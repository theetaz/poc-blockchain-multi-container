const express = require("express");
const app = express();
const port = 4501;

app.get("/test", (req, res) => {
  res.status(200).json({
    status: "success",
    message: `this message from container A`
  });
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
