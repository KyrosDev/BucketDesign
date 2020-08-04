const Joi = require("@hapi/joi");

const schema = Joi.object().keys({
  username: Joi.string().min(4).max(25).alphanum(), // KyrosDesign123
  profession: Joi.object(), // UI Designer, uid
  edge_posts: Joi.object()
    .keys({
      counter: Joi.number().default(0), // 1 Post
      posts: Joi.array().items(Joi.object()).default([]), // Post ID
    })
    .default({
      counter: 0,
      posts: [],
    }), // Set as default
  edge_followers: Joi.object()
    .keys({
      counter: Joi.number().default(0), // 1 Followers
      followers: Joi.array().items(Joi.object()).default([]), // Designer (follower) ID
    })
    .default({
      counter: 0,
      followers: [],
    }), // Set as default
  edge_follows: Joi.object()
    .keys({
      counter: Joi.number().default(0), // 1 Follow
      follows: Joi.array().items(Joi.object()).default([]), // Designer (following user) ID
    })
    .default({
      counter: 0,
      follows: [],
    }), // Set as default
  profile_picture: Joi.string().alphanum(), // {http/https}://{host}/static/{designer id}/profilePicture.{extension}
  location: Joi.string(), // Italy
  biography: Joi.string().max(150), // This is a biography.
  email: Joi.string().email().required(), // text@gmail.com
  password: Joi.string().min(8).required(), // Hashed password
  token: Joi.string().token(), // JWToken
});

module.exports = schema;
