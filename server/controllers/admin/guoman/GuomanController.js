let dbconfig = require('../../../util/dbconfig');

let getByParams = async (obj) => {
    console.log(`getBy${obj.key}`);
    let sql = `select * from pk_guoman where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    console.log("getGuomanByID", )
    let v_id = req.params.id
    let sql = 'select * from pk_guoman where v_id=?';
    let sqlArr = [v_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    res.send(result);
}

getAll = (req, res) => {
    console.log("getGuomanAll")
    let sql = 'select v_id,g_name,g_episodes,g_style,g_playtime from pk_guoman order by g_name asc';
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
    console.log("createGuoman");

    let { g_name, t_id, g_imgSrc, g_episodes, g_status, g_style, g_initials, g_playtime, /*g_quarter,*/ g_years, g_actors, g_summary } = req.body;
    let g_nameRst = await getByParams({key:'g_name',value:g_name});
    if (g_nameRst.length != 0) {
        res.send({
            "status": 402,
            "msg": "数据库中存在同名国漫"
        });
        return;
    }

    let sql =
        'insert into pk_guoman(g_name,t_id,g_imgSrc,g_episodes,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary) '
        + 'values(?,?,?,?,?,?,?,?,?,?,?)';

    let sqlArr = [g_name, t_id, g_imgSrc, g_episodes, g_status, g_style, g_initials, g_playtime, /*g_quarter,*/ g_years, g_actors, g_summary];
    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            res.send({
                "status": 402,
                'msg': "添加失败"
            });
        } else {
            console.log("操作成功");
            console.log("data", data.insertId);
            res.send({
                "status": 200,
                "msg": "添加成功",
                "v_id": data.insertId
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

updateOne = (req, res) => {
    console.log("updateGuomanByID");
    let { t_id, g_name, g_imgSrc, g_episodes, g_status, g_style, g_initials, g_playtime,/*g_quarter,*/g_years, g_actors, g_summary, v_id } = req.body;

    sql = 'update pk_guoman set t_id=?,g_name=?,g_imgSrc=?,g_episodes=?,g_status=?,g_style=?,g_initials=?,g_playtime=?,g_years=?,g_actors=?,g_summary=? where v_id=?';
    sqlArr = [t_id, g_name, g_imgSrc, g_episodes, g_status, g_style, g_initials, g_playtime,/*g_quarter,*/g_years, g_actors, g_summary, v_id];

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
    console.log("deleteGuomanByID")
    let v_id = req.params.id;
    console.log("v_id", req.params);
    let sql = 'delete from pk_guoman where v_id=?';
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