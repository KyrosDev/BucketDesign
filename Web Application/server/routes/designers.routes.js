const { Router } = require("express");
const router = Router();
const Joi = require("joi");

const connection = require("../database/connection");
const designers = connection.get("designers");
const auth = connection.get("auth");

const schema = Joi.object().keys({
  username: Joi.string().min(4).max(25).alphanum().required(),
  profession: Joi.string().required(),
  edge_posts: Joi.array()
    .items({
      postID: Joi.string().required(),
    })
    .optional()
    .default([]),
  edge_followers: Joi.array()
    .items({
      followerID: Joi.string().required(),
    })
    .optional()
    .default([]),
  edge_followos: Joi.array()
    .items({
      followID: Joi.string().required(),
    })
    .optional()
    .default([]),
  profile_picture: Joi.string().alphanum().required(),
  location: Joi.string().required(),
  biography: Joi.string().max(150).required(),
  email: Joi.string().email(),
});

designers.createIndex("email", { unique: true });

// Create Designer
router.post("/:email", (req, res) => {
  const email = req.params.email;
  const body = req.body;
  body.email = email;
  const result = Joi.validate(body, schema);
  if (result.error === null) {
    designers
      .findOne({ username: body.username })
      .then((designer) => {
        if (designer == null) {
          designers.insert(body).then(() => {
            res.json({ message: "Designer Created!!! 😍" });
          });
        } else {
          res.json({ designer });
        }
      })
      .catch((e) => {
        res.json({ e });
      });
  } else {
    res.json(result);
  }
});

// Get all Designers
router.get("/", (req, res) => {
  designers
    .find({})
    .then((result) => {
      res.json(result);
    })
    .catch((e) => {
      res.json({ e });
    });
});

// Get Designer by Token
router.get("/:token", (req, res) => {
  const token = req.params.token;
  
  auth.findOne({ token: token }).then((user) => {
    if (user === null) {
      res.json({ message: `Designer '${username}' not found! 🆔` });
    } else {
      const email = user.email;
      designers
        .findOne({ email })
        .then((designer) => {
          res.json(designer);
        })
        .catch((e) => {
          res.json({ message: e });
        });
    }
  });
});

// Delete user by ID
router.delete("/:id", (req, res) => {
  const id = req.body.id;
  console.log(id);
  designers
    .findOneAndDelete({ id })
    .then((designer) => {
      console.log(designer);
      if (designer !== null) {
        res.json({ message: "Designer deleted!!! 😥" });
      } else {
        res.json({ message: `Designer with id '${id}' not found. 🆔` });
      }
    })
    .catch((e) => {
      res.json({ message: e });
    });
});

module.exports = router;
