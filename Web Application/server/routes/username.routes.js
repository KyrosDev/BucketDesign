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

router.get("/:username/followers", (req, res, next) => {
  const username = req.params.username;
  let followers = new Array();
  designers
    .findOne({ username })
    .then((user) => {
      if (user !== null) {
        user.edge_followers.followers.forEach((follower) => {
          designers
            .findOne({ _id: follower.id })
            .then((f) => {
              if (f !== null) {
                followers.push({
                  id: f._id,
                  username: f.username,
                  profile_picture: `http://localhost:5000/public/${f.profile_picture}`,
                  profession: f.profession,
                });
              }
            })
            .then(() => {
              res.json(followers);
            });
        });
      } else {
        res.json("User not found");
      }
    })
    .catch((e) => next(e));
});

module.exports = router;
