const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ChatroomSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
    },
    users: {
      type: Array,
      required: true,
    },
    type: {
      type: String,
      enum: ["personal_chat", "group_chat"],
      default: "personal_chat",
    },
    messages: {
      type: Array,
      default: [],
    },
  },
  {
    timestamps: true,
  }
);

const Chatroom = mongoose.model("Chatroom", ChatroomSchema);

module.exports = Chatroom;
