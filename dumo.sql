-- MySQL dump 10.13  Distrib 5.7.15, for Win64 (x86_64)
--
-- Host: localhost    Database: unimeds
-- ------------------------------------------------------
-- Server version	5.7.15-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_2f476e4b_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$30000$weeAPnIjJzof$/5zV8sN0QyDprXS4aNDo/ddTsEbgx+aLSlBl+fCK2Tg=','2017-11-13 13:58:01.036000',1,'admin','','','manik.goyal.cse15@iitbhu.ac.in',1,1,'2017-10-30 11:57:11.603000'),(27,'pbkdf2_sha256$30000$RHVbeMbpg2W5$tunumaWHygM9iuWNtMD6rWyOGU5ZYrwiHQcTqR1AkjA=','2017-11-13 12:26:19.357000',0,'vj132','','','vandit.jain.cse15@iitbhu.ac.in',0,1,'2017-11-02 11:38:13.495000'),(28,'pbkdf2_sha256$30000$JCUtuYKHYXBD$Y7J7JFKWoeQGVCrbgtAAYJh/JMQLMqjPuR7tuIL3dcs=','2017-11-13 12:41:15.890000',0,'HarshtM','','','harshit@gmail.com',0,1,'2017-11-13 12:29:05.382000'),(34,'pbkdf2_sha256$30000$1Wn1sorMtsDJ$yVGAWrS54Kk+K+COGfADpT9BZmPS56G1o7O3cilGtJQ=','2017-11-13 13:56:26.957000',0,'Niki','','','',0,1,'2017-11-13 13:09:15.656000'),(35,'pbkdf2_sha256$30000$Bowvz6JMRIy0$opKrIqvBGnTAIJEpZY0sP2W3YPjnsIIz7JG5u7K6Pfo=',NULL,0,'Mikey','','','',0,1,'2017-11-13 13:13:05.598000'),(36,'pbkdf2_sha256$30000$R5CUTYGyDEWd$R3uDDQkmbU8Zmwnu9S9BqAFgHdQTrsPud0bGTvhhIxk=',NULL,0,'DTrump','','','',0,1,'2017-11-13 13:27:59.098000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_details`
--

DROP TABLE IF EXISTS `batch_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_details` (
  `BatchNo` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) DEFAULT NULL,
  `Whole_price` float NOT NULL,
  `Retail_price` float NOT NULL,
  `Mfg_date` date NOT NULL,
  `Exp_date` date NOT NULL,
  `Curr_quantity` int(11) NOT NULL,
  `PRID` int(11) NOT NULL,
  PRIMARY KEY (`BatchNo`),
  KEY `PRID` (`PRID`),
  KEY `Name` (`Name`),
  CONSTRAINT `batch_details_ibfk_1` FOREIGN KEY (`PRID`) REFERENCES `purchase_record` (`PRID`),
  CONSTRAINT `batch_details_ibfk_2` FOREIGN KEY (`Name`) REFERENCES `product_details` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_details`
--

