/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.17-log : Database - wxbook
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`wxbook` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `wxbook`;

/*Table structure for table `about` */

DROP TABLE IF EXISTS `about`;

CREATE TABLE `about` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '关于我们',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `image` varchar(100) DEFAULT NULL COMMENT '图片',
  `content` text COMMENT '内容',
  `about` varchar(10) DEFAULT NULL COMMENT '注释',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='关于我们';

/*Data for the table `about` */

insert  into `about`(`id`,`title`,`image`,`content`,`about`) values (1,'腾腾书友会','/uploads/20181016/9c39b82eeff7210e8ba0ff7ba9f7ea7a.jpg','<p>腾腾书友会</p>','关于我们'),(2,'腾腾书友会','/uploads/20181016/25998bd075e6e9b43832c63151d8561c.jpg','<p>腾腾书友会</p>','简介');

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `pretime` datetime DEFAULT NULL,
  `curtime` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='管理员';

/*Data for the table `admin` */

insert  into `admin`(`Id`,`username`,`pwd`,`pretime`,`curtime`) values (1,'admin','admin666','2019-01-07 11:30:18','2019-01-08 09:56:06');

/*Table structure for table `admin_recharge_log` */

DROP TABLE IF EXISTS `admin_recharge_log`;

CREATE TABLE `admin_recharge_log` (
  `ar_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员充值记录',
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '管理员id',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '会员id',
  `recharge_number` int(11) NOT NULL DEFAULT '0' COMMENT '充值钻石',
  `recharge_time` datetime DEFAULT NULL COMMENT '充值时间',
  PRIMARY KEY (`ar_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

/*Data for the table `admin_recharge_log` */

insert  into `admin_recharge_log`(`ar_id`,`admin_id`,`user_id`,`recharge_number`,`recharge_time`) values (1,1,1,100,'2018-10-31 10:08:22'),(2,1,1,200,'2018-10-31 10:41:55'),(3,1,1,1000,'2018-11-01 16:19:55'),(4,1,1,11111,'2018-11-05 15:29:39'),(5,1,10002,10000,'2018-11-07 09:48:03'),(6,1,10003,10000,'2018-11-07 09:48:07'),(7,1,10004,10000,'2018-11-07 09:48:10'),(8,1,10005,10000,'2018-11-07 09:48:12'),(9,1,10006,10000,'2018-11-07 09:48:14'),(10,1,10001,10000,'2018-11-07 09:55:43'),(11,1,10007,9999999,'2018-11-08 17:04:28'),(12,1,10009,8888,'2018-11-08 17:04:51'),(13,1,10010,8888,'2018-11-08 17:04:57'),(14,1,10011,8888,'2018-11-08 17:05:00'),(15,1,10012,8888,'2018-11-08 17:05:03'),(16,1,10013,8888,'2018-11-08 17:05:05'),(17,1,10014,8888,'2018-11-08 17:05:07'),(18,1,10015,8888,'2018-11-08 17:05:10'),(19,1,10016,8888,'2018-11-08 17:05:12'),(20,1,10017,8888,'2018-11-08 17:05:15'),(21,1,10018,8888,'2018-11-08 17:05:17'),(22,1,10005,8888,'2018-11-08 17:05:27'),(23,1,10005,8888,'2018-11-09 16:57:43'),(24,1,10032,888888,'2018-12-14 17:59:45'),(25,1,10030,888888,'2018-12-14 18:00:16'),(26,1,10036,888888,'2018-12-14 18:00:22'),(27,1,10034,888888,'2018-12-14 18:00:25'),(28,1,10035,888888,'2018-12-14 18:00:28'),(29,1,10033,888888,'2018-12-14 18:00:30'),(30,1,10031,888888,'2018-12-14 18:00:33'),(31,1,10029,888888,'2018-12-14 18:00:35'),(32,1,10028,888888,'2018-12-14 18:00:37'),(33,1,10037,888888,'2018-12-14 18:01:19'),(34,1,10038,888888,'2018-12-14 18:02:01'),(35,1,10039,888888,'2018-12-14 18:02:10'),(36,1,10040,8888888,'2018-12-14 18:02:41');

/*Table structure for table `lb` */

DROP TABLE IF EXISTS `lb`;

CREATE TABLE `lb` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) DEFAULT NULL COMMENT '父类id',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '状态0关闭 1开启',
  `url` varchar(255) DEFAULT NULL,
  `desc` text COMMENT '简介',
  `image` varchar(255) DEFAULT NULL COMMENT '图片',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告列表';

/*Data for the table `lb` */

insert  into `lb`(`id`,`fid`,`name`,`sort`,`status`,`url`,`desc`,`image`) values (3,1,'banner1',50,1,'','','/uploads/20181105/55fef990b0860d0a8b66e1014c086066.jpg'),(4,1,'banner2',50,1,'','','/uploads/20181105/11af685e46905b187ba81d5e334f9304.jpg');

/*Table structure for table `lb_place` */

DROP TABLE IF EXISTS `lb_place`;

