const Follow = require("../models/Follower");
const Designer = require("../models/Designer");

async function follow(designer, follow_id) {
    const following = await Follow.find().select({ designer: designer, follow_id: follow_id });
    console.log(following);
    if (following.length === 0) {
        const result = await new Follow({ designer, follow_id }).save();
        await Designer.findOneAndUpdate({ _id: designer._id }, { $inc: { following_counter: 1 } });
        await Designer.findOneAndUpdate({ _id: follow_id }, { $inc: { followers_counter: 1 } });
        return result;
    }
    return { status: 400, message: "You are already following this user" };
}

async function unfollow(designer, follow_id) {
    const following = await Follow.find().select({ designer, follow_id });
    console.log(following.length);
    if (following.length == 1) {
        await Designer.findOneAndUpdate({ _id: designer._id }, { $inc: { following_counter: -1 } });
        await Designer.findOneAndUpdate({ _id: follow_id }, { $inc: { followers_counter: -1 } });
        console.log(following[0]);
        const result = await Follow.findByIdAndDelete(following[0]._id);
        if (result) return { message: "Unfollowed successfully." };
    }
    return { status: 400, message: "You are not following this user" };
}

async function getFollowers(designer_id) {
    const result = await Follow.find().select({ follow_id: designer_id });
    return result;
}

async function getFollowing(designer) {
    const result = await Follow.find().select({ designer: designer });
    return result;
}

module.exports = {
    follow,
    unfollow,
    getFollowers,
    getFollowing,
};