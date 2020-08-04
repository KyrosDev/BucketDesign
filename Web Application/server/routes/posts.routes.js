const express = require("express");
const router = express.Router();
const Joi = require("@hapi/joi");

const connection = require("../database/connection"); // Stable a DB Connection
const posts = connection.get("posts"); // Get Posts Table
const designers = connection.get("designers"); // Get Designers Table

const schema = require("../models/Post"); // Import Schema

// Create a random shortcode for every post with len (LEN).
const randStr = (len) => {
  // List of allowed characters
  const letters =
    "ABCDEFGHIJLMNOPQRSTUVWXYZabcdefghijlmnopqrstuvwxyz1234567890";

  // Final Shortcode
  let result = "";
  for (let i = 0; i < len; i++) {
    // Insert random char into result
    result += letters[Math.floor(Math.random() * letters.length)];
  }

  // Check if shortcode already exists
  posts.find({ shortcode: result }).then((res) => {
    // If shortcode exists
    if (res !== null) {
      result[Math.floor(Math.random() * result.length)] =
        letters[Math.floor(Math.random() * letters.length)]; // Create new one
    }
  });
  return result; // Return the shortcodes
};

// Get all posts
router.get("/", (req, res) => {
  posts
    .find({})
    .then((result) => {
      res.json(result); // Send all posts to the client
    })
    .catch((e) => {
      res.json(e); // If error send it
    });
});

// Create a post
router.post("/", (req, res, next) => {
  // Create a shortcode with length 12
  const shortcode = randStr(12);

  // Initialize data
  const date = Date.now();

  // Get post body from the request body
  const body = req.body;

  // Insert createdAt and shortcode to the body of the post
  body.shortcode = shortcode;
  body.createdAt = date;

  // Convert description into list to get all words and format it
  const newDescription = body.description.split(" ");

  // String was an URL who match with that RegExp
  const urlExpression = /[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)?/gi;
  const urlRegExp = new RegExp(urlExpression); // Create RegExp

  // String was an TAG who match with that RegExp
  const tagExpression = /\@[a-zA-Z0-9()]?/gi;
  const tagRegExp = new RegExp(tagExpression); // Create RegExp

  // String was an BOLD TEXT who match with that RegExp
  const boldExpression = /\*\*([a-zA-Z0-9:%._\+~#=]*)\*\*/gi;
  const boldRegExp = new RegExp(boldExpression); // Create RegExp

  // For every word into list get index and word
  newDescription.map((w, i) => {
    // If word match with an URL String
    if (w.match(urlRegExp)) {
      // Convert the word at current index to an HTMLElement how contain an "a href" with a target "_blank"
      newDescription[
        i
      ] = `<a href='${w}' class='link' target='_blank'>${w}</a>`;
    }

    // If word match with an TAG String
    if (w.match(tagRegExp)) {
      // Convert the word at current index to an HTMLElement who contain an "a href" with path: /designer/:username
      newDescription[i] = `<a href='http://localhost:8080/designer/${
        w.split("@")[1]
      }' class='tag'>${w}</a>`;
    }

    // If word match with an BOLD String
    if (w.match(boldRegExp)) {
      // Convert the word at current index to an B element
      newDescription[i] = `<b>${w.split("**")[1]}</b>`;
    }
  });

  // Join all words with a space to create a simple string.
  body.description = newDescription.join(" ");

  // Validate the data
  const result = Joi.validate(body, schema);

  // If there are no validation error
  if (result.error === null) {
    // Create the post and insert it into DB
    posts
      .insert(result.value)
      .then((post) => {
        // When post created get it and insert it into Designer Author Model
        designers.findOne({ _id: post.author.id }).then((designer) => {
          // If author Exists
          if (designer !== null) {
            // Create the new Designer
            const newDesigner = designer;

            // Insert the post id into posts edge
            newDesigner.edge_posts.posts.push({ id: post._id });

            // Update the posts counter
            newDesigner.edge_posts.counter =
              newDesigner.edge_posts.posts.length;

            // Update the Designer
            designers.update(
              { username: newDesigner.username },
              { $set: newDesigner }
            );

            res.json(post); // Send current post
          } else {
            res.status(404).json("Designer not found"); // If author doesn't exists send 404 error
          }
        });
      })
      .catch((e) => {
        res.json(e); // If error send it
      });
  } else {
    res.json(result.error); // If validation error send it
  }
});

// Make action on the post with ID
router.post("/actions/:id", (req, res, next) => {
  // Get post id from params
  const id = req.params.id;

  // Get the designer ID and the Method of the action form request body
  const body = req.body;

  // If methods is LIKE
  if (body.method == "like") {
    // Find the post by it's ID
    posts
      .findOne({ _id: id })
      .then((post) => {
        // If post doesn't exists
        if (post === null) {
          res.status(404).json("Post not found"); // Send 404 error
        }

        // If post exists
        else {
          // Create the new post based on the old
          const newPost = post;

          // Get the users array and remove duplicates
          let likes = [...new Set(newPost.likes.likes)];

          // Add user who liked the post to the array
          likes.push(body);

          // Save the old values and save to the new post
          newPost._id = id;
          newPost.likes = {
            counter: likes.length,
            likes,
          };

          // Update the current post with new Data
          posts.update({ _id: id }, { $set: newPost }).catch((e) => next(e));
        }
      })
      .catch((e) => {
        next(e); // If error send it
      });
  }

  // If method is UNLIKE
  else if (body.method == "unlike") {
    // Find the post by it's ID
    posts
      .findOne({ _id: id })
      .then((post) => {
        // If post doesn't exists
        if (post === null) {
          res.status(404).json("Post not found"); // Send 404 error
        }

        // If post exists
        else {
          // Create the new post based on the old
          const newPost = post;

          // Get the users array and remove duplicates
          let likes = [...newPost.likes.likes];

          // Find the user and remove it from array
          likes.forEach((user) => {
            if (user.id == body.user.id) {
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

          // Update the current post with the new Data
          posts.update({ _id: id }, { $set: newPost }).catch((e) => next(e));
        }
      })
      .catch((e) => {
        res.json(e);
      });
  }
});

// Get the post with SHORTCODE
router.get("/:shortcode", (req, res) => {
  // Get the shortcode from the request body
  const shortcode = req.params.shortcode;

  // Find the post by it's shortcode
  posts.findOne({ shortcode }).then((post) => {
    // If post exists
    if (post !== null) {
      res.json(post); // Send it
    }

    // If post doesn't exists
    else {
      res.status(404).json("Invalid Shortcoded"); // Send 404 error
    }
  });
});

module.exports = router;
