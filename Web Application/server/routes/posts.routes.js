const express = require("express");
const router = express.Router();
const Joi = require("joi");

const connection = require("../database/connection");
const posts = connection.get("posts");

const randStr = (len) => {
  const letters =
    "ABCDEFGHIJLMNOPQRSTUVWXYZabcdefghijlmnopqrstuvwxyz1234567890";
  let result = "";
  for (let i = 0; i < len; i++) {
    result += letters[Math.floor(Math.random() * letters.length)];
  }
  posts.find({ shortcode: result }).then((res) => {
    if (res !== null) {
      result[Math.floor(Math.random() * result.length)] =
        letters[Math.floor(Math.random() * letters.length)];
    }
  });
  return result;
};

const schema = Joi.object().keys({
  title: Joi.string().max(30).required(),
  description: Joi.string().max(1500).optional(),
  shortcode: Joi.string().alphanum().required(),
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

  createdAt: Joi.date().timestamp("javascript").required(),
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

router.post("/", (req, res, next) => {
  const shortcode = randStr(12);

  const date = Date.now();
  const body = req.body;
  body.shortcode = shortcode;
  body.createdAt = date;
  const newDescription = body.description.split(" ");

  const urlExpression = /[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)?/gi;
  const urlRegExp = new RegExp(urlExpression);

  const tagExpression = /\@[a-zA-Z0-9()]?/gi;
  const tagRegExp = new RegExp(tagExpression);

  const boldExpression = /\*\*([a-zA-Z0-9:%._\+~#=]*)\*\*/gi
  const boldRegExp = new RegExp(boldExpression);
  newDescription.map((w, i) => {
    if (w.match(urlRegExp)) {
      newDescription[i] = `<a href='${w}' class='link' target='_blank'>${w}</a>`;
    }
    if (w.match(tagRegExp)) {
      newDescription[i] = `<a href='http://localhost:8080/designer/${
        w.split("@")[1]
      }' class='tag'>${w}</a>`;
    }
    if (w.match(boldRegExp)) {
      console.log("here");
      newDescription[i] = `<b>${w.split("**")[1]}</b>`;
    }
  });
  body.description = newDescription.join(" ");
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
            likes.splice(index, index + 1);
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

router.get("/:shortcode", (req, res) => {
  const shortcode = req.params.shortcode;

  posts.findOne({ shortcode }).then((post) => {
    if (post !== null) {
      res.json(post);
    } else {
      res.json("Invalid Shortcoded");
    }
  });
});

module.exports = router;
