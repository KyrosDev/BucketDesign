// Utilities
const express = require("express");
const morgan = require('morgan');
const helmet = require("helmet");
const dotenv = require("dotenv");
const cors = require("cors");

// App
const app = express();
dotenv.config();

// App setup
app.use(morgan("dev"));
app.use(express.json());
app.use(helmet());
app.use(cors({origin: "http://localhost:8080"}));

// Routes
const designerRoutes = require("./routes/designers.routes");
const postRoutes = require("./routes/posts.routes");
const commentRoutes = require("./routes/comments.routes");
const messageRoutes = require("./routes/messages.routes");
const chatroomRoutes = require("./routes/chatrooms.routes");

// AUTH Routes
const authRoute = require("./auth");

// Routers
app.get("/", (req, res) => {
  res.json({ message: "Welcome to my API! 🎉" });
});

app.use("/api/designers", designerRoutes);
app.use("/api/posts", postRoutes);
app.use("/api/comments", commentRoutes);
app.use("/api/messages", messageRoutes);
app.use("/api/chatrooms", chatroomRoutes);
app.use("/auth", authRoute);

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
