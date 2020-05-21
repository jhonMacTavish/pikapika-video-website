let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

let getByParams = async (obj, obj2, obj3) => {
    console.log(`getBy${obj.key}`);
    let sql = `select * from pk_resources where ${obj.key}=? and ${obj2.key}=? and ${obj3.key}=?`;
    let sqlArr = [obj.value, obj2.value, obj3.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getByID = async (r_id) => {
    console.log("getVideoByID");
    let sql = 'select v_id,t_id from pk_resources where r_id=?';
    let sqlArr = [r_id];
    console.log("sql", sql, "r_id", r_id);

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return (result);
}

getAll = (req, res) => {
    console.log("getVideoAll")
    let { v_id, t_id } = req.query;
    let sql = 'select r_id,v_id,t_id,r_episode,r_address from pk_resources where v_id=? and t_id=? order by r_episode asc';
    let sqlArr = [v_id, t_id];

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

createOne = async (req, res) => {
    console.log("createVideo");
    console.log("params", req.body);
    let { v_id, t_id, r_episode, r_address } = req.body;
    let v_episodeRst = await getByParams({ key: 'v_id', value: v_id }, { key: 't_id', value: t_id }, { key: 'r_episode', value: r_episode });
    if (v_episodeRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": `数据库已存在该番剧第${r_episode}话`
        });
        return;
    }

    let sql =
        'insert into pk_resources(v_id, t_id,r_episode,r_address) '
        + 'values(?,?,?,?)';

    let sqlArr = [v_id, t_id, r_episode, r_address];

    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            return res.send({
                "status": 402,
                'msg': "添加失败"
            });
        } else {
            console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "添加成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

updateOne = async (req, res) => {
    console.log("updateVideoByID");
    console.log("params", req.body);
    let { r_episode, r_address, r_id } = req.body;

    let VT_idRst = await getByID(r_id);
    let v_id = VT_idRst[0].v_id;
    let t_id = VT_idRst[0].t_id;
    console.log("v_id", v_id, "t_id", t_id);

    let v_episodeRst = await getByParams({ key: 'v_id', value: v_id }, { key: 't_id', value: t_id }, { key: 'r_episode', value: r_episode });
    if (v_episodeRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": `数据库已存在该番剧第${r_episode}话`
        });
        return;
    }

    sql = 'update pk_resources set r_episode=?,r_address=? where r_id=?';
    sqlArr = [r_episode, r_address, r_id];

    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            return res.send({
                "status": 402,
                'msg': "更新失败"
            });
        } else {
            console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "更新成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

deleteOne = (req, res) => {
    console.log("deleteVideoByID")
    let r_id = req.params.id;
    console.log("r_id", r_id);
    let sql = 'delete from pk_resources where r_id=?';
    let sqlArr = [r_id];
    console.log("sql", sql);

    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            return res.send({
                "status": 402,
                'msg': "删除失败"
            });
        } else {
            console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "删除成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

let deleteByFilmName = (req, res) => {
    console.log("deleteVideoByFilmName");
    let { t_id, v_id } = req.query;
    let sql = 'delete from pk_resources where t_id=? and v_id=?';
    let sqlArr = [t_id, v_id];

    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            return res.send({
                "status": 402,
                'msg': "删除失败"
            });
        } else {
            console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "删除成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

addVolume = (req, res) => {
    let params = req.body.params;
    console.log("params", params);
    let sql = '';
    let sqlArr = [params.v_id];
    switch (params.t_id) {
        case 1:
            sql = 'update pk_bangumi set play_volume=play_volume+1 where v_id=?';
            break;
        case 2:
            sql = 'update pk_guoman set play_volume=play_volume+1 where v_id=?';
            break;
        case 3:
            sql = 'update pk_theater set play_volume=play_volume+1 where v_id=?';
            break;
        case 4:
            sql = 'update pk_filmTV set play_volume=play_volume+1 where v_id=?';
            break;
        default:
            break;
    }
    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            return res.send({
                "status": 402,
                'msg': "播放失败"
            });
        } else {
            console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "播放成功"
            });
        }
    }
    
    dbconfig.sqlConnect(sql,sqlArr,callback);
}

let getBGrank = async (req, res) => {
    console.log("getBangumiRank")
    let Brank = [];
    let Grank = [];

    let sql1 = 'select t_id,v_id,b_name as name,b_imgSrc as imgSrc,b_status as status,play_volume from pk_bangumi order by play_volume desc';
    let sqlArr1 = [];

    Brank = await dbconfig.asyncSqlConnect(sql1, sqlArr1);

    let sql2 = 'select t_id,v_id,g_name as name,g_imgSrc as imgSrc,g_status as status,play_volume from pk_guoman order by play_volume desc';
    let sqlArr2 = [];

    Grank = await dbconfig.asyncSqlConnect(sql2, sqlArr2);

    let list = Brank.concat(Grank);
    list.length = 10;

    // console.log("list", list);

    for (let i = 0; i < list.length; i++) {
        let t_id = list[i].t_id;
        let v_id = list[i].v_id;
        list[i].episodes = await util.countEp(t_id, v_id);
    }
    return res.send({"list":list});
}

module.exports = {
    getAll, getOne, addVolume,getBGrank, createOne, updateOne, deleteOne, deleteByFilmName
}