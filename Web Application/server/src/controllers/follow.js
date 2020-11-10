const Follow = require("../models/Follower");
const Designer = require("../models/Designer");

async function incrementUserFields(designer, follow_id, inc) {
    await Designer.findOneAndUpdate({ _id: designer._id }, { $inc: { following_counter: inc } });
    await Designer.findOneAndUpdate({ _id: follow_id }, { $inc: { followers_counter: inc } });
}

async function follow(designer, follow_id) {
    const following = await Follow.find({ follow_id });
    if (following.length === 0) {
        const result = await new Follow({ designer, follow_id }).save();
        await incrementUserFields(designer, follow_id, 1);
        return result;
    }
    return { status: 400, message: "You are already following this user" };
}

async function unfollow(designer, follow_id) {
    const following = await Follow.find({ designer, follow_id });
    if (following.length == 1) {
        const result = await Follow.findByIdAndDelete(following[0]._id);
        await incrementUserFields(designer, follow_id, -1);
        if (result) return { message: "Unfollowed successfully." };
    }
    return { status: 400, message: "You are not following this user" };
}

async function getFollowers(follow_id) {
    const result = await Follow.find({ follow_id });
    return result;
}

async function getFollowing(designer) {
    const result = await Follow.find({ designer });
    return result;
}

module.exports = {
    follow,
    unfollow,
    getFollowers,
    getFollowing,
};