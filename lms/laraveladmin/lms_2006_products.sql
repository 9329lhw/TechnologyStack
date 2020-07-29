/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.0.20 : Database - lms_2006_products
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lms_2006_products` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `lms_2006_products`;

/*Table structure for table `lms_categories` */

DROP TABLE IF EXISTS `lms_categories`;

CREATE TABLE `lms_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `is_directory` tinyint(1) NOT NULL,
  `level` int unsigned NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `lms_categories` */

insert  into `lms_categories`(`id`,`name`,`parent_id`,`is_directory`,`level`,`path`,`created_at`,`updated_at`) values (1,'手机配件',NULL,1,0,'-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(2,'手机壳',1,0,1,'-1-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(3,'贴膜',1,0,1,'-1-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(4,'存储卡',1,0,1,'-1-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(5,'数据线',1,0,1,'-1-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(6,'充电器',1,0,1,'-1-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(7,'耳机',1,1,1,'-1-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(8,'有线耳机',7,0,2,'-1-7-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(9,'蓝牙耳机',7,0,2,'-1-7-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(10,'电脑配件',NULL,1,0,'-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(11,'显示器',10,0,1,'-10-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(12,'显卡',10,0,1,'-10-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(13,'内存',10,0,1,'-10-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(14,'CPU',10,0,1,'-10-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(15,'主板',10,0,1,'-10-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(16,'硬盘',10,0,1,'-10-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(17,'电脑整机',NULL,1,0,'-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(18,'笔记本',17,0,1,'-17-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(19,'台式机',17,0,1,'-17-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(20,'平板电脑',17,0,1,'-17-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(21,'一体机',17,0,1,'-17-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(22,'服务器',17,0,1,'-17-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(23,'工作站',17,0,1,'-17-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(24,'手机通讯',NULL,1,0,'-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(25,'智能机',24,0,1,'-24-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(26,'老人机',24,0,1,'-24-','2020-07-29 16:28:09','2020-07-29 16:28:09'),(27,'对讲机',24,0,1,'-24-','2020-07-29 16:28:09','2020-07-29 16:28:09');

/*Table structure for table `lms_product_descriptions` */

DROP TABLE IF EXISTS `lms_product_descriptions`;

CREATE TABLE `lms_product_descriptions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `lms_product_descriptions` */

/*Table structure for table `lms_product_images` */

DROP TABLE IF EXISTS `lms_product_images`;

CREATE TABLE `lms_product_images` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `image_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `pic_desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `is_master` tinyint DEFAULT NULL,
  `pic_order` int DEFAULT NULL,
  `pic_status` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `lms_product_images` */

/*Table structure for table `lms_product_sku_descriptions` */

DROP TABLE IF EXISTS `lms_product_sku_descriptions`;

CREATE TABLE `lms_product_sku_descriptions` (
  `id` int NOT NULL,
  `product_sku_id` int DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `lms_product_sku_descriptions` */

/*Table structure for table `lms_product_skus` */

DROP TABLE IF EXISTS `lms_product_skus`;

CREATE TABLE `lms_product_skus` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `parameter` json DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `lms_product_skus` */

/*Table structure for table `lms_products` */

DROP TABLE IF EXISTS `lms_products`;

CREATE TABLE `lms_products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_core` char(16) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `bar_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `audit_status` tinyint DEFAULT NULL,
  `shop_id` int DEFAULT NULL,
  `description_id` int DEFAULT NULL,
  `rating` double(8,2) DEFAULT NULL,
  `sold_count` int DEFAULT NULL,
  `review_count` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `lms_products` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
