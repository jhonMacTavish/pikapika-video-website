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
    let sql = 'select filmtv_id as film_id,type_id,name,imgSrc,is_ended,style,initials,playtime,years,actors,summary,play_volume from pk_filmtv where filmtv_id=?';
    let sqlArr = [film_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    result[0].episodes = await util.countEp(4, film_id);

    return res.send(result);
}

getAll = (req, res) => {
    //console.log("getFilmTVAll")
    let sql = 'select type_id,filmtv_id as film_id,name,is_ended,imgSrc from pk_filmtv order by create_time desc';
    let sqlArr = [];
    let callback = async (err, data) => {
        if (err) {
            console.error("error", err.message);
            return res.send({
                'is_ended': 402,
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
                "is_ended": 200,
                "msg": "信息获取成功"
            })
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}
let getStyles = async (req, res) => {
    let sql = 'select style as style from pk_filmtv';
    sqlArr = [];
    let rst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let arr = [];

    for (let i = 0; i < rst.length; i++) {
        temp = rst[i].style.split("、");
        arr = arr.concat(temp);

    }
    let styleArr = [];
    for (let i = 0; i < arr.length; i++) {
        if (styleArr.indexOf(arr[i]) == -1) {
            styleArr.push(arr[i]);
        }
    }
    styleArr.unshift("全部");
    return res.send({ list: styleArr });
}

let search = async (req, res) => {
    let params = req.body;
    switch (params.quarter) {
        case "1月":
            params.quarter = "01";
            break;
        case "4月":
            params.quarter = "04";
            break;
        case "7月":
            params.quarter = "07";
            break;
        case "10月":
            params.quarter = "10";
            break;
        default:
            break;
    }
    let sql = 'select type_id,filmtv_id as film_id,name,imgSrc,is_ended,style from pk_filmtv';
    let sqlArr = [];
    let keyArr = [];
    for (let key in params) {
        if (key == "style") continue
        if (key == "tag") continue
        if (params[key]) {
            keyArr.push(` ${key}=?`);
            sqlArr.push(params[key]);
        }
    }
    let sqlCondition = keyArr.join(" and");
    if (sqlCondition) {
        sql = `${sql} where${sqlCondition}`;
    }

    let rst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let list = [];
    if (params.style) {
        let length = rst.length;
        for (let i = 0; i < length; i++) {
            if (rst[i].style.indexOf(params.style) >= 0)
                list.push(rst[i]);
        }
    } else {
        list = rst;
    }
    let type_id = 4;
    for (let i = 0; i < list.length; i++) {
        let film_id = list[i].film_id;
        list[i].episodes = await util.countEp(type_id, film_id);
    }
    // //console.log("list", list);
    return res.send({ list });
}

let getRank = (req, res) => {
    //console.log("getGuomanRank")
    let sql = 'select type_id,filmtv_id as film_id,name as name,imgSrc as imgSrc,is_ended as is_ended from pk_filmtv order by play_volume desc';
    let sqlArr = [];
    let callback = async (err, data) => {
        if (err) {
            console.error("error", err.message);
            return res.send({
                'is_ended': 402,
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
            // //console.log("data", data);
            return res.send({
                "list": data,
                "is_ended": 200,
                "msg": "信息获取成功"
            })
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}
module.exports = {
    getAll, getOne, getStyles, search, getRank
}