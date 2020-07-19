const express = require("express");
const router = express.Router();
const Joi = require("joi");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

// DB Auth Setup
const connection = require("../database/connection");
const auth = connection.get("auth");

const schema = Joi.object().keys({
  email: Joi.string().email().required(),
  password: Joi.string().min(8).required(),
});

auth.createIndex("email", { unique: true });

function createTokenSendResponse(email, res, next) {
  const payload = {
    email,
  };

  let tkn = "";

  jwt.sign(
    payload,
    process.env.SECRET_TOKEN,
    {
      expiresIn: "7d",
    },
    (err, token) => {
      if (err) {
        fttError(res, next);
      } else {
        res.json({ token });
      }
    }
  );
}

router.get("/", (req, res) => {
  res.json({ message: "🔐" });
});

const fttError = (res, next) => {
  res.status(422);
  const error = new Error("Email or Password is invalid. 😬");
  next(error);
};

// SignUp - Register Route
router.post("/signup", (req, res, next) => {
  const body = req.body;
  const result = Joi.validate(body, schema);

  if (result.error === null) {
    auth
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
                    auth
                      .insert({
                        email: body.email,
                        password: hash,
                        token: token,
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

// Get user and check for token
router.get("/token/:token", (req, res) => {
  const token = req.params.token;

  auth.findOne({ token }).then((user) => {
    if (user !== null) {
      const result = jwt.verify(token, process.env.SECRET_TOKEN);
      res.json({ user: { email: result.email } });
    } else {
      res.json("User not found");
    }
  });
});

// SIGNIN - Login Route
router.post("/signin", (req, res, next) => {
  const body = req.body;
  const result = Joi.validate(body, schema);
  if (result.error === null) {
    auth.findOne({ email: body.email }).then((user) => {
      if (user) {
        bcrypt.compare(body.password, user.password).then((isEqual) => {
          if (isEqual) {
            createTokenSendResponse(user.email, res, next);
          } else {
            fttError(res, next);
          }
        });
      } else {
        fttError(res, next);
      }
    });
  } else {
    fttError(res, next);
  }
});

module.exports = router;
