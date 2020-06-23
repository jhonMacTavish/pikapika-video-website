let dbconfig = require('../../../util/dbconfig');
let Report = require('../report/ReportController');

let getByParams = async (obj) => {
    //console.log(`getCommentBy${obj.key}`);
    //console.log("obj.key",obj.key);
    let sql = `select * from pk_comment where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getOne = async (req, res) => {
    //console.log("getCommentByID");
    let film_id = req.params.id
    let sql = 'select * from pk_comment where film_id=?';
    let sqlArr = [film_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send(result);
}

let getAll = async (req, res) => {
    //console.log("getCommentAll");
    let {film_id,type_id} = req.query;
    //console.log("reqQuery", req.query);
    let sql = 'select comment_id,user_id,content,create_time from pk_comment where film_id=? and type_id=? order by create_time desc';
    let sqlArr = [film_id,type_id];

    let commentRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    for(let i=0; i<commentRst.length; i++){
        sql = 'select username as c_uname,avatar as c_uavatar from pk_user where user_id=?'
        sqlArr = [commentRst[i].user_id];
        let userRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        commentRst[i].c_uname = userRst[0].c_uname;
        commentRst[i].c_uavatar = userRst[0].c_uavatar;
    }
    return res.send({
        "status":200,
        "list":commentRst
    })
}

let deleteOne = async (req, res) => {
    //console.log("deleteCommentByID")
    let comment_id = req.params.id;
    //console.log("comment_id", req.params);
    await Report.deleteByCommentID(comment_id);

    let sql = 'delete from pk_comment where comment_id=?';
    let sqlArr = [comment_id];

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

let deleteByVideo = (req, res) => {
    //console.log("deleteCommentByVideo");
    let{type_id,film_id} = req.query;
    let sql = 'delete from pk_comment where type_id=? and film_id=?';
    let sqlArr = [type_id,film_id];

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

module.exports = {
    getAll, getOne, deleteOne, deleteByVideo
}