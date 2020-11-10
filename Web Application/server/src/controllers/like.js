const Like = require("../models/Like");
const Designer = require("../models/Designer");

async function addLikeToPost(user_id, post_id) {
    const designer = await Designer.findOne({ _id: user_id });
    if (designer) {
        const like = new Like({
            author: {
                username: designer.username,
                _id: designer._id,
                profile_picture: designer.profile_picture,
            },
            post_id
        });
        return like.save();
    } else {
        return { status: 404, message: "You are not logged in." }
    }
};

async function removeLikeFromPost(post_id) {

};

async function addLikeToComment(user_id, comment_id) {

};

async function removeLikeFromComment(like_id, comment_id) {

};

async function getAllLikes() {
    const likes = await Like.find({});
    return likes;
}

module.exports = {
    getAllLikes,
    addLikeToPost,
    addLikeToComment,
    removeLikeFromPost,
    removeLikeFromComment,
};