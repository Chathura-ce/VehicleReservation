/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 80031
Source Host           : localhost:3306
Source Database       : vehicle_reservation

Target Server Type    : MYSQL
Target Server Version : 80031
File Encoding         : 65001

Date: 2025-03-23 05:01:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for booking_status
-- ----------------------------
DROP TABLE IF EXISTS `booking_status`;
CREATE TABLE `booking_status` (
  `status_id` int NOT NULL AUTO_INCREMENT,
  `status_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`status_id`),
  UNIQUE KEY `status_name` (`status_name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of booking_status
-- ----------------------------
INSERT INTO `booking_status` VALUES ('0', 'Pending Payment', 'Booking created, Pending payment.');
INSERT INTO `booking_status` VALUES ('1', 'Pending', 'Payment done. Weiting driver approval.');
INSERT INTO `booking_status` VALUES ('4', 'In Progress', 'The ride has started.');
INSERT INTO `booking_status` VALUES ('5', 'Completed', 'The ride is finished.');
INSERT INTO `booking_status` VALUES ('6', 'Canceled by System', 'Booking was canceled by the admin.');
INSERT INTO `booking_status` VALUES ('7', 'Driver Canceled', 'The booking was canceled by the driver.');
INSERT INTO `booking_status` VALUES ('9', 'Customer Canceled', 'Booking was canceled by the customer.');

-- ----------------------------
-- Table structure for bookings
-- ----------------------------
DROP TABLE IF EXISTS `bookings`;
CREATE TABLE `bookings` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `booking_number` varchar(50) DEFAULT NULL,
  `customer_id` varchar(255) NOT NULL,
  `driver_id` varchar(50) DEFAULT NULL,
  `car_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `pickup_location` varchar(255) DEFAULT NULL,
  `destination` varchar(255) NOT NULL,
  `status_id` int DEFAULT NULL,
  `price_for_km` decimal(10,2) DEFAULT NULL,
  `distance` decimal(10,2) DEFAULT NULL,
  `total_fare` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pickup_date` date DEFAULT NULL,
  `pickup_time` time DEFAULT NULL,
  `is_paid` tinyint DEFAULT '0',
  PRIMARY KEY (`booking_id`),
  KEY `car_id` (`car_id`),
  KEY `driver_id` (`driver_id`),
  KEY `bookings_ibfk_1` (`status_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `booking_status` (`status_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`car_id`) REFERENCES `cars` (`car_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`driver_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of bookings
-- ----------------------------
INSERT INTO `bookings` VALUES ('65', 'BK20250322-0001', 'CUST0106', null, 'C0002', 'Gampaha, Gampaha District, Western Province, 11030, Sri Lanka', 'Department of Education, William Gopallawa Mawatha, Bogambara, Bahirawakanda, Kandy, Kandy District, Central Province, 20000, Sri Lanka', '6', '98.00', '73.79', '7592.99', '2025-03-22 20:08:12', '2025-03-24', '05:22:00', '0');
INSERT INTO `bookings` VALUES ('66', 'BK20250322-0066', 'CUST0106', null, 'C0002', 'Ambepussa, Mahena, Kegalle District, Sabaragamuwa Province, 71600, Sri Lanka', 'Department of Education, William Gopallawa Mawatha, Bogambara, Bahirawakanda, Kandy, Kandy District, Central Province, 20000, Sri Lanka', '1', '98.00', '46.91', '4827.04', '2025-03-22 20:11:05', '2025-03-26', '10:22:00', '1');
INSERT INTO `bookings` VALUES ('67', 'BK20250322-0067', 'CUST0106', null, 'C0008', 'D. R. Wijewardene Mawatha, Suduwella, Slave Island, Colombo, Colombo District, Western Province, 00200, Sri Lanka', 'Department of Education, William Gopallawa Mawatha, Bogambara, Bahirawakanda, Kandy, Kandy District, Central Province, 20000, Sri Lanka', '1', '110.00', '94.62', '10928.61', '2025-03-22 20:14:14', '2025-03-26', '14:22:00', '1');
INSERT INTO `bookings` VALUES ('68', 'BK20250322-0068', 'CUST0106', 'd0126', 'C0008', 'Gampaha, Gampaha District, Western Province, 11030, Sri Lanka', 'Department of Education, William Gopallawa Mawatha, Bogambara, Bahirawakanda, Kandy, Kandy District, Central Province, 20000, Sri Lanka', '5', '110.00', '73.00', '8431.50', '2025-03-22 20:33:24', '2025-03-27', '10:25:00', '1');

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
  `model` int DEFAULT NULL,
  `type` int DEFAULT NULL,
  `reg_number` varchar(20) NOT NULL,
  `capacity` int NOT NULL,
  `available` tinyint(1) DEFAULT '1',
  `driver_id` varchar(20) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `price_for_km` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reg_number` (`reg_number`),
  KEY `car_id` (`car_id`),
  KEY `cars_ibfk_2` (`model`),
  KEY `type` (`type`),
  KEY `driver_id` (`driver_id`),
  CONSTRAINT `cars_ibfk_2` FOREIGN KEY (`model`) REFERENCES `car_models` (`model_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `cars_ibfk_3` FOREIGN KEY (`type`) REFERENCES `car_types` (`type_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `cars_ibfk_4` FOREIGN KEY (`driver_id`) REFERENCES `drivers` (`driver_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of cars
-- ----------------------------
INSERT INTO `cars` VALUES ('1', 'C0001', '1', '1', 'ABC123', '5', '1', 'd0126', '/images/toyota_camry.jpg', '100.00');
INSERT INTO `cars` VALUES ('2', 'C0002', '2', '1', 'DEF456', '5', '1', 'd0126', '/images/honda_accord.jpg', '98.00');
INSERT INTO `cars` VALUES ('3', 'C0003', '3', '2', 'GHI789', '7', '0', 'd0126', '/images/ford_explorer.jpg', '130.00');
INSERT INTO `cars` VALUES ('4', 'C0004', '4', '2', 'JKL101', '4', '0', 'd0126', '/images/jeep_wrangler.jpg', '135.00');
INSERT INTO `cars` VALUES ('5', 'C0005', '5', '3', 'MNO112', '5', '0', 'd0126', '/images/vw_golf.jpg', '90.00');
INSERT INTO `cars` VALUES ('6', 'C0006', '6', '4', 'PQR131', '4', '0', 'd0126', '/images/bmw_4series.jpg', '200.00');
INSERT INTO `cars` VALUES ('7', 'C0007', '7', '5', 'STU415', '3', '0', 'd0126', '/images/ford_f150.jpg', '160.00');
INSERT INTO `cars` VALUES ('8', 'C0008', '8', '1', 'TES567', '5', '1', 'd0126', '/images/tesla_model_s.jpg', '110.00');
INSERT INTO `cars` VALUES ('9', 'C0009', '9', '2', 'CHE789', '8', '0', 'd0126', '/images/chevrolet_tahoe.jpg', '140.00');
INSERT INTO `cars` VALUES ('10', 'C0010', '10', '2', 'MAZ234', '5', '1', 'd0126', '/images/mazda_cx5.jpg', '120.00');
INSERT INTO `cars` VALUES ('11', 'C0011', '11', '3', 'SUB456', '5', '0', 'd0126', '/images/subaru_impreza.jpg', '95.00');
INSERT INTO `cars` VALUES ('12', 'C0012', '12', '4', 'POR911', '2', '1', 'd0126', '/images/porsche_911.jpg', '250.00');
INSERT INTO `cars` VALUES ('13', 'C0013', '13', '5', 'RAM150', '3', '0', 'd0126', '/images/ram_1500.jpg', '175.00');

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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of customers
-- ----------------------------
INSERT INTO `customers` VALUES ('69', 'CUST0106', '106', 'Magni dolor eu numqu', '2025-03-12 14:07:38');
INSERT INTO `customers` VALUES ('73', 'CUST0127', '127', 'No 123', '2025-03-22 17:00:59');
INSERT INTO `customers` VALUES ('74', 'CUST0128', '128', 'kurunegala colany', '2025-03-22 17:48:01');

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
  UNIQUE KEY `license_number` (`license_number`),
  KEY `driver_id` (`driver_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `drivers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of drivers
-- ----------------------------
INSERT INTO `drivers` VALUES ('126', 'd0126', 'ABC1234', '2025-03-21 23:04:26');

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
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('28', 'admin', 'Admin chathura', '4rKWDl1E+H5ZfHY18rLRK9TpPMOyU6d6EsOSqDzbDq4=', 'FV4/A6ZFiAp/97L62yEJaA==', '964515750v', '0457805450', 'chathu.eac@gmail.com', 'admin', '2025-02-20 19:20:36', '1');
INSERT INTO `users` VALUES ('106', 'dinuka25', 'Dinuka Dilshan', '+pAQ9qisVbzaKgCHvk8H3dElnFsVd1yIdMTAKcus4tQ=', 'u0xZphxG9yZNDCIOtX3EzA==', '874574251v', '0457805450', '1test.96c@gmail.com', 'customer', '2025-03-12 14:07:37', '1');
INSERT INTO `users` VALUES ('126', 'driversandun', 'Sandun', '4rKWDl1E+H5ZfHY18rLRK9TpPMOyU6d6EsOSqDzbDq4=', 'FV4/A6ZFiAp/97L62yEJaA==', '771642280V', '0754475741', 'chathura19960612@gmail.com', 'driver', '2025-03-21 23:04:26', '1');
INSERT INTO `users` VALUES ('127', 'Thisara', 'Thisara lakmal', 'lxf2yqZbX5SrQ/RTal5low5WL3tp8OAGePjwHjJ+KZk=', 'tpeEIExQDfZ6M3R69xnxoQ==', '995415250v', '0745825051', 'mycloudeac@gmail.com', 'customer', '2025-03-22 17:00:57', '1');
INSERT INTO `users` VALUES ('128', 'tester', 'Lakmal Edirisinghe', 'g5mfwmBTFHQQe/JF3vfrmotjP+D/SxXvLsBvz+X7J24=', 'jeAECJylBBxs0FutUpCz1A==', '223256432345', '0775567435', 'fghghjjh@gmail.com', 'customer', '2025-03-22 17:48:01', '1');
