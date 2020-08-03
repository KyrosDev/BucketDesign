const { Router } = require("express");
const router = Router();
const multer = require("multer");
const path = require("path");
const fs = require("fs");

const connection = require("../database/connection");
const designers = connection.get("designers");

const upload = multer({
  dest: "./public/",
});

router.post("/:email/picture", upload.single("file"), (req, res, next) => {
  const email = req.params.email;
  console.log(email);
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
  console.log(profession);

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
