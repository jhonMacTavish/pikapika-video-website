let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

let getOne = async (req, res) => {
    //console.log("getBangumiByID");
    let film_id = req.params.id;
    let sql = 'select bangumi_id as film_id,type_id,name,imgSrc,is_ended,style,initials,playtime,weekday,quarter,years,actors,summary,play_volume from pk_bangumi where bangumi_id=?';
    let sqlArr = [film_id];
    //console.log("film_id", film_id);

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // result[0].episodes = await util.countEp(1, film_id);
    // let token = String(req.headers.authorization || '').split(' ').pop();
    // try {
    //     var { user_id } = jwt.verify(token, secretkey);
    // } catch (err) {
    //     user_id = null
    // }
    return res.send(result);
}

let getAll = (req, res) => {
    //console.log("getBangumiAll")
    let sql = 'select type_id,bangumi_id as film_id,name,imgSrc,is_ended from pk_bangumi order by create_time desc';
    let sqlArr = [];
    let callback = async (err, data) => {
        if (err) {
            console.error("error", err.message);
            return res.send({
                'is_ended': 402,
                'msg': "信息获取失败"
            })
        } else {
            //console.log("操作成功");
            let type_id = 1;
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
    let sql = 'select style as style from pk_bangumi';
    sqlArr = [];
    let rst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // //console.log("rst", rst);
    let arr = [];
    // //console.log("rst[0]", rst[0].style);
    // //console.log("rst.length", rst.length);


    for (let i = 0; i < rst.length; i++) {

        temp = rst[i].style.split("、");
        // //console.log("temp", temp);
        arr = arr.concat(temp);

    }
    // //console.log("arr", arr);
    let styleArr = [];
    for (let i = 0; i < arr.length; i++) {
        if (styleArr.indexOf(arr[i]) == -1) {
            styleArr.push(arr[i]);
        }
    }
    styleArr.unshift("全部");
    // //console.log("styleArr", styleArr);
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
    //console.log("searchParams", params);
    let sql = 'select type_id,bangumi_id as film_id,name,imgSrc,is_ended,style from pk_bangumi';
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
    let type_id = 1;
    for (let i = 0; i < list.length; i++) {
        let film_id = list[i].film_id;
        list[i].episodes = await util.countEp(type_id, film_id);
    }
    //console.log("list", list);
    return res.send({ list });
}
// getBangumiType();
let bangumiQuarter = async () => {
    let sql = 'select quarter as style from pk_bangumi';
    sqlArr = [];
    let rst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // //console.log("rst", rst);
    let arr = [];
    // //console.log("rst[0]", rst[0].style);
    // //console.log("rst.length", rst.length);


    for (let i = 0; i < rst.length; i++) {

        temp = rst[i].style.split("、");
        // //console.log("temp", temp);
        arr = arr.concat(temp);

    }
    // //console.log("arr", arr);
    let quarterArr = [];
    for (let i = 0; i < arr.length; i++) {
        if (quarterArr.indexOf(arr[i]) == -1) {
            quarterArr.push(arr[i]);
        }
    }
    //console.log("quarterArr", quarterArr);
}
// bangumiQuarter();
let bangumiYear = async () => {
    let sql = 'select years as style from pk_bangumi';
    sqlArr = [];
    let rst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // //console.log("rst", rst);
    let arr = [];
    // //console.log("rst[0]", rst[0].style);
    // //console.log("rst.length", rst.length);


    for (let i = 0; i < rst.length; i++) {

        temp = rst[i].style.split("、");
        // //console.log("temp", temp);
        arr = arr.concat(temp);

    }
    // //console.log("arr", arr);
    let YearArr = [];
    for (let i = 0; i < arr.length; i++) {
        if (YearArr.indexOf(arr[i]) == -1) {
            YearArr.push(arr[i]);
        }
    }
    //console.log("YearArr", YearArr);
}
// bangumiYear();

let getRank = (req, res) => {
    //console.log("getBangumiRank")
    let sql = 'select type_id,bangumi_id as film_id,name as name,imgSrc as imgSrc,is_ended as is_ended from pk_bangumi order by play_volume desc';
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
            let type_id = 1;
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