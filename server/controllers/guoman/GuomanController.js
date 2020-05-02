var dbconfig = require('../../util/dbconfig');

getGuomanByName = async (g_name) => {
    var sql = 'select * from pk_guoman where g_name=?';
    var sqlArr = [g_name];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getGuomanByID = async (req, res) => {
    var v_id = req.params.id
    var sql = 'select * from pk_guoman where v_id=?';
    var sqlArr = [v_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    res.send(result);
}

getGuomans = (req, res) => {
    console.log("getGuomans")
    var sql = 'select v_id,g_name,g_episodes,g_style,g_playtime from pk_guoman where t_id=2';
    var sqlArr = [];
    var callback = (err, data) => {
        if (err) {
            console.log("操作出错");
            res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // console.log("getGuomans", data);
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

createGuoman = async (req, res) => {
    console.log("createGuoman");
    // console.log("req", req.body);
    console.log("params", req.body);

    let { g_name, t_id, g_imgSrc, g_episodes, g_status, g_style, g_initials, g_playtime, /*g_quarter,*/ g_years, g_actors, g_summary } = req.body;
    let g_nameRst = await getGuomanByName(g_name);
    if (g_nameRst.length != 0) {
        res.send({
            "status": 402,
            "msg": "数据库中存在同名国漫"
        });
        return;
    }

    var sql =
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
            res.send({
                "status": 200,
                "msg": "添加成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

updateGuoman = (req, res) => {
    console.log("更新数据", req.body);
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

deleteGuoman = (req, res) => {
    console.log("删除数据")
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
    getGuomans, createGuoman, getGuomanByID, updateGuoman, deleteGuoman
}