let dbconfig = require('../../../util/dbconfig');
let bcrypt = require('bcrypt');

let getByParams = async (obj) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_user where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    //console.log("getUserinfoByID");
    let user_id = req.params.id;
    let sql = 'select username,email,is_man,avatar,create_time from pk_user where user_id=?';
    let sqlArr = [user_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // //console.log("userRst", result);
    return res.send(result);
}

getAll = (req, res) => {
    //console.log("getUserinfoAll")
    let sql = 'select user_id,username,email,is_man,avatar,is_banned from pk_user order by user_id asc';
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
    //console.log("createUserinfo");

    let { username, email,password,is_man,avatar} = req.body;
    password = bcrypt.hashSync(password,10);

    let u_nameRst = await getByParams({ key: 'email', value: email });
    if (u_nameRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": "该邮箱已被注册"
        });
    }

    let sql =
        'insert into pk_user(username, email,password,is_man,avatar) '
        + 'values(?,?,?,?,?)';
    
    let sqlArr = [username, email,password,is_man,avatar];
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

deleteOne = async (req, res) => {
    //console.log("deleteUserinfoByID")
    let user_id = req.params.id;
    //console.log("user_id", req.params);
    let sql = 'delete from pk_comment where user_id=?';
    let sqlArr = [user_id];
    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);

    sql = 'delete from pk_user where user_id=?';
    sqlArr = [user_id];

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
}

banUser = (req, res) => {
    //console.log("banUserByID");
    let {is_banned} = req.body.params;
    let user_id = req.params.id;
    let sql = 'update pk_user set is_banned=? where user_id=?';
    let sqlArr = [is_banned,user_id];

    callback = (err, data) => {
        if (err) {
            //console.log("error",err.message)
            return res.send({
                "status": 402,
                'msg': "封禁失败"
            });
        } else {
            //console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "封禁成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

module.exports = {
    getAll, getOne, createOne, updateOne, deleteOne,banUser
}