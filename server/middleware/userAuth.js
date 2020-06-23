module.exports = options => {
    var jwt = require('jsonwebtoken');
    let { secretkey } = require('../util/secretkey');
    var assert = require('http-assert');
    var User = require('../controllers/users/user/UserinfoController');

    return async (req, res, next) => {
        let token = String(req.headers.authorization || '').split(' ').pop();
        assert(token, 401, "请先登录");
        try {
            var { user_id } = jwt.verify(token, secretkey);
        } catch (err) {
            if (err.message == "jwt malformed")
                user_id = null;
            assert(user_id, 422, "请先登录");
        }
        assert(user_id, 401, "请先登录");
        req.user_id = user_id;
        req.user = await User.getByID(user_id);
        assert(req.user, 401, "请先登录");
        // //console.log("req.user", req.user);
        await next();
    }
}