LOCK TABLES `batch_details` WRITE;
/*!40000 ALTER TABLE `batch_details` DISABLE KEYS */;
INSERT INTO `batch_details` VALUES (1,'Cinthol',50.5,55,'2017-07-05','2019-06-07',2,1),(3,'Dermicool',147,155,'2017-02-10','2021-02-10',3,2),(4,'Pampers',550,625,'2017-10-02','2022-09-03',6,3),(5,'Texifen',100,130,'2017-05-06','2019-10-05',2,3);
/*!40000 ALTER TABLE `batch_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `CustID` varchar(50) NOT NULL,
  `BatchNo` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`CustID`,`BatchNo`),
  KEY `BatchNo` (`BatchNo`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`CustID`) REFERENCES `customer` (`CustID`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`BatchNo`) REFERENCES `batch_details` (`BatchNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compartment`
--

DROP TABLE IF EXISTS `compartment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compartment` (
  `CID` int(11) NOT NULL,
  `ShelfNo` int(11) NOT NULL,
  PRIMARY KEY (`CID`,`ShelfNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compartment`
--

LOCK TABLES `compartment` WRITE;
/*!40000 ALTER TABLE `compartment` DISABLE KEYS */;
INSERT INTO `compartment` VALUES (1,1),(5,1),(7,2);
/*!40000 ALTER TABLE `compartment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `CustID` varchar(50) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Email_ID` varchar(50) DEFAULT NULL,
  `Apt_name` varchar(50) DEFAULT NULL,
  `Street_name` varchar(50) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `State` varchar(50) DEFAULT NULL,
  `Zip` int(11) DEFAULT NULL,
  `Phone` bigint(20) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`CustID`),
  KEY `userid` (`userid`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('DTrump','Donal Trump','1975-05-06','','Oval Office','White House','Washington','DC',123212,4578945136,36),('HarshtM','Harshit Mehrotra','1996-08-28','harshit@gmail.com','Room 158 Limbdi Hostel','IIT(BHU)','Varanasi','Uttar Pradesh',221005,9415975316,28),('Mikey','Michael','1990-04-15','','24','Lal Bag Colony','Ambala','Haryana',133001,154,35),('Niki','Niket Khandelwal','1997-06-05','','Room 122 DanrajGiri Hostel','IIT(BHU)','Varanasi','Uttar Pradesh',221005,9876541475,34),('vj132','Vandit Jain','1992-02-14','vandit.jain.cse15@iitbhu.ac.in','Room 125 Dhanrajgiri Hostel','IIT(BHU)','Varanasi','Uttar Pradesh',221005,9416362660,27);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(4,'auth','group'),(2,'auth','permission'),(3,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-10-28 07:16:06.479000'),(2,'auth','0001_initial','2017-10-28 07:16:18.893000'),(3,'admin','0001_initial','2017-10-28 07:16:21.697000'),(4,'admin','0002_logentry_remove_auto_add','2017-10-28 07:16:21.793000'),(5,'contenttypes','0002_remove_content_type_name','2017-10-28 07:16:23.400000'),(6,'auth','0002_alter_permission_name_max_length','2017-10-28 07:16:24.723000'),(7,'auth','0003_alter_user_email_max_length','2017-10-28 07:16:25.866000'),(8,'auth','0004_alter_user_username_opts','2017-10-28 07:16:25.956000'),(9,'auth','0005_alter_user_last_login_null','2017-10-28 07:16:26.841000'),(10,'auth','0006_require_contenttypes_0002','2017-10-28 07:16:26.874000'),(11,'auth','0007_alter_validators_add_error_messages','2017-10-28 07:16:26.972000'),(12,'auth','0008_alter_user_username_max_length','2017-10-28 07:16:27.945000'),(13,'sessions','0001_initial','2017-10-28 07:16:28.626000');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('dphqg1me0vrkqccufpa5yd6jwelj195f','YTUwN2M4YzljOTFjMzVlOWZmZjQ2MzYyM2RiZTU2MjI1ZTAxOTk5ZDp7Il9hdXRoX3VzZXJfaGFzaCI6ImRiY2U1YmI3ZTYzOTVmNDcwMDI2OWRmYTQyOWVhZDU1NjZjZTU2N2MiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2017-11-17 06:21:39.908000');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedback` (
  `FID` int(11) NOT NULL AUTO_INCREMENT,
  `CustID` varchar(50) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Subject` varchar(50) DEFAULT NULL,
  `Content` text,
  PRIMARY KEY (`FID`),
  KEY `CustID` (`CustID`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`CustID`) REFERENCES `customer` (`CustID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine_details`
--

DROP TABLE IF EXISTS `medicine_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicine_details` (
  `MedID` varchar(50) NOT NULL,
  `Salt` tinytext,
  `prescription` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`MedID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine_details`
--

LOCK TABLES `medicine_details` WRITE;
/*!40000 ALTER TABLE `medicine_details` DISABLE KEYS */;
INSERT INTO `medicine_details` VALUES ('Negative','Does not contain any salt','N'),('Terbinafine 250','Terbinafine','N');
/*!40000 ALTER TABLE `medicine_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_details`
--

DROP TABLE IF EXISTS `product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_details` (
  `Name` varchar(50) NOT NULL,
  `Category` varchar(50) DEFAULT NULL,
  `CID` int(11) DEFAULT NULL,
  `ShelfNo` int(11) DEFAULT NULL,
  `Mfg_by` varchar(50) DEFAULT NULL,
  `Description` text,
  `MedID` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Name`),
  KEY `CID` (`CID`,`ShelfNo`),
  KEY `MedID` (`MedID`),
  CONSTRAINT `product_details_ibfk_1` FOREIGN KEY (`CID`, `ShelfNo`) REFERENCES `compartment` (`CID`, `ShelfNo`),
  CONSTRAINT `product_details_ibfk_2` FOREIGN KEY (`MedID`) REFERENCES `medicine_details` (`MedID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_details`
--

LOCK TABLES `product_details` WRITE;
/*!40000 ALTER TABLE `product_details` DISABLE KEYS */;
INSERT INTO `product_details` VALUES ('Cinthol','Personal Care',1,1,'Godrej','Cinthol is more than just a personal care brand. It is a philosophy','Negative'),('Dermicool','Personal Care',1,1,'Reckitt Benckiser','Powder for treating prickly heat and itches','Negative'),('Pampers','Baby Products',7,2,'Pampers','Diapers for your Baby. Soft and super comfortable','Negative'),('Texifen','Medicine',5,1,'Ankur Drugs','Skin Allergy Medicine','Terbinafine 250');
/*!40000 ALTER TABLE `product_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_record`
--

DROP TABLE IF EXISTS `purchase_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_record` (
  `PRID` int(11) NOT NULL AUTO_INCREMENT,
  `WSID` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `TPrice` float DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`PRID`),
  KEY `WSID` (`WSID`),
  CONSTRAINT `purchase_record_ibfk_1` FOREIGN KEY (`WSID`) REFERENCES `wholeseller` (`WSID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_record`
--

LOCK TABLES `purchase_record` WRITE;
/*!40000 ALTER TABLE `purchase_record` DISABLE KEYS */;
INSERT INTO `purchase_record` VALUES (1,1,'2017-09-28',151.5,3),(2,2,'2017-11-02',441,3),(3,1,'2017-07-05',2925,8);
/*!40000 ALTER TABLE `purchase_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repl_record`
--

DROP TABLE IF EXISTS `repl_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repl_record` (
  `RRID` int(11) NOT NULL AUTO_INCREMENT,
  `BatchNo` int(11) DEFAULT NULL,
  `WSID` int(11) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Price` float DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`RRID`),
  KEY `BatchNo` (`BatchNo`),
  KEY `WSID` (`WSID`),
  CONSTRAINT `repl_record_ibfk_1` FOREIGN KEY (`BatchNo`) REFERENCES `batch_details` (`BatchNo`),
  CONSTRAINT `repl_record_ibfk_2` FOREIGN KEY (`WSID`) REFERENCES `wholeseller` (`WSID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repl_record`
--

LOCK TABLES `repl_record` WRITE;
/*!40000 ALTER TABLE `repl_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `repl_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_record`
--

DROP TABLE IF EXISTS `sale_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_record` (
  `SRID` int(11) NOT NULL AUTO_INCREMENT,
  `CustID` varchar(50) DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `Price` float DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `On_Offline` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`SRID`),
  KEY `CustID` (`CustID`),
  CONSTRAINT `sale_record_ibfk_1` FOREIGN KEY (`CustID`) REFERENCES `customer` (`CustID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_record`
--

LOCK TABLES `sale_record` WRITE;
/*!40000 ALTER TABLE `sale_record` DISABLE KEYS */;
INSERT INTO `sale_record` VALUES (2,'vj132','2017-11-13 00:00:00',110,2,'Online'),(8,'vj132','2017-11-13 01:16:44',55,1,'Online'),(11,'vj132','2017-11-13 17:53:34',680,2,'Online'),(12,'vj132','2017-11-13 17:56:43',1305,3,'Online'),(13,'HarshtM','2017-11-13 18:00:39',855,6,'Online'),(14,'HarshtM','2017-11-13 18:03:19',390,3,'Online'),(15,'Niki','2017-11-13 19:27:44',2265,6,'Online');
/*!40000 ALTER TABLE `sale_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sr_prod`
--

DROP TABLE IF EXISTS `sr_prod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sr_prod` (
  `SRID` int(11) NOT NULL,
  `BatchNo` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`SRID`,`BatchNo`),
  KEY `BatchNo` (`BatchNo`),
  CONSTRAINT `sr_prod_ibfk_1` FOREIGN KEY (`SRID`) REFERENCES `sale_record` (`SRID`),
  CONSTRAINT `sr_prod_ibfk_2` FOREIGN KEY (`BatchNo`) REFERENCES `batch_details` (`BatchNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sr_prod`
--

LOCK TABLES `sr_prod` WRITE;
/*!40000 ALTER TABLE `sr_prod` DISABLE KEYS */;
INSERT INTO `sr_prod` VALUES (2,1,2),(8,1,1),(11,1,1),(11,4,1),(12,1,1),(12,4,2),(13,3,3),(13,5,3),(14,5,3),(15,4,3),(15,5,3);
/*!40000 ALTER TABLE `sr_prod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wholeseller`
--

DROP TABLE IF EXISTS `wholeseller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wholeseller` (
  `WSID` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Address` text,
  `Email_ID` varchar(50) DEFAULT NULL,
  `Phone` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`WSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wholeseller`
--

LOCK TABLES `wholeseller` WRITE;
/*!40000 ALTER TABLE `wholeseller` DISABLE KEYS */;
INSERT INTO `wholeseller` VALUES (1,'Manik','68 A Gobind Nagar','manik@gmail',9455471336),(2,'Raj Medicose','#21 Sadar Market','Raj@gmail.com',9456123675),(3,'Shiva Medicose','#125 Timber Market, Ambala Cantt','shiva@gmail.com',9458716225);
/*!40000 ALTER TABLE `wholeseller` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-13 21:57:05
