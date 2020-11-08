const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const likeSchema = new Schema({
    author: {
        type: Object({
            username: String,
            id: mongoose.Schema.Types.ObjectId,
            profile_picture: String,
        }),
        required: true,
    },
}, { timestamps: true });

const Like = mongoose.model("Like", likeSchema);

module.exports = Like;