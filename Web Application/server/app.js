// Utilities
const express = require("express");
const morgan = require("morgan");
const helmet = require("helmet");
const dotenv = require("dotenv");
const middlewares = require("./middlewares");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");

const connection = mongoose.connect("mongodb://localhost/bucketdesign", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  useFindAndModify: false,
});

connection
  .then(() => {
    console.log("DB Connected! 🔥😎");
  })
  .catch((e) => {
    console.log(e);
  });

// App
const app = express();
dotenv.config();

// App setup

app.use(morgan("dev"));
app.use((req, res, next) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader(
    "Access-Control-Allow-Methods",
    "POST, GET, OPTIONS, PUT, DELETE"
  );
  res.setHeader(
    "Access-Control-Allow-Headers",
    "Origin, Content-Type, Accept, Authorization, X-Request-With"
  );
  next();
});
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(middlewares.checkTokenSetUser);
app.use(express.static("public"));
app.use(helmet());

// Routes
const designerRoutes_v1 = require("./routes/api/v1/designers.routes");
const postRoutes_v1 = require("./routes/api/v1/posts.routes");

const designerRoutes_v2 = require("./routes/api/v2/designers.routes");
const postRoutes_v2 = require("./routes/api/v2/posts.routes");

const authRoutes_v2 = require("./routes/api/v2/auth.routes");

// Routers
app.get("/", (req, res) => {
  console.log(req.headers);
  res.json({ message: "Welcome to my API! 🎉" });
});

app.use("/api/v1/designers", designerRoutes_v1);
app.use("/api/v1/posts", postRoutes_v1);
app.use("/api/v2/designers", designerRoutes_v2);
app.use("/api/v2/posts", postRoutes_v2);

app.use("/api/v2/auth", authRoutes_v2);

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
