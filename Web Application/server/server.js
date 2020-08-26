const http = require("http");
const app = require("./app");

const port = process.env.PORT || 5000;

const server = http.createServer(app);
const io = require("socket.io")(server);

io.on("connection", (socket) => {
  console.log("New user connected: " + socket.id);

  socket.on("send-message", (data) => {
    socket.broadcast.emit("get-message", data);
  });

  socket.on("disconnect", () =>
    console.log("User " + socket.id + " disconnected.")
  );
});

server.listen(port, () => {
  console.log(`Server running on: 'http://localhost:${port}/' ✨🪐.`);
});
