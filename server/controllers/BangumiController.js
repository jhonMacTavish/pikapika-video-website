var dbconfig = require('../util/dbconfig');

getBangumiByName = async(b_name) => {
    var sql = 'select * from pk_bangumi where b_name=?';
    var sqlArr = [b_name];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return result;
}

getBangumi = async (req, res) => {
    var v_id = req.params.id
    var sql = 'select * from pk_bangumi where v_id=?';
    var sqlArr = [v_id];

    let result = await dbconfig.asyncSqlConnect(sql, sqlArr);
    res.send(result);
}

getBangumis = (req, res) => {
    console.log("getBangumis")
    var sql = 'select v_id,b_name,b_episodes,b_style,b_playtime from pk_bangumi where t_id=1';
    var sqlArr = [];
    var callback = (err, data) => {
        if (err) {
            console.log("操作出错");
            res.send({
                'status': 500,
                'msg': "操作出错"
            })
        } else {
            // console.log("getBangumis", data);
            console.log("操作成功");
            res.send({
                "list":data,
                "msg":"操作成功"
            })
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback);
}

createBangumi = async(req, res) => {
    console.log("createBangumi");
    // console.log("req", req.body);
    console.log("params", req.body);

    let { b_name, t_id, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary } = req.body;
    let b_nameRst = await getBangumiByName(b_name);
    if(b_nameRst.length!=0){
        res.send({
            "status":402,
            "msg":"数据库中存在同名番剧"
        });
        return;
    }
    
    var sql =
        'insert into pk_bangumi(b_name,t_id,b_imgSrc,b_episodes,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) '
        + 'values(?,?,?,?,?,?,?,?,?,?,?,?)';
    console.log("插入2");

    let sqlArr = [b_name, t_id, b_imgSrc, b_episodes, b_status, b_style, b_initials, b_playtime, b_quarter, b_years, b_actors, b_summary];
    callback = (err, data) => {
        if (err) {
            console.log("操作出错")
            res.send({
                'msg': "操作出错"
            });
        } else {
            console.log("操作成功");
            res.send({
                "status":200,
                "msg":"操作成功"
            });
        }
    }

    dbconfig.sqlConnect(sql, sqlArr, callback)

}

module.exports = {
    getBangumis, createBangumi, getBangumi
}