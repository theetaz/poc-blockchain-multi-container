const express = require("express");
const app = express();
const port = 4502;
const axios = require("axios");

app.get("/test", (req, res) => {
  res.status(200).json({
    status: "success",
    message: `this message from container B`
  });
});

app.get("/container-test", async (req, res) => {
  const containerAEndpoint = "http://container-a:4501/test";

  const response = await axios.get(containerAEndpoint);
  const data = response.data;
  res.status(200).json({
    status: "success",
    message: `this message from container B and container A response : ${JSON.stringify(
      data
    )}}`
  });
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
