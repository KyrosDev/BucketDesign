const { Router } = require("express");
const router = Router();
const multer = require("multer");
const path = require("path");
const fs = require("fs");

const upload = multer({
  dest: "./public/",
});

const Model = require("../../../models/Designer.mongoose");

router.put("/id/:id", (req, res, next) => {
  const { id } = req.params;
  Model.findOneAndUpdate({ _id: id }, { $set: req.body })
    .then((updated) => {
      res.json(updated);
    })
    .catch((e) => next(e));
});

router.put("/email/:email", upload.single("file"), (req, res, next) => {
  const { email } = req.params;
  if (req.file) {
    const tempPath = req.file.path;
    const fileName = req.file.originalname;
    Model.findOne({ email })
      .then((designer) => {
        if (designer) {
          const pathName = `./public/${designer._id}`;
          const isPathExists = fs.existsSync(pathName);
          if (!isPathExists) fs.mkdirSync(pathName);
          const targetPath = `${pathName}/profilePicture.${path.extname(
            fileName
          )}`;
          fs.rename(tempPath, targetPath, (err) => {
            if (err) next(err, res);
            const finalPath = `https://bucketdesign-server.herokuapp.com/${targetPath
              .split("/")
              .slice(2)
              .join("/")}`;
            const newDesigner = designer;
            newDesigner.profile_picture = finalPath;
            Model.findOneAndUpdate(
              { _id: designer._id },
              {
                $set: newDesigner,
              },
              (err, _) => {
                if (err) next(e);
              }
            ).then((doc) => res.json(doc));
          });
        }
      })
      .catch((e) => next(e));
  } else {
    Model.findOneAndUpdate(
      { email },
      {
        $set: req.body,
      },
      (err, updated) => {
        if (err) next(err);
        else res.json(updated);
      }
    );
  }
});

module.exports = router;
