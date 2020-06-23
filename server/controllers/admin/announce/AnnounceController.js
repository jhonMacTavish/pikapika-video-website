let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

let getByParams = async (obj, obj2) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_announce where ${obj.key}=? and ${obj2.key}=?`;
    let sqlArr = [obj.value, obj2.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getAll = async (req, res) => {
    //console.log("getAnnounces")
    let sql = 'select announce_id,title,content,create_time,admin_id from pk_announce';
    let sqlArr = [];

    let AnnounceRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let length = AnnounceRst.length;
    for (let i = 0; i < length; i++) {
        sql = 'select adminname from pk_admin where admin_id=?';
        sqlArr = [AnnounceRst[i].admin_id];
        let adminnameRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        AnnounceRst[i].adminname = adminnameRst[0].adminname;
    }
    return res.send({
        'list': AnnounceRst
    })
}

let createOne = async (req, res) => {
    //console.log("createAnnounces");
    let { title, content } = req.body;
    let sql =
        'insert into pk_announce(title,content,admin_id) '
        + 'values(?,?,?)';

    let sqlArr = [title, content, req.admin_id];
    callback = (err, data) => {
        if (err) {
            console.error("error", err.message);
            return res.send({
                "status": 402,
                'msg': "添加失败"
            });
        } else {
            //console.log("操作成功");
            //console.log("data", data.insertId);
            return res.send({
                "status": 200,
                "msg": "添加成功",
                "announce_id": data.insertId
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

let updateOne = (req, res) => {
    let { title, content } = req.body;
    let announce_id = req.params.id;
    sql = 'update pk_announce set title=?,content=? where announce_id=?';
    sqlArr = [title, content, announce_id];

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

let deleteOne = (req, res) => {
    //console.log("deleteAnnouncesID")
    let announce_id = req.params.id;
    let sql = 'delete from pk_announce where announce_id=?';
    let sqlArr = [announce_id];

    callback = (err, data) => {
        if (err) {
            //console.log("error", err.message)
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

let getOne = async (req, res) => {
    //console.log("getOne***********************************");
    let announce_id = req.params.id;
    let sql = 'select title,content from pk_announce where announce_id=?';
    let sqlArr = [announce_id];
    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send({
        "list": result
    });
}

module.exports = {
    getOne, getAll, createOne, updateOne, deleteOne
}