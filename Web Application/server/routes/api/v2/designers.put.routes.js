const { Router } = require("express");
const router = Router();

const Model = require("../../../models/Deisgner.mongoose");

router.put("/id/:id", (req, res, next) => {
  const { id } = req.params;
  Model.findOneAndUpdate({ _id: id }, { $set: req.body })
    .then((updated) => {
      res.json(updated);
    })
    .catch((e) => next(e));
});

router.put("/email/:email", (req, res, next) => {
  const { email } = req.params;
  Model.findOneAndUpdate({ email }, { $set: req.body })
    .then((updated) => {
      res.json(updated);
    })
    .catch((e) => next(e));
});

module.exports = router;
