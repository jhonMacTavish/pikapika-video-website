let dbconfig = require('../../../util/dbconfig');
let { secretkey } = require('../../../util/secretkey');
let jwt = require('jsonwebtoken');
var assert = require('http-assert');

let getAll = async (req, res) => {
    //console.log("getCommentAll");
    // //console.log("req",req.query);
    let token = String(req.headers.authorization || '').split(' ').pop();
    try {
        var { user_id } = jwt.verify(token, secretkey);
    } catch (err) {
        user_id = null
    }
    let { type_id, film_id } = req.query;
    let sql = 'select comment_id,c.user_id as user_id,content,c.create_time as create_time,u.username as username,u.avatar as avatar from pk_comment as c,pk_user as u where c.user_id=u.user_id and type_id=? and film_id=? order by create_time desc';
    let sqlArr = [type_id, film_id];
    let list = await dbconfig.asyncSqlConnect(sql, sqlArr);
    for (let i = 0; i < list.length; i++) {
        if (list[i].user_id == user_id) {
            list[i].deletable = true;
            // list[i].is_praise = 
        } else {
            list[i].deletable = false;
        }
        delete list[i].user_id;

        sql = "select is_praise from pk_praise where comment_id=? and user_id=?";
        sqlArr = [list[i].comment_id, user_id];
        let praiseRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        if (praiseRst.length) {
            list[i].is_praise = praiseRst[0].is_praise;
        }

        sql = "select count(*) as likeNum from pk_praise where comment_id=? and is_praise=1";
        sqlArr = [list[i].comment_id];
        let likeNumRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        list[i].likeNum = likeNumRst[0].likeNum;

        sql = "select count(*) as hateNum from pk_praise where comment_id=? and is_praise=0";
        sqlArr = [list[i].comment_id];
        let hateNumRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        list[i].hateNum = hateNumRst[0].hateNum;
    }
    return res.send({
        "status": 200,
        "list": list
    })
}

let createOne = async (req, res) => {
    //console.log("subComment");
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

    let { type_id, film_id, content } = req.body.params;
    let sql = 'insert into pk_comment(user_id,film_id,type_id,content) '
        + 'values(?,?,?,?)';
    let sqlArr = [user_id, film_id, type_id, content];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    if (result.affectedRows == 1) {
        sql = 'select comment_id,c.user_id as user_id,content,c.create_time as create_time,u.username as username,u.avatar as avatar from pk_comment as c,pk_user as u where c.user_id=u.user_id and type_id=? and film_id=? order by create_time desc';
        sqlArr = [type_id, film_id];
        let list = await dbconfig.asyncSqlConnect(sql, sqlArr);
        for (let i = 0; i < list.length; i++) {
            if (list[i].user_id == user_id) {
                list[i].deletable = true;
            } else {
                list[i].deletable = false;
            }
            delete list[i].user_id;
        }
        return res.send({
            "status": "200",
            "msg": "发布成功",
            "list": list
        })
    } else {
        return res.send({
            "status": "500",
            "msg": "发布失败"
        })
    }
}

let deleteOne = async (req, res) => {
    //console.log("deleteCommentByID")
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
    let comment_id = req.params.id;
    // //console.log("comment_id", req.params);
    let sql = 'select type_id,film_id from pk_comment where comment_id=?';
    let sqlArr = [comment_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let { type_id, film_id } = result[0];

    sql = 'delete from pk_comment where comment_id=?';
    sqlArr = [comment_id];

    result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    if (result.affectedRows == 1) {
        sql = 'select comment_id,c.user_id as user_id,content,c.create_time as create_time,u.username as username,u.avatar as avatar from pk_comment as c,pk_user as u where c.user_id=u.user_id and type_id=? and film_id=? order by create_time desc';
        sqlArr = [type_id, film_id];
        let list = await dbconfig.asyncSqlConnect(sql, sqlArr);
        for (let i = 0; i < list.length; i++) {
            if (list[i].user_id == user_id) {
                list[i].deletable = true;
            } else {
                list[i].deletable = false;
            }
            delete list[i].user_id;
        }
        return res.send({
            "status": 200,
            "msg": "删除成功",
            "list": list
        });
        return
    } else {
        return res.send({
            "status": 500,
            "msg": "删除失败",
        });
    }

}

let report = async (req, res) => {
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

    let { comment_id, reason } = req.body.params;
    let sql = 'select * from pk_reporting where comment_id=?'
    let sqlArr = [comment_id];
    let reportRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    if (reportRst.length) {
        return res.send({
            'status': 200,
            'msg': "举报成功"
        });
    }

    sql = 'insert into pk_reporting(comment_id,user_id,reason) '
        + 'values(?,?,?)';
    sqlArr = [comment_id, user_id, reason];

    reportRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    if (reportRst.affectedRows == 1) {
        return res.send({
            'status': 200,
            'msg': "举报成功"
        });
    } else {
        return res.send({
            'status': 500,
            'msg': "举报失败"
        });
    }
}

let like = async (req, res) => {
    let user_id = req.user_id;
    let { comment_id, is_praise } = req.body.params;

    let sql = "select * from pk_praise where comment_id=? and user_id=?";
    let sqlArr = [comment_id, user_id];
    let likeRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    if (likeRst.length) {
        sql = 'update pk_praise set is_praise=? where comment_id=? and user_id=?';
        is_praise = is_praise == likeRst[0].is_praise ? 2 : is_praise;
        sqlArr = [is_praise, comment_id, user_id];
        likeRst = await dbconfig.asyncSqlConnect(sql, sqlArr);

        sql = "select count(*) as likeNum from pk_praise where comment_id=? and is_praise=1";
        sqlArr = [comment_id];
        let likeNumRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        let likeNum = likeNumRst[0].likeNum;

        sql = "select count(*) as hateNum from pk_praise where comment_id=? and is_praise=0";
        sqlArr = [comment_id];
        let hateNumRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        let hateNum = hateNumRst[0].hateNum;
        return res.send({ "status": 200, "msg": '点赞或点踩成功', is_praise, likeNum, hateNum });
    } else {
        sql = 'insert into pk_praise(user_id,comment_id,is_praise) '
            + 'values(?,?,?)';
        sqlArr = [user_id, comment_id, is_praise];
        likeRst = await dbconfig.asyncSqlConnect(sql, sqlArr);

        sql = "select count(*) as likeNum from pk_praise where comment_id=? and is_praise=1";
        sqlArr = [comment_id];
        let likeNumRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        let likeNum = likeNumRst[0].likeNum;

        sql = "select count(*) as hateNum from pk_praise where comment_id=? and is_praise=0";
        sqlArr = [comment_id];
        let hateNumRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        let hateNum = hateNumRst[0].hateNum;
        return res.send({ "status": 200, "msg": '点赞或点踩成功', is_praise, likeNum, hateNum });
    }
}

module.exports = {
    getAll, createOne, deleteOne, report, like,
}