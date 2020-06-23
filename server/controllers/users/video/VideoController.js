let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

let getByParams = async (obj, obj2, obj3) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_resource where ${obj.key}=? and ${obj2.key}=? and ${obj3.key}=?`;
    let sqlArr = [obj.value, obj2.value, obj3.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getByID = async (resource_id) => {
    //console.log("getVideoByID");
    let sql = 'select film_id,type_id from pk_resource where resource_id=?';
    let sqlArr = [resource_id];
    //console.log("sql", sql, "resource_id", resource_id);

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return (result);
}

getAll = (req, res) => {
    //console.log("getVideoAll")
    let { film_id, type_id } = req.query;
    let sql = 'select resource_id,film_id,type_id,episode,video_name,src from pk_resource where film_id=? and type_id=? order by episode asc';
    let sqlArr = [film_id, type_id];

    let callback = (err, data) => {
        if (err) {
            console.error("error",err.message);
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // //console.log("getAll", data);
            //console.log("操作成功");
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
    //console.log("createVideo");
    //console.log("params", req.body);
    let { film_id, type_id, episode, src } = req.body;
    let v_episodeRst = await getByParams({ key: 'film_id', value: film_id }, { key: 'type_id', value: type_id }, { key: 'episode', value: episode });
    if (v_episodeRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": `数据库已存在该番剧第${episode}话`
        });
        return;
    }

    let sql =
        'insert into pk_resource(film_id, type_id,episode,video_name,src) '
        + 'values(?,?,?,?)';

    let sqlArr = [film_id, type_id, episode, src];

    callback = (err, data) => {
        if (err) {
            //console.log("error",err.message)
            return res.send({
                "status": 402,
                'msg': "添加失败"
            });
        } else {
            //console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "添加成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

deleteOne = (req, res) => {
    //console.log("deleteVideoByID")
    let resource_id = req.params.id;
    //console.log("resource_id", resource_id);
    let sql = 'delete from pk_resource where resource_id=?';
    let sqlArr = [resource_id];
    //console.log("sql", sql);

    callback = (err, data) => {
        if (err) {
            //console.log("error",err.message)
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

let deleteByFilmName = (req, res) => {
    //console.log("deleteVideoByFilmName");
    let { type_id, film_id } = req.query;
    let sql = 'delete from pk_resource where type_id=? and film_id=?';
    let sqlArr = [type_id, film_id];

    callback = (err, data) => {
        if (err) {
            //console.log("error",err.message)
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

addVolume = (req, res) => {
    let params = req.body.params;
    //console.log("params", params);
    let sql = '';
    let sqlArr = [params.film_id];
    switch (params.type_id) {
        case 1:
            sql = 'update pk_bangumi set play_volume=play_volume+1 where bangumi_id=?';
            break;
        case 2:
            sql = 'update pk_guoman set play_volume=play_volume+1 where guoman_id=?';
            break;
        case 3:
            sql = 'update pk_theater set play_volume=play_volume+1 where theater_id=?';
            break;
        case 4:
            sql = 'update pk_filmtv set play_volume=play_volume+1 where filmtv_id=?';
            break;
        default:
            break;
    }
    callback = (err, data) => {
        if (err) {
            //console.log("error",err.message)
            return res.send({
                "status": 402,
                'msg': "播放失败"
            });
        } else {
            //console.log("操作成功");
            return res.send({
                "status": 200,
                "msg": "播放成功"
            });
        }
    }
    
    dbconfig.sqlConnect(sql,sqlArr,callback);
}

let getBGrank = async (req, res) => {
    //console.log("getBangumiRank")
    let Brank = [];
    let Grank = [];

    let sql1 = 'select type_id,bangumi_id as film_id,name,imgSrc,is_ended,play_volume from pk_bangumi order by play_volume desc';
    let sqlArr1 = [];

    Brank = await dbconfig.asyncSqlConnect(sql1, sqlArr1);

    let sql2 = 'select type_id,guoman_id as film_id,name,imgSrc,is_ended,play_volume from pk_guoman order by play_volume desc';
    let sqlArr2 = [];

    Grank = await dbconfig.asyncSqlConnect(sql2, sqlArr2);

    let list = Brank.concat(Grank);
    list.length = list.length>10?list.length=10:list.length;

    for (let i = 0; i < list.length; i++) {
        let type_id = list[i].type_id;
        let film_id = list[i].film_id;
        list[i].episodes = await util.countEp(type_id, film_id);
    }
    return res.send({"list":list});
}

module.exports = {
    getAll, getOne, addVolume,getBGrank, createOne, updateOne, deleteOne, deleteByFilmName
}