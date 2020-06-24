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
    let sql = 'select theater_id as film_id,type_id,tag,name,imgSrc,VGA,style,initials,playtime,years,actors,summary,play_volume from pk_theater where theater_id=?';
    let sqlArr = [film_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send(result);
}

getAll = (req, res) => {
    // console.log("getTheaterAll")
    let sql = 'select type_id,theater_id as film_id,name,imgSrc,VGA from pk_theater where tag=1 order by playtime desc';
    let sqlArr = [];
    let callback = (err, data) => {
        if (err) {
            console.error("error", err.message);
            return res.send({
                'is_ended': 402,
                'msg': "信息获取失败"
            })
        } else {
            // console.log("getAll", data);
            // console.log("获取成功");
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
    let sql = 'select style as style from pk_theater';
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
    //console.log("params", params);
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
    switch (params.tag) {
        case "剧场版":
            params.tag = 1;
            break;
        case "电影":
            params.tag = 2;
            break;
        default:
            break;
    }
    let sql = 'select type_id,theater_id as film_id,name,imgSrc,tag,style from pk_theater';
    let sqlArr = [];
    let keyArr = [];
    for (let key in params) {
        if (key == "style") continue
        if (params[key]) {
            keyArr.push(` ${key}=?`);
            sqlArr.push(params[key]);
        }
    }
    let sqlCondition = keyArr.join(" and");
    if (sqlCondition) {
        sql = `${sql} where${sqlCondition}`;
    }
    console.log(sql, );
    console.log(sqlArr, )
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
    return res.send({ list });
}

let getRank = (req, res) => {
    //console.log("getTheaterRank")
    let sql = 'select type_id,theater_id as film_id,name as name,imgSrc as imgSrc,VGA as VGA from pk_theater order by play_volume desc';
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