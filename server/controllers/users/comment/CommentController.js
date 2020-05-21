let dbconfig = require('../../../util/dbconfig');

// getByName = async (b_name) => {
//     let sql = 'select * from pk_comments where b_name=?';
//     let sqlArr = [b_name];

//     let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
//     return result;
// }

// let obj = {
//     key:'b_name',
//     value:'苍之彼方的四重奏'
// }

let getByParams = async (obj) => {
    console.log(`getCommentBy${obj.key}`);
    console.log("obj.key", obj.key);
    let sql = `select * from pk_comments where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getOne = async (req, res) => {
    console.log("getCommentByID");
    let v_id = req.params.id
    let sql = 'select * from pk_comments where v_id=?';
    let sqlArr = [v_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send(result);
}

let getAll = async (req, res) => {
    console.log("getCommentAll");
    // console.log("req",req.query);

    let {t_id,v_id} = req.query;
    let sql = 'select * from pk_comments where t_id=? and v_id=? order by create_time desc';
    let sqlArr = [t_id,v_id];
    let list = await dbconfig.asyncSqlConnect(sql, sqlArr);

    return res.send({
        "status": 200,
        "list": list
    })
}

let createOne = async (req, res) => {
    console.log("subComment");
    // console.log("params", req.body.params);
    let { c_uid, v_id, t_id, c_content, c_uname, c_uavatar } = req.body.params;
    if (!c_content) {
        return res.send({
            "status": 422,
            "msg": "你还没有评论"
        })
        return
    }

    let sql = 'insert into pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) '
        + 'values(?,?,?,?,?,?)';
    let sqlArr = [c_uid, v_id, t_id, c_content, c_uname, c_uavatar];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    console.log("result", result);
    if (result.affectedRows == 1) {
        sql = 'select * from pk_comments where t_id=? and v_id=? order by create_time desc';
        sqlArr = [t_id,v_id];
        let list = await dbconfig.asyncSqlConnect(sql, sqlArr);
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

// let updateOne = (req, res) => {
//     console.log("updateCommentByID")
//     let { b_name, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary, v_id } = req.body;

//     sql = 'update pk_comments set b_name=?,b_imgSrc=?,b_episodes=?,b_status=?,b_style=?,b_initials=?,b_playtime=?,b_quarter=?,b_years=?,b_actors=?,b_summary=? where v_id=?';
//     sqlArr = [b_name, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary, v_id];

//     callback = (err, data) => {
//         if (err) {
//             console.log("操作出错")
//             return res.send({
//                 "status": 402,
//                 'msg': "更新失败"
//             });
//         } else {
//             console.log("操作成功");
//             return res.send({
//                 "status": 200,
//                 "msg": "更新成功"
//             });
//         }
//     }

//     dbconfig.sqlConnect(sql, sqlArr, callback);
// }

let deleteOne = async (req, res) => {
    console.log("deleteCommentByID")
    let c_id = req.params.id;
    // console.log("c_id", req.params);
    let sql = 'select t_id,v_id from pk_comments where c_id=?';
    let sqlArr = [c_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let {t_id,v_id} = result[0];

    sql = 'delete from pk_comments where c_id=?';
    sqlArr = [c_id];

    result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // console.log(t_id,v_id);

    if (result.affectedRows == 1) {
        sql = 'select * from pk_comments where t_id=? and v_id=? order by create_time desc';
        sqlArr = [t_id,v_id];
        let list = await dbconfig.asyncSqlConnect(sql, sqlArr);
        return res.send({
            "status":200,
            "msg":"删除成功",
            "list":list
        });
        return
    }else{
        return res.send({
            "status":500,
            "msg":"删除失败",
        });
    }

}

module.exports = {
    getAll, getOne, createOne, updateOne, deleteOne
}