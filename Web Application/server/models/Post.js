const Joi = require("@hapi/joi");

const schema = Joi.object().keys({
  title: Joi.string().max(30).required(), // This is my post
  description: Joi.string().max(1500).optional(), // This is my description
  shortcode: Joi.string().alphanum().required(), // This is a random string
  author: Joi.object()
    .keys({
      id: Joi.string().alphanum().required(), // Author ID
    })
    .required(),
  previewURL: Joi.string().required(), // Image to show on hompage
  likes: Joi.object({
    counter: Joi.number().required().default(0), // 1 Like
    likes: Joi.array()
      .items(
        Joi.object({
          id: Joi.string().required(), // Designer's ID
        })
      )
      .required(),
  })
    .optional()
    .default({
      counter: 0,
      likes: [],
    }), // Set value as default
  comments: Joi.object({
    counter: Joi.number().required().default(0), // 1 Comment
    comments: Joi.array()
      .items(
        Joi.object({
          id: Joi.string().required(), // Comment ID
        })
      )
      .required(),
  })
    .optional()
    .default({
      counter: 0,
      comments: [],
    }), // Set value as default
  attachments: Joi.array()
    .items({
      imageURL: Joi.string().required(), // More image URLs
    })
    .optional(),
  createdAt: Joi.date().timestamp("javascript").required(), // Created At Date
  deleted: Joi.bool().default(false), //! If post was deleted, turn it into true. But DON'T delete post.
});

module.exports = schema;
