const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const commentSchema = new Schema({
    content: {
        type: String,
        max: 500,
        required: true,
    },
    likes: {
        type: Object({
            counter: {
                type: Number,
                default: 0,
            },
            users: {
                type: Array,
                default: [],
            }
        }),
    },
    responses: {
        type: Array,
        default: [],
    },
    author: {
        type: Object({
            username: String,
            profile_picture: String,
            id: mongoose.Schema.Types.ObjectId,
        }),
        required: true,
    }
}, { timestamps: true, });

const Comment = mongoose.model("Comment", commentSchema);

module.exports = Comment;