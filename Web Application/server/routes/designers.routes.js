const { Router } = require("express");
const router = Router();
const Joi = require("joi");
const multer = require("multer");
const path = require("path");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const fs = require("fs");

const connection = require("../database/connection");
const designers = connection.get("designers");

const schema = Joi.object().keys({
  username: Joi.string().min(4).max(25).alphanum(),
  profession: Joi.object(),
  edge_posts: Joi.array()
    .items({
      postID: Joi.string(),
    })
    .optional()
    .default([]),
  edge_followers: Joi.array()
    .items({
      followerID: Joi.string(),
    })
    .optional()
    .default([]),
  edge_followos: Joi.array()
    .items({
      followID: Joi.string(),
    })
    .optional()
    .default([]),
  profile_picture: Joi.string().alphanum(),
  location: Joi.string(),
  biography: Joi.string().max(150),
  email: Joi.string().email().required(),
  password: Joi.string().min(8).required(),
  token: Joi.string().token(),
});
designers.createIndex("email", { unique: true });

// Create Token and send it to Front-end
function createTokenSendResponse(email, res, next) {
  // Create payload
  const payload = {
    email,
  };

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
        res.json({ token: token, email: email });
      }
    }
  );
}

router.get("/", (req, res) => {
  designers.find().then((users) => {
    res.json(users);
  });
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
                      })
                      .then((insertedUser) => {
                        delete insertedUser.password;
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

  designers.findOne({ token: token }).then((user) => {
    if (user !== null) {
      const result = jwt.verify(token, process.env.SECRET_TOKEN);
      if (result.error === null) {
        const newUser = delete user.password;
        res.json({ user: newUser });
      } else {
        res.json(result.error);
      }
    } else {
      res.json("User not found");
    }
  });
});

const upload = multer({
  dest: "./public/",
});

router.post(
  "/:user/profile/picture",
  upload.single("file"),
  (req, res, next) => {
    const user = req.params.user;
    const tempPath = req.file.path;
    designers.findOne({ email: user }).then((u) => {
      if (u !== null) {
        if (!fs.existsSync(`./public/${u._id}`)) {
          fs.mkdirSync(`./public/${u._id}`);
        }
        const targetPath = `./public/${u._id}/profilePicture.${
          req.file.mimetype.split("/")[1]
        }`;
        if (
          path.extname(req.file.originalname).toLowerCase() ===
          (".png" || ".jpg" || ".jpeg")
        ) {
          fs.rename(tempPath, targetPath, (err) => {
            if (err) next(err, res);
            designers
              .findOne({ email: user })
              .then((user) => {
                if (user !== null) {
                  const newUser = user;
                  newUser.profile_picture = targetPath
                    .split("/")
                    .slice(2)
                    .join("/");
                  designers.remove({ email: user.email });
                  designers
                    .insert(newUser)
                    .then((inserted) => {
                      console.log(inserted);
                      res.json("success");
                    })
                    .catch((e) => {
                      next(e, res);
                    });
                } else {
                  res.json("User not found");
                }
              })
              .catch((e) => next(e, res));
          });
        } else {
          fs.unlink(tempPath, (err) => {
            if (err) return next(err, res);
            res
              .status(403)
              .contentType("text/plain")
              .end(
                "Only '.png', '.jpg', 'jpeg', '.gif' and '.mp4' files allowed"
              );
          });
        }
      }
    });
  }
);

// Set profession
router.post("/:user/profile/profession", (req, res, next) => {
  const user = req.params.user;
  const { profession } = req.body;

  designers
    .findOne({ email: user })
    .then((u) => {
      if (u !== null) {
        const newUser = u;
        newUser.profession = profession;
        designers.remove({ email: user });
        designers
          .insert(newUser)
          .then((inserted) => {
            console.log(inserted);
            res.json("success");
          })
          .catch((e) => next(e));
      } else {
        res.json("User not found");
      }
    })
    .catch((e) => next(e));
});

// SIGNIN - Login Route
router.post("/signin", (req, res, next) => {
  const body = req.body;
  const result = Joi.validate(body, schema);
  if (result.error === null) {
    designers.findOne({ email: body.email }).then((user) => {
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

router.get("/", (req, res) => {
  designers.find({}).then((designer) => {
    res.json(designer);
  });
});

router.post("/email/:email", (req, res) => {
  const email = req.params.email;
  const body = req.body;
  designers.findOne({ email }).then((user) => {
    if (user === null) {
      res.json("User not found");
    } else {
      const newUser = { ...user, body };
      designers
        .insert(newUser)
        .then((result) => {
          res.json(result);
        })
        .catch((e) => {
          res.json(e);
        });
    }
  });
});

module.exports = router;
