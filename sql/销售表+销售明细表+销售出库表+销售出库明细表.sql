/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-12-19 17:53:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ckxscheck`
-- ----------------------------
DROP TABLE IF EXISTS `ckxscheck`;
CREATE TABLE `ckxscheck` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderCode` varchar(20) NOT NULL,
  `OrderDate` date DEFAULT NULL,
  `ClientCode` varchar(20) DEFAULT NULL,
  `StoreCode` varchar(20) DEFAULT NULL,
  `EmpCode` varchar(20) DEFAULT NULL,
  `DeptCode` varchar(20) DEFAULT NULL,
  `InOutTypeNo` varchar(20) DEFAULT NULL,
  `BillOrderNo` varchar(20) DEFAULT NULL,
  `RelatedBillNo` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL,
  `CKAmount` decimal(10,2) DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `CheckFlag` smallint(6) DEFAULT NULL,
  `CheckDate` date DEFAULT NULL,
  `CheckMan` varchar(20) DEFAULT NULL,
  `Memo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`,`OrderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ckxscheck
-- ----------------------------

-- ----------------------------
-- Table structure for `ckxscheckdetail`
-- ----------------------------
DROP TABLE IF EXISTS `ckxscheckdetail`;
CREATE TABLE `ckxscheckdetail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderCode` varchar(20) NOT NULL,
  `SerialNo` int(11) DEFAULT NULL,
  `GoodsCode` varchar(20) DEFAULT NULL,
  `Quantity` decimal(10,2) DEFAULT NULL,
  `Unit` varchar(20) DEFAULT NULL,
  `OrigPrice` decimal(10,2) DEFAULT NULL,
  `Discount` decimal(10,2) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `TaxRate` decimal(10,2) DEFAULT NULL,
  `TaxAmount` decimal(10,2) DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `CKPrice` decimal(10,2) DEFAULT NULL,
  `Memo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`,`OrderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ckxscheckdetail
-- ----------------------------

-- ----------------------------
-- Table structure for `xsorder`
-- ----------------------------
DROP TABLE IF EXISTS `xsorder`;
CREATE TABLE `xsorder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderCode` varchar(20) NOT NULL,
  `OrderDate` date DEFAULT NULL,
  `ClientCode` varchar(20) DEFAULT NULL,
  `StoreCode` varchar(20) DEFAULT NULL,
  `FinishFlag` smallint(6) DEFAULT NULL,
  `DeptCode` varchar(20) DEFAULT NULL,
  `EmpCode` varchar(20) DEFAULT NULL,
  `DeliveryDate` date DEFAULT NULL,
  `Operator` varchar(255) DEFAULT NULL,
  `CheckFlag` smallint(6) DEFAULT NULL,
  `CheckMan` varchar(255) DEFAULT NULL,
  `CheckDate` date DEFAULT NULL,
  `SettleTypeFlag` int(11) DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `CKAmount` decimal(10,2) DEFAULT NULL,
  `Memo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`OrderCode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xsorder
-- ----------------------------
INSERT INTO `xsorder` VALUES ('3', 'XD-20131219-001', '2013-12-19', '001', '239', null, '001', 'admin', '2013-12-31', 'admin', null, null, null, null, '25.74', null, null);

-- ----------------------------
-- Table structure for `xsorderdetail`
-- ----------------------------
DROP TABLE IF EXISTS `xsorderdetail`;
CREATE TABLE `xsorderdetail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderCode` varchar(20) NOT NULL,
  `SerialNo` int(11) DEFAULT NULL,
  `StoreCode` varchar(20) DEFAULT NULL,
  `GoodsCode` varchar(20) DEFAULT NULL,
  `OrigPrice` decimal(10,2) DEFAULT NULL,
  `Discount` decimal(10,2) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Quantity` decimal(10,2) DEFAULT NULL,
  `Unit` varchar(20) DEFAULT NULL,
  `TaxRate` decimal(10,2) DEFAULT NULL,
  `TaxAmount` decimal(10,2) DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `OutStoreQty` decimal(10,2) DEFAULT NULL,
  `ReturnQty` decimal(10,2) DEFAULT NULL,
  `CKPrice` decimal(10,2) DEFAULT NULL,
  `Memo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xsorderdetail
-- ----------------------------
INSERT INTO `xsorderdetail` VALUES ('2', 'XD-20131219-001', null, '239', '1111', '11.00', '100.00', '11.00', '2.00', null, '17.00', '3.74', '25.74', null, null, '11.00', null);
