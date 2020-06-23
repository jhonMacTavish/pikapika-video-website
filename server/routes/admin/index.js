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
  var AdminUser = require('../../controllers/admin/adminUser/AdminUserController');
  var Carousel = require('../../controllers/admin/carousel/CarouselController');
  var Ads = require('../../controllers/admin/ads/AdsController');
  var Announce = require('../../controllers/admin/announce/AnnounceController');
  var Report = require('../../controllers/admin/report/ReportController');

  var authMiddleware = require('../../middleware/adminAuth');
  var authSuperAdmin = require('../../middleware/superAdminAuth');
  var axios = require("axios");

  router.get('/image', async (req, res) => {
    let rst = await axios.get("https://api.dongmanxingkong.com/suijitupian/acg/1080p/index.php?return=json");
    return res.send(rst.data)
  });

  router.get('/hitokoto', async (req, res) => {
    let rst = await axios.get("https://v1.hitokoto.cn/?c=a&encode=json");
    return res.send({
      'hitokoto': rst.data,
    })
  });

  router.get('/adminUser', authMiddleware(), (req, res) => {
    return res.send({
      "adminUser": req.user
    })
  });

  router.get('/getResources/:name', async (req, res) => {
    let { name } = req.params;
    let {queryCode} = req.query;
    name=encodeURI(name);
    let rst = await axios.get(`http://api.pingcc.cn/?ysname=${name}`);
    if(rst.data.code){
      return res.send({
        "status":500,
        "list":rst.data.list
      })
    }else{
      return res.send({
        "status":200,
        "list":rst.data.list,
        "queryCode":queryCode
      })
    }
    // let url = rst.data.list[0].url;
    // rst = await axios.get(`http://api.pingcc.cn/?ysurl=${url}`);
    // return res.send({
    //   "status":200,
    //   "list":rst.data.list
    // })
  });

  router.get('/getEpisodes/:url', async (req, res) => {
    let { url } = req.params;
    let {queryCode} = req.query;
    let rst = await axios.get(`http://api.pingcc.cn/?ysurl=${url}`);
    if(rst.data.code){
      return res.send({
        "status":500,
        "list":rst.data.list
      })
    }else{
      return res.send({
        "status":200,
        "list":rst.data.list,
        "queryCode":queryCode
      })
    }
    // let url = rst.data.list[0].url;
    // rst = await axios.get(`http://api.pingcc.cn/?ysurl=${url}`);
    // return res.send({
    //   "status":200,
    //   "list":rst.data.list
    // })
  });

  router.get('/bangumis', authMiddleware(), Bangumi.getAll);
  router.get('/bangumis/:id', authMiddleware(), Bangumi.getOne);
  router.post('/bangumis', authMiddleware(), Bangumi.createOne);
  router.put('/bangumis/:id', authMiddleware(), Bangumi.updateOne);
  router.delete('/bangumis/:id', authMiddleware(), Bangumi.deleteOne);

  router.get('/guomans', authMiddleware(), Guoman.getAll);
  router.get('/guomans/:id', authMiddleware(), Guoman.getOne);
  router.post('/guomans', authMiddleware(), Guoman.createOne);
  router.put('/guomans/:id', authMiddleware(), Guoman.updateOne);
  router.delete('/guomans/:id', authMiddleware(), Guoman.deleteOne);

  router.get('/theaters', authMiddleware(), Theater.getAll);
  router.get('/theaters/:id', authMiddleware(), Theater.getOne);
  router.post('/theaters', authMiddleware(), Theater.createOne);
  router.put('/theaters/:id', authMiddleware(), Theater.updateOne);
  router.delete('/theaters/:id', authMiddleware(), Theater.deleteOne);

  router.get('/filmtvs', authMiddleware(), FilmTV.getAll);
  router.get('/filmtvs/:id', authMiddleware(), FilmTV.getOne);
  router.post('/filmtvs', authMiddleware(), FilmTV.createOne);
  router.put('/filmtvs/:id', authMiddleware(), FilmTV.updateOne);
  router.delete('/filmtvs/:id', authMiddleware(), FilmTV.deleteOne);

  router.get('/userinfos', authMiddleware(), Userinfo.getAll);
  router.post('/userinfos/:id', authMiddleware(), Userinfo.getOne);
  router.post('/userinfos', authMiddleware(), Userinfo.createOne);
  router.put('/userinfos/:id', authMiddleware(), Userinfo.banUser);
  router.delete('/userinfos/:id', authMiddleware(), Userinfo.deleteOne);

  router.post('/login', AdminUser.login);
  router.get('/verifytoken', authMiddleware(), (req, res) => {
    //console.log("res");
    return res.send({ "status": 200 });
  });
  router.get('/adminusers', authMiddleware(), authSuperAdmin(), AdminUser.getAll);
  router.post('/adminusers/:id', authMiddleware(), authSuperAdmin(), AdminUser.getOne);
  router.post('/adminusers', authMiddleware(), authSuperAdmin(), AdminUser.createOne);
  router.put('/adminusers/:id', authMiddleware(), authSuperAdmin(), AdminUser.updateOne);
  router.delete('/adminusers/:id', authMiddleware(), authSuperAdmin(), AdminUser.deleteOne);

  router.get('/comments', authMiddleware(), Comment.getAll);
  router.get('/comments/:id', authMiddleware(), Comment.getOne);
  router.delete('/comments/:id', authMiddleware(), Comment.deleteOne);
  router.delete('/comments', authMiddleware(), Comment.deleteByVideo);

  router.get('/videos', authMiddleware(), Video.getAll);
  router.get('/episodes', Video.getEpisodes);
  router.post('/videos', authMiddleware(), Video.createOne);
  router.put('/videos/:id', authMiddleware(), Video.updateOne);
  router.delete('/videos/:id', authMiddleware(), Video.deleteOne);
  router.delete('/videos', authMiddleware(), Video.deleteByFilmName);

  router.get('/carousels', authMiddleware(), Carousel.getAll);
  router.get('/carousels/:id', authMiddleware(), Carousel.getOne);
  router.get('/updatingfilm/:id', authMiddleware(), Carousel.getUpdatingFilms);
  router.post('/carousels', authMiddleware(), Carousel.createOne);
  router.put('/carousels/:id', authMiddleware(), Carousel.updateOne);
  router.delete('/carousels/:id', authMiddleware(), Carousel.deleteOne);
  router.delete('/removeCsl', authMiddleware(), Carousel.removeCsl);
  // router.delete('/carousels', authMiddleware(), Carousel.deleteByFilmName);

  router.get('/ads', authMiddleware(), Ads.getAll);
  router.get('/ads/:id', authMiddleware(), Ads.getOne);
  router.post('/ads', authMiddleware(), Ads.createOne);
  router.put('/ads/:id', authMiddleware(), Ads.updateOne);
  router.delete('/ads/:id', authMiddleware(), Ads.deleteOne);

  router.get('/announces', authMiddleware(), Announce.getAll);
  router.get('/announces/:id', authMiddleware(), Announce.getOne);
  router.post('/announces', authMiddleware(), Announce.createOne);
  router.put('/announces/:id', authMiddleware(), Announce.updateOne);
  router.delete('/announces/:id', authMiddleware(), Announce.deleteOne);

  router.get('/comments/reports', authMiddleware(), Report.getAll);
  router.delete('/comments/reports/:id', authMiddleware(), Report.deleteOne);

  app.use('/admin/api', router);
  // app.use(async (err, req, res, next) => {
  //   //console.log("error");
  //   res.status(err.status).send({
  //     message: err.message
  //   });
  // })
}
