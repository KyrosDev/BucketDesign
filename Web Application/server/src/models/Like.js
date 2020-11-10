const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const likeSchema = new Schema({
    designer: {
        type: Object({
            username: String,
            id: mongoose.Schema.Types.ObjectId,
            profile_picture: String,
        }),
        required: true,
    },
    post_id: {
        type: mongoose.Schema.Types.ObjectId,
        required: false,
    },
    comment_id: {
        type: mongoose.Schema.Types.ObjectId,
        required: false,
    }
}, { timestamps: true });

const Like = mongoose.model("Like", likeSchema);

module.exports = Like;