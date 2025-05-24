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
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Barja','Joshua Jericho','barja@gmail.com','1234'),(2,'Israel','Renna','isarael@gmail.com','1234'),(3,'Montenegro','John Renzzo','montenegro@gmail.com','1234'),(4,'Olivares','Tischia Ann','olivares@gmail.com','1234');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `drugs`
--

LOCK TABLES `drugs` WRITE;
/*!40000 ALTER TABLE `drugs` DISABLE KEYS */;
INSERT INTO `drugs` VALUES (1,'Paracetamol','Tablet','Used to treat pain and fever.','PharmaCorp',1.50,'2026-01-15'),(2,'Amoxicillin','Capsule','Antibiotic for bacterial infections.','MediHealth',2.75,'2025-10-30'),(3,'Ibuprofen','Tablet','Nonsteroidal anti-inflammatory drug.','HealthLine Inc.',1.80,'2026-03-20'),(4,'Cetirizine','Tablet','Antihistamine for allergy relief.','AllerGen',1.25,'2025-08-10'),(5,'Salbutamol','Inhaler','Used for asthma relief.','RespiraMed',5.00,'2027-06-18'),(6,'Metformin','Tablet','Used to treat type 2 diabetes.','GlucoPharma',0.90,'2026-11-05'),(7,'Loperamide','Capsule','Used to treat diarrhea.','Digestix Labs',1.10,'2025-07-01'),(8,'Omeprazole','Capsule','Reduces stomach acid.','GastroHealth',1.65,'2026-09-12'),(9,'Aspirin','Tablet','Used for pain, fever, and inflammation.','PainAway Ltd.',1.00,'2027-02-25'),(10,'Losartan','Tablet','Used to treat high blood pressure.','CardioWell',2.20,'2026-12-01');
/*!40000 ALTER TABLE `drugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES (1,1,3,10,'2025-05-24 02:26:27'),(2,2,150,15,'2025-05-24 02:03:49'),(3,3,200,20,'2025-05-24 02:03:49'),(4,4,120,10,'2025-05-24 02:03:49'),(5,5,80,10,'2025-05-24 02:03:49'),(6,6,90,12,'2025-05-24 02:03:49'),(7,7,60,10,'2025-05-24 02:03:49'),(8,8,110,15,'2025-05-24 02:03:49'),(9,9,130,10,'2025-05-24 02:03:49'),(10,10,140,20,'2025-05-24 02:03:49');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `purchases`
--

LOCK TABLES `purchases` WRITE;
/*!40000 ALTER TABLE `purchases` DISABLE KEYS */;
INSERT INTO `purchases` VALUES (24,2,'2025-05-24',1,1,3);
/*!40000 ALTER TABLE `purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jj','pogi','jj@gmail.com','12345'),(2,'renzzo','Montenegro','renzzo@gmail.com','12345'),(3,'Jaricho','Barj','jaricho@gmail.com','12345'),(4,'wan','nice','wan@gmail.com','12345'),(5,'Sean Xander','Aquino','aquino@gmail.com','12345');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-24 10:53:59
