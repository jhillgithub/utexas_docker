const express = require('express');

const app = express();

const PORT = 3000;

app.get("*", (req, res) => {
    return res.send("Hello World!");
});

app.listen(PORT, (err) => {
    if (err) {
        return console.log(err);
    }
    console.log(`Listening on port: ${PORT}`);
});