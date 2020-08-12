const { Router } = require("express");
const router = Router();
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");

const Model = require("../../../models/Designer.mongoose");

const fttError = (res, next) => {
  res.status(422);
  const error = new Error("Email or Password is invalid. 😬");
  next(error);
};

router.post("/signup", (req, res, next) => {
  Model.findOne({ email: req.body.email })
    .then((designer) => {
      if (designer) {
        res.status(409);
        const err = new Error("Email already used. 🆔");
        next(err);
      } else {
        bcrypt
          .hash(req.body.password.trim(), 12)
          .then((hash) => {
            jwt.sign(
              { email: req.body.email }, // Return email
              process.env.SECRET_TOKEN, // Used to check if token is valid
              {
                expiresIn: "7d", // Expires data
              },
              (err, token) => {
                // If error send it to client
                if (err) {
                  res.json(err);
                } else {
                  const newDesigner = new Model(req.body);
                  newDesigner.validate((err) => {
                    if (err) {
                      next(err);
                    } else {
                      newDesigner.password = hash;
                      newDesigner.token = token;
                      newDesigner
                        .save()
                        .then((d) => res.json(d))
                        .catch((e) => next(e));
                    }
                  });
                }
              }
            );
          })
          .catch((e) => next(e));
      }
    })
    .catch((e) => next(e));
});

router.post("/signin", (req, res, next) => {
  Model.findOne({ email: req.body.email })
    .then((designer) => {
      if (designer) {
        bcrypt
          .compare(req.body.password, designer.password)
          .then((isEqual) => {
            if (isEqual) {
              jwt.sign(
                { email: req.body.email },
                process.env.SECRET_TOKEN,
                {
                  expiresIn: "1d",
                },
                (err, token) => {
                  if (err) {
                    fttError(res, next);
                  } else {
                    res.json({
                      designer,
                      token,
                      email: req.body.email,
                    });
                  }
                }
              );
            } else {
              fttError(res, next);
            }
          })
          .catch((e) => next(e));
      } else {
        fttError(req, next);
      }
    })
    .catch((e) => next(e));
});

module.exports = router;
