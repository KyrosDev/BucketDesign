const { Router } = require("express");
const router = Router();
const Joi = require("joi");

const connection = require("../database/connection");
const designers = connection.get("designers");

const schema = Joi.object().keys({
  username: Joi.string().min(4).max(25).alphanum(),
  profession: Joi.string(),
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
router.get("/designer/:token", (req, res) => {
  const token = req.params.token;

  designers.findOne({ token }).then((user) => {
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

router.post("/:email", (req, res) => {
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
