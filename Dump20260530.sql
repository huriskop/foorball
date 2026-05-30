CREATE DATABASE  IF NOT EXISTS `football_transfer_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `football_transfer_system`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: football_transfer_system
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clubs`
--

DROP TABLE IF EXISTS `clubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clubs` (
  `club_id` int NOT NULL AUTO_INCREMENT,
  `club_name` varchar(100) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `league` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clubs`
--

LOCK TABLES `clubs` WRITE;
/*!40000 ALTER TABLE `clubs` DISABLE KEYS */;
INSERT INTO `clubs` VALUES (1,'Real Madrid','Spain','La Liga'),(2,'Barcelona','Spain','La Liga'),(3,'Manchester City','England','Premier League'),(4,'Arsenal','England','Premier League'),(5,'Manchester United','England','Premier League'),(6,'Liverpool','England','Premier League'),(7,'PSG','France','League 1'),(8,'Bayern Munich','Germany','Bundesliga'),(9,'Dortmund','Germany','Bundesliga'),(10,'Milan','Italy','Seria A');
/*!40000 ALTER TABLE `clubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `player_id` int NOT NULL AUTO_INCREMENT,
  `player_name` varchar(100) NOT NULL,
  `age` int DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `position` varchar(20) DEFAULT NULL,
  `market_value` decimal(12,2) DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `club_id` int DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  KEY `club_id` (`club_id`),
  CONSTRAINT `players_ibfk_1` FOREIGN KEY (`club_id`) REFERENCES `clubs` (`club_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
INSERT INTO `players` VALUES (1,'Vinicius Junior',25,'Brazil','LW',150000000.00,91,1),(2,'Jude Bellingham',22,'England','CM',140000000.00,92,1),(3,'Erling Haaland',24,'Norway','ST',180000000.00,92,3),(4,'Kylian Mbappe',25,'France','ST',180000000.00,93,1),(5,'Jamal Musiala',21,'Germany','CAM',120000000.00,89,8),(6,'Florian Wirtz',21,'Germany','CAM',130000000.00,89,8),(7,'Pedri',22,'Spain','CM',90000000.00,87,2),(8,'Bukayo Saka',23,'England','RW',140000000.00,89,4),(9,'Rafael Leao',26,'Portugal','LW',65000000.00,84,10),(10,'Thibaut Courtois',34,'Belgium','GK',18000000.00,89,1),(11,'Manuel Neuer',40,'Germany','GK',4000000.00,84,8),(12,'Federico Valverde',27,'Uruguay','CM',120000000.00,90,1),(13,'Rodrygo',25,'Brazil','RW',90000000.00,88,1),(14,'Aurelien Tchouameni',26,'France','CDM',80000000.00,87,1),(15,'Eduardo Camavinga',23,'France','CM',80000000.00,87,1),(16,'Antonio Rudiger',33,'Germany','CB',25000000.00,86,1),(17,'Lamine Yamal',18,'Spain','RW',200000000.00,92,2),(18,'Gavi',21,'Spain','CM',60000000.00,86,2),(19,'Frenkie de Jong',29,'Netherlands','CM',45000000.00,86,2),(20,'Raphinha',29,'Brazil','RW',80000000.00,88,2),(21,'Pau Cubarsi',19,'Spain','CB',70000000.00,85,2),(22,'Phil Foden',26,'England','CAM',80000000.00,88,3),(23,'Rodri',30,'Spain','CDM',90000000.00,90,3),(24,'Ruben Dias',29,'Portugal','CB',70000000.00,88,3),(25,'Josko Gvardiol',24,'Croatia','LB',75000000.00,87,3),(26,'Jeremy Doku',24,'Belgium','LW',55000000.00,85,3),(27,'Martin Odegaard',27,'Norway','CAM',110000000.00,89,4),(28,'Declan Rice',27,'England','CDM',120000000.00,89,4),(29,'William Saliba',25,'France','CB',80000000.00,87,4),(30,'Gabriel Martinelli',25,'Brazil','LW',60000000.00,85,4),(31,'Bruno Fernandes',31,'Portugal','CAM',50000000.00,87,5),(32,'Benjamin Sesko',23,'Slovenia','ST',70000000.00,85,5),(33,'Bryan Mbeumo',26,'Cameroon','RW',55000000.00,84,5),(34,'Kobbie Mainoo',21,'England','CM',50000000.00,83,5),(35,'Mohamed Salah',34,'Egypt','RW',45000000.00,87,6),(36,'Virgil van Dijk',34,'Netherlands','CB',25000000.00,88,6),(37,'Alexis Mac Allister',27,'Argentina','CM',75000000.00,86,6),(38,'Dominik Szoboszlai',25,'Hungary','CAM',75000000.00,86,6),(39,'Ousmane Dembele',29,'France','RW',90000000.00,90,7),(40,'Khvicha Kvaratskhelia',25,'Georgia','LW',90000000.00,88,7),(41,'Achraf Hakimi',27,'Morocco','RB',70000000.00,87,7),(42,'Vitinha',26,'Portugal','CM',80000000.00,88,7),(43,'Harry Kane',32,'England','ST',65000000.00,90,8),(44,'Michael Olise',24,'France','RW',100000000.00,88,8),(45,'Joshua Kimmich',31,'Germany','CDM',40000000.00,86,8),(46,'Alphonso Davies',25,'Canada','LB',50000000.00,86,8),(47,'Gregor Kobel',28,'Switzerland','GK',40000000.00,85,9),(48,'Nico Schlotterbeck',26,'Germany','CB',40000000.00,84,9),(49,'Mike Maignan',30,'France','GK',35000000.00,87,10),(50,'Christian Pulisic',27,'USA','RW',50000000.00,84,10),(51,'Adrien Rabiot',31,'France','CM',20000000.00,83,10);
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squad`
--

DROP TABLE IF EXISTS `squad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `squad` (
  `squad_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `player_id` int DEFAULT NULL,
  `position_slot` varchar(20) DEFAULT NULL,
  `date_added` date DEFAULT NULL,
  PRIMARY KEY (`squad_id`),
  KEY `user_id` (`user_id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `squad_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `squad_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squad`
--

LOCK TABLES `squad` WRITE;
/*!40000 ALTER TABLE `squad` DISABLE KEYS */;
INSERT INTO `squad` VALUES (3,1,44,'RW','2026-05-24'),(4,1,10,'GK','2026-05-26'),(5,1,46,'LB','2026-05-27'),(6,1,41,'RB','2026-05-30'),(7,1,40,'LW','2026-05-30');
/*!40000 ALTER TABLE `squad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfers`
--

DROP TABLE IF EXISTS `transfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transfers` (
  `transfer_id` int NOT NULL AUTO_INCREMENT,
  `player_id` int DEFAULT NULL,
  `from_club_id` int DEFAULT NULL,
  `to_user_id` int DEFAULT NULL,
  `transfer_fee` decimal(12,2) DEFAULT NULL,
  `transfer_date` date DEFAULT NULL,
  PRIMARY KEY (`transfer_id`),
  KEY `player_id` (`player_id`),
  KEY `from_club_id` (`from_club_id`),
  KEY `to_user_id` (`to_user_id`),
  CONSTRAINT `transfers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`player_id`),
  CONSTRAINT `transfers_ibfk_2` FOREIGN KEY (`from_club_id`) REFERENCES `clubs` (`club_id`),
  CONSTRAINT `transfers_ibfk_3` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfers`
--

LOCK TABLES `transfers` WRITE;
/*!40000 ALTER TABLE `transfers` DISABLE KEYS */;
INSERT INTO `transfers` VALUES (1,4,1,1,180000000.00,'2026-01-24'),(2,6,8,1,130000000.00,'2026-02-11'),(3,44,8,1,100000000.00,'2026-05-03'),(4,10,1,1,18000000.00,'2026-07-24'),(5,46,8,1,50000000.00,'2026-09-25'),(6,41,7,1,70000000.00,'2026-05-30'),(7,40,7,1,90000000.00,'2026-05-30');
/*!40000 ALTER TABLE `transfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `team_name` varchar(100) NOT NULL,
  `budget` decimal(12,2) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Islam','Incheon',1000000000.00),(2,'Manas','INHA FC',150000000.00);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-30 16:07:37
