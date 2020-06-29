let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

// getByName = async (name) => {
//     let sql = 'select * from pk_bangumi where name=?';
//     let sqlArr = [name];

//     let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
//     return result;
// }

// let obj = {
//     key:'name',
//     value:'苍之彼方的四重奏'
// }

let getByParams = async (obj) => {
    //console.log(`getBangumiBy${obj.key}`);
    //console.log("obj.key", obj.key);
    let sql = `select * from pk_bangumi where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getOne = async (req, res) => {
    //console.log("getBangumiByID");
    let film_id = req.params.id
    let sql = 'select bangumi_id as film_id,name,searchUrl,type_id,imgSrc,is_ended,style,initials,playtime,quarter,years,actors,summary from pk_bangumi where bangumi_id=?';
    let sqlArr = [film_id];
    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);

    result[0].episodes = await util.countEp(1, film_id);
    // //console.log("result", result);
    return res.send(result);
}

let getAll = (req, res) => {
    //console.log("getBangumiAll")
    let sql = 'select bangumi_id as film_id,name,is_ended,style,playtime from pk_bangumi order by create_time desc';
    let sqlArr = [];
    let callback = async (err, data) => {
        if (err) {
            console.error("error", err.message);
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // //console.log("getAll", data);
            //console.log("操作成功");
            let type_id = 1;
            for (let i = 0; i < data.length; i++) {
                let film_id = data[i].film_id;
                data[i].episodes = await util.countEp(type_id, film_id);
            }
            // //console.log("data", data);
            return res.send({
                "list": data,
                "status": 200,
                "msg": "信息获取成功"
            })
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

let createOne = async (req, res) => {
    //console.log("createBangumi");

    let { searchUrl, name, type_id, imgSrc, is_ended, style, initials, playtime, quarter, years, actors, summary, weekday } = req.body;
    //console.log("name", name);

    let nameRst = await getByParams({ key: 'name', value: name });
    if (nameRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": "数据库中存在同名番剧"
        });
        return;
    }

    let sql =
        'insert into pk_bangumi(searchUrl,name,type_id,imgSrc,is_ended,style,initials,playtime,quarter,years,actors,summary,admin_id,weekday) '
        + 'values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)';

    let sqlArr = [searchUrl, name, type_id, imgSrc, is_ended, style, initials, playtime, quarter, years, actors, summary, req.admin_id, weekday];
    callback = (err, data) => {
        if (err) {
            console.error("error", err.message);
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

let updateOne = (req, res) => {
    console.log("updateBangumiByID")
    let { searchUrl, name, imgSrc, is_ended, style, initials, playtime, quarter, years, actors, summary, film_id } = req.body;
    console.log("name", name.length);
    let sql = 'update pk_bangumi set searchUrl=?,name=?,imgSrc=?,is_ended=?,style=?,initials=?,playtime=?,quarter=?,years=?,actors=?,summary=?,admin_id=? where bangumi_id=?';
    let sqlArr = [searchUrl, name, imgSrc, is_ended, style, initials, playtime, quarter, years, actors, summary, req.admin_id, film_id];

    callback = (err, data) => {
        if (err) {
            console.log("error", err.message)
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

let deleteOne = (req, res) => {
    //console.log("deleteBangumiByID")
    let film_id = req.params.id;
    //console.log("film_id", req.params);
    let sql = 'delete from pk_bangumi where bangumi_id=?';
    let sqlArr = [film_id];

    callback = (err, data) => {
        if (err) {
            //console.log("error", err.message)
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