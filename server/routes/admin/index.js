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
  var authMiddleware = require('../../middleware/auth')
  var axios = require("axios");

  router.get('/image', async (req, res) => {
    let rst = await axios.get("https://api.dongmanxingkong.com/suijitupian/acg/1080p/index.php?return=json");
    // let rst = await axios.get("https://api.ixiaowai.cn/api/api.php?return=json");
    return res.send(rst.data)
  });

  router.get('/hitokoto', authMiddleware(), async (req, res) => {
    let rst = await axios.get("https://v1.hitokoto.cn/?c=a&encode=json");
    return res.send({
      'hitokoto':rst.data,
      'super_admin':req.user.super_admin
    })
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
  router.put('/userinfos/:id', authMiddleware(), Userinfo.updateOne);
  router.delete('/userinfos/:id', authMiddleware(), Userinfo.deleteOne);

  router.post('/login', AdminUser.login);
  router.get('/verifytoken',authMiddleware(),(req,res)=>{
    console.log("res", );
    return res.send({"status":200});
  });
  router.get('/adminusers', authMiddleware(), AdminUser.getAll);
  router.post('/adminusers/:id', authMiddleware(), AdminUser.getOne);
  router.post('/adminusers', authMiddleware(), AdminUser.createOne);
  router.put('/adminusers/:id', authMiddleware(), AdminUser.updateOne);
  router.delete('/adminusers/:id', authMiddleware(), AdminUser.deleteOne);

  router.get('/comments', authMiddleware(), Comment.getAll);
  router.get('/comments/:id', authMiddleware(), Comment.getOne);
  router.post('/comments', authMiddleware(), Comment.createOne);
  router.put('/comments/:id', authMiddleware(), Comment.updateOne);
  router.delete('/comments/:id', authMiddleware(), Comment.deleteOne);
  router.delete('/comments', authMiddleware(), Comment.deleteByVideo);

  router.get('/videos', authMiddleware(), Video.getAll);
  // router.get('/videos/:id', Video.getOne);
  router.post('/videos', authMiddleware(), Video.createOne);
  router.put('/videos/:id', authMiddleware(), Video.updateOne);
  router.delete('/videos/:id', authMiddleware(), Video.deleteOne);
  router.delete('/videos', authMiddleware(), Video.deleteByFilmName);

  app.use('/admin/api', router);
  // app.use(async (err, req, res, next) => {
  //   console.log("error");
  //   res.status(err.status).send({
  //     message: err.message
  //   });
  // })
}
