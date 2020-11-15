const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const commentSchema = new Schema({
    content: {
        type: String,
        max: 500,
        required: true,
    },
    likes_counter: {
        type: Number,
        default: 0,
    },
    designer: {
        type: Object({
            id: mongoose.Schema.Types.ObjectId,
        }),
        required: true,
    },
    post_id: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
    },
    comment_id: {
        type: mongoose.Schema.Types.ObjectId,
    }
}, { timestamps: true, });

const Comment = mongoose.model("Comment", commentSchema);

module.exports = Comment;