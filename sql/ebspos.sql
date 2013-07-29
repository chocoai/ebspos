/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-07-29 16:21:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `employee`
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usr_no` varchar(11) NOT NULL,
  `usr_name` varchar(20) DEFAULT NULL,
  `pwd` varchar(50) DEFAULT NULL,
  `dep_no` int(11) DEFAULT NULL,
  `age` tinyint(4) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `edu_bg` varchar(50) DEFAULT NULL,
  `birthday` varchar(50) DEFAULT NULL,
  `entry_date` varchar(50) DEFAULT NULL,
  `id_card_no` bigint(20) DEFAULT NULL,
  `fax_no` bigint(20) DEFAULT NULL,
  `phone_no` bigint(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `royalty_rate` decimal(10,0) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `is_use` tinyint(4) DEFAULT NULL,
  `usr_type` tinyint(4) DEFAULT NULL,
  `upd_time` datetime DEFAULT NULL,
  `crd_time` datetime DEFAULT NULL,
  `upd_usr` varchar(255) DEFAULT NULL,
  `crd_usr` varchar(255) DEFAULT NULL,
  `del_flg` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`,`usr_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', 'admin', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', '1', '男', '本科', '2013-06-28', '2013-06-28', '36010319880999', null, '13809876543', 'vasdfasdfadsf', '导购员', '100000', 'xxxx@163.com', '0', '弄阿克苏打发第三方', '1', '1', null, null, null, null, null);
INSERT INTO `employee` VALUES ('2', 'pk', '彭科', 'e10adc3949ba59abbe56e057f20f883e', '1', null, '男', '高中', '2013-07-24', '2013-07-31', '23412343324', null, null, null, '业务员', null, null, null, null, null, null, '2013-07-09 14:44:39', null, null, null, null);
INSERT INTO `employee` VALUES ('3', 'wcc', '吴春明', 'e10adc3949ba59abbe56e057f20f883e', '1', '5', '女', '本科', '2013-07-23', '2013-07-26', '188888888', '13241324', '2341234', 'qer123r', '导购员', '10', '2@124.com', '20', '来这个啊京东方卡迪夫', null, null, '2013-07-18 10:53:54', null, null, null, '0');

-- ----------------------------
-- Table structure for `jbgoods`
-- ----------------------------
DROP TABLE IF EXISTS `jbgoods`;
CREATE TABLE `jbgoods` (
  `GoodsNo` varchar(255) NOT NULL DEFAULT '',
  `GoodsCode` varchar(255) DEFAULT NULL,
  `GoodsName` varchar(255) DEFAULT NULL,
  `GoodsTypeNo` varchar(255) DEFAULT NULL,
  `BrandNo` varchar(255) DEFAULT NULL,
  `ProduceArea` varchar(255) DEFAULT NULL,
  `ProduceName` varchar(255) DEFAULT NULL,
  `Clolor` varchar(255) DEFAULT NULL,
  `BarCode` varchar(255) DEFAULT NULL,
  `Model` varchar(255) DEFAULT NULL,
  `BaseUnit` varchar(255) DEFAULT NULL,
  `SmallUnit` varchar(255) DEFAULT NULL,
  `SmallUnitQty` decimal(10,0) DEFAULT NULL,
  `BigUnit` varchar(255) DEFAULT NULL,
  `BigUnitQty` decimal(10,0) DEFAULT NULL,
  `MaxBPrice` decimal(10,0) DEFAULT NULL,
  `MinSPrice` decimal(10,0) DEFAULT NULL,
  `BRefPrice` decimal(10,0) DEFAULT NULL,
  `SRefPrice` decimal(10,0) DEFAULT NULL,
  `BPriceLevel1` decimal(10,0) DEFAULT NULL,
  `SPriceLevel1` decimal(10,0) DEFAULT NULL,
  `CostPrice` decimal(10,0) DEFAULT NULL,
  `MemberPrice` decimal(10,0) DEFAULT NULL,
  `SUBRefPrice` decimal(10,0) DEFAULT NULL,
  `SUSRefPrice` decimal(10,0) DEFAULT NULL,
  `SUMemberPrice` decimal(10,0) DEFAULT NULL,
  `BUBRefPrice` decimal(10,0) DEFAULT NULL,
  `BUSRefPrice` decimal(10,0) DEFAULT NULL,
  `BMemberPrice` decimal(10,0) DEFAULT NULL,
  `SalesType` smallint(6) DEFAULT NULL,
  `SBeginDate` datetime DEFAULT NULL,
  `SEndDate` datetime DEFAULT NULL,
  `SalesQty` decimal(10,0) DEFAULT NULL,
  `FinishSaleQty` decimal(10,0) DEFAULT NULL,
  `SalesPrice` decimal(10,0) DEFAULT NULL,
  `MaxStorage` decimal(10,0) DEFAULT NULL,
  `MinStorage` decimal(10,0) DEFAULT NULL,
  `LastBuyPrice` decimal(10,0) DEFAULT NULL,
  `LastBuyDate` datetime DEFAULT NULL,
  `Picture` blob,
  `StopFlag` smallint(6) DEFAULT NULL,
  `DiscountFlag` smallint(6) DEFAULT NULL,
  `CombineFlag` smallint(6) DEFAULT NULL,
  `StoreFlag` smallint(6) DEFAULT NULL,
  `NewFlag` smallint(6) DEFAULT NULL,
  `Memo` varchar(255) DEFAULT NULL,
  `DownLogNo` int(11) DEFAULT NULL,
  `CSOptions` smallint(6) DEFAULT NULL,
  `BarcodeType` smallint(6) DEFAULT NULL,
  `CGroupNo` varchar(255) DEFAULT NULL,
  `SGroupNo` varchar(255) DEFAULT NULL,
  `Season` varchar(255) DEFAULT NULL,
  `YearBy` varchar(255) DEFAULT NULL,
  `IsGift` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`GoodsNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbgoods
