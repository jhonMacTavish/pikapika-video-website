let dbconfig = require('../../../util/dbconfig');

let getByParams = async (obj) => {
    console.log(`getBy${obj.key}`);
    let sql = `select * from pk_filmTV where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    console.log("getFilmTVByID", )
    let v_id = req.params.id
    let sql = 'select * from pk_filmTV where v_id=?';
    let sqlArr = [v_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    res.send(result);
}

getAll = (req, res) => {
    console.log("getFilmTVAll")
    let sql = 'select v_id,f_name,f_episodes,f_style,f_playtime from pk_filmTV order by f_name asc';
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
    console.log("createFilmTV");

    let { f_name, t_id, f_imgSrc, f_episodes, f_status, f_style, f_initials, f_playtime, /*f_quarter,*/ f_years, f_actors, f_summary } = req.body;
    let f_nameRst = await getByParams({key:'f_name',value:f_name});
    if (f_nameRst.length != 0) {
        res.send({
            "status": 402,
            "msg": "数据库中存在同名国漫"
        });
        return;
    }

    let sql =
        'insert into pk_filmTV(f_name,t_id,f_imgSrc,f_episodes,f_status,f_style,f_initials,f_playtime,f_years,f_actors,f_summary) '
        + 'values(?,?,?,?,?,?,?,?,?,?,?)';

    let sqlArr = [f_name, t_id, f_imgSrc, f_episodes, f_status, f_style, f_initials, f_playtime, /*f_quarter,*/ f_years, f_actors, f_summary];
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
    console.log("updateFilmTV");
    let { t_id, f_name, f_imgSrc, f_episodes, f_status, f_style, f_initials, f_playtime,/*f_quarter,*/f_years, f_actors, f_summary, v_id } = req.body;

    sql = 'update pk_filmTV set t_id=?,f_name=?,f_imgSrc=?,f_episodes=?,f_status=?,f_style=?,f_initials=?,f_playtime=?,f_years=?,f_actors=?,f_summary=? where v_id=?';
    sqlArr = [t_id, f_name, f_imgSrc, f_episodes, f_status, f_style, f_initials, f_playtime,/*f_quarter,*/f_years, f_actors, f_summary, v_id];

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
    console.log("deleteFilmTV")
    let v_id = req.params.id;
    let sql = 'delete from pk_filmTV where v_id=?';
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