const Comment = require("../models/Comment");
const Post = require("../models/Post");

async function increment(id, value) {
    await Post.findByIdAndUpdate(id, { $inc: { comments_counter: value } });
    return;
}

async function createComment(designer, post_id, body) {
    const exists = await Post.findById(post_id);
    if (exists) {
        const commentBody = {
            content: body.content,
            designer,
            post_id,
        }
        increment(post_id, 1);
        const comment = new Comment(commentBody);
        const result = await comment.save();
        return result;
    }
    return { status: 400, message: "Post ID doesn't exists. Please provide us a valid id" };
}

async function getPostComments(id) {
    const comments = await Comment.find({ post_id: id });
    return comments;
}

async function deleteComment(id) {
    const comment = await Comment.findByIdAndDelete(id);
    if (comment) { await increment(id, -1); return "Deleted" };
    return { status: 400, message: "Comment ID doesn't exists." };
}

module.exports = {
    createComment,
    deleteComment,
    getPostComments,
};