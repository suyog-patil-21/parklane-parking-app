const express = require("express");
const app = require("express")();
require("dotenv").config();
const httpServer = require("http").createServer(app);
const cors = require("cors");
const randomBetween = require("./miscellaneous");
const options = { cors: { origin: "*" } };
const io = require("socket.io")(httpServer, options);
const authRoutes = require("./routes/authRoutes");
const mongoose = require("mongoose");
const { requireAuth } = require("./middleware/authmiddleware");

const port = process.env.PORT || 3000;

// * Middleware
app.use(cors());
// app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// * Auth Routes here
app.use(authRoutes);

// * MongoDB Connection
const dbURI = process.env.MONGODBURI;
mongoose
  .connect(dbURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    // useCreateIndex: true,
  }) // * run backend only if connected to Database
  .then((result) => {
    // console.log(result);
    httpServer.listen(port, () => {
      console.log(`Backend listening on port ${port}`);
    });
  })
  .catch((err) => console.log(err));

// ! Socket.io connection and working
io.on("connection", (socket) => {
  console.log("userConnected " + socket.id);
  let parkingArea;

  // socket.on('staus',(data) => {
  // console.log('From the Client: '+data);
  // const adminEmitter = emitter.of("/admin");
  // adminEmitter.emit()
  // });
  socket.on("fetchStatus", (data) => {
    console.log("data form the clients is " + data);

    parkingArea = JSON.stringify({
      gp0001: randomBetween(0, 2),
      gp0002: randomBetween(0, 2),
    });
    console.log(parkingArea);
    socket.broadcast.emit("parkstatus", parkingArea);
  });
});

app.get("/", requireAuth, (req, res) => {
  res.send("Welcome to Parklane");
});
