const mysql = require('mysql');

module.exports = {
    config: {
        host:'localhost',
        port:'3306',
        user:'root',
        password:'124356',
        database:'pikapika'
    },

    sqlConnect(sql,sqlArr,callback){
        //console.log("sqlConnect");
        let pool = mysql.createPool(this.config);
        pool.getConnection((err,conn)=>{
            //console.log("正在连接");
            if(err){
                //console.log("连接失败");
                return;
            }
            conn.query(sql,sqlArr,callback);
            conn.release();
        })
    },

    asyncSqlConnect(sql,sqlArr){
        return new Promise((resolve,reject)=>{
            let pool = mysql.createPool(this.config);
            pool.getConnection((err,conn)=>{
                if(err){
                    reject(err);
                }else{
                    conn.query(sql,sqlArr,(err,data)=>{
                        if(err){
                            reject(err);
                        }else{
                            resolve(data);
                        }
                    });

                    conn.release();
                }
            })
        }).catch((err)=>{
            //console.log(err);
        });
    }
}