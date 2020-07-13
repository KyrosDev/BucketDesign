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

router.get("/", (req, res) => {
  res.json({ message: "🔐" });
});

const fttError = (res, next) => {
  res.status(422);
  const error = new Error("Email or Password is invalid.");
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
          const error = new Error("Email already used.");
          res.status(409);
          next(error);
        } else {
          bcrypt.hash(body.password.trim(), 12).then((hash) => {
            auth
              .insert({ email: body.email, password: hash })
              .then(() => {
                res.json({ message: "User created!!! ✨" });
              })
              .catch((e) => console.log(e.toString()));
          });
        }
      })
      .catch((e) => console.log(e.toString()));
  } else {
    res.status(422);
    next(result.error);
  }
});

router.post("/signin", (req, res, next) => {
  const body = req.body;
  const result = Joi.validate(body, schema);
  if (result.error === null) {
    auth.findOne({ email: body.email }).then((user) => {
      if (user) {
        bcrypt.compare(body.password, user.password).then((isEqual) => {
          if (isEqual) {
            const payload = {
              id: user._id,
              email: user.email,
            };
            jwt.sign(
              payload,
              process.env.SECRET_TOKEN,
              { expiresIn: "7d" },
              (err, token) => {
                if (err) {
                  fttError(res, next);
                } else {
                  res.json(token);
                }
              }
            );
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
