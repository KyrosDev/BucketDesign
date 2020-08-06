// Utilities
const express = require("express");
const morgan = require("morgan");
const helmet = require("helmet");
const dotenv = require("dotenv");
const middlewares = require("./middlewares");
const bodyParser = require("body-parser");
const cors = require("cors");

// App
const app = express();
dotenv.config();

// App setup
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE");
  res.setHeader(
    "Access-Control-Allow-Headers",
    "Origin, Content-Type, Accept, Authorization, X-Request-With"
  );
  next();
});
app.use(morgan("dev"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(middlewares.checkTokenSetUser);
app.use(express.static("public"));
app.use(helmet());
/* 
app.options("*", cors()); */

// Routes
const designerRoutes = require("./routes/designers.routes");
const postRoutes = require("./routes/posts.routes");

// Routers
app.get("/", (req, res) => {
  console.log(req.headers);
  res.json({ message: "Welcome to my API! 🎉" });
});

app.use("/api/v1/designers", designerRoutes);
app.use("/api/v1/posts", postRoutes);
app.use("/public", express.static("public"));

app.use((req, res, next) => {
  res.status(404); // Set status code to 404 Not Found
  const error = new Error(`Not Found - URL: ${req.originalUrl}`); // Create error
  next(error); // Send error
}); // Use middlewares

app.use((err, req, res, next) => {
  res.status(res.statusCode || 500); // Set status code to currentStatus or 500
  res.json({
    message: err.message,
    stack: process.env.NODE_ENV === "production" ? "🥮" : err.stack,
  }); // Send message
}); // Use middlewares

module.exports = app;
