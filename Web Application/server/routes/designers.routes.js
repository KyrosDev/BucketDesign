const router = require("express").Router();
const jwt = require("jsonwebtoken");

const connection = require("../database/connection");
const designers = connection.get("designers");

designers.createIndex("email", { unique: true });

// Get all designers
router.get("/", (req, res) => {
  designers.find().then((users) => {
    res.json(users); // Send designers array
  });
});

// Get user by email
router.get("/email/:email", (req, res) => {
  const email = req.params.email; // Get designer's email
  designers.findOne({ email }).then((user) => {
    // If user with that email exists send to client
    if (user !== null) {
      res.json(u);
    }

    // Else send "404"
    else {
      res.status(404).json("User not found");
    }
  });
});

// Verify token route
router.get("/token/verify/:token", (req, res, next) => {
  const token = req.params.token; // Take designer's token
  const result = jwt.verify(token, process.env.SECRET_TOKEN); // Check if token is valid
  res.json(result); // Send result. {error / payload (email)}
});

// Get Designer by ID
router.get("/:id", (req, res, next) => {
  const id = req.params.id; // Get designer's ID
  designers
    .findOne({ _id: id })
    .then((user) => {
      // If designer exists and send some informations to the client
      if (user !== null) {
        res.json({
          id: user._id, // Used for v-for :key
          profile_picture: `https://bucketdesign.herokuapp.com/public/${user.profile_picture}`, // Profile Picutre
          username: user.username, // Designer Username
          profession: user.profession, // Designer Profession
        });
      }
    })
    // If error send error
    .catch((e) => next(e));
});

// Auth Routes - Login and Register
router.use("/auth", require("./auth.routes"));

// Get user information by username
router.use("/username", require("./username.routes"));

// Edit Profile Routes - Add Profile Picture, Profession and Username
router.use("/profile", require("./profile.routes"));

module.exports = router;
