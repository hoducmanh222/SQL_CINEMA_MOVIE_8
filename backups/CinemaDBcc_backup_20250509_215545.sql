-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: CinemaDBcc
-- ------------------------------------------------------
-- Server version	9.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookingaudit`
--

DROP TABLE IF EXISTS `bookingaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookingaudit` (
  `AuditID` int NOT NULL AUTO_INCREMENT,
  `OperationType` varchar(50) DEFAULT NULL,
  `AffectedScreeningID` int DEFAULT NULL,
  `AffectedSeat` varchar(10) DEFAULT NULL,
  `UserID` varchar(50) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`AuditID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookingaudit`
--

LOCK TABLES `bookingaudit` WRITE;
/*!40000 ALTER TABLE `bookingaudit` DISABLE KEYS */;
INSERT INTO `bookingaudit` VALUES (1,'Booking',1,'D4','admin_user','2025-05-09 21:48:18'),(2,'Cancellation',1,'D4','admin_user','2025-05-09 21:48:47');
/*!40000 ALTER TABLE `bookingaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cancelledtickets`
--

DROP TABLE IF EXISTS `cancelledtickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cancelledtickets` (
  `CancellationID` int NOT NULL AUTO_INCREMENT,
  `TicketID` int NOT NULL,
  `CustomerID` int DEFAULT NULL,
  `ScreeningID` int DEFAULT NULL,
  `SeatNumber` varchar(10) DEFAULT NULL,
  `CancellationDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `CancelledBy` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CancellationID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `ScreeningID` (`ScreeningID`),
  CONSTRAINT `cancelledtickets_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `cancelledtickets_ibfk_2` FOREIGN KEY (`ScreeningID`) REFERENCES `screenings` (`ScreeningID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cancelledtickets`
--

LOCK TABLES `cancelledtickets` WRITE;
/*!40000 ALTER TABLE `cancelledtickets` DISABLE KEYS */;
INSERT INTO `cancelledtickets` VALUES (1,6,1,1,'D4','2025-05-09 21:48:47','admin_user');
/*!40000 ALTER TABLE `cancelledtickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cinemarooms`
--

DROP TABLE IF EXISTS `cinemarooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cinemarooms` (
  `RoomID` int NOT NULL AUTO_INCREMENT,
  `RoomName` varchar(50) NOT NULL,
  `Capacity` int DEFAULT NULL,
  PRIMARY KEY (`RoomID`),
  UNIQUE KEY `RoomName` (`RoomName`),
  CONSTRAINT `cinemarooms_chk_1` CHECK ((`Capacity` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinemarooms`
--

