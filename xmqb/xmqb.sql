/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50614
Source Host           : localhost:3306
Source Database       : xmqb

Target Server Type    : MYSQL
Target Server Version : 50614
File Encoding         : 65001

Date: 2016-08-14 20:41:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('11', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('13', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('14', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('16', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('17', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('19', 'Can add webuser', '7', 'add_webuser');
INSERT INTO `auth_permission` VALUES ('20', 'Can change webuser', '7', 'change_webuser');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete webuser', '7', 'delete_webuser');
INSERT INTO `auth_permission` VALUES ('22', 'Can add project', '8', 'add_project');
INSERT INTO `auth_permission` VALUES ('23', 'Can change project', '8', 'change_project');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete project', '8', 'delete_project');
INSERT INTO `auth_permission` VALUES ('25', 'Can add upload file', '9', 'add_uploadfile');
INSERT INTO `auth_permission` VALUES ('26', 'Can change upload file', '9', 'change_uploadfile');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete upload file', '9', 'delete_uploadfile');
INSERT INTO `auth_permission` VALUES ('28', 'Can add pay', '10', 'add_pay');
INSERT INTO `auth_permission` VALUES ('29', 'Can change pay', '10', 'change_pay');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete pay', '10', 'delete_pay');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('7', 'pbkdf2_sha256$24000$QJMrHGZnyGd5$JMfi1Sq06++y7V+8FXlhuF3VrwPfj1/niCLM6rMPr9A=', '2016-08-14 09:19:08', '1', '1', '', '', '213@afsafa.com', '1', '1', '2016-08-11 11:47:42');
INSERT INTO `auth_user` VALUES ('8', 'pbkdf2_sha256$24000$l31mTGBPewUt$5FFx8+erDcslF2OL+fVclrZOIcqTVDZeZwhRKhdewpQ=', '2016-08-12 00:46:50', '0', '2', '', '', '31321@dse.com', '0', '1', '2016-08-11 11:47:56');
INSERT INTO `auth_user` VALUES ('10', 'pbkdf2_sha256$24000$KzhaDLk9s0nE$zAW79PsgWIji1wmmqXWYz+ZpjL3Wf5yvBpO5VWmHGRA=', '2016-08-14 02:24:06', '0', '4', '', '', 'asfsa@fgjcg.com', '0', '1', '2016-08-11 11:48:55');
INSERT INTO `auth_user` VALUES ('11', 'pbkdf2_sha256$24000$JCkoiJMkRLEG$hd42TmhnPC9KWnaf/xOa9DPalXC1l5W9taxdneccZFc=', '2016-08-12 07:15:01', '0', '3', '', '', 'qedfewaf@sefaef.com', '0', '1', '2016-08-12 01:18:33');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('10', 'webuser', 'pay');
INSERT INTO `django_content_type` VALUES ('8', 'webuser', 'project');
INSERT INTO `django_content_type` VALUES ('9', 'webuser', 'uploadfile');
INSERT INTO `django_content_type` VALUES ('7', 'webuser', 'webuser');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2016-08-10 10:51:00');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2016-08-10 10:51:09');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2016-08-10 10:51:10');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2016-08-10 10:51:10');
INSERT INTO `django_migrations` VALUES ('5', 'contenttypes', '0002_remove_content_type_name', '2016-08-10 10:51:11');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2016-08-10 10:51:12');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2016-08-10 10:51:12');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2016-08-10 10:51:12');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2016-08-10 10:51:13');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2016-08-10 10:51:13');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2016-08-10 10:51:13');
INSERT INTO `django_migrations` VALUES ('12', 'sessions', '0001_initial', '2016-08-10 10:51:13');
INSERT INTO `django_migrations` VALUES ('13', 'webuser', '0001_initial', '2016-08-10 10:51:19');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('bvs01cnbbrg8jvv3jnpty6hvzgc7929k', 'NjE4MDk2ZjRjODkwYjIyOWUxMWNjOWEyMTU4OGMxYmIwNjQ5YTVlYTp7Il9hdXRoX3VzZXJfaGFzaCI6ImJmZGRkMGZiMjA1YmI2NWY2ZmJjYTZkMWFlZTE3OGRlMTAzMzdlMTYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI3In0=', '2016-08-28 09:19:08');
INSERT INTO `django_session` VALUES ('p74ckc8tyfku2szcrd821k11frw8yjkw', 'NmMzMTZlYzMwM2RhNzA1ZTBkNzg4OGJlYTk2NzIwMWM1YWUzMjUxYzp7Il9hdXRoX3VzZXJfaGFzaCI6ImY3YWZjNDhkYjUxZWRmODM4YjY0MzI0ZDgxZTRlODM4ZWMxNTkwNWEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=', '2016-08-25 08:07:56');

