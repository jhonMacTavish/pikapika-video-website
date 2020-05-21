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
    let sql = 'select t_id,v_id,th_name,th_imgSrc,th_VGA from pk_theater where th_tag=1';
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

let getStyles = async (req, res) => {
    let sql = 'select th_style as style from pk_theater';
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
    console.log("params", params);
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
    let sql = 'select t_id,v_id,th_name,th_imgSrc,th_tag,th_style from pk_theater';
    let sqlArr = [];
    let keyArr = [];
    for (let key in params) {
        if (key == "style") continue
        if (params[key]) {
            keyArr.push(` th_${key}=?`);
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
            console.log("操作成功");
            let t_id = 1;
            for (let i = 0; i < data.length; i++) {
                let v_id = data[i].v_id;
                data[i].th_episodes = await util.countEp(t_id, v_id);
            }
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
            if(rst[i].th_style.indexOf(params.style)>=0)
                list.push(rst[i]);
        }
    }else{
        list = rst;
    }
    // console.log("list", list);
    return res.send({list});
}

let getRank = (req, res) => {
    console.log("getTheaterRank")
    let sql = 'select t_id,v_id,th_name as name,th_imgSrc as imgSrc,th_VGA as VGA from pk_theater order by play_volume desc';
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
    getAll, getOne, getStyles,search,getRank
}