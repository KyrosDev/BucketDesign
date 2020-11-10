const Post = require("../models/Post");

function generateRandomShortcode() {
    const letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "_", "$"];
    let result = "";
    for (let i = 0; i < 10; i++)
        result += letters[Math.floor(Math.random() * letters.length)];
    return result;
}

async function getPosts() {
    const result = await Post.find();
    return result;
}

async function getByAuthorID(_id) {
    const result = await Post.find().select({ author: { _id } });
    if (result)
        return result;
    return null;
}

async function getByAuthorUsername(username) {
    const result = await Post.find().select({ author: { username } });
    if (result)
        return result;
    return null;
}

async function getByShortcode(shortcode) {
    const result = await Post.findOne({ shortcode });
    if (result)
        return result;
    return null;
}

async function getByType(type) {
    const result = await Post.find({}).select({ informations: { type } });
    if (result)
        return result;
    return null;
}

async function getById(id) {
    const result = await Post.findById(id);
    if (result)
        return result;
    else
        return null;
}

async function getByTag(tag) {
    const result = await Post.find({}).select({ hastags: hastags.contains(tag) });
    if (result)
        return result;
    return null;
}

async function createPost(body) {
    body.shortcode = generateRandomShortcode();
    const post = await new Post(body);
    let valid = null;
    try {
        valid = await post.save();
    } catch (e) {
        return e;
    }
    return valid;
}

function getFeed(follows) {
    let result = null;
    follows.map(async (follow) => {
        result = await Post.find({}).select({ author: { _id: follow } });
    });
    return result;
}

module.exports = {
    getPosts,
    getByAuthorID,
    getByAuthorUsername,
    getById,
    getByTag,
    getByType,
    getByShortcode,
    getFeed,
    createPost,
}