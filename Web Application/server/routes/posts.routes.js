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

router.post("/like/:id", (req, res) => {
  const id = req.params.id;
  const body = req.body;
  posts
    .findOne({ _id: id })
    .then((post) => {
      if (post === null) {
        res.json("Post not found");
      } else {
        // Create the new post based on the old
        const newPost = post;

        // Get the users array and remove duplicates
        let likes = [...new Set(newPost.likes.likes)];

        // Add user who liked the post to the array
        likes.push(body.user);

        // Save the old values and save to the new post
        newPost._id = id;
        newPost.likes = {
          counter: likes.length,
          likes,
        };

        // Delete the old post
        posts.remove({ _id: id });

        // Create the new post with old id
        posts
          .insert(newPost)
          .then((pst) => {
            res.json(pst);
          })
          .catch((e) => {
            res.json(e);
          });
      }
    })
    .catch((e) => {
      res.json(e);
    });
});

router.post("/unlike/:id", (req, res) => {
  const id = req.params.id;
  const body = req.body;
  posts
    .findOne({ _id: id })
    .then((post) => {
      if (post === null) {
        res.json("Post not found");
      } else {
        // Create the new post based on the old
        const newPost = post;

        // Get the users array and remove duplicates
        let likes = [...newPost.likes.likes];

        // Find the user and remove it from array
        likes.forEach((user) => {
          if (user.userID == body.user.userID) {
            // Get the index of element where user.userID === body.user.userID
            const index = likes.indexOf(user);

            // Remove the item at index INDEX
            likes.splice(index, index+1);
          }
        });

        // Save the old id and save to the new post
        newPost._id = id;

        // Update likes value
        newPost.likes = {
          counter: likes.length, // Increment counter by length of the array below
          likes, // Get all users who liked the post
        };

        // Delete the old post
        posts.remove({ _id: id });

        // Create the new post with old id
        posts
          .insert(newPost) // Create the post
          .then((pst) => {
            res.json(pst); // Respond with the post
          })
          .catch((e) => {
            res.json(e); // Respond with the error 
          });
      }
    })
    .catch((e) => {
      res.json(e);
    });
});

module.exports = router;
