const { Router } = require("express");
const router = Router();
const Joi = require("joi");

const connection = require("../database/connection");
const designers = connection.get("designers");

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
});

designers.createIndex("username", { unique: true });

// Create Designer
router.post("/", (req, res) => {
  const body = req.body;
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

// Get Designer by Username
router.get("/:username", (req, res) => {
  const username = req.params.username;
  designers
    .findOne({ username })
    .then((designer) => {
      if (designer == null) {
        res.json({ message: `Designer '${username}' not found! 🆔` });
      } else {
        res.json(designer);
      }
    })
    .catch((e) => {
      res.json({ message: e });
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
