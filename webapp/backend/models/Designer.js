const mongoose = require('mongoose');

const DesignerSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  username: {
    type: String,
    required: true
  },
  biography: {
    type: String,
    required: true
  },
  profile_picture_url: {
    url: {
      type: String,
      default: ""
    },
    contentType: {
      type: String,
      default: ""
    },
  },
  edge_follows: {
    count: {type: Number, default: 0},
    users: []
  },
  edge_followers: {
    count: {type: Number, default: 0},
    users: []
  },
  edge_posts: {
    count: {type: Number, default: 0},
    posts: []
  },
  location: String,
  profession: [],
  email: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  }
}, { timestamps: true });

const Designer = mongoose.model('Designer', DesignerSchema);

module.exports = Designer;