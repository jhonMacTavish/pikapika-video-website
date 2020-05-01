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
  router.get('/bangumis/:id',Bangumi.getBangumiByID);
  router.post('/bangumis',Bangumi.createBangumi);
  router.put('/bangumis/:id',Bangumi.updateBangumi);
  router.delete('/bangumis/:id',Bangumi.deleteBangumi);

  app.use('/admin/api',router);
}
