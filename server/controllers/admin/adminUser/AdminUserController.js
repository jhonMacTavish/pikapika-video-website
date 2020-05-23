let dbconfig = require('../../../util/dbconfig');
let { secretkey } = require('../../../util/secretkey');
let bcrypt = require('bcrypt');
let jwt = require('jsonwebtoken');

let getByParams = async (obj) => {
    console.log(`getBy${obj.key}`);
    let sql = `select * from pk_admin where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    console.log("getUserinfoByID");
    let a_id = req.params.id;
    let sql = 'select a_name,a_email from pk_admin where a_id=?';
    let sqlArr = [a_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // console.log("userRst", result);
    return res.send(result);
}

getAll = (req, res) => {
    console.log("getUserinfoAll")
    let sql = 'select a_id,a_name,a_email,create_time from pk_admin order by a_id asc';
    let sqlArr = [];
    let callback = (err, data) => {
        if (err) {
            console.log("操作出错");
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // console.log("getAll", data);
            console.log("操作成功");
            return res.send({
                "list": data,
                "status": 200,
                "msg": "信息获取成功"
            })
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

createOne = async (req, res) => {
    console.log("createAdminUser");

    let { a_name, a_email, a_password } = req.body;
    console.log("adminuser", req.body);
    a_password = bcrypt.hashSync(a_password, 10);

    let a_nameRst = await getByParams({ key: 'a_email', value: a_email });
    if (a_nameRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": "该邮箱已被注册"
        });
    }

    let sql =
        'insert into pk_admin(a_name, a_email,a_password) '
        + 'values(?,?,?)';

    let sqlArr = [a_name, a_email, a_password];
    console.log("sql", sql);
    console.log("sqlArr", sqlArr);

    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            return res.send({
                "status": 402,
                'msg': "添加失败"
            });
        } else {
            console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "添加成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

updateOne = (req, res) => {
    console.log("updateUserinfoByID", req.body);
    let { a_password, a_name, a_email } = req.body;
    let a_id = req.params.id;
    console.log("id", a_id);
    sql = `update pk_admin set ${a_password ? 'a_password=?,' : ''}a_name=?,a_email=? where a_id=?`;
    console.log("sql", sql);
    sqlArr = [a_name, a_email, a_id];
    if (a_password) {
        a_password = bcrypt.hashSync(a_password, 10);
        sqlArr.unshift(a_password);
    }
    console.log("sqlArr", sqlArr);

    callback = (err, data) => {
        if (err) {
            console.log("err", err);
            console.log("操作出错")
            return res.send({
                "status": 402,
                'msg': "更新失败"
            });
        } else {
            console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "更新成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

deleteOne = async (req, res) => {
    console.log("deleteUserinfoByID")
    let a_id = req.params.id;
    let sql = 'delete from pk_admin where a_id=?';
    let sqlArr = [a_id];
    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);

    if (result.affectedRows == 1) {
        sql = 'delete from pk_admin where a_id=?';
        sqlArr = [a_id];

        callback = (err, data) => {
            if (err) {
                console.log("操作出错")
                return res.send({
                    "status": 402,
                    'msg': "删除失败"
                });
            } else {
                console.log("操作成功");
                return res.send({
                    "status": 200,
                    "msg": "删除成功"
                });
            }
        }

        dbconfig.sqlConnect(sql, sqlArr, callback);
        return
    } else {
        return res.send({
            "status": 402,
            'msg': "该管理员不存在"
        });
    }
}

login = async (req, res) => {
    console.log("login");
    let { a_email, a_password } = req.body.params;

    let sql = 'select a_password from pk_admin where a_email=?';
    let sqlArr = [a_email];

    let userPsw = await dbconfig.asyncSqlConnect(sql, sqlArr);

    if (userPsw.length == 0) {
        return res.send({
            "status": 411,
            "msg": "账号不存在"
        })
    }

    let isValid = bcrypt.compareSync(a_password, userPsw[0].a_password);
    if (!isValid) {
        return res.send({
            "status": 401,
            "msg": "密码错误"
        })
    }

    sql = 'select a_id,a_name,super_admin from pk_admin where a_email=?';
    sqlArr = [a_email];

    let userRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let token = jwt.sign({ a_id: userRst[0].a_id }, secretkey);

    let { a_name, super_admin } = userRst[0];
    let user = { token, a_name, super_admin };
    return res.send({
        "status": 200,
        "msg": "登陆成功",
        "user": user
    })
}

getByID = async (a_id) => {
    console.log("getAdminUserByID");
    let sql = 'select a_id,a_name,a_email,super_admin from pk_admin where a_id=?';
    let sqlArr = [a_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    console.log("userRst", result.length);
    return result.length == 0 ? null : JSON.parse(JSON.stringify(result[0]));
}

verifyToken = async (req,res)=>{
    
}

module.exports = {
    getByID, getAll, getOne, createOne, updateOne, deleteOne, login, verifyToken
}