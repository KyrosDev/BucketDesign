module.exports = (app) => {
    const post = require('../controllers/post.controller.js');

    // Create a new Post
    app.post('/designer/:id/post', post.create)
}