const { Router } = require("express");
const router = Router();

const Chatroom = require("../../../models/Chatroom.mongoose");

router.get("/", (req, res, next) => {
  Chatroom.find()
    .then((chatrooms) => res.json(chatrooms))
    .catch((e) => next(e));
});

router.post("/", (req, res, next) => {
  const body = req.body;
  const chatroom = new Chatroom(body);
  chatroom.users.push(body.name);
  chatroom
    .save()
    .then((saved) => res.json(saved))
    .catch((e) => next(e));
});

module.exports = router;