LOCK TABLES `cinemarooms` WRITE;
/*!40000 ALTER TABLE `cinemarooms` DISABLE KEYS */;
INSERT INTO `cinemarooms` VALUES (1,'Room A',100),(2,'Room B',80);
/*!40000 ALTER TABLE `cinemarooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `CustomerName` varchar(100) NOT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `PhoneNumber` (`PhoneNumber`),
  KEY `idx_customer_phone` (`PhoneNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Nguyen Van A','0912345678'),(2,'Tran Thi B','0923456789'),(3,'Le Van C','0934567890');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `FeedbackID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int DEFAULT NULL,
  `MovieID` int DEFAULT NULL,
  `Rating` int DEFAULT NULL,
  `Comment` text,
  `FeedbackDate` date DEFAULT NULL,
  PRIMARY KEY (`FeedbackID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `MovieID` (`MovieID`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE,
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`MovieID`) REFERENCES `movies` (`MovieID`) ON DELETE CASCADE,
  CONSTRAINT `feedback_chk_1` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,1,1,5,'Great movie!','2025-05-02'),(2,2,2,4,'Interesting plot.','2025-05-02'),(3,3,3,3,'It was okay.','2025-05-03');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `GenreID` int NOT NULL AUTO_INCREMENT,
  `GenreName` varchar(50) NOT NULL,
  PRIMARY KEY (`GenreID`),
  UNIQUE KEY `GenreName` (`GenreName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (3,'Action'),(1,'Sci-Fi'),(2,'Thriller');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `MovieID` int NOT NULL AUTO_INCREMENT,
  `MovieTitle` varchar(100) NOT NULL,
  `GenreID` int DEFAULT NULL,
  `DurationMinutes` int DEFAULT NULL,
  PRIMARY KEY (`MovieID`),
  KEY `GenreID` (`GenreID`),
  KEY `idx_movie_title` (`MovieTitle`),
  CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`GenreID`) REFERENCES `genres` (`GenreID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `movies_chk_1` CHECK ((`DurationMinutes` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'Inception',1,148),(2,'Parasite',2,132),(3,'Avengers: Endgame',3,181);
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotions`
--

DROP TABLE IF EXISTS `promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotions` (
  `PromotionID` int NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) DEFAULT NULL,
  `DiscountPercent` decimal(5,2) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  PRIMARY KEY (`PromotionID`),
  CONSTRAINT `promotions_chk_1` CHECK (((`DiscountPercent` >= 0) and (`DiscountPercent` <= 100)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotions`
--

LOCK TABLES `promotions` WRITE;
/*!40000 ALTER TABLE `promotions` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screenings`
--

DROP TABLE IF EXISTS `screenings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `screenings` (
  `ScreeningID` int NOT NULL AUTO_INCREMENT,
  `MovieID` int DEFAULT NULL,
  `RoomID` int DEFAULT NULL,
  `ScreeningDate` date DEFAULT NULL,
  `ScreeningTime` time DEFAULT NULL,
  PRIMARY KEY (`ScreeningID`),
  KEY `MovieID` (`MovieID`),
  KEY `RoomID` (`RoomID`),
  KEY `idx_screening_date` (`ScreeningDate`),
  CONSTRAINT `screenings_ibfk_1` FOREIGN KEY (`MovieID`) REFERENCES `movies` (`MovieID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `screenings_ibfk_2` FOREIGN KEY (`RoomID`) REFERENCES `cinemarooms` (`RoomID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screenings`
--

LOCK TABLES `screenings` WRITE;
/*!40000 ALTER TABLE `screenings` DISABLE KEYS */;
INSERT INTO `screenings` VALUES (1,1,1,'2025-05-02','18:00:00'),(2,2,1,'2025-05-02','21:00:00'),(3,3,2,'2025-05-03','17:30:00'),(4,1,2,'2025-05-04','20:00:00');
/*!40000 ALTER TABLE `screenings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securityaudit`
--

DROP TABLE IF EXISTS `securityaudit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `securityaudit` (
  `AuditID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) DEFAULT NULL,
  `Operation` varchar(100) DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`AuditID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securityaudit`
--

LOCK TABLES `securityaudit` WRITE;
/*!40000 ALTER TABLE `securityaudit` DISABLE KEYS */;
/*!40000 ALTER TABLE `securityaudit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `StaffID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Role` varchar(50) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`StaffID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `TicketID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int DEFAULT NULL,
  `ScreeningID` int DEFAULT NULL,
  `SeatNumber` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`TicketID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `ScreeningID` (`ScreeningID`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`ScreeningID`) REFERENCES `screenings` (`ScreeningID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,1,1,'A1'),(2,1,1,'A2'),(3,2,2,'B1'),(4,3,3,'C5'),(5,2,4,'D10');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_prevent_double_booking` BEFORE INSERT ON `tickets` FOR EACH ROW BEGIN
    DECLARE seat_count INT;
   
    SELECT COUNT(*) INTO seat_count
    FROM Tickets
    WHERE ScreeningID = NEW.ScreeningID AND SeatNumber = NEW.SeatNumber;
   
    IF seat_count > 0 THEN
        INSERT INTO BookingAudit (OperationType, AffectedScreeningID, AffectedSeat, UserID, Timestamp)
        VALUES ('Failed Booking', NEW.ScreeningID, NEW.SeatNumber, IFNULL(@current_user, USER()), NOW());
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Seat already booked';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_update_seat_availability` AFTER INSERT ON `tickets` FOR EACH ROW BEGIN
    INSERT INTO BookingAudit (OperationType, AffectedScreeningID, AffectedSeat, UserID, Timestamp)
    VALUES ('Booking', NEW.ScreeningID, NEW.SeatNumber, IFNULL(@current_user, USER()), NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tr_after_delete_ticket` AFTER DELETE ON `tickets` FOR EACH ROW BEGIN
    -- Only add audit log if it's not from sp_cancel_ticket
    -- This prevents duplicate entries when cancelling tickets
    IF NOT EXISTS (
        SELECT 1 FROM CancelledTickets 
        WHERE TicketID = OLD.TicketID AND 
              ScreeningID = OLD.ScreeningID AND 
              SeatNumber = OLD.SeatNumber
    ) THEN
        INSERT INTO BookingAudit (OperationType, AffectedScreeningID, AffectedSeat, UserID, Timestamp)
        VALUES ('Cancellation', OLD.ScreeningID, OLD.SeatNumber, IFNULL(@current_user, USER()), NOW());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `PasswordHash` varchar(256) NOT NULL,
  `Role` enum('Admin','TicketClerk','Guest') NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin_user','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','Admin'),(2,'clerk_user','a3630b8b8f6c82d33b0695f77f915e69ed7b0c5214062f8b870219845e069d30','TicketClerk'),(3,'guest_user','6b93ccba414ac1d0ae1e77f3fac560c748a6701ed6946735a49d463351518e16','Guest');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_dailyrevenue`
--

DROP TABLE IF EXISTS `vw_dailyrevenue`;
/*!50001 DROP VIEW IF EXISTS `vw_dailyrevenue`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_dailyrevenue` AS SELECT 
 1 AS `Date`,
 1 AS `TicketsSold`,
 1 AS `TicketsCancelled`,
 1 AS `Revenue`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_dailyscreenings`
--

DROP TABLE IF EXISTS `vw_dailyscreenings`;
/*!50001 DROP VIEW IF EXISTS `vw_dailyscreenings`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_dailyscreenings` AS SELECT 
 1 AS `ScreeningID`,
 1 AS `MovieTitle`,
 1 AS `GenreName`,
 1 AS `RoomName`,
 1 AS `ScreeningDate`,
 1 AS `ScreeningTime`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_seatavailability`
--

DROP TABLE IF EXISTS `vw_seatavailability`;
/*!50001 DROP VIEW IF EXISTS `vw_seatavailability`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_seatavailability` AS SELECT 
 1 AS `ScreeningID`,
 1 AS `MovieTitle`,
 1 AS `RoomName`,
 1 AS `ScreeningDate`,
 1 AS `ScreeningTime`,
 1 AS `Capacity`,
 1 AS `AvailableSeats`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_dailyrevenue`
--

/*!50001 DROP VIEW IF EXISTS `vw_dailyrevenue`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dailyrevenue` AS select `s`.`ScreeningDate` AS `Date`,count(`t`.`TicketID`) AS `TicketsSold`,count(`c`.`CancellationID`) AS `TicketsCancelled`,(count(`t`.`TicketID`) * 10.00) AS `Revenue` from ((`screenings` `s` left join `tickets` `t` on((`s`.`ScreeningID` = `t`.`ScreeningID`))) left join `cancelledtickets` `c` on((`s`.`ScreeningID` = `c`.`ScreeningID`))) group by `s`.`ScreeningDate` order by `s`.`ScreeningDate` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_dailyscreenings`
--

/*!50001 DROP VIEW IF EXISTS `vw_dailyscreenings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dailyscreenings` AS select `s`.`ScreeningID` AS `ScreeningID`,`m`.`MovieTitle` AS `MovieTitle`,`g`.`GenreName` AS `GenreName`,`r`.`RoomName` AS `RoomName`,`s`.`ScreeningDate` AS `ScreeningDate`,`s`.`ScreeningTime` AS `ScreeningTime` from (((`screenings` `s` join `movies` `m` on((`s`.`MovieID` = `m`.`MovieID`))) join `cinemarooms` `r` on((`s`.`RoomID` = `r`.`RoomID`))) join `genres` `g` on((`m`.`GenreID` = `g`.`GenreID`))) where (`s`.`ScreeningDate` = curdate()) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_seatavailability`
--

/*!50001 DROP VIEW IF EXISTS `vw_seatavailability`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_seatavailability` AS select `s`.`ScreeningID` AS `ScreeningID`,`m`.`MovieTitle` AS `MovieTitle`,`r`.`RoomName` AS `RoomName`,`s`.`ScreeningDate` AS `ScreeningDate`,`s`.`ScreeningTime` AS `ScreeningTime`,`r`.`Capacity` AS `Capacity`,(`r`.`Capacity` - count(`t`.`TicketID`)) AS `AvailableSeats` from (((`screenings` `s` join `cinemarooms` `r` on((`s`.`RoomID` = `r`.`RoomID`))) join `movies` `m` on((`s`.`MovieID` = `m`.`MovieID`))) left join `tickets` `t` on((`s`.`ScreeningID` = `t`.`ScreeningID`))) group by `s`.`ScreeningID`,`m`.`MovieTitle`,`r`.`RoomName`,`s`.`ScreeningDate`,`s`.`ScreeningTime`,`r`.`Capacity` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-09 21:55:46
