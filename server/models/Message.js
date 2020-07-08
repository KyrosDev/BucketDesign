const mongoose = require('mongoose');
const { Schema } = mongoose;

const requiredObjectId = {
    type: mongoose.Schema.Types.ObjectId,
    required: true
}

const messageSchema = new Schema({
    text: {
        type: String,
        required: true,
    },
    from_id: requiredObjectId,
    to_id: requiredObjectId,
});

const Message = mongoose.model('Message', messageSchema);

module.exports = Message;