-- ----------------------------
-- Table structure for webuser_pay
-- ----------------------------
DROP TABLE IF EXISTS `webuser_pay`;
CREATE TABLE `webuser_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_pay` tinyint(1) NOT NULL,
  `price` varchar(10) DEFAULT NULL,
  `project_id` varchar(30) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  KEY `webuser_pay_e8701ad4` (`user_id`),
  CONSTRAINT `webuser_pay_project_id_5d6ee425_fk_webuser_project_Order_ID` FOREIGN KEY (`project_id`) REFERENCES `webuser_project` (`Order_ID`),
  CONSTRAINT `webuser_pay_user_id_cc71df67_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of webuser_pay
-- ----------------------------
INSERT INTO `webuser_pay` VALUES ('14', '0', '200', '820160811201258', '8');
INSERT INTO `webuser_pay` VALUES ('15', '0', '200', '1020160812090523', '10');
INSERT INTO `webuser_pay` VALUES ('16', '0', '200', '1120160812095728', '11');
INSERT INTO `webuser_pay` VALUES ('17', '0', '200', '1120160812095801', '11');
INSERT INTO `webuser_pay` VALUES ('18', '0', '200', '1020160814171718', '10');

-- ----------------------------
-- Table structure for webuser_project
-- ----------------------------
DROP TABLE IF EXISTS `webuser_project`;
CREATE TABLE `webuser_project` (
  `Order_ID` varchar(30) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `classify` varchar(10) DEFAULT NULL,
  `upload_dir` varchar(5000) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `remark` longtext,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `webuser_project_user_id_e8937b71_fk_auth_user_id` (`user_id`),
  CONSTRAINT `webuser_project_user_id_e8937b71_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of webuser_project
-- ----------------------------
INSERT INTO `webuser_project` VALUES ('1020160812090523', 'dsfasdfasf', '舌像', '\"F:\\GitHub\\xmqb\\upload\\4\\d2afe540-6028-11e6-b57d-fc4dd44c0419______django - 副本.pdf\"\"F:\\GitHub\\xmqb\\upload\\4\\d669e000-6028-11e6-98f0-fc4dd44c0419______2yam_under.stl\"', '2016-08-12 01:05:23', '0', 'gsrafweafafeqwfeqwfasef', '10');
INSERT INTO `webuser_project` VALUES ('1020160814171718', 'fsd', '肝癌', '\"F:\\GitHub\\xmqb\\upload\\4\\e3606940-61ff-11e6-b2e1-fc4dd44c0419______新建文本文档.rar\"', '2016-08-14 09:17:18', '0', 'fsd', '10');
INSERT INTO `webuser_project` VALUES ('1120160812095728', '给小卞补阳', '舌像', '\"\"\"F:\\GitHub\\xmqb\\upload\\3\\3da5edc0-6030-11e6-8efa-fc4dd44c0419______Deborah Theobald.docx\"\"F:\\GitHub\\xmqb\\upload\\3\\3db30d1e-6030-11e6-a116-fc4dd44c0419______Elisa Ferrara.doc\"\"F:\\GitHub\\xmqb\\upload\\3\\3dbd6d61-6030-11e6-a199-fc4dd44c0419______Fabio Miraglia.docx\"\"F:\\GitHub\\xmqb\\upload\\3\\3dc2eba1-6030-11e6-bea1-fc4dd44c0419______Gordon Tian.docx\"\"F:\\GitHub\\xmqb\\upload\\3\\3dca178f-6030-11e6-ac08-fc4dd44c0419______Güney Gürsel 题目有修改.doc\"\"F:\\GitHub\\xmqb\\upload\\3\\3dcf209e-6030-11e6-9da4-fc4dd44c0419______James P. Keller.doc\"', '2016-08-12 01:57:28', '0', 'asvdasvdszvdfzdv', '11');
INSERT INTO `webuser_project` VALUES ('1120160812095801', '给小卞补肾', '舌像', '\"F:\\GitHub\\xmqb\\upload\\3\\311ade80-6030-11e6-baf1-fc4dd44c0419______2.中华医学会第六次全国数字医学学术年会暨第一届国际数字医学与医学3D打印大会-中文论文汇编.pdf\"\"F:\\GitHub\\xmqb\\upload\\3\\31463440-6030-11e6-8670-fc4dd44c0419______NDI.pdf\"\"F:\\GitHub\\xmqb\\upload\\3\\31705180-6030-11e6-9f32-fc4dd44c0419______宝葫芦.jpg\"\"F:\\GitHub\\xmqb\\upload\\3\\3186236e-6030-11e6-985a-fc4dd44c0419______春立正达.jpg\"\"F:\\GitHub\\xmqb\\upload\\3\\31942d30-6030-11e6-93c0-fc4dd44c0419______华森.jpg\"\"F:\\GitHub\\xmqb\\upload\\3\\319e3f4f-6030-11e6-9ea9-fc4dd44c0419______凯利泰.jpg\"', '2016-08-12 01:58:01', '0', 'azvfzvdzdvzsdzsd', '11');
INSERT INTO `webuser_project` VALUES ('820160811201258', 'cdasdfcs', '肝癌', '\"\"\"F:\\GitHub\\xmqb\\upload\\2\\563dc00f-6026-11e6-a4b7-fc4dd44c0419______django - 副本.pdf\"', '2016-08-11 12:12:58', '0', 'CSAsfes', '8');

