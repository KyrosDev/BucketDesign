const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const DesignerSchema = new Schema(
  {
    email: { type: String, required: true },
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
    },
    biography: {
      type: String,
      maxlength: 250,
    },
    edge_posts: {
      counter: { type: Number, default: 0 },
      posts: {
        type: Array,
      },
    },
    edge_follows: {
      counter: { type: Number, default: 0 },
      follows: {
        type: Array,
      },
    },
    edge_followers: {
      counter: { type: Number, default: 0 },
      followers: {
        type: Array,
      },
    },
  },
  { timestamps: true }
);

const Designer = mongoose.model("Designer", DesignerSchema);

module.exports = Designer;
