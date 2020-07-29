/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.0.20 : Database - lms_2006_users
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lms_2006_users` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `lms_2006_users`;

/*Table structure for table `lms_admin_menu` */

DROP TABLE IF EXISTS `lms_admin_menu`;

CREATE TABLE `lms_admin_menu` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT '0',
  `order` int NOT NULL DEFAULT '0',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permission` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_admin_menu` */

insert  into `lms_admin_menu`(`id`,`parent_id`,`order`,`title`,`icon`,`uri`,`permission`,`created_at`,`updated_at`) values (1,0,1,'Dashboard','fa-bar-chart','/',NULL,NULL,NULL),(2,0,2,'Admin','fa-tasks','',NULL,NULL,NULL),(3,2,3,'Users','fa-users','auth/users',NULL,NULL,NULL),(4,2,4,'Roles','fa-user','auth/roles',NULL,NULL,NULL),(5,2,5,'Permission','fa-ban','auth/permissions',NULL,NULL,NULL),(6,2,6,'Menu','fa-bars','auth/menu',NULL,NULL,NULL),(7,2,7,'Operation log','fa-history','auth/logs',NULL,NULL,NULL),(8,0,0,'商品类目','fa-dedent','/categories',NULL,'2020-07-29 16:41:09','2020-07-29 16:41:09'),(9,0,0,'用户管理','fa-users','/users',NULL,'2020-07-29 16:47:06','2020-07-29 16:47:06');

/*Table structure for table `lms_admin_operation_log` */

DROP TABLE IF EXISTS `lms_admin_operation_log`;

CREATE TABLE `lms_admin_operation_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `input` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_admin_operation_log_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_admin_operation_log` */

insert  into `lms_admin_operation_log`(`id`,`user_id`,`path`,`method`,`ip`,`input`,`created_at`,`updated_at`) values (1,1,'admin/users','GET','192.168.8.1','[]','2020-07-29 16:27:59','2020-07-29 16:27:59'),(2,1,'admin/auth/menu','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:39:50','2020-07-29 16:39:50'),(3,1,'admin/auth/menu','POST','192.168.8.1','{\"parent_id\":\"0\",\"title\":\"\\u5546\\u54c1\\u7c7b\\u76ee\",\"icon\":\"fa-dedent\",\"uri\":\"\\/categories\",\"roles\":[null],\"permission\":null,\"_token\":\"w6zYnkIGzdUM5V6GDvPtrKNpm6EX3xpdoTUUFerd\"}','2020-07-29 16:41:09','2020-07-29 16:41:09'),(4,1,'admin/auth/menu','GET','192.168.8.1','[]','2020-07-29 16:41:09','2020-07-29 16:41:09'),(5,1,'admin/categories','GET','192.168.8.1','[]','2020-07-29 16:44:08','2020-07-29 16:44:08'),(6,1,'admin/categories','GET','192.168.8.1','[]','2020-07-29 16:45:22','2020-07-29 16:45:22'),(7,1,'admin/categories','GET','192.168.8.1','{\"page\":\"2\",\"_pjax\":\"#pjax-container\"}','2020-07-29 16:45:27','2020-07-29 16:45:27'),(8,1,'admin/categories/create','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:45:44','2020-07-29 16:45:44'),(9,1,'admin/categories','GET','192.168.8.1','{\"page\":\"2\",\"_pjax\":\"#pjax-container\"}','2020-07-29 16:45:59','2020-07-29 16:45:59'),(10,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:46:18','2020-07-29 16:46:18'),(11,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:46:30','2020-07-29 16:46:30'),(12,1,'admin','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:46:32','2020-07-29 16:46:32'),(13,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:46:33','2020-07-29 16:46:33'),(14,1,'admin/auth/users','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:46:37','2020-07-29 16:46:37'),(15,1,'admin/auth/menu','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:46:40','2020-07-29 16:46:40'),(16,1,'admin/auth/menu','POST','192.168.8.1','{\"parent_id\":\"0\",\"title\":\"\\u7528\\u6237\\u7ba1\\u7406\",\"icon\":\"fa-users\",\"uri\":\"\\/users\",\"roles\":[null],\"permission\":null,\"_token\":\"w6zYnkIGzdUM5V6GDvPtrKNpm6EX3xpdoTUUFerd\"}','2020-07-29 16:47:06','2020-07-29 16:47:06'),(17,1,'admin/auth/menu','GET','192.168.8.1','[]','2020-07-29 16:47:06','2020-07-29 16:47:06'),(18,1,'admin/auth/menu','GET','192.168.8.1','[]','2020-07-29 16:47:12','2020-07-29 16:47:12'),(19,1,'admin/users','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:47:15','2020-07-29 16:47:15'),(20,1,'admin','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:47:32','2020-07-29 16:47:32'),(21,1,'admin','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:47:37','2020-07-29 16:47:37'),(22,1,'admin','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:47:42','2020-07-29 16:47:42'),(23,1,'admin','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:47:44','2020-07-29 16:47:44'),(24,1,'admin','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:47:47','2020-07-29 16:47:47'),(25,1,'admin','GET','192.168.8.1','[]','2020-07-29 16:47:51','2020-07-29 16:47:51'),(26,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:47:56','2020-07-29 16:47:56'),(27,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:47:57','2020-07-29 16:47:57'),(28,1,'admin/users','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:48:00','2020-07-29 16:48:00'),(29,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:48:04','2020-07-29 16:48:04'),(30,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:48:19','2020-07-29 16:48:19'),(31,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:48:28','2020-07-29 16:48:28'),(32,1,'admin/users','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:48:29','2020-07-29 16:48:29'),(33,1,'admin/users','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:48:36','2020-07-29 16:48:36'),(34,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:48:37','2020-07-29 16:48:37'),(35,1,'admin/categories/create','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:48:40','2020-07-29 16:48:40'),(36,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:48:42','2020-07-29 16:48:42'),(37,1,'admin/categories/1/edit','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 16:48:44','2020-07-29 16:48:44'),(38,1,'admin','GET','192.168.8.1','[]','2020-07-29 17:27:58','2020-07-29 17:27:58'),(39,1,'admin/auth/logout','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 17:28:26','2020-07-29 17:28:26'),(40,1,'admin','GET','192.168.8.1','[]','2020-07-29 17:29:29','2020-07-29 17:29:29'),(41,1,'admin/categories','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 17:42:09','2020-07-29 17:42:09'),(42,1,'admin/auth/menu','GET','192.168.8.1','{\"_pjax\":\"#pjax-container\"}','2020-07-29 17:42:14','2020-07-29 17:42:14');

/*Table structure for table `lms_admin_permissions` */

DROP TABLE IF EXISTS `lms_admin_permissions`;

CREATE TABLE `lms_admin_permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `http_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `http_path` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lms_admin_permissions_name_unique` (`name`),
  UNIQUE KEY `lms_admin_permissions_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_admin_permissions` */

