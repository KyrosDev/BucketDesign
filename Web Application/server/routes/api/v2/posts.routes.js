const { Router } = require("express");
const router = Router();

const Model = require("../../../models/Post.mongoose");
const app = require("../../../app");

router.get("/", (req, res, next) => {
  Model.find()
    .then((posts) => {
      res.json(posts);
    })
    .catch((e) => next(e));
});

router.post("/", (req, res, next) => {
  const post = new Model(req.body);
  post.validate((e) => {
    if (e) {
      res.json(e);
    } else {
      post
        .save()
        .then((inserted) => {
          res.json(inserted);
        })
        .catch((e) => next(e));
    }
  });
});

router.delete("/id/:id", (req, res, next) => {
  const { id } = req.params;
  Model.findById(id)
    .then((post) => {
      if (post) {
        post
          .remove()
          .then(() => {
            res.json({ message: "Post deleted successfully" });
          })
          .catch((e) => next(e));
      } else {
        res.json({ message: "Post not found" });
      }
    })
    .catch((e) => next(e));
});

router.put("/id/:id", (req, res, next) => {
  const { id } = req.params;
  Model.findOneAndUpdate({ _id: id }, { $set: req.body })
    .then((updated) => {
      if (updated) res.json(updated);
      else res.json({ message: "Post not found" });
    })
    .catch((e) => next(e));
});

router.use("/get", require('./posts.get.routes'));

module.exports = router;
