-- 服务器mysql版本为5.7.32 数据库charset utf8 collate utf8_bin
DROP DATABASE IF EXISTS breastfeed;
CREATE DATABASE `breastfeed` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
use breastfeed;

-- MySQL dump 10.13  Distrib 8.0.14, for Win64 (x86_64)
--
-- Host: localhost    Database: breastfeed
-- ------------------------------------------------------
-- Server version	8.0.14

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `administrator` (
  `administrator_id` int(11) NOT NULL AUTO_INCREMENT,
  `administrator_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `administrator_password` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `administrator_right` int(11) NOT NULL,
  `administrator_token` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`administrator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_bin,
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (1,'反向按压法 ','！','反向按压法能够使乳头周围的乳晕变软，方便手挤奶或者宝宝吸吮，一般用于生理性涨奶或 乳晕肿胀明显时。 图 1 单手持花法：指甲剪短，指尖弯曲，五个指头指尖聚拢，朝胸壁方向按压，慢慢地数到 50。如果肿胀得厉害，那么就数得更慢些。 图 2 双手一步法：指甲剪短，指尖弯曲，放在乳头旁边。朝胸壁方向按压，慢慢地数到 50。 如果肿胀得厉害，那么就数得更慢些。 ',NULL,NULL),(2,'如何手挤奶（简单版） ','！','一、挤奶前放松自己：准备好挤奶所需的物品，放自己喜欢的音乐，聊天，',NULL,NULL),(3,'如何手挤奶（长版） ','！','手挤奶，是每个哺乳期妈妈必备的技能，能够缓解生理性乳胀、乳',NULL,NULL);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audio`
--

DROP TABLE IF EXISTS `audio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `audio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `audioURL` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `cover_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1236822 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audio`
--

LOCK TABLES `audio` WRITE;
/*!40000 ALTER TABLE `audio` DISABLE KEYS */;
INSERT INTO `audio` VALUES (1,'张碧晨&杨宗纬+-+凉凉','http://llllllllr.top/%E5%BC%A0%E7%A2%A7%E6%99%A8%26%E6%9D%A8%E5%AE%97%E7%BA%AC%2B-%2B%E5%87%89%E5%87%89.mp32241','','http://llllllllr.top/cover4.jpg2771'),(2,'张碧晨&杨宗纬+-+凉凉','http://llllllllr.top/%E5%BC%A0%E7%A2%A7%E6%99%A8%26%E6%9D%A8%E5%AE%97%E7%BA%AC%2B-%2B%E5%87%89%E5%87%89.mp32548','','http://llllllllr.top/cover4.jpg2771'),(3,'张碧晨&杨宗纬+-+凉凉','http://llllllllr.top/%E5%BC%A0%E7%A2%A7%E6%99%A8%26%E6%9D%A8%E5%AE%97%E7%BA%AC%2B-%2B%E5%87%89%E5%87%89.mp32553','','http://llllllllr.top/he.jpg'),(4,'张碧晨&杨宗纬+-+凉凉','http://llllllllr.top/%E5%BC%A0%E7%A2%A7%E6%99%A8%26%E6%9D%A8%E5%AE%97%E7%BA%AC%2B-%2B%E5%87%89%E5%87%89.mp32952','','http://llllllllr.top/kn.jpg');
/*!40000 ALTER TABLE `audio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auto_answer_template`
--

DROP TABLE IF EXISTS `auto_answer_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `auto_answer_template` (
  `consult_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_key` varchar(25) NOT NULL DEFAULT '问题',
  `answer_template` varchar(256) NOT NULL DEFAULT '答案',
  PRIMARY KEY (`consult_id`),
  UNIQUE KEY `question_key_UNIQUE` (`question_key`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='用户提问小程序客服答案模板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto_answer_template`
--

LOCK TABLES `auto_answer_template` WRITE;
/*!40000 ALTER TABLE `auto_answer_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_answer_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collection`
--

DROP TABLE IF EXISTS `collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `coll_type` int(11) NOT NULL COMMENT '收藏的类型 1-文章 2-音频 3-视频',
  `coll_id` int(11) NOT NULL COMMENT '收藏id',
  PRIMARY KEY (`id`),
  CONSTRAINT `id` FOREIGN KEY (`id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collection`
--

LOCK TABLES `collection` WRITE;
/*!40000 ALTER TABLE `collection` DISABLE KEYS */;
/*!40000 ALTER TABLE `collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consult_order`
--

DROP TABLE IF EXISTS `consult_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `consult_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) NOT NULL COMMENT '订单所属医生id',
  `user_id` int(11) NOT NULL COMMENT '订单所属用户id',
  `create_time` timestamp NOT NULL,
  `lasting_time` int(11) NOT NULL COMMENT '订单有效期（经过多久后订单完成）',
  `contact` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '联系人姓名',
  `contact_phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '联系人电话',
  `symptom_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '订单所属用户病情描述',
  `consult_cost` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `oid` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `user_open_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `doctor_open_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `img_urls` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_id_idx` (`user_id`),
  KEY `doctor_id_idx` (`doctor_id`),
  CONSTRAINT `doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`),
  CONSTRAINT `user_id_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='咨询订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consult_order`
--

LOCK TABLES `consult_order` WRITE;
/*!40000 ALTER TABLE `consult_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `consult_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `doctor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `user_password` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户密码',
  `token` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `name` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '医生真实姓名',
  `voice_cost` int(11) DEFAULT NULL,
  `license_number` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '执业证号',
  `expert_in` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `video_cost` int(11) DEFAULT NULL,
  `img_url` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `open_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `imagetext_cost` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='医生信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_content`
--

DROP TABLE IF EXISTS `search_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `search_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_content`
--

LOCK TABLES `search_content` WRITE;
/*!40000 ALTER TABLE `search_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `t_title` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `content` varchar(2048) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `age` int(11) DEFAULT NULL,
  `credit_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `pregnant_type` int(11) NOT NULL,
  `pregnant_week` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `job` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `confinement_date` date NOT NULL,
  `confinement_week` int(11) NOT NULL,
  `confinement_type` int(11) NOT NULL,
  `user_name` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_password` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `user_token` char(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户登录token',
  `open_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `credit_id_UNIQUE` (`credit_id`),
  UNIQUE KEY `user_name_UNIQUE` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vedio`
--

DROP TABLE IF EXISTS `vedio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `vedio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `vedioURL` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `cover_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vedio`
--

LOCK TABLES `vedio` WRITE;
/*!40000 ALTER TABLE `vedio` DISABLE KEYS */;
INSERT INTO `vedio` VALUES (1,'宝宝哭泣是因为饿了吗','http://llllllllr.top/%E5%AE%9D%E5%AE%9D%E5%93%AD%E6%B3%A3%E6%98%AF%E5%9B%A0%E4%B8%BA%E9%A5%BF%E4%BA%86%E5%90%97.mp42361','http://llllllllr.top/cover2.jpg2152',NULL,NULL),(2,'母乳喂养的好处','http://llllllllr.top/%E6%AF%8D%E4%B9%B3%E5%96%82%E5%85%BB%E7%9A%84%E5%A5%BD%E5%A4%84.mp42350','http://llllllllr.top/cover2.jpg2980',NULL,NULL);
/*!40000 ALTER TABLE `vedio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_message_item`
--

DROP TABLE IF EXISTS `wechat_message_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8 ;
CREATE TABLE `wechat_message_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `from_user_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '''发送方''',
  `to_user_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '''接收方''',
  `message_type` int(11) NOT NULL COMMENT '消息类型 0表示文本 1表示图片 2表示视频 3表示可选择的文本',
  `message_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '消息类型为文本 -》 文本\n图片 视频 -》 存储路径',
  `time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '消息时间',
  `oid` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='聊天信息条目';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_message_item`
--

LOCK TABLES `wechat_message_item` WRITE;
/*!40000 ALTER TABLE `wechat_message_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat_message_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-07 16:35:55
