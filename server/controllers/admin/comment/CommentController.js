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
    console.log(`getBangumiBy${obj.key}`);
    console.log("obj.key",obj.key);
    let sql = `select * from pk_comments where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getOne = async (req, res) => {
    console.log("getBangumiByID");
    let v_id = req.params.id
    let sql = 'select * from pk_comments where v_id=?';
    let sqlArr = [v_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    res.send(result);
}

// let format = async (table, v_id, t_id) => {
//     let rst = await getByParams({ key: 'v_id', value: v_id });
//     console.log("formatRst", rst[0]);
//     if (rst[0].t_id != t_id) {
//         let sql = `delete from ${table} where v_id=?`
//         let sqlArr = [v_id];
//         let callback = (err, data) => {
//             if (err) {
//                 console.log("操作出错")
//             } else {
//                 console.log("删除成功");
//             }
//         }
//         dbconfig.sqlConnect(sql, sqlArr, callback);

//         switch (t_id) {
//             case 1:
//                 rst[0].t_id = 1;
//                 console.log("create in pk_comments");

//                 let { b_name, t_id, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary } = rst[0];

//                 let b_nameRst = await getByParams({ key: 'b_name', value: b_name });
//                 if (b_nameRst.length != 0) {
//                     res.send({
//                         "status": 402,
//                         "msg": "数据库中存在同名番剧"
//                     });
//                     return;
//                 }

//                 let sql =
//                     'insert into pk_comments(b_name,t_id,b_imgSrc,b_episodes,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) '
//                     + 'values(?,?,?,?,?,?,?,?,?,?,?,?)';

//                 let sqlArr = [b_name, t_id, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary];
                

//                 break;
//             case 2:
//                 break;
//             case 3:
//                 break;
//             case 4:
//                 break;
//             default:
//                 break;
//         }

//         callback = (err, data) => {
//             if (err) {
//                 console.log("操作出错")
//                 res.send({
//                     "status": 402,
//                     'msg': "修改失败"
//                 });
//             } else {
//                 console.log("操作成功");
//                 res.send({
//                     "status": 200,
//                     "msg": "修改成功"
//                 });
//             }
//         }

//         dbconfig.sqlConnect(sql, sqlArr, callback)
//     }
// }

// format('pk_guoman', 4, 1);

let getAll = (req, res) => {
    console.log("getCommentAll");
    let {v_id,t_id} = req.query;
    console.log("reqQuery", req.query);
    let sql = 'select c_uid,c_uavatar,c_content,create_time from pk_comments where v_id=? and t_id=? order by create_time asc';
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

let createOne = async (req, res) => {
    console.log("createBangumi");

    let { b_name, t_id, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary } = req.body;
    console.log("b_name", b_name);

    let b_nameRst = await getByParams({ key: 'b_name', value: b_name });
    if (b_nameRst.length != 0) {
        res.send({
            "status": 402,
            "msg": "数据库中存在同名番剧"
        });
        return;
    }

    let sql =
        'insert into pk_comments(b_name,t_id,b_imgSrc,b_episodes,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) '
        + 'values(?,?,?,?,?,?,?,?,?,?,?,?)';

    let sqlArr = [b_name, t_id, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary];
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

let updateOne = (req, res) => {
    console.log("updateBangumiByID")
    let { b_name, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary, v_id } = req.body;

    sql = 'update pk_comments set b_name=?,b_imgSrc=?,b_episodes=?,b_status=?,b_style=?,b_initials=?,b_playtime=?,b_quarter=?,b_years=?,b_actors=?,b_summary=? where v_id=?';
    sqlArr = [b_name, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary, v_id];

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

let deleteOne = (req, res) => {
    console.log("deleteBangumiByID")
    let v_id = req.params.id;
    console.log("v_id", req.params);
    let sql = 'delete from pk_comments where v_id=?';
    let sqlArr = [v_id];

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