CREATE TABLE `lb_place` (
  `pl_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '轮播id',
  `pl_name` varchar(255) DEFAULT NULL COMMENT '位置名称',
  PRIMARY KEY (`pl_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告位';

/*Data for the table `lb_place` */

insert  into `lb_place`(`pl_id`,`pl_name`) values (1,'banner');

/*Table structure for table `message` */

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言',
  `house_id` int(11) DEFAULT NULL COMMENT '房源id',
  `username` varchar(18) DEFAULT NULL COMMENT '姓名',
  `mobile` varchar(18) DEFAULT NULL COMMENT '手机号',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `sign` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标记(是否已读)',
  `time` varchar(12) DEFAULT NULL COMMENT '留言时间',
  PRIMARY KEY (`message_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='留言表';

/*Data for the table `message` */

/*Table structure for table `novel` */

DROP TABLE IF EXISTS `novel`;

CREATE TABLE `novel` (
  `novel_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '小说',
  `nc_id` int(11) NOT NULL DEFAULT '0' COMMENT '小说类型，关联wb_novel_calssify',
  `novel_name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `novel_author` varchar(30) NOT NULL DEFAULT '' COMMENT '作者',
  `novel_image` varchar(100) NOT NULL DEFAULT '' COMMENT '封面图',
  `novel_profile` varchar(255) NOT NULL DEFAULT '' COMMENT '简介',
  `novel_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '连载状态1连载中2已完结',
  `novel_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐0未推荐1热门推荐2主编推荐3vip推荐4精彩推荐',
  `free_of_charge` tinyint(1) NOT NULL DEFAULT '0' COMMENT '限时免费0收费1限免',
  `novel_sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '适合性别，0男1女',
  `novel_word_number` int(11) NOT NULL DEFAULT '0' COMMENT '字数，单位万字',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间（软删除）',
  `create_time` datetime DEFAULT NULL COMMENT '添加时间（tp5模型用，无其他用处）',
  PRIMARY KEY (`novel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='小说';

/*Data for the table `novel` */

insert  into `novel`(`novel_id`,`nc_id`,`novel_name`,`novel_author`,`novel_image`,`novel_profile`,`novel_status`,`novel_recommend`,`free_of_charge`,`novel_sex`,`novel_word_number`,`add_time`,`update_time`,`delete_time`,`create_time`) values (2,2,'测试','阿斯顿','/uploads/20181025/663af95548a9163b445e3f871537554b.jpg','阿斯达岁的阿斯达斯',1,0,0,0,123,'2018-10-25 16:52:04','2018-11-06 11:37:48','2018-11-06 11:37:48',NULL),(3,3,'测试推荐限免','切勿','','下',1,0,0,0,111,'2018-10-29 08:44:56','2018-11-05 10:35:27','2018-11-05 10:35:27',NULL),(4,4,'万丈光赠你','测试','/uploads/20181031/d0f76a20235a7b8e2a7da4d4a411004e.jpg','对对对',1,1,0,0,31,'2018-10-29 15:10:48','2018-12-18 17:47:33','2018-12-18 17:47:33','2018-11-07 00:00:00'),(5,3,'逆天仙尊2','测试','/uploads/20181031/9bf18200b904dda831f2e3475c4a07a1.jpg','asd ',2,2,0,0,123,'2018-10-29 15:11:36','2018-11-01 15:25:26',NULL,'2018-11-06 00:00:00'),(6,2,'秦时明月之焚书坑儒','测试','/uploads/20181101/6d8e8db75f9bda3885a2dba7b661781b.jpg','ads ',1,1,1,0,46,'2018-11-01 16:28:29','2018-11-05 10:35:13','2018-11-05 10:35:13','2018-11-01 16:28:29'),(7,3,'铁面如来','测试','/uploads/20181101/81ae59437303a5beddbb8f1c13c1b93f.jpg','“白日依山尽，黄河入海流：欲穷千里目，更上一层楼。”大千世界无奇不有，任何千奇百怪的事情几乎每天发生，如果有人大惊小怪，这个人一定会被讥为孤陋寡闻。尤其是南京城素有小京城美誉，热闹非凡，王孙公子更是多如过江之鲫，人人争强好胜，谁也不肯服谁，有时明知自己不如人，却没人肯口头认输。所以，放眼南京城里，许多青少年尽是肤浅之徒，三五成群游手好闲，个个眼高于顶，目中无人，靠着祖先余荫、裙带关系作威作福，所行所事引人侧目。但是对于安分守己的平民百姓而言，早已司空见惯，人人忍气吞声，逆来顺受，日子过得异常辛苦。因此“欲',1,3,1,1,32,'2018-11-01 16:38:25','2018-12-18 17:47:50','2018-12-18 17:47:50','2018-11-01 16:38:25'),(8,3,'斗破苍穹','测试','/uploads/20181105/9e4c7dbca257843ac62039f4b13334a2.jpg','阿斯达斯',2,1,1,1,350,'2018-11-05 08:46:44','2018-11-22 10:14:41','2018-11-22 10:14:41','2018-11-05 08:46:44'),(9,2,'近身战兵','测试','/uploads/20181106/2c194efaa9c223a92e5ed88bcf62909d.jpg','沈浩，少年被迫离家，亡命天涯五载，练就高绝身手，心怀壮志回归都市，重返校园，邂逅美女校花，清纯萝莉，御姐女教师……保护各路美女，一路杀伐纵横都市，谱写一段荡气回肠的男儿热血传奇！江山如画，美人如玉，当年的穷孩子一骑绝尘，独领风骚！',2,1,0,0,54,'2018-11-06 11:07:19','2018-11-06 11:07:19',NULL,'2018-11-06 11:07:19'),(10,3,'帝问九天','测试','/uploads/20181106/c9c1c984b16e677ee841a0fa63e8bde3.jpg','叶不归，机缘巧合下进入女子宗门，从此一发不可收拾，踏上仙路，鏖战神体。\r\n　　任他天高地远，我自一拳轰平。\r\n　　任什么远古秘闻，一拳下去轰成历史尘埃。\r\n　　任他红粉骷髅……\r\n　　呀呀，我还没打呢，别往我身上扑……',2,2,0,0,78,'2018-11-06 11:24:25','2018-11-06 11:24:25',NULL,'2018-11-06 11:24:25'),(11,2,'跃马大唐','测试','/uploads/20181106/c7a5f1168b481a0db469a7c8c2c420f3.jpg','天宝四年，盛世大唐。安禄山正在崛起，杨国忠将权倾朝野，歌舞升平中孕育刀光剑影，太平盛世里暗藏血雨腥风。一名小小坊丁，崛起于市井之间，他是诗坛翘楚，他是天下枭雄。绝代佳人，为谁舞霓裳羽衣！大唐天下，谁将主社稷沉浮！',2,2,0,1,115,'2018-11-06 11:27:10','2018-11-07 15:39:45',NULL,'2018-11-06 11:27:10'),(12,5,'测试','测试','/uploads/20181108/7410dc53466d0149f4634b0c22ec4520.jpg','测试',2,1,1,1,110,'2018-11-08 17:13:58','2018-11-22 10:14:27','2018-11-22 10:14:27','2018-11-08 17:13:58'),(15,0,'斯蒂芬','阿斯蒂芬','','阿斯蒂芬',1,0,0,0,111,'2018-11-09 17:35:16','2018-11-09 18:14:22','2018-11-09 18:14:22','2018-11-09 17:35:16'),(16,4,'捡个杀手做老婆','花刺1913 ','/uploads/20181109/5de864b987ad34cb018115fcae66d209.jpg','月黑风高的夜晚他捡到一个漂亮妩媚性感妖艳的美女，于是他那风骚起伏波澜壮阔的人生开始了…… ',1,4,1,0,110,'2018-11-09 17:35:37','2018-11-09 17:35:37',NULL,'2018-11-09 17:35:37'),(17,2,'修真极品邪少','花好月圆','/uploads/20181109/aab6dfe45f042597c5ad84a5f267fc69.jpg','这小说无敌',2,0,1,0,500,'2018-11-09 17:47:42','2018-11-10 08:27:52','2018-11-10 08:27:52','2018-11-09 17:47:42'),(18,2,'修真极品邪少','花好月圆','/uploads/20181109/35aab76b44d86c49e542dfc082ed411f.jpg','这小说无敌',2,0,1,0,500,'2018-11-09 17:47:42','2018-11-10 17:34:52','2018-11-10 17:34:52','2018-11-09 17:47:42'),(19,2,'修真极品邪少','花好月圆','/uploads/20181109/8c1f4eb4a83f22866a8b45182e246708.jpg','这小说无敌',2,0,1,0,500,'2018-11-09 17:47:42','2018-11-10 17:34:50','2018-11-10 17:34:50','2018-11-09 17:47:42'),(20,2,'修真极品邪少','花好月圆','/uploads/20181109/698f4301026e76da154a7b488043595f.jpg','这小说无敌',2,0,1,0,500,'2018-11-09 17:47:43','2018-11-10 17:34:47','2018-11-10 17:34:47','2018-11-09 17:47:43'),(21,2,'修真极品邪少','花好月圆','/uploads/20181109/3bef919054ca488899a937f41eb47cbd.jpg','这小说无敌',2,0,1,0,500,'2018-11-09 17:47:43','2018-12-18 17:48:28','2018-12-18 17:48:28','2018-11-09 17:47:43'),(22,3,'浴火重生之鬼医妖后','枼玥','/uploads/20181109/62c4b746d0685c7bfba91055544946c4.jpg','本文一对一宠文，一生一世一双人。 前世 白天，她是首屈一指的整容医生，享誉世界，黑夜，她是闻名世界的千面杀手，被誉为千面妖女，她的生活充满了谎言，内心却保留着一颗最本真的心，没...',1,4,1,1,120,'2018-11-09 17:52:22','2018-11-22 10:14:23','2018-11-22 10:14:23','2018-11-09 17:52:22'),(23,3,'江湖遍地卖装备','测试','/uploads/20181110/76fae89ff1bdd6b19b5cb0f05fce3619.jpg','测试正则表达式导入',1,0,1,0,63,'2018-11-10 11:52:42','2018-11-10 11:53:00',NULL,'2018-11-10 11:52:42'),(24,0,'阿斯顿','111','','阿斯顿',1,0,0,0,111,'2018-11-10 16:56:47','2018-11-10 17:01:36','2018-11-10 17:01:36','2018-11-10 16:56:47'),(25,2,'大圣狂','love飞鱼','/uploads/20181122/b50ffda81bd3bc0b6bf5ba98309e8b29.jpg','西游是一盘偌大的棋局，执棋者也不仅仅是两人。须菩提、太上老君、如来、玉皇大帝，这些都是天界不可撼动的存在。 他们的手中各持一子，都是执棋者。偌大棋局，棋子也非黑白两色，孙悟空、金蝉子、天棚、杨戬、虽暂为棋子，但逆天改命，大道征途，棋子即可摆脱执棋者，一子落纵横，风云定乾坤。 这是执棋者与棋子之间的博弈，关乎三界六道。悟空助金蝉证道，金蝉助悟空渡心，证道渡心，胜天半子。',1,4,1,0,10,'2018-11-22 10:10:18','2018-12-18 17:48:51','2018-12-18 17:48:51','2018-11-22 10:10:18'),(26,2,'帝火丹王','平凡心','/uploads/20181122/445a425fa993f345e42468661c1ca4a7.jpg','与火神祝融火种融合，掌控世间火焰。丹师厉害靠的是什么，掌控火焰炼丹，谁掌控火焰能有咱强。 帝都争雄，扶持父亲崛起，让天下没有任何纨绔敢在我面前嚣张、放肆，因为我是掌控帝火的一代丹王。',1,4,1,0,110,'2018-11-22 10:16:45','2018-11-22 10:25:53',NULL,'2018-11-22 10:16:45'),(27,2,'都市超级修仙狂少','吧唧叭叽','/uploads/20181122/d24d9bfb34a26ae73651c4f886b52003.jpg','火热新书）三年苦修，只为一朝出人头地，不再看人白眼，不再受人欺辱，不为命运摆布！ 以大地为床，以天空为被，随心而行，逍遥自在。',1,0,1,0,120,'2018-11-22 10:20:12','2018-12-18 17:49:10','2018-12-18 17:49:10','2018-11-22 10:20:12'),(28,2,'一棍碎天','天上峡谷','/uploads/20181122/4e18482dd2911bc605abdbe34eb1d942.jpg','山海大陆人族动荡不安，妖族虎视眈眈,家族被灭艰难存活，从江湖走起，在庙堂纵横，且看常风如何指点山海。 江湖闯荡，无畏艰难，庙堂驰骋，纵横捭阖,闯荡修仙之路，掌控无尽山海，探求仙尊大道，傲视万千仙妖。 这一次写个简单点的，就写人妖两族的事情，多写一点生活气息，让我们一起在简单中欢度时光，留下点记忆。 ',1,4,1,0,110,'2018-11-22 10:22:07','2018-11-22 10:26:04',NULL,'2018-11-22 10:22:07'),(29,3,'凡人仙帝路','汾江居士','/uploads/20181122/e9e7d013767cb7ee5e97919582ab13bf.jpg','末落的修仙界如何修仙？如何成就长生？请看一个奇遇不断的小子，肩负着修仙界前辈的期望，冒死打通与繁荣修仙界的联系，最后飞升仙界、成就仙帝！',1,4,1,0,10,'2018-11-22 10:25:40','2018-12-18 17:49:29',NULL,'2018-11-22 10:25:40'),(30,2,'超神巫师','奇幻写手','/uploads/20181218/5c9617a4c21ce50e4688ab8128c68226.png','一场科学实验，让林成在巫师世界重生，行走在巫师世界，追寻真理，探索世界的奥秘，最终成为一名超神的故事。',2,1,1,0,15,'2018-12-18 16:15:32','2018-12-18 16:15:32',NULL,'2018-12-18 16:15:32'),(31,2,'超维入侵','一念乱天机','/uploads/20181218/c450698d1248c6a9b81c42ff64c99aaf.png','时空拐点的诡异世界，超越理解的事物，恐怖入侵现实，梦幻与真实的交融，隐藏着怎样的秘密，独特的天赋，走向强者之路，生存的挣扎，卑微者的战争。',2,1,1,0,16,'2018-12-18 16:17:23','2018-12-18 16:17:23',NULL,'2018-12-18 16:17:23'),(32,2,'帝道独尊','一叶青天','/uploads/20181218/0c5f005a85f419ff93b3bd7f98e4cab9.png','天地初始，宇宙洪荒；奇门九遁，布道星空。当地球尘封万古的雪山龙棺移位时刻，诛天大道临世，神魔文明到来，宇宙如同撕裂枷锁的神魔，演化着一个精彩绝伦的修行世界。仙命少年从弱小中崛起，一步步踏向宇宙星海，战万界，伐仙穹............',2,1,1,0,15,'2018-12-18 16:18:42','2018-12-18 16:18:42',NULL,'2018-12-18 16:18:42'),(33,2,'极品小画仙','腊玖','/uploads/20181218/4b565def71e211f9afd11a2756f41f47.png','修真故事，非傻白甜。一个涉世未深的机灵女画师，掉入腹黑六王爷的圈套。红尘漫漫，又有几人能逍遥？浊酒作伴，醉生梦死须尽欢。天命已定？她不信，不问天，赤子之心，披荆斩棘，繁华一梦，江山染血，但去无悔。长篇小说，步调比较慢，HE。',2,1,1,0,13,'2018-12-18 16:20:12','2018-12-18 16:23:34',NULL,'2018-12-18 16:20:12'),(34,2,'万古无敌天帝系统','一步入青云','/uploads/20181218/b7eaac8314ab63e515cf7b6a47a34509.png','少年叶星辰，血脉被夺，却意外获得天帝系统。创建至高皇朝，吞纳诸天气运。驾驭周天星斗，凝聚无上神兵，征战诸天三千界。神界之上，我为天帝。',2,1,1,0,110,'2018-12-18 16:24:57','2018-12-18 16:24:57',NULL,'2018-12-18 16:24:57'),(35,2,'植物崛起','星殒落','/uploads/20181218/391ec8aa58ba64fec73549d52f1d4488.png','植物也能成狂潮，谁说植物就是食物链的下层，植物一样能够称霸。池南在得到改造植物能力之后，以植物为基础，创造了一个强大的帝国。从此以后，用地刺蕨布置阵地，用风炮灌木守城，用豌豆炮冲锋陷阵。植物坦克平推人类营地，绿荫骑士冲垮各种骑兵。灌木战士横扫兽人军团，巨木树精干翻比蒙巨兽。',2,1,1,0,110,'2018-12-18 16:26:21','2018-12-18 16:44:08','2018-12-18 16:44:08','2018-12-18 16:26:21'),(36,7,'呆萌娇妻带球逃','慕梓凡','/uploads/20181218/b3448185b706209ec33581cf5fd68b71.png','当一个呆萌的女主角，遇见腹黑霸道的总裁，会掀起怎样的火花呢？当霸道总裁遇见不讲理的小娇妻，会是怎样的一副忠犬样呢？',2,1,1,1,15,'2018-12-18 16:46:35','2018-12-18 16:51:15','2018-12-18 16:51:15','2018-12-18 16:46:35'),(37,7,'呆萌娇妻带球逃','慕梓凡','/uploads/20181218/e04e996e6d9d62b05c105f16d3f2c678.png','当一个呆萌的女主角，遇见腹黑霸道的总裁，会掀起怎样的火花呢？当霸道总裁遇见不讲理的小娇妻，会是怎样的一副忠犬样呢？',2,1,1,1,10,'2018-12-18 16:51:49','2018-12-18 16:51:49',NULL,'2018-12-18 16:51:49'),(38,7,'第一首席：豪宠酷拽坏宝贝','爱尚','/uploads/20181218/2af279e75399c5eff50a42eba231efb5.png','她，花小魔，花家的悲催私生女，被渣男出卖，躲错房踢了某总，从此结下梁子。他勾唇坏笑，“女人，我要你给我疼回来！”各种手段打击，只为鞭、抽、踩、踏、虐，各种引以为乐。“你属什么的？”某女皱皱眉，火药指数攀升。他兴趣一来，“听好，我属狼……”勾她下颚，一脸邪魅地看着某女，“听说，你有个爱好，喜欢偷鸡摸狗？”“哦，懂了，原来祁总不过是只披着狼皮的鸡狗啊……”帅哥MM爽文宠文，精彩一对一。',1,1,1,1,15,'2018-12-18 17:15:54','2018-12-18 17:21:08',NULL,'2018-12-18 17:15:54'),(39,7,'惹爱成瘾','半世琉璃','/uploads/20181218/5571c334d543788c755a4e8fd1de6726.png','惹爱成瘾是半世琉璃所著的一部都市言情类佳作!',1,1,0,1,13,'2018-12-18 17:23:22','2018-12-18 17:23:22',NULL,'2018-12-18 17:23:22'),(40,3,'都市之绝世狂仙','紫晶花生','/uploads/20181218/172fe3cfa17456d3e3d2293ba78d9008.png','【绝对无敌】修真界化神境强者龙昊，遭逢意外，来到地球。龙昊只想完成师父心愿，然后重返修真界报仇，却总有不开眼的人惹上门！你是狂霸江湖大佬？拍死！你是顶级豪门大少？拍死！你是天才古武传人？拍死！凡是敢惹我的，通通拍死！什么，你有强者做靠山？不好意思，我无敌！',1,1,1,1,26,'2018-12-18 17:35:51','2018-12-18 17:35:51',NULL,'2018-12-18 17:35:51'),(41,3,'都市最强修真学生','林北留','/uploads/20181218/e5f250ec804af6c179e8c5e995a5ce28.png','【火爆畅销】无敌仙尊，重生都市，降临到了一名普通的高三学生身上。会修真、通医道、能隐身，游走校园，玩转都市，以爆表的力量横扫一切，专治各种不服！我会修真，任我纵横！',1,1,1,0,15,'2018-12-18 17:37:01','2018-12-18 17:37:01',NULL,'2018-12-18 17:37:01'),(42,3,'幻界仙途','沙荷四对','/uploads/20181218/1238e0222a2d0025f57c72f55007a76e.png','天下之大，无奇造化！芸芸众生，不过蜉蝣蝼蚁。古来英豪，须臾白发。沧桑尽历，哀哀而终??????然而，世事无情，天公有意。当你立足于这片天地之始，便早已有无数双贪婪的眼睛注视着你。何一诺，一个平凡的世人，又该如何修真道、得永生，摆脱命运的枷锁?',1,1,1,1,16,'2018-12-18 17:38:24','2018-12-18 17:38:24',NULL,'2018-12-18 17:38:24'),(43,3,'极品飞仙','金铃动','/uploads/20181218/968a229325977c1a094436fcfbe2337d.png','仙与魔的永恒争斗，琴与剑的绝世情缘，这是一个宏大而瑰丽的仙侠世界，一对少男少女踏上修仙路……',1,1,1,1,15,'2018-12-18 17:39:32','2018-12-18 17:39:32',NULL,'2018-12-18 17:39:32'),(44,3,'九幽天帝','给力','/uploads/20181218/4c2be9cd5606dd5f858a7247d5372de2.png','【全网最火爆玄幻，总点击过亿，倾情力荐！】为夺有望冲击神境至宝万物之源，一代强者九幽大帝陨落，重生为一名叫石枫的少年。且看石枫如何凭借前世苏醒的记忆，扼杀各方天才，夺天地造化，踏着累累白骨，回归大帝之位！',1,1,1,0,28,'2018-12-18 17:40:46','2018-12-18 17:40:46',NULL,'2018-12-18 17:40:46'),(45,3,'逆命魔主','陈森然的右手','/uploads/20181218/15e2ab0531bffbc89ab1370e217e0ccf.png','身患绝症而死的陈重穿越到了一个受命格主宰的武侠世界。在这个世界里，每个人都有自己的命格，不同的命格会带来不同的作用。拥有‘逢赌必赢’命格的人，只要去赌钱，就一定会赢。拥有‘千军僻易’命格的人天生就可以散发出令千军都僻易的可怕威压，上战场如入无人之境，完全就是天生的绝世猛将。陈重魂穿的身躯本来拥有百年难得一见的七两天命‘百无禁忌’，可以说是万中无一的练武奇才，结果被人所害，在陈重穿越时，已经被换上了‘七日必死’的命格，七天之内必死，陈重必须在七天内求活',1,1,1,0,16,'2018-12-18 17:43:39','2018-12-18 17:43:39',NULL,'2018-12-18 17:43:39'),(46,3,'重回八零当军嫂','暖金','/uploads/20181219/82fec1d45a8389254788e7addb1aa1d5.jpg','林宛悔，悔自己识人不清，受了好友的蒙骗，最后被渣男抛弃，最后身败名裂，不得不离开那个英姿飒爽、铁骨铮铮的人，最后凄惨潦倒的过完一生，晚景凄凉。重活一世，今生不想再重蹈覆辙，她势要将那颗虚荣的心泯灭掉，要拥有自己精彩的人生。林宛有很多事想做。但最重要的一件事情便是：再次俘虏那个对她深情的男人。努力赚钱，找到他，嫁给他，和他好好过日子！',1,1,1,0,10,'2018-12-19 16:41:38','2018-12-19 16:41:38',NULL,'2018-12-19 16:41:38'),(47,3,'遮天','辰东','/uploads/20181219/4cb5d9d3a7f3e3ff96b8f1d214de137d.jpg','冰冷与黑暗并存的宇宙深处，九具庞大的龙尸拉着一口青铜古棺，亘古长存。这是太空探测器在枯寂的宇宙中捕捉到的一幅极其震撼的画面。九龙拉棺，究竟是回到了上古，还是来到了星空的彼岸？一个浩大的仙侠世界，光怪陆离，神秘无尽。热血似火山沸腾，激情若瀚海汹涌，欲望如深渊无止境……登天路，踏歌行，弹指遮天。',1,1,1,0,15,'2018-12-19 16:44:09','2018-12-19 16:44:09',NULL,'2018-12-19 16:44:09'),(48,3,'女君凤无双','淳汐澜','/uploads/20181219/f40da688818e73d8e98608620ebafef3.jpg','身为凤族未来女君的我，这五万年来，一直在纠结一件事。我真要嫁给龙族太子龙默然吗？大家都说，成为龙后，对积弱已久的凤族来说，相当重要。可是，龙默然单方面退婚，害得我成为九州笑柄。这口气，我为什么要出？不就是退个婚嘛，又不会少块肉。直到有一天，拌猪吃老虎吃得正欢时，已经娶了四个侧妃的龙默然忽然有一天来质问我：“你们凤族什么时候也修炼出媚术了？”呵，本公主名震仙界，靠的是人品和个人魅力，何需媚术？',1,1,1,1,16,'2018-12-19 16:51:23','2018-12-19 16:51:23',NULL,'2018-12-19 16:51:23'),(49,3,'宠后多娇：昏君养成守则','木羽年華','/uploads/20181219/b4b02ad3a9bda0cc761de549e3371e32.jpg','上一世，苏婉容忍气吞声了一辈子，最后只落得被妾室赶出王府，死于冰冷脏污积雪中的凄惨下场。这一世，苏婉容势必要改写自己的命运。她要远离王室，远离皇族，嫁给一个平凡老实的男人安安稳稳度过此生。未曾想，她确实改写了命运，但终究没能逃离皇室，甚至直接嫁给了那个传闻中蛮横不讲理的九五之尊！……上一世的晋元皇帝，生性暴戾，喜怒无常，阴狠无情。但至少杀伐果断，才力过人。继位之后，一再扩张国土，百姓安康，勉强还称得上是一代明君。这一世的晋元皇帝，脾气依旧阴晴不定。他卑鄙无耻，甚至强夺臣子之妻！登基之后，怠于朝政。',1,1,1,0,15,'2018-12-19 16:56:17','2018-12-19 16:56:17',NULL,'2018-12-19 16:56:17'),(50,3,'最强山贼系统','蛤蟆大王','/uploads/20181219/dfe8c043fd2430256f5dba0ce891f57d.jpg','青牛山，蛤蟆岭，蛤蟆寨，几个面红耳赤的大汉。\r\n\r\n    “大当家在的时候，咱们蛤蟆寨多么威风，整座青牛山的山贼都得听我们的。可大当家一死，弟兄们死走逃亡，就剩下咱们哥几个。”\r\n\r\n    “官兵马上要来围剿，凭咱们几个根本守不住，散伙算球。”\r\n',1,1,1,0,13,'2018-12-19 16:57:53','2018-12-19 16:57:53',NULL,'2018-12-19 16:57:53'),(51,3,'都市超级医圣','断桥残雪','/uploads/20181219/b67bd79e3cd5a4aaa49f968c2f29b4f0.jpg','财法侣地，修行其实是一项非常耗钱的奢侈运动。无意中得到传说中道教学家，炼丹家，医药家葛洪的传承，淳朴的山里人葛东旭开始努力赚钱。当大多数人还在读高中时，他为了炼丹修行已经开始一边读书一边赚钱。当大多数人读大学还在为交女朋友的开销发愁时，他已经是一名老板。当大多数人大学毕业在为找工作四处投简历，当富二代开着跑车，在美女面前炫耀时，他已经是一名超级富一代，当然还是一名大隐隐于市的至尊医圣。',1,1,1,0,15,'2018-12-19 16:58:53','2018-12-19 16:58:53',NULL,'2018-12-19 16:58:53'),(52,3,'飞剑问道','我吃西红柿','/uploads/20181219/9d98966c75986fcb2e9e176ee7bc6356.jpg','在这个世界，有狐仙、河神、水怪、大妖，也有求长生的修行者。修行者们，开法眼，可看妖魔鬼怪。炼一口飞剑，可千里杀敌。千里眼、顺风耳，更可探查四方。……秦府二公子‘秦云’，便是一位修行者……',1,1,1,0,15,'2018-12-19 17:00:44','2018-12-19 17:00:44',NULL,'2018-12-19 17:00:44'),(53,3,'武侠世界侠客行','大江入海','/uploads/20181219/b6e8b40edb8ca1b6d5936366c6d0b57d.jpg','与黄飞鸿一起训练民团，杀敌报国，与陈真一起斩杀倭国贼寇，在龙门客栈中与金香玉调笑弄情，在兰若寺中，与燕赤霞谈笑风声。乱世之中，系统加身，能自由穿越各个经典动作片世界的李侠客，跨马舞长枪，扫平一切敌。让我们重温幼年时的动作影视。',1,1,1,1,16,'2018-12-19 17:01:46','2018-12-19 17:01:46',NULL,'2018-12-19 17:01:46'),(54,3,'凡人修仙之仙界篇','忘语','/uploads/20181219/5929e6f6115c78cf67ec3c2df49b1be5.jpg','凡人修仙，风云再起时空穿梭，轮回逆转金仙太乙，大罗道祖三千大道，法则至尊《凡人修仙传》仙界篇，一个韩立叱咤仙界的故事，一个凡人小子修仙的不灭传说。',1,1,1,0,15,'2018-12-19 17:02:26','2018-12-19 17:02:26',NULL,'2018-12-19 17:02:26'),(55,3,'三寸人间','耳根','/uploads/20181219/21fd915e1cb239b941bb8356ece62336.jpg','举头三尺无神明，掌心三寸是人间。这是耳根继《仙逆》《求魔》《我欲封天》《一念永恒》后，创作的第五部长篇小说《三寸人间》。',1,1,1,0,16,'2018-12-19 17:04:29','2018-12-19 17:04:29',NULL,'2018-12-19 17:04:29'),(56,3,'武侠世界的小配角','庞德耀斯','/uploads/20181219/6bf3cebac735ce796e90c5f05294bd43.jpg','这是一个屌丝男稀里糊涂穿越到武侠世界，然后和附送的系统斗智斗勇，顺手解决几个大反派的故事。真的只是顺手，而已。',1,1,1,0,15,'2018-12-19 17:05:40','2018-12-19 17:05:40',NULL,'2018-12-19 17:05:40'),(57,3,'都市最强妖精系统','九月鲤鱼','/uploads/20181219/55c3e63d666aaf4fb4a6c7a58b34fd10.jpg','无意间救了一个绝美妖精，身体从此一天不如一天……',1,1,1,0,15,'2018-12-19 17:06:41','2018-12-19 17:06:41',NULL,'2018-12-19 17:06:41'),(58,3,'武侠之数据风暴','一碗酸梅汤','/uploads/20181219/0d077d7c607d0610e785bab014838e2b.jpg','一个歌舞升平的江湖，一个浪漫旖旎的武林。大科学家方源携带人工智能穿越而来，究竟是一滴融入汪洋的水滴，还是跳进棋盘的石头？九阳神功、乾坤大挪移、无限剑制、小无相功、天魔策、凌波微步、奕剑术、三叹剑谱、五行迷踪步、狂龙斗气炮、气圆斩……无数经典武侠技能、幻想武学，在他手里“复现”！劈空·降龙十八掌、六脉·独孤九剑、漫天·小李飞刀、波动·天马流星拳……种种匪夷所思的“改造”武功，纵横低、中、高武。且看他如何收集万千秘籍，山寨经典武侠技能，搅动天下风云！！',1,1,1,0,15,'2018-12-19 17:08:50','2018-12-19 17:08:50',NULL,'2018-12-19 17:08:50'),(59,3,'傲天圣帝','唯易永恒','/uploads/20181219/ac8048e155612116ba19866129bfd0b2.jpg','御九龙，伐诸天，诛神魔，逆转苍穹，证无上圣帝',1,1,1,0,13,'2018-12-19 17:09:32','2018-12-19 17:09:32',NULL,'2018-12-19 17:09:32'),(60,3,'斗战神','人在天涯','/uploads/20181219/251f93020ee41fceeb5e7827a17050b0.jpg','一个寒门天才，一个残酷的世界，一部不屈的斗战史。拥有绝世传承的少年，为了追寻心爱的女子，从边陲小城踏出。之后一路战胜无尽天才，横扫各路势力，一步步踏足万界巅峰！“我不是针对哪个神灵，我是说，诸天所有的神灵，都是辣鸡！”',1,1,1,0,13,'2018-12-19 17:12:20','2018-12-19 17:12:20',NULL,'2018-12-19 17:12:20'),(61,2,'超神巫师','奇幻写手','/uploads/20190105/226ddb8b98e6c6ad1e2405ec9d614d6d.png','一场科学实验，让林成在巫师世界重生，行走在巫师世界，追寻真理，探索世界的奥秘，最终成为一名超神的故事。',2,1,1,0,15,'2019-01-05 14:55:45','2019-01-05 14:55:45',NULL,'2019-01-05 14:55:45');

/*Table structure for table `novel_chapter` */

DROP TABLE IF EXISTS `novel_chapter`;

CREATE TABLE `novel_chapter` (
  `chapter_id` int(11) NOT NULL COMMENT '章节',
  `novel_id` int(11) NOT NULL DEFAULT '0' COMMENT '小说id',
  `chapter_sort` int(11) NOT NULL DEFAULT '0' COMMENT '章节编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '章节名',
  `content` text NOT NULL COMMENT '内容',
  `spend` int(11) NOT NULL DEFAULT '0' COMMENT '所需钻石'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='章节';

/*Data for the table `novel_chapter` */

/*Table structure for table `novel_classify` */

DROP TABLE IF EXISTS `novel_classify`;

CREATE TABLE `novel_classify` (
  `nc_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '小说分类',
  `nc_name` varchar(30) DEFAULT NULL COMMENT '小说分类名称',
  PRIMARY KEY (`nc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='小说分类';

/*Data for the table `novel_classify` */

insert  into `novel_classify`(`nc_id`,`nc_name`) values (2,'玄幻奇幻'),(3,'武侠仙侠'),(4,'穿越重生'),(5,'古代言情'),(6,'科幻灵异'),(7,'现代言情'),(8,'网游竞技'),(9,'历史军事'),(10,'耽美同人');

/*Table structure for table `novel_count` */

DROP TABLE IF EXISTS `novel_count`;

CREATE TABLE `novel_count` (
  `novel_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '小说属性计数，一对一关联wb_novel',
  `reading_volume` int(11) NOT NULL DEFAULT '0' COMMENT '阅读量',
  `number_of_chapters` int(11) NOT NULL DEFAULT '0' COMMENT '章节数',
  `number_of_likes` int(11) NOT NULL DEFAULT '0' COMMENT '点赞量',
  `number_of_reward` int(11) NOT NULL DEFAULT '0' COMMENT '打赏量',
  `number_of_reward_human` int(11) NOT NULL DEFAULT '0' COMMENT '打赏人数',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`novel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COMMENT='小说动态统计';

/*Data for the table `novel_count` */

insert  into `novel_count`(`novel_id`,`reading_volume`,`number_of_chapters`,`number_of_likes`,`number_of_reward`,`number_of_reward_human`,`update_time`) values (1,423,234,423,0,0,NULL),(2,0,0,5,99,1,NULL),(3,0,0,0,0,0,NULL),(4,509,52,55,21459,22,NULL),(5,130,3235,13,24686,15,NULL),(6,34,36,35,33,36,'2018-11-01 16:34:45'),(7,9,24,10,3987,2,'2018-11-10 11:49:26'),(8,1,1458,0,17628,6,'2018-11-10 10:47:28'),(9,1,1550,0,8251,5,'2018-11-06 11:38:49'),(10,0,320,10,376,2,'2018-11-06 11:25:25'),(11,140,2233,8,10931,14,'2018-11-09 15:36:42'),(12,0,1870,0,0,0,'2018-11-09 17:49:01'),(13,0,0,0,0,0,NULL),(14,0,0,0,0,0,NULL),(15,0,0,0,0,0,NULL),(16,14,751,0,43344,13,'2018-11-09 17:49:29'),(17,0,0,0,0,0,NULL),(18,0,0,0,0,0,NULL),(19,0,0,0,0,0,NULL),(20,0,0,0,0,0,NULL),(21,0,0,0,18628,6,NULL),(22,0,729,0,0,0,'2018-11-10 10:39:29'),(23,1,230,0,0,0,'2018-11-10 12:06:34'),(24,0,0,0,0,0,NULL),(25,2,140,0,0,0,'2018-11-22 10:12:20'),(26,0,2994,0,0,0,'2018-11-22 10:18:57'),(27,0,166,0,0,0,'2018-11-22 10:20:44'),(28,0,1226,0,0,0,'2018-11-22 10:24:17'),(29,0,759,0,0,0,'2018-11-22 10:26:51'),(30,1,467,0,0,0,'2018-12-18 16:16:11'),(31,0,700,0,0,0,'2018-12-18 16:17:48'),(32,0,875,0,0,0,'2018-12-18 16:19:15'),(33,0,316,0,0,0,'2018-12-18 16:24:04'),(34,0,310,0,0,0,'2018-12-18 16:25:29'),(35,0,0,0,0,0,NULL),(36,0,0,0,0,0,NULL),(37,22,0,2,0,0,NULL),(38,13,2777,0,0,0,'2018-12-18 17:28:21'),(39,3,0,0,0,0,NULL),(40,0,281,0,0,0,'2018-12-18 17:36:09'),(41,1,2711,0,0,0,'2018-12-18 17:37:49'),(42,0,345,0,0,0,'2018-12-18 17:38:46'),(43,0,2844,0,0,0,'2018-12-18 17:40:15'),(44,0,0,0,0,0,NULL),(45,0,155,0,0,0,'2018-12-18 17:43:55'),(46,0,471,0,0,0,'2018-12-19 16:42:29'),(47,0,1806,0,0,0,'2018-12-19 16:50:40'),(48,0,0,0,0,0,NULL),(49,0,432,0,0,0,'2018-12-19 16:56:59'),(50,0,1540,0,0,0,'2018-12-19 16:58:16'),(51,0,0,0,0,0,NULL),(52,0,621,0,0,0,'2018-12-19 17:01:11'),(53,0,447,0,0,0,'2018-12-19 17:02:01'),(54,0,628,0,0,0,'2018-12-19 17:02:43'),(55,0,0,0,0,0,NULL),(56,0,642,0,0,0,'2018-12-19 17:05:57'),(57,0,506,0,0,0,'2018-12-19 17:06:59'),(58,0,404,0,0,0,'2018-12-19 17:09:05'),(59,0,1079,0,0,0,'2018-12-19 17:09:54'),(60,0,0,0,0,0,NULL),(61,0,464,0,0,0,'2019-01-05 14:57:19');

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_sn` varchar(50) NOT NULL COMMENT '订单号',
  `user_id` int(11) NOT NULL COMMENT '会员id',
  `r_id` int(11) NOT NULL COMMENT '充值类型id',
  `add_time` datetime NOT NULL COMMENT '订单时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '订单状态0未付款1已付款',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `order` */

insert  into `order`(`order_id`,`order_sn`,`user_id`,`r_id`,`add_time`,`status`) values (1,'2018111342890',10001,1,'2018-11-13 13:54:07',0),(2,'2018111313551239654',10001,1,'2018-11-13 13:55:12',0),(3,'2018111314004699045',10001,1,'2018-11-13 14:00:46',0),(4,'2018111314032916279',10001,1,'2018-11-13 14:03:29',0),(5,'2018111314451201736',10001,1,'2018-11-13 14:45:12',0),(6,'2018111314454993686',10001,1,'2018-11-13 14:45:49',0);

/*Table structure for table `seo` */

DROP TABLE IF EXISTS `seo`;

CREATE TABLE `seo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '首页标题',
  `keywords` varchar(255) DEFAULT NULL COMMENT 'seo关键词',
  `description` text COMMENT 'seo描述',
  `copy` text COMMENT '版权信息',
  `code` text COMMENT '统计代码',
  `support` varchar(255) DEFAULT NULL COMMENT '技术支持',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='网站优化';

/*Data for the table `seo` */

insert  into `seo`(`id`,`title`,`keywords`,`description`,`copy`,`code`,`support`) values (1,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `set_book` */

DROP TABLE IF EXISTS `set_book`;

CREATE TABLE `set_book` (
  `set_book_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '书城设置',
  `like_number` int(11) NOT NULL COMMENT '每天点赞数',
  `pid_number` int(11) NOT NULL COMMENT '升级vip的下级数量',
  `vip_day` int(11) DEFAULT '365' COMMENT 'vip的持续时间',
  `share_number` int(11) NOT NULL COMMENT '有效分享次数',
  `share_reward` int(11) NOT NULL COMMENT '分享奖励',
  `phone_reward` int(11) NOT NULL COMMENT '绑定手机号奖励',
  `share_title` varchar(30) NOT NULL COMMENT '分享标题',
  `share_content` varchar(100) NOT NULL COMMENT '分享内容',
  `share_image` varchar(255) NOT NULL COMMENT '分享图片',
  PRIMARY KEY (`set_book_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `set_book` */

insert  into `set_book`(`set_book_id`,`like_number`,`pid_number`,`vip_day`,`share_number`,`share_reward`,`phone_reward`,`share_title`,`share_content`,`share_image`) values (1,10,20,30,20,20,50,'微信书城','一个读书的平台','/uploads/20181112/45c83dbfd4903b9c5d02359b922909ba.jpg');

/*Table structure for table `set_recharge` */

DROP TABLE IF EXISTS `set_recharge`;

CREATE TABLE `set_recharge` (
  `recharge_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '充值规则',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '充值金额',
  `get_currency` int(11) NOT NULL DEFAULT '0' COMMENT '得到虚拟币（钻石）',
  `give_currency` int(11) NOT NULL DEFAULT '0' COMMENT '赠送虚拟币',
  `give_money` int(11) NOT NULL DEFAULT '0' COMMENT '赠送虚拟币价值人民币',
  PRIMARY KEY (`recharge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='充值设置';

/*Data for the table `set_recharge` */

insert  into `set_recharge`(`recharge_id`,`money`,`get_currency`,`give_currency`,`give_money`) values (1,30,3000,0,0),(2,50,5000,3000,30),(3,100,10000,8000,80),(4,200,20000,20000,200);

/*Table structure for table `set_reward` */

DROP TABLE IF EXISTS `set_reward`;

CREATE TABLE `set_reward` (
  `reward_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '打赏礼物',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `image` varchar(100) DEFAULT NULL COMMENT '图片',
  `value` int(11) DEFAULT NULL COMMENT '价值（钻石）',
  PRIMARY KEY (`reward_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='打赏礼物设置';

/*Data for the table `set_reward` */

insert  into `set_reward`(`reward_id`,`name`,`image`,`value`) values (1,'鲜花','/uploads/20181101/a239a6779a2993ab58722c8bcf2fa775.png',99),(2,'蛋糕','/uploads/20181101/f2f7cc7ccf7c2276d7e199f42661bb70.png',188),(3,'香水','/uploads/20181101/e63ff3ae4ebec9f1f0b08ed67d6a90a5.png',388),(4,'钻戒','/uploads/20181101/dc15f710c6fb597c35e77dbac005d4a5.png',1388),(5,'蓝色妖姬','/uploads/20181101/a7113e5e46216365a6127f538a26eb8e.png',1688),(6,'游艇','/uploads/20181101/f63b251a79ff18dbcf84163f96a0fd1c.png',3888);

/*Table structure for table `set_sign` */

DROP TABLE IF EXISTS `set_sign`;

CREATE TABLE `set_sign` (
  `sign_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '签到规则id',
  `day` int(11) NOT NULL DEFAULT '0' COMMENT '第几天',
  `reward` int(11) NOT NULL DEFAULT '0' COMMENT '奖励金额',
  PRIMARY KEY (`sign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='签到设置';

/*Data for the table `set_sign` */

insert  into `set_sign`(`sign_id`,`day`,`reward`) values (1,1,30),(2,2,40),(3,3,50);

/*Table structure for table `sys` */

DROP TABLE IF EXISTS `sys`;

CREATE TABLE `sys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '公司名称',
  `username` varchar(255) DEFAULT NULL COMMENT '负责人',
  `url` varchar(255) DEFAULT NULL COMMENT '网站域名',
  `qq` char(20) DEFAULT NULL COMMENT '客服QQ',
  `icp` varchar(255) DEFAULT NULL COMMENT 'icp备案号',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `tel` varchar(255) DEFAULT NULL COMMENT '固定电话',
  `phone` char(20) DEFAULT NULL COMMENT '手机号码',
  `longs` varchar(255) DEFAULT NULL COMMENT '经度',
  `lats` varchar(255) DEFAULT NULL COMMENT '纬度',
  `service_wx` varchar(255) DEFAULT NULL COMMENT '客服wx',
  `work_time` varchar(255) DEFAULT NULL COMMENT '工作时间',
  `addr` varchar(255) DEFAULT NULL COMMENT '公司地址',
  `content` text COMMENT '公司简介',
  `pclogo` varchar(255) DEFAULT NULL COMMENT '电脑端logo',
  `pclogos` varchar(255) DEFAULT NULL,
  `waplogo` varchar(255) DEFAULT NULL COMMENT '手机端logo',
  `qrcode` varchar(255) DEFAULT NULL COMMENT '微信二维码',
  `wx` varchar(255) DEFAULT NULL COMMENT '微信公众号',
  `fax` varchar(255) DEFAULT NULL COMMENT '公司传真',
  `telphone` varchar(255) DEFAULT NULL COMMENT '400电话',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='网站基本信息';

/*Data for the table `sys` */

insert  into `sys`(`id`,`name`,`username`,`url`,`qq`,`icp`,`email`,`tel`,`phone`,`longs`,`lats`,`service_wx`,`work_time`,`addr`,`content`,`pclogo`,`pclogos`,`waplogo`,`qrcode`,`wx`,`fax`,`telphone`) values (1,'腾腾书友会','','','kefuqq','','','','13673378844','','','','周一到周五9:30-20:30、周六周日9:30-18:30','','','/uploads/20180917/b2bff5a2dcd09c5885d3a5277ebbac59.png','/uploads/20180918/698c981f629493a02f045e14dccf37b4.png','/uploads/20180920/0f3b0fee0250b419fd921d0a5734004a.png','/uploads/20181218/2410e82d45baaf6cd9b3c1106dfcf36c.png',NULL,'','');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员id',
  `user_name` varchar(50) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '会员名称',
  `user_image` varchar(255) NOT NULL DEFAULT '' COMMENT '会员头像',
  `user_phone` varchar(18) NOT NULL DEFAULT '' COMMENT '会员手机号',
  `balance` int(11) NOT NULL DEFAULT '0' COMMENT '余额',
  `vip` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是vip，0不是1是2是后台设置',
  `openid` varchar(50) DEFAULT NULL COMMENT 'openid',
  `add_time` datetime DEFAULT NULL COMMENT '注册时间',
  `pid` int(11) DEFAULT '0' COMMENT '上级id',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10054 DEFAULT CHARSET=utf8 COMMENT='会员';

/*Data for the table `user` */

insert  into `user`(`user_id`,`user_name`,`user_image`,`user_phone`,`balance`,`vip`,`openid`,`add_time`,`pid`) values (10028,'暗语寒飞','http://thirdwx.qlogo.cn/mmopen/vi_32/ibytib2JRtibvnqurBXhuicUaJc7AyRWEHEYHgZOPzOVficCWcibK7pCVHrp8ZSaXgsUnLqfZHczsxQ610jJl0CPCkpg/132','',892598,0,'of3km50u_b-8-uBo6ZCXgGzZmTTU','2018-12-14 15:48:26',10045),(10029,'ECHO?','http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoH1AlViaiagB9us4dh3lqQwiaqftjhDybxsGlzaoic66giaBgDO2S7RQmkiapD1aNiabuR5icgzXfu8H2GZw/132','',888948,0,'of3km50RIv6BSb1YxDKHDNosirHQ','2018-12-14 16:28:23',10001),(10030,'? ʚ AN. ɞ','http://thirdwx.qlogo.cn/mmopen/vi_32/RfI6z1tsvia2F2UU72LmWJMwuvYte2VypFQxY9Wwyp9HkTez4IokfNZKIYicpUbk7468JWGicTvrZTqcKSbFJVjgg/132','',888700,0,'of3km59YIfDh3IPnUKHarD5uZZRE','2018-12-14 17:28:58',0),(10031,'二  月  半  ','http://thirdwx.qlogo.cn/mmopen/vi_32/PiajxSqBRaEL7Ujb3wHJpxl5FBTK4kkLVicN68vZydc9lpicWpl4eVI8d9jkPJAcLf1BDmFDHDYEfSyltbvk444EQ/132','',888888,0,'of3km52nUg9K8DPM_eCIcV2nBd6Y','2018-12-14 17:56:21',0),(10032,'Dy','http://thirdwx.qlogo.cn/mmopen/vi_32/Or35iaQs4TmfKW7QkmMPBMrrz7ElmSYDQicFOm09N7l0hDtpqm47Mic6Z2CibiaOibo0FMyrGIUVHiaQWGL4WsasSziayA/132','',888888,0,'of3km5-32ebDvOjckfQXCpwyp1Bw','2018-12-14 17:56:25',0),(10033,'undefined','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKXOhEO7Z5bqdoibZExibIp2eaKMIynICD7hj1loMsRNVNmR3iaAy5aTh8ld8Po3LYX4SibCM3jdRKic2Q/132','',888888,0,'of3km55Kf08Iw9OrJNHolSZkbUqs','2018-12-14 17:56:37',0),(10034,'小丑','http://thirdwx.qlogo.cn/mmopen/vi_32/iaH9jeLeOmpicdPNWEBAjjGWjztogdKF03FT0oibZ37nLLVKTBoQLarxGx8h33aHomZXZDEU5BeC3XqBJ8aIkwxrw/132','',888819,0,'of3km5z6r51_bgcUIKZQHRXXCRHQ','2018-12-14 17:56:53',0),(10035,'Perfect','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKUT0xYqIfAnzvHmDZKic6tA9xibTHV8h2icr9LMm3oydtCAdUnP6unyZ1ScdKPCwicMcac9FyX2ib4tVg/132','',888888,0,'of3km5zFS4Y4hWFm6s20K3ZWx2qo','2018-12-14 17:56:56',0),(10036,'信仰','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIABEibfq5E21x6TMBhGFLztyHM2lAsksDJicibMThGVRC0rrERQVdzFMmDVfRKH1W5Ut0TtibicUqDL2Q/132','',889758,2,'of3km51YbvDdsflsKLxc6Re4pJVo','2018-12-14 17:57:18',0),(10037,'xixi浅笑','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKqAhKaiceLgk67lkndkn1IMWsoxvYYP37aX2tq0srmXlRo5z2znm0tWm88GPzEjY7uBJmBzaVpyIg/132','',888888,0,'of3km5_emWgeiUl1T0nrmWgNkspo','2018-12-14 18:00:29',0),(10038,'薛柯','http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqS6wCEdy5ticqurk4Qze0wddwYfu5Nogktibv9eJbfBY48fUjUoBllytr3msbMaiaPafia4P7hY16auw/132','',888888,0,'of3km54gJhRbTAcKKazgWhn_QSnM','2018-12-14 18:01:53',0),(10039,'Sion_ren','http://thirdwx.qlogo.cn/mmopen/vi_32/yNibssxAicLFtibP8H9Z89EKjnz55icqd09aZib4IlBDJvKatyyFAJdQicnEjibgI16gHsXMpEATKqgRN4icEkiafE2zRww/132','',888888,0,'of3km5xoDMfYZlpywZ1ufpILOyV8','2018-12-14 18:02:00',0),(10040,'六月','http://thirdwx.qlogo.cn/mmopen/vi_32/nicib8gqImzrBXz0943oxAeOGVGHvaQ5YZkmEod5FBibCRaOJOCLcMhmtIljNhIzvk4q2FSfjLRPfqfYVmbqUOkTw/132','',8888888,0,'of3km5xc-vu-WS5sCTi3CvYqUcHk','2018-12-14 18:02:19',0),(10041,'15136796918','http://thirdwx.qlogo.cn/mmopen/vi_32/YqNibWyKvpXvLq1FhdySE6InJejOhxH5HPz3ibmYOeUnmaqV04E7DlkGxzDiamtvDacTddOjXFwHiaY7Lic4tuGBFng/132','15225967787',210,0,'of3km59cW_sVx-rA0boz4OEXlSzs','2018-12-14 18:18:51',0),(10042,'刘李委','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLnplGsNMOjNyldMVgEHPJwEVKWpMVqh584YxPhGldH9AQ4icMicT4hDdsw4DRBlmDfFFiaHlibfX6ibuA/132','',30,0,'of3km5yvUtLcupRIjBSQ0NZB_mfA','2018-12-15 17:25:38',0),(10043,'꧁༺青花瓷༻꧂15225967787','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLEGtB7lUzH6yqb253u1iaeWlSC8RZD5mulUdFQYu7rY0Qftqh0zJ6auhZPGqH9nn8sCCl50CI3nYw/132','',0,0,'of3km5xJPTdrfRvdzBgbH25nysNo','2018-12-16 08:11:06',0),(10044,'生如夏花','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKVCX4HiacgXhibJ9yzFlQjWdNZxPWk7wQMb3bcMCGedV9s6ZB5MGFsz5hCgrhFCerFq8PqjS7WHYDg/132','',30,0,'of3km5wEYkr9XEnkjcNVhsfYcBDU','2018-12-16 14:51:11',0),(10045,'朵朵科技客服','http://thirdwx.qlogo.cn/mmopen/vi_32/Z47YBfnj5vc6DTZQNNIuuHP6g2UdaIvsqZXZJwCuSADw8tKiabTjUkquVCmiaqjKZ6vZ6ib28CbFjtA8KA5ll8SmA/132','',20,0,'of3km5xhRjEa5FoSjIvraG2jl104','2018-12-17 15:58:28',0),(10046,'Allen 江德炜','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJ860MuOtHOTFEFjicxEdNBzLz3jH39a91XYROAyre6DK338TG1MUjvO3u5V5wWt21liaQAswY0ggAQ/132','',0,0,'of3km53TTwCNwQ1GcHzr76yO2_xc','2018-12-23 17:44:43',0),(10047,'蒙蒙蒙蒙蒙蒙','http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTIozLUctxVkuwM7OtEtTqaMw0JxS99HcV5UOzEhs7kiacvibsicrYlgDZWMQ1L0jWU400WzOGAia6dxibg/132','',20,0,'of3km509lEsPVRoGUlpVb6sRJlTo','2018-12-24 10:36:13',10028),(10048,'笑口常开','http://thirdwx.qlogo.cn/mmopen/vi_32/CDfzCpp1alwPQxIBzUiaPHT4MQbstO8ZZSKKIsXEbO2byLyNbjXHqxeqEibk8iaXc0maSHzXEsWFhMrwLXkkrIpzg/132','',0,0,'of3km50cwugkXdf58VlwngCkKlR8','2018-12-24 11:10:44',10041),(10049,'意难忘','http://thirdwx.qlogo.cn/mmopen/vi_32/511n2FT41o8eNs8ZVicYNpKAEECbej49QIrclGvmdT05DmEp0GxJAUw0Qdzk6PmPuUwQtibmUXwpsBjQebAIp4Eg/132','',0,0,'of3km5wMrC-TfdFXusIA3BdMjF_Y','2018-12-24 11:34:50',10041),(10050,'好好学习','http://thirdwx.qlogo.cn/mmopen/vi_32/kCjshGFPUawfv2bnH8DYzfeGzic6fa3cs96qY0CNSBBXOy1pCiaI02sYK2CMeeO5CpyVJ44Eym2IUvWlv6v5TCFw/132','',280,0,'of3km57KVBWTxr7CZ4YZIvuVPPKA','2018-12-25 09:29:47',0),(10051,'我是美美美?','http://thirdwx.qlogo.cn/mmopen/vi_32/MHmxldExzian1TxRJkFP1SlxfUict2N3uUyThsBuaibQeLJU7NWHAqeicE9r9P2CFY5vgDsV12g5dKYDXkCQV6tF3A/132','',0,0,'of3km51Sgvh-KaAid2KSaClipATM','2018-12-25 17:51:42',0),(10052,'淡定','http://thirdwx.qlogo.cn/mmopen/vi_32/qndNbICrNwjc9yialQVFEfnlMm6tZoy3zlTAY0cwES1NfzUPOwSMvL3kw9QQs1pibnCtjnq2PsVzia45y9W99yFfQ/132','',0,0,'of3km55mB9QQei0MtZHSieeW4e48','2019-01-05 12:02:48',0),(10053,'不惑?','http://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoRuTQHhdRAWmsicMGicT66ymia0ZSpn5Incu58SR439du2Ftbia9j4Zmj18lew2GRZ5orOtkicGJr0mGw/132','18737327760',110,0,'of3km5wlAxPNzbaXQvHu4sK9xGvU','2019-01-05 12:14:45',0);

/*Table structure for table `user_bookshelf` */

DROP TABLE IF EXISTS `user_bookshelf`;

CREATE TABLE `user_bookshelf` (
  `bookshelf_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '书架（收藏的书）',
  `user_id` int(11) DEFAULT NULL COMMENT '会员id',
  `novel_id` int(11) DEFAULT NULL COMMENT '书id',
  PRIMARY KEY (`bookshelf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='书架';

/*Data for the table `user_bookshelf` */

insert  into `user_bookshelf`(`bookshelf_id`,`user_id`,`novel_id`) values (13,10000,5),(14,10000,7),(15,10000,4),(16,10000,10),(17,10000,11),(18,10000,8),(20,10002,11),(21,10010,5),(22,10002,9),(23,10002,10),(24,10001,5),(25,10021,16),(26,10007,8),(27,10023,12),(28,10007,16),(29,10034,4),(30,10033,16),(31,10034,11),(32,10028,37),(33,10053,37);

/*Table structure for table `user_like` */

DROP TABLE IF EXISTS `user_like`;

CREATE TABLE `user_like` (
  `like_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '点赞id',
  `user_id` int(11) DEFAULT NULL COMMENT '会员id',
  `novel_id` int(11) DEFAULT NULL COMMENT '小说id',
  `like_time` datetime DEFAULT NULL COMMENT '点赞时间',
  PRIMARY KEY (`like_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='点赞';

/*Data for the table `user_like` */

insert  into `user_like`(`like_id`,`user_id`,`novel_id`,`like_time`) values (1,1,5,'2018-10-31 10:22:27'),(2,1,5,'2018-10-31 10:22:52'),(3,1,5,'2018-10-31 10:22:53'),(4,1,5,'2018-10-31 10:22:54'),(5,1,5,'2018-10-31 10:22:56'),(6,1,5,'2018-11-01 10:24:20'),(7,1,5,'2018-10-29 10:24:22'),(8,1,5,'2018-10-30 10:24:22'),(9,1,5,'2018-10-29 10:24:23'),(10,1,5,'2018-11-01 10:24:23'),(11,1,5,'2018-11-01 14:09:59'),(12,1,5,'2018-11-01 14:10:00'),(13,1,5,'2018-11-01 14:10:01'),(14,1,4,'2018-11-02 14:38:06'),(15,1,4,'2018-11-02 14:38:06'),(16,1,4,'2018-11-02 14:38:07'),(17,1,4,'2018-11-02 14:38:07'),(18,1,4,'2018-11-02 14:38:07'),(19,1,2,'2018-11-05 10:39:11'),(20,1,2,'2018-11-05 10:39:11'),(21,1,2,'2018-11-05 10:39:11'),(22,1,2,'2018-11-05 10:39:12'),(23,1,2,'2018-11-05 10:39:12'),(24,10000,4,'2018-11-06 11:02:42'),(25,10000,4,'2018-11-06 11:02:42'),(26,10000,4,'2018-11-06 11:02:42'),(27,10000,4,'2018-11-06 11:02:42'),(28,10000,4,'2018-11-06 11:02:43'),(29,10001,4,'2018-11-07 09:40:40'),(30,10001,4,'2018-11-07 09:40:40'),(31,10001,4,'2018-11-07 09:40:40'),(32,10001,4,'2018-11-07 09:40:40'),(33,10001,4,'2018-11-07 09:40:41'),(34,10009,11,'2018-11-07 11:59:39'),(35,10002,11,'2018-11-07 16:26:38'),(36,10002,11,'2018-11-07 16:26:39'),(37,10002,11,'2018-11-07 16:26:39'),(38,10002,11,'2018-11-07 16:26:40'),(39,10002,11,'2018-11-07 16:26:41'),(40,10005,11,'2018-11-07 17:42:24'),(41,10002,10,'2018-11-08 17:30:11'),(42,10002,10,'2018-11-08 17:30:12'),(43,10002,10,'2018-11-08 17:30:13'),(44,10002,10,'2018-11-08 17:39:12'),(45,10002,10,'2018-11-08 17:39:13'),(46,10001,10,'2018-11-09 11:47:34'),(47,10001,10,'2018-11-09 11:47:35'),(48,10001,10,'2018-11-09 11:47:35'),(49,10001,10,'2018-11-09 11:47:35'),(50,10001,10,'2018-11-09 11:47:35'),(51,10001,4,'2018-11-09 14:31:31'),(52,10001,4,'2018-11-09 14:31:31'),(53,10001,4,'2018-11-09 14:31:31'),(54,10001,4,'2018-11-09 14:31:32'),(55,10001,4,'2018-11-09 14:31:32'),(56,10007,7,'2018-11-09 20:33:07'),(57,10007,7,'2018-11-09 20:33:08'),(58,10007,7,'2018-11-09 20:33:09'),(59,10007,7,'2018-11-09 20:33:09'),(60,10007,7,'2018-11-09 20:33:09'),(61,10007,7,'2018-11-09 20:33:10'),(62,10007,7,'2018-11-09 20:33:10'),(63,10007,7,'2018-11-09 20:33:10'),(64,10007,7,'2018-11-09 20:33:10'),(65,10007,7,'2018-11-09 20:33:10'),(66,10042,11,'2018-12-16 03:12:32'),(67,10034,37,'2019-01-04 19:55:53'),(68,10041,37,'2019-01-04 20:05:40');

/*Table structure for table `user_login_log` */

DROP TABLE IF EXISTS `user_login_log`;

CREATE TABLE `user_login_log` (
  `ll_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员登录记录',
  `user_id` int(11) DEFAULT NULL COMMENT '会员id',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  PRIMARY KEY (`ll_id`)
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf32;

/*Data for the table `user_login_log` */

insert  into `user_login_log`(`ll_id`,`user_id`,`login_time`) values (1,1,'2018-11-05 16:24:12'),(2,10001,'2018-11-07 09:40:10'),(3,10001,'2018-11-10 09:31:01'),(4,10001,'2018-11-10 09:45:30'),(5,10001,'2018-11-10 14:11:36'),(6,10001,'2018-11-10 16:48:53'),(7,10001,'2018-11-10 17:49:37'),(8,10007,'2018-11-11 05:00:38'),(9,10019,'2018-11-11 19:36:21'),(10,10019,'2018-11-11 19:36:32'),(11,10001,'2018-11-12 08:45:37'),(12,10001,'2018-11-12 09:24:08'),(13,10001,'2018-11-12 09:27:37'),(14,10001,'2018-11-12 09:37:47'),(15,10001,'2018-11-12 09:41:50'),(16,10001,'2018-11-12 11:22:16'),(17,10001,'2018-11-12 14:37:15'),(18,10006,'2018-11-12 16:55:59'),(19,10001,'2018-11-13 11:39:48'),(20,10001,'2018-11-13 11:42:36'),(21,10007,'2018-11-13 12:16:30'),(22,10001,'2018-11-13 13:53:19'),(23,10001,'2018-11-13 14:45:06'),(24,10001,'2018-11-13 14:48:19'),(25,10004,'2018-11-22 09:49:51'),(26,10005,'2018-11-26 15:55:10'),(27,10001,'2018-12-14 15:28:40'),(28,10001,'2018-12-14 15:28:52'),(29,10028,'2018-12-14 15:51:18'),(30,10028,'2018-12-14 15:51:32'),(31,10028,'2018-12-14 15:52:05'),(32,10028,'2018-12-14 15:52:57'),(33,10028,'2018-12-14 15:53:37'),(34,10028,'2018-12-14 15:53:42'),(35,10028,'2018-12-14 16:05:42'),(36,10028,'2018-12-14 16:05:57'),(37,10028,'2018-12-14 16:07:25'),(38,10028,'2018-12-14 16:07:39'),(39,10028,'2018-12-14 16:10:10'),(40,10028,'2018-12-14 16:10:18'),(41,10028,'2018-12-14 16:17:05'),(42,10028,'2018-12-14 16:21:01'),(43,10028,'2018-12-14 16:23:21'),(44,10029,'2018-12-14 16:28:25'),(45,10028,'2018-12-14 16:28:59'),(46,10028,'2018-12-14 16:31:26'),(47,10028,'2018-12-14 16:35:19'),(48,10028,'2018-12-14 16:35:45'),(49,10030,'2018-12-14 17:29:09'),(50,10030,'2018-12-14 17:37:06'),(51,10031,'2018-12-14 17:56:23'),(52,10032,'2018-12-14 17:56:28'),(53,10033,'2018-12-14 17:56:39'),(54,10034,'2018-12-14 17:56:54'),(55,10035,'2018-12-14 17:56:59'),(56,10036,'2018-12-14 17:57:20'),(57,10037,'2018-12-14 18:00:31'),(58,10038,'2018-12-14 18:01:56'),(59,10039,'2018-12-14 18:02:03'),(60,10040,'2018-12-14 18:02:22'),(61,10028,'2018-12-14 18:02:32'),(62,10028,'2018-12-14 18:04:55'),(63,10033,'2018-12-14 18:04:56'),(64,10028,'2018-12-14 18:05:19'),(65,10034,'2018-12-14 18:05:30'),(66,10028,'2018-12-14 18:06:21'),(67,10034,'2018-12-14 18:07:56'),(68,10034,'2018-12-14 18:09:28'),(69,10034,'2018-12-14 18:11:13'),(70,10034,'2018-12-14 18:13:43'),(71,10033,'2018-12-14 18:14:30'),(72,10028,'2018-12-14 18:16:23'),(73,10041,'2018-12-14 18:18:54'),(74,10033,'2018-12-14 19:26:29'),(75,10036,'2018-12-14 21:53:40'),(76,10033,'2018-12-14 22:18:32'),(77,10037,'2018-12-15 14:08:10'),(78,10042,'2018-12-15 17:25:40'),(79,10035,'2018-12-15 20:05:09'),(80,10042,'2018-12-16 03:11:30'),(81,10043,'2018-12-16 08:11:08'),(82,10042,'2018-12-16 14:28:54'),(83,10044,'2018-12-16 14:51:14'),(84,10042,'2018-12-17 15:53:57'),(85,10030,'2018-12-17 15:57:21'),(86,10045,'2018-12-17 15:58:31'),(87,10028,'2018-12-17 16:09:53'),(88,10036,'2018-12-18 09:19:47'),(89,10030,'2018-12-18 15:20:26'),(90,10041,'2018-12-18 15:29:36'),(91,10028,'2018-12-18 15:32:08'),(92,10028,'2018-12-18 16:28:44'),(93,10028,'2018-12-18 16:34:22'),(94,10028,'2018-12-18 17:11:04'),(95,10042,'2018-12-18 17:12:14'),(96,10030,'2018-12-18 17:44:57'),(97,10030,'2018-12-18 17:50:16'),(98,10041,'2018-12-18 18:51:12'),(99,10030,'2018-12-19 16:20:30'),(100,10042,'2018-12-21 03:50:07'),(101,10037,'2018-12-23 00:47:05'),(102,10046,'2018-12-23 17:44:46'),(103,10036,'2018-12-24 09:33:27'),(104,10041,'2018-12-24 09:45:09'),(105,10041,'2018-12-24 09:57:18'),(106,10028,'2018-12-24 10:03:14'),(107,10047,'2018-12-24 10:36:26'),(108,10028,'2018-12-24 10:37:28'),(109,10048,'2018-12-24 11:10:47'),(110,10049,'2018-12-24 11:34:53'),(111,10036,'2018-12-24 15:12:55'),(112,10036,'2018-12-24 15:31:26'),(113,10036,'2018-12-24 16:02:12'),(114,10036,'2018-12-24 16:08:19'),(115,10034,'2018-12-24 17:37:22'),(116,10034,'2018-12-24 17:37:55'),(117,10034,'2018-12-24 17:43:00'),(118,10036,'2018-12-24 18:05:59'),(119,10028,'2018-12-24 18:19:48'),(120,10028,'2018-12-24 18:23:28'),(121,10028,'2018-12-24 18:25:23'),(122,10036,'2018-12-24 21:01:10'),(123,10028,'2018-12-25 09:03:24'),(124,10028,'2018-12-25 09:09:41'),(125,10028,'2018-12-25 09:10:09'),(126,10036,'2018-12-25 09:12:19'),(127,10028,'2018-12-25 09:17:04'),(128,10028,'2018-12-25 09:22:12'),(129,10028,'2018-12-25 09:23:22'),(130,10028,'2018-12-25 09:25:53'),(131,10050,'2018-12-25 09:29:49'),(132,10028,'2018-12-25 09:31:27'),(133,10028,'2018-12-25 09:46:40'),(134,10028,'2018-12-25 09:46:43'),(135,10028,'2018-12-25 09:46:43'),(136,10028,'2018-12-25 10:07:37'),(137,10036,'2018-12-25 15:21:09'),(138,10029,'2018-12-25 16:09:53'),(139,10028,'2018-12-25 16:11:28'),(140,10036,'2018-12-25 16:13:41'),(141,10032,'2018-12-25 16:14:25'),(142,10028,'2018-12-25 16:16:21'),(143,10036,'2018-12-25 16:16:24'),(144,10028,'2018-12-25 16:17:35'),(145,10036,'2018-12-25 16:17:59'),(146,10028,'2018-12-25 16:22:32'),(147,10036,'2018-12-25 16:23:54'),(148,10036,'2018-12-25 16:31:13'),(149,10045,'2018-12-25 16:37:22'),(150,10036,'2018-12-25 16:50:03'),(151,10051,'2018-12-25 17:51:45'),(152,10028,'2018-12-25 18:07:39'),(153,10028,'2018-12-25 18:07:40'),(154,10028,'2018-12-25 18:08:10'),(155,10028,'2018-12-25 18:09:06'),(156,10028,'2018-12-25 18:37:24'),(157,10028,'2018-12-26 08:58:31'),(158,10036,'2018-12-26 09:33:26'),(159,10028,'2018-12-26 09:44:21'),(160,10028,'2018-12-26 14:45:58'),(161,10042,'2018-12-26 16:27:24'),(162,10035,'2018-12-27 08:28:00'),(163,10028,'2018-12-27 18:05:50'),(164,10036,'2018-12-27 18:06:32'),(165,10028,'2018-12-27 18:06:50'),(166,10041,'2018-12-31 12:27:21'),(167,10036,'2019-01-02 18:56:56'),(168,10036,'2019-01-03 09:01:12'),(169,10036,'2019-01-04 09:10:29'),(170,10050,'2019-01-04 14:41:07'),(171,10028,'2019-01-04 19:19:10'),(172,10034,'2019-01-04 19:20:08'),(173,10036,'2019-01-04 19:20:49'),(174,10034,'2019-01-04 19:21:54'),(175,10034,'2019-01-04 19:23:26'),(176,10036,'2019-01-04 19:24:38'),(177,10036,'2019-01-04 19:26:50'),(178,10036,'2019-01-04 19:26:51'),(179,10034,'2019-01-04 19:30:29'),(180,10041,'2019-01-04 19:35:33'),(181,10034,'2019-01-04 19:50:34'),(182,10028,'2019-01-04 20:00:57'),(183,10028,'2019-01-04 20:01:21'),(184,10036,'2019-01-04 20:41:55'),(185,10036,'2019-01-05 09:12:20'),(186,10053,'2019-01-05 12:14:50'),(187,10030,'2019-01-05 14:47:25'),(188,10053,'2019-01-05 14:49:28'),(189,10041,'2019-01-06 22:28:17'),(190,10053,'2019-01-07 09:50:19'),(191,10036,'2019-01-07 09:52:42'),(192,10036,'2019-01-07 16:33:33'),(193,10041,'2019-01-07 20:40:44'),(194,10036,'2019-01-08 09:53:31');

/*Table structure for table `user_look_con` */

DROP TABLE IF EXISTS `user_look_con`;

CREATE TABLE `user_look_con` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员看书配置',
  `font_size` tinyint(1) NOT NULL DEFAULT '1' COMMENT '字体大小，1小号2标准3大号',
  `background` tinyint(1) NOT NULL DEFAULT '1' COMMENT '背景色，1白天，2夜晚，3护眼',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10045 DEFAULT CHARSET=utf8;

/*Data for the table `user_look_con` */

insert  into `user_look_con`(`user_id`,`font_size`,`background`) values (1,3,3),(10000,1,3),(10001,3,3),(10002,3,3),(10003,1,1),(10005,1,1),(10006,1,1),(10007,3,3),(10008,1,1),(10009,3,1),(10010,1,1),(10011,1,3),(10012,1,1),(10013,1,1),(10015,1,1),(10016,1,1),(10018,1,1),(10019,1,1),(10021,1,1),(10026,1,1),(10028,2,3),(10029,1,1),(10030,1,1),(10032,1,1),(10033,1,3),(10034,2,3),(10036,1,1),(10041,1,1),(10042,1,1),(10044,3,1);

/*Table structure for table `user_recent_reading` */

DROP TABLE IF EXISTS `user_recent_reading`;

CREATE TABLE `user_recent_reading` (
  `rr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '最近阅读',
  `user_id` int(11) DEFAULT NULL COMMENT '会员id',
  `novel_id` int(11) DEFAULT NULL COMMENT '书id',
  `chapter_id` int(11) DEFAULT NULL COMMENT '章节id',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`rr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8 COMMENT='最近阅读';

/*Data for the table `user_recent_reading` */

insert  into `user_recent_reading`(`rr_id`,`user_id`,`novel_id`,`chapter_id`,`read_time`) values (5,10000,5,192,'2018-11-06 18:29:50'),(6,10000,2,60,'2018-11-06 10:26:32'),(7,10000,4,90,'2018-11-06 18:31:34'),(8,10000,9,4971,'2018-11-06 18:50:45'),(9,10000,11,8044,'2018-11-06 20:38:07'),(10,10000,10,6514,'2018-11-06 18:29:18'),(11,10003,11,7952,'2018-11-08 17:05:53'),(12,10005,9,6511,'2018-11-07 10:30:32'),(13,10005,11,7954,'2018-11-09 15:45:43'),(14,10006,9,4961,'2018-11-07 09:50:11'),(15,10001,5,156,'2018-11-09 16:37:06'),(16,10002,11,8997,'2018-11-08 17:15:54'),(17,10008,11,7952,'2018-11-07 11:21:20'),(20,10011,5,140,'2018-11-08 16:53:30'),(21,10007,11,7952,'2018-11-09 21:19:17'),(22,10012,11,7952,'2018-11-08 16:53:23'),(24,10015,11,7952,'2018-11-08 16:53:47'),(25,10016,11,7952,'2018-11-08 16:53:51'),(26,10007,4,89,'2018-11-11 05:01:49'),(29,10018,11,7952,'2018-11-08 17:07:47'),(30,10006,4,88,'2018-11-09 21:26:28'),(31,10003,10,6512,'2018-11-08 17:07:40'),(32,10013,4,88,'2018-11-08 17:09:40'),(33,10013,11,7954,'2018-11-08 17:15:10'),(34,10019,4,88,'2018-11-08 17:14:03'),(35,10002,4,88,'2018-11-08 17:16:25'),(36,10009,11,7953,'2018-11-08 17:29:46'),(37,10002,9,4961,'2018-11-08 17:33:08'),(38,10002,10,6514,'2018-11-08 17:37:46'),(39,10001,4,88,'2018-11-12 09:42:16'),(40,10001,11,7953,'2018-11-10 14:13:57'),(41,10021,16,10936,'2018-11-09 18:50:30'),(42,10006,16,10935,'2018-11-09 21:24:03'),(43,10026,11,7952,'2018-11-09 22:32:03'),(44,10007,16,10936,'2018-11-13 12:16:36'),(45,10007,5,140,'2018-11-10 08:17:25'),(46,10001,8,17742,'2018-11-12 14:37:53'),(47,10033,16,10935,'2018-12-14 23:00:02'),(49,10033,11,7952,'2018-12-14 22:21:19'),(50,10034,4,88,'2018-12-14 18:04:54'),(51,10033,7,18470,'2018-12-14 19:27:34'),(52,10028,11,7974,'2019-01-04 19:30:50'),(53,10034,11,7953,'2019-01-04 19:20:26'),(54,10033,4,88,'2018-12-14 19:27:48'),(55,10042,11,7953,'2018-12-16 03:14:24'),(56,10044,11,7952,'2018-12-16 16:31:27'),(57,10041,11,7962,'2019-01-05 12:20:39'),(58,10042,5,140,'2018-12-21 03:50:26'),(59,10042,16,10935,'2018-12-18 17:44:58'),(60,10030,25,19646,'2018-12-18 17:45:25'),(61,10030,23,18494,'2018-12-18 17:45:41'),(62,10030,38,37023,'2018-12-18 17:50:41'),(63,10041,37,32332,'2019-01-04 20:07:38'),(64,10030,9,4961,'2018-12-19 16:21:04'),(65,10041,38,37024,'2018-12-24 09:54:00'),(68,10028,37,32333,'2019-01-04 19:30:12'),(69,10029,38,37022,'2018-12-25 16:11:05'),(70,10032,16,10935,'2018-12-25 16:14:56'),(71,10029,11,7952,'2018-12-25 16:18:43'),(72,10029,37,32332,'2018-12-25 16:20:38'),(73,10036,11,7998,'2019-01-04 19:28:06'),(74,10036,41,40359,'2019-01-04 09:10:52'),(75,10034,39,39799,'2019-01-04 19:55:57'),(76,10036,38,37022,'2019-01-07 09:54:12'),(77,10036,30,24931,'2019-01-07 09:54:42');

/*Table structure for table `user_recharge_record` */

DROP TABLE IF EXISTS `user_recharge_record`;

CREATE TABLE `user_recharge_record` (
  `rr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员充值签到记录',
  `user_id` int(11) NOT NULL COMMENT '会员id',
  `number` int(11) NOT NULL DEFAULT '0' COMMENT '得到钻石数量',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型，0无效1充值2签到',
  `add_time` datetime NOT NULL COMMENT '记录时间',
  PRIMARY KEY (`rr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COMMENT='充值签到记录';

/*Data for the table `user_recharge_record` */

insert  into `user_recharge_record`(`rr_id`,`user_id`,`number`,`type`,`add_time`) values (4,10000,30,2,'2018-10-28 14:34:40'),(11,10000,40,2,'2018-10-30 15:01:41'),(12,10000,3000,1,'2018-10-23 11:02:59'),(13,10000,30,2,'2018-11-01 11:54:56'),(14,10000,30,2,'2018-11-03 16:30:12'),(17,10000,40,2,'2018-11-04 09:39:25'),(18,10000,50,2,'2018-10-31 09:39:46'),(19,10000,50,2,'2018-11-02 09:40:05'),(20,10000,30,2,'2018-11-06 09:40:31'),(21,10000,30,2,'2018-11-06 17:57:36'),(22,10000,30,2,'2018-11-06 18:24:33'),(23,10000,30,2,'2018-11-06 20:39:26'),(24,10004,30,2,'2018-11-07 09:44:45'),(25,10005,30,2,'2018-11-07 09:49:06'),(26,10009,30,2,'2018-11-07 11:32:07'),(27,10005,40,2,'2018-11-08 10:38:43'),(28,10005,40,2,'2018-11-08 16:53:01'),(29,10002,30,2,'2018-11-08 16:55:43'),(30,10002,30,2,'2018-11-08 16:55:50'),(31,10002,30,2,'2018-11-08 16:55:58'),(32,10010,30,2,'2018-11-08 16:56:15'),(33,10002,30,2,'2018-11-08 16:56:23'),(34,10002,30,2,'2018-11-08 16:56:32'),(35,10010,30,2,'2018-11-08 16:56:33'),(36,10010,30,2,'2018-11-08 16:56:40'),(37,10001,30,2,'2018-11-08 16:56:41'),(38,10002,30,2,'2018-11-08 16:56:41'),(39,10001,30,2,'2018-11-08 16:56:52'),(40,10001,30,2,'2018-11-08 16:59:18'),(41,10001,30,2,'2018-11-08 16:59:33'),(42,10001,30,2,'2018-11-08 16:59:40'),(43,10007,30,2,'2018-11-08 17:04:59'),(44,10018,30,2,'2018-11-08 17:09:29'),(45,10002,40,2,'2018-11-09 09:01:01'),(46,10001,8000,1,'2018-11-09 10:09:11'),(47,10001,40,2,'2018-11-09 11:45:51'),(48,10005,50,2,'2018-11-09 15:44:18'),(49,10001,3000,1,'2018-11-13 14:50:15'),(50,10028,3000,1,'2018-12-14 16:29:21'),(51,10034,30,2,'2018-12-14 17:57:58'),(52,10036,30,2,'2018-12-14 17:59:16'),(53,10028,30,2,'2018-12-14 18:06:42'),(54,10041,30,2,'2018-12-14 18:27:03'),(55,10042,30,2,'2018-12-16 03:16:03'),(56,10044,30,2,'2018-12-16 16:33:31'),(57,10036,30,2,'2018-12-18 09:20:19'),(58,10041,30,2,'2018-12-18 15:30:30'),(59,10041,30,2,'2018-12-24 09:46:33'),(60,10036,30,2,'2018-12-25 09:12:51'),(61,10036,30,2,'2019-01-03 09:01:22'),(62,10036,40,2,'2019-01-04 19:24:46'),(63,10053,30,2,'2019-01-05 12:15:34'),(64,10053,30,2,'2019-01-07 09:50:37');

/*Table structure for table `user_record_log` */

DROP TABLE IF EXISTS `user_record_log`;

CREATE TABLE `user_record_log` (
  `record_log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消费记录',
  `user_id` int(11) DEFAULT NULL COMMENT '会员id',
  `novel_id` int(11) DEFAULT NULL COMMENT '小说id',
  `chapter_id` int(11) DEFAULT NULL COMMENT '章节id',
  `spend` int(11) NOT NULL DEFAULT '0' COMMENT '花费钻石',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`record_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='消费记录';

/*Data for the table `user_record_log` */

insert  into `user_record_log`(`record_log_id`,`user_id`,`novel_id`,`chapter_id`,`spend`,`add_time`) values (2,10000,5,162,30,'2018-11-06 08:59:43'),(3,10000,5,163,30,'2018-11-06 09:00:00'),(4,10000,5,164,30,'2018-11-06 09:00:09'),(5,10000,9,4999,20,'2018-11-06 11:56:16'),(6,10000,9,6511,20,'2018-11-06 14:46:31'),(7,10000,9,4993,20,'2018-11-06 14:48:55'),(8,10000,5,230,30,'2018-11-06 17:53:02'),(9,10000,5,191,30,'2018-11-06 17:54:02'),(10,10000,5,192,30,'2018-11-06 17:58:17'),(11,10000,9,4971,20,'2018-11-06 18:26:04'),(12,10001,5,154,30,'2018-11-07 09:55:59'),(13,10005,9,6511,20,'2018-11-07 10:30:32'),(14,10001,5,155,30,'2018-11-09 14:35:11'),(15,10001,5,156,30,'2018-11-09 14:35:23'),(16,10001,5,2646,30,'2018-11-09 14:36:46'),(17,10005,11,7954,10,'2018-11-09 15:45:43'),(18,10036,11,7998,10,'2018-12-24 15:17:21'),(19,10036,11,8257,10,'2018-12-24 15:17:52'),(20,10036,11,8195,10,'2018-12-24 15:21:47'),(21,10036,11,8047,10,'2018-12-24 15:23:15'),(22,10036,11,8146,10,'2018-12-24 15:26:26'),(23,10036,11,8048,10,'2018-12-24 15:26:38'),(24,10036,11,8197,10,'2018-12-24 15:26:53'),(25,10028,11,8047,10,'2018-12-24 18:38:17'),(26,10028,11,7974,10,'2019-01-04 19:30:50'),(27,10041,11,7962,10,'2019-01-05 12:20:39');

/*Table structure for table `user_reward` */

DROP TABLE IF EXISTS `user_reward`;

CREATE TABLE `user_reward` (
  `user_reward_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '打赏记录',
  `user_id` int(11) DEFAULT NULL COMMENT '会员id',
  `novel_id` int(11) DEFAULT NULL COMMENT '小说id',
  `reward_id` int(11) DEFAULT NULL COMMENT '打赏礼物id',
  `reward_time` datetime DEFAULT NULL COMMENT '打赏时间',
  PRIMARY KEY (`user_reward_id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;

/*Data for the table `user_reward` */

insert  into `user_reward`(`user_reward_id`,`user_id`,`novel_id`,`reward_id`,`reward_time`) values (82,10030,9,2,'2018-12-19 16:20:59'),(83,10034,11,1,'2018-12-24 17:38:35');

/*Table structure for table `user_sex` */

DROP TABLE IF EXISTS `user_sex`;

CREATE TABLE `user_sex` (
  `user_id` int(11) NOT NULL COMMENT '会员id',
  `sex` int(11) NOT NULL DEFAULT '0' COMMENT '会员性别0男1女',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_sex` */

insert  into `user_sex`(`user_id`,`sex`) values (10000,0),(10001,1),(10002,0),(10003,1),(10004,1),(10005,1),(10006,0),(10007,0),(10008,1),(10009,1),(10010,0),(10011,1),(10012,1),(10013,1),(10014,1),(10015,0),(10016,1),(10017,1),(10018,1),(10019,0),(10020,1),(10021,1),(10022,1),(10023,0),(10024,1),(10025,1),(10026,1),(10027,1),(10028,1),(10029,1),(10030,1),(10031,1),(10032,1),(10033,1),(10034,1),(10035,1),(10036,1),(10037,1),(10038,1),(10039,1),(10040,1),(10041,1),(10042,0),(10043,1),(10044,1),(10045,1),(10046,1),(10047,1),(10048,1),(10049,1),(10050,1),(10051,1),(10053,1);

/*Table structure for table `user_share` */

DROP TABLE IF EXISTS `user_share`;

CREATE TABLE `user_share` (
  `user_share_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `share_time` datetime NOT NULL,
  PRIMARY KEY (`user_share_id`)
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=utf8;

/*Data for the table `user_share` */

insert  into `user_share`(`user_share_id`,`user_id`,`share_time`) values (1,10001,'2018-11-07 17:26:59'),(2,10001,'2018-11-07 17:28:16'),(3,10001,'2018-11-07 17:29:34'),(4,10001,'2018-11-07 17:29:53'),(5,10001,'2018-11-07 17:48:46'),(6,10001,'2018-11-07 17:48:57'),(7,10001,'2018-11-08 10:06:15'),(8,10001,'2018-11-08 10:12:57'),(9,10001,'2018-11-08 10:17:32'),(10,10001,'2018-11-08 10:21:22'),(11,10001,'2018-11-08 10:24:30'),(12,10001,'2018-11-08 10:25:01'),(13,10001,'2018-11-08 10:26:14'),(14,10010,'2018-11-08 16:52:35'),(15,10001,'2018-11-09 14:32:08'),(16,10005,'2018-11-09 15:45:29'),(17,10005,'2018-11-09 15:45:49'),(18,10007,'2018-11-09 18:48:15'),(19,10007,'2018-11-09 19:11:23'),(20,10023,'2018-11-09 20:03:41'),(21,10007,'2018-11-10 08:16:07'),(22,10007,'2018-11-10 08:18:07'),(23,10007,'2018-11-10 08:18:26'),(24,10007,'2018-11-10 08:19:38'),(25,10001,'2018-11-12 09:27:48'),(26,10001,'2018-11-12 09:37:55'),(27,10001,'2018-11-12 09:42:26'),(28,10001,'2018-12-14 15:44:14'),(29,10028,'2018-12-14 16:36:51'),(30,10041,'2018-12-24 09:49:09'),(31,10041,'2018-12-24 09:50:46'),(32,10041,'2018-12-24 09:51:47'),(33,10041,'2018-12-24 09:54:13'),(34,10036,'2018-12-24 09:58:46'),(35,10036,'2018-12-24 10:08:59'),(36,10036,'2018-12-24 10:19:15'),(37,10028,'2018-12-24 10:23:13'),(38,10028,'2018-12-24 10:35:55'),(39,10047,'2018-12-24 10:36:44'),(40,10036,'2018-12-24 15:56:37'),(41,10036,'2018-12-24 15:56:52'),(42,10036,'2018-12-24 15:57:00'),(43,10036,'2018-12-24 15:57:13'),(44,10036,'2018-12-24 16:08:29'),(45,10036,'2018-12-24 18:06:21'),(46,10036,'2018-12-24 18:06:28'),(47,10028,'2018-12-25 09:03:36'),(48,10028,'2018-12-25 09:25:57'),(49,10028,'2018-12-25 09:25:57'),(50,10028,'2018-12-25 09:26:08'),(51,10028,'2018-12-25 09:26:08'),(52,10028,'2018-12-25 09:27:56'),(53,10028,'2018-12-25 09:27:56'),(54,10050,'2018-12-25 09:29:52'),(55,10050,'2018-12-25 09:29:52'),(56,10050,'2018-12-25 09:30:57'),(57,10050,'2018-12-25 09:30:57'),(58,10050,'2018-12-25 09:31:17'),(59,10050,'2018-12-25 09:31:19'),(60,10050,'2018-12-25 09:31:33'),(61,10050,'2018-12-25 09:31:33'),(62,10028,'2018-12-25 09:31:37'),(63,10028,'2018-12-25 09:31:43'),(64,10050,'2018-12-25 09:31:49'),(65,10050,'2018-12-25 09:31:49'),(66,10036,'2018-12-25 09:34:22'),(67,10036,'2018-12-25 09:34:23'),(68,10036,'2018-12-25 09:34:28'),(69,10036,'2018-12-25 09:34:28'),(70,10036,'2018-12-25 09:34:41'),(71,10036,'2018-12-25 09:34:42'),(72,10036,'2018-12-25 09:46:23'),(73,10036,'2018-12-25 09:46:25'),(74,10036,'2018-12-25 09:46:40'),(75,10036,'2018-12-25 09:46:40'),(76,10036,'2018-12-25 09:46:47'),(77,10036,'2018-12-25 09:46:47'),(78,10028,'2018-12-25 09:48:13'),(79,10028,'2018-12-25 09:48:13'),(80,10028,'2018-12-25 09:48:13'),(81,10028,'2018-12-25 09:48:14'),(82,10028,'2018-12-25 09:48:23'),(83,10028,'2018-12-25 09:48:24'),(84,10050,'2018-12-25 09:48:53'),(85,10050,'2018-12-25 09:48:53'),(86,10028,'2018-12-25 09:48:56'),(87,10028,'2018-12-25 09:48:56'),(88,10050,'2018-12-25 09:49:02'),(89,10050,'2018-12-25 09:49:02'),(90,10028,'2018-12-25 10:07:50'),(91,10028,'2018-12-25 10:07:59'),(92,10036,'2018-12-25 10:23:01'),(93,10036,'2018-12-25 10:24:35'),(94,10036,'2018-12-25 10:25:01'),(95,10036,'2018-12-25 15:21:26'),(96,10029,'2018-12-25 16:12:50'),(97,10036,'2018-12-25 16:13:58'),(98,10028,'2018-12-25 16:16:39'),(99,10036,'2018-12-25 16:16:39'),(100,10028,'2018-12-25 16:17:44'),(101,10036,'2018-12-25 16:18:06'),(102,10036,'2018-12-25 16:18:10'),(103,10028,'2018-12-25 16:18:11'),(104,10036,'2018-12-25 16:18:15'),(105,10028,'2018-12-25 16:18:18'),(106,10028,'2018-12-25 16:18:25'),(107,10028,'2018-12-25 16:18:59'),(108,10036,'2018-12-25 16:19:15'),(109,10036,'2018-12-25 16:19:36'),(110,10036,'2018-12-25 16:20:01'),(111,10029,'2018-12-25 16:21:13'),(112,10028,'2018-12-25 16:22:42'),(113,10028,'2018-12-25 16:22:50'),(114,10028,'2018-12-25 16:22:56'),(115,10036,'2018-12-25 16:23:10'),(116,10036,'2018-12-25 16:24:04'),(117,10036,'2018-12-25 16:26:10'),(118,10029,'2018-12-25 16:30:21'),(119,10036,'2018-12-25 16:31:21'),(120,10036,'2018-12-25 16:32:16'),(121,10036,'2018-12-25 16:32:22'),(122,10045,'2018-12-25 16:37:46'),(123,10028,'2018-12-25 18:08:27'),(124,10028,'2018-12-25 18:37:50'),(125,10028,'2018-12-25 18:37:57'),(126,10028,'2018-12-25 18:40:56'),(127,10028,'2018-12-25 18:41:03'),(128,10028,'2018-12-25 18:43:02'),(129,10028,'2018-12-25 18:43:08'),(130,10028,'2018-12-26 08:59:03'),(131,10036,'2018-12-26 09:35:26'),(132,10036,'2018-12-27 18:06:45'),(133,10028,'2019-01-04 19:19:41'),(134,10036,'2019-01-04 19:28:06');

/*Table structure for table `vip` */

DROP TABLE IF EXISTS `vip`;

CREATE TABLE `vip` (
  `vip_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'vip',
  `user_id` int(11) DEFAULT NULL COMMENT '会员id',
  `vip_time` datetime DEFAULT NULL COMMENT '成为vip的时间',
  `end_time` datetime NOT NULL,
  `is_over_due` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1未过期0已过期',
  PRIMARY KEY (`vip_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `vip` */

insert  into `vip`(`vip_id`,`user_id`,`vip_time`,`end_time`,`is_over_due`) values (15,10036,'2018-12-26 09:32:40','2019-12-26 09:32:40',1),(16,10028,'2018-12-26 09:33:34','2018-12-26 09:33:34',0),(17,10028,'2018-12-26 14:49:06','2018-12-26 14:55:06',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
