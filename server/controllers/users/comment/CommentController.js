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
    console.log("obj.key",obj.key);
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
    res.send(result);
}

let getAll = (req, res) => {
    console.log("getCommentAll");
    let {v_id,t_id} = req.query;
    console.log("reqQuery", req.query);
    let sql = 'select c_id,c_uname,c_uid,c_uavatar,c_content,create_time from pk_comments where v_id=? and t_id=? order by create_time asc';
    let sqlArr = [v_id,t_id];
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

let subComment = (req,res)=>{
    console.log("subComment", );
    console.log("req.body", req.body);
    let {c_uid,v_id,t_id,c_content,c_uname,c_uavatar} = req.body;
    let sql = 'insert into pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) values(?,?,?,?,?,?)';
    let sqlArr = [c_uid,v_id,t_id,c_content,c_uname,c_uavatar];

    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            res.send({
                "status": 402,
                'msg': "发布失败"
            });
        } else {
            console.log("操作成功");
            res.send({
                "status": 200,
                "msg": "发布成功"
            });
        }
    }

    dbconfig.sqlConnect(sql,sqlArr,callback);
}

// let updateOne = (req, res) => {
//     console.log("updateCommentByID")
//     let { b_name, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary, v_id } = req.body;

//     sql = 'update pk_comments set b_name=?,b_imgSrc=?,b_episodes=?,b_status=?,b_style=?,b_initials=?,b_playtime=?,b_quarter=?,b_years=?,b_actors=?,b_summary=? where v_id=?';
//     sqlArr = [b_name, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary, v_id];

//     callback = (err, data) => {
//         if (err) {
//             console.log("操作出错")
//             res.send({
//                 "status": 402,
//                 'msg': "更新失败"
//             });
//         } else {
//             console.log("操作成功");
//             res.send({
//                 "status": 200,
//                 "msg": "更新成功"
//             });
//         }
//     }

//     dbconfig.sqlConnect(sql, sqlArr, callback);
// }

let deleteOne = (req, res) => {
    console.log("deleteCommentByID")
    let c_id = req.params.id;
    console.log("c_id", req.params);
    let sql = 'delete from pk_comments where c_id=?';
    let sqlArr = [c_id];

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
    getAll, getOne, createOne, updateOne, deleteOne,subComment
}