-- ----------------------------

-- ----------------------------
-- Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `url` varchar(50) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `menulevel` smallint(6) DEFAULT '0',
  `icon` varchar(50) DEFAULT NULL,
  `ordernum` int(11) DEFAULT '0',
  `safecode` varchar(20) DEFAULT NULL,
  `pid` bigint(20) DEFAULT '0',
  `target` smallint(6) DEFAULT '0',
  `rel` varchar(30) DEFAULT NULL,
  `enable` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1015 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '资料管理', null, '0', '0', null, '1', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('2', '采购管理', null, '0', '0', null, '2', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('3', '销售管理', null, '0', '0', null, '3', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('4', '仓库管理', null, '0', '0', null, '4', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('5', '财务管理', null, '0', '0', null, '5', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('6', '报表统计', null, '0', '0', null, '6', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('114', '员工资料', 'employee', '1', '2', null, '4', null, '11', '0', null, '1');
INSERT INTO `menu` VALUES ('113', '商品资料', '#', '1', '2', null, '3', null, '11', '0', null, '1');
INSERT INTO `menu` VALUES ('11', '资料管理', null, '1', '1', null, '1', null, '1', '0', null, '1');
INSERT INTO `menu` VALUES ('111', '供应商资料', '#', '1', '2', null, '1', null, '11', '0', null, '1');
INSERT INTO `menu` VALUES ('112', '客户资料', '#', '1', '2', null, '2', null, '11', '0', null, '1');

-- ----------------------------
-- Table structure for `partment`
-- ----------------------------
DROP TABLE IF EXISTS `partment`;
CREATE TABLE `partment` (
  `id` int(11) NOT NULL DEFAULT '0',
  `dep_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of partment
-- ----------------------------
INSERT INTO `partment` VALUES ('1', '销售部');

-- ----------------------------
-- Table structure for `powermenu`
-- ----------------------------
DROP TABLE IF EXISTS `powermenu`;
CREATE TABLE `powermenu` (
  `menuid` bigint(20) NOT NULL,
  `objid` bigint(20) NOT NULL,
  `type` smallint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of powermenu
-- ----------------------------
INSERT INTO `powermenu` VALUES ('6', '1', '0');
INSERT INTO `powermenu` VALUES ('5', '1', '0');
INSERT INTO `powermenu` VALUES ('4', '1', '0');
INSERT INTO `powermenu` VALUES ('3', '1', '0');
INSERT INTO `powermenu` VALUES ('2', '1', '0');
INSERT INTO `powermenu` VALUES ('1', '1', '0');
INSERT INTO `powermenu` VALUES ('11', '1', '0');
INSERT INTO `powermenu` VALUES ('111', '1', '0');
INSERT INTO `powermenu` VALUES ('112', '1', '0');
INSERT INTO `powermenu` VALUES ('113', '1', '0');
INSERT INTO `powermenu` VALUES ('114', '1', '0');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('3', '员工', null);
INSERT INTO `role` VALUES ('2', '管理员', 'fds');

-- ----------------------------
-- Table structure for `userrole`
-- ----------------------------
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole` (
  `userid` bigint(20) NOT NULL,
  `roleid` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userrole
-- ----------------------------
INSERT INTO `userrole` VALUES ('1', '2');
INSERT INTO `userrole` VALUES ('1', '3');
