let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

let getByParams = async (obj) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_filmtv where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    //console.log("getFilmTVByID")
    let film_id = req.params.id
    let sql = 'select filmtv_id as film_id,name,searchUrl,type_id,imgSrc,is_ended,style,initials,playtime,years,actors,summary from pk_filmtv where filmtv_id=?';
    let sqlArr = [film_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    result[0].episodes = await util.countEp(4, film_id);

    return res.send(result);
}

getAll = (req, res) => {
    //console.log("getFilmTVAll")
    let sql = 'select filmtv_id as film_id,name,is_ended,style,playtime from pk_filmtv order by create_time desc';
    let sqlArr = [];
    let callback = async (err, data) => {
        if (err) {
            console.error("error",err.message);
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // //console.log("getAll", data);
            //console.log("操作成功");
            let type_id = 4;
            for (let i = 0; i < data.length; i++) {
                let film_id = data[i].film_id;
                data[i].episodes = await util.countEp(type_id, film_id);
            }

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
    //console.log("createFilmTV");

    let { searchUrl,name, type_id, imgSrc, is_ended, style, initials, playtime,   years, actors, summary } = req.body;
    let nameRst = await getByParams({ key: 'name', value: name });
    if (nameRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": "数据库中存在同名影视"
        });
        return;
    }

    let sql =
        'insert into pk_filmtv(searchUrl,name,type_id,imgSrc,is_ended,style,initials,playtime,years,actors,summary,admin_id) '
        + 'values(?,?,?,?,?,?,?,?,?,?,?,?)';

    let sqlArr = [searchUrl,name, type_id, imgSrc, is_ended, style, initials, playtime,   years, actors, summary, req.admin_id];
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
    //console.log("updateFilmTV");
    let { searchUrl,type_id, name, imgSrc, is_ended, style, initials, playtime, years, actors, summary, film_id } = req.body;

    let sql = 'update pk_filmtv set searchUrl=?,type_id=?,name=?,imgSrc=?,is_ended=?,style=?,initials=?,playtime=?,years=?,actors=?,summary=?,admin_id=? where filmtv_id=?';
    let sqlArr = [searchUrl,type_id, name, imgSrc, is_ended, style, initials, playtime, years, actors, summary, req.admin_id, film_id];

    callback = (err, data) => {
        if (err) {
            //console.log(err);
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
    //console.log("deleteFilmTV")
    let film_id = req.params.id;
    let sql = 'delete from pk_filmtv where filmtv_id=?';
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