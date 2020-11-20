const Like = require("../models/Like");
const Post = require("../models/Post");
const Comment = require("../models/Comment");

async function increment(collection, id, value) {
    await collection.findByIdAndUpdate(id, { $inc: { likes_counter: value } });
    return;
}

async function addLike(designer, post_id, comment_id) {
    const liked = await Like.find({ post_id, designer });
    if (liked.length === 0) {
        const like = new Like(post_id ? {
            designer,
            post_id
        } : { designer, comment_id });
        console.log(post_id);
        console.log(comment_id);
        if (post_id !== undefined) increment(Post, post_id, 1);
        if (comment_id !== undefined) increment(Comment, comment_id, 1);
        const result = await like.save();
        return result;
    }
    return { status: 400, message: "You already liked this post." }
}

async function removeLike(designer, post_id, comment_id) {
    let liked = null;
    if (post_id)
        liked = await Like.findOneAndDelete({ post_id, designer });
    if (comment_id)
        liked = await Like.findOneAndDelete({ comment_id, designer });
    if (liked) {
        if (post_id) increment(Post, post_id, -1);
        if (comment_id) increment(Comment, comment_id, -1);
        return "Unliked successfully";
    }
    return { status: 400, message: "You didn't liked this post." };
}

async function getAllLikes() {
    const likes = await Like.find({});
    return likes;
}

module.exports = {
    getAllLikes,
    addLike,
    removeLike,
};