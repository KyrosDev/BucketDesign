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

// Routes
const designerRoutes = require("./routes/designers.routes");
const postRoutes = require("./routes/posts.routes");
const commentRoutes = require("./routes/comments.routes");
const messageRoutes = require("./routes/messages.routes");
const chatroomRoutes = require("./routes/chatrooms.routes");

// Routers
app.get("/", express.static(path.join(__dirname, "./public")), (req, res) => {
  res.json({ message: "Welcome to my API! 🎉", user: req.user });
});

app.use("/api/designers", designerRoutes);
app.use("/api/posts", postRoutes);
/* app.use("/api/comments", commentRoutes);
app.use("/api/messages", messageRoutes);
app.use("/api/chatrooms", chatroomRoutes); */

function notFound(req, res, next) {
  res.status(404);
  const error = new Error(`Not Found - URL: ${req.originalUrl}`);
  next(error);
}

function errorHandler(err, req, res, next) {
  res.status(res.statusCode || 500);
  res.json({
    message: err.message,
    stack: process.env.NODE_ENV === "production" ? "🥮" : err.stack,
  });
}

app.use(notFound);
app.use(errorHandler);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on: 'http://localhost:${PORT}' ✨`);
});
