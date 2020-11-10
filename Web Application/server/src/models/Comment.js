const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const commentSchema = new Schema({
    content: {
        type: String,
        max: 500,
        required: true,
    },
    responses: {
        type: Array,
        default: [],
    },
    likes_counter: {
        type: Number,
        default: 0,
    },
    designer: {
        type: Object({
            username: String,
            profile_picture: String,
            id: mongoose.Schema.Types.ObjectId,
        }),
        required: true,
    },
    post_id: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
    }
}, { timestamps: true, });

const Comment = mongoose.model("Comment", commentSchema);

module.exports = Comment;