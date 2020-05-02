module.exports = app => {
  var express = require('express');
  var router = express.Router();
  var Bangumi = require('../../controllers/bangumi/BangumiController');
  var Guoman = require('../../controllers/guoman/GuomanController');

  /* GET home page. */
  router.get('/', (req, res) => {
    res.send({
      status: '200',
      message: '访问成功'
    })
  });

  router.get('/bangumis',Bangumi.getBangumis);
  router.get('/bangumis/:id',Bangumi.getBangumiByID);
  router.post('/bangumis',Bangumi.createBangumi);
  router.put('/bangumis/:id',Bangumi.updateBangumi);
  router.delete('/bangumis/:id',Bangumi.deleteBangumi);

  router.get('/guomans',Guoman.getGuomans);
  router.get('/guomans/:id',Guoman.getGuomanByID);
  router.post('/guomans',Guoman.createGuoman);
  router.put('/guomans/:id',Guoman.updateGuoman);
  router.delete('/guomans/:id',Guoman.deleteGuoman);

  app.use('/admin/api',router);
}
