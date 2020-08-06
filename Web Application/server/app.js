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

const corsOpts = {
  origin: "*",

  methods: ["GET", "POST", "PUT", "PATCH", "DELETE"],

  allowedHeaders: ["Content-Type"],
};

app.use(cors(corsOpts));
app.use(morgan("dev"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(middlewares.checkTokenSetUser);
app.use(express.static("public"));
app.use(helmet());

// Routes
const designerRoutes = require("./routes/designers.routes");
const postRoutes = require("./routes/posts.routes");

// Routers
app.get("/", (req, res) => {
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
