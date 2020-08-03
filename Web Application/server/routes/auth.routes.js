const { Router } = require("express");
const router = Router();
const jwt = require("jsonwebtoken");
const Joi = require("@hapi/joi");
const bcrypt = require("bcryptjs");

const middlewares = require("./middlewares/index");

const connection = require("../database/connection");
const designers = connection.get("designers");

const schema = require("../models/Designer");

// SignUp - Register Route
router.post("/signup", (req, res, next) => {
  const body = req.body;
  const result = Joi.validate(body, schema);

  if (result.error === null) {
    designers
      .findOne({
        email: body.email,
      })
      .then((user) => {
        if (user) {
          res.status(409);
          const err = new Error("Email already used. 🆔");
          next(err);
        } else {
          bcrypt.hash(body.password.trim(), 12).then((hash) => {
            if (result !== "error") {
              const payload = {
                email: body.email,
              };
              jwt.sign(
                payload,
                process.env.SECRET_TOKEN,
                {
                  expiresIn: "7d",
                },
                (err, token) => {
                  if (err) {
                    res.json(err);
                  } else {
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
                        res.json(insertedUser);
                      })
                      .catch((e) => console.log(e.toString()));
                  }
                }
              );
            } else {
              res.json(result);
            }
          });
        }
      })
      .catch((e) => console.log(e.toString()));
  } else {
    res.status(422);
    next(result.error);
  }
});

// SIGNIN - Login Route
router.post("/signin", (req, res, next) => {
  const { email, password } = req.body;
  const model = {
    email,
    password,
  };
  const result = Joi.validate(model, schema);
  if (result.error === null) {
    designers.findOne({ email: model.email }).then((user) => {
      if (user) {
        bcrypt
          .compare(model.password, user.password)
          .then((isEqual) => {
            if (isEqual) {
              middlewares.createTokenSendResponse(user.email, res, next);
            } else {
              middlewares.fttError(res, next);
            }
          })
          .catch((e) => {
            next(e);
          });
      } else {
        middlewares.fttError(res, next);
      }
    });
  } else {
    middlewares.fttError(res, next);
  }
});

module.exports = router;
