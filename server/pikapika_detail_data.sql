/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50724
Source Host           : localhost:3306
Source Database       : pikapika

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2020-05-08 12:13:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pk_admin
-- ----------------------------
DROP TABLE IF EXISTS `pk_admin`;
CREATE TABLE `pk_admin` (
  `a_id` int(11) NOT NULL AUTO_INCREMENT,
  `a_name` varchar(18) NOT NULL,
  `a_password` varchar(16) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`a_id`),
  UNIQUE KEY `a_id` (`a_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pk_admin
-- ----------------------------

-- ----------------------------
-- Table structure for pk_bangumi
-- ----------------------------
DROP TABLE IF EXISTS `pk_bangumi`;
CREATE TABLE `pk_bangumi` (
  `v_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_id` tinyint(1) NOT NULL,
  `b_name` varchar(100) NOT NULL,
  `b_imgSrc` varchar(500) NOT NULL,
  `b_status` tinyint(1) NOT NULL,
  `b_style` varchar(50) NOT NULL,
  `b_initials` varchar(1) NOT NULL,
  `b_playtime` varchar(10) NOT NULL,
  `b_quarter` varchar(2) NOT NULL,
  `b_years` varchar(4) NOT NULL,
  `b_actors` varchar(255) NOT NULL,
  `b_summary` varchar(500) NOT NULL,
  `play_volume` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`v_id`),
  UNIQUE KEY `v_id` (`v_id`),
  UNIQUE KEY `b_name` (`b_name`),
  KEY `t_id` (`t_id`),
  CONSTRAINT `pk_bangumi_ibfk_1` FOREIGN KEY (`t_id`) REFERENCES `pk_type` (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pk_bangumi
-- ----------------------------
INSERT INTO `pk_bangumi` VALUES ('1', '1', '无限系统树', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2546321469.webp', '1', '冒险、奇幻', 'W', '2020-01-09', '01', '2020', '齐藤壮马、大野柚布子、日野聪、小市真琴、高田忧希、村濑步、小仓唯、日笠阳子、悠木碧、春濑夏美、井泽诗织、铃村健一、东山奈央', '无限的冒险，如今拉开序幕——\n　　根据每位玩家的不同行为以及性格，游戏习惯等进化为具备独特能力的系统。装载了如此极具梦想的系统，全方位体感VRMMO，在面世一瞬间便引发舆论狂潮席卷全世界。ysgou.cc结束大学入学考试后在东京开始独居生活的椋鸟玲二，在兄长的邀请下，开始了其波澜万丈的冒险之旅——', '0', '2020-05-06 00:00:02');
INSERT INTO `pk_bangumi` VALUES ('2', '1', '巧克力与香子兰', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2561048692.webp', '1', '萌系、日常、治愈、游戏改', 'Q', '2018-07-21', '07', '2018', '立花慎之介、朋永真季、猪口有佳、永井真一、成濑未亚、小仓结衣、冈嶋妙、立石惠', '时间回到嘉祥担任店长的猫娘蛋糕店『La Soleil』开张的半年前，还是小猫的巧克力跟香草刚来到水无月家，还没跟其他猫娘们打成一片的时候。开始用「主人」称呼嘉祥，并且在水无月家度过第一个圣诞节的两人，和嘉祥立下了一个约定。NekoparaOVA的募资达标感谢礼，将为各位送上一段全新前传！', '0', '2020-05-06 00:07:15');
INSERT INTO `pk_bangumi` VALUES ('3', '1', 'NEW GAME!', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2412478173.webp', '1', '萌系、日常', 'N', '2016-07-26', '07', '2016', '高田忧希、日笠阳子、茅野爱衣、山口爱、户田惠、竹尾步美、朝日奈丸佳、森永千才、喜多村英梨', '高中毕业后，进入了曾制作自己自幼便入迷的游戏的制作公司“Eagle Jump”的青叶，在那里与担任这款游戏角色设计师的八神光相遇了。开始在憧憬的人手下工作的青叶，虽然对于第一次的工作感到困惑，但在以光为首的充满个性的前辈社员的帮助下一点一点地成长着。描绘在游戏公司工作的女孩子们的日常的工作女孩喜剧，现在开幕！', '8', '2020-05-06 00:16:50');
INSERT INTO `pk_bangumi` VALUES ('4', '1', 'Re：从零开始的异世界生活 新编集版 ', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2579702739.webp', '1', '小说改、穿越、奇幻、战斗', 'R', '2020-01-01', '01', '2020', '小林裕介、高桥李依、内山夕实、赤崎千夏、水濑祈、村川梨衣、新井里美、中村悠一', '在从便利商店回家的路上，突然被异世界召唤的少年菜月昴。在无法依靠任何东西的异世界，无力的少年手唯一的力量……那是“死去然后重新开始”的力量。为了守护最重要的人们，为了取回确实存在着又无可替代的时间，少年抗拒着绝望，勇敢地面对着残酷的命运。（本次新编集版在第一季动画基础上追加新场景，以2话合并成1话的形式制作成单集时长1小时的特别篇）', '2', '2020-05-06 00:19:43');
INSERT INTO `pk_bangumi` VALUES ('5', '1', '公主连结 Re:Dive', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2585851306.webp', '1', '奇幻、战斗、魔法、冒险', 'G', '2020-04-06', '04', '2020', 'M·A·O、立花理香、伊藤美来、阿部敦、高桥李依、泽城美雪、洲崎绫、日高里菜、诸星堇、小仓唯', '平静的风吹过美丽的大地——阿斯特莱亚大陆。在大陆的某个角落，失去记忆的少年佑树醒了过来。照顾他的小小指引者可可萝。总是饿肚子的美少女剑士佩可莉姆。有一点冷酷的猫耳魔法少女凯露。在命运的指引下，他们创立了名为“美食殿堂”的公会。现在，佑树和她们的冒险揭幕了。', '0', '2020-05-06 00:24:26');
INSERT INTO `pk_bangumi` VALUES ('6', '1', '苍之彼方的四重奏', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2306713388.webp', '2', '奇幻、运动、游戏改', 'C', '2016-01-11', '01', '2016', '逢坂良太、福圆美里、山本希望、米泽圆、若林直美、近藤孝行、种田梨沙、兴津和幸、绪方惠美、仪武佑子', '这是个因「反重力鞋」的问世，人人都能轻而易举地翱翔天空的世界。转校至久奈浜学院的仓科明日香，与新的同学鸢泽美咲、日向晶也相遇，得知了穿着「反重力鞋」竞技的比赛项目「Flying Circus」（简称FC）。迷上这项运动的明日香决意加入久奈浜学院的「FC部」，与其他伙伴一起挥洒青春的汗水。她们互帮互助，共同成长，向强力的对手发起挑战。目标——夏季大赛！', '10', '2020-05-06 00:32:03');
INSERT INTO `pk_bangumi` VALUES ('7', '1', '钢琴之森', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2512605626.webp', '1', '音乐、治愈、励志、漫画改', 'Q', '2018-04-09', '04', '2018', '齐藤壮马、诹访部顺一、花江夏树、中村悠一、KENN、伊濑茉莉也、小西克幸、丰永利行、游佐浩二、家中宏、白石凉子、大地叶、三宅麻理惠、广桥凉、熊井统子、坂本真绫、田中秀幸、岛田敏', '一之濑海是一位天才钢琴少年。小时候阿海凑巧弹奏一台位于森林的被废弃特殊钢琴，除了阿海以外无人能够奏响这个钢琴，通过这台特殊的钢琴阿海锻炼出了钢琴天赋，其弹奏力道比一般人要强，甚至是可以弹断琴弦。而因为钢琴阿海结识了因车祸结束演奏生涯的前天才钢琴师阿字野壮介，阿字野壮介也成为了阿海在钢琴方面的师父，同时阿海也遇到一生的朋友和对手雨宫修平——', '0', '2020-05-06 00:37:09');
INSERT INTO `pk_bangumi` VALUES ('8', '1', '家有圆圆？！我家的圆圆你知道吗？', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2559586335.webp', '1', '搞笑、治愈', 'J', '2020-01-09', '01', '2020', '齐藤壮马、小野贤章、白井悠介、花泽香菜、前野智昭、羽多野涉、 梶裕贵、梅原裕一郎', '1993年风靡东南亚的动画《猫狗宠物街》时隔26年即将推出拟人动画！这些熟悉的猫猫狗狗配上豪华声优阵容，会打造出怎样可爱的萌系动画呢？\n正在热播', '0', '2020-05-06 00:43:46');
INSERT INTO `pk_bangumi` VALUES ('9', '1', '恋爱小行星', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2563819038.webp', '2', '漫画改、搞笑、日常、治愈', 'L', '2020-01-03', '01', '2020', '高柳知叶、山口爱、指出球亚、东山奈央、上坂堇', '木之幡米拉在小时候与在露营地遇见的男生约定，“要找到小行星”。上了高中后她本打算加入天文社，但从今年开始“天文社”就和“地质研究会”合并成了“地学社”……！？和地学系女孩们一起，去寻找各种各样闪闪发亮的东西吧。', '0', '2020-05-06 00:47:04');
INSERT INTO `pk_bangumi` VALUES ('10', '1', '路人女主的养成方法', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2212217488.webp', '1', '恋爱、小说改', 'L', '2015-01-08', '01', '2015', '大地葉、松岡禎丞、大西沙織、茅野愛衣、安野希世乃、矢作紗友里、赤﨑千夏、柿原徹也、中原麻衣', '春假，为了赚得购入动画 BD 而打工的宅男·安艺伦也在樱花飞舞的道路上遇到了某个少女，对该少女感兴趣的伦也以她为模特制作了相关的同人游戏。一个月後，该少女成为了他的同班同学……为了制作游戏，伦也陆续找了美术部王牌来负责插画、学年第一名的学姐来写作剧本，一行人以 Comike为目标，开始进行相关的游戏制作。电视动画《路人女主的养成方法》改编自由丸户史明原作、深崎暮人负责插画的同名轻小说。作品讲述了身为御宅族的安芸伦也为了制作游戏，说服同年级美术部的绘画高手泽村·斯潘塞·英梨梨，以及优等生学姐霞之丘诗羽和女主角加藤惠，一起共组同人游戏社团，开始了同人游戏制作的故事。', '0', '2020-05-06 02:01:59');
INSERT INTO `pk_bangumi` VALUES ('11', '1', '请在伸展台上微笑', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2574890995.webp', '1', '喜剧、励志', 'Q', '2020-01-10', '01', '2020', ' 花守由美里 、花江夏树、茅野爱衣、木村良平、诹访部顺一、牧野由依', '拼上自己的一切闪耀吧！全世界的目光都将注视着你——梦想是巴黎COLLECTION的少女，身高却停滞在158CM，矮子不配拥有世界名模梦吗？可是，少女却是一个宁愿花去一生，也绝不放弃梦想的人……', '0', '2020-05-06 02:05:52');
INSERT INTO `pk_bangumi` VALUES ('12', '1', '世界第一初恋', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2567392495.webp', '1', '喜剧、爱情、动画', 'S', '2011-04-08', '10', '2017', '近藤隆、小西克幸、田村由香里、立花慎之介、中村悠一、冈本信彦、神谷浩史、前野智昭', '主人公小野寺律从父母的公司跳槽到丸川书店工作，却被分配到没有兴趣和经验的少女漫画部当编辑，工作后竟发现蛮横上司高野政宗是自己”初恋的人“。', '0', '2020-05-06 02:11:06');
INSERT INTO `pk_bangumi` VALUES ('13', '1', '无论何时我们的恋情都是10厘米。～告白实行委员会～', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2502733480.webp', '2', '恋爱、音乐、原创、校园', 'W', '2017-10-25', '10', '2017', '铃村健一、丰崎爱生、神谷浩史、户松遥、阿澄佳奈、绿川光', 'TV动画以《无论何时我们的恋情都是10厘米。》为题，于2017年11月25日开始播出，全6话。主角是芹泽春辉和合田美樱。', '0', '2020-05-06 02:13:41');
INSERT INTO `pk_bangumi` VALUES ('14', '1', '我们无法一起学习！', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2568130173.webp', '1', '漫画改、日常、校园、恋爱', 'W', '2019-10-06', '10', '2019', '逢坂良太、白石晴香、富田美忧、铃代纱弓、Lynn、朝日奈丸佳', '刻苦学习的高中3年生·唯我成幸，为了获得免除大学学费的“特别VIP推荐”资格，而要去担任为备考而苦战的同级生们的教育指导员。教导的对象是“文学之森的睡美人”古桥文乃和“机关精巧的拇指姑娘”绪方理珠这两位学园顶尖的天才美少女！原本以为她们的学习能力完美无缺，没想到对于不擅长的学科却完全无能……！？成幸一边被充满个性的“学不来女孩”们玩弄于股掌之间，一边为了让她们努力通过大学考试！无论学习还是恋爱都“学不来”的天才们的恋爱喜剧，就此开幕！！', '0', '2020-05-06 02:16:28');
INSERT INTO `pk_bangumi` VALUES ('15', '1', '虚构推理', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2558792910.webp', '1', '漫画改、神魔、恋爱、奇幻', 'X', '2020-01-12', '01', '2020', '鬼头明里、宫野真守、福圆美里、上坂堇、滨田贤二、佐古真弓、下山吉光', '成为“怪异”们的智慧之神，每天都在解决着“怪异”们带来的麻烦的少女·岩永琴子，她一见钟情的对象·樱川九郎，是个让“怪异”都感到畏惧的男人！？这样毫不普通的两人，迎战“怪异”们引发的神秘事件的［恋爱×传奇×推理］！！两人所面临的诡异事件，以及恋情将会迎来怎样的结局——！？', '0', '2020-05-06 02:18:51');
INSERT INTO `pk_bangumi` VALUES ('16', '1', '异世界四重奏', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2550985765.webp', '1', '原创、搞笑、日常', 'Y', '2019-04-09', '04', '2019', '日野聪、原由实、福岛润、雨宫天、小林裕介、高桥李依、悠木碧、早见沙织', '某天突然出现了一个神奇的按钮。按下按钮后，就转移到了另外一个异世界！！\n从其他世界转移而来的角色们在那里大集合……！？', '0', '2020-05-06 02:22:30');

-- ----------------------------
-- Table structure for pk_comments
-- ----------------------------
DROP TABLE IF EXISTS `pk_comments`;
CREATE TABLE `pk_comments` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `c_uid` int(11) NOT NULL,
  `v_id` int(11) NOT NULL,
  `t_id` tinyint(1) NOT NULL,
  `c_content` varchar(255) NOT NULL,
  `c_uname` varchar(48) NOT NULL,
  `c_uavatar` varchar(500) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`c_id`),
  UNIQUE KEY `c_id` (`c_id`),
  KEY `c_uid` (`c_uid`),
  KEY `t_id` (`t_id`),
  CONSTRAINT `pk_comments_ibfk_1` FOREIGN KEY (`c_uid`) REFERENCES `pk_user` (`u_id`),
  CONSTRAINT `pk_comments_ibfk_2` FOREIGN KEY (`t_id`) REFERENCES `pk_type` (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pk_comments
-- ----------------------------
INSERT INTO `pk_comments` VALUES ('20', '1', '5', '3', '哈哈哈哈哈哈', 'Dragon_Mr', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588879312997&di=91cc60ece4916ef83f52af3c7e664d3a&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F9fo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fwh%253D450%252C600%2Fsign%3Dc12a6c0f4736acaf59b59ef849e9a126%2Ff603918fa0ec08fa5bf83c9155ee3d6d55fbda0f.jpg', '2020-05-08 11:04:45');
INSERT INTO `pk_comments` VALUES ('21', '1', '5', '3', '开心', 'Dragon_Mr', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588879312997&di=91cc60ece4916ef83f52af3c7e664d3a&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F9fo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fwh%253D450%252C600%2Fsign%3Dc12a6c0f4736acaf59b59ef849e9a126%2Ff603918fa0ec08fa5bf83c9155ee3d6d55fbda0f.jpg', '2020-05-08 11:04:52');
INSERT INTO `pk_comments` VALUES ('22', '1', '5', '3', '开森\n', 'Dragon_Mr', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588879312997&di=91cc60ece4916ef83f52af3c7e664d3a&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F9fo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fwh%253D450%252C600%2Fsign%3Dc12a6c0f4736acaf59b59ef849e9a126%2Ff603918fa0ec08fa5bf83c9155ee3d6d55fbda0f.jpg', '2020-05-08 11:04:56');
INSERT INTO `pk_comments` VALUES ('23', '14', '3', '3', '？？？？', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 11:48:51');
INSERT INTO `pk_comments` VALUES ('24', '14', '3', '3', '哈哈哈', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 11:51:52');
INSERT INTO `pk_comments` VALUES ('25', '14', '3', '3', '怎么肥事', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 11:55:07');
INSERT INTO `pk_comments` VALUES ('26', '14', '3', '3', '别告我啊', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 11:56:00');
INSERT INTO `pk_comments` VALUES ('27', '14', '3', '3', 'a', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 11:57:59');
INSERT INTO `pk_comments` VALUES ('28', '14', '3', '3', 'ddd', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 11:58:44');
INSERT INTO `pk_comments` VALUES ('29', '14', '3', '3', '???', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 11:58:50');
INSERT INTO `pk_comments` VALUES ('30', '14', '3', '3', 'aaaaaaaaa', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 11:59:21');
INSERT INTO `pk_comments` VALUES ('31', '14', '3', '3', 'aa', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:00:15');
INSERT INTO `pk_comments` VALUES ('32', '14', '3', '3', '呵', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:02:31');
INSERT INTO `pk_comments` VALUES ('33', '14', '3', '3', '哼哼', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:02:36');
INSERT INTO `pk_comments` VALUES ('34', '14', '7', '3', '哈哈哈哈哈哈', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:02:46');
INSERT INTO `pk_comments` VALUES ('35', '14', '7', '3', '？', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:03:15');
INSERT INTO `pk_comments` VALUES ('36', '14', '7', '3', '？？？', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:04:03');
INSERT INTO `pk_comments` VALUES ('37', '14', '3', '3', 'd', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:04:49');
INSERT INTO `pk_comments` VALUES ('38', '14', '3', '3', 'aaa', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:04:52');
INSERT INTO `pk_comments` VALUES ('39', '14', '7', '3', 'aaa', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:05:03');
INSERT INTO `pk_comments` VALUES ('40', '14', '3', '3', 'ddd', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:06:00');
INSERT INTO `pk_comments` VALUES ('41', '14', '3', '3', 'aaaaaaaaaaaaaaaaaaaa', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:06:03');
INSERT INTO `pk_comments` VALUES ('42', '14', '7', '3', 'ddddd', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:06:15');
INSERT INTO `pk_comments` VALUES ('43', '14', '7', '3', '行了嘛？', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:08:24');
INSERT INTO `pk_comments` VALUES ('44', '14', '7', '3', '呵', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:08:28');
INSERT INTO `pk_comments` VALUES ('45', '14', '1', '3', 'aaa', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:08:35');
INSERT INTO `pk_comments` VALUES ('46', '14', '1', '3', '哈哈哈哈哈哈哈', 'aaaa', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 12:08:43');
INSERT INTO `pk_comments` VALUES ('47', '1', '1', '3', 'en?', 'Dragon_Mr', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588879312997&di=91cc60ece4916ef83f52af3c7e664d3a&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F9fo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fwh%253D450%252C600%2Fsign%3Dc12a6c0f4736acaf59b59ef849e9a126%2Ff603918fa0ec08fa5bf83c9155ee3d6d55fbda0f.jpg', '2020-05-08 12:10:03');

-- ----------------------------
-- Table structure for pk_filmtv
-- ----------------------------
DROP TABLE IF EXISTS `pk_filmtv`;
CREATE TABLE `pk_filmtv` (
  `v_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_id` tinyint(1) NOT NULL,
  `f_name` varchar(100) NOT NULL,
  `f_imgSrc` varchar(500) NOT NULL,
  `f_status` tinyint(1) NOT NULL,
  `f_style` varchar(50) NOT NULL,
  `f_initials` varchar(1) NOT NULL,
  `f_playtime` varchar(10) NOT NULL,
  `f_years` varchar(4) NOT NULL,
  `f_actors` varchar(255) NOT NULL,
  `f_summary` varchar(500) NOT NULL,
  `play_volume` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`v_id`),
  UNIQUE KEY `v_id` (`v_id`),
  UNIQUE KEY `f_name` (`f_name`),
  KEY `t_id` (`t_id`),
  CONSTRAINT `pk_filmtv_ibfk_1` FOREIGN KEY (`t_id`) REFERENCES `pk_type` (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pk_filmtv
-- ----------------------------
INSERT INTO `pk_filmtv` VALUES ('1', '4', '大力女子都奉顺', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2423081660.webp', '1', '剧情', 'D', '2017-02-24', '2017', '朴宝英、朴炯植、金志洙、安宇延', '此剧讲述一个怪力女子都奉顺和一个独一无二的男子相爱并发生横冲直撞的浪漫爱情喜剧故事。是一部幻想、喜剧和动作结合的有趣故事，都奉顺拥有谁都超越不了的怪力，被她打了至少需要62周才能痊愈。玉氏南正基导演，亲爱的恩东啊编剧，2月24日首播', '0');
INSERT INTO `pk_filmtv` VALUES ('2', '4', '龙岭迷窟', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2593664928.webp', '1', '冒险、奇幻', 'L', '2020-04-01', '2020', '潘粤明、张雨绮、姜超、高伟光、佟磊', '胡八一，王胖子在潘家园遇到前来售卖半只绣花鞋的陕西古兰县村民，在经大金牙掌眼之后，获知此物价值极高，并得知还有一箱从棺材里获得的陪葬品，于是起了贪恋，三人与村民一道前往古兰县', '0');
INSERT INTO `pk_filmtv` VALUES ('3', '4', '清平乐', 'https://img9.doubanio.com/view/photo/m/public/p2594020386.webp', '1', '剧情、古装', 'J', '2020-04-07', '2020', '王凯、江疏影、任敏、杨玏、边程、叶祖新、喻恩泰', '电视剧《清平乐》以宋仁宗的一生为线索，既讲述了北宋皇帝赵祯从少年登基逐渐把控朝政到殚精竭虑爱民治国的故事，也表现了在风起云涌的朝堂背后，仁宗的情感抉择和喜怒哀乐。仁宗少年登基，掌控天下生杀大权，却因心中对百姓的慈悲仁爱，这至高的地位和权利带给他的反而是压力。他仰惧天变， 俯畏人言 ，治 国如执秤，如履薄冰地保持着朝堂与天下的种种平衡。仁宗朝河清海晏，名臣才子辈出，是中国古代史上著名的经济文化盛世，而这与仁宗一直以来遵循的“宽柔以教，不报无道”，并且广开言路也不无关系。然而同时，他却也牺牲了几乎所有“任性”的可能，无可选择地将女儿、妻子、爱妃包括他自己，置于无法逾越的孤城，也让自己在天下苍生与天子之爱，治国理念与骨肉亲情中百般挣扎，在理智与情感间难以取舍，展现了古代背景下，个人命运的无奈与抉择，即使生在帝王家，亦需承担起出身和时代赋予的责任和使命，为此必须舍弃生而为人的普通情感与喜乐。这其间，个人抉择如同涓涓细流在时代的浪潮中被湮没，而汇成浪潮的也正是这涓涓细流。', '0');
INSERT INTO `pk_filmtv` VALUES ('4', '4', '庆余年', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2575362797.webp', '1', '古装、剧情、穿越', 'Q', '2019-11-21', '2019', '张若昀、李沁、陈道明、吴刚、李小冉、袁泉、于荣光、辛芷蕾、李纯、宋轶', '某大学文学史专业的学生张庆熟读古典名著，但他用现代观念剖析古代文学史的论文命题不被叶教授所认可。为了让叶教授成为自己的研究生导师，张庆决定通过写小说的方式，进一步阐述自己想要表达的观点。\n　　在他的小说中，身世神秘的少年——范闲，自小跟随奶奶生活在海边小城澹州，随着一位老师的突然造访，他看似平静的生活开始直面重重的危机与考验。在神秘老师和一位蒙眼守护者的指点下，范闲熟识药性药理，修炼霸道真气并精进武艺，而后接连化解了诸多危局。因对身世之谜的好奇，范闲离开澹州，前赴京都。\n　　在京都，范闲凭借过人的智谋与勇武成为年轻一代的佼佼者，他先以诗文冠绝京都，而后出使邻国，营救人质，整合谍报网，查处震动朝野的走私案……这个过程中，范闲饱尝人间冷暖并坚守对正义、良善的坚持，历经家族、江湖、庙堂的种种考验与锤炼，书写了光彩的人生传奇。', '0');
INSERT INTO `pk_filmtv` VALUES ('5', '4', '三生三世枕上书', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2581729661.webp', '1', '剧情、爱情、奇幻', 'S', '2020-01-22', '2020', '迪丽热巴、高伟光、陈楚河、郭品超、刘雨欣', '青丘帝姬白凤九被东华帝君所救铭记在心，为报恩凤九去太晨宫做宫婢多年。后东华被锁入十恶莲花境，凤九化身灵狐救东华。此后，凤九便以灵狐身份相伴东华左右，得知东华要迎娶姬蘅做帝后，凤九伤心离去。后东华去凡间历劫，凤九亦相随。梵音谷中，凤九为取频婆果陷入阿兰若梦境，重历阿兰若与沉晔的过往，东华化身息泽救出凤九。和缈落的大战中，正义战胜邪恶，光明战胜黑暗，最终东华凤九终成眷属。', '0');
INSERT INTO `pk_filmtv` VALUES ('6', '4', '我是大哥大', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2543113206.webp', '1', '剧情、喜剧、校园', 'W', '2018-10-14', '2018', ' 贺来贤人、伊藤健太郎、桥本环奈、仲野太贺、矢本悠马、铃木伸之、 矶村勇斗', '故事发生在20世纪80年代，中学生三桥贵志（贺来贤人 饰）和伊藤真司（伊藤健太郎 饰）转学来到新的学校，为了看起来凶恶一点，他们不约而同改换了不良少年的打扮。刚刚入学，两人意外打倒十人，一战成名。此后他们结识了女校的戏精大姐大早川京子（桥本环奈 饰）、男校的大嗓门傻老大今井（太贺 饰）、今井的小跟班谷川（矢本悠马 饰）以及本校的功夫纪律委员赤坂理子（清野菜名 饰）。在与黑道分子和其他学校不良少年的抗争过程中，少男少女的友情不断加深，而爆笑沙雕的故事也接二连三的发生。三桥与伊藤的确度过了一段难忘的青春岁月……\n　　本片根据同名漫画改编。', '15');
INSERT INTO `pk_filmtv` VALUES ('7', '4', '爱情公寓5', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2580338609.webp', '2', '喜剧、爱情', 'A', '2020-01-12', '2020', '娄艺潇、孙艺洲、李金铭、李佳航、成果、万籽麟、张一铎', '经过多年的爱情长跑，爱情公寓的老住客们纷纷修成正果，他们中有的确定了恋爱关系，有的决定领证结婚。大家的爱情纷纷进入了新阶段，新的惊喜和新的烦恼都接踵而至。有的人在约会的过程中磕磕碰碰，有的人在筹备结婚的过程中鸡飞狗跳。爱情公寓仿佛是一个有魔力的地方，每一对真心相爱的情侣都能在这里获得祝福，走向美好。随着公寓浪漫的美名越传越远，新住客也慕名而来。新住客带来很多新观念、新玩法，让曾经都是时代弄潮儿的老住客们也自叹弗如。和新住客的青春活力相比，老住客们经过多年历练，对爱情和人生的态度更加成熟稳重。新老住客努力去理解对方，彼此帮助，即使磕磕碰碰，也要互相拥抱。铁打的公寓，流水的爱情，新的浪漫故事在这里不断上演。', '0');

-- ----------------------------
-- Table structure for pk_guoman
-- ----------------------------
DROP TABLE IF EXISTS `pk_guoman`;
CREATE TABLE `pk_guoman` (
  `v_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_id` tinyint(1) NOT NULL,
  `g_name` varchar(100) NOT NULL,
  `g_imgSrc` varchar(500) NOT NULL,
  `g_status` tinyint(1) NOT NULL,
  `g_style` varchar(50) NOT NULL,
  `g_initials` varchar(1) NOT NULL,
  `g_playtime` varchar(10) NOT NULL,
  `g_years` varchar(4) NOT NULL,
  `g_actors` varchar(255) NOT NULL,
  `g_summary` varchar(500) NOT NULL,
  `play_volume` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`v_id`),
  UNIQUE KEY `v_id` (`v_id`),
  UNIQUE KEY `g_name` (`g_name`),
  KEY `t_id` (`t_id`),
  CONSTRAINT `pk_guoman_ibfk_1` FOREIGN KEY (`t_id`) REFERENCES `pk_type` (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pk_guoman
-- ----------------------------
INSERT INTO `pk_guoman` VALUES ('1', '2', '爱神巧克力', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2292416309.webp', '1', '搞笑、恋爱、后宫、漫改', 'A', '2015-12-02', '2015', ' 沈达威、冯骏骅、醋醋、龟娘、杨鸥', '江浩一（沈达威 配音）是一个其貌不扬个性普通的平凡高中生，然而，这样的他却在某一天里成为了校园内诸多女生争相爱慕的对象，就连身处事件漩涡中心的江浩一都搞不懂究竟发生了什么。在校方正要对江浩一兴师问罪之际，时间停止了，爱神从天而降。\n　　爱神告诉江浩一，造成这一切混乱的原因，在于江浩一在误打误撞之中将被施了爱情魔法的巧克力分给了女生们，魔法使得女生们对江浩一产生了恋爱的错觉。要解决这个麻烦，江浩一必须一一帮助这些中了魔法的女生们实现她们心中真正的愿望，这对于性格有些内向的江浩一来说，可不是一件轻松的活计。', '0', '2020-05-06 08:37:59');
INSERT INTO `pk_guoman` VALUES ('2', '2', '爱神巧克力Ⅱ', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2512926816.webp', '1', '搞笑、后宫、恋爱、漫改', 'A', '2017-12-21', '2017', '沈达威、龟娘、冯骏骅、杨欧、醋醋', '校花竟然前来声称怀了自己的孩子?学姐前来斥责自己劈腿？……男主人公江浩一，凭借“爱神巧克力”的力量，获得了从天而来的美少女后宫。粉色系大小姐夏紫瞳，运动少女唐瑄，学霸眼镜娘林渊，再加上原本就喜欢着江浩一的病娇黑长直欧阳雪梨，还有一个每次出场都在吃东西的爱神妹子。', '0', '2020-05-06 08:44:03');
INSERT INTO `pk_guoman` VALUES ('3', '2', '百妖谱', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2579181722.webp', '1', '小说改、奇幻、治愈、古风', 'B', '2020-04-25', '2020', '赵小双、常蓉珊、曹云图、涂小鸦、李兰陵、李轻扬、藤新、姜英俊、郝祥海、图特哈蒙', '灵医桃夭，善恶如谜。金铃过处，片甲不留。讲百种妖怪，述世间沧桑。她是所有妖怪的救星，也是所有妖怪的噩梦。她带着磨牙小和尚行走江湖，也是鬼医桃夭。桃都鬼医桃夭只治妖怪不治人，她带着小和尚磨牙一起云游四方，顺道给各路妖怪治病。磨牙的跟班狐狸滚滚，加上她们的老邻居蛇妖柳公子，也先后加入结伴而行，在这妖怪横行、惊险重重，却又让人眷念的人间大显神通，为周围的妖怪治疗各种疑难杂症，也为这些妖怪周围的人类排忧解难。桃夭、磨牙和柳公子之间的关系不显山不露水，更多稀奇古怪的问题等着这个小团队一起去探索解决。冰山的一角...', '0', '2020-05-06 08:46:51');
INSERT INTO `pk_guoman` VALUES ('4', '2', '崩坏星河', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2555433539.webp', '1', '科幻', 'B', '2019-05-05', '2019', '谢添天、赵路、夏磊、刘北辰、醋醋', '崩坏星河动画正式定档：5月5日，腾讯视频独家开启！\n　　这是一场密谋已久的刺杀！\n　　广袤星河之战，一触即发！', '0', '2020-05-06 08:49:09');
INSERT INTO `pk_guoman` VALUES ('5', '2', '刺客伍六七', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2522418171.webp', '1', '搞笑、热血、战斗', 'C', '2018-04-25', '2018', '何小疯、姜SIR、段艺璇、赵成晨、刘小倩、朱蓉蓉、yuancongyu', '在某个小岛上，有一个可以伪装成任何东西的廉价刺客，名叫伍六七。平时看上去是个理发师，其实背地里却做着刺客生意。热爱理发事业，喜欢给人剪头发，善用剪刀——剪刀也是他的刺杀武器。由于初入刺客行当，行情十分廉价，因此接到的都是些奇葩的刺杀任务。在执行刺杀任务的过程中，与刺杀对象发生一系列有趣的意外事件。', '0', '2020-05-06 08:53:04');
INSERT INTO `pk_guoman` VALUES ('6', '2', '大王不高兴', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2563744716.webp', '1', '漫画改、搞笑、玄幻、泡面', 'D', '2020-01-01', '2020', '李诗萌、乔苏、星潮、郭浩然、谷江山、亚捷、金弦', '大家好，我是新上任的大王阎小罗，因胆小怕鬼，父王安排我到人间练胆。然而来自西大陆地界的迪曼和艾瑞肯未尝有一日放弃对东大陆天界和人间的觊觎。小黑小白，牛侍卫马统领和偶然捡到的小癸，会辅佐本王和他们周旋。', '0', '2020-05-06 09:03:57');
INSERT INTO `pk_guoman` VALUES ('7', '2', '帝王攻略', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2520100330.webp', '1', '小说改、古风', 'D', '2018-04-30', '2018', '苏尚卿、梁达伟、唐雅菁、孙晔、符冲、韩雨希、黄莺', '楚渊与段白月一个在朝堂一个在西南，所有人都以为他们是相互对立的关系，却没想到他们之间却并不是如此。为这大好河山，楚渊要做一个好皇帝，段白月便成为他最大的助力。', '0', '2020-05-06 09:06:00');
INSERT INTO `pk_guoman` VALUES ('8', '2', '斗罗大陆', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2510966013.webp', '1', '剧情、奇幻', 'D', '2018-01-20', '2018', '沈磊、程玉珠、黄翔宇、王肖兵、倪康', '唐门外门弟子唐三，因偷学内门绝学为唐门所不容，跳崖明志时却发现没有死，反而以另外一个身份来到了另一个世界，一个属于武魂的世界，名叫斗罗大陆。这里没有魔法，没有斗气，没有武术，却有神奇的武魂。这里的每个人，在自己六岁的时候，都会在武魂殿中令武魂觉醒。武魂有动物，有植物，有器物，武魂可以辅助人们的日常生活。而其中一些特别出色的武魂却可以用来修炼并进行战斗，这个职业，是斗罗大陆上最为强大也是最荣耀的职业“魂师”。\n　　小小的唐三在圣魂村开始了他的魂师修炼之路，并萌生了振兴唐门的梦想。当唐门暗器来到斗罗大陆，当唐三武魂觉醒，他能否在这片武魂的世界再铸唐门的辉煌？', '0', '2020-05-06 09:09:15');
INSERT INTO `pk_guoman` VALUES ('9', '2', '斗破苍穹 第三季', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2561727696.webp', '1', '奇幻、冒险、古装', 'D', '2019-07-21', '2019', '张沛、冯骏骅、杨梦露、黑石稔、袁国庆', '为从美杜莎女王手中夺取异火，萧炎在药老陪同下前往蛇人族居住的塔戈尔沙漠。却因口渴误闯绿洲，引来蛇人族高手月媚追杀。没有药老逆天协助的萧炎，眼看要被月媚杀死，生死存亡之际，幸得一位蒙面斗皇相救。不料蒙面斗皇一行人也为异火而来。美杜莎女王拒绝古河交换异火的条件，蒙面斗皇戳穿女王此刻是能量体，而真正的女王在某处准备吞噬异火，进化为斗宗。蛇人族攻击冒犯女王的古河等人，萧炎也在混战中感知到异火行踪，潜入女王所在的地心岛……', '0', '2020-05-06 09:13:43');
INSERT INTO `pk_guoman` VALUES ('10', '2', '斗破苍穹动画特别篇', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2500695765.webp', '2', '奇幻、冒险', 'D', '2017-09-13', '2017', '刘三木、杨梦露', '萧炎，萧家历史上空前绝后的斗气修炼天才。家族百年之内最年轻的斗者！\n　　三年之前，这名声望达到巅峰的天才少年，却是突兀的接受到了有生以来最残酷的打击，他辛辛苦苦修炼十数载方才凝聚的斗之气旋，一夜之间，化为乌有。而且体内的斗之气，也是随着时间的流逝，诡异地变得越来越少导致其实力不断地后退。一夜间，沦落成了路人口中嘲笑的废物！\n　　种种打击接踵而至，就在他即将绝望的时候，一缕幽魂（药尘又作药老）从他手上的戒指里浮现，一扇全新的大门在面前开启！\n　　原来，竟是有一不死魂魄吸收他的斗气，在药老灵魂停止吸收斗气后萧炎终于天赋重展，（有药老帮助）连连突破，震惊全城。\n　　萧炎重新成为家族年轻一辈中的最强斗者，然而他却不满足于此。 为了一雪退婚带来的耻辱，萧炎来到了魔兽山脉，在药老的帮助下，进一步提升自己的实力……\n　　在魔兽山脉，他结识了小医仙（厄难毒体），结为好友，抵御妖兽和企图不轨的敌人。他面向的世界更加宽阔。后又在药老的教导下，成为加玛帝国黑岩城最年轻的二品炼药师，（现已是九品玄丹炼药宗师）。为着他的执着与信念闯荡大陆，向着大陆巅峰强者迈进。年仅29岁便晋级斗帝境界并自封炎帝， 30岁成为斗', '0', '2020-05-06 09:19:05');
INSERT INTO `pk_guoman` VALUES ('11', '2', '国民老公带回家', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2406886486.webp', '1', '恋爱、乙女', 'L', '2017-01-06', '2017', '戴超行、陈奕雯、穆雪婷、赵路', '“不许公共场合碰我。” “不许公开说我是你妻子。” “不许让人知道我跟你住在一起。” 陆瑾年和乔安好因为父母之命被迫结婚。新婚之夜，安好跟瑾年一开口就连续说了三个不许…...她曾经爱了他整整十三年，他也同样，但是，他们并不知道彼此都深爱着对方....', '0', '2020-05-06 09:28:47');
INSERT INTO `pk_guoman` VALUES ('12', '2', '狐妖小红娘', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2253414171.webp', '1', '萌系、奇幻、恋爱、漫画改', 'H', '2015-06-26', '2015', '杨天翔、刘校妤、张杰、张凯、乔诗语、边江', '根据古典小说记载，世上有人有妖，妖会与人相恋，妖寿命千年，人的寿命有限，人死了，妖活着。人会投胎转世，但投胎以后不记得上辈子的爱。妖如果痴情的话，就去找狐妖“购买”一项服务，让投胎转世的人回忆起前世的爱……狐妖红娘这个角色就为此而诞生。作品主要讲述了以红娘为职业的狐妖，在为前世恋人牵红线的过程中发生的一系列有趣、神秘的故事。', '0', '2020-05-06 09:34:30');
INSERT INTO `pk_guoman` VALUES ('13', '2', '剑网3·侠肝义胆沈剑心', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2525155690.webp', '1', '搞笑、游戏改', 'J', '2018-09-21', '2018', '幽舞越山、宝木中阳、藤新、图特哈蒙、林强、彭尧、曹旭鹏', '沈剑心是一位稻香村的保安，平平无奇的他立志成为一代大侠。在拜入江湖大派——纯阳宫后，竟阴差阳错地领会了纯阳宫祖传的绝世秘籍。但他对于自己领悟的一身绝学却毫不知情。于是他步入江湖，逐渐成长，在盛世大唐的江湖纷争中见识了风风雨雨。一个拥有绝世武功的小透明，又将会在江湖中掀起怎样的风浪。', '1', '2020-05-06 09:38:38');
INSERT INTO `pk_guoman` VALUES ('14', '2', '剑网3·侠肝义胆沈剑心 第二季', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2574527150.webp', '1', '游戏改、搞笑、战斗', 'J', '2019-12-27', '2019', '幽舞越山、宝木中阳、藤新、杨默、郭盛、陈张太康', '拔出天道之剑的沈剑心信心满满，下山重回江湖。而此时的中原武林正面临着前所未有的危机。沈剑心因身负胎气原力和天道之剑，临危受命进入航海世界，卷入了层层阴谋之中。在沈剑心一行人的旅途中，意外接连不断地发生，神秘人物的身份也逐步揭晓……', '1', '2020-05-06 09:40:19');
INSERT INTO `pk_guoman` VALUES ('15', '2', '快把我哥带走 第二季', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2525944164.webp', '1', '搞笑、校园、日常、治愈', 'K', '2017-03-28', '2017', '边江、小连杀、皇贞季、新月冰冰、阿杰、北斗企鹅', '真的有哥哥的人才不会是兄控！”每天坑妹一万次的哥哥和暴走的妹妹相爱相杀，还有众多好基友加戏不断，日常小片段却会让人捧腹大笑不止。这个兄妹番才不是什么德国骨科......', '0', '2020-05-06 09:42:26');
INSERT INTO `pk_guoman` VALUES ('16', '2', '魔道祖师', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2523153760.webp', '1', '剧情、古装、玄幻', 'M', '2018-07-09', '2018', '阿杰、边江、郭浩然、金弦、刘三木', '温氏横行，生灵涂炭。江湖仙门义士发动“射日之征”，合力讨伐温氏。“夷陵老祖”魏无羡虽在推翻温氏中立下了汗马功劳，却因修非常道且太过强大而遭人忌惮坑害，致万人唾骂，被情同手足的师弟带人端了老巢，身陨形灭……\n　　十三年后，魏无羡被人献舍，并再度与姑苏蓝氏蓝忘机、云梦江氏江澄等旧人相遇，前尘谜团未消，江湖疑云再起。\n　　而这一切恩怨情仇，都要从他们少年时说起……', '0', '2020-05-06 09:47:25');
INSERT INTO `pk_guoman` VALUES ('17', '2', '魔道祖师 第二季', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2566791848.webp', '1', '奇幻、古装', 'M', '2019-08-03', '2019', '阿杰、边江、郭浩然、苏尚卿、金弦', '莫家庄里，金光善的私生子莫玄羽献舍成功，随着一句在此恭迎夷陵老祖魏无羡，魏无羡得以重生。重生后的魏无羡必须满足莫玄羽的三个愿望才能不被诅咒反噬，在机缘巧合下，凶尸将莫家庄少爷莫子渊、随仆阿童、莫夫人等先后杀死。但是凶尸力量强大，虽然魏无羡暗 地里帮助蓝愿与蓝景仪驱除凶尸 却依旧苦难重重，就在魏无羡要绝杀的时候，蓝湛赶到压制住了鬼手。\n　　时隔13年，蓝湛和魏无羡再次见面了。魏无羡骑着小苹果慌慌张张地逃跑，不曾想却遇到金陵和江澄、以及鬼将军温宁。为了解除鬼将军带来的危机，魏无羡吹响竹笛将其制服。因为鬼将军只有夷陵老祖魏无羡才能控制，所以魏无羡的身份受到质疑，蓝忘机索性直接将其带回了云深不知处。', '0', '2020-05-06 09:52:24');
INSERT INTO `pk_guoman` VALUES ('18', '2', '全职高手 第一季', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2375449298.webp', '1', '热血、战斗、小说改', 'Q', '2017-04-07', '2017', '阿杰、C小调、叶清、夏磊、刘三木、宝木中阳、金弦', '根据蝴蝶蓝同名电子游戏竞技小说改编，一个被战队驱逐的超级职业选手离开老东家，进入网吧自行组建战队，结识了形形色色的优秀队员，打挑战赛杀回了《荣耀》的职业联盟，并获得了最高的荣誉重回巅峰。', '0', '2020-05-06 09:54:33');
INSERT INTO `pk_guoman` VALUES ('19', '2', '实验品家庭', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2530243087.webp', '1', '治愈、催泪、励志', 'S', '2018-04-10', '2018', '咩咩、山新、月夜桥、沈念如、瞳音、藤新、阎么么', '“长草的大姐、蜘蛛二姐、变狗的哥哥、会读心术的三姐、天才少年的我……与科学家父母组成了一个完整的一个家。除了我，大家都没有现代人的常识？！” 有一天，父母突然从生活中消失，五位少年少女在安排下到了另一个地方居住。 究竟他们能否顺利融入社会同时，也隐藏好自己的特异身份，甚至让人们接受他们呢......', '0', '2020-05-06 09:56:49');
INSERT INTO `pk_guoman` VALUES ('20', '2', '望古神话之天选者', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2594299930.webp', '1', '科幻', 'W', '2020-04-07', '2020', '佟心竹、王珍亮、杨天翔、齐斯伽、叶知秋', '堡垒纪元2115年，边境部队出身的女少校“位沁”，来到中央堡垒参加天选者选拔，并因暗中追查“边境惨案”而屡遭暗杀。此时，堡垒头号公敌“元一”策动了一场诡谲浩大的反抗行动。一时间，各方势力都被卷入这场行动。', '0', '2020-05-06 10:00:53');
INSERT INTO `pk_guoman` VALUES ('21', '2', '我开动物园那些年', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2579180298.webp', '1', '小说改、搞笑、日常、治愈', 'W', '2020-04-05', '2020', '苏尚卿、阿杰、李诗萌、赵熠彤、孙路路、钱琛、孙路路', '“新晋社畜”段佳泽，继承了一家濒临倒闭的动物园，然而被迫签订的一纸合约需要让他以生命为赌注，在短时间内扩大其经营规模；还迎来了一众合约附加的派遣员工：三足金乌“陆压”；九尾狐“有苏“；蛇精“白贞贞、小青”等；从此，段佳泽便开始了操碎了心，但似乎又乐在其中的创业之旅…', '0', '2020-05-06 10:02:36');
INSERT INTO `pk_guoman` VALUES ('22', '2', '雪鹰领主', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2543150942.webp', '1', '奇幻、武侠、古装', 'X', '2018-12-20', '2018', '郝祥海、杨凝、涂小鸦、李铫、藤新', '动画《雪鹰领主》改编自我吃西红柿小说《雪鹰领主》，由企鹅影视出品，米粒影业制作，将于12月20日在腾讯视频播出。\n　　主角东伯雪鹰是雪鹰领的领主，他痴迷练武，心性十分坚定，只要认准一件事绝不回头。他早早继任雪鹰领主，因此性格比较早熟，只有面对弟弟时才会露出孩子气的一面。', '0', '2020-05-06 10:05:41');
INSERT INTO `pk_guoman` VALUES ('23', '2', '妖精种植手册', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2580660011.webp', '1', '奇幻、小说改', 'Y', '2020-01-17', '2020', '高枫', '主人公园丁打算坐飞机去动漫乐园游玩，不料还未登机时却误入到了朵雅大陆。这个大陆是多元宇宙论中无限个宇宙集合中的其中一个。园丁见识到了美丽的朔月学院，地龙拉着的马车，天空中学员使用魔法决斗，对于游戏老玩家的园丁来说很快地适应和认知到了自己已经来到朵雅大陆的局面。', '0', '2020-05-06 10:08:09');
INSERT INTO `pk_guoman` VALUES ('24', '2', '妖神记之黑狱篇', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2594784874.webp', '1', '小说改、热血、玄幻', 'Y', '2020-04-08', '2020', '西呱双、柳知萧、张妮、秦且歌、柳川鱼、烈之流星、冷泉夜月', '聂离以为银翼世家家主制药为由，带着司空易的亲信离开领地。领地外，聂离和段剑联手制服了他们后，回到银翼世家领地引爆炎爆铭文，被监禁的伙伴们和奴隶借机逃离。银翼世家受到重创，聂离一行人顺利回到光辉之城。', '0', '2020-05-06 10:09:54');
INSERT INTO `pk_guoman` VALUES ('25', '2', '一人之下 第三季', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2561547232.webp', '1', '热血', 'Y', '2020-04-24', '2020', '曹云图、小连杀、彭尧、宝木中阳、阿杰', '罗天大醮之后，王也被武当除名回到了家中，却因为身怀“八奇技-风后奇门”遭人觊觎，家人遭人监视。王也万般无奈，在好友诸葛青的建议下向“哪都通”公司的求助，张楚岚携冯宝宝前来破案。张楚岚如何一展身手帮王也抓出幕后黑手？诸葛青和王也等人又将有怎样精彩的表现？觊觎“八奇技”的人究竟是谁？《一人之下-入世篇》即将揭晓！', '0', '2020-05-06 10:12:02');
INSERT INTO `pk_guoman` VALUES ('26', '2', '镇魂街 第一季', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2454653245.webp', '1', '热血、奇幻、战斗、漫画改', 'Z', '2016-04-29', '2016', '四刀辉彰、宝木中阳、郭盛、小连杀、齐克建、阿杰、藤新', '普通的应届大学毕业生夏铃在求职之际，收到了一条奇怪的面试通知，因此误入罗刹街并遭到了危险，幸而被镇魂将曹焱兵搭救。然而接触中，曹焱兵却发现，夏铃也是寄灵人。与此同时，夏铃开始遭到不明身份刺客的追杀，曹焱兵亦被卷入其中，二人的命运从此开始了交集，而在这一切的背后，似乎还隐藏着某些更加危险的秘密……', '0', '2020-05-06 10:14:19');
INSERT INTO `pk_guoman` VALUES ('27', '2', '镇魂街 第二季', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2574775186.webp', '1', '热血、奇幻、战斗、漫画改', 'Z', '2019-12-28', '2019', '图特哈蒙、四刀辉彰、郭盛、陈思宇、闫夜桥', '罗刹街镇魂将曹焱兵和寄灵人夏铃踏上修复灵槐之路，羽林街镇魂将南御夫却受命缉拿曹焱兵，恰有菩提街镇魂将北落师门出面平息事态。但南御夫心怀鬼胎，北落师门与女孩水儿也暗藏秘密，曹焱兵和夏铃又将如何应对。菩提树下，三方命运交结，最终会涌至何处。', '0', '2020-05-06 10:16:06');

-- ----------------------------
-- Table structure for pk_resources
-- ----------------------------
DROP TABLE IF EXISTS `pk_resources`;
CREATE TABLE `pk_resources` (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `v_id` int(11) NOT NULL,
  `t_id` tinyint(1) NOT NULL,
  `r_episode` int(4) NOT NULL DEFAULT '1',
  `r_address` varchar(500) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`r_id`),
  UNIQUE KEY `r_id` (`r_id`),
  KEY `t_id` (`t_id`),
  CONSTRAINT `pk_resources_ibfk_1` FOREIGN KEY (`t_id`) REFERENCES `pk_type` (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pk_resources
-- ----------------------------
INSERT INTO `pk_resources` VALUES ('1', '1', '1', '1', 'http://localhost:3000/videos/bangumi/Infinite_Dendragon/01.mp4', '2020-05-06 00:03:34');
INSERT INTO `pk_resources` VALUES ('2', '2', '1', '1', 'http://localhost:3000/videos/bangumi/NECOPARA/01.mp4', '2020-05-06 00:13:15');
INSERT INTO `pk_resources` VALUES ('3', '3', '1', '1', 'http://localhost:3000/videos/bangumi/NEW_GAME/01.mp4', '2020-05-06 00:17:40');
INSERT INTO `pk_resources` VALUES ('4', '4', '1', '1', 'http://localhost:3000/videos/bangumi/Re_从零开始的异世界生活_新编集版/01.mp4', '2020-05-06 00:22:27');
INSERT INTO `pk_resources` VALUES ('5', '5', '1', '1', 'http://localhost:3000/videos/bangumi/Re_公主连结/01.mp4', '2020-05-06 00:25:50');
INSERT INTO `pk_resources` VALUES ('6', '5', '1', '2', 'http://localhost:3000/videos/bangumi/Re_公主连结/02.mp4', '2020-05-06 00:26:34');
INSERT INTO `pk_resources` VALUES ('7', '5', '1', '3', 'http://localhost:3000/videos/bangumi/Re_公主连结/03.mp4', '2020-05-06 00:27:12');
INSERT INTO `pk_resources` VALUES ('8', '5', '1', '4', 'http://localhost:3000/videos/bangumi/Re_公主连结/04.mp4', '2020-05-06 00:27:36');
INSERT INTO `pk_resources` VALUES ('9', '6', '1', '1', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/01.mp4', '2020-05-06 00:32:36');
INSERT INTO `pk_resources` VALUES ('10', '6', '1', '2', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/02.mp4', '2020-05-06 00:32:46');
INSERT INTO `pk_resources` VALUES ('11', '6', '1', '3', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/03.mp4', '2020-05-06 00:32:54');
INSERT INTO `pk_resources` VALUES ('12', '6', '1', '4', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/04.mp4', '2020-05-06 00:33:09');
INSERT INTO `pk_resources` VALUES ('13', '6', '1', '5', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/05.mp4', '2020-05-06 00:33:16');
INSERT INTO `pk_resources` VALUES ('14', '6', '1', '6', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/06.mp4', '2020-05-06 00:33:24');
INSERT INTO `pk_resources` VALUES ('15', '6', '1', '7', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/07.mp4', '2020-05-06 00:33:34');
INSERT INTO `pk_resources` VALUES ('16', '6', '1', '8', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/08.mp4', '2020-05-06 00:33:41');
INSERT INTO `pk_resources` VALUES ('17', '6', '1', '9', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/09.mp4', '2020-05-06 00:33:50');
INSERT INTO `pk_resources` VALUES ('18', '6', '1', '10', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/10.mp4', '2020-05-06 00:34:05');
INSERT INTO `pk_resources` VALUES ('19', '6', '1', '11', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/11.mp4', '2020-05-06 00:34:17');
INSERT INTO `pk_resources` VALUES ('20', '6', '1', '12', 'http://localhost:3000/videos/bangumi/苍之彼方的四重奏/12.mp4', '2020-05-06 00:34:26');
INSERT INTO `pk_resources` VALUES ('21', '7', '1', '1', 'http://localhost:3000/videos/bangumi/钢琴之森/01.mp4', '2020-05-06 00:37:34');
INSERT INTO `pk_resources` VALUES ('22', '8', '1', '1', 'http://localhost:3000/videos/bangumi/家有圆圆_我家的圆圆你知道吗/01.mp4', '2020-05-06 00:45:13');
INSERT INTO `pk_resources` VALUES ('28', '9', '1', '1', 'http://localhost:3000/videos/bangumi/恋爱小行星/01.mp4', '2020-05-06 01:07:33');
INSERT INTO `pk_resources` VALUES ('29', '9', '1', '2', 'http://localhost:3000/videos/bangumi/恋爱小行星/02.mp4', '2020-05-06 01:23:43');
INSERT INTO `pk_resources` VALUES ('40', '9', '1', '3', 'http://localhost:3000/videos/bangumi/恋爱小行星/03.mp4', '2020-05-06 01:51:55');
INSERT INTO `pk_resources` VALUES ('41', '9', '1', '4', 'http://localhost:3000/videos/bangumi/恋爱小行星/04.mp4', '2020-05-06 01:51:57');
INSERT INTO `pk_resources` VALUES ('42', '9', '1', '5', 'http://localhost:3000/videos/bangumi/恋爱小行星/05.mp4', '2020-05-06 01:51:58');
INSERT INTO `pk_resources` VALUES ('43', '9', '1', '6', 'http://localhost:3000/videos/bangumi/恋爱小行星/06.mp4', '2020-05-06 01:52:04');
INSERT INTO `pk_resources` VALUES ('44', '9', '1', '7', 'http://localhost:3000/videos/bangumi/恋爱小行星/07.mp4', '2020-05-06 01:52:07');
INSERT INTO `pk_resources` VALUES ('45', '9', '1', '8', 'http://localhost:3000/videos/bangumi/恋爱小行星/08.mp4', '2020-05-06 01:52:09');
INSERT INTO `pk_resources` VALUES ('46', '9', '1', '9', 'http://localhost:3000/videos/bangumi/恋爱小行星/09.mp4', '2020-05-06 01:52:11');
INSERT INTO `pk_resources` VALUES ('47', '9', '1', '10', 'http://localhost:3000/videos/bangumi/恋爱小行星/10.mp4', '2020-05-06 01:53:19');
INSERT INTO `pk_resources` VALUES ('48', '9', '1', '11', 'http://localhost:3000/videos/bangumi/恋爱小行星/11.mp4', '2020-05-06 01:53:22');
INSERT INTO `pk_resources` VALUES ('49', '9', '1', '12', 'http://localhost:3000/videos/bangumi/恋爱小行星/12.mp4', '2020-05-06 01:53:25');
INSERT INTO `pk_resources` VALUES ('50', '10', '1', '1', 'http://localhost:3000/videos/bangumi/路人女主的养成方法/00.mp4', '2020-05-06 02:02:29');
INSERT INTO `pk_resources` VALUES ('51', '10', '1', '2', 'http://localhost:3000/videos/bangumi/路人女主的养成方法/01.mp4', '2020-05-06 02:02:41');
INSERT INTO `pk_resources` VALUES ('52', '11', '1', '1', 'http://localhost:3000/videos/bangumi/请在伸展台上微笑/01.mp4', '2020-05-06 02:06:16');
INSERT INTO `pk_resources` VALUES ('53', '12', '1', '1', 'http://localhost:3000/videos/bangumi/世界第一初恋 _第一季/01.mp4', '2020-05-06 02:11:30');
INSERT INTO `pk_resources` VALUES ('54', '13', '1', '1', 'http://localhost:3000/videos/bangumi/我们的爱总是只有10厘米/01.mp4', '2020-05-06 02:14:04');
INSERT INTO `pk_resources` VALUES ('55', '13', '1', '2', 'http://localhost:3000/videos/bangumi/我们的爱总是只有10厘米/02.mp4', '2020-05-06 02:14:13');
INSERT INTO `pk_resources` VALUES ('56', '13', '1', '3', 'http://localhost:3000/videos/bangumi/我们的爱总是只有10厘米/03.mp4', '2020-05-06 02:14:16');
INSERT INTO `pk_resources` VALUES ('57', '13', '1', '4', 'http://localhost:3000/videos/bangumi/我们的爱总是只有10厘米/04.mp4', '2020-05-06 02:14:18');
INSERT INTO `pk_resources` VALUES ('58', '13', '1', '5', 'http://localhost:3000/videos/bangumi/我们的爱总是只有10厘米/05.mp4', '2020-05-06 02:14:21');
INSERT INTO `pk_resources` VALUES ('59', '13', '1', '6', 'http://localhost:3000/videos/bangumi/我们的爱总是只有10厘米/06.mp4', '2020-05-06 02:14:23');
INSERT INTO `pk_resources` VALUES ('60', '14', '1', '1', 'http://localhost:3000/videos/bangumi/我们无法一起学习_第二季/01.mp4', '2020-05-06 02:16:54');
INSERT INTO `pk_resources` VALUES ('61', '15', '1', '1', 'http://localhost:3000/videos/bangumi/虚构推理/01.mp4', '2020-05-06 02:19:11');
INSERT INTO `pk_resources` VALUES ('62', '16', '1', '1', 'http://localhost:3000/videos/bangumi/异世界四重奏/01.mp4', '2020-05-06 02:22:50');
INSERT INTO `pk_resources` VALUES ('63', '1', '4', '1', 'http://localhost:3000/videos/filmtv/大力女子都奉顺/01.mp4', '2020-05-06 02:26:14');
INSERT INTO `pk_resources` VALUES ('64', '2', '4', '1', 'http://localhost:3000/videos/filmtv/龙岭迷窟/01.mp4', '2020-05-06 02:29:46');
INSERT INTO `pk_resources` VALUES ('65', '3', '4', '1', 'http://localhost:3000/videos/filmtv/清平乐/01.mp4', '2020-05-06 02:32:18');
INSERT INTO `pk_resources` VALUES ('66', '4', '4', '1', 'http://localhost:3000/videos/filmtv/庆余年/01.mp4', '2020-05-06 08:29:08');
INSERT INTO `pk_resources` VALUES ('67', '4', '4', '2', 'http://localhost:3000/videos/filmtv/庆余年/02.mp4', '2020-05-06 08:29:09');
INSERT INTO `pk_resources` VALUES ('68', '4', '4', '3', 'http://localhost:3000/videos/filmtv/庆余年/03.mp4', '2020-05-06 08:29:13');
INSERT INTO `pk_resources` VALUES ('69', '4', '4', '4', 'http://localhost:3000/videos/filmtv/庆余年/04.mp4', '2020-05-06 08:29:15');
INSERT INTO `pk_resources` VALUES ('70', '4', '4', '5', 'http://localhost:3000/videos/filmtv/庆余年/05.mp4', '2020-05-06 08:29:17');
INSERT INTO `pk_resources` VALUES ('71', '4', '4', '6', 'http://localhost:3000/videos/filmtv/庆余年/06.mp4', '2020-05-06 08:29:20');
INSERT INTO `pk_resources` VALUES ('72', '5', '4', '1', 'http://localhost:3000/videos/filmtv/三生三世枕上书/01.mp4', '2020-05-06 08:31:40');
INSERT INTO `pk_resources` VALUES ('73', '6', '4', '1', 'http://localhost:3000/videos/filmtv/我是大哥大/01.mp4', '2020-05-06 08:34:27');
INSERT INTO `pk_resources` VALUES ('74', '1', '2', '1', 'http://localhost:3000/videos/guoman/爱神巧克力/01.mp4', '2020-05-06 08:38:22');
INSERT INTO `pk_resources` VALUES ('75', '2', '2', '1', 'http://localhost:3000/videos/guoman/爱神巧克力_第二季/01.mp4', '2020-05-06 08:44:21');
INSERT INTO `pk_resources` VALUES ('76', '3', '2', '1', 'http://localhost:3000/videos/guoman/百妖谱/01.mp4', '2020-05-06 08:47:09');
INSERT INTO `pk_resources` VALUES ('77', '3', '2', '2', 'http://localhost:3000/videos/guoman/百妖谱/02.mp4', '2020-05-06 08:47:17');
INSERT INTO `pk_resources` VALUES ('78', '3', '2', '3', 'http://localhost:3000/videos/guoman/百妖谱/03.mp4', '2020-05-06 08:47:19');
INSERT INTO `pk_resources` VALUES ('79', '4', '2', '1', 'http://localhost:3000/videos/guoman/崩坏星河/01.mp4', '2020-05-06 08:49:27');
INSERT INTO `pk_resources` VALUES ('80', '5', '2', '1', 'http://localhost:3000/videos/guoman/刺客伍六七/01.mp4', '2020-05-06 08:53:22');
INSERT INTO `pk_resources` VALUES ('81', '6', '2', '1', 'http://localhost:3000/videos/guoman/大王不高兴/01.mp4', '2020-05-06 09:04:27');
INSERT INTO `pk_resources` VALUES ('82', '7', '2', '1', 'http://localhost:3000/videos/guoman/帝王攻略/帝王攻略01.MP4', '2020-05-06 09:06:25');
INSERT INTO `pk_resources` VALUES ('83', '8', '2', '1', 'http://localhost:3000/videos/guoman/斗罗大陆/01.mp4', '2020-05-06 09:09:40');
INSERT INTO `pk_resources` VALUES ('84', '8', '2', '2', 'http://localhost:3000/videos/guoman/斗罗大陆/02.mp4', '2020-05-06 09:09:55');
INSERT INTO `pk_resources` VALUES ('85', '8', '2', '3', 'http://localhost:3000/videos/guoman/斗罗大陆/03.mp4', '2020-05-06 09:09:57');
INSERT INTO `pk_resources` VALUES ('86', '8', '2', '4', 'http://localhost:3000/videos/guoman/斗罗大陆/04.mp4', '2020-05-06 09:09:59');
INSERT INTO `pk_resources` VALUES ('87', '8', '2', '5', 'http://localhost:3000/videos/guoman/斗罗大陆/05.mp4', '2020-05-06 09:10:01');
INSERT INTO `pk_resources` VALUES ('88', '8', '2', '6', 'http://localhost:3000/videos/guoman/斗罗大陆/06.mp4', '2020-05-06 09:10:03');
INSERT INTO `pk_resources` VALUES ('89', '8', '2', '7', 'http://localhost:3000/videos/guoman/斗罗大陆/07.mp4', '2020-05-06 09:10:06');
INSERT INTO `pk_resources` VALUES ('90', '8', '2', '8', 'http://localhost:3000/videos/guoman/斗罗大陆/08.mp4', '2020-05-06 09:10:20');
INSERT INTO `pk_resources` VALUES ('91', '8', '2', '9', 'http://localhost:3000/videos/guoman/斗罗大陆/09.mp4', '2020-05-06 09:10:23');
INSERT INTO `pk_resources` VALUES ('92', '8', '2', '10', 'http://localhost:3000/videos/guoman/斗罗大陆/10.mp4', '2020-05-06 09:10:26');
INSERT INTO `pk_resources` VALUES ('93', '8', '2', '11', 'http://localhost:3000/videos/guoman/斗罗大陆/11.mp4', '2020-05-06 09:10:55');
INSERT INTO `pk_resources` VALUES ('94', '8', '2', '12', 'http://localhost:3000/videos/guoman/斗罗大陆/12.mp4', '2020-05-06 09:10:58');
INSERT INTO `pk_resources` VALUES ('95', '9', '2', '1', 'http://localhost:3000/videos/guoman/斗破苍穹_第三季/01.mp4', '2020-05-06 09:14:34');
INSERT INTO `pk_resources` VALUES ('97', '10', '2', '1', 'http://localhost:3000/videos/guoman/斗破苍穹特别篇/01.mp4', '2020-05-06 09:23:32');
INSERT INTO `pk_resources` VALUES ('98', '11', '2', '1', 'http://localhost:3000/videos/guoman/国民老公带回家/01.mp4', '2020-05-06 09:29:05');
INSERT INTO `pk_resources` VALUES ('99', '12', '2', '1', 'http://localhost:3000/videos/guoman/狐妖小红娘/01.mp4', '2020-05-06 09:34:49');
INSERT INTO `pk_resources` VALUES ('100', '13', '2', '1', 'http://localhost:3000/videos/guoman/剑网3·侠肝义胆沈剑心/01.mp4', '2020-05-06 09:38:58');
INSERT INTO `pk_resources` VALUES ('101', '14', '2', '1', 'http://localhost:3000/videos/guoman/剑网3·侠肝义胆沈剑心_第二季/01.mp4', '2020-05-06 09:40:35');
INSERT INTO `pk_resources` VALUES ('102', '15', '2', '1', 'http://localhost:3000/videos/guoman/快把我哥带走_第二季/01.mp4', '2020-05-06 09:42:44');
INSERT INTO `pk_resources` VALUES ('103', '16', '2', '1', 'http://localhost:3000/videos/guoman/魔道祖师/01.MP4', '2020-05-06 09:47:39');
INSERT INTO `pk_resources` VALUES ('104', '17', '2', '1', 'http://localhost:3000/videos/guoman/魔道祖师_第二季/01.MP4', '2020-05-06 09:52:57');
INSERT INTO `pk_resources` VALUES ('105', '18', '2', '1', 'http://localhost:3000/videos/guoman/全职高手_第一季/01.MP4', '2020-05-06 09:54:51');
INSERT INTO `pk_resources` VALUES ('106', '19', '2', '1', 'http://localhost:3000/videos/guoman/试验品家庭/01.MP4', '2020-05-06 09:57:30');
INSERT INTO `pk_resources` VALUES ('107', '20', '2', '1', 'http://localhost:3000/videos/guoman/王古神话之天选者/01.MP4', '2020-05-06 10:01:06');
INSERT INTO `pk_resources` VALUES ('108', '21', '2', '1', 'http://localhost:3000/videos/guoman/我开动物园的那些年/01.MP4', '2020-05-06 10:02:59');
INSERT INTO `pk_resources` VALUES ('109', '21', '2', '2', 'http://localhost:3000/videos/guoman/我开动物园的那些年/02.MP4', '2020-05-06 10:03:06');
INSERT INTO `pk_resources` VALUES ('110', '21', '2', '3', 'http://localhost:3000/videos/guoman/我开动物园的那些年/03.MP4', '2020-05-06 10:03:09');
INSERT INTO `pk_resources` VALUES ('111', '21', '2', '4', 'http://localhost:3000/videos/guoman/我开动物园的那些年/04.MP4', '2020-05-06 10:03:10');
INSERT INTO `pk_resources` VALUES ('112', '21', '2', '5', 'http://localhost:3000/videos/guoman/我开动物园的那些年/05.MP4', '2020-05-06 10:03:13');
INSERT INTO `pk_resources` VALUES ('113', '21', '2', '6', 'http://localhost:3000/videos/guoman/我开动物园的那些年/06.MP4', '2020-05-06 10:03:15');
INSERT INTO `pk_resources` VALUES ('114', '22', '2', '1', 'http://localhost:3000/videos/guoman/雪鹰领主/01.MP4', '2020-05-06 10:05:57');
INSERT INTO `pk_resources` VALUES ('115', '23', '2', '1', 'http://localhost:3000/videos/guoman/妖精种植手册/01.MP4', '2020-05-06 10:08:28');
INSERT INTO `pk_resources` VALUES ('116', '24', '2', '1', 'http://localhost:3000/videos/guoman/妖神记之黑狱篇/01.MP4', '2020-05-06 10:10:05');
INSERT INTO `pk_resources` VALUES ('117', '25', '2', '1', 'http://localhost:3000/videos/guoman/一人之下_第三季/01.MP4', '2020-05-06 10:12:23');
INSERT INTO `pk_resources` VALUES ('118', '25', '2', '2', 'http://localhost:3000/videos/guoman/一人之下_第三季/02.MP4', '2020-05-06 10:12:41');
INSERT INTO `pk_resources` VALUES ('119', '25', '2', '3', 'http://localhost:3000/videos/guoman/一人之下_第三季/03.MP4', '2020-05-06 10:12:43');
INSERT INTO `pk_resources` VALUES ('120', '26', '2', '1', 'http://localhost:3000/videos/guoman/镇魂街_第二季/01.MP4', '2020-05-06 10:14:38');
INSERT INTO `pk_resources` VALUES ('121', '27', '2', '1', 'http://localhost:3000/videos/guoman/镇魂街_第一季/01.MP4', '2020-05-06 10:16:24');
INSERT INTO `pk_resources` VALUES ('122', '1', '3', '1', 'http://localhost:3000/videos/theater/ANOTHER_WORLD.mp4', '2020-05-06 10:26:16');
INSERT INTO `pk_resources` VALUES ('123', '2', '3', '1', 'http://localhost:3000/videos/theater/BanG_Dream!梦想协奏曲.mp4', '2020-05-06 10:29:46');
INSERT INTO `pk_resources` VALUES ('124', '3', '3', '1', 'http://localhost:3000/videos/theater/BLACKFOX.mp4', '2020-05-06 10:32:10');
INSERT INTO `pk_resources` VALUES ('125', '4', '3', '1', 'http://localhost:3000/videos/theater/CENCOROLL_CONNECT.mp4', '2020-05-06 10:48:04');
INSERT INTO `pk_resources` VALUES ('126', '5', '3', '1', 'http://localhost:3000/videos/theater/Fate_Kaleid liner_魔法少女☆伊莉雅_Prisma☆Phantasm.mp4', '2020-05-06 10:50:31');
INSERT INTO `pk_resources` VALUES ('127', '6', '3', '1', 'http://localhost:3000/videos/theater/Fate_Stay_night_Heaven\'s Feel II.lost butterifly.mp4', '2020-05-06 10:53:01');
INSERT INTO `pk_resources` VALUES ('128', '7', '3', '1', 'http://localhost:3000/videos/theater/Re 从零开始的异世界生活 雪之回忆.mp4', '2020-05-06 10:56:42');
INSERT INTO `pk_resources` VALUES ('129', '8', '3', '1', 'http://localhost:3000/videos/theater/Re_ 从零开始的异世界生活 冰结之绊.mp4', '2020-05-06 11:01:51');
INSERT INTO `pk_resources` VALUES ('130', '9', '3', '1', 'http://localhost:3000/videos/theater/薄暮.mp4', '2020-05-06 11:04:22');
INSERT INTO `pk_resources` VALUES ('131', '10', '3', '1', 'http://localhost:3000/videos/theater/朝花夕誓 于离别之朝束起希望之花.mp4', '2020-05-06 11:06:23');
INSERT INTO `pk_resources` VALUES ('132', '11', '3', '1', 'http://localhost:3000/videos/theater/吹响！上低音号~誓言的终章.mp4', '2020-05-06 11:09:08');
INSERT INTO `pk_resources` VALUES ('133', '12', '3', '1', 'http://localhost:3000/videos/theater/吹响吧！上低音号2 ~想要传达的旋律~.mp4', '2020-05-06 11:11:22');
INSERT INTO `pk_resources` VALUES ('134', '13', '3', '1', 'http://localhost:3000/videos/theater/刺猬索尼克.mp4', '2020-05-06 11:15:23');
INSERT INTO `pk_resources` VALUES ('135', '14', '3', '1', 'http://localhost:3000/videos/theater/哆啦A梦 大雄的南极大冒险.mp4', '2020-05-06 11:18:38');
INSERT INTO `pk_resources` VALUES ('136', '15', '3', '1', 'http://localhost:3000/videos/theater/花开伊吕波 甜蜜的家.mp4', '2020-05-06 11:22:01');
INSERT INTO `pk_resources` VALUES ('137', '16', '3', '1', 'http://localhost:3000/videos/theater/火影忍者剧场版 博人传.mp4', '2020-05-06 11:25:10');
INSERT INTO `pk_resources` VALUES ('138', '17', '3', '1', 'http://localhost:3000/videos/theater/机甲少女 FRAME ARMS GIRL～高高兴兴的幻境～.mp4', '2020-05-06 11:28:43');
INSERT INTO `pk_resources` VALUES ('139', '18', '3', '1', 'http://localhost:3000/videos/theater/境界的彼方 I\'LL BE HERE 未来篇.mp4', '2020-05-06 11:31:03');
INSERT INTO `pk_resources` VALUES ('140', '19', '3', '1', 'http://localhost:3000/videos/theater/境界的彼方 I\'LL BE HERE过去篇.mp4', '2020-05-06 11:32:54');
INSERT INTO `pk_resources` VALUES ('141', '20', '3', '1', 'http://localhost:3000/videos/theater/囧妈.mp4', '2020-05-06 11:35:00');
INSERT INTO `pk_resources` VALUES ('142', '21', '3', '1', 'http://localhost:3000/videos/theater/壳中少女 燃烧.mp4', '2020-05-06 11:37:19');
INSERT INTO `pk_resources` VALUES ('143', '22', '3', '1', 'http://localhost:3000/videos/theater/利兹与青鸟.mp4', '2020-05-06 11:39:36');
INSERT INTO `pk_resources` VALUES ('144', '23', '3', '1', 'http://localhost:3000/videos/theater/凉宫春日的消失.mp4', '2020-05-06 11:43:16');
INSERT INTO `pk_resources` VALUES ('145', '24', '3', '1', 'http://localhost:3000/videos/theater/名侦探柯南 绀青之拳.mp4', '2020-05-06 11:49:41');
INSERT INTO `pk_resources` VALUES ('146', '25', '3', '1', 'http://localhost:3000/videos/theater/名侦探柯南：唐红的恋歌.mp4', '2020-05-06 11:53:23');
INSERT INTO `pk_resources` VALUES ('147', '26', '3', '1', 'http://localhost:3000/videos/theater/哪吒之魔童降世.mp4', '2020-05-06 11:55:50');
INSERT INTO `pk_resources` VALUES ('148', '27', '3', '1', 'http://localhost:3000/videos/theater/你的名字.mp4', '2020-05-06 11:57:32');
INSERT INTO `pk_resources` VALUES ('149', '28', '3', '1', 'http://localhost:3000/videos/theater/你好世界.mp4', '2020-05-06 12:00:14');
INSERT INTO `pk_resources` VALUES ('150', '29', '3', '1', 'http://localhost:3000/videos/theater/牵牛花与加濑同学.mp4', '2020-05-06 12:01:57');
INSERT INTO `pk_resources` VALUES ('151', '30', '3', '1', 'http://localhost:3000/videos/theater/请问今天要来点兔子吗.mp4', '2020-05-06 12:04:45');
INSERT INTO `pk_resources` VALUES ('152', '31', '3', '1', 'http://localhost:3000/videos/theater/声之形.mp4', '2020-05-06 12:07:13');
INSERT INTO `pk_resources` VALUES ('153', '32', '3', '1', 'http://localhost:3000/videos/theater/泰坦尼克号.mp4', '2020-05-06 12:09:36');
INSERT INTO `pk_resources` VALUES ('154', '33', '3', '1', 'http://localhost:3000/videos/theater/天降之物剧场版：永远的我的鸟笼.mp4', '2020-05-06 12:26:26');
INSERT INTO `pk_resources` VALUES ('155', '34', '3', '1', 'http://localhost:3000/videos/theater/天气之子.mp4', '2020-05-06 12:28:22');
INSERT INTO `pk_resources` VALUES ('156', '35', '3', '1', 'http://localhost:3000/videos/theater/为美好的世界献上祝福! 紅傳説.mp4', '2020-05-06 12:30:25');
INSERT INTO `pk_resources` VALUES ('157', '36', '3', '1', 'http://localhost:3000/videos/theater/我们的七日战争.mp4', '2020-05-06 12:32:16');
INSERT INTO `pk_resources` VALUES ('158', '37', '3', '1', 'http://localhost:3000/videos/theater/我想吃掉你的胰脏.mp4', '2020-05-06 12:34:08');
INSERT INTO `pk_resources` VALUES ('159', '38', '3', '1', 'http://localhost:3000/videos/theater/夏目友人帐 缘结空蝉.mp4', '2020-05-06 12:36:32');
INSERT INTO `pk_resources` VALUES ('160', '40', '3', '1', 'http://localhost:3000/videos/theater/言叶之庭.mp4', '2020-05-06 12:40:49');
INSERT INTO `pk_resources` VALUES ('161', '41', '3', '1', 'http://localhost:3000/videos/theater/萤火之森.mp4', '2020-05-06 12:43:07');
INSERT INTO `pk_resources` VALUES ('162', '42', '3', '1', 'http://localhost:3000/videos/theater/游戏人生ZERO.mp4', '2020-05-06 12:45:41');
INSERT INTO `pk_resources` VALUES ('163', '43', '3', '1', 'http://localhost:3000/videos/theater/追逐繁星的孩子.mp4', '2020-05-06 12:48:36');
INSERT INTO `pk_resources` VALUES ('164', '44', '3', '1', 'http://localhost:3000/videos/theater/紫罗兰永恒花园外传：永远与自动手记人偶.mp4', '2020-05-06 12:51:29');

-- ----------------------------
-- Table structure for pk_theater
-- ----------------------------
DROP TABLE IF EXISTS `pk_theater`;
CREATE TABLE `pk_theater` (
  `v_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_id` tinyint(1) NOT NULL,
  `th_tag` tinyint(1) NOT NULL,
  `th_name` varchar(100) NOT NULL,
  `th_imgSrc` varchar(500) NOT NULL,
  `th_VGA` tinyint(1) NOT NULL,
  `th_style` varchar(50) NOT NULL,
  `th_initials` varchar(1) NOT NULL,
  `th_playtime` varchar(10) NOT NULL,
  `th_years` varchar(4) NOT NULL,
  `th_actors` varchar(255) NOT NULL,
  `th_summary` varchar(500) NOT NULL,
  `play_volume` int(11) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`v_id`),
  UNIQUE KEY `v_id` (`v_id`),
  UNIQUE KEY `th_name` (`th_name`),
  KEY `t_id` (`t_id`),
  CONSTRAINT `pk_theater_ibfk_1` FOREIGN KEY (`t_id`) REFERENCES `pk_type` (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pk_theater
-- ----------------------------
INSERT INTO `pk_theater` VALUES ('1', '3', '1', 'ANOTHER WORLD', 'https://wxt.sinaimg.cn/large/006MDjU7ly1g9cwb5tlzdj30ak0fwwfn.jpg', '1', '校园、科幻', 'A', '2019-09-13', '2019', '未知', '剧场版动画《HELLO WORLD》原创的衍生动画。即使世界毁灭了，和你的未来不放弃——故事以2027年的京都为舞台，讲述了主人公·男高中生·直实和自称来自10年后的未来的“直美”的青年·卡塔加吉奈美、同班同学·琉璃的现在和未来交错的世界的科幻青春爱情故事。第1话《Record 2027》、第2话《Record 2032》、第3话《Record 2036》以3个时间轴描绘…', '1', '2020-05-06 10:25:48');
INSERT INTO `pk_theater` VALUES ('2', '3', '1', 'BanG Dream! 梦想协奏曲 电影演唱会 ', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2571270241.webp', '1', '偶像、百合', 'B', '2019-09-13', '2019', '寺川爱美、大冢纱英、西本里美、大桥彩香、伊藤彩沙', '各キャラクターの声優が実際にバンド活動を展開するメディアミックスプロジェクト「BanG Dream!（バンドリ！）」の劇場版アニメ。花咲川女子学園で結成されたガールズバンド「Poppin’Party」、幼なじみの5人による王道ガールズロックバンド「Afterglow」、事務所の意向で生まれたアイドルバンド「Pastel＊Palettes」、重厚な世界観で観客を魅了する本格…', '0', '2020-05-06 10:29:15');
INSERT INTO `pk_theater` VALUES ('3', '3', '1', 'BLACKFOX', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2551501306.webp', '1', '战斗、奇幻、百合', 'B', '2019-10-05', '2019', '七濑彩夏、户松遥、大地叶、土田大、津田英三、藤原启治、丰崎爱生、鸟海浩辅、飞田展男、东地宏树、小山力也', '伫立于近未来大都市一角的忍者宅邸。 住在那里的忍者一族石动家的长女·律花，憧憬着身为研究人员的父亲。 她觉得平凡而幸福的生活会一直持续下去，但就在某一天，宅邸突然遭到某人的袭击。面对走投无路的危机，律花果敢地挺身而出，但——。 成为劈开黑暗的“黑”吧！', '0', '2020-05-06 10:31:38');
INSERT INTO `pk_theater` VALUES ('4', '3', '1', 'CENCOROLL CONNECT', 'https://wxt.sinaimg.cn/large/006MDjU7ly1g91wzj3rccj30go0njgmz.jpg', '1', '科幻、冒险', 'C', '2019-06-29', '2019', '花泽香菜、下野纮、木村良平', 'CENCOROLL CONNECT》是由宇木敦哉负责监督、编剧、作画的原创动画电影，于2019年6月29日在日本上映。突然出现在街上的白色巨型生物，操纵它们的少年们，还有好奇的短发少女从屏幕上迸发出来，被奔放的想象所压倒的短篇动画sean“圣科罗尔”。作为漫画家、插图画家活跃在这个领域，大冒险tri.》的角色设计而出名的创作者宇木敦哉这部由他一人完成的电影，在2009年上…', '0', '2020-05-06 10:47:52');
INSERT INTO `pk_theater` VALUES ('5', '3', '1', 'Fate/kaleid liner 魔法少女☆伊莉雅 Prisma☆Phantasm', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2549459545.webp', '1', '漫画改、校园、魔法、搞笑', 'F', '2019-08-24', '2019', '门胁舞以、斋藤千和、植田佳奈、伊藤静、神谷浩史、中田让治', 'Fate/kaleid liner系列的角色穿越平行世界的大集合，原作监修的完全原创剧情，描绘少女们的另一个故事。', '0', '2020-05-06 10:50:23');
INSERT INTO `pk_theater` VALUES ('6', '3', '1', '命运之夜——天之杯II ：迷失之蝶', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2561910374.webp', '1', '剧情、奇幻、动画', 'M', '2019-07-12', '2019', '杉山纪彰、下屋则子、川澄绫子、神谷浩史、植田佳奈、伊藤美纪、中田让治', '本片改编自TYPE-MOON出品的文字冒险类游戏《Fate/stay night》，是该游戏最终路线“HF线”动画剧场版全三部作品中的第二章。通过女主角间桐樱的视角，讲述了御主和英灵为了得到可以实现一切愿望的圣杯而相互厮杀的一场战争。时隔10年在冬木市爆发的这场“圣杯战争”中，因被称为“圣杯战争”御三家之一的间桐家的当家·间桐脏砚的参战而变得更畸形、扭曲和恶化。作为御主参战的卫宫士郎也在战斗中负伤还失去了英灵Saber，尽管如此士郎为了守护间桐樱，并没有从战斗中引身退出。而担心士郎身体的樱，自己也无法逃离魔法师的宿命……', '2', '2020-05-06 10:52:49');
INSERT INTO `pk_theater` VALUES ('7', '3', '1', 'Re：从零开始的异世界生活 Memory Snow(雪之回忆)', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2515741354.webp', '1', '小说改、穿越、奇幻、日常', 'R', '2019-06-07', '2019', '小林裕介、高桥李依、内山夕实、水濑祈、村川梨衣、新井里美、子安武人', '昴等人打倒了诅咒的元凶——魔兽沃尔加姆，拯救了阿拉姆村的孩子们。终于到来的安稳并未持续很久，昴就瞒着所有人前去挑战某个极秘任务。尽管昴做了变装，但很快就被以佩特拉为首的村里的孩子们识破了真实身份。开始后5秒就曝光的这一任务，是事前调查和艾米莉亚约会的路线……。', '0', '2020-05-06 10:56:34');
INSERT INTO `pk_theater` VALUES ('8', '3', '1', 'Re：从零开始的异世界生活 冰结之绊', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2564850964.webp', '1', '小说改、奇幻、战斗', 'R', '2019-11-08', '2019', '高桥李依、内山夕实', '如果是为了你的话，我可以成为任何东西——。', '0', '2020-05-06 11:01:42');
INSERT INTO `pk_theater` VALUES ('9', '3', '1', '薄暮', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2554655502.webp', '2', '校园、恋爱、治愈', 'B', '2019-06-21', '2019', '樱田日和、加藤清史郎、下野纮、岛本须美、福原香织、雨宫天、佐仓绫音、花泽香菜', '描绘福岛的现在，再平常不过的相遇的故事。这个世界，仍然有爱。', '0', '2020-05-06 11:04:11');
INSERT INTO `pk_theater` VALUES ('10', '3', '1', '朝花夕誓', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2545561196.webp', '1', '奇幻、爱情', 'Z', '2019-02-22', '2019', '石见舞菜香、入野自由、茅野爱衣、梶裕贵、泽城美雪、细谷佳正、佐藤利奈', '在世界的尽头，住着一群被称为“离别一族”的古老民族：他们拥有着长寿之血和永生不老的面容。 在一场外族入侵的战役中，离别一族惨遭灭族，15岁的玛奇亚虽然侥幸逃生，却彻底和朋友失去了联系。孤身一人的她在残骸中拾到了一个普通人家的遗孤，并决定收养他。然而随着时间的流逝，玛奇亚必须要学会如何做一个母亲，经历人间的生离死别，并在朝代的更迭中守护“离别一族”最后的信仰…', '0', '2020-05-06 11:06:11');
INSERT INTO `pk_theater` VALUES ('11', '3', '1', '吹响吧！上低音号～誓言的终章～', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2590346161.webp', '2', '小说改、日常、萌系、校园', 'C', '2019-04-19', '2019', '黑泽朋世、朝井彩加、丰田萌绘、安济知佳、石谷春贵、藤村鼓乃美、山冈百合', '北宇治高中吹奏乐部去年顺利地在全日本吹奏乐大赛出场。升入二年级的黄前久美子，和三年级的加部友惠一起开始负责指导从四月开始新加入的一年级生们。是进入了全国大赛的学校，自然有很多一年级生入部。其中，有四名新生来到了低音声部。乍一看似乎毫无问题的久石奏。不融入周围的铃木美玲。想要和美玲做朋友的铃木五月。不提及自身事情的月永求。Sunrise祭、选拔赛、以及竞演会。以“全国大赛金奖”为目标的吹奏乐部，却接连发生了问题……！？北宇治高中吹奏乐部，风波不断的日子开始了！', '0', '2020-05-06 11:08:58');
INSERT INTO `pk_theater` VALUES ('12', '3', '1', '吹响吧！上低音号～想要传达的旋律～', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2499628260.webp', '1', '小说改、日常、校园、萌新', 'C', '2017-09-30', '2017', '黑泽朋世、朝井彩加、丰田萌绘、安济知佳、寿美菜子、早见沙织、茅原实里', '重制于电视动画《吹响吧！上低音号》第二季的总集篇剧场版，加入了部分原来TV没有的新画面。', '0', '2020-05-06 11:11:14');
INSERT INTO `pk_theater` VALUES ('13', '3', '2', '刺猬索尼克', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2582485085.webp', '2', '喜剧、动作', 'C', '2020-02-14', '2020', '詹姆斯·麦斯登、金·凯瑞、本·施瓦茨、提卡·森普特、娜塔莎·罗斯韦尔、亚当·佩里、李·马贾道布、尼尔·麦克唐纳、汤姆·巴特勒、弗兰克·C·特纳、珊农·陈-肯特', '改编自世嘉公司出品的风靡全球的电子游戏。电影讲述了拥有音速奔跑能力的刺猬索尼克在地球上展开新生活的故事。索尼克和他的新朋友汤姆（詹姆斯·麦斯登 饰）联手保护地球，阻止邪恶的蛋头博士（金·凯瑞 饰）统治世界的计划。这部适合全家观看的电影还邀请了迪卡·桑普特参演，本·施瓦茨为索尼克配音。', '0', '2020-05-06 11:15:14');
INSERT INTO `pk_theater` VALUES ('14', '3', '1', '多啦A梦 大雄的南极大冒险', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2459265598.webp', '1', '冒险、科幻、少儿', 'D', '2017-03-04', '2017', '水田山葵、大原惠美、嘉数由美、木村昴、关智一、千秋、钉宫理惠、金井美香、三石琴乃', '为了躲避夏日的酷暑，哆啦A梦（水天葵 配音）带着大雄（大原惠美 配音）、静香（嘉薮由美 配音）、胖虎（木村昴 配音）和小夫（关智一 配音）来到了漂浮在南太平洋中的一座冰山上。他们利用道具“冰雕工艺组”打造了惊险刺激而又妙趣横生的游乐园，小伙伴们乐而忘返。可就在此时，乐园突然垮塌，大雄则偶然从冰层中捡到了一枚金环。根据调查发现，金环居然是十万年前的产物。为了寻找它的主人，哆…', '0', '2020-05-06 11:18:31');
INSERT INTO `pk_theater` VALUES ('15', '3', '1', '花开伊吕波 Home Sweet Home', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2065644062.webp', '1', '催泪、日常、治愈、励志', 'H', '2013-03-09', '2013', '伊藤加奈惠、豊崎愛生、小見川千明、戸松遥、能登麻美子', '东京出身的女子高中生 松前绪花 入住了祖母经营的温泉旅馆“喜翠庄”。在与见习厨师鹤来民子和见习仲居押水菜子度过的日子中，习惯了喜翠庄生活的绪花渐渐开始注意到的自身的变化。深秋的某天，同班同学、竞争对手“福屋”旅馆的女儿 和仓结名来到了喜翠庄进行女将修行。一边被自由奔放的结名弄的不知所措、又一边照顾她的绪花，在打扫的时候，在杂物柜中发现的某个东西。', '0', '2020-05-06 11:21:40');
INSERT INTO `pk_theater` VALUES ('16', '3', '1', '火影忍者剧场版 博人传', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2251539632.webp', '1', '热血、冒险、战斗、奇幻', 'H', '2016-02-18', '2016', '三瓶由布子、菊池心、木岛隆一、竹内顺子、中村千绘、杉山纪彰、早见沙织、水树奈奈', '漩涡博人虽然是七代火影漩涡鸣人（竹内顺子 配音）的儿子，但是他并不以父亲为荣，父子间充满了误会。博人为了打败父亲，准备拜师宇智波佐助（杉山纪彰 配音），与此同时，博人与佐助的女儿佐良娜（菊池心 配音）、三月（木岛隆一 饰）组成了小队，共同参加下影的考试。下影考试开始，博人求胜心切，不料考试途中，神秘反派大筒木桃式、金式发动了突然…', '0', '2020-05-06 11:24:54');
INSERT INTO `pk_theater` VALUES ('17', '3', '1', '机甲少女 FRAME ARMS GIRL～高高兴兴的幻境～', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2551142900.webp', '2', '搞笑、校园、百合、科幻', 'J', '2019-06-29', '2019', '日笠阳子、佳穗成美、绫濑有、长江里加、山崎惠理、桦山南、山村响、阿部里果、井泽佳之实', '女子高校生あおの元に届けられた謎の小包には、フレームアームズ・ガールと呼ばれる完全自律型の小型ロボット「轟雷」が入っていた。轟雷は人工自我、AS（アーティフィシャル・セルフ）を搭載した最新型の試作機。バトルデータを収集し、感情を学んでいく轟雷とあおの、奇妙で楽しい日常が始まる！', '0', '2020-05-06 11:28:31');
INSERT INTO `pk_theater` VALUES ('18', '3', '1', '境界的彼方 -I\'LL BE HERE- 未来篇', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2232714370.webp', '1', '日常、奇幻、治愈', 'J', '2015-04-25', '2015', '種田梨沙、KENN、鈴木達央、茅原実里、川澄綾子、山冈百合、渡辺明乃', '本片于2015年4月25日于日本上映，延续了TV版剧情一年后的事。一年后，栗山未来同学复活后失去记忆。秋人同学在新学期为着栗山同学的未来着想，开始疏远栗山同学，在新的战斗中栗山同学再次表明自己对秋人同学的情感，他们对未来又将会作出如何选择。', '0', '2020-05-06 11:30:56');
INSERT INTO `pk_theater` VALUES ('19', '3', '1', '境界的彼方 -I\'LL BE HERE- 过去篇', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2233074775.webp', '1', '恋爱、奇幻、战斗', 'J', '2015-03-14', '2015', '种田梨沙、KENN、茅原实里、铃木达央', '2013年放送的TV动画《境界的彼方》，于2015年春宣布上映剧场版动画。该剧场版由「过去篇」和「未来篇」2部构成。其中「过去篇」以女主角栗山未来为中心,回顾TV动画版中发生的故事。', '0', '2020-05-06 11:32:42');
INSERT INTO `pk_theater` VALUES ('20', '3', '2', '囧妈', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2581835383.webp', '2', '喜剧', 'J', '2020-01-25', '2020', '徐峥、黄梅莹、袁泉、贾冰、郭京飞、沈腾、吴云芳、陈奇、高以翔、宋小宝、黄渤、黄景瑜', '讲述了小老板伊万缠身于商业纠纷，却意外同母亲坐上了开往俄罗斯的火车。在旅途中，他和母亲发生激烈冲突，同时还要和竞争对手斗智斗勇。为了最终抵达莫斯科，他不得不和母亲共同克服难关，并面对家庭生活中一直所逃避的问题。', '0', '2020-05-06 11:34:52');
INSERT INTO `pk_theater` VALUES ('21', '3', '1', '壳中少女 燃烧', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p1159280622.webp', '1', '剧情、科幻', 'K', '2011-09-03', '2011', '林原惠美、八岛智人、东地宏树、中井和哉、矶部勉、若本规夫、小林由美子、浪川大辅', '承受着残酷命运的少女露恩•芭洛特（林原惠美 配音）与强敌鲍伊德（矶部勉 配音）进行着实力悬殊的惨烈战斗，危急时刻，号称万能兵器的犯罪搜查官乌夫库克博士（八岛智人 配音）出现，拯救了濒临死亡的芭洛特。当芭洛特再次醒来，发现自己正置身于传说中的禁忌科学诞生之地——“乐园”实验室，再次她见识了许多奇怪的发明，并了解到“乐园”和三博士的过去。经过一番追查，她终于得知榭尔（中井和哉…', '0', '2020-05-06 11:37:11');
INSERT INTO `pk_theater` VALUES ('22', '3', '1', '利兹与青鸟', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2515806508.webp', '1', '剧情、音乐', 'L', '2018-04-21', '2018', '种崎敦美、东山奈央、本田望结、藤村鼓乃美、山冈百合、杉浦しおり、黑泽朋世、朝井彩加、丰田萌绘、安济知佳、桑岛法子、中村悠一、樱井孝宏', '就读北宇治高中的铠塚霙（种崎敦美 配音），在管乐团中负责吹奏双簧管；伞木希美（东山奈央 配音） 则负责吹奏长笛。国中时，希美主动对孤单的霙搭话，从那刻起霙就将希美视为自己的全世界。霙现在每天都感到很幸福，因为有希美在身边陪伴她，但同时也害怕希美是否会再次消失在自己面前…… ', '0', '2020-05-06 11:39:29');
INSERT INTO `pk_theater` VALUES ('23', '3', '1', '凉宫春日的消失', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2246432125.webp', '1', '搞笑、校园、奇幻、日常', 'L', '2010-02-06', '2010', '茅原実里、杉田智和、平野綾、小野大輔、後藤邑子、後藤邑子、松岡由貴', '圣诞节即将来临，SOS团火锅派对的活动拍板以后，阿虚就带着烦恼回家。第二天，阿虚如常上学，但他很快注意到，学校发生了与平日完全不同的事。应该在后面的座位的凉宫春日不在，却换上了理应让长门有希消灭了的朝仓凉子；不仅是这样，全世界也都变了……。', '0', '2020-05-06 11:42:57');
INSERT INTO `pk_theater` VALUES ('24', '3', '1', '名侦探柯南：绀青之拳', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2566225091.webp', '1', '悬疑、动作、漫画改', 'M', '2019-09-13', '2019', '高山南、山口胜平、山崎和佳奈、小山力也、绪方贤一、岩居由希子、高木涉', '在19世纪末与海盗船一同沉入新加坡近海的、世界上最大的蓝宝石“绀青之拳”。在当地的富豪将其回收，于舞台上展现其真容时，在滨海湾金沙酒店附近发生了杀人案。现场留下了怪盗基德沾有血迹的预告函。而在那时，为了观看在新加坡举办的空手道锦标赛，小兰和园子到访了当地。', '0', '2020-05-06 11:48:09');
INSERT INTO `pk_theater` VALUES ('25', '3', '1', '名侦探柯南：唐红的恋歌', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2461296240.webp', '1', '剧情、推理、动画', 'M', '2017-04-15', '2017', '高山南、山崎和佳奈、小山力也、堀川亮、宫村优子、绪方贤一、岩居由希子、高木渉、大谷育江、林原惠美、宫川大辅、吉冈里帆、雪野五月', '舞台：大阪&京都，正在录制\"皐月杯\"百人一首记者会的大阪地标·日卖电视台突然发生爆炸，千钧一发之际，急忙赶来的柯南救出了被困在崩塌大楼中的平次与和叶，而另一侧，\"皐月杯\"冠军在京都屋内遭人杀害，监控器里所显示出的是——红叶...原作中的重要角色，百人一首高中生冠军，自称\"平次未婚妻\"的大冈红叶，将首次在剧…', '0', '2020-05-06 11:52:58');
INSERT INTO `pk_theater` VALUES ('26', '3', '2', '哪吒之魔童降世', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2563780504.webp', '1', '剧情、喜剧', 'N', '2019-07-26', '2019', '吕艳婷、囧森瑟夫、瀚墨、陈浩、绿绮、张珈铭、杨卫', '天地灵气孕育出一颗能量巨大的混元珠，元始天尊将混元珠提炼成灵珠和魔丸，灵珠投胎为人，助周伐纣时可堪大用；而魔丸则会诞出魔王，为祸人间。元始天尊启动了天劫咒语，3年后天雷将会降临，摧毁魔丸。太乙受命将灵珠托生于陈塘关李靖家的儿子哪吒身上。然而阴差阳错，灵珠和魔丸竟然被掉包。本应是灵珠英雄的哪吒却成了混世大魔王。调皮捣蛋顽劣不堪的哪吒却徒有一颗做英雄的心。然而面对众人对魔丸的误解和即将来临的天雷的降临，哪吒是否命中注定会立地成魔？他将何去何从？', '0', '2020-05-06 11:55:39');
INSERT INTO `pk_theater` VALUES ('27', '3', '1', '你的名字。', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2395733377.webp', '1', '爱情、剧情、科幻', 'N', '2016-08-26', '2016', '神木隆之介、上白石萌音、长泽雅美、市原悦子、成田凌、悠木碧、岛崎信长、石川界人、谷花音', '在远离大都会的小山村，住着巫女世家出身的高中女孩宫水三叶。不知从何时起，三叶在梦中就会变成一个住在东京的高中男孩。另一方面，住在东京的高中男孩立花泷则总在梦里来到陌生的小山村，以女孩子的身份过着全新的生活。许是受那颗神秘彗星的影响，立花和三叶在梦中交换了身份。', '0', '2020-05-06 11:57:25');
INSERT INTO `pk_theater` VALUES ('28', '3', '1', '你好世界。', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2594764469.webp', '1', '恋爱、科幻', 'N', '2019-09-20', '2019', '北村匠海、松坂桃李、滨边美波、子安武人、寿美菜子', '在京都居住的内向男高中生直实（北村匠海 配音）的面前，突然出现从10年后穿越而来26岁的自己（松坂桃李 配音）。未来的直实告诉他，自己不久便会与琉璃（滨边美波 配音）相爱，可是之后烟花大会时她却会因为一场事故意外离世。\n　　为了拯救爱人，16岁的直实卷入了这场现实与虚拟的记忆世界，经历了一系列超乎想象的事情。即使世界毁灭，我也想再见你一面。 ', '0', '2020-05-06 12:00:08');
INSERT INTO `pk_theater` VALUES ('29', '3', '1', '牵牛花与加濑同学', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2450467970.webp', '1', '青春、剧情', 'Q', '2018-06-09', '2018', '高桥未奈美、佐仓绫音、木户衣吹', '根据日本漫画家高嶋博美创作的百合漫画《牵牛花与加濑同学》改编的剧场版动画。主角山田结衣是位个性内向、喜欢植物的高中2年级学生，班上的园艺股长；在她隔壁班的加濑同学是田径队的王牌及校内风云人物。某一天，山田与加濑她们两人因山田种的牵牛花而相识，并成为好朋友。', '0', '2020-05-06 12:01:50');
INSERT INTO `pk_theater` VALUES ('30', '3', '1', '请问您今天要来点兔子吗？？～Sing for You～', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2556827263.webp', '1', '漫画改、搞笑、日常、萌系', 'Q', '2019-09-26', '2019', '佐仓绫音、水濑祈、种田梨沙、佐藤聪美、内田真礼、德井青空、村川梨衣', '被选为音乐会独奏的智乃，让理世对她进行特训，理世为了让智乃习惯在众人面前唱歌而举办了卡拉OK大会，与其说是智乃的练习，倒不如说是大家的狂欢。紧张的智乃能在当天好好的唱歌吗？', '0', '2020-05-06 12:04:38');
INSERT INTO `pk_theater` VALUES ('31', '3', '1', '声之形', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2497136132.webp', '1', '爱情、剧情、漫画改', 'S', '2017-09-08', '2017', '入野自由、早见沙织、松冈茉优、悠木碧、 小野贤章、金子有希、石川由依、潘惠美', '西宫硝子（早见沙织 配音）天生患有听觉障碍，需依靠助听器与外界交流，她的口语发音也因此显得格外古怪。初中时，硝子转去了一所新学校，生理缺陷让她成为了班上的“独特”存在，她因此收获了友情，却也遭到了以男生石田将也（入野自由 配音）为首的小团体的欺凌。无论是出于少年无心，还是恶童有意，随着时间的推移，事态逐渐升级，一系列的事件之后，最终演变成为了无法挽回的伤害，硝子也永远地消失在了众人的眼前……', '0', '2020-05-06 12:07:00');
INSERT INTO `pk_theater` VALUES ('32', '3', '2', '泰坦尼克号', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p457760035.webp', '1', '爱情、灾难、剧情', 'T', '2012-04-10', '2012', '莱昂纳多·迪卡普里奥、凯特·温丝莱特、比利·赞恩、凯西·贝茨、弗兰西丝·费舍', '1912年4月10日，号称 “世界工业史上的奇迹”的豪华客轮泰坦尼克号开始了自己的处女航，从英国的南安普顿出发驶往美国纽约。富家少女罗丝（凯特•温丝莱特）与母亲及未婚夫卡尔坐上了头等舱；另一边，放荡不羁的少年画家杰克（莱昂纳多·迪卡普里奥）也在码头的一场赌博中赢得了下等舱的船票。\n　　罗丝厌倦了上流社会虚伪的生活，不愿嫁给卡尔，打算投海自尽，被杰克救起。很快，美丽活泼的罗丝与英俊开朗的杰克相爱，杰克带罗丝参加下等舱的舞会、为她画像，二人的感情逐渐升温。\n　　1912年4月14日，星期天晚上，一个风平浪静的夜晚。泰坦尼克号撞上了冰山，“永不沉没的”泰坦尼克号面临沉船的命运，罗丝和杰克刚萌芽的爱情也将经历生死的考验。', '0', '2020-05-06 12:09:27');
INSERT INTO `pk_theater` VALUES ('33', '3', '1', '天降之物Final 我永远的鸟笼', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2173407632.webp', '1', '奇幻', 'T', '2011-06-25', '2011', '日笠陽子、早见沙织、保志総一朗、美名、大亀明日香、野水伊織、福原香織', '我的名字是樱井智树，座右铭为「和平至上」。平凡不就是最好的吗？若要说唯一不寻常的地方…就是我常作到的梦，会梦到一个连长相也回想不起来的女孩。我因为那终究只是场梦而没有放在心上，但是……直到那天，天使从天而降————《天降之物》（そらのおとしもの、直译为“天空遗落之物”）是水无月嵩的漫画作品，2007年开始在角川书店旗下的《月刊少年Ace》连载。在单行本第4集发售时发布动画化消息，TV版对漫画稍微进行修改，于2009年10月4日播放，全14话。动画续篇《天降之物f》于2010年10月1日播出，全12话。', '0', '2020-05-06 12:12:17');
INSERT INTO `pk_theater` VALUES ('34', '3', '1', '天气之子', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2570059839.webp', '1', '恋爱、治愈', 'T', '2019-07-19', '2019', '醍醐虎汰朗、森七菜、小栗旬、本田翼', '高一那年夏天，帆高（醍醐虎汰朗 配音）離開位在離島的家鄉，獨自一人來到東京，拮据的生活迫使他不得不找份工作，最後來到一間專門出版奇怪超自然刊物的出版社擔任寫手。不久，東京開始下起連日大雨，彷彿暗示著帆高不順遂的未來，在這座繁忙城市裡到處取材的帆高邂逅了與弟弟相依為命，不可思議的美少女陽菜（森七菜 配音）。「等等就會放晴了喔。」陽菜這樣告訴著帆高，不久，頭頂的烏雲逐漸散去，…', '0', '2020-05-06 12:28:10');
INSERT INTO `pk_theater` VALUES ('35', '3', '1', '为美好的世界献上祝福！红传说', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2551687590.webp', '1', '冒险、搞笑、奇幻、后宫', 'W', '2019-08-30', '2019', '福岛润、雨宫天、高桥李依、茅野爱衣、堀江由衣、丰崎爱生', '本应由于交通事故（!?）导致人生轻易闭幕的游戏迷家里蹲·佐藤和真，事出偶然地带着女神·阿库娅转生到了异世界。“在如同RPG游戏一样的异世界，享受憧憬已久的冒险者生活！目标是勇者！”像这样兴奋了还没多久，转生而来的和真就尽是遇到倒霉的事情。 麻烦制造机废柴女神·阿库娅，重度中二病魔法使·惠惠，妄想停不下来的女骑士·达克妮丝，和真与空有高超能力值却无比残念的这3人组队，欠下一屁股债，涉嫌颠覆国家罪而遭到审判，讨伐魔王军干部，偶尔还会死一死……\n　　这样的某一天，突然跑来的红魔族少女·悠悠的一句爆炸性发言，让和真等人当场石化。“我想要和真先生的孩子！”问明原因，原来惠惠和悠悠的故乡“红魔之里” 目前正濒临灭亡的危机。追在出发前去拯救村落的悠悠后面，和真等人向着红魔之里出发，但——！？向和真小队袭来的最大危机！平凡的冒险者和真度过的异世界生活，未来究竟会怎样！？', '0', '2020-05-06 12:30:18');
INSERT INTO `pk_theater` VALUES ('36', '3', '1', '我们的七日战争', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2570352974.webp', '2', '冒险、校园', 'W', '2019-12-13', '2019', '芳根京子、北村匠海、宫泽理惠', '《我们的七日战争》剧场版动画化，村野佑太担当监督，脚本为大河内一楼，清水洋出任角色设计，けーしん负责角色原案，2019年内上映。 作品改编自宗田理于1985年4月出版的小说。故事讲述了某学校中学一年级的男学生们，集体在废弃工厂建立所谓的“解放区”，并发动了针对大人们的“叛乱”后的故事。借此反映了学生学业过重、学校对学生任意进行体罚等种种社会问题。', '0', '2020-05-06 12:32:09');
INSERT INTO `pk_theater` VALUES ('37', '3', '1', '我想吃掉你的胰脏', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2545571306.webp', '1', '爱情、小说改', 'W', '2019-01-08', '2019', '高杉真宙、藤井雪代、内田雄马、福岛润、田中敦子、三木真一郎', '对他人毫无兴趣，总是独自一人读书的高中生“我”，有一天偶然捡到一册写着《共病文库》的文库本，那是同班同学山内樱良的日记，里面记载着她身患胰脏的疾病，已经时日无多……性格相反的两个人，生命开始出现交集。', '0', '2020-05-06 12:34:00');
INSERT INTO `pk_theater` VALUES ('38', '3', '1', '夏目友人帐剧场版 缘结空蝉', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2546745948.webp', '1', '剧情、奇幻', 'X', '2019-03-07', '2019', '神谷浩史、井上和彦、高良健吾、小林沙苗、泽城美雪、石田彰、藤村步、村濑步', '在人与妖怪之间过着忙碌日子的夏目，偶然与以前的同学结城重逢，由此回忆起了被妖怪缠身的苦涩记忆。此时，夏目认识了在归还名字的妖怪记忆中出现的女性·津村容莉枝。和玲子相识的她，现在和独子椋雄一同过着平稳的生活。夏目通过与他们的交流，心境也变得平和。但这对母子居住的城镇，却似乎潜伏着神秘的妖怪。在调查此事归来后，寄生于猫咪老师身体的“妖之种”，在藤原家的庭院中，一夜之间就长成树结出果实。而吃掉了与自己形状相似果实的猫咪老师，竟然分裂成了3个？！', '0', '2020-05-06 12:36:25');
INSERT INTO `pk_theater` VALUES ('39', '3', '1', '烟花', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2504455660.webp', '2', '剧情、恋爱', 'Y', '2017-12-01', '2017', '广濑铃、菅田将晖、宫野真守、松隆子、花泽香菜', '炎炎夏日，茂下町的烟花大会即将举行。就读于当地高中的及川奈砂（广濑铃 配音）并未沉浸在愉快祥和的气氛之中，她即将随母亲（松隆子 配音）搬家到另一个城市，心中满是失落。在某次即兴的游泳比赛时，奈砂击败同班同学岛田典道（菅田将晖 配音）和安昙祐介（宫野真守 配音）。随后她坦白喜欢祐介，希望烟花大会时能与对方一同游玩。可是祐介、典道随后卷入和朋友们关于“烟花到底是圆是扁”的争论中，大家约好当晚一起去某地见证。祐介因此爽约，而同样偷偷喜欢着奈砂的典道因此发觉了女孩的秘密和心思。他为此责怪好友，也渴望时光重来，迎得当初那场比赛…… ', '0', '2020-05-06 12:38:25');
INSERT INTO `pk_theater` VALUES ('40', '3', '1', '言叶之庭', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p1958733032.webp', '1', '日常、少女、治愈', 'Y', '2013-05-31', '2013', '入野自由、花泽香菜、平野文、前田刚、寺崎裕香、井上优、潘惠美、小松未可子', '年方15岁的高中生秋月孝雄（入野自由 配音），专心学业的过程中不得不为了生计打工赚钱。母亲离家出走，他与哥哥过着看不到前方的生活。入梅之日，孝雄逃课来到日本庭园。在一座安静的小亭子里，27岁的职场女性雪野百香里（花泽香菜 配音）边吃巧克力边饮啤酒的样子引起了孝雄的注意。似曾相识的二人，仿佛约定好了一般，每到落雨之日便从世俗的烦恼中逃脱出来，相会于这座钢筋铁骨都市丛林中宛若世外桃源的幽静角落。在梅雨季节的日子里，他们的心渐渐向彼此靠拢。志愿成为手工鞋匠的秋月，决心以雪野为模特做一双鞋。\n　　雨过天晴，艳阳高照，庭园中久久不见秋月和雪野的身影，相会无期亦有期……', '0', '2020-05-06 12:40:32');
INSERT INTO `pk_theater` VALUES ('41', '3', '1', '萤火之森', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p1675053073.webp', '1', '漫画改、神魔、催泪、恋爱', 'Y', '2011-09-11', '2011', '佐仓绫音、内山昂辉', '某年夏天，6岁小女孩竹川萤来到爷爷家度假，她闯进了传说住满妖怪的山神森林。正当她因为迷路而焦急万分的时候，一个戴着狐狸面具的大男孩出现在她面前，并引领着萤找到回家的路。虽然萤分外感激，可是男孩却禁止她碰触自己的身体，原来这名叫银的男孩并非人类，他一旦被人类碰触就会烟消云散。在此后的日子里，萤和银成为好朋友，他们走遍了森林的每一个角落玩耍。日复一日，年复一年，每到夏天的时候萤就会如约来到森林和好朋友见面。她遵守着和银的约定，无论如何也不碰触银的身体。随着年龄的增长，萤和银对彼此的情感都悄悄发生了变化，他们共同期待相聚的日子，共同期待拥抱对方…… ', '0', '2020-05-06 12:42:58');
INSERT INTO `pk_theater` VALUES ('42', '3', '1', '游戏人生 零', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2561782374.webp', '1', '爱情、奇幻', 'Y', '2019-07-19', '2019', '松冈祯丞、茅野爱衣、日笠阳子、田村由加莉、能登麻美子、井口裕香、泽城美雪、大川透', '距今超过六千年的远古世界，天地割裂的凄惨战争持续不断，毫无还手之力的人类被拥有强大力量的各个种族逼入绝境，濒临灭亡。此时率领人类的年轻领袖里克，与机凯种少女休比偶然相遇。被同伴抛弃的休比，为了修复故障，拜托里克把“人类的心”告诉自己。机凯种少女的单纯与真诚，使得里克对休比逐渐放下戒备、敞开心扉，二人感情亦日渐升温。最终二人带领人类共同面对终极一战，少女休比也将面临恋人与生命的残酷抉择。末日来临，在251秒的时间里，赌上一场深情告白。', '0', '2020-05-06 12:45:33');
INSERT INTO `pk_theater` VALUES ('43', '3', '1', '追逐繁星的孩子', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p1957577564.webp', '1', '冒险、奇幻', 'Z', '2011-05-07', '2011', '金元寿子、入野自由、井上和彦、岛本须美、日高里菜、竹内顺子、折笠富美子', '在一片宁静的小山村，少女渡濑明日菜（金元寿子 配音）时常站在山顶，用父亲留给她的神秘矿石作二极管，收听着来自外面世界的美妙音乐。在一次放学途中，明日菜遭到一头怪兽的袭击，关键时刻她被俊美少年瞬（入野自由 配音）救下，纯洁的友谊在少男少女之间开始萌芽。明日菜体味着友谊的甜蜜，却不知瞬在某天悄然离开人世。新来的男老师森崎龙司（井上和彦 配音）为孩子们讲述了死国的传说，明日菜这…', '0', '2020-05-06 12:48:28');
INSERT INTO `pk_theater` VALUES ('44', '3', '1', '紫罗兰永恒花园外传：永远与自动手记人偶', 'https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2578722076.webp', '2', '剧情、小说改', 'Z', '2020-01-10', '2020', '石川由依、茅原实里、远藤绫、寿美菜子、子安武人、户松遥、内山昂辉', '某个大陆的、某个时代。大陆南北分割的战争结束了，世界走向了和平。在战争中作为军人的薇尔莉特•伊芙加登，怀抱着对她来说无比重要之人留下的“话语”，离开军队来到了大港口城市。踊跃的人群在排列着煤气灯的街道马路上来来往往地穿梭着。薇尔莉特在街道上找到了“代写书 信”的工作。那是根据委托人的想法来组织出相应语言的工作。她直面委托人、触碰着他们内心深处的坦率感情。与此同时，薇尔莉特在记录书信时，渐渐明白那“话语”的含义...', '0', '2020-05-06 12:51:15');

-- ----------------------------
-- Table structure for pk_type
-- ----------------------------
DROP TABLE IF EXISTS `pk_type`;
CREATE TABLE `pk_type` (
  `t_id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `t_text` varchar(8) NOT NULL,
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pk_type
-- ----------------------------
INSERT INTO `pk_type` VALUES ('1', '番剧');
INSERT INTO `pk_type` VALUES ('2', '国漫');
INSERT INTO `pk_type` VALUES ('3', '剧场动画');
INSERT INTO `pk_type` VALUES ('4', '影视');

-- ----------------------------
-- Table structure for pk_user
-- ----------------------------
DROP TABLE IF EXISTS `pk_user`;
CREATE TABLE `pk_user` (
  `u_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_name` varchar(48) NOT NULL,
  `u_email` varchar(100) NOT NULL,
  `u_password` varchar(16) NOT NULL,
  `u_sex` tinyint(1) NOT NULL DEFAULT '0',
  `u_avatar` varchar(500) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pk_user
-- ----------------------------
INSERT INTO `pk_user` VALUES ('1', 'Dragon_Mr', '981192661@qq.com', 'a981192661', '0', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588879312997&di=91cc60ece4916ef83f52af3c7e664d3a&imgtype=0&src=http%3A%2F%2Fgss0.baidu.com%2F9fo3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fwh%253D450%252C600%2Fsign%3Dc12a6c0f4736acaf59b59ef849e9a126%2Ff603918fa0ec08fa5bf83c9155ee3d6d55fbda0f.jpg', '2020-05-07 22:51:00');
INSERT INTO `pk_user` VALUES ('2', 'Jhon_Mactavish96', '819661408@qq.com', 'a981192661', '0', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-07 22:51:00');
INSERT INTO `pk_user` VALUES ('13', 'aaa', '11@qq.com', 'a981192661', '0', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-07 23:57:44');
INSERT INTO `pk_user` VALUES ('14', 'aaaa', '21@qq.com', 'a981192661', '0', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 00:02:44');
INSERT INTO `pk_user` VALUES ('15', 'aaaa', '31@qq.com', 'a981192661', '0', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3832099094,1425661950&fm=26&gp=0.jpg', '2020-05-08 00:07:22');
