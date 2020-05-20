use pikapika;
CREATE TABLE pk_user(
	u_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    u_name VARCHAR(48) NOT NULL,
    u_email VARCHAR(100) NOT NULL,
    u_password VARCHAR(16) NOT NULL,
    u_sex TINYINT(1) NOT NULL DEFAULT 0,
    u_avatar VARCHAR(500),
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP);
    
INSERT INTO pk_user(u_id,u_name,u_email,u_password,u_sex,u_avatar) VALUES(1,'Dragon_Mr','981192661@qq.com','a981192661',0,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3038277678,2828142910&fm=26&gp=0.jpg');
INSERT INTO pk_user(u_id,u_name,u_email,u_password,u_sex,u_avatar) VALUES(2,'Jhon_Mactavish96','819661408@qq.com','a981192661',0,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3038277678,2828142910&fm=26&gp=0.jpg');

    
CREATE TABLE pk_type(
	t_id TINYINT(1) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    t_text VARCHAR(8) NOT NULL);

INSERT INTO pk_type VALUES(1,'番剧');
INSERT INTO pk_type VALUES(2,'国漫');
INSERT INTO pk_type VALUES(3,'剧场动画');
INSERT INTO pk_type VALUES(4,'影视');
    
CREATE TABLE pk_bangumi(
	v_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    t_id TINYINT(1) NOT NULL,
    b_name VARCHAR(100) UNIQUE NOT NULL,
    b_imgSrc VARCHAR(500) NOT NULL,
    /*b_episodes VARCHAR(4) NOT NULL,*/
    b_status TINYINT(1) NOT NULL,
    b_style VARCHAR(50) NOT NULL,
    b_initials VARCHAR(1) NOT NULL,
    b_playtime VARCHAR(10) NOT NULL,
    b_quarter VARCHAR(2) NOT NULL,
    b_years VARCHAR(4) NOT NULL,
    b_actors VARCHAR(255) NOT NULL,
    b_summary VARCHAR(500) NOT NULL,
    play_volume INT NOT NULL DEFAULT 0,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    FOREIGN KEY(t_id) REFERENCES pk_type(t_id));
/*    
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(1,1,'苍之彼方的四重奏','',1,'竞技、校园、科幻','C','2018-01-11',1,'2016','福圆美里、浅仓杏美、山本希望、米泽圆、逢坂良太、若林直美、近藤孝行、种田梨沙、新津和幸、仪武祐子、绪方惠美、高森奈津美',''); 
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(2,1,'我们的爱只有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(3,1,'苍之彼方的四s重奏','',1,'竞技、校园、科幻','C','2018-01-11',1,'2016','福圆美里、浅仓杏美、山本希望、米泽圆、逢坂良太、若林直美、近藤孝行、种田梨沙、新津和幸、仪武祐子、绪方惠美、高森奈津美',''); 
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(4,1,'我们的爱只有dawwwww10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(5,1,'苍之彼方的d四重奏','',1,'竞技、校园、科幻','C','2018-01-11',1,'2016','福圆美里、浅仓杏美、山本希望、米泽圆、逢坂良太、若林直美、近藤孝行、种田梨沙、新津和幸、仪武祐子、绪方惠美、高森奈津美',''); 
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(6,1,'我们的爱只有d1ddd0厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(7,1,'我们的爱只有f10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(8,1,'我们pk_bangumi的爱只有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(9,1,'我们的爱只有1f0厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(10,1,'我们的爱656只有s10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(11,1,'我们的爱只有4654f10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(12,1,'我们的爱只sdddd有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(93,1,'我们的爱g只有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(180,1,'我们的353h爱只ad有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(111,1,'我们的爱g只有1ada0厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(122,1,'我们的54354爱只adgh有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(123,1,'我们的爱只fd有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(144,1,'我们的34爱只有g1dgd0厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(116,1,'我们的gdd爱只有g10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(117,1,'我们的爱d只有g10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(118,1,'我们的爱只fd有gg10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(191,1,'我们的爱d只有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(210,1,'我们的爱只dddd有hh10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(241,1,'我们的爱只dgggh有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(242,1,'我们的爱s只dd有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
INSERT INTO pk_bangumi(v_id,t_id,b_name,b_imgSrc,b_status,b_style,b_initials,b_playtime,b_quarter,b_years,b_actors,b_summary) VALUES(243,1,'我们的爱ss只有10厘米。','',1,'校园、青春','W','2018-01-11',10,'2017','铃村健一、丰崎爱生、神谷浩史、户松遥、梶裕贵、阿澄佳奈、绿川光、Gero、木村良平、莉犬','');   
*/

CREATE TABLE pk_guoman(
	v_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    t_id TINYINT(1) NOT NULL,
    g_name VARCHAR(100) UNIQUE NOT NULL,
    g_imgSrc VARCHAR(500) NOT NULL,
    /*g_episodes VARCHAR(4) NOT NULL,*/
    g_status TINYINT(1) NOT NULL,
    g_style VARCHAR(50) NOT NULL,
    g_initials VARCHAR(1) NOT NULL,
    g_playtime VARCHAR(10) NOT NULL,
    g_years VARCHAR(4) NOT NULL,
    g_actors VARCHAR(255) NOT NULL,
    g_summary VARCHAR(500) NOT NULL,
    play_volume INT NOT NULL DEFAULT 0,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    FOREIGN KEY(t_id) REFERENCES pk_type(t_id));
/*    
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(1,2,'今天开始做明星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(2,2,'剑网3·侠肝55义胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(3,2,'今天开始f做s明星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(5,2,'今天开始fss做明星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(6,2,'剑网3·侠fg肝义胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(12,2,'今天开始jf做明星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(25,2,'剑网3·侠肝6hk义胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(37,2,'今天开始做64明chh星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(43,2,'剑网3·侠肝义k胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(57,2,'今天开始做明gkk星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(63,2,'剑网3·侠肝义胆g沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(17,2,'今天开465始做明星k','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(21,2,'剑g网3·侠bz肝义胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(34,2,'今g天开gxbgg始做明星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(41,2,'剑网g3·侠c肝义胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(52,2,'今天ggk开bcc始做明星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(65,2,'剑网3·侠ccbb肝c义胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(16,2,'今天开始做cVDvxScbb明星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(28,2,'剑网3·侠肝义cbc胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(33,2,'今天开始f做vvSd明星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(497,2,'剑网3·侠dxx3wer肝义胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(58,2,'今天开始做r3wrw3r3r3we明星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(6213,2,'剑网3·侠d肝rw3r3w义胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(18,2,'今天开始做明dddd星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(28855,2,'剑网3·侠tw3t3r3肝义胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(35,2,'今天开始做3wefgre3明星','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(42,2,'剑网3·侠肝wer3er3w义胆沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(53,2,'今天开始做bdvfb明星ret','',1,'偶像','J','2018-01-11','2019','吟良犬、马正阳、藤新、周侗','',0);
INSERT INTO pk_guoman(v_id,t_id,g_name,g_imgSrc,g_status,g_style,g_initials,g_playtime,g_years,g_actors,g_summary,play_volume) VALUES(62,2,'剑网3·侠肝义胆fff沈剑心','',1,'搞笑、战斗','J','2018-01-11','2018','宝木中阳、藤新、图特哈蒙、黎悠濛','',0);
*/

CREATE TABLE pk_theater(
	v_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    t_id TINYINT(1) NOT NULL,
    th_tag TINYINT(1) NOT NULL,
    th_name VARCHAR(100) UNIQUE NOT NULL,
    th_imgSrc VARCHAR(500) NOT NULL,
    th_VGA TINYINT(1) NOT NULL,
    th_style VARCHAR(50) NOT NULL,
    th_initials VARCHAR(1) NOT NULL,
    th_playtime VARCHAR(10) NOT NULL,
    th_years VARCHAR(4) NOT NULL,
    th_actors VARCHAR(255) NOT NULL,
    th_summary VARCHAR(500) NOT NULL,
    play_volume INT NOT NULL DEFAULT 0,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    FOREIGN KEY(t_id) REFERENCES pk_type(t_id));
/*
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(1,3,1,'Re：从ddad零开始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(2,3,1,'凉宫wbnv bm春日的消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(3,3,1,'Re：从零bmb开始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(4,3,1,'凉宫春日bb的消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(16,3,1,'Re：从零mbmmbm开始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(21,3,1,'凉宫春bmm日的消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(35,3,1,'Re：从零开bb始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(432,3,1,'凉宫春日的消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(163,3,1,'Re：从零开始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(246,3,1,'凉宫春日的hfghzg消失s','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(392,3,1,'Re：从零开始sfnj的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(427,3,1,'凉宫春日xxxzjx的消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(14,3,1,'Re：从零开hgxx,vk始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(255,3,1,'凉宫春日的my nxz消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(37,3,1,'Re：从零开,cj始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(466,3,1,'凉宫春日ngtnjtxnhz的消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(11,3,1,'Re：从零开bzzbzbz始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(242,3,1,'凉宫春日zvvnxgbzbz的消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(373,3,1,'Re：从零开1351351315的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(40,3,1,'凉宫春日的31失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(15,3,1,'Re：从零53开daddsd始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(293,3,1,'凉宫春++4日的消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(32,3,1,'Re：从零53开sd始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(459,3,1,'凉宫春135日的消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(132,3,1,'Re：从23241544零开始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(24,3,1,'凉宫春日的64642消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(323,3,1,'Re：从零12321开始的异世界生活 冰结之绊','',1,'穿越、战斗','R','2018-01-11','2019','高桥李依、内山夕实、小林裕介、水濑祈、村川梨衣、子安武人','',0);
INSERT INTO pk_theater(v_id,t_id,th_tag,th_name,th_imgSrc,th_VGA,th_style,th_initials,th_playtime,th_years,th_actors,th_summary,play_volume) VALUES(41,3,1,'凉宫春日的1111消失','',1,'搞笑、校园、科幻','L','2018-01-11','2010','平野绫、杉田智和、茅原实里、青木沙耶香、后藤邑子、桑谷夏子','',0);
 */   

 CREATE TABLE pk_filmTV(
	v_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    t_id TINYINT(1) NOT NULL,
    f_name VARCHAR(100) UNIQUE NOT NULL,
    f_imgSrc VARCHAR(500) NOT NULL,
    f_status TINYINT(1) NOT NULL,
    /*f_episodes VARCHAR(4) NOT NULL,*/
    /*f_VGA VARCHAR(16),*/
    f_style VARCHAR(50) NOT NULL,
    f_initials VARCHAR(1) NOT NULL,
    f_playtime VARCHAR(10) NOT NULL,
    f_years VARCHAR(4) NOT NULL,
    f_actors VARCHAR(255) NOT NULL,
    f_summary VARCHAR(500) NOT NULL,
    play_volume INT NOT NULL DEFAULT 0,
    /*create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,*/
    FOREIGN KEY(t_id) REFERENCES pk_type(t_id));

/*
INSERT INTO pk_filmTV(v_id,t_id,f_name,f_imgSrc,f_status,f_style,f_initials,f_playtime,f_years,f_actors,f_summary,play_volume) VALUES(1,4,'我是大54哥大','',1,'剧情、喜剧','W','2018-01-11','2018','贺来贤人、伊藤健太郎、太贺、矢本悠马、清野菜名、桥本环奈、铃木伸之','',0);
INSERT INTO pk_filmTV(v_id,t_id,f_name,f_imgSrc,f_status,f_style,f_initials,f_playtime,f_years,f_actors,f_summary,play_volume) VALUES(2,4,'你是大654哥大','',1,'剧情、喜剧','W','2018-01-11','2018','贺来贤人、伊藤健太郎、太贺、矢本悠马、清野菜名、桥本环奈、铃木伸之','',0);
INSERT INTO pk_filmTV(v_id,t_id,f_name,f_imgSrc,f_status,f_style,f_initials,f_playtime,f_years,f_actors,f_summary,play_volume) VALUES(3,4,'他是大64554哥大','',1,'剧情、喜剧','W','2018-01-11','2018','贺来贤人、伊藤健太郎、太贺、矢本悠马、清野菜名、桥本环奈、铃木伸之','',0);
INSERT INTO pk_filmTV(v_id,t_id,f_name,f_imgSrc,f_status,f_style,f_initials,f_playtime,f_years,f_actors,f_summary,play_volume) VALUES(4,4,'狗是大6456543哥大','',1,'剧情、喜剧','W','2018-01-11','2018','贺来贤人、伊藤健太郎、太贺、矢本悠马、清野菜名、桥本环奈、铃木伸之','',0);
INSERT INTO pk_filmTV(v_id,t_id,f_name,f_imgSrc,f_status,f_style,f_initials,f_playtime,f_years,f_actors,f_summary,play_volume) VALUES(5,4,'猪是54645大哥大','',1,'剧情、喜剧','W','2018-01-11','2018','贺来贤人、伊藤健太郎、太贺、矢本悠马、清野菜名、桥本环奈、铃木伸之','',0);
*/
CREATE TABLE pk_resources(
	r_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
	v_id INT NOT NULL,
    t_id TINYINT(1) NOT NULL,
    r_episode INT(4) NOT NULL DEFAULT 1,
    r_address VARCHAR(500) NOT NULL,
    /*PRIMARY KEY(v_id,r_t_id,r_episode),
    FOREIGN KEY(v_id) REFERENCES pk_bangumi(v_id),
    FOREIGN KEY(v_id) REFERENCES pk_guoman(v_id),
    FOREIGN KEY(v_id) REFERENCES pk_theater(v_id),
    FOREIGN KEY(v_id) REFERENCES pk_filmTV(v_id),*/
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    FOREIGN KEY(t_id) REFERENCES pk_type(t_id));
/*
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(1,1,1,1,'http://vwecam.tc.qq.com/1006_73bd7b4141aa4aa992eb9efe5552dbbb.f0.mp4?vkey=C24CB5A21746FCDB549B55244A2E0D550523DF84743F8E478867F82CA7E3FA57D13B4D30AC7BDAA1E08D0FB6D868356DB242004886822F8C');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(2,1,1,2,'http://vwecam.tc.qq.com/1006_5a17a1a7b5644faead2a156fb26ddbbb.f0.mp4?vkey=9E10CF877CF926D28DF20E9D361FB070E39F879262F1680518E98102D22D209B25494BC95BD696BC5F57E284CBFE8D0A7A0B45C578162080');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(3,1,1,3,'http://vwecam.tc.qq.com/1006_dd00134fbda9401192fc6f42d442dbbb.f0.mp4?vkey=810738B28D39B0E2A7A959A33A2C7CDD6C111D60E04BB27EC69B1B5537570BEF4B69B99CCF385C60BDFF80E67A36168C327468F800D9AB17');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(4,1,1,4,'http://vwecam.tc.qq.com/1006_b5f19da3c5804061b33e4ed70f9adbbb.f0.mp4?vkey=69ECA913CEB2CB14052139CF42D8CFC75A63B0C884B79ED82A438C2A65A2F84371AFE6E0D19BC582D68802C4B53000254157DD4010C93D9D');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(5,1,1,5,'http://vwecam.tc.qq.com/1006_d9a0a6af25db48bea711ce5f48ccdbbb.f0.mp4?vkey=59E08426F0A76C394E62F09C427ECE611553FF9B542E29462D173A895E4C22810B1F59150712FB6AB88F1BD036F4F3713F38D7189251987F');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(6,1,1,6,'http://vwecam.tc.qq.com/1006_0c361eca6c034cb49d0370075051dbbb.f0.mp4?vkey=E6CAAAD2B404D1C61343312664959BC8C4997F510376F9FC06FE7685E10D18D8A441CBC3FC717ADA4F51ADF78E048EE1D26CD4EBF01DC777');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(7,1,1,7,'http://vwecam.tc.qq.com/1006_24ed7843b958465ab92b76086d78dbbb.f0.mp4?vkey=C843165FAB06B60C9B95ADA0EECA7CD6B7B5CDDB2B924C71C7FE98AB11C7209FF9E38F9C9E616322CA638E4FBC4D9B33D1F7FBA5F22D8989	');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(8,1,1,8,'http://vwecam.tc.qq.com/1006_eed74e22e51447fdab55e94f4186dbbb.f0.mp4?vkey=ECC21D9617B7EF9B73B3CFB46D0281C9130A25B11FCA7E461FD788A6E19204C8C898FC388B56D88BF2310FFBB8EA9F9222BDAA09FE05FA59');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(9,1,1,9,'http://vwecam.tc.qq.com/1006_fb3794c49fb346e5a52f5b03a393dbbb.f0.mp4?vkey=8CDA4C5830E0319BB19355E83571C386B9554E5B6D41DBEA825035E8318E2B4B0FC9498B456EA1DE959F37651CA63E223E781EE2D1CF9E0D');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(10,1,1,10,'http://vwecam.tc.qq.com/1006_3690474c84d347fe8615092b5226dbbb.f0.mp4?vkey=20708469F0836CB29584C07FB6D6CFCB852941648637CE75F37B2EA53E74E8717BBCC2830954C4B37C8EC8D3FC1E7FF58CD8BE5588F8CEC3');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(11,1,1,11,'http://vwecam.tc.qq.com/1006_66056945fab6476e9a733a289577dbbb.f0.mp4?vkey=E98857EA6CDC921C2D17EE85C9D2AD264B41009364844F5DE45B20E773A178883DD1B523886DE60EB3BE464FA6FF4E7877EB15E553463C58');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(12,1,1,12,'http://vwecam.tc.qq.com/1006_7886b1ca4a9b40fb9dd1bb09b443dbbb.f0.mp4?vkey=8CC3773F18363945DA50BCED49B6E90AB75E3BC0473ADE7A7A54A41AEED18C8F3106F25F6A7AB0FA540E7D82C770572D1BCEAD5E60D0DC5A');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(13,2,1,1,'http://vwecam.tc.qq.com/1006_63ccf88aecb241e08c5bb4db7753dbbb.f0.mp4?vkey=7EF4423683BFBE950AA8E83E96F6EC50D2E062DBD77930274616E00B7EEE0FD9766D67E58F0FB561E3187245131849223F2EF2EC58170940');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(14,2,1,2,'http://vwecam.tc.qq.com/1006_a0fe424030d44096bf0edbed9913dbbb.f0.mp4?vkey=B7357104ED9DFDE0B82C8C8709693A01D4CC593B4799B5DDE37AFB61C3E0801D8C4ED0E6272BC9AAF8570E0D77A7A26D02C4F84B0C0F20B9');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(15,2,1,3,'http://vwecam.tc.qq.com/1006_5a06cff4b0ed4718927d357446abdbbb.f0.mp4?vkey=6ED918633FE1E7C93EF4946840203E00892284703DE44E441ADD54E1812E3362CC4C1F8DBC29D3C53A54084268BEB7719E7241A890776684');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(16,2,1,4,'http://vwecam.tc.qq.com/1006_6ee37857b5c54c03b6720c44e297dbbb.f0.mp4?vkey=73178C1A7A2D1DF06F0FA44814552C50556CA051A1E8613B9105620FBE0A5CF292CC22B555C6FDAD10E9E1647E4ECD86E505EA73B9694999');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(17,2,1,5,'http://vwecam.tc.qq.com/1006_0d558cea1a2443559c16e4e13b7adbbb.f0.mp4?vkey=F15FDC8C1A90B7B0B4B7533F062EB9D90EAB1F84A519FAF111DE4327D09D5CF95FF99908A5EAD91D58C9C1F026A7F54FFE0226AE9FAFCE6D');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(18,2,1,6,'http://vwecam.tc.qq.com/1006_66e087bf186a487d9935d6f455f4dbbb.f0.mp4?vkey=B3927CF7E0CA9ECEFE1017593CB6C77DF8E9377B53B12BD0080F343DB068E31DFAED427A89EDE9F6BFE09B101D0C9A72A701B9A9BBB67DBF');

INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(19,1,2,1,'http://vwecam.tc.qq.com/1006_764fe484b2734ecb9ef1b42ca005b39f.f0.mp4?vkey=2A31D06EF6B1FCA8718533C0155ADE49F163D1CA1FE9032FAFE5E847B1D9636E38FE1DBC7A4C63BA2047A9E2702A79159E3E63C0CF42AC1B');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(20,1,2,2,'http://vwecam.tc.qq.com/1006_0d642005b8274dd482ca26f539b2eb27.f0.mp4?vkey=09A45215C74EBA1DD203F221AEEF85E2484BC5B3F39F632EE752CD3A064D3E75BB1D5B8DAC09E5358BCF951D973B995C731A7BFEEC100D10');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(21,1,2,3,'http://vwecam.tc.qq.com/1006_7e37eecb4dc044518fc17f703d34a5ca.f0.mp4?vkey=ECF76F8B9A08D998021543D6E09A2AEA102D6B121C896B9FF45B1957B39A9B499AA749028744307594AFB4B8BD6648E2CC1626C113B12F7F');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(22,1,2,4,'http://vwecam.tc.qq.com/1006_4c025f8cc6ea4a06b8c50d61a5cedf2b.f0.mp4?vkey=CDFFE281610ABB4FC7E15936694EC888431716B5336A74A31C5C57177A7D2BE10572B6FA817317E9C57FD78D8D7E15152D96AA233E95A02F');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(23,1,2,5,'http://vwecam.tc.qq.com/1006_4ee74e70f1d7436ab93c83e7f66e1738.f0.mp4?vkey=075EB1BB38813E32CC7B2381DC20A3B8C4DC70AFDF1A0A369D8DABFFA0127CC3EC795F7EF5B17ABF67B92916DA07E5B0BB399B829EED996A');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(24,1,2,6,'http://vwecam.tc.qq.com/1006_c9c18c12107c4743b962f849a78da484.f0.mp4?vkey=784DFF6AA3C1395A74E56D9F5A6D4088AF9AF62B49D219E5D213747CB106B6B9C8C921D12DF1652AFED505886284D30463B5BF60DA697703');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(25,1,2,7,'http://vwecam.tc.qq.com/1006_377ee2e914cd4794b28fc497f2dfa2a9.f0.mp4?vkey=E8EA229B85E75C66934E3A6DEFFAF40408F2B9F059B4FFE85E44D9EE119165E702321EB53408B8936771F787D2CD6DB5A6DF8A1954BDA63C');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(26,1,2,8,'http://vwecam.tc.qq.com/1006_5462c8dff7be45b2948faf3b98031e0a.f0.mp4?vkey=BD8D8A6F8FADD22D89AD646CA73F50898CF72150B538E2DE488FAC9A439752147794791952823D5FA29F472227C12DEDFD5075C986FAF879');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(27,1,2,9,'http://vwecam.tc.qq.com/1006_69b72a96b8864cc19ea0b33c4a99ce77.f0.mp4?vkey=D5373D06E633E56F8D319ADB349EB1D8BD545BFFE338911DC5487E53CCC87A4A5964B3F0872EE72613C7690B5B4AB14BF7AEA39A71B48D05');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(28,1,2,10,'http://vwecam.tc.qq.com/1006_746825222a9c40b2af7bda139e40d95b.f20.mp4?vkey=8C82B0037E94FB8D53542AEB60C58C246E079332BE317A19339128155DEABEFD30DE249128FB1146C3916D9D81CF8341D78CD7B42587A043');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(29,1,2,11,'http://vwecam.tc.qq.com/1006_ea2c5bcd06084742a2121fad185701b6.f0.mp4?vkey=FC24384FC0B5AE05130D3481DF71FF821262272700FF4604305DB8411F9A6B062343786638949F3BEF5226DC029F904E24F77AFF3D73A371');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(30,1,2,12,'http://vwecam.tc.qq.com/1006_4843ce88a74c4648b76a9b928b058b56.f0.mp4?vkey=DE9E98B85188F22731258BEF287C60266770559BB00876837DBF480F02BA652AFCB353625D032553FDBD36FD0B3262BFD7CE9A4FE317EE4E');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(31,1,2,13,'http://vwecam.tc.qq.com/1006_a91ceac48bf541159c2f2d760f3a7a0f.f0.mp4?vkey=D0681ACDA1CFB79F4CB6CB03A378261B3F48656AA767796927BE52A9071FE8FE13B98AB6C6C1F7C41C670AEF91A6404092105493F56DDC06');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(32,1,2,14,'http://vwecam.tc.qq.com/1006_cd31ee8958844d339dda1c343b802290.f0.mp4?vkey=9C275936BB3968286C14DFCD4819829EF67BD47BF8BFE792210B6BA8F1E16FAC92EEFB6C786B71900C736922358C648F239EAD948F22E2D1');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(33,2,2,1,'http://photovideo.photo.qq.com/1075_0b53qyapoaaalqaox3yq3fpdhbqe66dab52a.f20.mp4?dis_k=67b7cc483cc2b7b1c795e7288babc92c&dis_t=1588079000&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(34,2,2,2,'http://photovideo.photo.qq.com/1075_0b53uyaqgaabkyab7marfbpdfjqeaotaca2a.f20.mp4?dis_k=9b67a6b7a8ef35f028b6ed00e17559e3&dis_t=1588079154&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(35,2,2,3,'http://photovideo.photo.qq.com/1075_0b535uaqcaab5yabygqrfvpdf3ieahwqcaka.f20.mp4?dis_k=9400774b9a199cd23787c3dcbd5acd12&dis_t=1588079206&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(36,2,2,4,'http://photovideo.photo.qq.com/1075_0b53aiaqsaabdiabibyrevpdeaqebebaccka.f20.mp4?dis_k=2bfb6911a565805807c8516ae20cd918&dis_t=1588079218&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(37,2,2,5,'http://photovideo.photo.qq.com/1075_0b53kaaqiaabpuabtnyrfzpdeuaeariacbca.f20.mp4?dis_k=e5371539c2881da97bac3287ec373691&dis_t=1588079229&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(38,2,2,6,'http://photovideo.photo.qq.com/1075_0b53fmaqiaabmmabtkarf5pdekyeaqvqcbca.f20.mp4?dis_k=e2aed8b35cc0ccd55ebcb2df40aa9df2&dis_t=1588079242&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(39,2,2,7,'http://photovideo.photo.qq.com/1075_0b5354aqeaabwiab6sirfzpdf3yealxqcasa.f20.mp4?dis_k=7e9680906c17952cc900c0d07a606d06&dis_t=1588079272&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(40,2,2,8,'http://photovideo.photo.qq.com/1075_0b53feaqkaableabrwyrf5pdekieauuqcbka.f20.mp4?dis_k=c269ad5d64656f64d49f53e00e1191be&dis_t=1588079284&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(41,2,2,9,'http://photovideo.photo.qq.com/1075_0b53yqaqkaabiaabr2yrfbpdfraeaxcacbka.f20.mp4?dis_k=9ee9c3ba7ce97481530a3bae1c32d647&dis_t=1588079296&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(42,2,2,10,'http://photovideo.photo.qq.com/1075_0b533eaqoaabimabv7irfrpdfwiea7mqcb2a.f20.mp4?dis_k=690db9d94f3ed592f070e749e0f812f4&dis_t=1588079310&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(43,2,2,11,'http://photovideo.photo.qq.com/1075_0b53yaaqiaaboaabslqrfzpdfqaeataacbca.f20.mp4?dis_k=e540e4f3781b4808fe18c6c8f25e60fb&dis_t=1588079325&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(44,2,2,12,'http://photovideo.photo.qq.com/1075_0b532qaqiaabcmabsxirfzpdfvaeatkacbca.f20.mp4?dis_k=d73f167319a2b96fa167eae3d3a456dd&dis_t=1588079337&vuin=1764307762');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(45,1,3,1,'https://gss3.baidu.com/6LZ0ej3k1Qd3ote6lo7D0j9wehsv/tieba-smallvideo/1250921_c7af3a2b73d03604f6421ef11134af72.mp4');
INSERT INTO pk_resources(r_id,v_id,t_id,r_episode,r_address) VALUES(46,1,3,2,'https://gss3.baidu.com/6LZ0ej3k1Qd3ote6lo7D0j9wehsv/tieba-smallvideo/19649098_ed7d2aa6e581dc648cdc860290429735.mp4');
*/
CREATE TABLE pk_comments(
	c_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    c_uid INT NOT NULL,
    v_id INT NOT NULL,
    t_id TINYINT(1) NOT NULL,
    c_content VARCHAR(255) NOT NULL,
    c_uname VARCHAR(48) NOT NULL,
    c_uavatar VARCHAR(500) NOT NULL,
    /*c_pubtime DATETIME NOT NULL,*/
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    FOREIGN KEY(c_uid) REFERENCES pk_user(u_id),
    /*FOREIGN KEY(c_vid) REFERENCES pk_bangumi(ID),
    FOREIGN KEY(c_vid) REFERENCES pk_guoman(ID),
    FOREIGN KEY(c_vid) REFERENCES pk_theater(ID),
    FOREIGN KEY(c_vid) REFERENCES pk_filmTV(ID),*/
    FOREIGN KEY(t_id) REFERENCES pk_type(t_id));
 /*   
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,1,'今天也要加油鸭1','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,1,1,'今天也要加油鸭2','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,1,'今天也要加油鸭3','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,1,'今天也要加油鸭4','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,1,1,'今天也要加油鸭5','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');

INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,1,'今天也要加油鸭1','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,2,1,'今天也要加油鸭2','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,1,'今天也要加油鸭3','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,1,'今天也要加油鸭4','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,2,1,'今天也要加油鸭5','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');

INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,2,'今天也要加油鸭1','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,1,2,'今天也要加油鸭2','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,2,'今天也要加油鸭3','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,2,'今天也要加油鸭4','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,1,2,'今天也要加油鸭5','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');

INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,2,'今天也要加油鸭1','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,2,2,'今天也要加油鸭2','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,2,'今天也要加油鸭3','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,2,'今天也要加油鸭4','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,2,2,'今天也要加油鸭5','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');

INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,3,'今天也要加油鸭1','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,1,3,'今天也要加油鸭2','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,3,'今天也要加油鸭3','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,3,'今天也要加油鸭4','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,1,3,'今天也要加油鸭5','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');

INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,3,'今天也要加油鸭1','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,2,3,'今天也要加油鸭2','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,3,'今天也要加油鸭3','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,3,'今天也要加油鸭4','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,2,3,'今天也要加油鸭5','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');

INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,4,'今天也要加油鸭1','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,1,4,'今天也要加油鸭2','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,4,'今天也要加油鸭3','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,1,4,'今天也要加油鸭4','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,1,4,'今天也要加油鸭5','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');

INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,4,'今天也要加油鸭1','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,2,4,'今天也要加油鸭2','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,4,'今天也要加油鸭3','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(1,2,4,'今天也要加油鸭4','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
INSERT INTO pk_comments(c_uid,v_id,t_id,c_content,c_uname,c_uavatar) VALUES(2,2,4,'今天也要加油鸭5','Dragon.Mr','wwwwwwwwwwwwwwwwwwwwwwwwwww');
*/
CREATE TABLE pk_admin(
	a_id INT UNIQUE NOT NULL AUTO_INCREMENT PRIMARY KEY,
    a_name VARCHAR(18) NOT NULL,
    a_password VARCHAR(16) NOT NULL,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

delete from pk_resources where r_id=46;
    