-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: druginventory
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `adminId` int(11) NOT NULL AUTO_INCREMENT,
  `lastName` varchar(100) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`adminId`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Barja','Joshua Jericho','barja@gmail.com','1234'),(2,'Israel','Renna','isarael@gmail.com','1234'),(3,'Montenegro','John Renzzo','montenegro@gmail.com','1234');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drugs`
--

DROP TABLE IF EXISTS `drugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drugs` (
  `drugId` int(11) NOT NULL,
  `drugName` varchar(100) NOT NULL,
  `drugType` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `manufacturer` varchar(100) DEFAULT NULL,
  `unitPrice` decimal(10,2) DEFAULT NULL,
  `expiryDate` date DEFAULT NULL,
  PRIMARY KEY (`drugId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drugs`
--

LOCK TABLES `drugs` WRITE;
/*!40000 ALTER TABLE `drugs` DISABLE KEYS */;
INSERT INTO `drugs` VALUES (5,'Omeprazole','Antibiotic','Omeprazole is used to treat common conditions.','CureWell',69.00,'2028-04-03'),(6,'Simvastatin','Antacid','Simvastatin is used to treat common conditions.','HealthPlus',70.60,'2026-05-23'),(7,'Metformin','Antibiotic','Metformin is used to treat common conditions.','MediLife',123.87,'2026-06-23'),(8,'Losartan','Antihistamine','Losartan is used to treat common conditions.','PharmaCorp',30.94,'2026-12-19'),(9,'Amlodipine','Antibiotic','Amlodipine is used to treat common conditions.','HealthPlus',143.48,'2027-07-08'),(10,'Clopidogrel','Antacid','Clopidogrel is used to treat common conditions.','PharmaCorp',147.56,'2025-09-21'),(11,'Azithromycin','Analgesic','Azithromycin is used to treat common conditions.','PharmaCorp',178.97,'2026-06-17'),(12,'Doxycycline','Antibiotic','Doxycycline is used to treat common conditions.','PharmaCorp',11.12,'2026-06-18'),(13,'Hydrochlorothiazide','Antibiotic','Hydrochlorothiazide is used to treat common conditions.','LifeMeds',160.96,'2028-03-18'),(14,'Pantoprazole','Antihistamine','Pantoprazole is used to treat common conditions.','PharmaCorp',102.13,'2027-09-20'),(15,'Gabapentin','Antihistamine','Gabapentin is used to treat common conditions.','HealthPlus',90.45,'2026-09-15'),(16,'Fluoxetine','Antihistamine','Fluoxetine is used to treat common conditions.','HealthPlus',100.76,'2028-02-19'),(17,'Sertraline','Antacid','Sertraline is used to treat common conditions.','LifeMeds',31.25,'2028-02-10'),(18,'Ciprofloxacin','Antacid','Ciprofloxacin is used to treat common conditions.','LifeMeds',180.63,'2026-06-06'),(19,'Alprazolam','Antihistamine','Alprazolam is used to treat common conditions.','HealthPlus',133.41,'2027-04-13'),(20,'Prednisone','Antihistamine','Prednisone is used to treat common conditions.','MediLife',166.52,'2027-04-12'),(21,'Ranitidine','Antidepressant','Ranitidine is used to treat common conditions.','HealthPlus',43.33,'2027-06-09'),(22,'Levothyroxine','Analgesic','Levothyroxine is used to treat common conditions.','HealthPlus',87.17,'2026-01-29'),(23,'Atorvastatin','Analgesic','Atorvastatin is used to treat common conditions.','CureWell',20.96,'2025-11-08'),(24,'Warfarin','Analgesic','Warfarin is used to treat common conditions.','CureWell',70.41,'2027-02-22'),(25,'Zolpidem','Antacid','Zolpidem is used to treat common conditions.','PharmaCorp',36.17,'2026-06-01'),(29,'Salbutamol','Antihistamine','Salbutamol is used to treat common conditions.','MediLife',138.83,'2025-09-17');
/*!40000 ALTER TABLE `drugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `inventoryId` int(11) NOT NULL,
  `drugId` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `reorderLevel` int(11) DEFAULT 10,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`inventoryId`),
  KEY `drugId` (`drugId`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`drugId`) REFERENCES `drugs` (`drugId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (5,5,70,10,'2025-05-22 06:38:13'),(6,6,190,10,'2025-05-21 07:12:15'),(7,7,278,10,'2025-05-21 07:12:15'),(8,8,422,10,'2025-05-21 07:12:15'),(9,9,603,10,'2025-05-21 07:12:15'),(10,10,702,10,'2025-05-21 07:12:15'),(11,11,317,10,'2025-05-21 07:12:15'),(12,12,787,10,'2025-05-21 07:12:15'),(13,13,693,10,'2025-05-21 07:12:15'),(14,14,828,10,'2025-05-21 07:12:15'),(15,15,419,10,'2025-05-21 07:12:15'),(16,16,16,10,'2025-05-21 07:12:15'),(17,17,285,10,'2025-05-21 07:12:15'),(18,18,972,10,'2025-05-21 07:12:15'),(19,19,125,10,'2025-05-21 07:12:15'),(20,20,473,10,'2025-05-21 07:12:15'),(21,21,389,10,'2025-05-21 07:12:15'),(22,22,842,10,'2025-05-21 07:12:15'),(23,23,626,10,'2025-05-21 07:12:15'),(24,24,874,10,'2025-05-21 07:12:15'),(25,25,614,10,'2025-05-21 07:12:15'),(29,29,469,10,'2025-05-21 07:12:15');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchases` (
  `purchaseId` int(11) NOT NULL AUTO_INCREMENT,
  `quantityPurchased` int(11) DEFAULT NULL,
  `purchaseDate` date DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `drugId` int(11) DEFAULT NULL,
  `total` int(11) NOT NULL,
  PRIMARY KEY (`purchaseId`),
  KEY `fk_user` (`userId`),
  KEY `fk_drug` (`drugId`),
  CONSTRAINT `fk_drug` FOREIGN KEY (`drugId`) REFERENCES `drugs` (`drugId`),
  CONSTRAINT `fk_user` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
INSERT INTO `purchases` VALUES (1,5,'2025-05-22',1,5,0),(2,10,'2025-05-22',1,5,690);
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suppliers` (
  `supplierId` int(11) NOT NULL AUTO_INCREMENT,
  `supplierName` varchar(100) DEFAULT NULL,
  `contactNumber` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  PRIMARY KEY (`supplierId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Supplier A','123-456-7890','supplierA@email.com','123 Main St, City A'),(2,'Supplier B','234-567-8901','supplierB@email.com','456 Elm St, City B'),(3,'Supplier C','345-678-9012','supplierC@email.com','789 Oak St, City C'),(4,'Supplier D','456-789-0123','supplierD@email.com','101 Pine St, City D'),(5,'Supplier E','567-890-1234','supplierE@email.com','202 Maple St, City E'),(6,'Supplier F','678-901-2345','supplierF@email.com','303 Birch St, City F'),(7,'Supplier G','789-012-3456','supplierG@email.com','404 Cedar St, City G'),(8,'Supplier H','890-123-4567','supplierH@email.com','505 Ash St, City H'),(9,'Supplier I','901-234-5678','supplierI@email.com','606 Pine St, City I'),(10,'Supplier J','012-345-6789','supplierJ@email.com','707 Maple St, City J'),(11,'Supplier K','123-456-7891','supplierK@email.com','808 Oak St, City K'),(12,'Supplier L','234-567-8902','supplierL@email.com','909 Birch St, City L'),(13,'Supplier M','345-678-9013','supplierM@email.com','1010 Cedar St, City M'),(14,'Supplier N','456-789-0124','supplierN@email.com','1111 Pine St, City N'),(15,'Supplier O','567-890-1235','supplierO@email.com','1212 Maple St, City O');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userId` int(11) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jj','pogi','jj@gmail.com','12345'),(2,'renzzo','Montenegro','renzzo@gmail.com','12345');
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

-- Dump completed on 2025-05-22 15:10:59
