const { Router } = require("express");
const router = Router();

const Message = require("../../../models/Message.mongoose");
const Chatroom = require("../../../models/Chatroom.mongoose");
const { messages } = require("../../../models/Post");

router.get("/", (req, res, next) => {
  Message.find()
    .then((messages) => {
      res.json(messages);
    })
    .catch((e) => next(e));
});

router.post("/", (req, res, next) => {
  const body = req.body;
  const message = new Message(body);

  message.validate((err) => {
    if (err) next(err);
    message
      .save()
      .then((saved) => {
        Chatroom.findById(saved.to_room)
          .then((room) => {
            const messages = room.messages;
            messages.push(saved);
            room.set("messages", messages).save();
          })
          .catch((e) => next(e));
        res.json(saved);
      })
      .catch((e) => next(e));
  });
});

module.exports = router;
