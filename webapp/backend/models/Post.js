const mongoose = require('mongoose');

const PostSchema = new mongoose.Schema({
    
    author: mongoose.ObjectId,
    shortcut: {
        type: String
    },
    image_urls: {
        type: Array,
        default: []
    },
    tags: {
        type: Array,
        default: []
    },
    description: {
        type: String,
        maxlength: 200
    },
    edge_likes: {
        count: {
            type: Number,
            default: 0
        },
        users:  {
            type: Array,
            default: []
        }
    },
    edge_comments: {
        count: {
            type: Number,
            default: 0
        },
        users: {
            type: Array,
            default: []
        }
    }

}, { timestamps: true })

const Post = mongoose.model("Post", PostSchema)

module.exports = Post;