-- ----------------------------
-- Table structure for webuser_uploadfile
-- ----------------------------
DROP TABLE IF EXISTS `webuser_uploadfile`;
CREATE TABLE `webuser_uploadfile` (
  `directory` varchar(100) NOT NULL,
  `upload_time` datetime NOT NULL,
  `Order_ID_id` varchar(30) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`directory`),
  KEY `webuser_uploadf_Order_ID_id_b75c86b7_fk_webuser_project_Order_ID` (`Order_ID_id`),
  KEY `webuser_uploadfile_user_id_f63d568d_fk_auth_user_id` (`user_id`),
  CONSTRAINT `webuser_uploadfile_user_id_f63d568d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `webuser_uploadf_Order_ID_id_b75c86b7_fk_webuser_project_Order_ID` FOREIGN KEY (`Order_ID_id`) REFERENCES `webuser_project` (`Order_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of webuser_uploadfile
-- ----------------------------
INSERT INTO `webuser_uploadfile` VALUES ('1e8d440f-6030-11e6-8cca-fc4dd44c0419______2yam_under.stl', '2016-08-12 01:57:28', '1120160812095728', '11');
INSERT INTO `webuser_uploadfile` VALUES ('1e9b4dcf-6030-11e6-a17e-fc4dd44c0419______2.中华医学会第六次全国数字医学学术年会暨第一届国际数字医学与医学3D打印大会-中文论文汇编.pdf', '2016-08-12 01:57:28', '1120160812095728', '11');
INSERT INTO `webuser_uploadfile` VALUES ('311ade80-6030-11e6-baf1-fc4dd44c0419______2.中华医学会第六次全国数字医学学术年会暨第一届国际数字医学与医学3D打印大会-中文论文汇编.pdf', '2016-08-12 01:58:01', '1120160812095801', '11');
INSERT INTO `webuser_uploadfile` VALUES ('31463440-6030-11e6-8670-fc4dd44c0419______NDI.pdf', '2016-08-12 01:58:02', '1120160812095801', '11');
INSERT INTO `webuser_uploadfile` VALUES ('31705180-6030-11e6-9f32-fc4dd44c0419______宝葫芦.jpg', '2016-08-12 01:58:02', '1120160812095801', '11');
INSERT INTO `webuser_uploadfile` VALUES ('3186236e-6030-11e6-985a-fc4dd44c0419______春立正达.jpg', '2016-08-12 01:58:02', '1120160812095801', '11');
INSERT INTO `webuser_uploadfile` VALUES ('31942d30-6030-11e6-93c0-fc4dd44c0419______华森.jpg', '2016-08-12 01:58:02', '1120160812095801', '11');
INSERT INTO `webuser_uploadfile` VALUES ('319e3f4f-6030-11e6-9ea9-fc4dd44c0419______凯利泰.jpg', '2016-08-12 01:58:02', '1120160812095801', '11');
INSERT INTO `webuser_uploadfile` VALUES ('3da5edc0-6030-11e6-8efa-fc4dd44c0419______Deborah Theobald.docx', '2016-08-12 01:58:20', '1120160812095728', '11');
INSERT INTO `webuser_uploadfile` VALUES ('3db30d1e-6030-11e6-a116-fc4dd44c0419______Elisa Ferrara.doc', '2016-08-12 01:58:20', '1120160812095728', '11');
INSERT INTO `webuser_uploadfile` VALUES ('3dbd6d61-6030-11e6-a199-fc4dd44c0419______Fabio Miraglia.docx', '2016-08-12 01:58:20', '1120160812095728', '11');
INSERT INTO `webuser_uploadfile` VALUES ('3dc2eba1-6030-11e6-bea1-fc4dd44c0419______Gordon Tian.docx', '2016-08-12 01:58:20', '1120160812095728', '11');
INSERT INTO `webuser_uploadfile` VALUES ('3dca178f-6030-11e6-ac08-fc4dd44c0419______Güney Gürsel 题目有修改.doc', '2016-08-12 01:58:20', '1120160812095728', '11');
INSERT INTO `webuser_uploadfile` VALUES ('3dcf209e-6030-11e6-9da4-fc4dd44c0419______James P. Keller.doc', '2016-08-12 01:58:20', '1120160812095728', '11');
INSERT INTO `webuser_uploadfile` VALUES ('563dc00f-6026-11e6-a4b7-fc4dd44c0419______django - 副本.pdf', '2016-08-12 00:47:26', '820160811201258', '8');
INSERT INTO `webuser_uploadfile` VALUES ('d2afe540-6028-11e6-b57d-fc4dd44c0419______django - 副本.pdf', '2016-08-12 01:05:23', '1020160812090523', '10');
INSERT INTO `webuser_uploadfile` VALUES ('d669e000-6028-11e6-98f0-fc4dd44c0419______2yam_under.stl', '2016-08-12 01:05:24', '1020160812090523', '10');
INSERT INTO `webuser_uploadfile` VALUES ('e3606940-61ff-11e6-b2e1-fc4dd44c0419______新建文本文档.rar', '2016-08-14 09:17:18', '1020160814171718', '10');
INSERT INTO `webuser_uploadfile` VALUES ('f0721ec0-5fbc-11e6-bff8-fc4dd44c0419______2yam_under.stl', '2016-08-11 12:12:58', '820160811201258', '8');

-- ----------------------------
-- Table structure for webuser_webuser
-- ----------------------------
DROP TABLE IF EXISTS `webuser_webuser`;
CREATE TABLE `webuser_webuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL,
  `hospital` varchar(20) DEFAULT NULL,
  `position` varchar(10) DEFAULT NULL,
  `department` varchar(10) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `abstract` longtext,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `webuser_webuser_user_id_c05e8745_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of webuser_webuser
-- ----------------------------
INSERT INTO `webuser_webuser` VALUES ('7', '小王', 'azdvnasnvdn', '其他', '其他', '1234567890', 'zdzvdasdaz', '7');
INSERT INTO `webuser_webuser` VALUES ('8', '小卞', '常熟三院', '病人', '肾内科', '54385438', '病人严重肾虚', '8');
INSERT INTO `webuser_webuser` VALUES ('10', 'arno', 'brotherhood', '医师', '骨肿瘤科', '1234214324', 'nothing is true\r\neverything is premitted', '10');
INSERT INTO `webuser_webuser` VALUES ('11', '老卞傻逼', '1342431', '医师', '呼吸内科', '1231341421432142', 'vzdsVdEaerfawE', '11');
