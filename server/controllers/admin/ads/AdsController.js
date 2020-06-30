let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

let getByParams = async (obj, obj2) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_advertising where ${obj.key}=? and ${obj2.key}=?`;
    let sqlArr = [obj.value, obj2.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getAll = async (req, res) => {
    //console.log("getAds")
    let sql = 'select ad_id,brand,imgSrc,url from pk_advertising';
    let sqlArr = [];

    let adRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send({
        'list': adRst
    })
}

let createOne = async (req, res) => {
    let { brand, url, imgSrc } = req.body;

    let adRst = await getByParams({ key: 'brand', value: brand }, { key: 'url', value: url });
    // if (adRst.length != 0) {
    //     return res.send({
    //         "status": 402,
    //         "msg": `数据库中存在"${brand}"的该url广告`
    //     });
    // }
    let sql =
        'insert into pk_advertising(brand,url,imgSrc,admin_id) '
        + 'values(?,?,?,?)';

    let sqlArr = [brand, url, imgSrc, req.admin_id];
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
                "ad_id": data.insertId
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

let updateOne = (req, res) => {
    let { brand, url, imgSrc,ad_id } = req.body;

    sql = 'update pk_advertising set brand=?,url=?,imgSrc=? where ad_id=?';
    sqlArr = [brand, url, imgSrc,ad_id];

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
    //console.log("deleteAdsID")
    let ad_id = req.params.id;
    let sql = 'delete from pk_advertising where ad_id=?';
    let sqlArr = [ad_id];

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
    let ad_id = req.params.id;
    //console.log("type_id", ad_id);
    let sql = 'select brand,imgSrc,url from pk_advertising where ad_id=?';
    let sqlArr = [ad_id];
    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send(result);
}

module.exports = {
    getOne, getAll, createOne, updateOne, deleteOne
}