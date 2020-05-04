var dbconfig = require('./dbconfig');

let countEp = async(t_id,v_id)=>{
    let sql = 'select count(r_id) as countEp from pk_resources where t_id=? and v_id=?';
    sqlArr=[t_id,v_id];

    let count = await dbconfig.asyncSqlConnect(sql,sqlArr);
    return count[0].countEp;
}


module.exports ={
    countEp
}