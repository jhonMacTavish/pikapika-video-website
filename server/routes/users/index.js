module.exports = app =>{
  var express = require('express');
  var router = express.Router();
  var Bangumi = require('../../controllers/users/bangumi/BangumiController');
  var Guoman = require('../../controllers/users/guoman/GuomanController');
  var Theater = require('../../controllers/users/theater/TheaterController');
  var FilmTV = require('../../controllers/users/filmtv/FilmtvController');
  var User = require('../../controllers/users/user/userinfoController');
  var Video = require('../../controllers/users/video/VideoController');
  var Comment = require('../../controllers/users/comment/CommentController');
  var axios = require("axios");


  router.get('/image', async (req, res) => {
    let rst = await axios.get("https://api.dongmanxingkong.com/suijitupian/acg/1080p/index.php?return=json");
    console.log("data", rst.data);
    res.send(rst.data)
  });

  router.get('/undefineds',(req,res)=>{
    res.send(null);
  })

  router.post('/undefineds',(req,res)=>{
    res.send(null);
  })

  router.get('/getBrank', Bangumi.getRank);
  router.get('/bangumis', Bangumi.getAll);
  router.get('/bangumis/:id', Bangumi.getOne);
  router.post('/bangumis/type', Bangumi.getStyles);
  router.post('/bangumis/search',Bangumi.search);

  router.get('/getGrank', Guoman.getRank);
  router.get('/guomans', Guoman.getAll);
  router.get('/guomans/:id', Guoman.getOne);
  router.post('/guomans/type', Guoman.getStyles);
  router.post('/guomans/search',Guoman.search);

  router.get('/getThrank', Theater.getRank);
  router.get('/theaters', Theater.getAll);
  router.get('/theaters/:id', Theater.getOne);
  router.post('/theaters/type', Theater.getStyles);
  router.post('/theaters/search',Theater.search);

  router.get('/getFrank', FilmTV.getRank);
  router.get('/filmtvs', FilmTV.getAll);
  router.get('/filmtvs/:id', FilmTV.getOne);
  router.post('/filmtvs/type', FilmTV.getStyles);
  router.post('/filmtvs/search',FilmTV.search);

  router.get('/videos', Video.getAll);
  router.get('/getBGrank', Video.getBGrank);
  router.put('/volumes',Video.addVolume);
  // router.put('/rank',Video.getVideoRank);

  router.post('/login',User.login);
  router.post('/register',User.register);
  router.post('/getCaptcha',User.sendCaptcha);

  router.get('/comments',Comment.getAll);
  router.post('/comments',Comment.createOne);
  router.delete('/comments/:id',Comment.deleteOne);

  app.use('/users/api',router);
}