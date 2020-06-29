let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

let getByParams = async (obj, obj2) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_carousel where ${obj.key}=? and ${obj2.key}=?`;
    let sqlArr = [obj.value, obj2.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getUpdatingFilms = async (req, res) => {
    //console.log("getUpdatingFilms");
    let type_id = req.params.id;
    //console.log("type_id", type_id);
    let sql = '';
    switch (type_id) {
        case '1':
            sql = 'select bangumi_id as film_id,name from pk_bangumi where is_ended=0';
            break;
        case '2':
            sql = 'select guoman_id as film_id,name from pk_guoman where is_ended=0';
            break;
        default:
            break;
    }
    let sqlArr = [];
    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send({
        "list": result
    });
}

let getAll = async (req, res) => {
    //console.log("getCarousel")
    let sql = 'select carousel_id,type_id,film_id,episode,imgSrc from pk_carousel';
    let sqlArr = [];

    let carouselRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let length = carouselRst.length;
    for (let i = 0; i < length; i++) {
        if (carouselRst[i].type_id == 1) {
            sql = 'select name from pk_bangumi where type_id=? and bangumi_id=?';
            sqlArr = [carouselRst[i].type_id, carouselRst[i].film_id];
            let nameRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
            carouselRst[i].name = nameRst[0].name
            delete carouselRst[i].film_id;
        } else if (carouselRst[i].type_id == 2) {
            sql = 'select name from pk_guoman where type_id=? and guoman_id=?';
            sqlArr = [carouselRst[i].type_id, carouselRst[i].film_id];
            let nameRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
            carouselRst[i].name = nameRst[0].name
            delete carouselRst[i].film_id;
        }
    }
    return res.send({
        'list': carouselRst
    })
}

let createOne = async (req, res) => {
    //console.log("createCarousel");

    let { type_id, film_id, episode, imgSrc } = req.body;

    let carouselRst = await getByParams({ key: 'film_id', value: film_id }, { key: 'type_id', value: type_id });
    if (carouselRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": `数据库中存在该${type_id == 1 ? "番剧" : "国漫"}的轮播图`
        });
    }

    let sql = 'select * from pk_resource where type_id=? and film_id=? and episode=?';
    let sqlArr = [type_id, film_id, episode];
    let resourceRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    //console.log("resourceRst", resourceRst);
    if (resourceRst.length == 0) {
        if (type_id == 1) {
            sql = 'select name from pk_bangumi where type_id=? and bangumi_id=?';
        } else if (type_id == 2) {
            sql = 'select name from pk_guoman where type_id=? and guoman_id=?';
        }
        sqlArr = [type_id, film_id,];
        let filmRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        return res.send({
            "status": 402,
            "msg": `请先添加${type_id == 1 ? "番剧" : "国漫"}:"${filmRst[0].name}" 第${episode}${type_id == 1 ? "话" : "集"}的视频资源`
        });
    }



    sql =
        'insert into pk_carousel(type_id,film_id,episode,imgSrc,admin_id) '
        + 'values(?,?,?,?,?)';

    sqlArr = [type_id, film_id, episode, imgSrc, req.admin_id];
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
                "carousel_id": data.insertId
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

let updateOne = (req, res) => {
    //console.log("updateBangumiByID")
    let { type_id, film_id, episode, imgSrc } = req.body;

    let sql = 'update pk_carousel set imgSrc=? where type_id=? and film_id=? and episode=?';
    let sqlArr = [imgSrc, type_id, film_id, episode];

    callback = (err, data) => {
        if (err) {
            //console.log("error", err.message)
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
    //console.log("deleteCarouselID")
    let carousel_id = req.params.id;
    //console.log("carousel_id", req.params);
    let sql = 'delete from pk_carousel where carousel_id=?';
    let sqlArr = [carousel_id];

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

let removeCsl = (req, res) => {
    let {type_id,film_id} = req.query;
    let sql = 'delete from pk_carousel where type_id=? and film_id=?';
    let sqlArr = [type_id,film_id];

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

let getOne = async (req, res) => {
    let carousel_id = req.params.id;
    //console.log("carousel_id", carousel_id);
    let sql = 'select type_id,film_id,episode,imgSrc from pk_carousel where carousel_id=?';
    let sqlArr = [carousel_id];
    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    if (result[0].type_id == 1) {
        sql = 'select name from pk_bangumi where type_id=? and bangumi_id=?';
        sqlArr = [result[0].type_id, result[0].film_id];
        let nameRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        //console.log("nameRst", nameRst);
        var filmNames = [
            { film_id: result[0].film_id, name: nameRst[0].name }
        ]
    }
    return res.send({
        "list": result,
        "filmNames": filmNames
    });
}

module.exports = {
    getOne, getAll, getUpdatingFilms, createOne, updateOne, deleteOne, removeCsl
}