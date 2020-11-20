const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const DesignerSchema = new Schema(
  {
    email: { type: String, required: true },
    verified: {
      type: Boolean,
      default: false,
    },
    password: {
      type: String,
      minlength: 8,
      required: true,
    },
    token: String,
    username: {
      type: String,
      minlength: 4,
      maxlength: 25,
    },
    profession: {
      name: String,
      id: String,
    },
    profile_picture: {
      type: String,
      required: true,
    },
    biography: {
      type: String,
      maxlength: 250,
    },
    posts_counter: {
      type: Number,
      default: 0,
    },
    following_counter: {
      type: Number,
      default: 0,
    },
    followers_counter: {
      type: Number,
      default: 0,
    },
  },
  { timestamps: true }
);

const Designer = mongoose.model("Designer", DesignerSchema);

module.exports = Designer;
