let dbconfig = require('../../../util/dbconfig');

let getByParams = async (obj, obj2) => {
    //console.log(`getBy${obj.key}`);
    let sql = `select * from pk_announce where ${obj.key}=? and ${obj2.key}=?`;
    let sqlArr = [obj.value, obj2.value];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

let getAll = async (req, res) => {
    //console.log("getAnnounces")
    let sql = 'select announce_id,title,content,create_time,admin_id from pk_announce';
    let sqlArr = [];

    let AnnounceRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let length = AnnounceRst.length;
    for (let i = 0; i < length; i++) {
        sql = 'select adminname from pk_admin where admin_id=?';
        sqlArr = [AnnounceRst[i].admin_id];
        let adminnameRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        AnnounceRst[i].editor = adminnameRst[0].adminname;
    }
    return res.send({
        'list': AnnounceRst
    })
}

let getOne = async (req, res) => {
    let announce_id = req.params.id;
    let sql = 'select title,content from pk_announce where announce_id=?';
    let sqlArr = [announce_id];
    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send({
        "list": result
    });
}

module.exports = {
    getOne, getAll
}