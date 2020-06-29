let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

let getAll = async (req, res) => {
    let sql = 'select reporting_id,comment_id,user_id from pk_reporting';
    let sqlArr = [];

    let reportRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let length = reportRst.length;
    for(let i=0; i<length; i++){
        sql = 'select content,user_id from pk_comment where comment_id=?'
        sqlArr = [reportRst[i].comment_id];
        let commentRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        reportRst[i].content = commentRst[0].content;
        sql = 'select user_id,username from pk_user where user_id=?'
        sqlArr = [commentRst[0].user_id];
        let commentatorRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        reportRst[i].commentator = commentatorRst[0];
        sqlArr = [reportRst[i].user_id]
        let whistleblowerRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        reportRst[i].whistleblower = whistleblowerRst[0];
        delete reportRst[i].user_id;
    }
    
    console.log("reportRst", reportRst);
    return res.send({
        'list': reportRst
    })
}

let deleteOne = (req, res) => {
    //console.log("deleteReportID")
    let reporting_id = req.params.id;
    let sql = 'delete from pk_reporting where reporting_id=?';
    let sqlArr = [reporting_id];

    callback = (err, data) => {
        if (err) {
            //console.log("error", err.message)
            return res.send({
                "status": 402,
                'msg': "解除失败"
            });
        } else {
            //console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "解除成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

let deleteByCommentID = async (comment_id) => {
    let sql = 'delete from pk_reporting where comment_id=?';
    let sqlArr = [comment_id];

    await dbconfig.asyncSqlConnect(sql, sqlArr);
}
module.exports = {
    getAll, deleteOne, deleteByCommentID
}