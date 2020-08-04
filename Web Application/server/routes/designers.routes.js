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
  designers.findOne({ email }).then((user) => {
    if (user !== null) {
      res.json(u);
    } else {
      res.json("User not found");
    }
  });
});

// Verify token route
router.get("/token/verify/:token", (req, res, next) => {
  const token = req.params.token;
  const result = jwt.verify(token, process.env.SECRET_TOKEN);
  res.json(result);
});

// Auth Routes - Login and Register
router.use("/auth", require("./auth.routes"));

// Get user information by username
router.use("/username", require("./username.routes"));

// Edit Profile Routes - Add Profile Picture, Profession and Username
router.use("/profile", require("./profile.routes"));


module.exports = router;
