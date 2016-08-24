/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50713
Source Host           : localhost:3306
Source Database       : xmqb

Target Server Type    : MYSQL
Target Server Version : 50713
File Encoding         : 65001

Date: 2016-08-24 16:47:36
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
  CONSTRAINT `auth_group_permissi_permission_id_84c5c92e_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

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
INSERT INTO `auth_permission` VALUES ('25', 'Can add project', '9', 'add_project');
INSERT INTO `auth_permission` VALUES ('26', 'Can change project', '9', 'change_project');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete project', '9', 'delete_project');
INSERT INTO `auth_permission` VALUES ('28', 'Can add pay', '10', 'add_pay');
INSERT INTO `auth_permission` VALUES ('29', 'Can change pay', '10', 'change_pay');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete pay', '10', 'delete_pay');
INSERT INTO `auth_permission` VALUES ('31', 'Can add upload file', '11', 'add_uploadfile');
INSERT INTO `auth_permission` VALUES ('32', 'Can change upload file', '11', 'change_uploadfile');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete upload file', '11', 'delete_uploadfile');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES ('1', 'pbkdf2_sha256$24000$IHTAFe9tOUYQ$p7UGPYWAkpTjLtFjuYq6Bs18PBqwCeNk1regJMBgJMs=', '2016-08-24 16:07:34', '1', '1', '', '', '289643938@qq.com', '0', '1', '2016-07-31 06:59:04');
INSERT INTO `auth_user` VALUES ('3', 'pbkdf2_sha256$24000$pWpDPljwDyDp$TS3GcednarFh5klKEgPncnrn7ecygQGg7G9IhKhBfQo=', '2016-08-11 20:08:18', '0', 'y6239810y', '', '', '289643938@qq.com', '0', '1', '2016-08-01 01:02:34');
INSERT INTO `auth_user` VALUES ('4', 'pbkdf2_sha256$24000$PC19KryBeV41$utC37Pjlnp8zsyu4v2FAZSAgMtL7j0NeFEHlVp14cXU=', '2016-08-23 08:55:32', '0', '2', '', '', '289643938@qq.com', '0', '1', '2016-08-11 20:08:54');
INSERT INTO `auth_user` VALUES ('5', 'pbkdf2_sha256$24000$DV0ZFNPVFsTR$jljRX3MAeScg0Ic402cyke/k89yqm754kSwYDHYpiO8=', '2016-08-12 10:06:42', '0', '4', '', '', '4@c.cn', '0', '1', '2016-08-12 10:06:41');
INSERT INTO `auth_user` VALUES ('6', 'pbkdf2_sha256$24000$NakgC2bryFQL$Yat7f9LNmH7IQbFAy483Df3AIQ0FTBW6u5aa25QLWYk=', '2016-08-24 16:07:40', '0', '3', '', '', '2@qq.com', '0', '1', '2016-08-14 11:18:03');

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
  CONSTRAINT `auth_user_user_perm_permission_id_1fbb5f2c_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
  CONSTRAINT `django_admin__content_type_id_c4bce8eb_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

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
INSERT INTO `django_content_type` VALUES ('9', 'webuser', 'project');
INSERT INTO `django_content_type` VALUES ('11', 'webuser', 'uploadfile');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2016-07-29 08:51:36');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2016-07-29 08:51:42');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2016-07-29 08:51:43');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2016-07-29 08:51:44');
INSERT INTO `django_migrations` VALUES ('5', 'contenttypes', '0002_remove_content_type_name', '2016-07-29 08:51:45');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0002_alter_permission_name_max_length', '2016-07-29 08:51:46');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0003_alter_user_email_max_length', '2016-07-29 08:51:46');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0004_alter_user_username_opts', '2016-07-29 08:51:46');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0005_alter_user_last_login_null', '2016-07-29 08:51:47');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0006_require_contenttypes_0002', '2016-07-29 08:51:47');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0007_alter_validators_add_error_messages', '2016-07-29 08:51:47');
INSERT INTO `django_migrations` VALUES ('12', 'sessions', '0001_initial', '2016-07-29 08:51:47');
INSERT INTO `django_migrations` VALUES ('13', 'webuser', '0001_initial', '2016-07-29 08:51:48');
INSERT INTO `django_migrations` VALUES ('14', 'webuser', '0002_auto_20160731_1018', '2016-07-31 02:19:11');
INSERT INTO `django_migrations` VALUES ('15', 'webuser', '0003_webuser_register_time', '2016-07-31 02:22:09');
INSERT INTO `django_migrations` VALUES ('16', 'webuser', '0004_auto_20160731_1025', '2016-07-31 02:25:37');
INSERT INTO `django_migrations` VALUES ('17', 'webuser', '0005_auto_20160801_1107', '2016-08-01 03:08:02');
INSERT INTO `django_migrations` VALUES ('18', 'webuser', '0006_auto_20160802_0803', '2016-08-02 00:03:27');
INSERT INTO `django_migrations` VALUES ('19', 'webuser', '0007_auto_20160802_0807', '2016-08-02 00:08:01');
INSERT INTO `django_migrations` VALUES ('20', 'webuser', '0008_auto_20160802_0925', '2016-08-02 01:25:18');
INSERT INTO `django_migrations` VALUES ('21', 'webuser', '0009_auto_20160802_0954', '2016-08-02 01:54:10');
INSERT INTO `django_migrations` VALUES ('22', 'webuser', '0010_project_classify', '2016-08-02 04:44:22');
INSERT INTO `django_migrations` VALUES ('23', 'webuser', '0011_auto_20160802_1359', '2016-08-02 05:59:39');
INSERT INTO `django_migrations` VALUES ('24', 'webuser', '0002_pay_user', '2016-08-02 06:17:31');
INSERT INTO `django_migrations` VALUES ('25', 'webuser', '0003_auto_20160803_0829', '2016-08-03 00:29:35');
INSERT INTO `django_migrations` VALUES ('26', 'webuser', '0004_auto_20160803_0847', '2016-08-03 00:48:03');
INSERT INTO `django_migrations` VALUES ('27', 'webuser', '0005_auto_20160803_1119', '2016-08-03 03:19:43');
INSERT INTO `django_migrations` VALUES ('28', 'webuser', '0006_auto_20160806_1203', '2016-08-06 04:03:57');
INSERT INTO `django_migrations` VALUES ('29', 'webuser', '0007_remove_uploadfile_is_active', '2016-08-06 12:32:09');
INSERT INTO `django_migrations` VALUES ('30', 'webuser', '0002_uploadfile_upload_time', '2016-08-10 10:45:36');

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
INSERT INTO `django_session` VALUES ('2a77w5yyfm31r4rvppchngmx189cdz4v', 'MDIwYmFkZjc2ODU0YzY3YmEyN2UxZTUzYTc5NDY1OTQwNTY0YmI5ZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImE2ZTk0Y2ZkOTk2NGI1YzQ2ZjI2ZWMzZWY1MjZkNzM0OGQ4OTFhNzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-15 00:24:22');
INSERT INTO `django_session` VALUES ('7bqk5waop47lk440e8bhsd2kvace16q1', 'MDIwYmFkZjc2ODU0YzY3YmEyN2UxZTUzYTc5NDY1OTQwNTY0YmI5ZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImE2ZTk0Y2ZkOTk2NGI1YzQ2ZjI2ZWMzZWY1MjZkNzM0OGQ4OTFhNzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-17 04:30:23');
INSERT INTO `django_session` VALUES ('cnxfiy7tfy1pql87ucyd3f88szwmzwee', 'NDgwNjE4Nzg3MjhjNjBiNjUzMTc0ZTYyYmQ3NGVhMmM3ZjU5Nzg0ZTp7Il9hdXRoX3VzZXJfaGFzaCI6ImRlMTFkM2FmYjdlZjBiZGQ5Y2Y1ZGIxNDNmNmU0ZWZkNDk5OWJkMWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI2In0=', '2016-09-07 16:07:40');
INSERT INTO `django_session` VALUES ('fby35wer1cajth4a494hne41c74rm3qs', 'ZTYwYjA3YjM0MTg1YTJhODk1ZjBlZWM3OTUzMTE1NzY5OGQxMmY1Mjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc1MzU0N2IxYjQwMzJmYzhjZGNkN2M4OGVjNTdlZDUzOGYxOGRjMTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=', '2016-08-15 01:04:17');
INSERT INTO `django_session` VALUES ('flx0yjcukc73prvn227x6x7oqom0owrf', 'Mzk2Njk3MDg3MWNjYjhjYjJjMzQyNDg0YmEyMWUzNDc1NGI3ZWRmNTp7Il9hdXRoX3VzZXJfaGFzaCI6IjBlNDRhYWNlZmYxODQ0NTZkMTE3ZTFiNWI0MTY0ODQ2MjU5ZGZlYTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-25 16:09:49');
INSERT INTO `django_session` VALUES ('gi2c2g76pl0dyecf1n4owymkzv2qa9u2', 'MDIwYmFkZjc2ODU0YzY3YmEyN2UxZTUzYTc5NDY1OTQwNTY0YmI5ZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImE2ZTk0Y2ZkOTk2NGI1YzQ2ZjI2ZWMzZWY1MjZkNzM0OGQ4OTFhNzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-17 07:39:11');
INSERT INTO `django_session` VALUES ('srnkky6q8i1cemqz7w59lrk2qiryzque', 'MDIwYmFkZjc2ODU0YzY3YmEyN2UxZTUzYTc5NDY1OTQwNTY0YmI5ZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImE2ZTk0Y2ZkOTk2NGI1YzQ2ZjI2ZWMzZWY1MjZkNzM0OGQ4OTFhNzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-15 07:22:44');
INSERT INTO `django_session` VALUES ('u9n8lu8vg24nbybvabl4vifhhl58lyon', 'MDIwYmFkZjc2ODU0YzY3YmEyN2UxZTUzYTc5NDY1OTQwNTY0YmI5ZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImE2ZTk0Y2ZkOTk2NGI1YzQ2ZjI2ZWMzZWY1MjZkNzM0OGQ4OTFhNzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=', '2016-08-17 04:33:00');

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
  CONSTRAINT `webuser_pay_project_id_5d6ee425_fk` FOREIGN KEY (`project_id`) REFERENCES `webuser_project` (`Order_ID`),
  CONSTRAINT `webuser_pay_user_id_cc71df67_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of webuser_pay
