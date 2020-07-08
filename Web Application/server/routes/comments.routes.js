const express = require("express");
const { Router } = express;
const router = Router();

const Comment = require("../models/Comment");
const { json } = require("express");

// Get all Comments
router.get("/", async (req, res) => {
  const comments = await Comment.find();
  res.json(comments);
});

// Create a Comment
router.post("/", (req, res) => {
  const { text, author } = req.body;

  Comment.create({
    text,
    author,
  })
    .then((comment) => {
      res.json(comment);
    })
    .catch((e) => {
      res.json(e);
    });
});

// Get a Comment by ID
router.get("/:id", (req, res) => {
  const id = req.params.id;

  Comment.findById(id)
    .then((comment) => {
      if (comment === null) res.status(404).json("Comment not found. 🆔");
      else res.json(comment);
    })
    .catch((e) => {
      res.status(404).json("Comment not found. 🆔");
    });
});

// Find a Comment by ID and Update
router.put("/:id", (req, res) => {
  const id = req.params.id;
  const { text } = req.body;

  Comment.findById(id)
    .then((comment) => {
      comment
        .update({
          text,
        })
        .then(() => {
          res.json("Comments updated");
        });
    })
    .catch((e) => {
      res.status(404).json("Comment not found. 🆔");
    });
});

// Find a Comment by ID and delete
router.delete("/:id", (req, res) => {
  const id = req.params.id;

  Comment.findById(id)
    .then((comment) => {
      comment.deleteOne().then(() => {
        res.json("Comment deleted Successfully!!! ❤");
      });
    })
    .catch((e) => {
      res.status(404).json("Comment not found. 🆔");
    });
});

module.exports = router;
