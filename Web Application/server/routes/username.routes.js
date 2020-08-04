const { Router } = require("express");
const router = Router();

const connection = require("../database/connection");
const designers = connection.get("designers");

// Get user by username
router.get("/:username", (req, res, next) => {
  const username = req.params.username;
  designers
    .findOne({ username })
    .then((user) => {
      if (user !== null) {
        res.json(user);
      } else {
        res.json("User not found");
      }
    })
    .catch((e) => next(e));
});

module.exports = router;
