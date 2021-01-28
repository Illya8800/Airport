/*
 Navicat Premium Data Transfer

 Source Server         : MyBD
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : 195.88.72.7:3306
 Source Schema         : i.s.hopak

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 29/01/2021 00:25:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for aircrafts
-- ----------------------------
DROP TABLE IF EXISTS `aircrafts`;
CREATE TABLE `aircrafts`  (
  `aircraft_code` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `range1` int NOT NULL,
  PRIMARY KEY (`aircraft_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of aircrafts
-- ----------------------------

-- ----------------------------
-- Table structure for airports
-- ----------------------------
DROP TABLE IF EXISTS `airports`;
CREATE TABLE `airports`  (
  `airport_code` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `airport_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `timezone` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`airport_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of airports
-- ----------------------------

-- ----------------------------
-- Table structure for boarding_passes
-- ----------------------------
DROP TABLE IF EXISTS `boarding_passes`;
CREATE TABLE `boarding_passes`  (
  `ticket_no` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `flight_id` int NOT NULL,
  `boarding_no` int NOT NULL,
  `seat_no` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ticket_no`, `flight_id`) USING BTREE,
  CONSTRAINT `boarding_passes_ibfk_1` FOREIGN KEY (`ticket_no`, `flight_id`) REFERENCES `ticket_flights` (`ticket_no`, `flight_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of boarding_passes
-- ----------------------------

-- ----------------------------
-- Table structure for bookings
-- ----------------------------
DROP TABLE IF EXISTS `bookings`;
CREATE TABLE `bookings`  (
  `book_ref` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `book_date` timestamp NOT NULL,
  `total_amount` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`book_ref`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bookings
-- ----------------------------

-- ----------------------------
-- Table structure for flights
-- ----------------------------
DROP TABLE IF EXISTS `flights`;
CREATE TABLE `flights`  (
  `flight_id` int NOT NULL,
  `flight_no` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `scheduled_departure` timestamp NOT NULL,
  `scheduled_arrival` timestamp NOT NULL,
  `departure_airport` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `arrival_airport` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_f` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `aircraft_code` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `actual_departure` timestamp NULL DEFAULT NULL,
  `actual_arrival` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`flight_id`) USING BTREE,
  INDEX `aircraft_code`(`aircraft_code`) USING BTREE,
  INDEX `arrival_airport`(`arrival_airport`) USING BTREE,
  INDEX `departure_airport`(`departure_airport`) USING BTREE,
  CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`aircraft_code`) REFERENCES `aircrafts` (`aircraft_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`aircraft_code`) REFERENCES `aircrafts` (`aircraft_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`arrival_airport`) REFERENCES `airports` (`airport_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `flights_ibfk_4` FOREIGN KEY (`departure_airport`) REFERENCES `airports` (`airport_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `flights_ibfk_5` FOREIGN KEY (`aircraft_code`) REFERENCES `aircrafts` (`aircraft_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `flights_ibfk_6` FOREIGN KEY (`arrival_airport`) REFERENCES `airports` (`airport_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `flights_ibfk_7` FOREIGN KEY (`departure_airport`) REFERENCES `airports` (`airport_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flights
-- ----------------------------

-- ----------------------------
-- Table structure for flights_rate
-- ----------------------------
DROP TABLE IF EXISTS `flights_rate`;
CREATE TABLE `flights_rate`  (
  `aircraft_code` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seat_no` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `flight_id` int NOT NULL,
  `id_rate` int NOT NULL,
  INDEX `aircraft_code`(`aircraft_code`) USING BTREE,
  INDEX `seat_no`(`seat_no`) USING BTREE,
  INDEX `flight_id`(`flight_id`) USING BTREE,
  INDEX `id_rate`(`id_rate`) USING BTREE,
  CONSTRAINT `flights_rate_ibfk_1` FOREIGN KEY (`aircraft_code`) REFERENCES `aircrafts` (`aircraft_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `flights_rate_ibfk_2` FOREIGN KEY (`seat_no`) REFERENCES `ticket_flights` (`ticket_no`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `flights_rate_ibfk_3` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `flights_rate_ibfk_4` FOREIGN KEY (`id_rate`) REFERENCES `rate` (`id_rate`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of flights_rate
-- ----------------------------

-- ----------------------------
-- Table structure for lr4
-- ----------------------------
DROP TABLE IF EXISTS `lr4`;
CREATE TABLE `lr4`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lr4
-- ----------------------------

-- ----------------------------
-- Table structure for lr4z2
-- ----------------------------
DROP TABLE IF EXISTS `lr4z2`;
CREATE TABLE `lr4z2`  (
  `FIO` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `PayName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `UAH` int NULL DEFAULT NULL,
  `PayId` int NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lr4z2
-- ----------------------------
INSERT INTO `lr4z2` VALUES ('Crew A. I. ', 'Water', 38, 100);
INSERT INTO `lr4z2` VALUES ('Crew A. I. ', 'SecurityServices', 500, 114);
INSERT INTO `lr4z2` VALUES ('Crew A. I. ', 'Water', 23, 100);
INSERT INTO `lr4z2` VALUES ('Firth J. S. ', 'Gas', 45, 101);
INSERT INTO `lr4z2` VALUES ('Macros K. M. ', 'Water', 37, 100);
INSERT INTO `lr4z2` VALUES ('Turol V. E. ', 'ColdWater', 37, 103);
INSERT INTO `lr4z2` VALUES ('Irden T. V. ', 'Water', 39, 100);
INSERT INTO `lr4z2` VALUES ('Wex I. K. ', 'Trash', 39, 105);
INSERT INTO `lr4z2` VALUES ('Exort I. S. ', 'Heating', 25, 106);
INSERT INTO `lr4z2` VALUES ('Whither V. I. ', 'Water', 51, 100);
INSERT INTO `lr4z2` VALUES ('Loopin K. V. ', 'Rent', 40, 108);
INSERT INTO `lr4z2` VALUES ('Chick V. B. ', 'Coal', 34, 109);
INSERT INTO `lr4z2` VALUES ('Gray E. S. ', 'WooddenCoal', 30, 110);
INSERT INTO `lr4z2` VALUES ('Hopin I. V. ', 'Lift', 38, 111);
INSERT INTO `lr4z2` VALUES ('Iriya I. A. ', 'Repairs', 24, 112);
INSERT INTO `lr4z2` VALUES ('Crew A. I. ', 'Water', 38, 100);
INSERT INTO `lr4z2` VALUES ('Crew A. I. ', 'SecurityServices', 500, 114);
INSERT INTO `lr4z2` VALUES ('Crew A. I. ', 'Water', 23, 100);
INSERT INTO `lr4z2` VALUES ('Firth J. S. ', 'Gas', 45, 101);
INSERT INTO `lr4z2` VALUES ('Macros K. M. ', 'Water', 37, 100);
INSERT INTO `lr4z2` VALUES ('Turol V. E. ', 'ColdWater', 37, 103);
INSERT INTO `lr4z2` VALUES ('Irden T. V. ', 'Water', 39, 100);
INSERT INTO `lr4z2` VALUES ('Wex I. K. ', 'Trash', 39, 105);
INSERT INTO `lr4z2` VALUES ('Exort I. S. ', 'Heating', 25, 106);
INSERT INTO `lr4z2` VALUES ('Whither V. I. ', 'Water', 51, 100);
INSERT INTO `lr4z2` VALUES ('Loopin K. V. ', 'Rent', 40, 108);
INSERT INTO `lr4z2` VALUES ('Chick V. B. ', 'Coal', 34, 109);
INSERT INTO `lr4z2` VALUES ('Gray E. S. ', 'WooddenCoal', 30, 110);
INSERT INTO `lr4z2` VALUES ('Hopin I. V. ', 'Lift', 38, 111);
INSERT INTO `lr4z2` VALUES ('Iriya I. A. ', 'Repairs', 24, 112);

-- ----------------------------
-- Table structure for rate
-- ----------------------------
DROP TABLE IF EXISTS `rate`;
CREATE TABLE `rate`  (
  `id_rate` int NOT NULL,
  `rate_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate_cost` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`id_rate`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rate
-- ----------------------------

-- ----------------------------
-- Table structure for seats
-- ----------------------------
DROP TABLE IF EXISTS `seats`;
CREATE TABLE `seats`  (
  `aircraft_code` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `seat_no` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fare_conditions` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`aircraft_code`, `seat_no`) USING BTREE,
  INDEX `seat_no`(`seat_no`) USING BTREE,
  CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`aircraft_code`) REFERENCES `aircrafts` (`aircraft_code`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `seats_ibfk_2` FOREIGN KEY (`aircraft_code`) REFERENCES `aircrafts` (`aircraft_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `seats_ibfk_3` FOREIGN KEY (`aircraft_code`) REFERENCES `aircrafts` (`aircraft_code`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `seats_ibfk_4` FOREIGN KEY (`aircraft_code`) REFERENCES `aircrafts` (`aircraft_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `seats_ibfk_5` FOREIGN KEY (`aircraft_code`) REFERENCES `aircrafts` (`aircraft_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `seats_ibfk_6` FOREIGN KEY (`seat_no`) REFERENCES `ticket_flights` (`ticket_no`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of seats
-- ----------------------------

-- ----------------------------
-- Table structure for tenantmadeutilitypayment
-- ----------------------------
DROP TABLE IF EXISTS `tenantmadeutilitypayment`;
CREATE TABLE `tenantmadeutilitypayment`  (
  `Receipt_id` int NOT NULL,
  `DateOfPay` date NULL DEFAULT NULL,
  `PersonalAccount` int UNSIGNED NULL DEFAULT NULL,
  `Payment_id` int UNSIGNED NOT NULL,
  `Paid_UAH` decimal(5, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`Receipt_id`) USING BTREE,
  INDEX `tenantmadeutilitypayment`(`PersonalAccount`) USING BTREE,
  INDEX `Payment_id`(`Payment_id`) USING BTREE,
  CONSTRAINT `tenantmadeutilitypayment` FOREIGN KEY (`PersonalAccount`) REFERENCES `tenants` (`PersonalAccount`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tenantmadeutilitypayment_ibfk_1` FOREIGN KEY (`Payment_id`) REFERENCES `typesofutilitypayments` (`Payment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenantmadeutilitypayment
-- ----------------------------
INSERT INTO `tenantmadeutilitypayment` VALUES (1, '2020-09-03', 44098, 100, 38.00);
INSERT INTO `tenantmadeutilitypayment` VALUES (2, '2020-10-05', 44099, 101, 45.47);
INSERT INTO `tenantmadeutilitypayment` VALUES (3, '2020-08-21', 44100, 100, 36.50);
INSERT INTO `tenantmadeutilitypayment` VALUES (4, '2020-09-30', 44101, 103, 37.43);
INSERT INTO `tenantmadeutilitypayment` VALUES (5, '2020-09-28', 44102, 100, 39.36);
INSERT INTO `tenantmadeutilitypayment` VALUES (6, '2020-09-03', 44103, 105, 39.00);
INSERT INTO `tenantmadeutilitypayment` VALUES (7, '2020-10-07', 44104, 106, 25.00);
INSERT INTO `tenantmadeutilitypayment` VALUES (8, '2020-11-09', 44105, 100, 50.98);
INSERT INTO `tenantmadeutilitypayment` VALUES (9, '2020-09-10', 44106, 108, 40.40);
INSERT INTO `tenantmadeutilitypayment` VALUES (10, '2020-08-13', 44107, 109, 33.76);
INSERT INTO `tenantmadeutilitypayment` VALUES (11, '2020-10-23', 44108, 110, 29.66);
INSERT INTO `tenantmadeutilitypayment` VALUES (12, '2020-11-24', 44109, 111, 38.00);
INSERT INTO `tenantmadeutilitypayment` VALUES (13, '2020-09-26', 44110, 112, 24.00);
INSERT INTO `tenantmadeutilitypayment` VALUES (14, '2020-09-15', 44111, 113, 38.50);
INSERT INTO `tenantmadeutilitypayment` VALUES (15, '2020-08-15', 44112, 114, 40.00);
INSERT INTO `tenantmadeutilitypayment` VALUES (16, '2020-12-12', 44098, 114, 500.00);
INSERT INTO `tenantmadeutilitypayment` VALUES (17, '2020-11-01', 44098, 100, 23.00);
INSERT INTO `tenantmadeutilitypayment` VALUES (18, '2020-11-25', 44099, 100, 105.00);
INSERT INTO `tenantmadeutilitypayment` VALUES (19, '2020-12-26', 44099, 100, 23.00);

-- ----------------------------
-- Table structure for tenants
-- ----------------------------
DROP TABLE IF EXISTS `tenants`;
CREATE TABLE `tenants`  (
  `PersonalAccount` int UNSIGNED NOT NULL,
  `SecondName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `FirstName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Patronymic` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `AmountOfRegisteredPeople` tinyint UNSIGNED NULL DEFAULT NULL,
  `Privilege` int NULL DEFAULT NULL,
  PRIMARY KEY (`PersonalAccount`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenants
-- ----------------------------
INSERT INTO `tenants` VALUES (44098, 'Crew', 'Alexey', 'Igorevich', 2, 5);
INSERT INTO `tenants` VALUES (44099, 'Firth', 'John', 'Sergeevich', 1, 1);
INSERT INTO `tenants` VALUES (44100, 'Macros', 'Karl', 'Marsovich', 3, 6);
INSERT INTO `tenants` VALUES (44101, 'Turol', 'Veronika', 'Eduardovna', 1, 13);
INSERT INTO `tenants` VALUES (44102, 'Irden', 'Tatyana', 'Viktorovna', 2, 0);
INSERT INTO `tenants` VALUES (44103, 'Wex', 'Igor', 'Kilimov', 2, 0);
INSERT INTO `tenants` VALUES (44104, 'Exort', 'Inna', 'Sergeevna', 3, 30);
INSERT INTO `tenants` VALUES (44105, 'Whither', 'Vladimir', 'Ilich', 2, 15);
INSERT INTO `tenants` VALUES (44106, 'Loopin', 'Kostya', 'Vyacheslavovich', 3, 17);
INSERT INTO `tenants` VALUES (44107, 'Chick', 'Vladislav', 'Bogdanovich', 1, 0);
INSERT INTO `tenants` VALUES (44108, 'Gray', 'Egor', 'Sergeevich', 4, 10);
INSERT INTO `tenants` VALUES (44109, 'Hopin', 'Ilya', 'Vasilevich', 2, 3);
INSERT INTO `tenants` VALUES (44110, 'Iriya', 'Inna', 'Antonovna', 2, 4);
INSERT INTO `tenants` VALUES (44111, 'Kai`sa', 'Darya', 'Antonovna', 1, 1);
INSERT INTO `tenants` VALUES (44112, 'Fillit', 'Nastya', 'Igorevna', 1, 12);
INSERT INTO `tenants` VALUES (44113, 'Krue', 'Vasiliy', 'Frenkov', 4, 0);

-- ----------------------------
-- Table structure for ticket_flights
-- ----------------------------
DROP TABLE IF EXISTS `ticket_flights`;
CREATE TABLE `ticket_flights`  (
  `ticket_no` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `flight_id` int NOT NULL,
  `fare_conditions` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10, 2) NOT NULL,
  PRIMARY KEY (`ticket_no`, `flight_id`) USING BTREE,
  INDEX `flight_id`(`flight_id`) USING BTREE,
  CONSTRAINT `ticket_flights_ibfk_1` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ticket_flights_ibfk_2` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ticket_flights_ibfk_3` FOREIGN KEY (`flight_id`) REFERENCES `flights` (`flight_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ticket_flights_ibfk_4` FOREIGN KEY (`ticket_no`) REFERENCES `tickets` (`ticket_no`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ticket_flights
-- ----------------------------

-- ----------------------------
-- Table structure for tickets
-- ----------------------------
DROP TABLE IF EXISTS `tickets`;
CREATE TABLE `tickets`  (
  `ticket_no` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `book_ref` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `passenger_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `passenger_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_data` json NULL,
  PRIMARY KEY (`ticket_no`) USING BTREE,
  INDEX `book_ref`(`book_ref`) USING BTREE,
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`book_ref`) REFERENCES `bookings` (`book_ref`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`book_ref`) REFERENCES `bookings` (`book_ref`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tickets
-- ----------------------------

-- ----------------------------
-- Table structure for typesofutilitypayments
-- ----------------------------
DROP TABLE IF EXISTS `typesofutilitypayments`;
CREATE TABLE `typesofutilitypayments`  (
  `Payment_id` int UNSIGNED NOT NULL,
  `PaymentName` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `PaymentPerMonthForOnePerson_UAH` decimal(5, 2) NULL DEFAULT NULL,
  `TRIGG` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `paimentsum` decimal(6, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`Payment_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of typesofutilitypayments
-- ----------------------------
INSERT INTO `typesofutilitypayments` VALUES (100, 'Water', 18.25, ' 561.00; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (101, 'Gas', 37.43, ' 64.80; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (102, 'Electric', 39.36, ' 64.80; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (103, 'ColdWater', 13.12, ' 37.43; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (104, 'HotWater', 19.00, ' 62.75; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (105, 'Trash', 13.00, ' 65.53; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (106, 'Heating', 25.00, ' 156.72; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (107, 'Intercom', 50.98, ' 150.00; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (108, 'Rent', 10.10, ' 40.40; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (109, 'Coal', 33.76, ' 33.76; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (110, 'WooddenCoal', 29.66, ' 29.66; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (111, 'Lift', 38.00, '0', NULL);
INSERT INTO `typesofutilitypayments` VALUES (112, 'Repairs', 8.00, ' 24.00; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (113, 'Signalization', 14.25, ' 38.50; ', NULL);
INSERT INTO `typesofutilitypayments` VALUES (114, 'SecurityServices', 20.00, ' 40.00; ', NULL);

-- ----------------------------
-- Table structure for typesofutilitypayments_log
-- ----------------------------
DROP TABLE IF EXISTS `typesofutilitypayments_log`;
CREATE TABLE `typesofutilitypayments_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `time` timestamp NULL DEFAULT NULL,
  `action` enum('DELETE','INSERT','UPDATE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Pay_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Pay_Name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `Pay_Per_Month` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 179 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of typesofutilitypayments_log
-- ----------------------------
INSERT INTO `typesofutilitypayments_log` VALUES (7, 'i.s.hopak@176.101.200.228', '2020-12-17 00:58:01', 'UPDATE', '116', 'RR', '24.00');
INSERT INTO `typesofutilitypayments_log` VALUES (8, 'i.s.hopak@176.101.200.228', '2020-12-17 00:58:01', 'INSERT', '116', 'RR', '24.00');
INSERT INTO `typesofutilitypayments_log` VALUES (9, 'i.s.hopak@176.101.200.228', '2020-12-17 00:59:35', 'INSERT', '115', 'RTW', '56.00');
INSERT INTO `typesofutilitypayments_log` VALUES (10, 'i.s.hopak@176.101.200.228', '2020-12-17 00:59:35', 'UPDATE', '115', 'RTW', '56.00');
INSERT INTO `typesofutilitypayments_log` VALUES (11, 'i.s.hopak@176.101.200.228', '2020-12-17 01:00:11', 'UPDATE', '115', 'WERTTYzu', '56.00');
INSERT INTO `typesofutilitypayments_log` VALUES (12, 'i.s.hopak@176.101.200.228', '2020-12-17 01:02:28', 'INSERT', '115', 'SSSSSS', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (13, 'i.s.hopak@176.101.200.228', '2020-12-17 01:02:43', 'DELETE', '115', 'SSSSSS', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (14, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (15, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '101', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (16, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '102', 'Electric', '39.36');
INSERT INTO `typesofutilitypayments_log` VALUES (17, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '103', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (18, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '104', 'HotWater', '19.00');
INSERT INTO `typesofutilitypayments_log` VALUES (19, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '105', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (20, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (21, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '107', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (22, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '108', 'Rent', '10.10');
INSERT INTO `typesofutilitypayments_log` VALUES (23, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '109', 'Coal', '33.76');
INSERT INTO `typesofutilitypayments_log` VALUES (24, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '110', 'WooddenCoal', '29.66');
INSERT INTO `typesofutilitypayments_log` VALUES (25, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '111', 'Lift', '38.00');
INSERT INTO `typesofutilitypayments_log` VALUES (26, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '112', 'Repairs', '8.00');
INSERT INTO `typesofutilitypayments_log` VALUES (27, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (28, 'i.s.hopak@176.101.200.228', '2020-12-17 03:30:55', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (29, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (30, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '101', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (31, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '102', 'Electric', '39.36');
INSERT INTO `typesofutilitypayments_log` VALUES (32, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '103', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (33, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '104', 'HotWater', '19.00');
INSERT INTO `typesofutilitypayments_log` VALUES (34, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '105', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (35, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (36, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '107', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (37, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '108', 'Rent', '10.10');
INSERT INTO `typesofutilitypayments_log` VALUES (38, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '109', 'Coal', '33.76');
INSERT INTO `typesofutilitypayments_log` VALUES (39, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '110', 'WooddenCoal', '29.66');
INSERT INTO `typesofutilitypayments_log` VALUES (40, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '111', 'Lift', '38.00');
INSERT INTO `typesofutilitypayments_log` VALUES (41, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '112', 'Repairs', '8.00');
INSERT INTO `typesofutilitypayments_log` VALUES (42, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (43, 'i.s.hopak@176.101.200.228', '2020-12-17 03:31:44', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (44, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (45, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '101', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (46, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '102', 'Electric', '39.36');
INSERT INTO `typesofutilitypayments_log` VALUES (47, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '103', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (48, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '104', 'HotWater', '19.00');
INSERT INTO `typesofutilitypayments_log` VALUES (49, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '105', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (50, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (51, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '107', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (52, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '108', 'Rent', '10.10');
INSERT INTO `typesofutilitypayments_log` VALUES (53, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '109', 'Coal', '33.76');
INSERT INTO `typesofutilitypayments_log` VALUES (54, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '110', 'WooddenCoal', '29.66');
INSERT INTO `typesofutilitypayments_log` VALUES (55, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '111', 'Lift', '38.00');
INSERT INTO `typesofutilitypayments_log` VALUES (56, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '112', 'Repairs', '8.00');
INSERT INTO `typesofutilitypayments_log` VALUES (57, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (58, 'i.s.hopak@176.101.200.228', '2020-12-17 03:33:34', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (59, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (60, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '101', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (61, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '102', 'Electric', '39.36');
INSERT INTO `typesofutilitypayments_log` VALUES (62, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '103', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (63, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '104', 'HotWater', '19.00');
INSERT INTO `typesofutilitypayments_log` VALUES (64, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '105', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (65, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (66, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '107', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (67, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '108', 'Rent', '10.10');
INSERT INTO `typesofutilitypayments_log` VALUES (68, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '109', 'Coal', '33.76');
INSERT INTO `typesofutilitypayments_log` VALUES (69, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '110', 'WooddenCoal', '29.66');
INSERT INTO `typesofutilitypayments_log` VALUES (70, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '111', 'Lift', '38.00');
INSERT INTO `typesofutilitypayments_log` VALUES (71, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '112', 'Repairs', '8.00');
INSERT INTO `typesofutilitypayments_log` VALUES (72, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (73, 'i.s.hopak@176.101.200.228', '2020-12-17 03:34:31', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (74, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '7', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (75, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '7', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (76, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '7', 'Electric', '39.36');
INSERT INTO `typesofutilitypayments_log` VALUES (77, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '7', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (78, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '7', 'HotWater', '19.00');
INSERT INTO `typesofutilitypayments_log` VALUES (79, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '7', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (80, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '7', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (81, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '7', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (82, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '108', 'Rent', '10.10');
INSERT INTO `typesofutilitypayments_log` VALUES (83, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '109', 'Coal', '33.76');
INSERT INTO `typesofutilitypayments_log` VALUES (84, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '110', 'WooddenCoal', '29.66');
INSERT INTO `typesofutilitypayments_log` VALUES (85, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '111', 'Lift', '38.00');
INSERT INTO `typesofutilitypayments_log` VALUES (86, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '112', 'Repairs', '8.00');
INSERT INTO `typesofutilitypayments_log` VALUES (87, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (88, 'i.s.hopak@176.101.200.228', '2020-12-17 03:36:39', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (89, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (90, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '101', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (91, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '102', 'Electric', '39.36');
INSERT INTO `typesofutilitypayments_log` VALUES (92, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '103', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (93, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '104', 'HotWater', '19.00');
INSERT INTO `typesofutilitypayments_log` VALUES (94, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '105', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (95, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (96, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '107', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (97, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '108', 'Rent', '10.10');
INSERT INTO `typesofutilitypayments_log` VALUES (98, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '109', 'Coal', '33.76');
INSERT INTO `typesofutilitypayments_log` VALUES (99, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '110', 'WooddenCoal', '29.66');
INSERT INTO `typesofutilitypayments_log` VALUES (100, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '111', 'Lift', '38.00');
INSERT INTO `typesofutilitypayments_log` VALUES (101, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '112', 'Repairs', '8.00');
INSERT INTO `typesofutilitypayments_log` VALUES (102, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (103, 'i.s.hopak@176.101.200.228', '2020-12-17 03:39:24', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (104, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (105, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '101', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (106, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '102', 'Electric', '39.36');
INSERT INTO `typesofutilitypayments_log` VALUES (107, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '103', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (108, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '104', 'HotWater', '19.00');
INSERT INTO `typesofutilitypayments_log` VALUES (109, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '105', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (110, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (111, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '107', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (112, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '108', 'Rent', '10.10');
INSERT INTO `typesofutilitypayments_log` VALUES (113, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '109', 'Coal', '33.76');
INSERT INTO `typesofutilitypayments_log` VALUES (114, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '110', 'WooddenCoal', '29.66');
INSERT INTO `typesofutilitypayments_log` VALUES (115, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '111', 'Lift', '38.00');
INSERT INTO `typesofutilitypayments_log` VALUES (116, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '112', 'Repairs', '8.00');
INSERT INTO `typesofutilitypayments_log` VALUES (117, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (118, 'i.s.hopak@176.101.200.228', '2020-12-17 03:40:14', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (119, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (120, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '101', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (121, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '102', 'Electric', '39.36');
INSERT INTO `typesofutilitypayments_log` VALUES (122, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '103', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (123, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '104', 'HotWater', '19.00');
INSERT INTO `typesofutilitypayments_log` VALUES (124, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '105', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (125, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (126, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '107', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (127, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '108', 'Rent', '10.10');
INSERT INTO `typesofutilitypayments_log` VALUES (128, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '109', 'Coal', '33.76');
INSERT INTO `typesofutilitypayments_log` VALUES (129, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '110', 'WooddenCoal', '29.66');
INSERT INTO `typesofutilitypayments_log` VALUES (130, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '111', 'Lift', '38.00');
INSERT INTO `typesofutilitypayments_log` VALUES (131, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '112', 'Repairs', '8.00');
INSERT INTO `typesofutilitypayments_log` VALUES (132, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (133, 'i.s.hopak@176.101.200.228', '2020-12-17 03:42:31', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (134, 'i.s.hopak@176.101.200.228', '2020-12-17 03:44:26', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (135, 'i.s.hopak@176.101.200.228', '2020-12-17 03:45:07', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (136, 'i.s.hopak@176.101.200.228', '2020-12-17 03:45:32', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (137, 'i.s.hopak@176.101.200.228', '2020-12-17 03:45:45', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (138, 'i.s.hopak@176.101.200.228', '2020-12-17 03:45:48', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (139, 'i.s.hopak@176.101.200.228', '2020-12-17 03:45:50', 'UPDATE', '114', 'SecurityServices', '20.00');
INSERT INTO `typesofutilitypayments_log` VALUES (140, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:00', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (141, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:04', 'UPDATE', '113', 'Signalization', '14.25');
INSERT INTO `typesofutilitypayments_log` VALUES (142, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:08', 'UPDATE', '112', 'Repairs', '8.00');
INSERT INTO `typesofutilitypayments_log` VALUES (143, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:10', 'UPDATE', '112', 'Repairs', '8.00');
INSERT INTO `typesofutilitypayments_log` VALUES (144, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:22', 'UPDATE', '110', 'WooddenCoal', '29.66');
INSERT INTO `typesofutilitypayments_log` VALUES (145, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:24', 'UPDATE', '110', 'WooddenCoal', '29.66');
INSERT INTO `typesofutilitypayments_log` VALUES (146, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:27', 'UPDATE', '109', 'Coal', '33.76');
INSERT INTO `typesofutilitypayments_log` VALUES (147, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:28', 'UPDATE', '109', 'Coal', '33.76');
INSERT INTO `typesofutilitypayments_log` VALUES (148, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:34', 'UPDATE', '108', 'Rent', '10.10');
INSERT INTO `typesofutilitypayments_log` VALUES (149, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:37', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (150, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:38', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (151, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:42', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (152, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:43', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (153, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:45', 'UPDATE', '105', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (154, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:47', 'UPDATE', '105', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (155, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:50', 'UPDATE', '103', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (156, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:52', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (157, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:53', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (158, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:56', 'UPDATE', '103', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (159, 'i.s.hopak@176.101.200.228', '2020-12-17 03:46:59', 'UPDATE', '103', 'ColdWater', '13.12');
INSERT INTO `typesofutilitypayments_log` VALUES (160, 'i.s.hopak@176.101.200.228', '2020-12-17 03:47:01', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (161, 'i.s.hopak@176.101.200.228', '2020-12-17 03:47:03', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (162, 'i.s.hopak@176.101.200.228', '2020-12-17 03:47:06', 'UPDATE', '101', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (163, 'i.s.hopak@176.101.200.228', '2020-12-17 03:47:08', 'UPDATE', '101', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (164, 'i.s.hopak@176.101.200.228', '2020-12-17 03:47:11', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (165, 'i.s.hopak@176.101.200.228', '2020-12-17 03:47:12', 'UPDATE', '100', 'Water', '18.25');
INSERT INTO `typesofutilitypayments_log` VALUES (166, 'i.s.hopak@176.101.200.228', '2020-12-17 03:47:21', 'UPDATE', '102', 'Electric', '39.36');
INSERT INTO `typesofutilitypayments_log` VALUES (167, 'i.s.hopak@176.101.200.228', '2020-12-17 03:47:22', 'UPDATE', '104', 'HotWater', '19.00');
INSERT INTO `typesofutilitypayments_log` VALUES (168, 'i.s.hopak@176.101.200.228', '2020-12-17 03:47:23', 'UPDATE', '107', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (169, 'i.s.hopak@176.101.200.228', '2020-12-17 03:47:24', 'UPDATE', '111', 'Lift', '38.00');
INSERT INTO `typesofutilitypayments_log` VALUES (170, 'i.s.hopak@176.101.200.228', '2020-12-17 03:56:16', 'UPDATE', '105', 'Trash', '13.00');
INSERT INTO `typesofutilitypayments_log` VALUES (171, 'i.s.hopak@176.101.200.228', '2020-12-17 08:50:14', 'UPDATE', '102', 'Electric', '39.36');
INSERT INTO `typesofutilitypayments_log` VALUES (172, 'i.s.hopak@176.101.200.228', '2020-12-17 08:51:55', 'UPDATE', '107', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (173, 'i.s.hopak@176.101.200.228', '2020-12-17 08:52:05', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (174, 'i.s.hopak@176.101.200.228', '2020-12-17 08:53:59', 'UPDATE', '101', 'Gas', '37.43');
INSERT INTO `typesofutilitypayments_log` VALUES (175, 'i.s.hopak@176.101.200.228', '2020-12-17 08:54:30', 'UPDATE', '104', 'HotWater', '19.00');
INSERT INTO `typesofutilitypayments_log` VALUES (176, 'i.s.hopak@176.101.200.228', '2020-12-17 08:54:57', 'UPDATE', '106', 'Heating', '25.00');
INSERT INTO `typesofutilitypayments_log` VALUES (177, 'i.s.hopak@176.101.200.228', '2020-12-17 09:10:48', 'UPDATE', '107', 'Intercom', '50.98');
INSERT INTO `typesofutilitypayments_log` VALUES (178, 'i.s.hopak@176.101.200.228', '2020-12-17 09:13:45', 'UPDATE', '104', 'HotWater', '19.00');

-- ----------------------------
-- Function structure for 4F
-- ----------------------------
DROP FUNCTION IF EXISTS `4F`;
delimiter ;;
CREATE FUNCTION `4F`(P_A INT)
 RETURNS varchar(100) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
BEGIN
	#Routine body goes here...
DECLARE Dof varchar(10);
Declare Ri varchar(30);
DECLARE res VARCHAR(100);
DECLARE done  INTEGER DEFAULT 0;


DECLARE cur CURSOR FOR
SELECT
	typesofutilitypayments.PaymentName,
	tenantmadeutilitypayment.DateOfPay,
	tenantmadeutilitypayment.Receipt_id 
FROM
	typesofutilitypayments
	INNER JOIN tenantmadeutilitypayment ON tenantmadeutilitypayment.Payment_id = typesofutilitypayments.Payment_id 
	
WHERE
PersonalAccount = P_A AND MONTH ( DateOfPay )>= MONTH ( NOW() )-1  ; 



DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' 
SET done=1;
OPEN cur;
WHILE done =0 DO
FETCH cur INTO res,Dof,Ri ;
IF DONE =1 THEN RETURN res;
END IF;
SET res = CONCAT("PayName :",res,", Date: ",Dof,", id: ",Ri);
END WHILE;
CLOSE cur;
RETURN res;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for 5F
-- ----------------------------
DROP FUNCTION IF EXISTS `5F`;
delimiter ;;
CREATE FUNCTION `5F`(nameF VARCHAR(15), Per_I INT)
 RETURNS longtext CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
BEGIN
	#Routine body goes here...
DECLARE Sname varchar(30);
Declare Fname varchar(30);
Declare ZPatronymic varchar(30);
DECLARE res VARCHAR(100);
DECLARE Res_Id VARCHAR(100);

DECLARE done  INTEGER DEFAULT 0;

DECLARE cur CURSOR FOR
SELECT
	tenants.SecondName,
	tenants.FirstName,
	tenants.Patronymic,
	tenantmadeutilitypayment.PersonalAccount,
	tenantmadeutilitypayment.Receipt_id
	FROM
	tenants
	INNER JOIN tenantmadeutilitypayment ON tenants.PersonalAccount = tenantmadeutilitypayment.PersonalAccount WHERE tenants.SecondName = nameF AND tenantmadeutilitypayment.PersonalAccount = Per_I;




DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' 
SET done=1;
OPEN cur;
WHILE done =0 DO
FETCH cur INTO Sname,Fname,ZPatronymic,Per_I,Res_Id ;
IF DONE =1 THEN RETURN res;
END IF;
SET res = CONCAT("SrcName :",Sname,", FirName: ",Fname,", Patron: ",ZPatronymic,"Pers_Account :",Per_I,"R_ID :",Res_Id);
END WHILE;
CLOSE cur;
RETURN res;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for Sec (Cur)
-- ----------------------------
DROP FUNCTION IF EXISTS `Sec (Cur)`;
delimiter ;;
CREATE FUNCTION `Sec (Cur)`(num VARCHAR ( 5 ), mm INT , mb INT)
 RETURNS varchar(100) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
BEGIN
	DECLARE done INT DEFAULT FALSE;
  DECLARE  res VARCHAR(100);
	DECLARE  SU VARCHAR(10);

	


	DECLARE cur CURSOR FOR
	SELECT  GROUP_CONCAT(Receipt_id,""), SUM(Paid_UAH)
	
	FROM tenantmadeutilitypayment 
  WHERE tenantmadeutilitypayment.PersonalAccount = num AND MONTH(DateOfPay)> mm AND MONTH(DateOfPay)<mb ;
	
	
	DECLARE  CONTINUE HANDLER FOR NOT FOUND SET DONE = TRUE;
	OPEN cur;
	
	FETCH NEXT FROM cur INTO res, SU;
	CLOSE cur;
	
	RETURN(res);
	
	END
;;
delimiter ;

-- ----------------------------
-- Function structure for Sec_True
-- ----------------------------
DROP FUNCTION IF EXISTS `Sec_True`;
delimiter ;;
CREATE FUNCTION `Sec_True`(num VARCHAR ( 5 ), mm INT , mb INT)
 RETURNS json
  READS SQL DATA 
  DETERMINISTIC
BEGIN
    DECLARE json_var JSON;
    SELECT JSON_OBJECT('Id: ', GROUP_CONCAT(Receipt_id,""), 'SUM =', SUM(Paid_UAH))
		 
   
        INTO json_var
        FROM tenantmadeutilitypayment
        WHERE tenantmadeutilitypayment.PersonalAccount = num AND MONTH(DateOfPay)> mm AND MONTH(DateOfPay)<mb ;
    RETURN json_var;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_first
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_first`;
delimiter ;;
CREATE PROCEDURE `sp_first`(IN `PI` int(5),IN `PN` varchar(25))
BEGIN
	
	SELECT PersonalAccount, PaymentName,SUBSTRING("", 1, 10)AS YourName,SUBSTRING("", 1, 10)AS YourSecName,SUBSTRING("", 1, 10)AS YourSignature,SUBSTRING("", 1, 10)AS Sum, DATE(NOW()) FROM tenantmadeutilitypayment INNER JOIN typesofutilitypayments ON tenantmadeutilitypayment.Payment_id = typesofutilitypayments.Payment_id
WHERE tenantmadeutilitypayment.PersonalAccount = PI AND
typesofutilitypayments.PaymentName = PN;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for Thi (Cur)
-- ----------------------------
DROP FUNCTION IF EXISTS `Thi (Cur)`;
delimiter ;;
CREATE FUNCTION `Thi (Cur)`(mm INT , mb INT)
 RETURNS varchar(500) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci
BEGIN
	DECLARE done INT DEFAULT FALSE;
  DECLARE  res VARCHAR(400);
	DECLARE  SU VARCHAR(10);
		
		
		
		
	DECLARE cur CURSOR FOR
	SELECT  GROUP_CONCAT(PaymentName ,""),SUM(Paid_UAH)
	
	FROM tenantmadeutilitypayment INNER JOIN typesofutilitypayments ON tenantmadeutilitypayment.Payment_id = typesofutilitypayments.Payment_id
  WHERE  MONTH(DateOfPay)> mm AND MONTH(DateOfPay)<mb ;
	
	
	DECLARE  CONTINUE HANDLER FOR NOT FOUND SET DONE = TRUE;
	OPEN cur;
	
	FETCH NEXT FROM cur INTO res, SU;
	CLOSE cur;
	
  RETURN(res);
	
END
;;
delimiter ;

-- ----------------------------
-- Function structure for Thi_True
-- ----------------------------
DROP FUNCTION IF EXISTS `Thi_True`;
delimiter ;;
CREATE FUNCTION `Thi_True`(mm INT , mb INT)
 RETURNS json
  READS SQL DATA 
  DETERMINISTIC
BEGIN
    DECLARE json_var JSON;
    SELECT JSON_OBJECT('PaymentName: ', GROUP_CONCAT(PaymentName ," "), 'SUM =', SUM(Paid_UAH))
		 
   
        INTO json_var
        FROM tenantmadeutilitypayment INNER JOIN typesofutilitypayments ON tenantmadeutilitypayment.Payment_id = typesofutilitypayments.Payment_id
        WHERE MONTH(DateOfPay)> mm AND MONTH(DateOfPay)<mb 
    ORDER BY PaymentName;
		RETURN json_var;
		
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tenantmadeutilitypayment
-- ----------------------------
DROP TRIGGER IF EXISTS `add_penalty`;
delimiter ;;
CREATE TRIGGER `add_penalty` BEFORE INSERT ON `tenantmadeutilitypayment` FOR EACH ROW SET NEW.Paid_UAH = NEW.Paid_UAH * (1 + CASE WHEN DAY(NEW.DateOfPay) > 15 
                                            THEN (DAY(NEW.DateOfPay) - 15) * 0.005
                                            ELSE 0
                                            END)
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tenantmadeutilitypayment
-- ----------------------------
DROP TRIGGER IF EXISTS `NEW_inc_2`;
delimiter ;;
CREATE TRIGGER `NEW_inc_2` BEFORE INSERT ON `tenantmadeutilitypayment` FOR EACH ROW BEGIN
	
		DECLARE NEW_id INT;
		SELECT tenantmadeutilitypayment.Receipt_id INTO NEW_id FROM tenantmadeutilitypayment ORDER BY tenantmadeutilitypayment.Receipt_id DESC LIMIT 1;	
		SET NEW.Receipt_id = NEW_id+1;
		
	END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tenantmadeutilitypayment
-- ----------------------------
DROP TRIGGER IF EXISTS `add_FIO`;
delimiter ;;
CREATE TRIGGER `add_FIO` AFTER INSERT ON `tenantmadeutilitypayment` FOR EACH ROW BEGIN
	
	/*DECLARE done integer default 0;
	DECLARE new_FIO VARCHAR(30);*/
	DECLARE psum DECIMAL(6,2);
	
	
	SELECT SUM(Paid_UAH) into psum FROM tenantmadeutilitypayment where tenantmadeutilitypayment.Payment_id=new.Payment_id;
	update typesofutilitypayments SET paimentsum=psum WHERE typesofutilitypayments.Payment_id=new.Payment_id;
	
	/*DECLARE cur CURSOR FOR 
	SELECT SUM(Paid_UAH) FROM tenantmadeutilitypayment INNER JOIN typesofutilitypayments ON tenantmadeutilitypayment.Payment_id = typesofutilitypayments.Payment_id WHERE tenantmadeutilitypayment.PersonalAccount = NEW.PersonalAccount;
	
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done=1;
	OPEN cur;
	
	WHILE done = 0 DO 
		FETCH cur INTO new_FIO;
	
		IF done = 1 THEN
				UPDATE typesofutilitypayments SET typesofutilitypayments.TRIGG = RESULT
				WHERE typesofutilitypayments.Payment_id=NEW.Payment_id;
		END IF;
		SET RESULT = CONCAT(RESULT, new_FIO, "; ");

	END WHILE;
	CLOSE cur;*/
	END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table tenants
