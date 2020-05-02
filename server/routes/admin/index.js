module.exports = app => {
  var express = require('express');
  var router = express.Router();
  var Bangumi = require('../../controllers/BangumiController');
  var Guoman = require('../../controllers/GuomanController');

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

  app.use('/admin/api', router);
}
