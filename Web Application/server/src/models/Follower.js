const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const followerSchema = new Schema({
    designer: {
        type: Object({
            username: String,
            id: mongoose.Schema.Types.ObjectId,
            profile_picture: String,
        }),
        required: true,
    },
    follow_id: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
    },
}, { timestamps: true });

const Follow = mongoose.model("Follower", followerSchema);

module.exports = Follow;