-- ----------------------------
DROP TRIGGER IF EXISTS `NEW_inc_1`;
delimiter ;;
CREATE TRIGGER `NEW_inc_1` BEFORE INSERT ON `tenants` FOR EACH ROW BEGIN
	
		DECLARE NEW_id INT;
		/*SELECT tenants.PersonalAccount INTO NEW_id FROM tenants ORDER BY tenants.PersonalAccount DESC LIMIT 1;	*/
		SELECT max(tenants.PersonalAccount) INTO NEW_id FROM tenants;
		SET NEW.PersonalAccount = NEW_id+1;
		
	END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table typesofutilitypayments
-- ----------------------------
DROP TRIGGER IF EXISTS `NEW_inc`;
delimiter ;;
CREATE TRIGGER `NEW_inc` BEFORE INSERT ON `typesofutilitypayments` FOR EACH ROW BEGIN
	
		DECLARE NEW_id INT;
		SELECT typesofutilitypayments.Payment_id INTO NEW_id FROM typesofutilitypayments ORDER BY typesofutilitypayments.Payment_id DESC LIMIT 1;	
		SET NEW.Payment_id = NEW_id+1;
		
	END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table typesofutilitypayments
-- ----------------------------
DROP TRIGGER IF EXISTS `type_log_insert`;
delimiter ;;
CREATE TRIGGER `type_log_insert` AFTER INSERT ON `typesofutilitypayments` FOR EACH ROW BEGIN
	
	INSERT INTO typesofutilitypayments_log (`user`, `action`, `time`,  `Pay_id`, `Pay_Name`, `Pay_Per_Month`) 
	VALUES (USER(),"INSERT", CURRENT_TIMESTAMP, NEW.Payment_id, NEW.PaymentName, NEW.PaymentPerMonthForOnePerson_UAH);
	
	END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table typesofutilitypayments
-- ----------------------------
DROP TRIGGER IF EXISTS `type_log_update`;
delimiter ;;
CREATE TRIGGER `type_log_update` AFTER UPDATE ON `typesofutilitypayments` FOR EACH ROW BEGIN
	
	INSERT INTO typesofutilitypayments_log (`user`, `action`, `time`,  `Pay_id`, `Pay_Name`, `Pay_Per_Month`) 
	VALUES (USER(),"UPDATE", CURRENT_TIMESTAMP, NEW.Payment_id, NEW.PaymentName, NEW.PaymentPerMonthForOnePerson_UAH);
	
	END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table typesofutilitypayments
-- ----------------------------
DROP TRIGGER IF EXISTS `type_log_delete`;
delimiter ;;
CREATE TRIGGER `type_log_delete` AFTER DELETE ON `typesofutilitypayments` FOR EACH ROW BEGIN
	
	INSERT INTO typesofutilitypayments_log (`user`, `action`, `time`,  `Pay_id`, `Pay_Name`, `Pay_Per_Month`) 
	VALUES (USER(),"DELETE", CURRENT_TIMESTAMP, OLD.Payment_id, OLD.PaymentName, OLD.PaymentPerMonthForOnePerson_UAH);
	
	END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
