let dbconfig = require('../../../util/dbconfig');
let { secretkey } = require('../../../util/secretkey');
let bcrypt = require('bcrypt');
let jwt = require('jsonwebtoken');

let getByParams = async (obj) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_admin where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    //console.log("getUserinfoByID");
    let admin_id = req.params.id;
    let sql = 'select name,email from pk_admin where admin_id=?';
    let sqlArr = [admin_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // //console.log("userRst", result);
    return res.send(result);
}

getAll = (req, res) => {
    let sql = 'select admin_id,name,email,create_time from pk_admin order by admin_id asc';
    let sqlArr = [];
    let callback = (err, data) => {
        if (err) {
            console.error("error",err.message);
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // //console.log("getAll", data);
            //console.log("操作成功");
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
    //console.log("createAdminUser");

    let { name, email, password } = req.body;
    //console.log("adminuser", req.body);
    password = bcrypt.hashSync(password, 10);

    let nameRst = await getByParams({ key: 'email', value: email });
    if (nameRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": "该邮箱已被注册"
        });
    }

    let sql =
        'insert into pk_admin(name, email,password) '
        + 'values(?,?,?)';

    let sqlArr = [name, email, password];
    //console.log("sql", sql);
    //console.log("sqlArr", sqlArr);

    callback = (err, data) => {
        if (err) {
            //console.log("error",err.message)
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
    let { password, name, email } = req.body;
    let admin_id = req.params.id;
    //console.log("id", admin_id);
    sql = `update pk_admin set ${password ? 'password=?,' : ''}name=?,email=? where admin_id=?`;
    //console.log("sql", sql);
    sqlArr = [name, email, admin_id];
    if (password) {
        password = bcrypt.hashSync(password, 10);
        sqlArr.unshift(password);
    }
    //console.log("sqlArr", sqlArr);

    callback = (err, data) => {
        if (err) {
            //console.log("err", err);
            //console.log("error",err.message)
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

deleteOne = async (req, res) => {
    //console.log("deleteUserinfoByID")
    let admin_id = req.params.id;
    let sql = 'delete from pk_admin where admin_id=?';
    let sqlArr = [admin_id];
    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);

    if (result.affectedRows == 1) {
        sql = 'delete from pk_admin where admin_id=?';
        sqlArr = [admin_id];

        callback = (err, data) => {
            if (err) {
                //console.log("error",err.message)
                return res.send({
                    "status": 402,
                    'msg': "删除失败"
                });
            } else {
                //console.log("操作成功");
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
    //console.log("login");
    let { email, password } = req.body.params;

    let sql = 'select password from pk_admin where email=?';
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

    sql = 'select admin_id,name,is_super_admin from pk_admin where email=?';
    sqlArr = [email];

    let userRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let token = jwt.sign({ admin_id: userRst[0].admin_id }, secretkey);

    return res.send({
        "status": 200,
        "msg": "登陆成功",
        "token": token
    })
}

getByID = async (admin_id) => {
    //console.log("getAdminUserByID");
    let sql = 'select name as name,is_super_admin as superAdmin from pk_admin where admin_id=?';
    let sqlArr = [admin_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    //console.log("userRst", result.length);
    return result.length == 0 ? null : JSON.parse(JSON.stringify(result[0]));
}

verifyToken = async (req,res)=>{
    
}

module.exports = {
    getByID, getAll, getOne, createOne, updateOne, deleteOne, login, verifyToken
}