/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-07-27 14:11:57
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
  `GoodsNo` varchar(255) DEFAULT NULL,
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
  `IsGift` smallint(6) DEFAULT NULL
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
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('2', '系统管理', null, '0', '0', null, '10', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('3', '人力资源', null, '0', '0', null, '9', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('4', '计划', null, '0', '0', null, '8', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('5', '财务', null, '0', '0', null, '7', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('24', '任务', null, '0', '0', null, '4', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('22', '流程', null, '0', '0', null, '2', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('21', '文档', null, '0', '0', null, '1', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('20', '员工信息', 'employee', '1', '2', null, '1', null, '15', '0', null, '1');
INSERT INTO `menu` VALUES ('10', '功能菜单', 'menu', '1', '2', null, '0', null, '32', '0', null, '1');
INSERT INTO `menu` VALUES ('11', '角色', 'role', '1', '2', null, '1', null, '33', '0', null, '1');
INSERT INTO `menu` VALUES ('12', '部门', 'partment', '1', '2', null, '2', null, '33', '0', null, '1');
INSERT INTO `menu` VALUES ('13', '参数设置', 'systemparam', '1', '2', null, '3', null, '32', '0', null, '1');
INSERT INTO `menu` VALUES ('14', '机构', 'organization', '1', '2', null, '4', null, '33', '0', null, '1');
INSERT INTO `menu` VALUES ('15', '人员管理', null, '1', '1', null, '1', null, '3', '0', null, '1');
INSERT INTO `menu` VALUES ('16', '权限配置', 'power', '1', '2', null, '5', 'employee', '32', '0', null, '1');
INSERT INTO `menu` VALUES ('31', '流程管理', null, '1', '1', null, '1', null, '2', '0', null, '1');
INSERT INTO `menu` VALUES ('18', '员工工资发放', 'wagepay', '1', '1', null, '1', 'wagepay', '5', '0', null, '1');
INSERT INTO `menu` VALUES ('25', '日程', null, '0', '0', null, '5', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('26', '我的日程', null, '1', '1', null, '1', null, '25', '0', null, '1');
INSERT INTO `menu` VALUES ('27', '我的日程管理', 'calender', '1', '2', null, '1', null, '26', '0', null, '1');
INSERT INTO `menu` VALUES ('28', '考勤管理', null, '1', '1', null, '1', null, '3', '0', null, '1');
INSERT INTO `menu` VALUES ('29', '我的考勤', null, '1', '2', null, '1', null, '28', '0', null, '1');
INSERT INTO `menu` VALUES ('30', '考勤统计', null, '1', '2', null, '2', null, '28', '0', null, '1');
INSERT INTO `menu` VALUES ('32', '系统设置', null, '1', '1', null, '0', null, '2', '0', null, '1');
INSERT INTO `menu` VALUES ('33', '组织设置', null, '1', '1', null, '1', null, '2', '0', null, '1');
INSERT INTO `menu` VALUES ('34', '流程分类', 'flowcate', '1', '2', null, '1', null, '31', '0', null, '1');
INSERT INTO `menu` VALUES ('35', '流程部署', 'flowdeploy', '1', '2', null, '0', null, '31', '0', null, '1');
INSERT INTO `menu` VALUES ('36', '我的流程', null, '1', '1', null, '0', null, '22', '0', null, '1');
INSERT INTO `menu` VALUES ('37', '发布流程', null, '1', '1', null, '0', null, '22', '0', null, '1');
INSERT INTO `menu` VALUES ('38', '我的任务', null, '1', '1', null, '1', null, '24', '0', null, '1');
INSERT INTO `menu` VALUES ('39', '发布任务', null, '1', '1', null, '0', null, '24', '1', null, '1');
INSERT INTO `menu` VALUES ('43', '发布文档', null, '1', '2', null, '1', null, '42', '1', null, '1');
INSERT INTO `menu` VALUES ('41', '公共文档', null, '1', '1', null, '1', null, '21', '0', null, '1');
INSERT INTO `menu` VALUES ('42', '我的文档', null, '1', '1', null, '0', null, '21', '0', null, '1');
INSERT INTO `menu` VALUES ('44', '文档管理', null, '1', '2', null, '0', null, '42', '0', null, '1');
INSERT INTO `menu` VALUES ('45', '发布文档', null, '1', '2', null, '1', null, '41', '0', null, '1');
INSERT INTO `menu` VALUES ('46', '文档管理', null, '1', '2', null, '2', null, '41', '0', null, '1');
INSERT INTO `menu` VALUES ('47', '平台设置', 'platform/set', '1', '2', null, '0', null, '32', '0', null, '1');
INSERT INTO `menu` VALUES ('48', '流程管理', null, '1', '1', null, '0', null, '22', '0', null, '1');
INSERT INTO `menu` VALUES ('49', '流程分类', null, '1', '2', null, '0', null, '48', '0', null, '1');
INSERT INTO `menu` VALUES ('50', '流程发布', null, '1', '2', null, '0', null, '48', '0', null, '1');
INSERT INTO `menu` VALUES ('51', '资产', null, '0', '0', null, '2', null, '0', '0', null, '1');
INSERT INTO `menu` VALUES ('52', '会议管理', null, '1', '1', null, '0', null, '25', '0', null, '1');
INSERT INTO `menu` VALUES ('53', '证件', null, '0', '0', null, '1', null, '0', '0', null, '1');

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
INSERT INTO `powermenu` VALUES ('2', '1', '0');
INSERT INTO `powermenu` VALUES ('3', '1', '0');
INSERT INTO `powermenu` VALUES ('4', '1', '0');
INSERT INTO `powermenu` VALUES ('5', '1', '0');
INSERT INTO `powermenu` VALUES ('10', '1', '0');
INSERT INTO `powermenu` VALUES ('11', '1', '0');
INSERT INTO `powermenu` VALUES ('12', '1', '0');
INSERT INTO `powermenu` VALUES ('13', '1', '0');
INSERT INTO `powermenu` VALUES ('14', '1', '0');
INSERT INTO `powermenu` VALUES ('15', '1', '0');
INSERT INTO `powermenu` VALUES ('16', '1', '0');
INSERT INTO `powermenu` VALUES ('18', '1', '0');
INSERT INTO `powermenu` VALUES ('20', '1', '0');
INSERT INTO `powermenu` VALUES ('21', '1', '0');
INSERT INTO `powermenu` VALUES ('22', '1', '0');
INSERT INTO `powermenu` VALUES ('24', '1', '0');
INSERT INTO `powermenu` VALUES ('25', '1', '0');
INSERT INTO `powermenu` VALUES ('26', '1', '0');
INSERT INTO `powermenu` VALUES ('27', '1', '0');
INSERT INTO `powermenu` VALUES ('28', '1', '0');
INSERT INTO `powermenu` VALUES ('29', '1', '0');
INSERT INTO `powermenu` VALUES ('30', '1', '0');
INSERT INTO `powermenu` VALUES ('31', '1', '0');
INSERT INTO `powermenu` VALUES ('32', '1', '0');
INSERT INTO `powermenu` VALUES ('33', '1', '0');
INSERT INTO `powermenu` VALUES ('34', '1', '0');
INSERT INTO `powermenu` VALUES ('35', '1', '0');
INSERT INTO `powermenu` VALUES ('36', '1', '0');
INSERT INTO `powermenu` VALUES ('37', '1', '0');
INSERT INTO `powermenu` VALUES ('38', '1', '0');
INSERT INTO `powermenu` VALUES ('39', '1', '0');
INSERT INTO `powermenu` VALUES ('41', '1', '0');
INSERT INTO `powermenu` VALUES ('42', '1', '0');
INSERT INTO `powermenu` VALUES ('43', '1', '0');
INSERT INTO `powermenu` VALUES ('44', '1', '0');
INSERT INTO `powermenu` VALUES ('45', '1', '0');
INSERT INTO `powermenu` VALUES ('46', '1', '0');
INSERT INTO `powermenu` VALUES ('47', '1', '0');
INSERT INTO `powermenu` VALUES ('48', '1', '0');
INSERT INTO `powermenu` VALUES ('49', '1', '0');
INSERT INTO `powermenu` VALUES ('50', '1', '0');
INSERT INTO `powermenu` VALUES ('51', '1', '0');
INSERT INTO `powermenu` VALUES ('52', '1', '0');
INSERT INTO `powermenu` VALUES ('53', '1', '0');

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
