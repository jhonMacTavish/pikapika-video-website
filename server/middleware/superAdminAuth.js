module.exports = options => {
  var assert = require('http-assert');
  return async (req, res, next) => {
    if (!req.user.superAdmin) {
      assert(false, 411, "你无权访问管理员列表");
    }
    console.log("*****************----------------------");
    await next();
  }
}