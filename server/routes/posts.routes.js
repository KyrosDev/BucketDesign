const { Router } = require("express");
const { nanoid } = require("nanoid");
const router = Router();

// Model
const Post = require("../models/Post");

// Get all Posts
router.get("/", async (req, res) => {
  const posts = await Post.find();
  res.json(posts);
});

// Create a new Post
router.post("/", (req, res) => {
  const {
    author,
    images,
    tags,
    edge_likes,
    edge_comments,
    title,
    description,
  } = req.body;

  const post = new Post({
    author,
    shortcut: nanoid(8),
    images,
    tags,
    edge_likes,
    edge_comments,
    title,
    description,
  });

  post
    .save()
    .then(res.json(post))
    .catch((e) => res.json(e));
});

// Get Post by id and Update
router.put("/:id", (req, res) => {
  const id = req.params.id;
  const { author, images, tags, title, description } = req.body;
  console.log(req.body);

  Post.findById(id).then((post) => {
    post
      .updateOne({
        images,
        tags,
        title,
        description,
      })
      .then(() => {
        res.json(post);
      })
      .catch((e) => {
        res.json(e);
      });
  });
});

// Get a Post by id
router.get("/:id", (req, res) => {
  const id = req.params.id;
  Post.findById(id)
    .then((post) => {
      if (post === null) res.status(404).json("Post not found. 🆔");
      else res.json(post);
    })
    .catch(() => {
      res.status(404).json("Post not found. 🆔");
    });
});

// Delete a Post by id
router.delete("/:id", (req, res) => {
  const id = req.params.id;

  Post.findById(id)
    .then((post) => {
      post.deleteOne().then(() => {
        res.json("Post deleted Successfully!!! ❤");
      });
    })
    .catch(() => {
      res.status(404).json("Post not found. 🆔");
    });
});

module.exports = router;
