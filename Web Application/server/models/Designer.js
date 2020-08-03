const Joi = require("@hapi/joi");

const schema = Joi.object().keys({
  username: Joi.string().min(4).max(25).alphanum(),
  profession: Joi.object(),
  edge_posts: Joi.object()
    .keys({
      counter: Joi.number().default(0),
      posts: Joi.array().items(Joi.object()).default([]),
    })
    .default({
      counter: 0,
      posts: [],
    }),
  edge_followers: Joi.object()
    .keys({
      counter: Joi.number().default(0),
      followers: Joi.array().items(Joi.object()).default([]),
    })
    .default({
      counter: 0,
      followers: [],
    }),
  edge_follows: Joi.object()
    .keys({
      counter: Joi.number().default(0),
      follows: Joi.array().items(Joi.object()).default([]),
    })
    .default({
      counter: 0,
      follows: [],
    }),
  profile_picture: Joi.string().alphanum(),
  location: Joi.string(),
  biography: Joi.string().max(150),
  email: Joi.string().email().required(),
  password: Joi.string().min(8).required(),
  token: Joi.string().token(),
});

module.exports = schema;