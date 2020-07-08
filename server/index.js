// Utilities
const express = require("express"),
  helmet = require("helmet"),
  morgan = require("morgan"),
  dotenv = require("dotenv"),
  mongoose = require("mongoose"),
  cors = require("cors");

// Middlewares
const { errorHandler, notFound } = require('./middlewares/main');

// App
const app = express();
dotenv.config();

// App setup
app.use(express.json());
app.use(helmet());
app.use(morgan());
app.use(cors(process.env.CROSS_ORIGIN_ACCESS || "http://localhost:8080"));

// DB Connection
mongoose.connect(
  process.env.MONGODB_URI || "mongodb://localhost/bucketdesign",
  {
    useNewUrlParser: true,
    useFindAndModify: false,
    useUnifiedTopology: true,
  }
);

// Routes
const userRoutes = require('./routes/users.routes');
const postRoutes = require('./routes/posts.routes');

// Routing
app.get("/", (req, res) => {
  res.json("Cool! 🎉");
});

// Routers
app.use("/api/users", userRoutes);
app.use("/api/posts", postRoutes);

app.use(errorHandler);
app.use(notFound);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on: 'http://localhost:${PORT}'`);
});
