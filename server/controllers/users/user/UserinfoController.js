let dbconfig = require('../../../util/dbconfig');
let bcrypt = require('bcrypt');
let { secretkey } = require('../../../util/secretkey');
let jwt = require('jsonwebtoken');
var assert = require('http-assert');

let getByParams = async (obj) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_user where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let VerifyArr = [];

let generateCaptcha = () => {
    let code = Math.floor(Math.random() * (10000 - 1000)) + 1000;
    //console.log("code", code);
    return code;
}

sendCaptcha = async (req, res) => {
    let { email } = req.body;
    // //console.log("email", email);
    let captcha = generateCaptcha();
    console.log(captcha, );
    //console.log("captcha", captcha);
    VerifyArr.push({ email, captcha });
    let id = setTimeout(() => {
        VerifyArr.shift();
    }, 300000);
    // let sendEmail = await axios.get(`http://liuxingw.com/api/mail/api.php?address=${email}&name=PikaPika 登录验证&certno=您此次登录的验证码为：${captcha} ————皮卡皮卡二次元`)
    // //console.log("sendEmail", sendEmail);
    return res.send({
        "status": 200,
        "captcha": captcha,
        "msg": "验证码发送成功"
    })
}

login = async (req, res) => {
    //console.log("login");
    let captchaPass = false;
    let { email, password, captcha } = req.body;
    for (let i = 0; i < VerifyArr.length; i++) {
        if (VerifyArr[i].email && VerifyArr[i].email == email) {
            if (VerifyArr[i].captcha == captcha) {
                captchaPass = true;
                VerifyArr.pop();
            } else {
                return res.send({
                    "status": 422,
                    "msg": "验证码错误"
                })
            }
        } else {
            return res.send({
                "status": 433,
                "msg": "验证码已过期"
            })
        }
    }

    if (!captchaPass) {
        return res.send({
            "status": 426,
            "msg": "请重新获取验证码"
        })
    }

    let sql = 'select password from pk_user where email=?';
    let sqlArr = [email];

    let userPsw = await dbconfig.asyncSqlConnect(sql, sqlArr);

    if (userPsw.length == 0) {
        return res.send({
            "status": 411,
            "msg": "账号不存在"
        })
    }

    let isValid = bcrypt.compareSync(password, userPsw[0].password);
    if (!isValid) {
        return res.send({
            "status": 401,
            "msg": "密码错误"
        })
    }

    sql = 'select user_id,username,avatar,is_banned from pk_user where email=?';
    sqlArr = [email];

    let userRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    //console.log("userRst", userRst);
    if (userRst[0].is_banned) {
        return res.send({
            "status": 405,
            "msg": "该账号已被封禁，请联系管理员",
        })
    }

    let token = jwt.sign({ user_id: userRst[0].user_id }, secretkey);

    return res.send({
        "status": 200,
        "msg": "登陆成功",
        "token": token
    })
}

register = async (req, res) => {

    //console.log("register");
    let captchaPass = false;
    // //console.log("VerifyArr", VerifyArr);
    let { username, email, password, captcha } = req.body;
    for (let i = 0; i < VerifyArr.length; i++) {
        if (VerifyArr[i].email && VerifyArr[i].email == email && VerifyArr[i].captcha == captcha) {
            //console.log("验证成功");
            captchaPass = true;
            VerifyArr.pop();
            // } else {
            //     return res.send({
            //         "status": 422,
            //         "msg": "验证码错误"
            //     })
            //     return
            // }
        } else {
            return res.send({
                "status": 422,
                "msg": "验证码错误"
            })
            return
        }
    }

    if (!captchaPass) {
        return res.send({
            "status": 426,
            "msg": "请重新获取验证码"
        })
        return
    }




    let sql = 'select user_id from pk_user where email=?';
    let sqlArr = [email];

    let user = await dbconfig.asyncSqlConnect(sql, sqlArr);
    if (user.length != 0) {
        return res.send({
            "status": 411,
            "msg": "该邮箱已被注册"
        })
        return
    }

    password = bcrypt.hashSync(password, 10);

    sql = 'insert into pk_user(username,email,password) values(?,?,?)';
    sqlArr = [username, email, password];

    let rst = await dbconfig.asyncSqlConnect(sql, sqlArr);

    // //console.log("rst", rst);

    if (rst.affectedRows == 1) {
        return res.send({
            "status": 200,
            "msg": "注册成功",
        })
    } else {
        return res.send({
            "status": 500,
            "msg": "注册失败",
        })
    }

}

createOne = async (req, res) => {
    //console.log("createUserinfo");

    let { username, email, password, is_man, avatar } = req.body;
    let u_nameRst = await getByParams({ key: 'email', value: email });
    if (u_nameRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": "该邮箱已被注册"
        });
        return;
    }

    let sql =
        'insert into pk_user(username, email,password,is_man,avatar) '
        + 'values(?,?,?,?,?)';

    let sqlArr = [username, email, password, is_man, avatar];
    callback = (err, data) => {
        if (err) {
            //console.log("error", err.message)
            return res.send({
                "status": 402,
                'msg': "添加失败"
            });
        } else {
            //console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "添加成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

updateOne = (req, res) => {
    //console.log("updateUserinfoByID", req.body);
    let { username, type_id, u_tag, u_imgSrc, u_VGA, u_style, u_initials, u_playtime, /*u_quarter,*/ u_years, u_actors, u_summary, user_id } = req.body;

    let sql = 'update pk_user set username=?,type_id=?,u_tag=?,u_imgSrc=?,u_VGA=?,u_style=?,u_initials=?,u_playtime=?,u_years=?,u_actors=?,u_summary=? where user_id=?';
    let sqlArr = [username, type_id, u_tag, u_imgSrc, u_VGA, u_style, u_initials, u_playtime, /*u_quarter,*/ u_years, u_actors, u_summary, user_id];

    callback = (err, data) => {
        if (err) {
            //console.log("error", err.message)
            return res.send({
                "status": 402,
                'msg': "更新失败"
            });
        } else {
            //console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "更新成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

getInfos = async (req, res) => {
    let sql = 'select username,email,is_man,avatar,create_time from pk_user where user_id=?';
    let sqlArr = [req.user_id];
    let userRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    console.log(userRst, "userRst");
    return res.send({
        "code": 1,
        "user": userRst[0]
    })
}

updateInfos = (req, res) => {
    //console.log("req", req.body);
    let { username, is_man, avatar } = req.body;

    let sql = 'update pk_user set username=?,is_man=?,avatar=? where user_id=?';
    let sqlArr = [username, is_man, avatar, req.user_id];

    callback = (err, data) => {
        if (err) {
            //console.log("error", err.message)
            return res.send({
                "status": 402,
                'msg': "更新失败"
            });
        } else {
            //console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "更新成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

getUserinfo = (req, res) => {
    let sql = 'select username,avatar from pk_user where user_id=?';
    let sqlArr = [req.user_id];
    //console.log("sqlArr", sqlArr);

    callback = (err, data) => {
        if (err) {
            //console.log("error", err.message)
        } else {
            //console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "更新成功",
                "user": data[0]
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

getByID = async (user_id) => {
    let sql = 'select user_id,username,avatar from pk_user where user_id=?';
    let sqlArr = [user_id];
    let userRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return userRst.length == 0 ? null : JSON.parse(JSON.stringify(userRst[0]));
}

module.exports = {
    getAll, login, createOne, updateOne, sendCaptcha, register, getInfos, updateInfos, getUserinfo,getByID
}