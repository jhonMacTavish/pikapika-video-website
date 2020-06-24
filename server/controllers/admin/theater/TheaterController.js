let dbconfig = require('../../../util/dbconfig');

let getByParams = async (obj) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_theater where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    //console.log("getTheaterByID")
    let film_id = req.params.id
    let sql = 'select theater_id as film_id,name,searchUrl,type_id,tag,imgSrc,VGA,style,initials,playtime,years,actors,summary from pk_theater where theater_id=?';
    let sqlArr = [film_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send(result);
}

getAll = (req, res) => {
    //console.log("getTheaterAll")
    let sql = 'select theater_id as film_id,name,tag,style,playtime from pk_theater order by create_time desc';
    let sqlArr = [];
    let callback = (err, data) => {
        if (err) {
            console.error("error",err.message);
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // //console.log("getAll", data);
            //console.log("操作成功");
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
    //console.log("createTheater");

    let { searchUrl,name, type_id, tag, imgSrc, VGA, style, initials, playtime,   years, actors, summary } = req.body;
    let nameRst = await getByParams({ key: 'name', value: name });
    if (nameRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": "数据库中存在同名电影"
        });
        return;
    }

    let sql =
        'insert into pk_theater(searchUrl,name,type_id,tag,imgSrc,VGA,style,initials,playtime,years,actors,summary,admin_id) '
        + 'values(?,?,?,?,?,?,?,?,?,?,?,?,?)';

    let sqlArr = [searchUrl,name, type_id, tag, imgSrc, VGA, style, initials, playtime,   years, actors, summary, req.admin_id];
    callback = (err, data) => {
        if (err) {
            //console.log("error",err.message)
            return res.send({
                "status": 402,
                'msg': "添加失败"
            });
        } else {
            //console.log("操作成功");
            //console.log("data", data.insertId);
            return res.send({
                "status": 200,
                "msg": "添加成功",
                "film_id": data.insertId
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

updateOne = (req, res) => {
    //console.log("updateTheaterByID");
    let { searchUrl,name, type_id, tag, imgSrc, VGA, style, initials, playtime,   years, actors, summary, film_id } = req.body;

    let sql = 'update pk_theater set searchUrl=?,name=?,type_id=?,tag=?,imgSrc=?,VGA=?,style=?,initials=?,playtime=?,years=?,actors=?,summary=?,admin_id=? where theater_id=?';
    let sqlArr = [searchUrl,name, type_id, tag, imgSrc, VGA, style, initials, playtime,   years, actors, summary, req.admin_id, film_id];

    callback = (err, data) => {
        if (err) {
            console.log("error",err.message)
            return res.send({
                "status": 402,
                'msg': "更新失败"
            });
        } else {
            //console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "更新成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

deleteOne = (req, res) => {
    //console.log("deleteTheaterByID")
    let film_id = req.params.id;
    //console.log("film_id", req.params);
    let sql = 'delete from pk_theater where theater_id=?';
    let sqlArr = [film_id];
    callback = (err, data) => {
        if (err) {
            //console.log("error",err.message)
            return res.send({
                "status": 402,
                'msg': "删除失败"
            });
        } else {
            //console.log("操作成功");
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