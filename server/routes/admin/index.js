module.exports = app => {
  var express = require('express');
  var router = express.Router();
  var Bangumi = require('../../controllers/BangumiController');

  /* GET home page. */
  router.get('/', (req, res) => {
    res.send({
      status: '200',
      message: '访问成功'
    })
  });

  router.get('/bangumis',Bangumi.getBangumis);
  router.get('/bangumis/:id',Bangumi.getBangumi);
  router.post('/bangumis',Bangumi.createBangumi);

  app.use('/admin/api',router);
}
