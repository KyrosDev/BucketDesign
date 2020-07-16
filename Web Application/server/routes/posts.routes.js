const express = require("express");
const router = express.Router();
const Joi = require("joi");
const connection = require("../database/connection");

const posts = connection.get("posts");

const schema = Joi.object().keys({
  title: Joi.string().max(30).required(),
  description: Joi.string().max(500).optional(),
  author: Joi.string().alphanum().required(),
  previewURL: Joi.string().required(),
  likes: Joi.object({
    counter: Joi.number().required().default(0),
    likes: Joi.array()
      .items(
        Joi.object({
          userID: Joi.string().required(),
        })
      )
      .required(),
  })
    .optional()
    .default({
      counter: 0,
      likes: [],
    }),
  comments: Joi.object({
    counter: Joi.number().required().default(0),
    comments: Joi.array()
      .items(
        Joi.object({
          userID: Joi.string().required(),
        })
      )
      .required(),
  })
    .optional()
    .default({
      counter: 0,
      comments: [],
    }),
  attachments: Joi.array()
    .items({
      imageURL: Joi.string().required(),
    })
    .optional(),
});

router.get("/", (req, res) => {
  posts
    .find({})
    .then((result) => {
      res.json(result);
    })
    .catch((e) => {
      res.json(e);
    });
});

router.post("/", (req, res) => {
  const body = req.body;
  const result = Joi.validate(body, schema);
  if (result.error === null) {
    posts
      .insert(result.value)
      .then((post) => {
        res.json(post);
      })
      .catch((e) => {
        res.json(e);
      });
  } else {
    res.json(result.error);
  }
});
module.exports = router;
