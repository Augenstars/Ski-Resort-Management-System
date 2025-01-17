/*
 Navicat Premium Dump SQL

 Source Server         : DataBase
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : localhost:3306
 Source Schema         : skidatabase

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 09/01/2025 20:21:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------


-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (1, 'pbkdf2_sha256$870000$MZ9bc7iol0ag2hurPWUiLi$GsEtJNo9Avgkhrz+jzltY3BqZglr3V9qZdnwun3PC2k=', '2025-01-04 06:51:45.456725', 1, 'lee18', '', '', 'liyunxuan@hrbeu.edu.cn', 1, 1, '2025-01-04 06:51:15.993176');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id` ASC) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------


-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------


-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------


-- ----------------------------
-- Table structure for operation_logs
-- ----------------------------
DROP TABLE IF EXISTS `operation_logs`;
CREATE TABLE `operation_logs`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `operation_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `operation_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 366 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operation_logs
-- ----------------------------


-- ----------------------------
-- Table structure for ski_equipment
-- ----------------------------
DROP TABLE IF EXISTS `ski_equipment`;
CREATE TABLE `ski_equipment`  (
  `EquipmentID` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `EquipmentName` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `EquipmentStatus` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `EquipmentStartime` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `EquipmentEndtime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`EquipmentID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ski_equipment
-- ----------------------------


-- ----------------------------
-- Table structure for ski_manager
-- ----------------------------
DROP TABLE IF EXISTS `ski_manager`;
CREATE TABLE `ski_manager`  (
  `ManagerID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '管理者ID（主键）',
  `Passport` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '管理者登录密码',
  PRIMARY KEY (`ManagerID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ski_manager
-- ----------------------------
INSERT INTO `ski_manager` VALUES ('12', '12');

-- ----------------------------
-- Table structure for ski_purchase
-- ----------------------------
DROP TABLE IF EXISTS `ski_purchase`;
CREATE TABLE `ski_purchase`  (
  `PurchaseID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UsersID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `TicketsID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PurchaseTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `PurchaseCost` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `BankcardID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`PurchaseID`) USING BTREE,
  INDEX `TicketsID`(`TicketsID` ASC) USING BTREE,
  INDEX `ski_purchase_ibfk_1`(`UsersID` ASC) USING BTREE,
  CONSTRAINT `ski_purchase_ibfk_1` FOREIGN KEY (`UsersID`) REFERENCES `ski_users` (`UsersID`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `ski_purchase_ibfk_2` FOREIGN KEY (`TicketsID`) REFERENCES `ski_tickets` (`TicketsID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ski_purchase
-- ----------------------------


-- ----------------------------
-- Table structure for ski_rental
-- ----------------------------
DROP TABLE IF EXISTS `ski_rental`;
CREATE TABLE `ski_rental`  (
  `RentalID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UsersID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `EquipmentID` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RentalStartTime` datetime NULL DEFAULT NULL,
  `RentalEndTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`RentalID`) USING BTREE,
  INDEX `UsersID`(`UsersID` ASC) USING BTREE,
  CONSTRAINT `ski_rental_ibfk_1` FOREIGN KEY (`UsersID`) REFERENCES `ski_users` (`UsersID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ski_rental
-- ----------------------------


-- ----------------------------
-- Table structure for ski_tickets
-- ----------------------------
DROP TABLE IF EXISTS `ski_tickets`;
CREATE TABLE `ski_tickets`  (
  `TicketsID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UsersID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `TicketsType` char(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `TicketsPrice` decimal(10, 2) UNSIGNED NOT NULL,
  `TicketsStartTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `TicketsEndTime` datetime NOT NULL,
  PRIMARY KEY (`TicketsID`) USING BTREE,
  INDEX `TicketsType`(`TicketsType` ASC) USING BTREE,
  INDEX `ski_tickets_ibfk_1`(`UsersID` ASC) USING BTREE,
  CONSTRAINT `ski_tickets_ibfk_1` FOREIGN KEY (`UsersID`) REFERENCES `ski_users` (`UsersID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ski_tickets
-- ----------------------------


-- ----------------------------
-- Table structure for ski_trail
-- ----------------------------
DROP TABLE IF EXISTS `ski_trail`;
CREATE TABLE `ski_trail`  (
  `SkiName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Difficulty` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SkiDegree` float(5, 2) NOT NULL,
  `SkiLength` float(5, 2) NOT NULL,
  `SkiStatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`SkiName`) USING BTREE,
  INDEX `Difficulty`(`Difficulty` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ski_trail
-- ----------------------------
INSERT INTO `ski_trail` VALUES ('南楼大道', '中级道', 17.00, 111.00, '关闭');
INSERT INTO `ski_trail` VALUES ('工程雪道', '高级道', 30.00, 200.00, '开放');
INSERT INTO `ski_trail` VALUES ('慕雪道', '初中级道', 22.00, 810.00, '关闭');
INSERT INTO `ski_trail` VALUES ('星光大道', '中级道', 20.06, 800.00, '开放');
INSERT INTO `ski_trail` VALUES ('黑龙道', '高级道', 28.00, 900.00, '开放');

-- ----------------------------
-- Table structure for ski_users
-- ----------------------------
DROP TABLE IF EXISTS `ski_users`;
CREATE TABLE `ski_users`  (
  `UsersID` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UsersName` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `UsersPhoneNumber` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MembershipType` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `RegistrationTime` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `UsersPassport` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`UsersID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ski_users
-- ----------------------------


-- ----------------------------
-- View structure for user_ski_info
-- ----------------------------
DROP VIEW IF EXISTS `user_ski_info`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `user_ski_info` AS select `u`.`UsersID` AS `UsersID`,`u`.`UsersName` AS `UsersName`,`t`.`TicketsID` AS `TicketsID`,`p`.`PurchaseID` AS `PurchaseID`,`r`.`EquipmentID` AS `EquipmentID` from ((((`ski_users` `u` left join `ski_tickets` `t` on((`u`.`UsersID` = `t`.`UsersID`))) left join `ski_purchase` `p` on((`u`.`UsersID` = `p`.`UsersID`))) left join `ski_rental` `r` on((`u`.`UsersID` = `r`.`UsersID`))) left join `ski_equipment` `e` on((`r`.`EquipmentID` = `e`.`EquipmentID`)));

-- ----------------------------
-- Procedure structure for update_device_status_after_rental
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_device_status_after_rental`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_device_status_after_rental`()
BEGIN
    -- 更新所有租赁时间到期的设备状态为 '空闲'，并清空开始时间和结束时间
    UPDATE ski_equipment
    SET EquipmentStatus = '空闲',
        EquipmentStartime = NULL,
        EquipmentEndTime = NULL
    WHERE EquipmentID IN (
        SELECT EquipmentID
        FROM ski_rental
        WHERE RentalEndTime <= SYSDATE() AND EquipmentID IS NOT NULL
    );
END
;;
delimiter ;

-- ----------------------------
-- Event structure for update_device_status_event
-- ----------------------------
DROP EVENT IF EXISTS `update_device_status_event`;
delimiter ;;
CREATE EVENT `update_device_status_event`
ON SCHEDULE
EVERY '5' MINUTE STARTS '2025-01-05 23:41:05'
DO CALL update_device_status_after_rental()
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_equipment
-- ----------------------------
DROP TRIGGER IF EXISTS `after_skiequipment_insert`;
delimiter ;;
CREATE TRIGGER `after_skiequipment_insert` AFTER INSERT ON `ski_equipment` FOR EACH ROW BEGIN
    INSERT INTO operation_logs (table_name, operation_type, description)
    VALUES ('ski_equipment', 'INSERT', CONCAT('Inserted EquipmentID: ', NEW.EquipmentID));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_equipment
-- ----------------------------
DROP TRIGGER IF EXISTS `after_skiequipment_update`;
delimiter ;;
CREATE TRIGGER `after_skiequipment_update` AFTER UPDATE ON `ski_equipment` FOR EACH ROW BEGIN
    INSERT INTO operation_logs (table_name, operation_type, description)
    VALUES ('ski_equipment', 'UPDATE', CONCAT('Updated EquipmentID: ', NEW.EquipmentID));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_equipment
-- ----------------------------
DROP TRIGGER IF EXISTS `after_equipment_delete_log`;
delimiter ;;
CREATE TRIGGER `after_equipment_delete_log` AFTER DELETE ON `ski_equipment` FOR EACH ROW BEGIN
    -- 插入操作日志
    INSERT INTO operation_logs (table_name, operation_type, operation_time, description)
    VALUES ('ski_equipment', 'DELETE', NOW(), 
            CONCAT('Deleted equipment record: EquipmentID = ', OLD.EquipmentID, 
                   ', EquipmentName = ', OLD.EquipmentName, 
                   ', EquipmentStatus = ', OLD.EquipmentStatus));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_purchase
-- ----------------------------
DROP TRIGGER IF EXISTS `after_skipurchase_insert`;
delimiter ;;
CREATE TRIGGER `after_skipurchase_insert` AFTER INSERT ON `ski_purchase` FOR EACH ROW BEGIN
    INSERT INTO operation_logs (table_name, operation_type, description)
    VALUES ('ski_purchase', 'INSERT', CONCAT('Inserted PurchaseID: ', NEW.PurchaseID));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_purchase
-- ----------------------------
DROP TRIGGER IF EXISTS `after_skipurchase_update`;
delimiter ;;
CREATE TRIGGER `after_skipurchase_update` AFTER UPDATE ON `ski_purchase` FOR EACH ROW BEGIN
    INSERT INTO operation_logs (table_name, operation_type, description)
    VALUES ('ski_purchase', 'UPDATE', CONCAT('Updated PurchaseID: ', NEW.PurchaseID));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_purchase
-- ----------------------------
DROP TRIGGER IF EXISTS `after_purchase_delete_log`;
delimiter ;;
CREATE TRIGGER `after_purchase_delete_log` AFTER DELETE ON `ski_purchase` FOR EACH ROW BEGIN
    -- 插入操作日志
    INSERT INTO operation_logs (table_name, operation_type, operation_time, description)
    VALUES ('ski_purchase', 'DELETE', NOW(), 
            CONCAT('Deleted purchase record: PurchaseID = ', OLD.PurchaseID, 
                   ', UsersID = ', OLD.UsersID, 
                   ', TicketsID = ', OLD.TicketsID));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_rental
-- ----------------------------
DROP TRIGGER IF EXISTS `after_rental_insert`;
delimiter ;;
CREATE TRIGGER `after_rental_insert` AFTER INSERT ON `ski_rental` FOR EACH ROW BEGIN
    UPDATE ski_equipment
    SET 
        EquipmentStartime = NEW.RentalStartTime,
        EquipmentEndtime = NEW.RentalEndTime,
        EquipmentStatus = '使用'
    WHERE EquipmentID = NEW.EquipmentID;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_rental
-- ----------------------------
DROP TRIGGER IF EXISTS `after_rentall_insert`;
delimiter ;;
CREATE TRIGGER `after_rentall_insert` AFTER INSERT ON `ski_rental` FOR EACH ROW BEGIN
    -- 插入操作日志
    INSERT INTO operation_logs (table_name, operation_type, operation_time, description)
    VALUES ('ski_rental', 'INSERT', NOW(), 
            CONCAT('Inserted rental record: RentalID = ', NEW.RentalID, 
                   ', UsersID = ', NEW.UsersID, 
                   ', EquipmentID = ', NEW.EquipmentID));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_rental
-- ----------------------------
DROP TRIGGER IF EXISTS `after_rental_update`;
delimiter ;;
CREATE TRIGGER `after_rental_update` AFTER UPDATE ON `ski_rental` FOR EACH ROW BEGIN
    -- 插入操作日志
    INSERT INTO operation_logs (table_name, operation_type, operation_time, description)
    VALUES ('ski_rental', 'UPDATE', NOW(), 
            CONCAT('Updated rental record: RentalID = ', NEW.RentalID, 
                   ', EquipmentID = ', NEW.EquipmentID, 
                   '. Rental period updated from ', OLD.RentalStartTime, ' to ', NEW.RentalStartTime));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_rental
-- ----------------------------
DROP TRIGGER IF EXISTS `after_rental_delete_log`;
delimiter ;;
CREATE TRIGGER `after_rental_delete_log` AFTER DELETE ON `ski_rental` FOR EACH ROW BEGIN
    -- 插入操作日志
    INSERT INTO operation_logs (table_name, operation_type, operation_time, description)
    VALUES ('ski_rental', 'DELETE', NOW(), 
            CONCAT('Deleted rental record: RentalID = ', OLD.RentalID, 
                   ', EquipmentID = ', OLD.EquipmentID, 
                   ', UsersID = ', OLD.UsersID, 
                   ', RentalStartTime = ', OLD.RentalStartTime, 
                   ', RentalEndTime = ', OLD.RentalEndTime));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_tickets
-- ----------------------------
DROP TRIGGER IF EXISTS `after_skitickets_insert`;
delimiter ;;
CREATE TRIGGER `after_skitickets_insert` AFTER INSERT ON `ski_tickets` FOR EACH ROW BEGIN
    INSERT INTO operation_logs (table_name, operation_type, description)
    VALUES ('ski_tickets', 'INSERT', CONCAT('Inserted TicketsID: ', NEW.TicketsID));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_tickets
-- ----------------------------
DROP TRIGGER IF EXISTS `after_skitickets_update`;
delimiter ;;
CREATE TRIGGER `after_skitickets_update` AFTER UPDATE ON `ski_tickets` FOR EACH ROW BEGIN
    INSERT INTO operation_logs (table_name, operation_type, description)
    VALUES ('ski_tickets', 'UPDATE', CONCAT('Updated TicketsID: ', NEW.TicketsID));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_tickets
-- ----------------------------
DROP TRIGGER IF EXISTS `after_tickets_delete_log`;
delimiter ;;
CREATE TRIGGER `after_tickets_delete_log` AFTER DELETE ON `ski_tickets` FOR EACH ROW BEGIN
    -- 插入操作日志
    INSERT INTO operation_logs (table_name, operation_type, operation_time, description)
    VALUES ('ski_tickets', 'DELETE', NOW(), 
            CONCAT('Deleted tickets record: TicketsID = ', OLD.TicketsID, 
                   ', TicketsType = ', OLD.TicketsType, 
                   ', TicketsPrice = ', OLD.TicketsPrice));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_trail
-- ----------------------------
DROP TRIGGER IF EXISTS `after_skitrail_insert`;
delimiter ;;
CREATE TRIGGER `after_skitrail_insert` AFTER INSERT ON `ski_trail` FOR EACH ROW BEGIN
    INSERT INTO operation_logs (table_name, operation_type, description)
    VALUES ('ski_trail', 'INSERT', CONCAT('Inserted SkiName: ', NEW.SkiName));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_trail
-- ----------------------------
DROP TRIGGER IF EXISTS `after_skitrail_update`;
delimiter ;;
CREATE TRIGGER `after_skitrail_update` AFTER UPDATE ON `ski_trail` FOR EACH ROW BEGIN
    INSERT INTO operation_logs (table_name, operation_type, description)
    VALUES ('ski_trail', 'UPDATE', CONCAT('Updated SkiName: ', NEW.SkiName));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_trail
-- ----------------------------
DROP TRIGGER IF EXISTS `after_trail_delete_log`;
delimiter ;;
CREATE TRIGGER `after_trail_delete_log` AFTER DELETE ON `ski_trail` FOR EACH ROW BEGIN
    -- 插入操作日志
    INSERT INTO operation_logs (table_name, operation_type, operation_time, description)
    VALUES ('ski_trail', 'DELETE', NOW(), 
            CONCAT('Deleted trail record: SkiName = ', OLD.SkiName, 
                   ', Difficulty = ', OLD.Difficulty, 
                   ', SkiDegree = ', OLD.SkiDegree));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_users
-- ----------------------------
DROP TRIGGER IF EXISTS `after_skiuser_insert`;
delimiter ;;
CREATE TRIGGER `after_skiuser_insert` AFTER INSERT ON `ski_users` FOR EACH ROW BEGIN
    INSERT INTO operation_logs (table_name, operation_type, description)
    VALUES ('ski_users', 'INSERT', CONCAT('Inserted UserID: ', NEW.UsersID));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_users
-- ----------------------------
DROP TRIGGER IF EXISTS `after_skiuser_update`;
delimiter ;;
CREATE TRIGGER `after_skiuser_update` AFTER UPDATE ON `ski_users` FOR EACH ROW BEGIN
    INSERT INTO operation_logs (table_name, operation_type, description)
    VALUES ('ski_users', 'UPDATE', CONCAT('Updated UserID: ', NEW.UsersID));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_users
-- ----------------------------
DROP TRIGGER IF EXISTS `after_user_delete`;
delimiter ;;
CREATE TRIGGER `after_user_delete` AFTER DELETE ON `ski_users` FOR EACH ROW BEGIN
    -- 删除 ski_equipment 表中与该用户相关的记录
    DELETE FROM ski_rental
    WHERE UsersID = OLD.UsersID;

    -- 删除 ski_tickets 表中与该用户相关的记录
    DELETE FROM ski_tickets
    WHERE UsersID = OLD.UsersID;

    -- 删除 ski_purchase 表中与该用户相关的记录
    DELETE FROM ski_purchase
    WHERE UsersID = OLD.UsersID;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ski_users
-- ----------------------------
DROP TRIGGER IF EXISTS `after_user_delete_log`;
delimiter ;;
CREATE TRIGGER `after_user_delete_log` AFTER DELETE ON `ski_users` FOR EACH ROW BEGIN
    -- 插入操作日志
    INSERT INTO operation_logs (table_name, operation_type, operation_time, description)
    VALUES ('ski_users', 'DELETE', NOW(), 
            CONCAT('Deleted user record: UsersID = ', OLD.UsersID, 
                   ', UsersName = ', OLD.UsersName, 
                   ', UsersPhoneNumber = ', OLD.UsersPhoneNumber));
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
