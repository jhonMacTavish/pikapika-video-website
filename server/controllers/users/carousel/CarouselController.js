let dbconfig = require('../../../util/dbconfig');

let getAll = async (req, res) => {
    let sql = 'select carousel_id as id,type_id,film_id,episode,imgSrc from pk_carousel';
    let sqlArr = [];

    let carouselRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
    let length = carouselRst.length;
    for (let i = 0; i < length; i++) {
        if (carouselRst[i].type_id == 1) {
            sql = 'select video_name as name from pk_resource where type_id=? and film_id=? and episode=?';
        } else if (carouselRst[i].type_id == 2) {
            sql = 'select video_name as name from pk_resource where type_id=? and film_id=? and episode=?';
        }
        sqlArr = [carouselRst[i].type_id, carouselRst[i].film_id,carouselRst[i].episode];
        let nameRst = await dbconfig.asyncSqlConnect(sql, sqlArr);
        carouselRst[i].name = nameRst[0].name
    }
    return res.send({
        'list': carouselRst
    })
}

module.exports = {
    getAll
}