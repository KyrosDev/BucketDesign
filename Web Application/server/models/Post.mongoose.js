const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const PostSchema = new Schema(
  {
    title: { type: String, required: true },
    description: { type: String },
    author: {
      type: String,
      required: true,
    },
    shortcode: {
      type: String,
      required: true,
      minlength: 8,
    },
    previewURL: {
      type: String,
      required: true,
    },
    attachments: {
      counter: {
        type: Number,
        default: 0,
      },
      media: {
        type: Array,
      },
    },
    edge_comments: {
      counter: { type: Number, default: 0 },
      comments: {
        type: Array,
      },
    },
    edge_likes: {
      counter: { type: Number, default: 0 },
      likes: {
        type: Array,
      },
    },
  },
  { timestamps: true }
);

const Post = mongoose.model("Post", PostSchema);

module.exports = Post;
