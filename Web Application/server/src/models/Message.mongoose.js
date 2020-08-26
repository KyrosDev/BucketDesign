const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const MessageSchema = new Schema(
  {
    type: {
      type: String,
      enum: ["message", "audio"],
      default: "message",
    },
    from: {
      type: String,
      required: true,
    },
    from_id: {
      type: Schema.Types.ObjectId,
      required: true,
    },
    text: {
      type: String,
      required: true,
    },
    mime_type: {
      type: String,
      enum: ["video/mp4", "audio/mp3", "image/gif", "image/png", "video/jpg"],
    },
    to_room: Schema.Types.ObjectId,
    duration_seconds: Number,
    photo: String,
    width: Number,
    height: Number,
  },
  { timestamps: true }
);

const Message = mongoose.model("Message", MessageSchema);

module.exports = Message;
