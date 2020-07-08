const mongoose = require("mongoose");
const { Schema } = mongoose;

const postSchema = new Schema(
  {
    author: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
    },
    title: {
      type: String,
      required: true
    },
    description: {
      type: String,
    },
    shortcut: {
      type: String,
    },
    images: [
      {
        image_url: {
          type: String,
          required: true,
        },
      },
    ],
    tags: [
      {
        type: String,
      },
    ],
    edge_likes: [
      {
        usersId: mongoose.Schema.Types.ObjectId,
      },
    ],
    edge_comments: [
      {
        commentId: mongoose.Schema.Types.ObjectId,
      },
    ],
  },
  { timestamps: true }
);

const Post = mongoose.model("Post", postSchema);

module.exports = Post;
