-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: netcracker
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attributes` (
  `attr_id` int(11) NOT NULL,
  `attr_name` varchar(20) NOT NULL,
  `object_type_id` int(11) NOT NULL,
  PRIMARY KEY (`attr_id`),
  KEY `r_12` (`object_type_id`),
  CONSTRAINT `r_12` FOREIGN KEY (`object_type_id`) REFERENCES `object_types` (`object_type_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
INSERT INTO `attributes` VALUES (111,'KingA',35),(112,'BlakeA',32),(113,'WardA',33),(114,'AllenA',33),(115,'MatrinA',33),(116,'TurnerA',33),(117,'JamesA',31),(118,'SmithA',31),(119,'JonesA',32),(1110,'ClarkA',32),(1111,'ScottA',34),(1112,'AdamsA',31),(1113,'FordA',34),(1114,'MillerA',31);
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (10,'New York'),(20,'Dallas'),(30,'Chikago'),(40,'Boston');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `object_types`
--

DROP TABLE IF EXISTS `object_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `object_types` (
  `object_type_id` int(11) NOT NULL,
  `o_type` varchar(20) NOT NULL,
  PRIMARY KEY (`object_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `object_types`
--

LOCK TABLES `object_types` WRITE;
/*!40000 ALTER TABLE `object_types` DISABLE KEYS */;
INSERT INTO `object_types` VALUES (31,'CLERK'),(32,'MANAGER'),(33,'SALESMAN'),(34,'ANALYST'),(35,'PRESIDENT');
/*!40000 ALTER TABLE `object_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `objects`
--

DROP TABLE IF EXISTS `objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `objects` (
  `object_id` int(11) NOT NULL,
  `object` varchar(200) NOT NULL,
  `object_type_id` int(11) NOT NULL,
  PRIMARY KEY (`object_id`),
  KEY `r_11` (`object_type_id`),
  CONSTRAINT `r_11` FOREIGN KEY (`object_type_id`) REFERENCES `object_types` (`object_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `objects`
--

LOCK TABLES `objects` WRITE;
/*!40000 ALTER TABLE `objects` DISABLE KEYS */;
INSERT INTO `objects` VALUES (441,'KING',35),(442,'BLAKE',32),(443,'WARD',33),(444,'ALLEN',33),(445,'MARTIN',33),(446,'TURNER',33),(447,'JAMES',31),(448,'SMITH',31),(449,'JONES',32),(4410,'CLARK',32),(4411,'SCOTT',34),(4412,'ADAMS',31),(4413,'FORD',34),(4414,'MILLER',31);
/*!40000 ALTER TABLE `objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `params`
--

DROP TABLE IF EXISTS `params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `params` (
  `empno` int(11) NOT NULL,
  `mgr` int(11) DEFAULT NULL,
  `hirerdate` date DEFAULT NULL,
  `sal` decimal(40,0) NOT NULL,
  `com` decimal(40,0) DEFAULT NULL,
  `deptno` int(11) DEFAULT NULL,
  `attr_id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  KEY `r_13` (`object_id`),
  KEY `r_14_idx` (`attr_id`),
  KEY `r_15_idx` (`deptno`),
  CONSTRAINT `r_13` FOREIGN KEY (`object_id`) REFERENCES `objects` (`object_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `r_14` FOREIGN KEY (`attr_id`) REFERENCES `attributes` (`attr_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `r_15` FOREIGN KEY (`deptno`) REFERENCES `city` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `params`
--

LOCK TABLES `params` WRITE;
/*!40000 ALTER TABLE `params` DISABLE KEYS */;
INSERT INTO `params` VALUES (7839,0,'1981-11-17',5000,0,20,111,441),(7698,7839,'1981-05-01',2850,0,30,112,442),(7521,7698,'1981-02-22',1250,500,30,113,443),(7499,7698,'1981-02-20',1600,300,30,114,444),(7654,7698,'1981-09-28',1250,1400,30,115,445),(7844,7698,'1981-09-08',1500,0,30,116,446),(7900,7698,'1981-12-03',950,0,20,117,447),(7566,7902,'1980-12-17',800,0,20,118,448),(7566,7839,'1981-04-02',2975,0,20,119,449),(7788,7839,'1981-06-09',2450,0,10,1110,4410),(7788,7566,'1981-06-09',3000,0,20,1111,4411),(7876,7788,'1983-09-08',1100,0,20,1112,4412),(7902,7566,'1981-12-03',3000,0,20,1113,4413),(7934,7782,'1982-01-23',1300,0,10,1114,4414);
/*!40000 ALTER TABLE `params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `project_id` int(11) NOT NULL AUTO_INCREMENT,
  `projectsName` varchar(45) NOT NULL,
  `project_discuss` date DEFAULT NULL,
  `specification` date DEFAULT NULL,
  `consept_sollution` date DEFAULT NULL,
  `tehnical_impl` date DEFAULT NULL,
  `start_project` date DEFAULT NULL,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (10,'TestProject','2018-02-15','2018-02-14','2018-02-24','2018-02-25','2018-02-28'),(11,'TestProject2','2018-03-22','2018-03-22','2018-03-09','2018-03-23','2018-03-09'),(12,'testProject3','2018-03-16','2018-03-16','2018-03-23','2018-03-29','2018-03-09');
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_datails`
--

DROP TABLE IF EXISTS `user_datails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_datails` (
  `login` varchar(40) NOT NULL,
  `password` varchar(1000) NOT NULL,
  `object_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  KEY `FK_object_id1` (`object_id`),
  KEY `fk_object_type` (`type_id`),
  CONSTRAINT `FK_object_id1` FOREIGN KEY (`object_id`) REFERENCES `objects` (`object_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_object_type` FOREIGN KEY (`type_id`) REFERENCES `user_profilee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_datails`
--

LOCK TABLES `user_datails` WRITE;
/*!40000 ALTER TABLE `user_datails` DISABLE KEYS */;
INSERT INTO `user_datails` VALUES ('president','$2a$10$pwWY7Xvys2Zon8LHiaYbSOoKsk10U7gm0xGl/JD.HylyCxjbbbBqu',441,2),('manager','$2a$10$wDp1C20ioCaADkgUMHmoaOdaZ8zoCjxaGZGd/kYRO19.mudFySHXi',442,3),('ward','$2a$10$y5jyr3W/X2ExO7donYZb8OF3/TkhpwK2t3Wr2QKtolLVcA/YvmAB2',443,1),('allen','$2a$10$QOunQolVZf/ohh6nHQHuZuydNpnDRuZ3XNm4dGPWsh3ufSfBaZHFa',444,1),('martin','$2a$10$YVpkEQUrSi1rZ3jBJEimMeH5DopsmOAqqdGrPg/wHlB5NVVxGY3Gq',445,1),('turner','$2a$10$6vPTMFcMMQVUMnrQBDDfM.BHr8yBDgR4kRiLhemvz.yIRSauIqxy.',446,1),('james','$2a$10$empJipgw66BLAvFGPYzITuq1Bb/DGIDne6.J..bY2k/M/ozcwT92q',447,1),('smith','$2a$10$49SH9FWOuBQP3jzluSd7tOWBIclubSMruxtQc.aRNqzExTCEYnLK2',448,1),('jones','$2a$10$qj58ZpDpC2FDKd/Ntt0E9.FWx.k9XCshBZLLX2cWf.wgapCTcD2PG',449,1),('clark','$2a$10$w/njjHrPAf/YdF/z4d0vD.9sb1POFGB.fXJjGx8kl5Bw6TqXRPZOu',4410,1),('scott','$2a$10$Aj2H9fpocPnNFiQQO0gjlu5EKScjdIW5Oz5cz2PoQas07uYYww9C6',4411,1),('adams','$2a$10$kcAU1fQOKPkmA8wm0KJLm.iff84uBBxvy6wdXsolfzXC1a1N4OA3y',4412,1),('ford','$2a$10$orznGEVjJLcIAOftmmm9s.6AWPVDzeC4tsDmkfCVZM1mXJEisqAZi',4413,1),('miller','$2a$10$gqhVKO2k1qTB13RebmFHl.em1l2d/xs8WEX7UGv6Rf.7zyAv/NU7.',4414,1);
/*!40000 ALTER TABLE `user_datails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profilee`
--

DROP TABLE IF EXISTS `user_profilee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_profilee` (
  `id` int(11) NOT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profilee`
--

LOCK TABLES `user_profilee` WRITE;
/*!40000 ALTER TABLE `user_profilee` DISABLE KEYS */;
INSERT INTO `user_profilee` VALUES (1,'ROLE_USER'),(2,'ROLE_ADMIN'),(3,'ROLE_CUST');
/*!40000 ALTER TABLE `user_profilee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_projects`
--

DROP TABLE IF EXISTS `user_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_projects` (
  `obj_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  KEY `FK_obj_id_for_projects` (`obj_id`),
  KEY `FK_project_id_for_user` (`project_id`),
  CONSTRAINT `FK_obj_id_for_projects` FOREIGN KEY (`obj_id`) REFERENCES `objects` (`object_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_project_id_for_user` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_projects`
--

LOCK TABLES `user_projects` WRITE;
/*!40000 ALTER TABLE `user_projects` DISABLE KEYS */;
INSERT INTO `user_projects` VALUES (446,10),(445,10),(448,11),(4411,12);
/*!40000 ALTER TABLE `user_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'netcracker'
--

--
-- Dumping routines for database 'netcracker'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-25 19:51:43
