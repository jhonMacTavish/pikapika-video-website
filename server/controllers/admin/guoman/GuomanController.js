let dbconfig = require('../../../util/dbconfig');
let util = require('../../../util/util');

let getByParams = async (obj) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_guoman where ${obj.key}=?`;
    let sqlArr = [obj.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getOne = async (req, res) => {
    //console.log("getGuomanByID", )
    let film_id = req.params.id
    let sql = 'select guoman_id as film_id,name,searchUrl,type_id,imgSrc,is_ended,style,initials,playtime,years,actors,summary from pk_guoman where guoman_id=?';
    let sqlArr = [film_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    result[0].episodes = await util.countEp(2,film_id);

    return res.send(result);
}

getAll = (req, res) => {
    //console.log("getGuomanAll")
    let sql = 'select guoman_id as film_id,name,is_ended,style,playtime from pk_guoman order by create_time desc';
    let sqlArr = [];
    let callback = async (err, data) => {
        if (err) {
            console.error("error",err.message);
            return res.send({
                'status': 402,
                'msg': "信息获取失败"
            })
        } else {
            // //console.log("getAll", data);
            //console.log("操作成功");
            let type_id = 2;
            for(let i=0; i<data.length; i++){
                let film_id = data[i].film_id;
                data[i].episodes = await util.countEp(type_id,film_id);
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

createOne = async (req, res) => {
    //console.log("createGuoman");

    let { searchUrl, name, type_id, imgSrc, is_ended, style, initials, playtime,   years, actors, summary,weekday } = req.body;
    let nameRst = await getByParams({key:'name',value:name});
    if (nameRst.length != 0) {
        return res.send({
            "status": 402,
            "msg": "数据库中存在同名国漫"
        });
        return;
    }

    let sql =
        'insert into pk_guoman(searchUrl,name,type_id,imgSrc,is_ended,style,initials,playtime,years,actors,summary,admin_id,weekday) '
        + 'values(?,?,?,?,?,?,?,?,?,?,?,?,?)';

    let sqlArr = [searchUrl,name, type_id, imgSrc, is_ended, style, initials, playtime,   years, actors, summary,req.admin_id,weekday];
    callback = (err, data) => {
        if (err) {
            //console.log("error",err.message)
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
                "film_id": data.insertId
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

updateOne = (req, res) => {
    let { searchUrl,type_id, name, imgSrc, is_ended, style, initials, playtime, years, actors, summary, film_id } = req.body;

    let sql = 'update pk_guoman set searchUrl=?,type_id=?,name=?,imgSrc=?,is_ended=?,style=?,initials=?,playtime=?,years=?,actors=?,summary=?,admin_id=? where guoman_id=?';
    let sqlArr = [searchUrl,type_id, name, imgSrc, is_ended, style, initials, playtime, years, actors, summary, req.admin_id, film_id];

    callback = (err, data) => {
        if (err) {
            //console.log("error",err.message)
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
    //console.log("deleteGuomanByID")
    let film_id = req.params.id;
    //console.log("film_id", req.params);
    let sql = 'delete from pk_guoman where guoman_id=?';
    let sqlArr = [film_id];

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

module.exports = {
    getAll, getOne, createOne, updateOne, deleteOne
}