const express = require("express");
const dgram = require("dgram");
const app = express();
const port = 4500;

let udpSuccess = false;

const client = dgram.createSocket("udp4");
client.on("message", () => {
  udpSuccess = true;
});

app.get("/test-udp", (req, res) => {
  const message = Buffer.from("Test message");
  client.send(message, 30310, "bootnode-3192360657", (error, data) => {
    console.log("ERROR", error);
    console.log("DATA", data);
    if (data) {
      res.status(200).json({
        status: "success",
        message: `UDP communication is successful data : ${data}`
      });
    }

    if (error) {
      res.status(400).json({
        status: "error",
        message: `UDP communication is failed error : ${error}`
      });
    }
  });
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
