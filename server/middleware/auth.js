module.exports = options => {
    var jwt = require('jsonwebtoken');
    let { secretkey } = require('../util/secretkey');
    var assert = require('http-assert');
    var AdminUser = require('../controllers/admin/adminUser/AdminUserController');

    return async (req, res, next) => {
        let token = String(req.headers.authorization || '').split(' ').pop();
        assert(token, 401, "请先登录");
        try{
            var { a_id } = jwt.verify(token, secretkey);
        }catch(err){
            if(err.message == "jwt malformed")
            a_id = null;
            assert(a_id, 422, "请先登录");
        }
        assert(a_id, 401, "请先登录");
        req.user = await AdminUser.getByID(a_id);
        assert(req.user, 401, "请先登录");
        // console.log("req.user", req.user);
        await next();
    }
}