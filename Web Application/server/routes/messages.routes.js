const { Router } = require("express");
const router = Router();

// Model
const Message = require("../models/Message");

// Get all Messages
router.get("/", async (req, res) => {
  const messages = await Message.find();
  res.json(messages);
});

// Create a Message
router.post("/", (req, res) => {
  const { text, from_id, to_id } = req.body;

  Message.create({
    text,
    from_id,
    to_id,
  })
    .then((message) => {
      res.json(message);
    })
    .catch((e) => {
      res.json(e);
    });
});

// Get a Message by ID
router.get("/:id", (req, res) => {
  const id = req.params.id;

  Message.findById(id)
    .then((message) => {
      if (post === null) res.status(404).json("Message not found. 🆔");
      else res.json(message);
    })
    .catch((e) => {
      res.status(404).json("Message not found. 🆔");
    });
});

// Get a Message by ID and Update
router.put("/:id", (req, res) => {
  const id = req.params.id;
  const { text } = req.body;

  Message.findById(id)
    .then((message) => {
      message
        .update({
          text,
        })
        .then(() => {
          res.json("Message Updated");
        });
    })
    .catch((e) => {
      res.status(404).json("Message not found. 🆔");
    });
});

// Get a Message by ID and Delete
router.delete("/:id", (req, res) => {
  const id = req.params.id;

  Message.findById(id)
    .then((message) => {
      message.deleteOne().then(() => {
        res.json("Message deleted");
      });
    })
    .catch((e) => {
      res.status(404).json("Message not found. 🆔");
    });
});

module.exports = router;
