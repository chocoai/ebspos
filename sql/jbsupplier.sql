/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-09-30 11:17:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `jbsupplier`
-- ----------------------------
DROP TABLE IF EXISTS `jbsupplier`;
CREATE TABLE `jbsupplier` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `supplierCode` varchar(20) DEFAULT '0' COMMENT '供应商编码',
  `supplierName` varchar(50) DEFAULT '0' COMMENT '供应商名称',
  `supplierTypeNo` int(11) DEFAULT '0' COMMENT '供应商类别',
  `EmployeeNo` int(11) DEFAULT '0' COMMENT '管辖业务员',
  `Address` varchar(150) DEFAULT '0' COMMENT '联系地址',
  `SendAddress` varchar(150) DEFAULT '0' COMMENT '发货地址',
  `PostNo` varchar(50) DEFAULT '0' COMMENT '邮编',
  `TelePhone` varchar(50) DEFAULT '0' COMMENT '公司电话',
  `Fax` varchar(50) DEFAULT '0' COMMENT '传真',
  `Email` varchar(50) DEFAULT '0' COMMENT '邮箱',
  `LinkMan` varchar(50) DEFAULT '0' COMMENT '联系人',
  `LinkPhone` varchar(50) DEFAULT '0' COMMENT '联系人电话',
  `Url` varchar(50) DEFAULT '0' COMMENT '网址',
  `PDayMax` int(11) DEFAULT '0' COMMENT '信用天数',
  `PAmountMax` decimal(10,2) DEFAULT '0.00' COMMENT '信用金额',
  `BankNo` varchar(100) DEFAULT '0' COMMENT '开户行',
  `BankAccount` varchar(100) DEFAULT '0' COMMENT '账号',
  `PreAmount` decimal(10,2) DEFAULT '0.00' COMMENT '期初应付',
  `AdvanceAmount` decimal(10,2) DEFAULT '0.00' COMMENT '预付款',
  `BuyAmount` decimal(10,2) DEFAULT '0.00' COMMENT '购买总金额',
  `SplusAmount` decimal(10,2) DEFAULT '0.00' COMMENT '往来余额',
  `StopFlag` smallint(6) DEFAULT '0' COMMENT '停止业务标志',
  `remark` varchar(150) DEFAULT '0' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `supplierCode` (`supplierCode`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='供应商资料';

-- ----------------------------
-- Records of jbsupplier
-- ----------------------------
INSERT INTO `jbsupplier` VALUES ('1', '112', '2222', '0', '22', '2', '2', '2', '2', null, null, '2', '2', '2', '2', '22.00', '22', '222', '2.00', '0.00', '0.00', '0.00', null, '2');
