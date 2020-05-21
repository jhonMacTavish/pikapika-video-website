let dbconfig = require('../../../util/dbconfig');

let getByParams = async (obj) => {
    console.log(`getBy${obj.key}`);
    let sql = `select * from pk_theater where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    console.log("getTheaterByID")
    let v_id = req.params.id
    let sql = 'select * from pk_theater where v_id=?';
    let sqlArr = [v_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send(result);
}

getAll = (req, res) => {
    console.log("getTheaterAll")
    let sql = 'select v_id,th_name,th_tag,th_style,th_playtime from pk_theater order by th_name asc';
    let sqlArr = [];
    let callback = (err, data) => {
        if (err) {
            console.log("操作出错");
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // console.log("getAll", data);
            console.log("操作成功");
            return res.send({
                "list": data,
                "status": 200,
                "msg": "信息获取成功"
            })
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

createOne = async (req, res) => {
    console.log("createTheater");

    let { th_name, t_id, th_tag, th_imgSrc, th_VGA, th_style, th_initials, th_playtime, /*th_quarter,*/ th_years, th_actors, th_summary } = req.body;
    let th_nameRst = await getByParams({ key: 'th_name', value: th_name });
    if (th_nameRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": "数据库中存在同名国漫"
        });
        return;
    }

    let sql =
        'insert into pk_theater(th_name,t_id,th_tag,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary) '
        + 'values(?,?,?,?,?,?,?,?,?,?,?)';

    let sqlArr = [th_name, t_id, th_tag, th_imgSrc, th_VGA, th_style, th_initials, th_playtime, /*th_quarter,*/ th_years, th_actors, th_summary];
    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            return res.send({
                "status": 402,
                'msg': "添加失败"
            });
        } else {
            console.log("操作成功");
            console.log("data", data.insertId);
            return res.send({
                "status": 200,
                "msg": "添加成功",
                "v_id": data.insertId
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

updateOne = (req, res) => {
    console.log("updateTheaterByID");
    let { th_name, t_id, th_tag, th_imgSrc, th_VGA, th_style, th_initials, th_playtime, /*th_quarter,*/ th_years, th_actors, th_summary, v_id } = req.body;

    sql = 'update pk_theater set th_name=?,t_id=?,th_tag=?,th_imgSrc=?,th_VGA=?,th_style=?,th_initials=?,th_playtime=?,th_years=?,th_actors=?,th_summary=? where v_id=?';
    sqlArr = [th_name, t_id, th_tag, th_imgSrc, th_VGA, th_style, th_initials, th_playtime, /*th_quarter,*/ th_years, th_actors, th_summary, v_id];

    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            return res.send({
                "status": 402,
                'msg': "更新失败"
            });
        } else {
            console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "更新成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

deleteOne = (req, res) => {
    console.log("deleteTheaterByID")
    let v_id = req.params.id;
    console.log("v_id", req.params);
    let sql = 'delete from pk_theater where v_id=?';
    let sqlArr = [v_id];

    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            return res.send({
                "status": 402,
                'msg': "删除失败"
            });
        } else {
            console.log("操作成功");
            return res.send({
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