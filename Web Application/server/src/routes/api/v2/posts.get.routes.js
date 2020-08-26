const { Router } = require("express");
const router = Router();

const Model = require("../../../models/Post.mongoose");

router.get("/id/:id", (req, res, next) => {
  const { id } = req.params;
  Model.findById(id).then((post) => {
    if (post) {
      res.json(post);
    } else {
      res.json({ message: "Post not found" });
    }
  });
});

router.get("/shortcode/:shortcode", (req, res, next) => {
  const { shortcode } = req.params;
  Model.findOne({ shortcode }).then((post) => {
    if (post) {
      res.json(post);
    } else {
      res.json({ message: "Post not found" });
    }
  });
});

module.exports = router;
