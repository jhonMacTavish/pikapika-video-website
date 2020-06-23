let dbconfig = require('../../../util/dbconfig');
let { secretkey } = require('../../../util/secretkey');
let jwt = require('jsonwebtoken');
var assert = require('http-assert');

let review = async (req, res) => {
    //console.log("subReview");
    let { type_id, film_id, score } = req.body.params;
    //console.log("req.body.params", req.body.params);

    let sql = 'select * from pk_review where type_id=? and film_id=? and user_id=?';
    let sqlArr = [type_id, film_id, req.user_id];

    let reviewRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    if (reviewRst.length) {
        sql = 'update pk_review set score=? where type_id=? and film_id=? and user_id=?';
        sqlArr = [score, type_id, film_id, req.user_id];

        reviewRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        if (reviewRst.affectedRows == 1) {
            return res.send({
                "status": 200,
                "msg": "更新成功"
            })
        } else {
            return res.send({
                "status": 500,
                "msg": "更新失败"
            })
        }
    } else {
        sql = 'insert into pk_review(type_id,film_id,user_id,score) '
            + 'values(?,?,?,?)';
        sqlArr = [type_id, film_id, req.user_id, score];

        reviewRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        if (reviewRst.affectedRows == 1) {
            return res.send({
                "status": 200,
                "msg": "评分成功"
            })
        } else {
            return res.send({
                "status": 500,
                "msg": "评分失败"
            })
        }
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
    let sql = 'select type_id,film_id from pk_review where comment_id=?';
    let sqlArr = [comment_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let { type_id, film_id } = result[0];

    sql = 'delete from pk_review where comment_id=?';
    sqlArr = [comment_id];

    result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    if (result.affectedRows == 1) {
        sql = 'select comment_id,c.user_id as user_id,content,c.create_time as create_time,u.username as username,u.avatar as avatar from pk_review as c,pk_review as u where c.user_id=u.user_id and type_id=? and film_id=? order by create_time desc';
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

let getRate = async (req, res) => {
    let { type_id, film_id } = req.query;

    let sql = 'select count(*) as reviewers,sum(score) as score from pk_review where type_id=? and film_id=?';
    let sqlArr = [type_id, film_id];

    let RateRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let score = RateRst[0].score;
    let reviewers = RateRst[0].reviewers;
    let avgScore = score/reviewers;
    return res.send({
        avgScore,
        reviewers
    })
}


module.exports = {
    review, deleteOne, getRate
}