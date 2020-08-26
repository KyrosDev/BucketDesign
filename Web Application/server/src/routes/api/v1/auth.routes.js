const { Router } = require("express");
const jwt = require("jsonwebtoken");
const Joi = require("@hapi/joi");
const bcrypt = require("bcryptjs");
const router = Router();

const middlewares = require("../../middlewares"); // To create token and send errors

const connection = require("../../../database/connection"); // Stabilate a DB Connection
const designers = connection.get("designers"); // Get Designers Table

const schema = require("../../../models/Designer"); // Designer Schema

// SignUp - Register Route
router.post("/signup", (req, res, next) => {
  // Get email and password from body
  const body = req.body;

  // Check if model is valid
  const result = Joi.validate(body, schema);

  // If model is valid do:
  if (result.error === null) {
    // Check if designer with that email already exists
    designers
      .findOne({
        email: body.email,
      })
      .then((user) => {
        // If designer exists send error
        if (user) {
          res.status(409);
          const err = new Error("Email already used. 🆔");
          next(err);
        } else {
          // Take password and hash it with salt 12
          bcrypt.hash(body.password.trim(), 12).then((hash) => {
            // If there are no errors
            if (result !== "error") {
              // Create payload
              const payload = {
                email: body.email,
              };

              // Create Token
              jwt.sign(
                payload, // Return email
                process.env.SECRET_TOKEN, // Used to check if token is valid
                {
                  expiresIn: "7d", // Expires data
                },
                (err, token) => {
                  // If error send it to client
                  if (err) {
                    res.json(err);
                  } else {
                    // Create designer and initialize edges
                    designers
                      .insert({
                        email: body.email,
                        password: hash,
                        token: token,
                        edge_posts: {
                          counter: 0,
                          posts: [],
                        },
                        edge_followers: {
                          counter: 0,
                          followers: [],
                        },
                        edge_follows: {
                          counter: 0,
                          follows: [],
                        },
                      })
                      .then((insertedUser) => {
                        res.json(insertedUser); // If designer inserted into db send it's data
                      })
                      .catch((e) => next(e)); // Else send error
                  }
                }
              );
            } else {
              res.json(result); // If there is a token error send error
            }
          });
        }
      })
      .catch((e) => next(e)); // If error send it to client

  } else {
    res.status(422);
    next(result.error); // If there is a validation error send error
  }
});

// SIGNIN - Login Route
router.post("/signin", (req, res, next) => {
  // Get email and password from request body
  const { email, password } = req.body;

  // Create the model
  const model = {
    email,
    password,
  };

  // Verify if model is valid
  const result = Joi.validate(model, schema);

  // If model is valid
  if (result.error === null) {

    // Find user by email
    designers.findOne({ email: model.email }).then((user) => {

      // If user exists
      if (user) {

        // Compare hashed password with inserted password
        bcrypt
          .compare(model.password, user.password)
          .then((isEqual) => {

            // If password matches
            if (isEqual) {
              // Create token and send it to client
              middlewares.createTokenSendResponse(user.email, res, next);
            }
            
            // If passwords don't matches
            else {
              // Send error
              middlewares.fttError(res, next);
            }
          })
          .catch((e) => {
            next(e); // If error send it
          });
      } else {
        middlewares.fttError(res, next); // If designer doesn't exists send error
      }
    });
  } else {
    middlewares.fttError(res, next); // If validation error send it
  }
});

module.exports = router;
