const mongoose = require("mongoose");
const { Schema } = mongoose;

const designer = new Schema(
  {
    username: {
      type: String,
      required: true,
      minlength: 4,
      maxLength: 12,
    },
    image: String,
    biography: {
      type: String,
      minLength: 12,
      maxLength: 80,
    },
    profession: String,
    edge_follows: [
      {
        designerId: mongoose.Schema.Types.ObjectId,
      },
    ],
    edge_posts: [
      {
        postId: mongoose.Schema.Types.ObjectId,
      },
    ],
    location: {
        type: String,
        required: true,
    }
  },
  { timestamps: true }
);

const Designer = mongoose.model("Designer", designer);

module.exports = Designer;
