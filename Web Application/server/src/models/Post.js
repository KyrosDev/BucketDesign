const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const PostSchema = new Schema(
  {
    title: { type: String, required: true },
    description: { type: String, maxlength: 1500 },
    designer: {
      type: Object({
        username: {
          type: String,
          required: true,
        },
        profile_picture: {
          type: String,
          required: true,
        },
        _id: {
          type: mongoose.Schema.Types.ObjectId,
          required: true,
        },
      }),
      required: true
    },
    informations: {
      type: Object({
        type: {
          type: String,
          enum: [
            "video",
            "gif",
            "image",
          ],
          default: "image",
          required: true,
        },
        meta: {
          type: String,
          required: true,
        },
      }),
    },
    hashtags: [
      {
        name: {
          type: String,
          enum: [
            "UI Design",
            "UX Design",
            "Product Industrial Design",
            "Graphic Design",
            "Animation Design",
            "Motion Design",
            "Architectural Design",
            "Fashion Design",
            "Design",
          ],
          default: "Design",
        },
        code: {
          type: String,
          enum: ["uid", "uxd", "pid", "gd", "ad", "md", "ad", "fd", "d"],
          default: "d",
        },
      },
    ],
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
        default: [],
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
    edge_reports: {
      counter: { type: Number, default: 0 },
      reports: [
        {
          reason: {
            type: String,
            enum: [
              "Nudity or Sexual activity",
              "Hate speech or symbols",
              "Violence or Dangerous organizations",
              "Sale of illegal or regulated goods",
              "Bullying or Harassment",
              "Intellectual property violation",
              "Suicide, self-injuring or eating disorders",
              "Scam or fraud",
              "False informations",
            ],
            reportedAt: {
              type: Date,
              default: Date.now(),
            },
          },
        },
      ],
    },
    deleted: {
      isDeleted: { type: Boolean, default: false },
      deletedAt: { type: Date, default: null },
    },
  },
  { timestamps: true }
);

const Post = mongoose.model("Post", PostSchema);

module.exports = Post;
