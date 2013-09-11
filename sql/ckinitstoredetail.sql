/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-09-11 15:43:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ckinitstoredetail`
-- ----------------------------
DROP TABLE IF EXISTS `ckinitstoredetail`;
CREATE TABLE `ckinitstoredetail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(20) DEFAULT NULL,
  `SerialNo` int(11) DEFAULT NULL,
  `GoodsNo` varchar(20) DEFAULT NULL,
  `GoodsName` varchar(200) DEFAULT NULL,
  `SUnitQuantity` decimal(10,0) DEFAULT NULL,
  `MUnitQuantity` decimal(10,0) DEFAULT NULL,
  `UnitQuantity` decimal(10,0) DEFAULT NULL,
  `Quantity` decimal(10,0) DEFAULT NULL,
  `CKPrice` decimal(10,0) DEFAULT NULL,
  `CKAmount` decimal(10,0) DEFAULT NULL,
  `Unit` varchar(20) DEFAULT NULL,
  `MixUnit` varchar(20) DEFAULT NULL,
  `UnitRate` varchar(20) DEFAULT NULL,
  `RelatedOrderNo` varchar(20) DEFAULT NULL,
  `OrderSerialNo` int(11) DEFAULT NULL,
  `Memo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ckinitstoredetail
-- ----------------------------
INSERT INTO `ckinitstoredetail` VALUES ('29', 'CK1377830836634', null, '1111', '123', null, null, null, '0', '0', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('31', 'CK1377840751068', null, '1111', '123', null, null, null, '20', '123', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('32', 'CK1377840751068', null, '1111', '123', null, null, null, '30', '12', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('33', 'CK1377840751068', null, '1111', '123', null, null, null, '40', '10', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('38', 'CK1377840751068', null, '1111', '123', null, null, null, '77', '99', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('41', 'CK1377840751068', null, '1111', '123', null, null, null, '1000', '12', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('42', 'CK1377840751068', null, '1111', '123', null, null, null, '100', '20', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('43', 'CK1377840751068', null, '1111', '123', null, null, null, '1', '1', null, '1', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('44', 'CK1377840751068', null, '1111', '123', null, null, null, '1', '1', null, '1', null, null, null, null, null);
