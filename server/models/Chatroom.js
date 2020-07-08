const mongoose = require('mongoose');
const { Schema } = mongoose;

const chatroomSchema = new Schema({
    users: [
        {
            type: mongoose.Schema.Types.ObjectId,
            required: true,
        }
    ],
    chat: [
        {
            type: mongoose.Schema.Types.ObjectId,
        }
    ]
});

const Chatroom = mongoose.model('Chatroom', chatroomSchema);

module.exports = Chatroom;