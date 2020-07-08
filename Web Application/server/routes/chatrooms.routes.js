const { Router } = require("express");
const router = Router();

// Model
const Chatroom = require("../models/Chatroom");
const { route } = require("./users.routes");

// Get all Chatrooms
router.get("/", async (req, res) => {
  const chatrooms = await Chatroom.find();
  res.json(chatrooms);
});

// Create a Chatroom
router.post("/", (req, res) => {
  const { users, chat } = req.body;

  Chatroom.create({
    users,
    chat,
  })
    .then((chatroom) => {
      res.json(chatroom);
    })
    .catch((e) => {
      res.json(e);
    });
});

// Get a Chatroom by ID
router.get("/:id", (req, res) => {
  const id = req.params.id;

  Chatroom.findById(id)
    .then((chatroom) => {
      if (chatroom === null) res.status(404).json("Chatroom not found. 🆔");
      else res.json(chatroom);
    })
    .catch((e) => {
      res.status(404).json("Chatroom not found. 🆔");
    });
});

// Get a Chatroom by ID and Update
router.put("/:id", (req, res) => {
  const id = req.params.id;
  const { chat } = req.body;

  Chatroom.findById(id)
    .then((chatroom) => {
      chatroom
        .update({
          chat,
        })
        .then(() => {
          res.json("Updated");
        });
    })
    .catch((e) => {
      res.status(404).json("Chatroom not found. 🆔");
    });
});

// Get a Chatroom by ID and Delete
router.delete("/:id", (req, res) => {
  const id = req.params.id;

  Chatroom.findById(id)
    .then((chatroom) => {
      if (chatroom === null) res.status(404).json("Chatroom not found. 🆔");
      else
        chatroom.delete().then(() => {
          res.json("Chatroom deleted");
        });
    })
    .catch((e) => {
      res.json("Chatroom not found. 🆔");
    });
});

module.exports = router;
