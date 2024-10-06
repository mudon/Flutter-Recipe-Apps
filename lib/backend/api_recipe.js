const express = require('express');
const app = express();
var fs = require('fs');
const path = require('path');
const port = 3000;

app.get('/recipeImage', (req, res) => {
  req.query.imageName = "nasi-ayam";

  const imagePath = path.join('/home/iot-2/Desktop/Flu/Recipe App Project/recipe_project/assets/images/makanan', `${req.query.imageName}.jpeg`);

  res.sendFile(imagePath);
});

app.get('/recipeList', (req, res) => {
  const data = fs.readFileSync('/home/iot-2/Desktop/Flu/Recipe App Project/recipe_project/MyApi/masakan-melayu.json', 'utf8');
  res.send(data);
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
