let dbconfig = require('../../../util/dbconfig');

let getByParams = async (obj) => {
    console.log(`getBy${obj.key}`);
    let sql = `select * from pk_user where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    console.log("getUserinfoByID");
    let u_id = req.params.id;
    let sql = 'select u_name,u_email,u_sex,u_avatar from pk_user where u_id=?';
    let sqlArr = [u_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    res.send(result);
}

getAll = (req, res) => {
    console.log("getUserinfoAll")
    let sql = 'select u_id,u_name,u_email,u_sex,u_avatar from pk_user order by u_id asc';
    let sqlArr = [];
    let callback = (err, data) => {
        if (err) {
            console.log("操作出错");
            res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // console.log("getAll", data);
            console.log("操作成功");
            res.send({
                "list": data,
                "status": 200,
                "msg": "信息获取成功"
            })
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

createOne = async (req, res) => {
    console.log("createUserinfo");

    let { u_name, u_email,u_password,u_sex,u_avatar} = req.body;
    let u_nameRst = await getByParams({ key: 'u_email', value: u_email });
    if (u_nameRst.length != 0) {
        res.send({
            "status": 402,
            "msg": "该邮箱已被注册"
        });
        return;
    }

    let sql =
        'insert into pk_user(u_name, u_email,u_password,u_sex,u_avatar) '
        + 'values(?,?,?,?,?)';

    let sqlArr = [u_name, u_email,u_password,u_sex,u_avatar];
    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            res.send({
                "status": 402,
                'msg': "添加失败"
            });
        } else {
            console.log("操作成功");
            res.send({
                "status": 200,
                "msg": "添加成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

updateOne = (req, res) => {
    console.log("updateUserinfoByID", req.body);
    let { u_name, t_id, u_tag, u_imgSrc, u_VGA, u_style, u_initials, u_playtime, /*u_quarter,*/ u_years, u_actors, u_summary, u_id } = req.body;

    sql = 'update pk_user set u_name=?,t_id=?,u_tag=?,u_imgSrc=?,u_VGA=?,u_style=?,u_initials=?,u_playtime=?,u_years=?,u_actors=?,u_summary=? where u_id=?';
    sqlArr = [u_name, t_id, u_tag, u_imgSrc, u_VGA, u_style, u_initials, u_playtime, /*u_quarter,*/ u_years, u_actors, u_summary, u_id];

    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            res.send({
                "status": 402,
                'msg': "更新失败"
            });
        } else {
            console.log("操作成功");
            res.send({
                "status": 200,
                "msg": "更新成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

deleteOne = (req, res) => {
    console.log("deleteUserinfoByID")
    let u_id = req.params.id;
    console.log("u_id", req.params);
    let sql = 'delete from pk_user where u_id=?';
    let sqlArr = [u_id];

    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            res.send({
                "status": 402,
                'msg': "删除失败"
            });
        } else {
            console.log("操作成功");
            res.send({
                "status": 200,
                "msg": "删除成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

module.exports = {
    getAll, getOne, createOne, updateOne, deleteOne
}