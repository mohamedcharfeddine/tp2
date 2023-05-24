const request = require("request");

request("http://localhost:8080/data", { json: true }, (err, res, body) => {
  if (err) {
    return console.log(err);
  }
  console.log(body);
});

fetch("http://localhost:8080/data")
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error(error));

const axios = require("axios");

axios
  .get("http://localhost:8080/data")
  .then((response) => console.log(response.data))
  .catch((error) => console.error(error));
