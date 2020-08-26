const { Router } = require("express");
const router = Router();

const connection = require("../../../database/connection"); // Stable a DB Connection
const designers = connection.get("designers"); // Get Designers Table

// Get user by username
router.get("/:username", (req, res, next) => {
  // Get username from params
  const username = req.params.username;

  // Find designer from username
  designers
    .findOne({ username })
    .then((user) => {
      // If designer exists send it to client
      if (user !== null) {
        res.json(user);
      }
      // Else send error
      else {
        res.status(404).json("User not found");
      }
    })
    .catch((e) => next(e)); // If error send it
});

module.exports = router;
