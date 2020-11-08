// Utilities
const express = require("express");
const morgan = require("morgan");
const helmet = require("helmet");
const middlewares = require("./src/middlewares");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");

require("dotenv").config();

const connection = mongoose.connect(
  "mongodb://localhost:27017/bucketdesign",
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
  }
);

connection
  .then(() => {
    console.log("DB Connected! 🔥😎");
  })
  .catch((e) => {
    console.log(e);
  });

// App
const app = express();

// App setup

app.use(morgan("dev"));
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader(
    "Access-Control-Allow-Methods",
    "POST, GET"
  );
  res.setHeader(
    "Access-Control-Allow-Headers",
    "Content-Type, Authorization, X-Admin-Token"
  );
  next();
});
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.static("public"));
app.use(helmet());

// Routes
const designer = require("./src/routes/api/designer.routes");
const post = require("./src/routes/api/post.routes");

// Routers
app.get("/", (_, res) => {
  res.json({ message: "Welcome to my API! 🎉" });
});

app.use("/api/designers", designer);
app.use("/api/posts", post);

app.use("/public", express.static("src/public"));

app.use((req, res, next) => {
  res.status(404); // Set status code to 404 Not Found
  const error = new Error(`Not Found - URL: ${req.originalUrl}`); // Create error
  next(error); // Send error
}); // Use middlewares

app.use((err, req, res, next) => {
  res.status(err.status || 500); // Set status code to currentStatus or 500
  res.json({
    message: err.message,
    stack: process.env.NODE_ENV === "production" ? "🥮" : err.stack,
  }); // Send message
}); // Use middlewares

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server running on: 'http://localhost:${PORT}/' ✨🪐.`)
});