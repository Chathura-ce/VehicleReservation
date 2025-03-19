/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80031
Source Host           : localhost:3306
Source Database       : vehicle_reservation

Target Server Type    : MYSQL
Target Server Version : 80031
File Encoding         : 65001

Date: 2025-03-14 01:58:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for booking_status
-- ----------------------------
DROP TABLE IF EXISTS `booking_status`;
CREATE TABLE `booking_status` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(20) NOT NULL,
  PRIMARY KEY (`status_id`),
  UNIQUE KEY `status_name` (`status_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of booking_status
-- ----------------------------
INSERT INTO `booking_status` VALUES ('3', ' On the Way');
INSERT INTO `booking_status` VALUES ('2', 'Approved');
INSERT INTO `booking_status` VALUES ('4', 'Completed');
INSERT INTO `booking_status` VALUES ('1', 'Pending');

-- ----------------------------
-- Table structure for bookings
-- ----------------------------
DROP TABLE IF EXISTS `bookings`;
CREATE TABLE `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `booking_number` varchar(50) DEFAULT NULL,
  `customer_id` varchar(255) NOT NULL,
  `driver_id` varchar(50) DEFAULT NULL,
  `car_id` varchar(50) NOT NULL,
  `pickup_location` varchar(255) DEFAULT NULL,
  `destination` varchar(255) NOT NULL,
  `status_id` int NOT NULL,
  `price_for_km` decimal(10,2) DEFAULT NULL,
  `distance` decimal(10,2) DEFAULT NULL,
  `total_fare` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pickup_date` date DEFAULT NULL,
  `pickup_time` time DEFAULT NULL,
  PRIMARY KEY (`booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of bookings
-- ----------------------------
INSERT INTO `bookings` VALUES ('46', 'BK20250313-0046', 'CUST0106', 'd0110', 'C0001', 'Colombo, Colombo District, Western Province, Sri Lanka', 'Kurunegala, Kurunegala District, North Western Province, 60000, Sri Lanka', '1', '100.00', '83.00', '8300.00', '2025-03-13 11:28:58', '2025-03-13', '10:25:00');

-- ----------------------------
-- Table structure for car_image
-- ----------------------------
DROP TABLE IF EXISTS `car_image`;
CREATE TABLE `car_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `car_id` varchar(50) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of car_image
-- ----------------------------
INSERT INTO `car_image` VALUES ('1', 'C0001', '');
INSERT INTO `car_image` VALUES ('2', 'C0001', 'l.png');
INSERT INTO `car_image` VALUES ('3', 'C0003', '');
INSERT INTO `car_image` VALUES ('4', 'C0003', 'l.png');
INSERT INTO `car_image` VALUES ('5', 'C0005', '');
INSERT INTO `car_image` VALUES ('6', 'C0007', '');
INSERT INTO `car_image` VALUES ('7', '', '');
INSERT INTO `car_image` VALUES ('8', '', '');
INSERT INTO `car_image` VALUES ('9', 'C0010', '');
INSERT INTO `car_image` VALUES ('10', 'C0011', '');
INSERT INTO `car_image` VALUES ('11', 'C0012', '');

-- ----------------------------
-- Table structure for car_models
-- ----------------------------
DROP TABLE IF EXISTS `car_models`;
CREATE TABLE `car_models` (
  `model_id` int NOT NULL AUTO_INCREMENT,
  `model_name` varchar(50) NOT NULL,
  `type_id` int NOT NULL,
  PRIMARY KEY (`model_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `car_models_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `car_types` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of car_models
-- ----------------------------
INSERT INTO `car_models` VALUES ('1', 'Toyota Camry', '1');
INSERT INTO `car_models` VALUES ('2', 'Honda Accord', '1');
INSERT INTO `car_models` VALUES ('3', 'Ford Explorer', '2');
INSERT INTO `car_models` VALUES ('4', 'Jeep Wrangler', '2');
INSERT INTO `car_models` VALUES ('5', 'Volkswagen Golf', '3');
INSERT INTO `car_models` VALUES ('6', 'BMW 4 Series', '4');
INSERT INTO `car_models` VALUES ('7', 'Ford F-150', '5');
INSERT INTO `car_models` VALUES ('8', 'Tesla Model S', '1');
INSERT INTO `car_models` VALUES ('9', 'Chevrolet Tahoe', '2');
INSERT INTO `car_models` VALUES ('10', 'Mazda CX-5', '2');
INSERT INTO `car_models` VALUES ('11', 'Subaru Impreza', '3');
INSERT INTO `car_models` VALUES ('12', 'Porsche 911', '4');
INSERT INTO `car_models` VALUES ('13', 'Ram 1500', '5');

-- ----------------------------
-- Table structure for car_types
-- ----------------------------
DROP TABLE IF EXISTS `car_types`;
CREATE TABLE `car_types` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of car_types
-- ----------------------------
INSERT INTO `car_types` VALUES ('1', 'Sedan');
INSERT INTO `car_types` VALUES ('2', 'SUV');
INSERT INTO `car_types` VALUES ('3', 'Hatchback');
INSERT INTO `car_types` VALUES ('4', 'Convertible');
INSERT INTO `car_types` VALUES ('5', 'Truck');

-- ----------------------------
-- Table structure for cars
-- ----------------------------
DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `id` int NOT NULL AUTO_INCREMENT,
  `car_id` varchar(255) NOT NULL,
  `model` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `reg_number` varchar(20) NOT NULL,
  `capacity` int NOT NULL,
  `available` tinyint(1) DEFAULT '1',
  `driver_id` varchar(20) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `price_for_km` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reg_number` (`reg_number`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`driver_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of cars
-- ----------------------------
INSERT INTO `cars` VALUES ('1', 'C0001', '1', '1', 'ABC123', '5', '1', 'd0110', '/images/toyota_camry.jpg', '100.00');
INSERT INTO `cars` VALUES ('2', 'C0002', '2', '1', 'DEF456', '5', '0', 'D002', '/images/honda_accord.jpg', '98.00');
INSERT INTO `cars` VALUES ('3', 'C0003', '3', '2', 'GHI789', '7', '0', 'D003', '/images/ford_explorer.jpg', '130.00');
INSERT INTO `cars` VALUES ('4', 'C0004', '4', '2', 'JKL101', '4', '0', 'D004', '/images/jeep_wrangler.jpg', '135.00');
INSERT INTO `cars` VALUES ('5', 'C0005', '5', '3', 'MNO112', '5', '0', 'D005', '/images/vw_golf.jpg', '90.00');
INSERT INTO `cars` VALUES ('6', 'C0006', '6', '4', 'PQR131', '4', '0', 'D006', '/images/bmw_4series.jpg', '200.00');
INSERT INTO `cars` VALUES ('7', 'C0007', '7', '5', 'STU415', '3', '0', 'D007', '/images/ford_f150.jpg', '160.00');
INSERT INTO `cars` VALUES ('8', 'C0008', '8', '1', 'TES567', '5', '1', 'D008', '/images/tesla_model_s.jpg', '110.00');
INSERT INTO `cars` VALUES ('9', 'C0009', '9', '2', 'CHE789', '8', '0', 'D009', '/images/chevrolet_tahoe.jpg', '140.00');
INSERT INTO `cars` VALUES ('10', 'C0010', '10', '2', 'MAZ234', '5', '1', 'D010', '/images/mazda_cx5.jpg', '120.00');
INSERT INTO `cars` VALUES ('11', 'C0011', '11', '3', 'SUB456', '5', '0', 'D011', '/images/subaru_impreza.jpg', '95.00');
INSERT INTO `cars` VALUES ('12', 'C0012', '12', '4', 'POR911', '2', '1', 'D012', '/images/porsche_911.jpg', '250.00');
INSERT INTO `cars` VALUES ('13', 'C0013', '13', '5', 'RAM150', '3', '0', 'D013', '/images/ram_1500.jpg', '175.00');

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int NOT NULL,
  `address` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  KEY `customers_ibfk_1` (`user_id`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES ('63', 'CUST0095', '95', 'Irure sint est quam ', '2025-03-09 22:40:44');
INSERT INTO `customers` VALUES ('64', 'CUST0096', '96', 'Eu ea ratione accusa', '2025-03-12 09:39:17');
INSERT INTO `customers` VALUES ('65', 'CUST0102', '102', 'Sed hic aperiam ulla', '2025-03-12 09:39:41');
INSERT INTO `customers` VALUES ('66', 'CUST0103', '103', 'Elit distinctio In', '2025-03-12 09:40:32');
INSERT INTO `customers` VALUES ('67', 'CUST0104', '104', 'Magni dignissimos nu', '2025-03-12 10:50:13');
INSERT INTO `customers` VALUES ('68', 'CUST0105', '105', 'Rerum minim cupidata', '2025-03-12 11:50:29');
INSERT INTO `customers` VALUES ('69', 'CUST0106', '106', 'Magni dolor eu numqu', '2025-03-12 14:07:38');
INSERT INTO `customers` VALUES ('70', 'CUST0107', '107', 'Lorem qui iure eum a', '2025-03-13 08:52:30');
INSERT INTO `customers` VALUES ('71', 'CUST0111', '111', 'No 123, Test road', '2025-03-13 18:47:32');
INSERT INTO `customers` VALUES ('72', 'CUST0112', '112', 'No 56, abc road', '2025-03-13 18:54:16');

-- ----------------------------
-- Table structure for drivers
-- ----------------------------
DROP TABLE IF EXISTS `drivers`;
CREATE TABLE `drivers` (
  `user_id` int NOT NULL,
  `driver_id` varchar(20) NOT NULL,
  `license_number` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`driver_id`,`user_id`),
  UNIQUE KEY `license_number` (`license_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of drivers
-- ----------------------------
INSERT INTO `drivers` VALUES ('34', 'd0034', '462', '2025-02-22 17:45:01');
INSERT INTO `drivers` VALUES ('36', 'd0036', '59', '2025-02-22 17:45:34');
INSERT INTO `drivers` VALUES ('38', 'd0038', '734', '2025-02-22 17:47:43');
INSERT INTO `drivers` VALUES ('39', 'd0039', '768', '2025-02-22 17:48:02');
INSERT INTO `drivers` VALUES ('40', 'd0040', '795', '2025-02-22 17:50:18');
INSERT INTO `drivers` VALUES ('41', 'd0041', '929', '2025-02-22 17:52:07');
INSERT INTO `drivers` VALUES ('42', 'd0042', '158', '2025-02-22 17:52:28');
INSERT INTO `drivers` VALUES ('43', 'd0043', '369', '2025-02-22 17:55:54');
INSERT INTO `drivers` VALUES ('44', 'd0044', '976', '2025-02-22 17:58:33');
INSERT INTO `drivers` VALUES ('92', 'd0092', '808-5454-4545', '2025-03-08 10:31:19');
INSERT INTO `drivers` VALUES ('94', 'd0094', '376', '2025-03-08 10:51:50');
INSERT INTO `drivers` VALUES ('110', 'd0110', 'B1234567', '2025-03-13 10:44:03');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `role` enum('admin','customer','driver') NOT NULL DEFAULT 'customer',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('28', 'admin', 'Admin chathura', '4rKWDl1E+H5ZfHY18rLRK9TpPMOyU6d6EsOSqDzbDq4=', 'FV4/A6ZFiAp/97L62yEJaA==', '964515750v', '0457805450', 'admin@gmail.com', 'admin', '2025-02-20 19:20:36', '1');
INSERT INTO `users` VALUES ('95', 'ryfixib', 'Jocelyn Owens', '22CmYMOlQ8cHqTeE1VTXuCcu2YJAVilYgG+7r1JoJ7A=', 'vvcJZPEoEjGE2DbKMz9zkw==', null, null, 'chathu.eac@gmail.com', 'customer', '2025-03-09 22:40:43', '1');
INSERT INTO `users` VALUES ('96', 'juqodo', 'Rhiannon Sheppard', '6In1ppaPVBWoluLs62BqTeAy4l602cetAq0GAKgGpO0=', 'bGeKrnrf6NQCNw/OgqwBUA==', null, null, 'cynoti@mailinator.com', 'customer', '2025-03-12 09:39:16', '1');
INSERT INTO `users` VALUES ('102', 'hypikakaba', 'Jayme Beach', 'SUuhleGvpvuIawDfUhCHVmymSAQuRrygAHiVFOnSLms=', 'f7+JQwxlDMmjoAWam8vn9g==', null, null, 'voxuw@mailinator.com', 'customer', '2025-03-12 09:39:41', '1');
INSERT INTO `users` VALUES ('103', 'palasat', 'Shellie Wade', '5XI4Puc7kIEq2SN5cGqm5iprTZRIMf8q92NAMFs99kg=', 'MA+k9RsKQAQ5TjDou6RmuA==', null, null, 'tamapa@mailinator.com', 'customer', '2025-03-12 09:40:32', '1');
INSERT INTO `users` VALUES ('104', 'zetujecu', 'Camden Hanson', 'Oagl2735h1slFUOMdACKNBpLSaZM4R/4eOU9n5331Uw=', 'n/U+5+EVaJ0Z/rtdc51BkQ==', null, null, 'cikep@mailinator.com', 'customer', '2025-03-12 10:50:13', '1');
INSERT INTO `users` VALUES ('105', 'qyzunozug', 'Harding Sweeney', '4rKWDl1E+H5ZfHY18rLRK9TpPMOyU6d6EsOSqDzbDq4=', 'FV4/A6ZFiAp/97L62yEJaA==', null, null, 'qugog@mailinator.com', 'customer', '2025-03-12 11:50:29', '1');
INSERT INTO `users` VALUES ('106', 'dinuka25', 'Dinuka Dilshan', '+pAQ9qisVbzaKgCHvk8H3dElnFsVd1yIdMTAKcus4tQ=', 'u0xZphxG9yZNDCIOtX3EzA==', null, null, 'gyfadoxa@mailinator.com', 'customer', '2025-03-12 14:07:37', '1');
INSERT INTO `users` VALUES ('107', 'nakyqyny', 'Chase Crawford', 'b0Q0znKaiNHjYsIqOOufq5OJrCMEFEf7/8btciHWuuI=', 'AzpZhiTN+dQMlPLgffzoIg==', '915422580v', '0787325051', 'mycloud.eac@gmail.com', 'customer', '2025-03-13 08:52:30', '1');
INSERT INTO `users` VALUES ('110', 'ssss', 'Pradeep Kumara', 'tbqHu5w22OumFsOdrCSh102er6Aur2oGpL3yTsRFlL8=', 'qSUAXoppkGJMaMmq96vAng==', '956525452v', '0787325051', 'pradeepkumara@gmail.com', 'driver', '2025-03-13 10:44:03', '1');
INSERT INTO `users` VALUES ('111', 'TestUser', 'Todd Avila', 'lXmIcROIOi3qxRe4TREZKJHbAUm80SouiQ2LE33CfYg=', 'zcxcEK6ZVRTX/0zKOWOmPA==', '994885820v', '0754585025', 'test@mailinator.com', 'customer', '2025-03-13 18:47:32', '1');
INSERT INTO `users` VALUES ('112', 'Test2', 'Second test user', 'mH6nQaGIwu6w/AcTwQDyAAiwdK3uOm7EsuutTiEOIKs=', 'CZRIr4lj3PxXc7cMhX6Aug==', '985682250v', '0758265485', 'test3@mailinator.com', 'customer', '2025-03-13 18:54:16', '1');
