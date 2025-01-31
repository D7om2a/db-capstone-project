-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: littlelemondb
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `bookingID` int NOT NULL AUTO_INCREMENT,
  `bookingDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `tableNumber` int NOT NULL,
  `fk_CustomerID` int NOT NULL,
  PRIMARY KEY (`bookingID`),
  KEY `fk_customerID_idx` (`fk_CustomerID`),
  CONSTRAINT `fk_customerID` FOREIGN KEY (`fk_CustomerID`) REFERENCES `customers` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,'2023-10-01 18:00:00',5,1),(2,'2023-10-02 19:30:00',3,2),(3,'2024-04-22 13:40:00',2,3),(5,'2023-10-05 21:00:00',6,5),(6,'2023-10-02 00:00:00',3,4),(8,'2025-01-30 22:30:00',4,3),(9,'2025-02-16 18:26:00',3,5);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customerID` int NOT NULL AUTO_INCREMENT,
  `customerName` varchar(60) NOT NULL,
  `contactNumber` varchar(15) DEFAULT NULL,
  `customerEmail` varchar(100) NOT NULL,
  PRIMARY KEY (`customerID`),
  UNIQUE KEY `customerEmail_UNIQUE` (`customerEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'John Doe','555-1001','john@example.com'),(2,'Jane Smith','555-2002','jane@example.com'),(3,'Alice Brown','555-3003','alice@example.com'),(4,'Bob Wilson','555-4004','bob@example.com'),(5,'Charlie Green','555-5005','charlie@example.com');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `menuID` int NOT NULL AUTO_INCREMENT,
  `itemName` varchar(50) NOT NULL,
  `itemType` enum('Cuisine','Starter','Course','Drink','Dessert') NOT NULL,
  `itemPrice` decimal(10,2) NOT NULL,
  PRIMARY KEY (`menuID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Margherita Pizza','Cuisine',15.00),(2,'Garlic Bread','Starter',8.50),(3,'Caesar Salad','Starter',10.00),(4,'Grilled Salmon','Course',20.00),(5,'Coke','Drink',3.00),(6,'Tiramisu','Dessert',7.00),(7,'Spaghetti Carbonara','Cuisine',12.00),(8,'Mineral Water','Drink',2.50),(9,'Chocolate Cake','Dessert',6.50),(10,'Beef Burger','Cuisine',14.00);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuorderdetail`
--

DROP TABLE IF EXISTS `menuorderdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menuorderdetail` (
  `fk_orderID` int NOT NULL,
  `fk_menuID` int NOT NULL,
  `quantity` int DEFAULT NULL,
  KEY `fk_orderID_idx` (`fk_orderID`),
  KEY `fk_menuID_idx` (`fk_menuID`),
  CONSTRAINT `fk2_orderID` FOREIGN KEY (`fk_orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_menuID` FOREIGN KEY (`fk_menuID`) REFERENCES `menu` (`menuID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuorderdetail`
--

LOCK TABLES `menuorderdetail` WRITE;
/*!40000 ALTER TABLE `menuorderdetail` DISABLE KEYS */;
INSERT INTO `menuorderdetail` VALUES (1,1,2),(1,2,1),(2,3,1),(2,7,1),(2,5,2),(3,4,1),(3,8,1),(3,6,1),(5,7,2),(5,8,1);
/*!40000 ALTER TABLE `menuorderdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `orderDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `totalCost` decimal(10,2) DEFAULT NULL,
  `fk_bookingID` int NOT NULL,
  PRIMARY KEY (`orderID`),
  KEY `fk_bookingID_idx` (`fk_bookingID`),
  CONSTRAINT `fk_bookingID` FOREIGN KEY (`fk_bookingID`) REFERENCES `bookings` (`bookingID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2023-10-01 18:05:00',38.50,1),(2,'2023-10-02 19:35:00',28.00,2),(3,'2023-10-03 20:20:00',29.50,3),(5,'2023-10-05 21:05:00',26.50,5);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderstatus`
--

DROP TABLE IF EXISTS `orderstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderstatus` (
  `orderStatusID` int NOT NULL AUTO_INCREMENT,
  `fk_orderID` int NOT NULL,
  `orderStatus` enum('Pending','Delivered','Cancelled') NOT NULL,
  `orderStatusDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`orderStatusID`),
  KEY `fk_orderID_idx` (`fk_orderID`),
  CONSTRAINT `fk_orderID` FOREIGN KEY (`fk_orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderstatus`
--

LOCK TABLES `orderstatus` WRITE;
/*!40000 ALTER TABLE `orderstatus` DISABLE KEYS */;
INSERT INTO `orderstatus` VALUES (1,1,'Delivered','2023-10-01 19:00:00'),(2,2,'Delivered','2023-10-02 20:15:00'),(3,3,'Pending','2023-10-03 20:45:00'),(5,5,'Cancelled','2023-10-05 21:10:00');
/*!40000 ALTER TABLE `orderstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `ordersview`
--

DROP TABLE IF EXISTS `ordersview`;
/*!50001 DROP VIEW IF EXISTS `ordersview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ordersview` AS SELECT 
 1 AS `orderID`,
 1 AS `quantity`,
 1 AS `totalCost`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staffID` int NOT NULL AUTO_INCREMENT,
  `staffName` varchar(100) NOT NULL,
  `staffRole` varchar(100) DEFAULT NULL,
  `salary` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`staffID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Sarah Johnson','Manager',55000),(2,'Mike Williams','Waiter',32000),(3,'Emily Davis','Chef',48000),(4,'Tom Clark','Bartender',28000);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'littlelemondb'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbuser`@`%` PROCEDURE `AddBooking`(IN bookdate DATETIME,
    IN tableNum INT, IN fk_c INT)
BEGIN
	DECLARE existingBookings INT DEFAULT 0;
    
    START TRANSACTION;
    
    INSERT INTO bookings (bookingDate, tableNumber, fk_CustomerID)
    VALUES (bookdate, tableNum, fk_c);
    
    SELECT COUNT(*) INTO existingBookings
    FROM bookings
    WHERE bookingDate = bookdate
      AND tableNumber = tableNum;
    

    IF existingBookings > 1 THEN
        
        ROLLBACK;
        SELECT CONCAT('Table ', tableNum, ' is already booked - booking cancelled.') AS Status;
    ELSE
       
        COMMIT;
        SELECT CONCAT('Booking successful for table ', tableNum, '.') AS Status;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddValidBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbuser`@`%` PROCEDURE `AddValidBooking`( IN bookdate DATETIME,
    IN tableNum INT, IN fk_c INT )
BEGIN
	DECLARE existingBookings INT DEFAULT 0;
    
    START TRANSACTION;
    
    INSERT INTO bookings (bookingDate, tableNumber, fk_CustomerID)
    VALUES (bookdate, tableNum, fk_c);
    
    SELECT COUNT(*) INTO existingBookings
    FROM bookings
    WHERE bookingDate = bookdate
      AND tableNumber = tableNum;
    

    IF existingBookings > 1 THEN
        
        ROLLBACK;
        SELECT CONCAT('Table ', tableNum, ' is already booked - booking cancelled.') AS Status;
    ELSE
       
        COMMIT;
        SELECT CONCAT('Booking successful for table ', tableNum, '.') AS Status;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CancelBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbuser`@`%` PROCEDURE `CancelBooking`( in booking_id int)
BEGIN

	delete from bookings where bookings.bookingID = booking_id;
    SELECT CONCAT('booking ', booking_id, ' is cancelled.') AS Status;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CancelOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbuser`@`%` PROCEDURE `CancelOrder`(in orderid int)
BEGIN
	DELETE FROM orders WHERE orderID = orderid;
    SELECT CONCAT('Order ', order_id, ' is cancelled.') AS Confirmation;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CheckBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbuser`@`%` PROCEDURE `CheckBooking`(in bookdate datetime, in tableNum int)
BEGIN
	DECLARE tableStatus INT DEFAULT 0;
    
    -- Check if the table is already booked on the specified date
    SELECT COUNT(*) INTO tableStatus
    FROM bookings
    WHERE bookingDate = bookdate
    AND tableNumber = tableNum;
    
    -- Return the booking status
    IF tableStatus > 0 THEN
        SELECT CONCAT('Table ', tableNum, ' is already booked on ', bookdate, '.') AS Status;
    ELSE
        SELECT CONCAT('Table ', tableNum, ' is available on ', bookdate, '.') AS Status;
    END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetMaxQuantity` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbuser`@`%` PROCEDURE `GetMaxQuantity`()
BEGIN
	select max(quantity) 
    from orders inner join menuorderdetail on orders.orderID = menuorderdetail.fk_orderID; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateBooking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbuser`@`%` PROCEDURE `UpdateBooking`(in bookingid int, in bookdate datetime)
BEGIN

	update bookings set bookings.bookingDate = bookdate where bookings.bookingID =  bookingid;
    SELECT CONCAT('Bokking ', bookingid, ' updated.') AS Status;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `ordersview`
--

/*!50001 DROP VIEW IF EXISTS `ordersview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbuser`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `ordersview` AS select `orders`.`orderID` AS `orderID`,`menuorderdetail`.`quantity` AS `quantity`,`orders`.`totalCost` AS `totalCost` from (`orders` join `menuorderdetail` on((`orders`.`orderID` = `menuorderdetail`.`fk_orderID`))) */;
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

-- Dump completed on 2025-01-31 14:59:49
