const { Router } = require("express");
const router = Router();

const Model = require("../../../models/Designer.mongoose");

// Get designer by him id
router.get("/id/:id", (req, res, next) => {
  const { id } = req.params;
  Model.findOne({ _id: id })
    .then((designer) => {
      if (designer) {
        res.json(designer);
      } else {
        res.status(404).json({ message: "Designer not found." });
      }
    })
    .catch((e) => next(e));
});

// Get designer by him email
router.get("/email/:email", (req, res, next) => {
  const { email } = req.params;
  Model.findOne({ email })
    .then((designer) => {
      if (designer) {
        res.json(designer);
      } else {
        res.json({ message: "Designer not found." });
      }
    })
    .catch((e) => next(e));
});

// Get designer by him usernames
router.get("/usernames/:username", (req, res, next) => {
  const { username } = req.params;
  Model.find({ username: { $regex: username, $options: "i" } })
    .then((designers) => {
      if (designers) {
        res.json(designers);
      } else {
        res.status(404).json({ message: "Designer not found." });
      }
    })
    .catch((e) => next(e));
});

// Get designer by him username
router.get("/username/:username", (req, res, next) => {
  const { username } = req.params;
  Model.findOne({ username: { $regex: username, $options: "i" } })
    .then((designer) => {
      if (designer) {
        res.json(designer);
      } else {
        res.status(404).json({ message: "Designer not found." });
      }
    })
    .catch((e) => next(e));
});

module.exports = router;
