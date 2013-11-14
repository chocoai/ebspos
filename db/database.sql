/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-08-16 15:50:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `calendar`
-- ----------------------------
DROP TABLE IF EXISTS `calendar`;
CREATE TABLE `calendar` (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日程主键',
  `Subject` varchar(200) DEFAULT NULL COMMENT '日程标题',
  `Location` varchar(200) DEFAULT NULL COMMENT '地点',
  `Description` varchar(500) DEFAULT NULL COMMENT '说明',
  `CalendarType` tinyint(4) DEFAULT '1' COMMENT '日程类型\r\n            1	个人日程\r\n            2	部门日程',
  `StartTime` datetime NOT NULL COMMENT '开始时间',
  `EndTime` datetime NOT NULL COMMENT '结束时间',
  `IsAllDayEvent` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否全天日程',
  `HasAttachment` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否有附件',
  `Category` varchar(400) DEFAULT NULL COMMENT '分类',
  `InstanceType` tinyint(4) NOT NULL COMMENT '实例类型\r\n            0	Single（一般日程）\r\n            1	Master（循环主日程）\r\n            2	Instance（循环实例日程）\r\n            3	Exception （错误）\r\n            4	MeetingRequest（会议安排）',
  `Attendees` varchar(500) DEFAULT NULL COMMENT '参与人',
  `AttendeeNames` varchar(500) DEFAULT NULL COMMENT '参与人姓名',
  `OtherAttendee` varchar(500) DEFAULT NULL COMMENT '其他参与人',
  `UPAccount` bigint(20) DEFAULT NULL COMMENT '更新人账号',
  `UPName` varchar(100) DEFAULT NULL COMMENT '更新人姓名',
  `UPTime` datetime DEFAULT NULL COMMENT '最后一次更新时间',
  `RecurringRule` varchar(1000) DEFAULT NULL COMMENT '循环规则',
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of calendar
-- ----------------------------

-- ----------------------------
-- Table structure for `ckinitstore`
-- ----------------------------
DROP TABLE IF EXISTS `ckinitstore`;
CREATE TABLE `ckinitstore` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(20) NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `StoreNo` varchar(20) DEFAULT NULL,
  `BillOrderNo` varchar(20) DEFAULT NULL,
  `RelatedBillNo` varchar(20) DEFAULT NULL,
  `DepartmentNo` varchar(20) DEFAULT NULL,
  `EmployeeNo` varchar(20) DEFAULT NULL,
  `Operator` varchar(20) DEFAULT NULL,
  `CKAmount` decimal(10,0) DEFAULT NULL,
  `CheckFlag` smallint(6) DEFAULT NULL,
  `CheckDate` datetime DEFAULT NULL,
  `CheckMan` varchar(50) DEFAULT NULL,
  `RecordCount` int(11) DEFAULT NULL,
  `Memo` varchar(100) DEFAULT NULL,
  `RedFlag` smallint(6) DEFAULT NULL,
  `RedDate` datetime DEFAULT NULL,
  `RedMan` varchar(50) DEFAULT NULL,
  `HasRed` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`,`OrderNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ckinitstore
-- ----------------------------

-- ----------------------------
-- Table structure for `ckinitstoredetail`
-- ----------------------------
DROP TABLE IF EXISTS `ckinitstoredetail`;
CREATE TABLE `ckinitstoredetail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(20) DEFAULT NULL,
  `SerialNo` int(11) DEFAULT NULL,
  `GoodsNo` varchar(20) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ckinitstoredetail
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', 'admin', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', '1', '男', '本科', '2013-06-28', '2013-06-28', '36010319880999', null, '13809876543', 'vasdfasdfadsf', '导购员', '100000', 'xxxx@163.com', '0', '弄阿克苏打发第三方', '1', '1', '2013-08-07 21:06:02', null, null, null, null);
INSERT INTO `employee` VALUES ('2', 'pk', '彭科', 'e10adc3949ba59abbe56e057f20f883e', '1', null, '男', '高中', '2013-07-24', '2013-07-31', '23412343324', null, null, null, '业务员', null, null, null, null, null, '1', '2013-07-09 14:44:39', null, null, null, null);
INSERT INTO `employee` VALUES ('3', 'wcc', '吴春明', 'e10adc3949ba59abbe56e057f20f883e', '1', '5', '女', '本科', '2013-07-23', '2013-07-26', '188888888', '13241324', '2341234', 'qer123r', '导购员', '10', '2@124.com', '20', '来这个啊京东方卡迪夫', null, null, '2013-07-18 10:53:54', null, null, null, '0');
INSERT INTO `employee` VALUES ('4', 'zyh', '湛原红', 'e10adc3949ba59abbe56e057f20f883e', '1', '30', '男', '高中', '1980-07-27', '2013-08-01', '1234567890', null, '111111', '呃呃呃', '业务员', '5000', 'hczyh_888@163.com', '20', '呃呃呃', null, null, '2013-08-06 10:37:40', null, null, null, '0');
INSERT INTO `employee` VALUES ('5', 'zs', '张三', 'e10adc3949ba59abbe56e057f20f883e', '1', '11', null, '高中', '1971-10-10', '2013-08-06', '11111', null, null, null, '业务员', '1111', null, '10', null, null, null, '2013-08-07 21:17:10', null, null, null, '0');
INSERT INTO `employee` VALUES ('6', 'test', 'test', 'e10adc3949ba59abbe56e057f20f883e', '1', '11', '男', '高中', '2011-08-05', '2013-07-28', '11111', null, '11', '11', '业务员', '11', '11', null, '11', null, '1', '2013-08-10 12:10:30', null, null, null, '0');
INSERT INTO `employee` VALUES ('7', 'ttt', 'ttt', 'e10adc3949ba59abbe56e057f20f883e', '2', '11', null, '高中', null, null, '11111', null, null, null, '业务员', '11', null, null, null, null, '1', '2013-08-10 18:34:01', null, null, null, '0');

-- ----------------------------
-- Table structure for `goodstype`
-- ----------------------------
DROP TABLE IF EXISTS `goodstype`;
CREATE TABLE `goodstype` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '类别名称',
  `remark` varchar(250) DEFAULT NULL COMMENT '备注',
  `pid` bigint(10) DEFAULT NULL COMMENT '父级类别id',
  `num` varchar(20) DEFAULT NULL COMMENT '编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品类别';

-- ----------------------------
-- Records of goodstype
-- ----------------------------
INSERT INTO `goodstype` VALUES ('2', '休闲服', null, '0', '001');
INSERT INTO `goodstype` VALUES ('3', '男式休闲服', null, '2', '001001');
INSERT INTO `goodstype` VALUES ('4', '女式休闲服', null, '2', '001002');
INSERT INTO `goodstype` VALUES ('5', '西装', null, '0', '002');
INSERT INTO `goodstype` VALUES ('6', '男装', null, '5', '002001');
INSERT INTO `goodstype` VALUES ('7', '女装', null, '5', '002002');

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
-- Table structure for `jbstore`
-- ----------------------------
DROP TABLE IF EXISTS `jbstore`;
CREATE TABLE `jbstore` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `StoreNo` varchar(20) NOT NULL DEFAULT '',
  `StoreCode` varchar(50) DEFAULT NULL,
  `StoreName` varchar(50) DEFAULT NULL,
  `TypeNo` varchar(20) DEFAULT NULL,
  `LAndHeight` varchar(50) DEFAULT NULL,
  `Place` varchar(50) DEFAULT NULL,
  `EmployeeNo` varchar(20) DEFAULT NULL,
  `CountQuantity` decimal(18,0) DEFAULT NULL,
  `PriceType` varchar(20) DEFAULT NULL,
  `StopFlag` smallint(6) DEFAULT '0',
  `Memo` char(10) DEFAULT NULL,
  `RetailSTFlag` smallint(6) DEFAULT NULL,
  `OtherFlag` smallint(6) DEFAULT NULL,
  `MrpFlag` smallint(6) DEFAULT NULL,
  `DownLogNo` int(11) DEFAULT NULL,
  `PriceLevel` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`StoreNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jbstore
-- ----------------------------
INSERT INTO `jbstore` VALUES ('1', '1', '1', '男服装', null, '10000', '八百伴', '5', '100', '按件', '1', 'T恤，牛仔裤', null, null, null, null, null);
INSERT INTO `jbstore` VALUES ('2', '2', '239', '材料', null, '1000', '张江', '4', '1888', '批发', null, '布匹', null, null, null, null, null);

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
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1051 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '资料管理', null, '0', '0', null, '1', null, '0', '0', null, '1', null);
INSERT INTO `menu` VALUES ('2', '采购管理', null, '0', '0', null, '2', null, '0', '0', null, '1', null);
INSERT INTO `menu` VALUES ('3', '销售管理', null, '0', '0', null, '3', null, '0', '0', null, '1', null);
INSERT INTO `menu` VALUES ('4', '仓库管理', null, '0', '0', null, '4', null, '0', '0', null, '1', null);
INSERT INTO `menu` VALUES ('5', '财务管理', null, '0', '0', null, '5', null, '0', '0', null, '1', null);
INSERT INTO `menu` VALUES ('6', '报表统计', null, '0', '0', null, '6', null, '0', '0', null, '1', null);
INSERT INTO `menu` VALUES ('114', '员工资料', 'employee', '1', '2', null, '4', null, '11', '0', null, '1', null);
INSERT INTO `menu` VALUES ('113', '商品资料', '#', '1', '2', null, '3', null, '11', '0', null, '1', null);
INSERT INTO `menu` VALUES ('11', '资料管理', null, '1', '1', null, '1', null, '1', '0', null, '1', null);
INSERT INTO `menu` VALUES ('111', '供应商资料', '#', '1', '2', null, '1', null, '11', '0', null, '1', null);
INSERT INTO `menu` VALUES ('112', '客户资料', '#', '1', '2', null, '2', null, '11', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1023', '采购入库单', '#', '1', '2', null, '1', null, '1021', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1021', '采购管理', null, '1', '1', null, '0', null, '2', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1022', '采购订单', '#', '1', '2', null, '0', null, '1021', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1019', '类别资料', null, '1', '2', null, '6', null, '11', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1020', '商品类别', 'goodstype', '1', '3', null, '0', null, '1019', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1024', '采购付款单', '#', '1', '2', null, '2', null, '1021', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1025', '销售管理', null, '1', '1', null, '0', null, '3', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1026', '销售订单', '#', '1', '2', null, '0', null, '1025', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1027', '销售出库单', '#', '1', '2', null, '1', null, '1025', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1028', '销售收款单', '#', '1', '2', null, '2', null, '1025', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1029', '仓库管理', null, '1', '1', null, '0', null, '4', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1030', '仓库调拨单', '#', '1', '2', null, '0', null, '1029', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1031', '其它收发货单', '#', '1', '2', null, '1', null, '1029', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1032', '成本价调整', '#', '1', '2', null, '2', null, '1029', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1033', '盘点表', '#', '1', '2', null, '3', null, '1029', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1037', '期初库存商品录入', null, '1', '1', null, '1', null, '1', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1038', '期初库存商品录入单', '#', '1', '2', null, '0', null, '1037', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1039', '期初库存商品录入单汇总', '#', '1', '2', null, '1', null, '1037', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1040', '期初库存商品录入单明细表', '#', '1', '2', null, '2', null, '1037', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1041', '系统管理', null, '0', '0', null, '7', null, '0', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1042', '系统管理', null, '1', '1', null, '0', null, '1041', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1043', '修改密码', 'employee/pwd', '1', '2', null, '0', null, '1042', '0', 'uppwd', '1', null);
INSERT INTO `menu` VALUES ('1044', '功能菜单', 'menu', '1', '2', null, '1', null, '1042', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1046', '权限配置', 'power', '1', '2', null, '2', null, '1042', '0', 'power', '1', null);
INSERT INTO `menu` VALUES ('1047', '组织定义', 'organization', '1', '2', null, '3', null, '1042', '0', 'organization', '1', null);
INSERT INTO `menu` VALUES ('1048', '部门定义', 'partment', '1', '2', null, '4', null, '1042', '0', 'partment', '1', null);
INSERT INTO `menu` VALUES ('1049', '系统参数配置', '#', '1', '2', null, '5', null, '1042', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1050', '系统表', 'xttables', '1', '2', null, '6', null, '1042', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1036', '仓库资料', 'jbstore', '1', '2', null, '5', null, '11', '0', null, '1', null);

-- ----------------------------
-- Table structure for `organization`
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `addr` varchar(50) DEFAULT NULL,
  `picid` bigint(20) DEFAULT NULL,
  `sortnum` smallint(6) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `num` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization
-- ----------------------------
INSERT INTO `organization` VALUES ('2', '昶源软件', '上海市', null, null, null, '001');

-- ----------------------------
-- Table structure for `partment`
-- ----------------------------
DROP TABLE IF EXISTS `partment`;
CREATE TABLE `partment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `remark` varchar(250) DEFAULT NULL,
  `picid` bigint(20) DEFAULT NULL,
  `orgid` bigint(20) DEFAULT NULL,
  `pid` bigint(10) DEFAULT NULL COMMENT '父级部门id',
  `num` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of partment
-- ----------------------------
INSERT INTO `partment` VALUES ('1', '销售部', null, '4', '2', '0', '001');
INSERT INTO `partment` VALUES ('2', '财务部', null, '1', '2', '0', '002');

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
INSERT INTO `powermenu` VALUES ('1050', '2', '1');
INSERT INTO `powermenu` VALUES ('1049', '2', '1');
INSERT INTO `powermenu` VALUES ('1048', '2', '1');
INSERT INTO `powermenu` VALUES ('1047', '2', '1');
INSERT INTO `powermenu` VALUES ('1046', '2', '1');
INSERT INTO `powermenu` VALUES ('1044', '2', '1');
INSERT INTO `powermenu` VALUES ('1043', '2', '1');
INSERT INTO `powermenu` VALUES ('1042', '2', '1');
INSERT INTO `powermenu` VALUES ('1041', '2', '1');
INSERT INTO `powermenu` VALUES ('1033', '2', '1');
INSERT INTO `powermenu` VALUES ('1032', '2', '1');
INSERT INTO `powermenu` VALUES ('1031', '2', '1');
INSERT INTO `powermenu` VALUES ('1030', '2', '1');
INSERT INTO `powermenu` VALUES ('1029', '2', '1');
INSERT INTO `powermenu` VALUES ('4', '2', '1');
INSERT INTO `powermenu` VALUES ('1028', '2', '1');
INSERT INTO `powermenu` VALUES ('1027', '2', '1');
INSERT INTO `powermenu` VALUES ('1026', '2', '1');
INSERT INTO `powermenu` VALUES ('1025', '2', '1');
INSERT INTO `powermenu` VALUES ('3', '2', '1');
INSERT INTO `powermenu` VALUES ('1024', '2', '1');
INSERT INTO `powermenu` VALUES ('1023', '2', '1');
INSERT INTO `powermenu` VALUES ('1022', '2', '1');
INSERT INTO `powermenu` VALUES ('1021', '2', '1');
INSERT INTO `powermenu` VALUES ('2', '2', '1');
INSERT INTO `powermenu` VALUES ('1020', '2', '1');
INSERT INTO `powermenu` VALUES ('1019', '2', '1');
INSERT INTO `powermenu` VALUES ('1036', '2', '1');
INSERT INTO `powermenu` VALUES ('114', '2', '1');
INSERT INTO `powermenu` VALUES ('113', '2', '1');
INSERT INTO `powermenu` VALUES ('112', '2', '1');
INSERT INTO `powermenu` VALUES ('111', '2', '1');
INSERT INTO `powermenu` VALUES ('11', '2', '1');
INSERT INTO `powermenu` VALUES ('1040', '2', '1');
INSERT INTO `powermenu` VALUES ('1039', '2', '1');
INSERT INTO `powermenu` VALUES ('1038', '2', '1');
INSERT INTO `powermenu` VALUES ('1037', '2', '1');
INSERT INTO `powermenu` VALUES ('1', '2', '1');

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
-- Table structure for `storetype`
-- ----------------------------
DROP TABLE IF EXISTS `storetype`;
CREATE TABLE `storetype` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `type_no` varchar(20) DEFAULT NULL,
  `type_code` varchar(50) DEFAULT NULL,
  `type_name` varchar(50) DEFAULT NULL,
  `pid` bigint(20) DEFAULT NULL,
  `auto_code` varchar(100) DEFAULT NULL,
  `remark` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storetype
-- ----------------------------

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

-- ----------------------------
-- Table structure for `xttables`
-- ----------------------------
DROP TABLE IF EXISTS `xttables`;
CREATE TABLE `xttables` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `TableName` varchar(50) DEFAULT '0' COMMENT '表名',
  `TLevel` smallint(2) DEFAULT '0',
  `TType` smallint(2) DEFAULT '0' COMMENT '1 JB  2 JH 3 XS 4 CK 5 CW 6 XT 7 其他',
  `remark` char(10) DEFAULT '0',
  `SysDefault` smallint(2) DEFAULT '0',
  `CTableName` varchar(50) DEFAULT '0' COMMENT '表中文名称',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统表信息';

-- ----------------------------
-- Records of xttables
-- ----------------------------
