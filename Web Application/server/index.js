// Utilities
const express = require("express");
const morgan = require("morgan");
const helmet = require("helmet");
const dotenv = require("dotenv");
const cors = require("cors");
const middlewares = require("./middlewares");
const path = require("path");
const fs = require("fs");

// App
const app = express();
dotenv.config();

// App setup
app.use(cors());
app.use(morgan("dev"));
app.use(express.json());
app.use(helmet());
app.use(middlewares.checkTokenSetUser);
app.use(express.static('public'));

// Routes
const designerRoutes = require("./routes/designers.routes");
const postRoutes = require("./routes/posts.routes");

// Routers
app.get("/", express.static(path.join(__dirname, "./public")), (req, res) => {
  res.json({ message: "Welcome to my API! 🎉", user: req.user });
});

app.use("/api/designers", designerRoutes);
app.use("/api/posts", postRoutes);
app.use("/public", express.static('public'));

// Send not found error
function notFound(req, res, next) {
  res.status(404); // Set status code to 404 Not Found
  const error = new Error(`Not Found - URL: ${req.originalUrl}`); // Create error
  next(error); // Send error
}

// Send error if some error
function errorHandler(err, req, res, next) {
  res.status(res.statusCode || 500); // Set status code to currentStatus or 500
  res.json({
    message: err.message,
    stack: process.env.NODE_ENV === "production" ? "🥮" : err.stack,
  }); // Send message
}

app.use(notFound); // Use middlewares
app.use(errorHandler); // Use middlewares

// Run application
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on: 'http://localhost:${PORT}' ✨`);
});
