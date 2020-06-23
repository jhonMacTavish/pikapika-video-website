var dbconfig = require('./dbconfig');

let countEp = async(type_id,film_id)=>{
    let sql = 'select count(*) as countEp from pk_resource where type_id=? and film_id=?';
    sqlArr=[type_id,film_id];

    let count = await dbconfig.asyncSqlConnect(sql,sqlArr);
    return count[0].countEp;
}


module.exports ={
    countEp
}