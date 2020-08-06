const { Router } = require("express");
const router = Router();
const multer = require("multer");
const path = require("path");
const fs = require("fs");

const connection = require("../../../database/connection");
const designers = connection.get("designers");

const upload = multer({
  dest: "./public/",
});

router.post("/follow", (req, res, next) => {
  const { from, to, method } = req.body;

  // Find the user (fromUser) how follow the new user (toUser)
  designers
    .findOne({ _id: from })
    .then((fromUser) => {
      if (fromUser !== null) {
        // Find the new user (toUser) how followed the user (fromUser)
        designers
          .findOne({ username: to })
          .then((toUser) => {
            if (toUser !== null) {
              if (method === "follow") {
                // Create the fromUser with the new follows map
                let newFrom = fromUser;
                const followsSet = [...new Set(newFrom.edge_follows.follows)];
                followsSet.push({ id: toUser._id });
                newFrom.edge_follows.follows = followsSet;
                newFrom.edge_follows.counter = followsSet.length;

                // Create the toUser with the new followers map
                let newTo = toUser;
                const followersSet = [
                  ...new Set(newTo.edge_followers.followers),
                ];
                followersSet.push({ id: fromUser._id });
                newTo.edge_followers.followers = followersSet;
                newTo.edge_followers.counter = followersSet.length;

                designers.update({ _id: fromUser._id }, { $set: newFrom }); // Update fromUser
                designers.update({ _id: toUser._id }, { $set: newTo }); // Update toUser
                res.json(newFrom);
              } else if (method === "unfollow") {
                // Create the fromUser with the new follows map
                let newFrom = fromUser;
                const fromArr = newFrom.edge_follows.follows;
                const fromIndex = fromArr.indexOf(toUser._id);
                fromArr.splice(fromIndex, 1);
                newFrom.edge_follows.follows = fromArr;
                newFrom.edge_follows.counter = fromArr.length;

                // Create the toUser with the new followers map
                let newTo = toUser;
                const toArr = newTo.edge_followers.followers;
                const toIndex = toArr.indexOf(fromUser._id);
                toArr.splice(toIndex, 1);
                newTo.edge_followers.followers = toArr;
                newTo.edge_followers.counter = toArr.length;

                designers.update({ _id: fromUser._id }, { $set: newFrom }); // Update fromUser
                designers.update({ _id: toUser._id }, { $set: newTo }); // Update toUser
                res.json(newFrom);
              }
            }
          })
          .catch((e) => next(e));
      }
    })
    .catch((e) => next(e));
});

router.post("/:email/picture", upload.single("file"), (req, res, next) => {
  const email = req.params.email;
  const tempPath = req.file.path;
  designers.findOne({ email }).then((u) => {
    if (u) {
      if (!fs.existsSync(`./public/${u._id}`)) {
        fs.mkdirSync(`./public/${u._id}`);
      }
      const targetPath = `./public/${u._id}/profilePicture.${
        req.file.mimetype.split("/")[1]
      }`;
      if (
        path.extname(req.file.originalname).toLowerCase() ===
        (".png" || ".jpg" || ".jpeg")
      ) {
        fs.rename(tempPath, targetPath, (err) => {
          if (err) next(err, res);
          designers
            .findOne({ email })
            .then((user) => {
              if (user !== null) {
                const newUser = user;
                newUser.profile_picture = targetPath
                  .split("/")
                  .slice(2)
                  .join("/");
                designers
                  .update({ token: user.token }, { $set: newUser })
                  .then(() => {
                    res.json("success");
                  });
              } else {
                res.json("User not found");
              }
            })
            .catch((e) => next(e, res));
        });
      } else {
        fs.unlink(tempPath, (err) => {
          if (err) return next(err, res);
          res
            .status(403)
            .contentType("text/plain")
            .end(
              "Only '.png', '.jpg', 'jpeg', '.gif' and '.mp4' files allowed"
            );
        });
      }
    }
  });
});

// Set profession
router.post("/:email/profession", (req, res, next) => {
  const email = req.params.email;
  const { profession } = req.body;

  designers
    .findOne({ email: email })
    .then((u) => {
      if (u !== null) {
        const newUser = u;
        newUser.profession = profession;
        designers.update({ email: email }, { $set: newUser });
      } else {
        res.json("User not found");
      }
    })
    .catch((e) => next(e));
});

router.post("/:email/informations", (req, res, next) => {
  const email = req.params.email;
  const { username, biography } = req.body;

  designers.findOne({ email }).then((u) => {
    if (u !== null) {
      const newUser = u;
      newUser.username = username;
      newUser.biography = biography.trim();
      designers.update({ email }, { $set: newUser }).then(() => {
        res.json(u);
      });
    } else {
      res.json("User not found");
    }
  });
});

module.exports = router;
