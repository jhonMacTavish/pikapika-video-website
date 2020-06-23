let dbconfig = require('../../../util/dbconfig');

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
            console.error("error", err.message);
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
    let { film_id, type_id, episode, src, video_name } = req.body;
    let v_episodeRst = await getByParams({ key: 'film_id', value: film_id }, { key: 'type_id', value: type_id }, { key: 'episode', value: episode });
    if (v_episodeRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": `数据库已存在该番剧第${episode}话`
        });
        return;
    }

    let sql =
        'insert into pk_resource(film_id, type_id,episode,video_name,src,admin_id) '
        + 'values(?,?,?,?,?,?)';
    //console.log("req.admin_id", req.admin_id);
    let sqlArr = [film_id, type_id, episode, video_name, src, req.admin_id];

    callback = (err, data) => {
        if (err) {
            //console.log("error", err.message)
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

updateOne = async (req, res) => {
    let { episode, src, resource_id, video_name } = req.body;

    sql = 'update pk_resource set episode=?,video_name=?,src=?,admin_id=? where resource_id=?';
    sqlArr = [episode, video_name, src, req.admin_id, resource_id];
    console.log(req.body );
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

deleteOne = (req, res) => {
    //console.log("deleteVideoByID")
    let resource_id = req.params.id;
    //console.log("resource_id", resource_id);
    let sql = 'delete from pk_resource where resource_id=?';
    let sqlArr = [resource_id];
    //console.log("sql", sql);

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

let deleteByFilmName = (req, res) => {
    //console.log("deleteVideoByFilmName");
    let { type_id, film_id } = req.query;
    let sql = 'delete from pk_resource where type_id=? and film_id=?';
    let sqlArr = [type_id, film_id];

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

let getEpisodes = (req, res) => {
    //console.log("getEpisodes")
    let { film_id, type_id } = req.query;
    let sql = 'select count(*) as episodes from pk_resource where film_id=? and type_id=?';
    let sqlArr = [film_id, type_id];

    let callback = (err, data) => {
        if (err) {
            console.error("error", err.message);
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // //console.log("getAll", data);
            //console.log("操作成功");
            return res.send({
                "episodes": data[0].episodes,
                "status": 200,
                "msg": "信息获取成功"
            })
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

module.exports = {
    getAll, getOne, createOne, updateOne, deleteOne, deleteByFilmName, getEpisodes
}