-- ----------------------------
INSERT INTO `webuser_pay` VALUES ('99', '1', '13', '320160811185252', '3');
INSERT INTO `webuser_pay` VALUES ('100', '1', '200', '420160811201203', '4');
INSERT INTO `webuser_pay` VALUES ('101', '1', '200', '420160812090409', '4');
INSERT INTO `webuser_pay` VALUES ('102', '0', '200', '520160812100857', '5');
INSERT INTO `webuser_pay` VALUES ('103', '0', '200', '420160814101029', '4');
INSERT INTO `webuser_pay` VALUES ('104', '0', '200', '420160822135932', '4');
INSERT INTO `webuser_pay` VALUES ('108', '0', '200', '620160824143852', '6');
INSERT INTO `webuser_pay` VALUES ('109', '0', '200', '620160824153700', '6');

-- ----------------------------
-- Table structure for webuser_project
-- ----------------------------
DROP TABLE IF EXISTS `webuser_project`;
CREATE TABLE `webuser_project` (
  `Order_ID` varchar(30) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `upload_dir` varchar(500) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `remark` longtext,
  `user_id` int(11) NOT NULL,
  `classify` varchar(10),
  PRIMARY KEY (`Order_ID`),
  KEY `webuser_project_user_id_e8937b71_fk_auth_user_id` (`user_id`),
  CONSTRAINT `webuser_project_user_id_e8937b71_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of webuser_project
-- ----------------------------
INSERT INTO `webuser_project` VALUES ('320160811185252', 'STL文件测试', '\"D:\\work\\xmqb\\upload\\y6239810y\\be15d211-5fb1-11e6-9399-fc4dd44c02a3-shenmiao.stl\"', '2016-08-11 18:52:52', '1', 'STL文件测试STL文件测试STL文件测试STL文件测试', '3', '肝癌');
INSERT INTO `webuser_project` VALUES ('420160811201203', '1', '\"D:\\work\\xmqb\\upload\\2\\cfb2c9f0-5fbc-11e6-a108-fc4dd44c02a3-shenmiao.stl\"\"D:\\work\\xmqb\\upload\\2\\e53fc99e-6028-11e6-9911-fc4dd44c02a3-p449399746.jpg\"\"D:\\work\\xmqb\\upload\\2\\ea8a4f70-6028-11e6-a232-fc4dd44c02a3-p449399746.jpg\"\"D:\\work\\xmqb\\upload\\2\\8ce0d7cf-6029-11e6-b7bd-fc4dd44c02a3-p453719066.jpg\"\"D:\\work\\xmqb\\upload\\2\\9538015e-6029-11e6-8e52-fc4dd44c02a3-p453719066.jpg\"', '2016-08-11 20:12:03', '1', '234234', '4', '肝癌');
INSERT INTO `webuser_project` VALUES ('420160812090409', '312323', '\"D:\\work\\xmqb\\upload\\2\\aade1be1-6028-11e6-9342-fc4dd44c02a3-greek_temple-custumizer_20130907-17486-8mzq60-0.stl\"\"D:\\work\\xmqb\\upload\\2\\c3500b1e-6028-11e6-81ba-fc4dd44c02a3-greek_temple-custumizer_20130907-17486-8mzq60-0.stl\"\"D:\\work\\xmqb\\upload\\2\\c357370f-6028-11e6-bc16-fc4dd44c02a3-p443461818.stl\"', '2016-08-12 09:04:09', '1', '123134123', '4', '舌像');
INSERT INTO `webuser_project` VALUES ('420160814101029', '213123', '\"D:\\work\\xmqb\\upload\\2\\446f2dc0-61c4-11e6-b115-fc4dd44c02a3-p453719066.jpg\"', '2016-08-14 10:10:29', '1', '1231231', '4', '肝癌');
INSERT INTO `webuser_project` VALUES ('420160822135932', '231313123', '\"D:\\work\\xmqb\\upload\\2\\96b3c680-682d-11e6-a1f8-fc4dd44c02a3-medical.stl\"', '2016-08-22 13:59:32', '1', '12312312', '4', '肝癌');
INSERT INTO `webuser_project` VALUES ('520160812100857', '12312313', '\"D:\\work\\xmqb\\upload\\4\\b8e79eb0-6031-11e6-90c1-fc4dd44c02a3-p453719066.jpg\"\"D:\\work\\xmqb\\upload\\4\\b8ef66e1-6031-11e6-b98a-fc4dd44c02a3-p453719066.jpg\"\"D:\\work\\xmqb\\upload\\4\\b8f49700-6031-11e6-a7cb-fc4dd44c02a3-p453719066.jpg\"\"D:\\work\\xmqb\\upload\\4\\b8fc110f-6031-11e6-8aeb-fc4dd44c02a3-p453719066.jpg\"', '2016-08-12 10:08:57', '1', '213131123', '5', '肝癌');
INSERT INTO `webuser_project` VALUES ('620160824143852', '1', '\"D:\\work\\xmqb\\upload\\3\\6b1a2c4f-69c5-11e6-be56-fc4dd44c02a3-1.stl\"', '2016-08-24 14:38:52', '1', '1', '6', '肝癌');
INSERT INTO `webuser_project` VALUES ('620160824153700', '12313123', '\"D:\\work\\xmqb\\upload\\3\\8a99665e-69cd-11e6-a84c-fc4dd44c02a3-1.stl\"', '2016-08-24 15:37:00', '1', '124123141341asedasd', '6', '肝癌');

-- ----------------------------
-- Table structure for webuser_uploadfile
-- ----------------------------
DROP TABLE IF EXISTS `webuser_uploadfile`;
CREATE TABLE `webuser_uploadfile` (
  `directory` varchar(100) NOT NULL,
  `Order_ID_id` varchar(30) NOT NULL,
  `user_id` int(11) NOT NULL,
  `upload_time` datetime NOT NULL,
  PRIMARY KEY (`directory`),
  KEY `webuser_uploadfile_7080c049` (`Order_ID_id`),
  KEY `webuser_uploadfile_e8701ad4` (`user_id`),
  CONSTRAINT `webuser_uploadf_Order_ID_id_b75c86b7_fk_webuser_project_Order_ID` FOREIGN KEY (`Order_ID_id`) REFERENCES `webuser_project` (`Order_ID`),
  CONSTRAINT `webuser_uploadfile_user_id_f63d568d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of webuser_uploadfile
-- ----------------------------
INSERT INTO `webuser_uploadfile` VALUES ('446f2dc0-61c4-11e6-b115-fc4dd44c02a3-p453719066.jpg', '420160814101029', '4', '2016-08-14 10:10:29');
INSERT INTO `webuser_uploadfile` VALUES ('6b1a2c4f-69c5-11e6-be56-fc4dd44c02a3-1.stl', '620160824143852', '6', '2016-08-24 14:38:52');
INSERT INTO `webuser_uploadfile` VALUES ('8a99665e-69cd-11e6-a84c-fc4dd44c02a3-1.stl', '620160824153700', '6', '2016-08-24 15:37:00');
INSERT INTO `webuser_uploadfile` VALUES ('8ce0d7cf-6029-11e6-b7bd-fc4dd44c02a3-p453719066.jpg', '420160811201203', '4', '2016-08-12 09:10:42');
INSERT INTO `webuser_uploadfile` VALUES ('9538015e-6029-11e6-8e52-fc4dd44c02a3-p453719066.jpg', '420160811201203', '4', '2016-08-12 09:10:42');
INSERT INTO `webuser_uploadfile` VALUES ('96b3c680-682d-11e6-a1f8-fc4dd44c02a3-medical.stl', '420160822135932', '4', '2016-08-22 13:59:32');
INSERT INTO `webuser_uploadfile` VALUES ('aade1be1-6028-11e6-9342-fc4dd44c02a3-greek_temple-custumizer_20130907-17486-8mzq60-0.stl', '420160812090409', '4', '2016-08-12 09:04:09');
INSERT INTO `webuser_uploadfile` VALUES ('b8e79eb0-6031-11e6-90c1-fc4dd44c02a3-p453719066.jpg', '520160812100857', '5', '2016-08-12 10:08:58');
INSERT INTO `webuser_uploadfile` VALUES ('b8ef66e1-6031-11e6-b98a-fc4dd44c02a3-p453719066.jpg', '520160812100857', '5', '2016-08-12 10:08:58');
INSERT INTO `webuser_uploadfile` VALUES ('b8f49700-6031-11e6-a7cb-fc4dd44c02a3-p453719066.jpg', '520160812100857', '5', '2016-08-12 10:08:58');
INSERT INTO `webuser_uploadfile` VALUES ('b8fc110f-6031-11e6-8aeb-fc4dd44c02a3-p453719066.jpg', '520160812100857', '5', '2016-08-12 10:08:58');
INSERT INTO `webuser_uploadfile` VALUES ('be15d211-5fb1-11e6-9399-fc4dd44c02a3-shenmiao.stl', '320160811185252', '3', '2016-08-11 18:52:52');
INSERT INTO `webuser_uploadfile` VALUES ('c3500b1e-6028-11e6-81ba-fc4dd44c02a3-greek_temple-custumizer_20130907-17486-8mzq60-0.stl', '420160812090409', '4', '2016-08-12 09:04:48');
INSERT INTO `webuser_uploadfile` VALUES ('c357370f-6028-11e6-bc16-fc4dd44c02a3-p443461818.stl', '420160812090409', '4', '2016-08-12 09:04:48');
INSERT INTO `webuser_uploadfile` VALUES ('cfb2c9f0-5fbc-11e6-a108-fc4dd44c02a3-shenmiao.stl', '420160811201203', '4', '2016-08-11 20:12:03');
INSERT INTO `webuser_uploadfile` VALUES ('e53fc99e-6028-11e6-9911-fc4dd44c02a3-p449399746.jpg', '420160811201203', '4', '2016-08-12 09:05:59');
INSERT INTO `webuser_uploadfile` VALUES ('ea8a4f70-6028-11e6-a232-fc4dd44c02a3-p449399746.jpg', '420160811201203', '4', '2016-08-12 09:05:59');

-- ----------------------------
-- Table structure for webuser_webuser
-- ----------------------------
DROP TABLE IF EXISTS `webuser_webuser`;
CREATE TABLE `webuser_webuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `abstract` longtext,
  `department` varchar(10),
  `hospital` varchar(20),
  `name` varchar(10),
  `position` varchar(10),
  `telephone` varchar(20),
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `webuser_webuser_user_id_c05e8745_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of webuser_webuser
-- ----------------------------
INSERT INTO `webuser_webuser` VALUES ('1', '1', '无敌你懂吗？', '呼吸内科', '神之医院', '严凯', '医师', '18616733637');
INSERT INTO `webuser_webuser` VALUES ('3', '3', '傻逼一个', '肾内科', '傻逼医院', '卞学胜', '病人', '17750593769');
INSERT INTO `webuser_webuser` VALUES ('4', '4', '2', '肝病研究所', '傻逼医院', '王弘轩', '医师', '18616733241');
INSERT INTO `webuser_webuser` VALUES ('5', '5', '41', '内分泌科', '3421234', '313134', '医师', '1213424');
INSERT INTO `webuser_webuser` VALUES ('6', '6', null, null, null, null, null, null);
