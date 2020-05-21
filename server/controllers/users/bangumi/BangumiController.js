let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

// getByName = async (b_name) => {
//     let sql = 'select * from pk_bangumi where b_name=?';
//     let sqlArr = [b_name];

//     let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
//     return result;
// }

// let obj = {
//     key:'b_name',
//     value:'苍之彼方的四重奏'
// }

let getByParams = async (obj) => {
    console.log(`getBangumiBy${obj.key}`);
    console.log("obj.key", obj.key);
    let sql = `select * from pk_bangumi where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getOne = async (req, res) => {
    console.log("getBangumiByID");
    let v_id = req.params.id;
    let sql = 'select * from pk_bangumi where v_id=?';
    let sqlArr = [v_id];
    console.log("v_id", v_id);

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // console.log("res", result);
    result[0].b_episodes = await util.countEp(1, v_id);
    // console.log("result", result);
    return res.send(result);
}

// let format = async (table, v_id, t_id) => {
//     let rst = await getByParams({ key: 'v_id', value: v_id });
//     console.log("formatRst", rst[0]);
//     if (rst[0].t_id != t_id) {
//         let sql = `delete from ${table} where v_id=?`
//         let sqlArr = [v_id];
//         let callback = (err, data) => {
//             if (err) {
//                 console.log("操作出错")
//             } else {
//                 console.log("删除成功");
//             }
//         }
//         dbconfig.sqlConnect(sql, sqlArr, callback);

//         switch (t_id) {
//             case 1:
//                 rst[0].t_id = 1;
//                 console.log("create in pk_bangumi");

//                 let { b_name, t_id, b_imgSrc, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary } = rst[0];

//                 let b_nameRst = await getByParams({ key: 'b_name', value: b_name });
//                 if (b_nameRst.length != 0) {
//                     return res.send({
//                         "status": 402,
//                         "msg": "数据库中存在同名番剧"
//                     });
//                     return;
//                 }

//                 let sql =
//                     'insert into pk_bangumi(b_name,t_id,b_imgSrc,b_episodes,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) '
//                     + 'values(?,?,?,?,?,?,?,?,?,?,?,?)';

//                 let sqlArr = [b_name, t_id, b_imgSrc, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary];


//                 break;
//             case 2:
//                 break;
//             case 3:
//                 break;
//             case 4:
//                 break;
//             default:
//                 break;
//         }

//         callback = (err, data) => {
//             if (err) {
//                 console.log("操作出错")
//                 return res.send({
//                     "status": 402,
//                     'msg': "修改失败"
//                 });
//             } else {
//                 console.log("操作成功");
//                 return res.send({
//                     "status": 200,
//                     "msg": "修改成功"
//                 });
//             }
//         }

//         dbconfig.sqlConnect(sql, sqlArr, callback)
//     }
// }

// format('pk_guoman', 4, 1);

let getAll = (req, res) => {
    console.log("getBangumiAll")
    let sql = 'select t_id,v_id,b_name,b_imgSrc,b_status from pk_bangumi';
    let sqlArr = [];
    let callback = async (err, data) => {
        if (err) {
            console.log("操作出错");
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // console.log("getAll", data);
            console.log("操作成功");
            let t_id = 1;
            for (let i = 0; i < data.length; i++) {
                let v_id = data[i].v_id;
                data[i].b_episodes = await util.countEp(t_id, v_id);
            }
            // console.log("data", data);
            return res.send({
                "list": data,
                "status": 200,
                "msg": "信息获取成功"
            })
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

let getStyles = async (req, res) => {
    let sql = 'select b_style as style from pk_bangumi';
    sqlArr = [];
    let rst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // console.log("rst", rst);
    let arr = [];
    // console.log("rst[0]", rst[0].style);
    // console.log("rst.length", rst.length);


    for (let i = 0; i < rst.length; i++) {

        temp = rst[i].style.split("、");
        // console.log("temp", temp);
        arr = arr.concat(temp);

    }
    // console.log("arr", arr);
    let styleArr = [];
    for (let i = 0; i < arr.length; i++) {
        if (styleArr.indexOf(arr[i]) == -1) {
            styleArr.push(arr[i]);
        }
    }
    styleArr.unshift("全部");
    // console.log("styleArr", styleArr);
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
    console.log("searchParams", params);
    let sql = 'select t_id,v_id,b_name,b_imgSrc,b_status,b_style from pk_bangumi';
    let sqlArr = [];
    let keyArr = [];
    for (let key in params) {
        if (key == "style") continue
        if (key == "tag") continue
        if (params[key]) {
            keyArr.push(` b_${key}=?`);
            sqlArr.push(params[key]);
        }
    }
    let sqlCondition = keyArr.join(" and");
    if (sqlCondition) {
        sql = `${sql} where${sqlCondition}`;
    }
    let callback = async (err, data) => {
        if (err) {
            console.log("操作出错");
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // console.log("getAll", data);
            console.log("操作成功");
            let t_id = 1;
            for (let i = 0; i < data.length; i++) {
                let v_id = data[i].v_id;
                data[i].b_episodes = await util.countEp(t_id, v_id);
            }
            // console.log("data", data);
            return res.send({
                "list": data,
                "status": 200,
                "msg": "信息获取成功"
            })
        }
    }

    let rst = await dbconfig.asyncSqlConnect(sql, sqlArr, callback);
    let list = [];
    if(params.style){
        let length = rst.length;
        for(let i=0; i<length; i++){
            if(rst[i].b_style.indexOf(params.style)>=0)
                list.push(rst[i]);
        }
    }else{
        list = rst;
    }
    console.log("list", list);
    return res.send({list});
}
// getBangumiType();
let bangumiQuarter = async () => {
    let sql = 'select b_quarter as style from pk_bangumi';
    sqlArr = [];
    let rst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // console.log("rst", rst);
    let arr = [];
    // console.log("rst[0]", rst[0].style);
    // console.log("rst.length", rst.length);


    for (let i = 0; i < rst.length; i++) {

        temp = rst[i].style.split("、");
        // console.log("temp", temp);
        arr = arr.concat(temp);

    }
    // console.log("arr", arr);
    let quarterArr = [];
    for (let i = 0; i < arr.length; i++) {
        if (quarterArr.indexOf(arr[i]) == -1) {
            quarterArr.push(arr[i]);
        }
    }
    console.log("quarterArr", quarterArr);
}
// bangumiQuarter();
let bangumiYear = async () => {
    let sql = 'select b_years as style from pk_bangumi';
    sqlArr = [];
    let rst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    // console.log("rst", rst);
    let arr = [];
    // console.log("rst[0]", rst[0].style);
    // console.log("rst.length", rst.length);


    for (let i = 0; i < rst.length; i++) {

        temp = rst[i].style.split("、");
        // console.log("temp", temp);
        arr = arr.concat(temp);

    }
    // console.log("arr", arr);
    let YearArr = [];
    for (let i = 0; i < arr.length; i++) {
        if (YearArr.indexOf(arr[i]) == -1) {
            YearArr.push(arr[i]);
        }
    }
    console.log("YearArr", YearArr);
}
// bangumiYear();

let getRank = (req, res) => {
    console.log("getBangumiRank")
    let sql = 'select t_id,v_id,b_name as name,b_imgSrc as imgSrc,b_status as status from pk_bangumi order by play_volume desc';
    let sqlArr = [];
    let callback = async (err, data) => {
        if (err) {
            console.log("操作出错");
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // console.log("getAll", data);
            console.log("操作成功");
            let t_id = 1;
            for (let i = 0; i < data.length; i++) {
                let v_id = data[i].v_id;
                data[i].episodes = await util.countEp(t_id, v_id);
            }
            // console.log("data", data);
            return res.send({
                "list": data,
                "status": 200,
                "msg": "信息获取成功"
            })
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

module.exports = {
    getAll, getOne, getStyles, search, getRank
}