insert  into `lms_admin_permissions`(`id`,`name`,`slug`,`http_method`,`http_path`,`created_at`,`updated_at`) values (1,'All permission','*','','*',NULL,NULL),(2,'Dashboard','dashboard','GET','/',NULL,NULL),(3,'Login','auth.login','','/auth/login\r\n/auth/logout',NULL,NULL),(4,'User setting','auth.setting','GET,PUT','/auth/setting',NULL,NULL),(5,'Auth management','auth.management','','/auth/roles\r\n/auth/permissions\r\n/auth/menu\r\n/auth/logs',NULL,NULL);

/*Table structure for table `lms_admin_role_menu` */

DROP TABLE IF EXISTS `lms_admin_role_menu`;

CREATE TABLE `lms_admin_role_menu` (
  `role_id` int NOT NULL,
  `menu_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `lms_admin_role_menu_role_id_menu_id_index` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_admin_role_menu` */

insert  into `lms_admin_role_menu`(`role_id`,`menu_id`,`created_at`,`updated_at`) values (1,2,NULL,NULL);

/*Table structure for table `lms_admin_role_permissions` */

DROP TABLE IF EXISTS `lms_admin_role_permissions`;

CREATE TABLE `lms_admin_role_permissions` (
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `lms_admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_admin_role_permissions` */

insert  into `lms_admin_role_permissions`(`role_id`,`permission_id`,`created_at`,`updated_at`) values (1,1,NULL,NULL);

/*Table structure for table `lms_admin_role_users` */

DROP TABLE IF EXISTS `lms_admin_role_users`;

CREATE TABLE `lms_admin_role_users` (
  `role_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `lms_admin_role_users_role_id_user_id_index` (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_admin_role_users` */

insert  into `lms_admin_role_users`(`role_id`,`user_id`,`created_at`,`updated_at`) values (1,1,NULL,NULL);

/*Table structure for table `lms_admin_roles` */

DROP TABLE IF EXISTS `lms_admin_roles`;

CREATE TABLE `lms_admin_roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lms_admin_roles_name_unique` (`name`),
  UNIQUE KEY `lms_admin_roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_admin_roles` */

insert  into `lms_admin_roles`(`id`,`name`,`slug`,`created_at`,`updated_at`) values (1,'Administrator','administrator','2020-07-29 16:27:46','2020-07-29 16:27:46');

/*Table structure for table `lms_admin_user_permissions` */

DROP TABLE IF EXISTS `lms_admin_user_permissions`;

CREATE TABLE `lms_admin_user_permissions` (
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `lms_admin_user_permissions_user_id_permission_id_index` (`user_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_admin_user_permissions` */

/*Table structure for table `lms_admin_users` */

DROP TABLE IF EXISTS `lms_admin_users`;

CREATE TABLE `lms_admin_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lms_admin_users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_admin_users` */

insert  into `lms_admin_users`(`id`,`username`,`password`,`name`,`avatar`,`remember_token`,`created_at`,`updated_at`) values (1,'admin','$2y$10$F16ezssfZZvW0JGlIWFdbusZwqXaPPXL46s4yvgbhJTVwNY//QqPi','Administrator',NULL,'4EEMXPVDYoucAyhn6Bz96XJ6CPUVJ1CTU1EnxNSjTcgGYfwA2BF7qe2DGwJH','2020-07-29 16:27:46','2020-07-29 16:27:46');

/*Table structure for table `lms_failed_jobs` */

DROP TABLE IF EXISTS `lms_failed_jobs`;

CREATE TABLE `lms_failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_failed_jobs` */

/*Table structure for table `lms_migrations` */

DROP TABLE IF EXISTS `lms_migrations`;

CREATE TABLE `lms_migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_migrations` */

insert  into `lms_migrations`(`id`,`migration`,`batch`) values (1,'2014_10_12_100000_create_password_resets_table',1),(2,'2016_01_04_173148_create_admin_tables',1),(3,'2019_08_19_000000_create_failed_jobs_table',1);

/*Table structure for table `lms_password_resets` */

DROP TABLE IF EXISTS `lms_password_resets`;

CREATE TABLE `lms_password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `lms_password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `lms_password_resets` */

/*Table structure for table `lms_user_info` */

DROP TABLE IF EXISTS `lms_user_info`;

CREATE TABLE `lms_user_info` (
  `id` int NOT NULL,
  `user_id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `age` int DEFAULT NULL,
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  `identity_type` tinyint(1) DEFAULT NULL,
  `identity_no` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `user_description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `level_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `lms_user_info` */

/*Table structure for table `lms_users` */

DROP TABLE IF EXISTS `lms_users`;

CREATE TABLE `lms_users` (
  `id` char(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `Openid` char(28) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'openid',
  `username` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户名称',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `role_id` int DEFAULT NULL COMMENT '用户角色id',
  `vender_type` tinyint(1) DEFAULT NULL COMMENT '第三方类型:1.QQ,2:微信',
  `status` tinyint(1) DEFAULT NULL COMMENT '用户状态：1. 黑名单',
  `mobile` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '手机号码',
  `login_ip` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '登录ip',
  `remember_token` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'token验证',
  `created_at` datetime DEFAULT NULL COMMENT '注册时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后一次修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `lms_users` */

insert  into `lms_users`(`id`,`Openid`,`username`,`password`,`role_id`,`vender_type`,`status`,`mobile`,`login_ip`,`remember_token`,`created_at`,`updated_at`) values ('5b123af4-c6bc-121e-5f9c-639500771c80','o_e6i0xALAvgOelif4gDaAnGUMD0','旭日东升',NULL,1,NULL,0,NULL,'192.168.8.1','Ta8fgrUIsuJWLLr00y5wkt03LdLGt7WeqvHttCz4yZBLQGFyUdCoTLyQvi9p','2020-07-29 16:25:33','2020-07-29 16:25:33');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
