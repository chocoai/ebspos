/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-09-11 15:43:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ckinitstore`
-- ----------------------------
DROP TABLE IF EXISTS `ckinitstore`;
CREATE TABLE `ckinitstore` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(20) DEFAULT NULL,
  `OrderDate` varchar(20) DEFAULT NULL,
  `StoreNo` varchar(20) DEFAULT NULL,
  `BillOrderNo` varchar(20) DEFAULT NULL,
  `RelatedBillNo` varchar(20) DEFAULT NULL,
  `DepartmentNo` varchar(20) DEFAULT NULL,
  `EmployeeNo` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL,
  `CKAmount` decimal(10,0) DEFAULT NULL,
  `CheckFlag` smallint(6) DEFAULT NULL,
  `CheckDate` varchar(20) DEFAULT NULL,
  `CheckMan` varchar(50) DEFAULT NULL,
  `RecordCount` int(11) DEFAULT NULL,
  `Memo` varchar(100) DEFAULT NULL,
  `RedFlag` smallint(6) DEFAULT NULL,
  `RedDate` varchar(20) DEFAULT NULL,
  `RedMan` varchar(50) DEFAULT NULL,
  `HasRed` smallint(6) DEFAULT NULL,
  `PriceType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ckinitstore
-- ----------------------------
INSERT INTO `ckinitstore` VALUES ('5', 'CK1377840011216', '2013-08-06', '1', null, null, '1', 'pk', '3', '3', null, '2013-08-13', '4', null, '2', null, null, null, null, null);
INSERT INTO `ckinitstore` VALUES ('6', 'CK1377840751068', '2013-08-14', '2', null, null, '13', 'zyh', 'dd', '45', null, '2013-08-20', '45', null, '5000', null, null, null, null, '移动平均计价');
INSERT INTO `ckinitstore` VALUES ('7', 'CK1377854931458', '2013-08-12', '1', null, null, '13', 'zyh', '1324', '1234', null, '2013-08-15', '1234', null, '324', null, null, null, null, null);
