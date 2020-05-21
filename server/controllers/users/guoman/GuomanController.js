let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

let getByParams = async (obj) => {
    console.log(`getBy${obj.key}`);
    let sql = `select * from pk_guoman where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    console.log("getGuomanByID", )
    let v_id = req.params.id
    let sql = 'select * from pk_guoman where v_id=?';
    let sqlArr = [v_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    result[0].g_episodes = await util.countEp(2,v_id);

    return res.send(result);
}

getAll = (req, res) => {
    console.log("getGuomanAll")
    let sql = 'select t_id,v_id,g_name,g_imgSrc,g_status from pk_guoman order by g_name asc';
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
            let t_id = 2;
            for(let i=0; i<data.length; i++){
                let v_id = data[i].v_id;
                data[i].g_episodes = await util.countEp(t_id,v_id);
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

let getStyles = async (req, res) => {
    console.log("guomanGetStyles", );
    let sql = 'select g_style as style from pk_guoman';
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
    let sql = 'select t_id,v_id,g_name,g_imgSrc,g_status,g_style from pk_guoman';
    let sqlArr = [];
    let keyArr = [];
    for (let key in params) {
        if (key == "style") continue
        if (key == "tag") continue
        
        if (params[key]) {
            keyArr.push(` g_${key}=?`);
            sqlArr.push(params[key]);
        }
    }
    let sqlCondition = keyArr.join(" and");
    if (sqlCondition) {
        sql = `${sql} where${sqlCondition}`;
    }
    console.log("sql", sql);
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
                data[i].g_episodes = await util.countEp(t_id, v_id);
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
            if(rst[i].g_style.indexOf(params.style)>=0)
                list.push(rst[i]);
        }
    }else{
        list = rst;
    }
    console.log("list", list);
    return res.send({list});
}

let getRank = (req, res) => {
    console.log("getGuomanRank")
    let sql = 'select t_id,v_id,g_name as name,g_imgSrc as imgSrc,g_status as status from pk_guoman order by play_volume desc';
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
            let t_id = 2;
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
    getAll, getOne, getStyles,search,getRank
}