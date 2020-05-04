module.exports = app => {
  var express = require('express');
  var router = express.Router();
  var Bangumi = require('../../controllers/admin/bangumi/BangumiController');
  var Guoman = require('../../controllers/admin/guoman/GuomanController');
  var Theater = require('../../controllers/admin/theater/TheaterController');
  var FilmTV = require('../../controllers/admin/filmtv/FilmtvController');
  var Userinfo = require('../../controllers/admin/userinfo/UserinfoController');
  var Video = require('../../controllers/admin/video/VideoController');
  var Comment = require('../../controllers/admin/comment/CommentController');

  /* GET home page. */
  router.get('/', (req, res) => {
    res.send({
      status: '200',
      message: '访问成功'
    })
  });

  router.get('/bangumis', Bangumi.getAll);
  router.get('/bangumis/:id', Bangumi.getOne);
  router.post('/bangumis', Bangumi.createOne);
  router.put('/bangumis/:id', Bangumi.updateOne);
  router.delete('/bangumis/:id', Bangumi.deleteOne);

  router.get('/guomans', Guoman.getAll);
  router.get('/guomans/:id', Guoman.getOne);
  router.post('/guomans', Guoman.createOne);
  router.put('/guomans/:id', Guoman.updateOne);
  router.delete('/guomans/:id', Guoman.deleteOne);

  router.get('/theaters', Theater.getAll);
  router.get('/theaters/:id', Theater.getOne);
  router.post('/theaters', Theater.createOne);
  router.put('/theaters/:id', Theater.updateOne);
  router.delete('/theaters/:id', Theater.deleteOne);

  router.get('/filmtvs', FilmTV.getAll);
  router.get('/filmtvs/:id', FilmTV.getOne);
  router.post('/filmtvs', FilmTV.createOne);
  router.put('/filmtvs/:id', FilmTV.updateOne);
  router.delete('/filmtvs/:id', FilmTV.deleteOne);

  router.get('/userinfos', Userinfo.getAll);
  router.post('/userinfos/:id', Userinfo.getOne);
  router.post('/userinfos', Userinfo.createOne);
  router.put('/userinfos/:id', Userinfo.updateOne);
  router.delete('/userinfos/:id', Userinfo.deleteOne);

  router.get('/comments', Comment.getAll);
  router.get('/comments/:id', Comment.getOne);
  router.post('/comments', Comment.createOne);
  router.put('/comments/:id', Comment.updateOne);
  router.delete('/comments/:id', Comment.deleteOne);
  router.delete('/comments', Comment.deleteByVideo);

  router.get('/videos', Video.getAll);
  // router.get('/videos/:id', Video.getOne);
  router.post('/videos', Video.createOne);
  router.put('/videos/:id', Video.updateOne);
  router.delete('/videos/:id', Video.deleteOne);
  router.delete('/videos', Video.deleteByFilmName);

  app.use('/admin/api', router);
}
