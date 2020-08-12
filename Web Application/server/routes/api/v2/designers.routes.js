const { Router } = require("express");
const router = Router();

const Model = require("../../../models/Designer.mongoose");

router.get("/", (req, res, next) => {
  Model.find()
    .then((designers) => {
      res.json(designers);
    })
    .catch((e) => next(e));
});

// Create a Designer
router.post("/", (req, res, next) => {
  const designer = new Model(req.body);
  designer.validate((err) => {
    if (err) res.json(err);
    else {
      Model.findOne({ email: req.body.email })
        .then((exists) => {
          if (exists) {
            res.json({
              message: "Designer with that email already exists. Try again.",
            });
          } else {
            designer.save().then((inserted) => {
              res.json(inserted);
            });
          }
        })
        .catch((e) => next(e));
    }
  });
});

router.delete("/id/:id", (req, res, next) => {
  const { id } = req.params;
  Model.findById(id)
    .then((designer) => {
      if (designer) {
        designer
          .remove()
          .then(res.json({ message: "Designer removed successfully" }))
          .catch((e) => next(e));
      } else {
        res.status(404).json({ message: "Designer not found" });
      }
    })
    .catch((e) => next(e));
});

// Edit profile by ID or EMAIL
router.use("/put", require("./designers.put.routes"));

// Get Designer by Username, ID, Email
router.use("/get", require("./designers.get.routes"));

module.exports = router;
