let dbconfig = require('../../../util/dbconfig');

let getAll = async (req, res) => {
    //console.log("getAds")
    let sql = 'select ad_id,brand,imgSrc,url from pk_advertising';
    let sqlArr = [];

    let adRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    return res.send({
        'list': adRst
    })
}

module.exports = {
    getAll
}