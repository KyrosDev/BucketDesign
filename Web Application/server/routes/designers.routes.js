const router = require("express").Router();
const Joi = require("@hapi/joi");
const jwt = require("jsonwebtoken");

const connection = require("../database/connection");
const designers = connection.get("designers");

designers.createIndex("email", { unique: true });

// Get all designers
router.get("/", (req, res) => {
  designers.find().then((users) => {
    res.json(users);
  });
});

// Get user by email
router.get("/email/:email", (req, res) => {
  const email = req.params.email;
  console.log(email);
  designers.findOne({ email }).then((user) => {
    if (user !== null) {
      res.json(u);
    } else {
      res.json("User not found");
    }
  });
});

// Get user by username
router.get("/username/:username", (req, res, next) => {
  const username = req.params.username;
  designers
    .findOne({ username })
    .then((user) => {
      if (user !== null) {
        res.json(user);
      } else {
        res.json("User not found");
      }
    })
    .catch((e) => next(e));
});

// Verify token route
router.get("/token/verify/:token", (req, res, next) => {
  const token = req.params.token;
  const result = jwt.verify(token, process.env.SECRET_TOKEN);
  res.json(result);
});

// Auth Routes - Login and Register
router.use("/auth", require("./auth.routes"));

// Edit Profile Routes - Add Profile Picture, Profession and Username
router.use("/profile", require("./profile.routes"));


module.exports = router;
