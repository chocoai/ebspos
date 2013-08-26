-- --------------------------------------------------------
-- 主机                            :127.0.0.1
-- 服务器版本                         :5.0.67-community-log - MySQL Community Edition (GPL)
-- 服务器操作系统                       :Win32
-- HeidiSQL 版本                   :7.0.0.4278
-- 创建                            :2013-08-26 13:46:02
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 ebspos.calendar 结构
DROP TABLE IF EXISTS `calendar`;
CREATE TABLE IF NOT EXISTS `calendar` (
  `Id` int(11) NOT NULL auto_increment COMMENT '日程主键',
  `Subject` varchar(200) default NULL COMMENT '日程标题',
  `Location` varchar(200) default NULL COMMENT '地点',
  `Description` varchar(500) default NULL COMMENT '说明',
  `CalendarType` tinyint(4) default '1' COMMENT '日程类型\r\n            1	个人日程\r\n            2	部门日程',
  `StartTime` datetime NOT NULL COMMENT '开始时间',
  `EndTime` datetime NOT NULL COMMENT '结束时间',
  `IsAllDayEvent` bit(1) NOT NULL default '\0' COMMENT '是否全天日程',
  `HasAttachment` bit(1) NOT NULL default '\0' COMMENT '是否有附件',
  `Category` varchar(400) default NULL COMMENT '分类',
  `InstanceType` tinyint(4) NOT NULL COMMENT '实例类型\r\n            0	Single（一般日程）\r\n            1	Master（循环主日程）\r\n            2	Instance（循环实例日程）\r\n            3	Exception （错误）\r\n            4	MeetingRequest（会议安排）',
  `Attendees` varchar(500) default NULL COMMENT '参与人',
  `AttendeeNames` varchar(500) default NULL COMMENT '参与人姓名',
  `OtherAttendee` varchar(500) default NULL COMMENT '其他参与人',
  `UPAccount` bigint(20) default NULL COMMENT '更新人账号',
  `UPName` varchar(100) default NULL COMMENT '更新人姓名',
  `UPTime` datetime default NULL COMMENT '最后一次更新时间',
  `RecurringRule` varchar(1000) default NULL COMMENT '循环规则',
  PRIMARY KEY  (`Id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.calendar 的数据: 0 rows
DELETE FROM `calendar`;
/*!40000 ALTER TABLE `calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar` ENABLE KEYS */;


-- 导出  表 ebspos.ckinitstore 结构
DROP TABLE IF EXISTS `ckinitstore`;
CREATE TABLE IF NOT EXISTS `ckinitstore` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderNo` varchar(20) NOT NULL,
  `OrderDate` datetime default NULL,
  `StoreNo` varchar(20) default NULL,
  `BillOrderNo` varchar(20) default NULL,
  `RelatedBillNo` varchar(20) default NULL,
  `DepartmentNo` varchar(20) default NULL,
  `EmployeeNo` varchar(20) default NULL,
  `Operator` varchar(20) default NULL,
  `CKAmount` decimal(10,0) default NULL,
  `CheckFlag` smallint(6) default NULL,
  `CheckDate` datetime default NULL,
  `CheckMan` varchar(50) default NULL,
  `RecordCount` int(11) default NULL,
  `Memo` varchar(100) default NULL,
  `RedFlag` smallint(6) default NULL,
  `RedDate` datetime default NULL,
  `RedMan` varchar(50) default NULL,
  `HasRed` smallint(6) default NULL,
  PRIMARY KEY  (`id`,`OrderNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.ckinitstore 的数据: ~0 rows ((大约))
DELETE FROM `ckinitstore`;
/*!40000 ALTER TABLE `ckinitstore` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckinitstore` ENABLE KEYS */;


-- 导出  表 ebspos.ckinitstoredetail 结构
DROP TABLE IF EXISTS `ckinitstoredetail`;
CREATE TABLE IF NOT EXISTS `ckinitstoredetail` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderNo` varchar(20) default NULL,
  `SerialNo` int(11) default NULL,
  `GoodsNo` varchar(20) default NULL,
  `SUnitQuantity` decimal(10,0) default NULL,
  `MUnitQuantity` decimal(10,0) default NULL,
  `UnitQuantity` decimal(10,0) default NULL,
  `Quantity` decimal(10,0) default NULL,
  `CKPrice` decimal(10,0) default NULL,
  `CKAmount` decimal(10,0) default NULL,
  `Unit` varchar(20) default NULL,
  `MixUnit` varchar(20) default NULL,
  `UnitRate` varchar(20) default NULL,
  `RelatedOrderNo` varchar(20) default NULL,
  `OrderSerialNo` int(11) default NULL,
  `Memo` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.ckinitstoredetail 的数据: ~0 rows ((大约))
DELETE FROM `ckinitstoredetail`;
/*!40000 ALTER TABLE `ckinitstoredetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckinitstoredetail` ENABLE KEYS */;


-- 导出  表 ebspos.employee 结构
DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `id` bigint(20) NOT NULL auto_increment,
  `usr_no` varchar(11) NOT NULL,
  `usr_name` varchar(20) default NULL,
  `pwd` varchar(50) default NULL,
  `dep_no` int(11) default NULL,
  `age` tinyint(4) default NULL,
  `gender` varchar(20) default NULL,
  `edu_bg` varchar(50) default NULL,
  `birthday` varchar(50) default NULL,
  `entry_date` varchar(50) default NULL,
  `id_card_no` bigint(20) default NULL,
  `fax_no` bigint(20) default NULL,
  `phone_no` bigint(20) default NULL,
  `address` varchar(255) default NULL,
  `position` varchar(50) default NULL,
  `salary` int(11) default NULL,
  `email` varchar(255) default NULL,
  `royalty_rate` decimal(10,0) default NULL,
  `remarks` varchar(255) default NULL,
  `is_use` tinyint(4) default NULL,
  `usr_type` tinyint(4) default NULL,
  `upd_time` datetime default NULL,
  `crd_time` datetime default NULL,
  `upd_usr` varchar(255) default NULL,
  `crd_usr` varchar(255) default NULL,
  `del_flg` tinyint(4) default '0',
  PRIMARY KEY  (`id`,`usr_no`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.employee 的数据: ~9 rows ((大约))
DELETE FROM `employee`;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` (`id`, `usr_no`, `usr_name`, `pwd`, `dep_no`, `age`, `gender`, `edu_bg`, `birthday`, `entry_date`, `id_card_no`, `fax_no`, `phone_no`, `address`, `position`, `salary`, `email`, `royalty_rate`, `remarks`, `is_use`, `usr_type`, `upd_time`, `crd_time`, `upd_usr`, `crd_usr`, `del_flg`) VALUES
	(1, 'admin', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, 1, '男', '本科', '2013-06-28', '2013-06-28', 36010319880999, NULL, 13809876543, 'vasdfasdfadsf', '导购员', 100000, 'xxxx@163.com', 0, '弄阿克苏打发第三方', 1, 1, '2013-08-07 21:06:02', NULL, NULL, NULL, NULL),
	(2, 'pk', '彭科', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL, '男', '高中', '2013-07-24', '2013-07-31', 23412343324, NULL, NULL, NULL, '业务员', NULL, NULL, NULL, NULL, NULL, 1, '2013-07-09 14:44:39', NULL, NULL, NULL, NULL),
	(3, 'wcc', '吴春明', 'e10adc3949ba59abbe56e057f20f883e', 1, 5, '女', '本科', '2013-07-23', '2013-07-26', 188888888, 13241324, 2341234, 'qer123r', '导购员', 10, '2@124.com', 20, '来这个啊京东方卡迪夫', NULL, NULL, '2013-07-18 10:53:54', NULL, NULL, NULL, 0),
	(4, 'zyh', '湛原红', 'e10adc3949ba59abbe56e057f20f883e', 1, 30, '男', '高中', '1980-07-27', '2013-08-01', 1234567890, NULL, 111111, '呃呃呃', '业务员', 5000, 'hczyh_888@163.com', 20, '呃呃呃', NULL, NULL, '2013-08-06 10:37:40', NULL, NULL, NULL, 0),
	(5, 'zs', '张三', 'e10adc3949ba59abbe56e057f20f883e', 1, 11, NULL, '高中', '1971-10-10', '2013-08-06', 11111, NULL, NULL, NULL, '业务员', 1111, NULL, 10, NULL, NULL, NULL, '2013-08-07 21:17:10', NULL, NULL, NULL, 0),
	(6, 'test', 'test', 'e10adc3949ba59abbe56e057f20f883e', 1, 11, '男', '高中', '2011-08-05', '2013-07-28', 11111, NULL, 11, '11', '业务员', 11, '11', NULL, '11', NULL, 1, '2013-08-10 12:10:30', NULL, NULL, NULL, 0),
	(7, 'ttt', 'ttt', 'e10adc3949ba59abbe56e057f20f883e', 2, 11, NULL, '高中', NULL, NULL, 11111, NULL, NULL, NULL, '业务员', 11, NULL, NULL, NULL, NULL, 1, '2013-08-10 18:34:01', NULL, NULL, NULL, 0),
	(8, 'fdsf', 'fdfd', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL, NULL, '高中', NULL, NULL, 11111, NULL, NULL, NULL, '业务员', NULL, NULL, NULL, NULL, NULL, 1, '2013-08-18 11:46:19', NULL, NULL, NULL, 0),
	(9, '454654', '6565', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL, NULL, '高中', NULL, NULL, 6565656565, NULL, NULL, NULL, '业务员', NULL, NULL, NULL, NULL, NULL, 1, '2013-08-18 11:46:31', NULL, NULL, NULL, 0);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;


-- 导出  表 ebspos.jbgoods 结构
DROP TABLE IF EXISTS `jbgoods`;
CREATE TABLE IF NOT EXISTS `jbgoods` (
  `id` bigint(20) NOT NULL auto_increment,
  `GoodsCode` varchar(50) default NULL COMMENT '商品编号',
  `GoodsName` varchar(100) default NULL COMMENT '商品名称',
  `GoodsTypeNo` bigint(20) default NULL COMMENT '大类',
  `subgoodstypeno` bigint(20) default NULL COMMENT '中类',
  `smallgoodstypeno` bigint(20) default NULL COMMENT '小类',
  `BrandNo` varchar(50) default NULL COMMENT '品牌',
  `ProduceArea` varchar(255) default NULL COMMENT '产地',
  `ProduceName` varchar(255) default NULL COMMENT '生产厂家',
  `Clolor` varchar(255) default NULL COMMENT '颜色',
  `BarCode` varchar(255) default NULL COMMENT '条码',
  `Model` varchar(255) default NULL COMMENT '规格型号',
  `BaseUnit` varchar(255) default NULL COMMENT '基本单位',
  `BRefPrice` decimal(10,2) default NULL COMMENT '参考进价',
  `SRefPrice` decimal(10,2) default NULL COMMENT '参考销价',
  `CostPrice` decimal(10,2) default NULL COMMENT '成本价',
  `Picture` blob COMMENT '图片',
  `StopFlag` smallint(1) default NULL COMMENT '是否停用',
  `Remark` varchar(255) default NULL COMMENT '备注',
  `Season` varchar(1) default NULL COMMENT '季度‘1、2、3、4’',
  `YearBy` varchar(4) default NULL COMMENT '年份',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品资料表';

-- 正在导出表  ebspos.jbgoods 的数据: ~1 rows ((大约))
DELETE FROM `jbgoods`;
/*!40000 ALTER TABLE `jbgoods` DISABLE KEYS */;
INSERT INTO `jbgoods` (`id`, `GoodsCode`, `GoodsName`, `GoodsTypeNo`, `subgoodstypeno`, `smallgoodstypeno`, `BrandNo`, `ProduceArea`, `ProduceName`, `Clolor`, `BarCode`, `Model`, `BaseUnit`, `BRefPrice`, `SRefPrice`, `CostPrice`, `Picture`, `StopFlag`, `Remark`, `Season`, `YearBy`) VALUES
	(1, '1111', '123', 30, 32, 33, '19', '1', '1', NULL, '1', '333', '14', 11.00, 11.00, 11.00, NULL, 1, 'wwww', '1', '2011');
/*!40000 ALTER TABLE `jbgoods` ENABLE KEYS */;


-- 导出  表 ebspos.jbstore 结构
DROP TABLE IF EXISTS `jbstore`;
CREATE TABLE IF NOT EXISTS `jbstore` (
  `id` bigint(20) NOT NULL auto_increment,
  `StoreNo` varchar(20) NOT NULL default '',
  `StoreCode` varchar(50) default NULL,
  `StoreName` varchar(50) default NULL,
  `TypeNo` varchar(20) default NULL,
  `LAndHeight` varchar(50) default NULL,
  `Place` varchar(50) default NULL,
  `EmployeeNo` varchar(20) default NULL,
  `CountQuantity` decimal(18,0) default NULL,
  `PriceType` varchar(20) default NULL,
  `StopFlag` smallint(6) default '0',
  `Memo` char(10) default NULL,
  `RetailSTFlag` smallint(6) default NULL,
  `OtherFlag` smallint(6) default NULL,
  `MrpFlag` smallint(6) default NULL,
  `DownLogNo` int(11) default NULL,
  `PriceLevel` int(11) default NULL,
  PRIMARY KEY  (`id`,`StoreNo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='仓库信息';

-- 正在导出表  ebspos.jbstore 的数据: ~2 rows ((大约))
DELETE FROM `jbstore`;
/*!40000 ALTER TABLE `jbstore` DISABLE KEYS */;
INSERT INTO `jbstore` (`id`, `StoreNo`, `StoreCode`, `StoreName`, `TypeNo`, `LAndHeight`, `Place`, `EmployeeNo`, `CountQuantity`, `PriceType`, `StopFlag`, `Memo`, `RetailSTFlag`, `OtherFlag`, `MrpFlag`, `DownLogNo`, `PriceLevel`) VALUES
	(1, '1', '1', '男服装', NULL, '10000', '八百伴', '5', 100, '按件', 1, 'T恤，牛仔裤', NULL, NULL, NULL, NULL, NULL),
	(2, '2', '239', '材料', NULL, '1000', '张江', '4', 1888, '批发', NULL, '布匹', NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `jbstore` ENABLE KEYS */;


-- 导出  表 ebspos.menu 结构
DROP TABLE IF EXISTS `menu`;
CREATE TABLE IF NOT EXISTS `menu` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL,
  `url` varchar(50) default NULL,
  `type` smallint(6) default NULL,
  `menulevel` smallint(6) default '0',
  `icon` varchar(50) default NULL,
  `ordernum` int(11) default '0',
  `safecode` varchar(20) default NULL,
  `pid` bigint(20) default '0',
  `target` smallint(6) default '0',
  `rel` varchar(30) default NULL,
  `enable` smallint(6) default '1',
  `remark` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1051 DEFAULT CHARSET=utf8 COMMENT='系统菜单';

-- 正在导出表  ebspos.menu 的数据: 39 rows
DELETE FROM `menu`;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` (`id`, `name`, `url`, `type`, `menulevel`, `icon`, `ordernum`, `safecode`, `pid`, `target`, `rel`, `enable`, `remark`) VALUES
	(1, '资料管理', NULL, 0, 0, NULL, 1, NULL, 0, 0, NULL, 1, NULL),
	(2, '采购管理', NULL, 0, 0, NULL, 2, NULL, 0, 0, NULL, 1, NULL),
	(3, '销售管理', NULL, 0, 0, NULL, 3, NULL, 0, 0, NULL, 1, NULL),
	(4, '仓库管理', NULL, 0, 0, NULL, 4, NULL, 0, 0, NULL, 1, NULL),
	(5, '财务管理', NULL, 0, 0, NULL, 5, NULL, 0, 0, NULL, 1, NULL),
	(6, '报表统计', NULL, 0, 0, NULL, 6, NULL, 0, 0, NULL, 1, NULL),
	(114, '员工资料', 'employee', 1, 2, NULL, 4, NULL, 11, 0, NULL, 1, NULL),
	(113, '商品资料', 'jbgoods', 1, 2, NULL, 3, NULL, 11, 0, NULL, 1, NULL),
	(11, '资料管理', NULL, 1, 1, NULL, 1, NULL, 1, 0, NULL, 1, NULL),
	(111, '供应商资料', '#', 1, 2, NULL, 1, NULL, 11, 0, NULL, 1, NULL),
	(112, '客户资料', '#', 1, 2, NULL, 2, NULL, 11, 0, NULL, 1, NULL),
	(1023, '采购入库单', '#', 1, 2, NULL, 1, NULL, 1021, 0, NULL, 1, NULL),
	(1021, '采购管理', NULL, 1, 1, NULL, 0, NULL, 2, 0, NULL, 1, NULL),
	(1022, '采购订单', '#', 1, 2, NULL, 0, NULL, 1021, 0, NULL, 1, NULL),
	(1019, '定义类别', 'types', 1, 2, NULL, 6, NULL, 11, 0, NULL, 1, NULL),
	(1024, '采购付款单', '#', 1, 2, NULL, 2, NULL, 1021, 0, NULL, 1, NULL),
	(1025, '销售管理', NULL, 1, 1, NULL, 0, NULL, 3, 0, NULL, 1, NULL),
	(1026, '销售订单', '#', 1, 2, NULL, 0, NULL, 1025, 0, NULL, 1, NULL),
	(1027, '销售出库单', '#', 1, 2, NULL, 1, NULL, 1025, 0, NULL, 1, NULL),
	(1028, '销售收款单', '#', 1, 2, NULL, 2, NULL, 1025, 0, NULL, 1, NULL),
	(1029, '仓库管理', NULL, 1, 1, NULL, 0, NULL, 4, 0, NULL, 1, NULL),
	(1030, '仓库调拨单', '#', 1, 2, NULL, 0, NULL, 1029, 0, NULL, 1, NULL),
	(1031, '其它收发货单', '#', 1, 2, NULL, 1, NULL, 1029, 0, NULL, 1, NULL),
	(1032, '成本价调整', '#', 1, 2, NULL, 2, NULL, 1029, 0, NULL, 1, NULL),
	(1033, '盘点表', '#', 1, 2, NULL, 3, NULL, 1029, 0, NULL, 1, NULL),
	(1037, '期初库存商品录入', NULL, 1, 1, NULL, 1, NULL, 1, 0, NULL, 1, NULL),
	(1038, '期初库存商品录入单', 'ckinitstore', 1, 2, NULL, 0, NULL, 1037, 0, NULL, 1, NULL),
	(1039, '期初库存商品录入单汇总', '#', 1, 2, NULL, 1, NULL, 1037, 0, NULL, 1, NULL),
	(1040, '期初库存商品录入单明细表', '#', 1, 2, NULL, 2, NULL, 1037, 0, NULL, 1, NULL),
	(1041, '系统管理', NULL, 0, 0, NULL, 7, NULL, 0, 0, NULL, 1, NULL),
	(1042, '系统管理', NULL, 1, 1, NULL, 0, NULL, 1041, 0, NULL, 1, NULL),
	(1043, '修改密码', 'employee/pwd', 1, 2, NULL, 0, NULL, 1042, 0, 'uppwd', 1, NULL),
	(1044, '功能菜单', 'menu', 1, 2, NULL, 1, NULL, 1042, 0, NULL, 1, NULL),
	(1046, '权限配置', 'power', 1, 2, NULL, 2, NULL, 1042, 0, 'power', 1, NULL),
	(1047, '组织定义', 'organization', 1, 2, NULL, 3, NULL, 1042, 0, 'organization', 1, NULL),
	(1048, '部门定义', 'partment', 1, 2, NULL, 4, NULL, 1042, 0, 'partment', 1, NULL),
	(1049, '系统参数配置', '#', 1, 2, NULL, 5, NULL, 1042, 0, NULL, 1, NULL),
	(1050, '系统表', 'xttables', 1, 2, NULL, 6, NULL, 1042, 0, NULL, 1, NULL),
	(1036, '仓库资料', 'jbstore', 1, 2, NULL, 5, NULL, 11, 0, NULL, 1, NULL);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;


-- 导出  表 ebspos.organization 结构
DROP TABLE IF EXISTS `organization`;
CREATE TABLE IF NOT EXISTS `organization` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(30) default NULL,
  `addr` varchar(50) default NULL,
  `picid` bigint(20) default NULL,
  `sortnum` smallint(6) default NULL,
  `remark` varchar(100) default NULL,
  `num` varchar(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='组织';

-- 正在导出表  ebspos.organization 的数据: 1 rows
DELETE FROM `organization`;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` (`id`, `name`, `addr`, `picid`, `sortnum`, `remark`, `num`) VALUES
	(2, '昶源软件', '上海市', NULL, NULL, NULL, '001');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;


-- 导出  表 ebspos.partment 结构
DROP TABLE IF EXISTS `partment`;
CREATE TABLE IF NOT EXISTS `partment` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `remark` varchar(250) default NULL,
  `picid` bigint(20) default NULL,
  `orgid` bigint(20) default NULL,
  `pid` bigint(10) default NULL COMMENT '父级部门id',
  `num` varchar(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='部门';

-- 正在导出表  ebspos.partment 的数据: ~13 rows ((大约))
DELETE FROM `partment`;
/*!40000 ALTER TABLE `partment` DISABLE KEYS */;
INSERT INTO `partment` (`id`, `name`, `remark`, `picid`, `orgid`, `pid`, `num`) VALUES
	(1, '销售部', NULL, 4, 2, 0, '001'),
	(2, '财务部', NULL, 1, 2, 0, '002'),
	(3, '22222', NULL, 1, 2, 0, '222'),
	(4, '33', NULL, 1, 2, 0, '33'),
	(5, '33', NULL, 1, 2, 0, '44'),
	(6, '23', NULL, 1, 2, 0, '23'),
	(7, '21', NULL, 1, 2, 0, '21'),
	(8, '22', NULL, 1, 2, 0, '222'),
	(9, '44', NULL, 1, 2, 0, '234'),
	(10, '21', NULL, 1, 2, 0, '112'),
	(11, '111', NULL, 1, 2, 0, '121'),
	(12, '3343', NULL, 1, 2, 0, '1234'),
	(13, '财务二级部门', NULL, 1, 2, 2, 'ejb');
/*!40000 ALTER TABLE `partment` ENABLE KEYS */;


-- 导出  表 ebspos.powermenu 结构
DROP TABLE IF EXISTS `powermenu`;
CREATE TABLE IF NOT EXISTS `powermenu` (
  `menuid` bigint(20) NOT NULL,
  `objid` bigint(20) NOT NULL,
  `type` smallint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.powermenu 的数据: 48 rows
DELETE FROM `powermenu`;
/*!40000 ALTER TABLE `powermenu` DISABLE KEYS */;
INSERT INTO `powermenu` (`menuid`, `objid`, `type`) VALUES
	(6, 1, 0),
	(5, 1, 0),
	(4, 1, 0),
	(3, 1, 0),
	(2, 1, 0),
	(1, 1, 0),
	(11, 1, 0),
	(111, 1, 0),
	(112, 1, 0),
	(113, 1, 0),
	(114, 1, 0),
	(1050, 2, 1),
	(1049, 2, 1),
	(1048, 2, 1),
	(1047, 2, 1),
	(1046, 2, 1),
	(1044, 2, 1),
	(1043, 2, 1),
	(1042, 2, 1),
	(1041, 2, 1),
	(1033, 2, 1),
	(1032, 2, 1),
	(1031, 2, 1),
	(1030, 2, 1),
	(1029, 2, 1),
	(4, 2, 1),
	(1028, 2, 1),
	(1027, 2, 1),
	(1026, 2, 1),
	(1025, 2, 1),
	(3, 2, 1),
	(1024, 2, 1),
	(1023, 2, 1),
	(1022, 2, 1),
	(1021, 2, 1),
	(2, 2, 1),
	(1019, 2, 1),
	(1036, 2, 1),
	(114, 2, 1),
	(113, 2, 1),
	(112, 2, 1),
	(111, 2, 1),
	(11, 2, 1),
	(1040, 2, 1),
	(1039, 2, 1),
	(1038, 2, 1),
	(1037, 2, 1),
	(1, 2, 1);
/*!40000 ALTER TABLE `powermenu` ENABLE KEYS */;


-- 导出  表 ebspos.role 结构
DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL,
  `remark` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色';

-- 正在导出表  ebspos.role 的数据: 2 rows
DELETE FROM `role`;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id`, `name`, `remark`) VALUES
	(3, '员工', NULL),
	(2, '管理员', 'fds');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;


-- 导出  表 ebspos.storetype 结构
DROP TABLE IF EXISTS `storetype`;
CREATE TABLE IF NOT EXISTS `storetype` (
  `id` bigint(20) NOT NULL default '0',
  `type_no` varchar(20) default NULL,
  `type_code` varchar(50) default NULL,
  `type_name` varchar(50) default NULL,
  `pid` bigint(20) default NULL,
  `auto_code` varchar(100) default NULL,
  `remark` varchar(200) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.storetype 的数据: ~0 rows ((大约))
DELETE FROM `storetype`;
/*!40000 ALTER TABLE `storetype` DISABLE KEYS */;
/*!40000 ALTER TABLE `storetype` ENABLE KEYS */;


-- 导出  表 ebspos.types 结构
DROP TABLE IF EXISTS `types`;
CREATE TABLE IF NOT EXISTS `types` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(50) default NULL COMMENT '类别名称',
  `remark` varchar(250) default NULL COMMENT '备注',
  `pid` bigint(10) default NULL COMMENT '父级类别id',
  `num` varchar(20) default NULL COMMENT '编码',
  `level` tinyint(4) default NULL COMMENT '级别',
  `path` varchar(100) default NULL COMMENT '全路径',
  `function` varchar(100) default NULL COMMENT '功能类别',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定义类别';

-- 正在导出表  ebspos.types 的数据: ~17 rows ((大约))
DELETE FROM `types`;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` (`id`, `name`, `remark`, `pid`, `num`, `level`, `path`, `function`) VALUES
	(9, '计量单位', NULL, 0, 'jldw', 1, '0-9', '计量单位'),
	(14, '件', NULL, 9, 'jian', 2, '9-14', '计量单位'),
	(15, '个', NULL, 9, 'ge', 2, '9-15', '计量单位'),
	(16, '品牌', NULL, 0, 'pp', 1, '0-16', '品牌'),
	(17, '服装', NULL, 0, 'fuz', 1, '0-17', NULL),
	(18, '品牌一', NULL, 16, 'pp1', 2, '16-18', '品牌'),
	(19, '品牌二', NULL, 16, 'pp2', 2, '16-19', '品牌'),
	(20, '运动装', NULL, 17, 'ydz', 2, '17-20', NULL),
	(21, '儿童运动装', NULL, 20, 'rtydz', 3, '17-20-21', NULL),
	(22, '斤', NULL, 9, 'jin', NULL, NULL, '计量单位'),
	(23, '辆', NULL, 9, 'liang', NULL, NULL, '计量单位'),
	(24, '成人运动装', NULL, 20, 'cr', NULL, NULL, NULL),
	(29, '商品类别', NULL, 0, 'dl', NULL, NULL, '商品类别'),
	(30, '商品大类一', NULL, 29, 'dl', NULL, NULL, '商品类别'),
	(31, '商品大类二', NULL, 29, 'dl2', NULL, NULL, '商品类别'),
	(32, '商品中类一', NULL, 30, 'zl', NULL, NULL, '商品类别'),
	(33, '商品小类一', NULL, 32, 'xl', NULL, NULL, '商品类别');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;


-- 导出  表 ebspos.userrole 结构
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE IF NOT EXISTS `userrole` (
  `userid` bigint(20) NOT NULL,
  `roleid` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- 正在导出表  ebspos.userrole 的数据: 2 rows
DELETE FROM `userrole`;
/*!40000 ALTER TABLE `userrole` DISABLE KEYS */;
INSERT INTO `userrole` (`userid`, `roleid`) VALUES
	(1, 2),
	(1, 3);
/*!40000 ALTER TABLE `userrole` ENABLE KEYS */;


-- 导出  表 ebspos.xttables 结构
DROP TABLE IF EXISTS `xttables`;
CREATE TABLE IF NOT EXISTS `xttables` (
  `id` int(10) NOT NULL auto_increment,
  `tablename` varchar(50) default '0' COMMENT '表名',
  `tlevel` smallint(2) default '0',
  `ttype` smallint(2) default '0' COMMENT '1 JB  2 JH 3 XS 4 CK 5 CW 6 XT 7 其他',
  `remark` char(10) default '0',
  `sysdefault` smallint(2) default '0',
  `ctablename` varchar(50) default '0' COMMENT '表中文名称',
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='系统表信息';

-- 正在导出表  ebspos.xttables 的数据: ~12 rows ((大约))
DELETE FROM `xttables`;
/*!40000 ALTER TABLE `xttables` DISABLE KEYS */;
INSERT INTO `xttables` (`id`, `tablename`, `tlevel`, `ttype`, `remark`, `sysdefault`, `ctablename`) VALUES
	(1, 'xttables', 0, 6, '记录系统表信息', 0, '系统表'),
	(2, 'JBStore', 0, 1, '定义仓库', 0, '仓库信息'),
	(11, 'calendar', 0, 0, NULL, 0, '日程表'),
	(12, 'employee', 0, 1, NULL, 0, '员工信息表'),
	(13, 'types', 0, 1, NULL, 0, '定义类别'),
	(14, 'jbgoods', 0, 1, NULL, 0, '商品资料表'),
	(15, 'menu', 0, 6, NULL, 0, '系统菜单表'),
	(16, 'organization', 0, 1, '定义组织', 0, '组织表'),
	(17, 'partment', 0, 1, NULL, 0, '部门'),
	(18, 'role', 0, 6, NULL, 0, '角色'),
	(19, 'userrole', 0, 6, NULL, 0, '用户角色'),
	(20, 'powermenu', 0, 6, NULL, 0, '权限');
/*!40000 ALTER TABLE `xttables` ENABLE KEYS */;


-- 导出  表 blog.article 结构
DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(200) NOT NULL,
  `createDateTime` datetime NOT NULL,
  `type` int(11) NOT NULL default '0',
  `url` varchar(200) default NULL,
  `viewCount` int(11) NOT NULL default '0',
  `replyCount` int(11) NOT NULL default '0',
  `content` text NOT NULL,
  `categorySubId` int(11) default NULL,
  `tags` varchar(300) NOT NULL,
  `projectId` int(11) default NULL,
  `finish` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- 正在导出表  blog.article 的数据: ~2 rows ((大约))
DELETE FROM `article`;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`id`, `title`, `createDateTime`, `type`, `url`, `viewCount`, `replyCount`, `content`, `categorySubId`, `tags`, `projectId`, `finish`) VALUES
	(2, '我的ABAP命名规范', '2012-12-11 17:33:44', 0, '', 230, 0, '<h3>\n	<strong><span style="background-color:#FFFFFF;color:#FF9900;line-height:2;"><span style="line-height:1.5;">目录</span><span></span></span></strong> \n</h3>\n<h4>\n	<ul>\n		<li>\n			<span style="color:#337FE5;"><span style="color:#337FE5;"><a href="#g_type">全局类型</a></span></span> \n		</li>\n		<li>\n			<span style="color:#337FE5;"><a href="#g_cns">全局常量</a></span> \n		</li>\n		<li>\n			<span style="color:#337FE5;"><a href="#g_var">全局变量</a></span> \n		</li>\n		<li>\n			<span style="color:#337FE5;"><span style="color:#337FE5;"><a href="#l_var">局部变量</a></span> </span> \n		</li>\n	</ul>\n</h4>\n<h3>\n	<span style="color:#FF9900;"><a name="g_type"></a>全局类型</span> \n</h3>\n<ol>\n	<li>\n		<span><span>表类型</span><br />\n<pre class="prettyprint brush:abap">TYP_TAB_*</pre>\n</span> \n	</li>\n	<li>\n		<span><span>结构体类型</span><br />\n<pre class="prettyprint brush:abap">TYP_*</pre>\n</span> \n	</li>\n</ol>\n<p>\n	<span></span> \n</p>\n<h3>\n	<span style="color:#FF9900;"><a name="g_cns"></a>全局常量</span> \n</h3>\n<ol>\n	<li>\n		<span>表类型常量<br />\n<pre class="prettyprint brush:abap">CNS_TAB_*</pre>\n</span> \n	</li>\n	<li>\n		<span>结构体类型常量<br />\n<pre class="prettyprint brush:abap">CNS_*</pre>\n</span> \n	</li>\n</ol>\n<h3>\n	<span style="color:#FF9900;"><a name="g_var"></a>全局变量</span> \n</h3>\n<ol>\n	<li>\n		<span>表类型变量<br />\n<pre class="prettyprint brush:abap">TAB_*</pre>\n</span> \n	</li>\n	<li>\n		<span>结构体类型变量<br />\n<span></span> \n<pre class="prettyprint brush:abap">W_*</pre>\n</span> \n	</li>\n</ol>\n<h3>\n	<span style="color:#FF9900;"><a name="l_var"></a>局部变量</span> \n</h3>\n<ol>\n	<li>\n		<span>表类型局部变量<br />\n<pre class="prettyprint brush:abap">L_TAB_*</pre>\n</span> \n	</li>\n	<li>\n		<span>结构体类型变量<br />\n<pre class="prettyprint brush:abap">L_W_*</pre>\n</span> \n	</li>\n</ol>', 1, 'sap,abap,types', 2, 1),
	(45, 'SAP IMG 解释', '2013-01-28 17:36:50', 1, 'http://www.cnblogs.com/mybi/archive/2010/12/21/1912852.html', 10, 0, '<p>\n	<span style="line-height:2;"><strong>IMG</strong> - Implementation Guide(IMG)是SAP系统的配置工具，它可按你公司的要求配置SAP系统以适合你公司的要求。</span>\n</p>\n<p>\n	<span style="line-height:2;">有三种类型的IMG，分别是:</span>\n</p>\n<p>\n	<span style="line-height:2;">1. SAP Reference IMG，可在这里配置SAP系统的所有功能。</span>\n</p>\n<p>\n	<span style="line-height:2;">2. Project IMGs，它基于Rrference IMG，可为某个项目进行单独配置，比如我们可建立一个FI的Project IMGs，方便配置。</span>\n</p>\n<p>\n	<span style="line-height:2;">3. Project view IMGs，在Project IMGs里的Project views里设置，在Project IMGs里再建立一个视图，把一些配置选项添加到该视图里。通过这样一层层的分工，就可把Reference IMG里的配置分配给不同的人员进行维护。</span>\n</p>\n<span style="line-height:2;"> 我们可为不同版本的SAP系统建立IMG，如4.0x，4.5x。这种IMG叫做版本相关IMG。通过“help”--“Release notes”菜单可显示各个SAP发布版的区别。\n我们可用事务码“spro”来进入SAP Reference IMG。使用“spro_admin”进入project IMGs。</span>', 1, 'sap,img', 1, 1);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;


-- 导出  表 blog.category_sub 结构
DROP TABLE IF EXISTS `category_sub`;
CREATE TABLE IF NOT EXISTS `category_sub` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `pId` int(11) default NULL,
  `order` int(3) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- 正在导出表  blog.category_sub 的数据: ~13 rows ((大约))
DELETE FROM `category_sub`;
/*!40000 ALTER TABLE `category_sub` DISABLE KEYS */;
INSERT INTO `category_sub` (`id`, `name`, `pId`, `order`) VALUES
	(1, '基础知识', 1, 0),
	(3, 'JFINAL', 2, 0),
	(4, 'FUNCTION详解', 1, 0),
	(6, 'javascript', 3, 0),
	(7, 'css', 3, 0),
	(8, '谈谈生活', 4, 0),
	(9, '软件分享', 4, 2),
	(10, '图片展示', 4, 0),
	(11, '开发需知', 1, 0),
	(12, '代码分享', 2, 0),
	(13, 'SAPJCO', 1, 0),
	(15, 'ABAP', 6, 0),
	(16, 'SAP', 6, 1);
/*!40000 ALTER TABLE `category_sub` ENABLE KEYS */;


-- 导出  表 blog.category_super 结构
DROP TABLE IF EXISTS `category_super`;
CREATE TABLE IF NOT EXISTS `category_super` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `order` int(3) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 正在导出表  blog.category_super 的数据: ~5 rows ((大约))
DELETE FROM `category_super`;
/*!40000 ALTER TABLE `category_super` DISABLE KEYS */;
INSERT INTO `category_super` (`id`, `name`, `order`) VALUES
	(1, 'ABAP', 0),
	(2, 'JAVA', 1),
	(3, 'WEB技术', 2),
	(4, '@生活@', 3),
	(6, '资料分享', 4);
/*!40000 ALTER TABLE `category_super` ENABLE KEYS */;


-- 导出  表 blog.comment 结构
DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL auto_increment,
  `articleId` int(11) NOT NULL,
  `email` varchar(40) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `dateTime` datetime NOT NULL,
  `nick` varchar(45) NOT NULL,
  `pId` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  blog.comment 的数据: ~0 rows ((大约))
DELETE FROM `comment`;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;


-- 导出  表 blog.message 结构
DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(45) NOT NULL,
  `content` varchar(200) NOT NULL,
  `dateTime` datetime NOT NULL,
  `nick` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  blog.message 的数据: ~0 rows ((大约))
DELETE FROM `message`;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;


-- 导出  表 blog.project 结构
DROP TABLE IF EXISTS `project`;
CREATE TABLE IF NOT EXISTS `project` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `finish` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  blog.project 的数据: ~9 rows ((大约))
DELETE FROM `project`;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` (`id`, `name`, `finish`) VALUES
	(1, '无', 0),
	(2, 'ABAP基础', 0),
	(3, '报表程序--选择屏幕', 0),
	(4, 'FUNCTION详解', 0),
	(5, 'ALV细说', 0),
	(6, 'ABAP关于时间', 0),
	(7, 'DNPRO细节', 0),
	(8, 'ALV控件的使用', 0),
	(9, '资料分享', 0);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;


-- 导出  表 blog.user 结构
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(40) NOT NULL,
  `password` varchar(80) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- 正在导出表  blog.user 的数据: ~1 rows ((大约))
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`) VALUES
	(1, 'root', 'dc76e9f0c0006e8f919e0c515c66dbba3982f785');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


-- 导出  表 bbs.module 结构
DROP TABLE IF EXISTS `module`;
CREATE TABLE IF NOT EXISTS `module` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) default NULL,
  `detail` varchar(100) default NULL,
  `turn` tinyint(2) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 正在导出表  bbs.module 的数据: ~3 rows ((大约))
DELETE FROM `module`;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
INSERT INTO `module` (`id`, `name`, `detail`, `turn`) VALUES
	(4, '屌丝一起来 ⊙ω⊙', NULL, 1),
	(5, '技术专区 (ΘｏΘ)', NULL, 2),
	(6, 'github ：）', NULL, 3);
/*!40000 ALTER TABLE `module` ENABLE KEYS */;


-- 导出  表 bbs.post 结构
DROP TABLE IF EXISTS `post`;
CREATE TABLE IF NOT EXISTS `post` (
  `id` int(11) NOT NULL auto_increment,
  `topicID` int(11) NOT NULL,
  `userID` int(11) NOT NULL default '0',
  `content` text NOT NULL,
  `createTime` timestamp NULL default CURRENT_TIMESTAMP,
  `hasReply` bit(1) NOT NULL default '\0',
  `updateTime` timestamp NULL default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- 正在导出表  bbs.post 的数据: ~2 rows ((大约))
DELETE FROM `post`;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` (`id`, `topicID`, `userID`, `content`, `createTime`, `hasReply`, `updateTime`) VALUES
	(27, 16, 11, '<p>^O^</p>', '2013-05-17 13:04:51', b'10000000', NULL),
	(28, 17, 12, '<p>^O^辅导费多发点发大幅度发</p>', '2013-08-25 16:56:12', b'10000000', NULL);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;


-- 导出  表 bbs.reply 结构
DROP TABLE IF EXISTS `reply`;
CREATE TABLE IF NOT EXISTS `reply` (
  `id` int(11) NOT NULL auto_increment,
  `topicID` int(11) NOT NULL default '1',
  `postID` int(11) NOT NULL,
  `userID` int(11) NOT NULL default '0',
  `content` varchar(300) NOT NULL,
  `createTime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- 正在导出表  bbs.reply 的数据: ~2 rows ((大约))
DELETE FROM `reply`;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
INSERT INTO `reply` (`id`, `topicID`, `postID`, `userID`, `content`, `createTime`) VALUES
	(94, 16, 27, 11, '111', '2013-05-18 11:20:34'),
	(95, 17, 28, 12, '啥意思', '2013-08-25 16:56:32');
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;


-- 导出  表 bbs.topic 结构
DROP TABLE IF EXISTS `topic`;
CREATE TABLE IF NOT EXISTS `topic` (
  `id` int(11) NOT NULL auto_increment,
  `userID` int(11) NOT NULL default '0',
  `moduleID` int(11) NOT NULL,
  `postCount` int(11) NOT NULL default '1',
  `replyCount` int(11) NOT NULL default '0',
  `pv` int(11) NOT NULL default '0',
  `content` varchar(60) NOT NULL,
  `emotion` tinyint(2) default NULL,
  `createTime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `isNice` bit(1) NOT NULL default '\0',
  `isUp` bit(1) NOT NULL default '\0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- 正在导出表  bbs.topic 的数据: ~2 rows ((大约))
DELETE FROM `topic`;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` (`id`, `userID`, `moduleID`, `postCount`, `replyCount`, `pv`, `content`, `emotion`, `createTime`, `isNice`, `isUp`) VALUES
	(16, 11, 4, 1, 0, 9, 'test', NULL, '2013-05-17 13:04:51', b'00000000', b'00000000'),
	(17, 12, 4, 1, 0, 1, '不咋地嘛', NULL, '2013-08-25 16:56:12', b'00000000', b'00000000');
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;


-- 导出  表 bbs.user 结构
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(20) NOT NULL,
  `password` varchar(40) NOT NULL,
  `sex` bit(1) NOT NULL default '',
  `email` varchar(30) default NULL,
  `headImg` varchar(120) default 'http://static.tieba.baidu.com/tb/editor/images/ali/ali_008.gif',
  `blogUrl` varchar(80) default NULL,
  `feeling` varchar(300) default NULL,
  `registDate` date default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- 正在导出表  bbs.user 的数据: ~2 rows ((大约))
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`, `sex`, `email`, `headImg`, `blogUrl`, `feeling`, `registDate`) VALUES
	(11, 'admin', 'bfd59291e825b5f2bbf1eb76569f8fe7', b'10000000', 'iveryang@sina.cn', 'http://static.tieba.baidu.com/tb/editor/images/ali/ali_008.gif', NULL, NULL, '2013-05-17'),
	(12, 'zzzz', 'c4996e602bf907934ca9d8d61f6429fb', b'10000000', 'hczyh_888@163.com', 'http://static.tieba.baidu.com/tb/editor/images/ali/ali_008.gif', NULL, NULL, '2013-08-25');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
