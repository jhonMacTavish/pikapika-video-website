module.exports = app =>{
  var express = require('express');
  var router = express.Router();
  var Bangumi = require('../../controllers/users/bangumi/BangumiController');
  var Guoman = require('../../controllers/users/guoman/GuomanController');
  var Theater = require('../../controllers/users/theater/TheaterController');
  var FilmTV = require('../../controllers/users/filmtv/FilmtvController');
  var userinfo = require('../../controllers/users/userinfo/userinfoController');
  var Video = require('../../controllers/users/video/VideoController');
  var Comment = require('../../controllers/users/comment/CommentController');
  var axios = require("axios");


  router.get('/image', async (req, res) => {
    let rst = await axios.get("https://api.dongmanxingkong.com/suijitupian/acg/1080p/index.php?return=json");
    console.log("data", rst.data);
    res.send(rst.data)
  });

  router.get('/bangumis', Bangumi.getAll);
  router.get('/bangumis/:id', Bangumi.getOne);

  router.get('/guomans', Guoman.getAll);
  router.get('/guomans/:id', Guoman.getOne);

  router.get('/theaters', Theater.getAll);
  router.get('/theaters/:id', Theater.getOne);

  router.get('/filmtvs', FilmTV.getAll);
  router.get('/filmtvs/:id', FilmTV.getOne);

  router.get('/videos', Video.getAll);

  app.use('/users/api',router);
}