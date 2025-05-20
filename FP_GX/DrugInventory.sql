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
INSERT INTO `drugs` VALUES (1,'Paracetamol','Analgesic','hhd','ewan kay renzzo',2.00,'2025-06-07'),(2,'Marijuana','di ko alam ','ewan','quiboloy',2.00,'2025-05-21'),(3,'Ecstasy','Class A','Crack cocaine','Gedli',2500.00,'2027-04-03');
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
INSERT INTO `inventory` VALUES (1,NULL,69,10,'2025-05-19 15:06:30'),(2,NULL,5000,10,'2025-05-19 15:06:48'),(3,NULL,1,10,'2025-05-19 15:13:01');
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
  `drugId` int(11) DEFAULT NULL,
  `supplierId` int(11) DEFAULT NULL,
  `quantityPurchased` int(11) DEFAULT NULL,
  `purchaseDate` date DEFAULT NULL,
  PRIMARY KEY (`purchaseId`),
  KEY `drugId` (`drugId`),
  KEY `supplierId` (`supplierId`),
  CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`drugId`) REFERENCES `drugs` (`drugId`),
  CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`supplierId`) REFERENCES `suppliers` (`supplierId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-20 14:25:23
