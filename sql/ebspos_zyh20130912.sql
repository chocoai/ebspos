-- --------------------------------------------------------
-- 主机                            :127.0.0.1
-- 服务器版本                         :5.0.67-community-log - MySQL Community Edition (GPL)
-- 服务器操作系统                       :Win32
-- HeidiSQL 版本                   :7.0.0.4278
-- 创建                            :2013-09-12 17:45:25
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日程表';

-- 正在导出表  ebspos.calendar 的数据: ~0 rows ((大约))
DELETE FROM `calendar`;
/*!40000 ALTER TABLE `calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar` ENABLE KEYS */;


-- 导出  表 ebspos.cgorder 结构
DROP TABLE IF EXISTS `cgorder`;
CREATE TABLE IF NOT EXISTS `cgorder` (
  `orderCode` varchar(20) NOT NULL default '0' COMMENT '订单编号',
  `orderDate` datetime default NULL COMMENT '订单日期',
  `Operator` varchar(50) default '0' COMMENT '制单人',
  `SupplierNo` int(11) default '0' COMMENT '供应商编号',
  `StoreNo` int(11) default '0' COMMENT '仓库编号',
  `partmentNo` int(11) default '0' COMMENT '部门编号',
  `EmployeeNo` int(11) default '0' COMMENT '业务员编号',
  `DeliveryDate` date default NULL COMMENT '收货日期',
  `FinishFlag` smallint(6) default '0' COMMENT '订单完成标志',
  `CheckFlag` smallint(6) default '0' COMMENT '审核状态',
  `CheckMan` varchar(50) default '0' COMMENT '审核人',
  `CheckDate` date default NULL COMMENT '审核日期',
  `StopFlag` smallint(6) default '0' COMMENT '停用标志',
  `StopMan` varchar(50) default '0' COMMENT '终止人',
  `StopDate` date default NULL COMMENT '终止日期',
  `PreAmount` decimal(10,2) default '0.00' COMMENT '预付金额',
  `SettleTypeFlag` smallint(6) default '0' COMMENT '0：什么都不选。1：预付 2：清货 3：货款结清',
  `remark` varchar(100) default '0' COMMENT '备注',
  PRIMARY KEY  (`orderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购订单';

-- 正在导出表  ebspos.cgorder 的数据: ~0 rows ((大约))
DELETE FROM `cgorder`;
/*!40000 ALTER TABLE `cgorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `cgorder` ENABLE KEYS */;


-- 导出  表 ebspos.cgorderdetail 结构
DROP TABLE IF EXISTS `cgorderdetail`;
CREATE TABLE IF NOT EXISTS `cgorderdetail` (
  `orderCode` varchar(20) NOT NULL default '0' COMMENT '订单号',
  `SerialNo` int(11) NOT NULL default '1' COMMENT '序号',
  `GoodsNo` varchar(20) default NULL COMMENT '商品编号',
  `OrigPrice` decimal(10,2) default NULL COMMENT '原订价',
  `Price` decimal(10,2) default NULL COMMENT '确认价',
  `Quantity` decimal(10,2) default NULL COMMENT '数量',
  `Discount` decimal(10,2) default NULL COMMENT '折扣',
  `InStoreQty` decimal(10,2) default NULL COMMENT '已入库数',
  `ReturnQty` decimal(10,2) default NULL COMMENT '退回数',
  `BuyAmount` decimal(10,2) default NULL COMMENT '货款',
  `TaxRate` decimal(10,2) default NULL COMMENT '税率',
  `TaxAmount` decimal(10,2) default NULL COMMENT '税额',
  `Amount` decimal(10,2) default NULL COMMENT '价税合计',
  `remark` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`orderCode`,`SerialNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购订单明细';

-- 正在导出表  ebspos.cgorderdetail 的数据: ~0 rows ((大约))
DELETE FROM `cgorderdetail`;
/*!40000 ALTER TABLE `cgorderdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `cgorderdetail` ENABLE KEYS */;


-- 导出  表 ebspos.ckinitstore 结构
DROP TABLE IF EXISTS `ckinitstore`;
CREATE TABLE IF NOT EXISTS `ckinitstore` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderNo` varchar(20) default NULL,
  `OrderDate` varchar(20) default NULL,
  `StoreNo` varchar(20) default NULL,
  `BillOrderNo` varchar(20) default NULL,
  `RelatedBillNo` varchar(20) default NULL,
  `DepartmentNo` varchar(20) default NULL,
  `EmployeeNo` varchar(20) default NULL,
  `Operator` varchar(20) default NULL,
  `CKAmount` decimal(10,0) default NULL,
  `CheckFlag` smallint(6) default NULL,
  `CheckDate` varchar(20) default NULL,
  `CheckMan` varchar(50) default NULL,
  `RecordCount` int(11) default NULL,
  `Memo` varchar(100) default NULL,
  `RedFlag` smallint(6) default NULL,
  `RedDate` varchar(20) default NULL,
  `RedMan` varchar(50) default NULL,
  `HasRed` smallint(6) default NULL,
  `PriceType` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.ckinitstore 的数据: ~3 rows ((大约))
DELETE FROM `ckinitstore`;
/*!40000 ALTER TABLE `ckinitstore` DISABLE KEYS */;
INSERT INTO `ckinitstore` (`id`, `OrderNo`, `OrderDate`, `StoreNo`, `BillOrderNo`, `RelatedBillNo`, `DepartmentNo`, `EmployeeNo`, `Operator`, `CKAmount`, `CheckFlag`, `CheckDate`, `CheckMan`, `RecordCount`, `Memo`, `RedFlag`, `RedDate`, `RedMan`, `HasRed`, `PriceType`) VALUES
	(5, 'CK1377840011216', '2013-08-06', '1', NULL, NULL, '1', 'pk', '3', 3, NULL, '2013-08-13', '4', NULL, '2', NULL, NULL, NULL, NULL, NULL),
	(6, 'CK1377840751068', '2013-08-14', '2', NULL, NULL, '13', 'zyh', 'dd', 45, NULL, '2013-08-20', '45', NULL, '5000', NULL, NULL, NULL, NULL, '移动平均计价'),
	(7, 'CK1377854931458', '2013-08-12', '1', NULL, NULL, '13', 'zyh', '1324', 1234, NULL, '2013-08-15', '1234', NULL, '324', NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `ckinitstore` ENABLE KEYS */;


-- 导出  表 ebspos.ckinitstoredetail 结构
DROP TABLE IF EXISTS `ckinitstoredetail`;
CREATE TABLE IF NOT EXISTS `ckinitstoredetail` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderNo` varchar(20) default NULL,
  `SerialNo` int(11) default NULL,
  `GoodsNo` varchar(20) default NULL,
  `GoodsName` varchar(200) default NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.ckinitstoredetail 的数据: ~9 rows ((大约))
DELETE FROM `ckinitstoredetail`;
/*!40000 ALTER TABLE `ckinitstoredetail` DISABLE KEYS */;
INSERT INTO `ckinitstoredetail` (`id`, `OrderNo`, `SerialNo`, `GoodsNo`, `GoodsName`, `SUnitQuantity`, `MUnitQuantity`, `UnitQuantity`, `Quantity`, `CKPrice`, `CKAmount`, `Unit`, `MixUnit`, `UnitRate`, `RelatedOrderNo`, `OrderSerialNo`, `Memo`) VALUES
	(29, 'CK1377830836634', NULL, '1111', '123', NULL, NULL, NULL, 0, 0, NULL, '14', NULL, NULL, NULL, NULL, NULL),
	(31, 'CK1377840751068', NULL, '1111', '123', NULL, NULL, NULL, 20, 123, NULL, '14', NULL, NULL, NULL, NULL, NULL),
	(32, 'CK1377840751068', NULL, '1111', '123', NULL, NULL, NULL, 30, 12, NULL, '14', NULL, NULL, NULL, NULL, NULL),
	(33, 'CK1377840751068', NULL, '1111', '123', NULL, NULL, NULL, 40, 10, NULL, '14', NULL, NULL, NULL, NULL, NULL),
	(38, 'CK1377840751068', NULL, '1111', '123', NULL, NULL, NULL, 77, 99, NULL, '14', NULL, NULL, NULL, NULL, NULL),
	(41, 'CK1377840751068', NULL, '1111', '123', NULL, NULL, NULL, 1000, 12, NULL, '14', NULL, NULL, NULL, NULL, NULL),
	(42, 'CK1377840751068', NULL, '1111', '123', NULL, NULL, NULL, 100, 20, NULL, '14', NULL, NULL, NULL, NULL, NULL),
	(43, 'CK1377840751068', NULL, '1111', '123', NULL, NULL, NULL, 1, 1, NULL, '1', NULL, NULL, NULL, NULL, NULL),
	(44, 'CK1377840751068', NULL, '1111', '123', NULL, NULL, NULL, 1, 1, NULL, '1', NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `ckinitstoredetail` ENABLE KEYS */;


-- 导出  表 ebspos.ckjhcheck 结构
DROP TABLE IF EXISTS `ckjhcheck`;
CREATE TABLE IF NOT EXISTS `ckjhcheck` (
  `OrderNo` varchar(20) NOT NULL default '0' COMMENT '进货单编号',
  `OrderDate` datetime default NULL COMMENT '进货日期',
  `JHPayOrderNo` varchar(20) default NULL,
  `SupplierNo` int(11) default NULL COMMENT '供应商id',
  `StoreNo` int(11) default NULL COMMENT '仓库id',
  `InOutTypeNo` varchar(20) default NULL COMMENT '入库/退货类型',
  `BillOrderNo` varchar(20) default NULL COMMENT '采购单号',
  `RelatedBillNo` varchar(20) default NULL,
  `DepartmentNo` int(11) default NULL COMMENT '部门id',
  `EmployeeNo` varchar(20) default NULL COMMENT '经办人id',
  `Operator` varchar(50) default NULL COMMENT '制单人',
  `PayAmount` decimal(10,2) default NULL COMMENT '已付金额',
  `AdjustAmount` decimal(10,2) default NULL,
  `CKAmount` decimal(10,2) default NULL COMMENT '入库金额',
  `Amount` decimal(10,2) default NULL COMMENT '购货金额',
  `PatchAmount` decimal(10,2) default NULL,
  `CheckFlag` smallint(6) default NULL COMMENT '审核标志',
  `CheckDate` datetime default NULL COMMENT '审核日期',
  `CheckMan` varchar(50) default NULL COMMENT '审核人',
  `RePayType` varchar(20) default NULL,
  `CollateType` smallint(6) default NULL,
  `RecordCount` int(11) default NULL,
  `remark` varchar(100) default NULL COMMENT '备注',
  `RedFlag` smallint(6) default NULL,
  `RedDate` datetime default NULL,
  `RedMan` varchar(50) default NULL,
  `HasRed` smallint(6) default NULL,
  PRIMARY KEY  (`OrderNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购入库表';

-- 正在导出表  ebspos.ckjhcheck 的数据: ~0 rows ((大约))
DELETE FROM `ckjhcheck`;
/*!40000 ALTER TABLE `ckjhcheck` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckjhcheck` ENABLE KEYS */;


-- 导出  表 ebspos.ckjhcheckdetail 结构
DROP TABLE IF EXISTS `ckjhcheckdetail`;
CREATE TABLE IF NOT EXISTS `ckjhcheckdetail` (
  `OrderNo` varchar(20) NOT NULL default '0' COMMENT '进货单号',
  `SerialNo` int(11) NOT NULL default '1' COMMENT '进货单序号',
  `GoodsNo` varchar(20) default NULL COMMENT '商品编号',
  `Quantity` decimal(10,2) default NULL COMMENT '数量',
  `OrigPrice` decimal(10,2) default NULL,
  `Price` decimal(10,2) default NULL COMMENT '单价',
  `DisCount` decimal(10,2) default NULL,
  `BuyAmount` decimal(10,2) default NULL,
  `TaxRate` decimal(10,2) default NULL COMMENT '税率',
  `TaxAmount` decimal(10,2) default NULL COMMENT '价税合计',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `CKPrice` decimal(10,2) default NULL COMMENT '入库单价',
  `CKAmount` decimal(10,2) default NULL COMMENT '入库金额',
  `PatchPrice` decimal(10,2) default NULL,
  `PatchAmount` decimal(10,2) default NULL,
  `Unit` varchar(20) default NULL COMMENT '单位',
  `MixUnit` varchar(20) default NULL,
  `UnitRate` varchar(20) default NULL,
  `RelatedOrderNo` varchar(20) default NULL COMMENT '关联单号',
  `OrderSerialNo` int(11) default NULL,
  `remark` varchar(100) default NULL COMMENT '备注',
  `LastPrice` decimal(10,2) default NULL COMMENT '最近进价',
  PRIMARY KEY  (`OrderNo`,`SerialNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购入库明细表';

-- 正在导出表  ebspos.ckjhcheckdetail 的数据: ~0 rows ((大约))
DELETE FROM `ckjhcheckdetail`;
/*!40000 ALTER TABLE `ckjhcheckdetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckjhcheckdetail` ENABLE KEYS */;


-- 导出  表 ebspos.employee 结构
DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `id` bigint(20) NOT NULL auto_increment,
  `usr_no` varchar(20) NOT NULL COMMENT '员工编号',
  `usr_name` varchar(50) default NULL COMMENT '姓名',
  `pwd` varchar(50) default NULL COMMENT '密码',
  `dep_no` varchar(20) default NULL COMMENT '部门',
  `age` tinyint(4) default NULL COMMENT '年龄',
  `gender` varchar(20) default NULL COMMENT '籍贯',
  `edu_bg` varchar(50) default NULL COMMENT '学历',
  `birthday` varchar(50) default NULL COMMENT '生日',
  `entry_date` varchar(50) default NULL COMMENT '入职时间',
  `id_card_no` bigint(20) default NULL,
  `fax_no` bigint(20) default NULL COMMENT '传真',
  `phone_no` bigint(20) default NULL COMMENT '电话号码',
  `address` varchar(255) default NULL COMMENT '地址',
  `position` varchar(50) default NULL COMMENT '联系地址',
  `salary` int(11) default NULL COMMENT '工资',
  `email` varchar(255) default NULL COMMENT '邮箱',
  `royalty_rate` decimal(10,0) default NULL,
  `remark` varchar(255) default NULL COMMENT '备注',
  `is_use` tinyint(4) default NULL COMMENT '是否在职',
  `usr_type` tinyint(4) default NULL,
  `upd_time` datetime default NULL,
  `crd_time` datetime default NULL,
  `upd_usr` varchar(255) default NULL,
  `crd_usr` varchar(255) default NULL,
  `del_flg` tinyint(4) default '0' COMMENT '删除标志',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `usr_no` (`usr_no`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.employee 的数据: ~9 rows ((大约))
DELETE FROM `employee`;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` (`id`, `usr_no`, `usr_name`, `pwd`, `dep_no`, `age`, `gender`, `edu_bg`, `birthday`, `entry_date`, `id_card_no`, `fax_no`, `phone_no`, `address`, `position`, `salary`, `email`, `royalty_rate`, `remark`, `is_use`, `usr_type`, `upd_time`, `crd_time`, `upd_usr`, `crd_usr`, `del_flg`) VALUES
	(1, 'admin', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', 1, '男', '本科', '2013-06-28', '2013-06-28', 36010319880999, NULL, 13809876543, 'vasdfasdfadsf', '导购员', 100000, 'xxxx@163.com', 0, '弄阿克苏打发第三方', 1, 1, '2013-08-07 21:06:02', NULL, NULL, NULL, NULL),
	(2, 'pk', '彭科', 'e10adc3949ba59abbe56e057f20f883e', '1', NULL, '男', '高中', '2013-07-24', '2013-07-31', 23412343324, NULL, NULL, NULL, '业务员', NULL, NULL, NULL, NULL, NULL, 1, '2013-07-09 14:44:39', NULL, NULL, NULL, NULL),
	(3, 'wcc', '吴春明', 'e10adc3949ba59abbe56e057f20f883e', '1', 5, '女', '本科', '2013-07-23', '2013-07-26', 188888888, 13241324, 2341234, 'qer123r', '导购员', 10, '2@124.com', 20, '来这个啊京东方卡迪夫', NULL, NULL, '2013-07-18 10:53:54', NULL, NULL, NULL, 0),
	(4, 'zyh', '湛原红', 'e10adc3949ba59abbe56e057f20f883e', '1', 30, '男', '高中', '1980-07-27', '2013-08-01', 1234567890, NULL, 111111, '呃呃呃', '业务员', 5000, 'hczyh_888@163.com', 20, '呃呃呃', NULL, NULL, '2013-08-06 10:37:40', NULL, NULL, NULL, 0),
	(5, 'zs', '张三', 'e10adc3949ba59abbe56e057f20f883e', '1', 11, NULL, '高中', '1971-10-10', '2013-08-06', 11111, NULL, NULL, NULL, '业务员', 1111, NULL, 10, NULL, NULL, NULL, '2013-08-07 21:17:10', NULL, NULL, NULL, 0),
	(6, 'test', 'test', 'e10adc3949ba59abbe56e057f20f883e', '1', 11, '男', '高中', '2011-08-05', '2013-07-28', 11111, NULL, 11, '11', '业务员', 11, '11', NULL, '11', NULL, 1, '2013-08-10 12:10:30', NULL, NULL, NULL, 0),
	(7, 'ttt', 'ttt', 'e10adc3949ba59abbe56e057f20f883e', '2', 11, NULL, '高中', NULL, NULL, 11111, NULL, NULL, NULL, '业务员', 11, NULL, NULL, NULL, NULL, 1, '2013-08-10 18:34:01', NULL, NULL, NULL, 0),
	(8, 'fdsf', 'fdfd', 'e10adc3949ba59abbe56e057f20f883e', '1', NULL, NULL, '高中', NULL, NULL, 11111, NULL, NULL, NULL, '业务员', NULL, NULL, NULL, NULL, NULL, 1, '2013-08-18 11:46:19', NULL, NULL, NULL, 0),
	(9, '454654', '6565', 'e10adc3949ba59abbe56e057f20f883e', '1', NULL, NULL, '高中', NULL, NULL, 6565656565, NULL, NULL, NULL, '业务员', NULL, NULL, NULL, NULL, NULL, 1, '2013-08-18 11:46:31', NULL, NULL, NULL, 0);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;


-- 导出  表 ebspos.jbclient 结构
DROP TABLE IF EXISTS `jbclient`;
CREATE TABLE IF NOT EXISTS `jbclient` (
  `id` bigint(20) NOT NULL auto_increment,
  `ClientCode` varchar(20) default '0' COMMENT '客户代码',
  `ClientName` varchar(50) default '0' COMMENT '客户名称',
  `TypeNo` varchar(10) default '0' COMMENT '客户类型序号',
  `EmployeeNo` varchar(10) default '0' COMMENT '相关业务员序号',
  `ClientLevelNo` varchar(10) default '0' COMMENT '客户级别 如大客户 小客户等',
  `AccounType` smallint(6) default '0',
  `LegMan` varchar(50) default '0' COMMENT '联系人',
  `Address` varchar(100) default '0' COMMENT '地址',
  `SendAddress` varchar(100) default '0' COMMENT '发货地址',
  `PostNo` varchar(20) default '0' COMMENT '邮政编码',
  `TelePhone` varchar(20) default '0' COMMENT '电话',
  `Fax` varchar(20) default '0' COMMENT '传真',
  `LinkMan` varchar(20) default '0' COMMENT '联系人',
  `MobilePhone` varchar(20) default '0' COMMENT '联系人手机',
  `LinkPhone` varchar(20) default '0' COMMENT '联系人电话',
  `Email` varchar(50) default '0' COMMENT '邮箱',
  `Url` varchar(50) default '0' COMMENT '网址',
  `CType` varchar(50) default '0' COMMENT '结账类型',
  `SDayMax` int(11) default '0' COMMENT '信用天数',
  `SAmountMax` decimal(10,2) default '0.00' COMMENT '最大销售金额（信誉额）',
  `BankNo` varchar(100) default '0' COMMENT '开户行',
  `BankAccount` varchar(100) default '0' COMMENT '银行账号',
  `PreAmount` decimal(10,2) default '0.00' COMMENT '期初应收',
  `AdvanceAmount` decimal(10,2) default '0.00' COMMENT '预收款',
  `NeedRecive` decimal(10,2) default '0.00' COMMENT '应收款',
  `SplusAmount` decimal(10,2) default '0.00' COMMENT '往来余额',
  `StopFlag` smallint(6) default '0' COMMENT '停止业务标记',
  `remark` varchar(150) default '0' COMMENT '备注',
  UNIQUE KEY `ClientCode` (`ClientCode`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户资料';

-- 正在导出表  ebspos.jbclient 的数据: ~0 rows ((大约))
DELETE FROM `jbclient`;
/*!40000 ALTER TABLE `jbclient` DISABLE KEYS */;
/*!40000 ALTER TABLE `jbclient` ENABLE KEYS */;


-- 导出  表 ebspos.jbgoods 结构
DROP TABLE IF EXISTS `jbgoods`;
CREATE TABLE IF NOT EXISTS `jbgoods` (
  `id` bigint(20) NOT NULL auto_increment,
  `GoodsCode` varchar(20) default NULL COMMENT '商品编号',
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
  PRIMARY KEY  (`id`),
  UNIQUE KEY `GoodsCode` (`GoodsCode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商品资料表';

-- 正在导出表  ebspos.jbgoods 的数据: ~2 rows ((大约))
DELETE FROM `jbgoods`;
/*!40000 ALTER TABLE `jbgoods` DISABLE KEYS */;
INSERT INTO `jbgoods` (`id`, `GoodsCode`, `GoodsName`, `GoodsTypeNo`, `subgoodstypeno`, `smallgoodstypeno`, `BrandNo`, `ProduceArea`, `ProduceName`, `Clolor`, `BarCode`, `Model`, `BaseUnit`, `BRefPrice`, `SRefPrice`, `CostPrice`, `Picture`, `StopFlag`, `Remark`, `Season`, `YearBy`) VALUES
	(1, '1111', '123', 30, 32, 33, '19', '1', '1', NULL, '1', '333', '14', 11.00, 11.00, 11.00, NULL, 1, 'wwww', '1', '2011'),
	(2, 'dss', 'dsa', 30, 32, 33, '18', NULL, NULL, NULL, NULL, 'dsads', '14', NULL, NULL, NULL, NULL, NULL, NULL, '1', '2011');
/*!40000 ALTER TABLE `jbgoods` ENABLE KEYS */;


-- 导出  表 ebspos.jbstore 结构
DROP TABLE IF EXISTS `jbstore`;
CREATE TABLE IF NOT EXISTS `jbstore` (
  `StoreNo` int(11) NOT NULL auto_increment COMMENT '仓库id',
  `StoreCode` varchar(20) default NULL COMMENT '仓库编号',
  `StoreName` varchar(50) default NULL COMMENT '仓库名称',
  `TypeNo` varchar(20) default NULL COMMENT '仓库类别',
  `LAndHeight` varchar(50) default NULL COMMENT '面积',
  `Place` varchar(50) default NULL COMMENT '存放位置',
  `EmployeeNo` varchar(20) default NULL COMMENT '仓库保管员',
  `CountQuantity` decimal(18,0) default NULL COMMENT '数量',
  `PriceType` varchar(20) default NULL COMMENT '计价类型',
  `StopFlag` smallint(6) default '0' COMMENT '是否停用',
  `Memo` char(10) default NULL COMMENT '备注',
  `RetailSTFlag` smallint(6) default NULL,
  `OtherFlag` smallint(6) default NULL,
  `MrpFlag` smallint(6) default NULL,
  `DownLogNo` int(11) default NULL,
  `PriceLevel` int(11) default NULL,
  PRIMARY KEY  (`StoreNo`),
  UNIQUE KEY `StoreCode` (`StoreCode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='仓库信息';

-- 正在导出表  ebspos.jbstore 的数据: ~2 rows ((大约))
DELETE FROM `jbstore`;
/*!40000 ALTER TABLE `jbstore` DISABLE KEYS */;
INSERT INTO `jbstore` (`StoreNo`, `StoreCode`, `StoreName`, `TypeNo`, `LAndHeight`, `Place`, `EmployeeNo`, `CountQuantity`, `PriceType`, `StopFlag`, `Memo`, `RetailSTFlag`, `OtherFlag`, `MrpFlag`, `DownLogNo`, `PriceLevel`) VALUES
	(1, '1', '男服装', NULL, '10000', '八百伴', '5', 100, '按件', 1, 'T恤，牛仔裤', NULL, NULL, NULL, NULL, NULL),
	(2, '239', '材料', NULL, '1000', '张江', '4', 1888, '批发', NULL, '布匹', NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `jbstore` ENABLE KEYS */;


-- 导出  表 ebspos.jbsupplier 结构
DROP TABLE IF EXISTS `jbsupplier`;
CREATE TABLE IF NOT EXISTS `jbsupplier` (
  `id` bigint(20) NOT NULL auto_increment,
  `supplierCode` varchar(20) default '0' COMMENT '供应商编码',
  `supplierName` varchar(50) default '0' COMMENT '供应商名称',
  `supplierTypeNo` int(11) default '0' COMMENT '供应商类别',
  `EmployeeNo` int(11) default '0' COMMENT '管辖业务员',
  `Address` varchar(150) default '0' COMMENT '联系地址',
  `SendAddress` varchar(150) default '0' COMMENT '发货地址',
  `PostNo` varchar(50) default '0' COMMENT '邮编',
  `TelePhone` varchar(50) default '0' COMMENT '公司电话',
  `Fax` varchar(50) default '0' COMMENT '传真',
  `Email` varchar(50) default '0' COMMENT '邮箱',
  `LinkMan` varchar(50) default '0' COMMENT '联系人',
  `LinkPhone` varchar(50) default '0' COMMENT '联系人电话',
  `Url` varchar(50) default '0' COMMENT '网址',
  `PDayMax` int(11) default '0' COMMENT '信用天数',
  `PAmountMax` decimal(10,2) default '0.00' COMMENT '信用金额',
  `BankNo` varchar(100) default '0' COMMENT '开户行',
  `BankAccount` varchar(100) default '0' COMMENT '账号',
  `PreAmount` decimal(10,2) default '0.00' COMMENT '期初应付',
  `AdvanceAmount` decimal(10,2) default '0.00' COMMENT '预付款',
  `BuyAmount` decimal(10,2) default '0.00' COMMENT '购买总金额',
  `SplusAmount` decimal(10,2) default '0.00' COMMENT '往来余额',
  `StopFlag` smallint(6) default '0' COMMENT '停止业务标志',
  `remark` varchar(150) default '0' COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `supplierCode` (`supplierCode`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='供应商资料';

-- 正在导出表  ebspos.jbsupplier 的数据: ~1 rows ((大约))
DELETE FROM `jbsupplier`;
/*!40000 ALTER TABLE `jbsupplier` DISABLE KEYS */;
INSERT INTO `jbsupplier` (`id`, `supplierCode`, `supplierName`, `supplierTypeNo`, `EmployeeNo`, `Address`, `SendAddress`, `PostNo`, `TelePhone`, `Fax`, `Email`, `LinkMan`, `LinkPhone`, `Url`, `PDayMax`, `PAmountMax`, `BankNo`, `BankAccount`, `PreAmount`, `AdvanceAmount`, `BuyAmount`, `SplusAmount`, `StopFlag`, `remark`) VALUES
	(1, '112', '2222', 0, 22, '2', '2', '2', '2', NULL, NULL, '2', '2', '2', 2, 22.00, '22', '222', 2.00, 0.00, 0.00, 0.00, NULL, '2');
/*!40000 ALTER TABLE `jbsupplier` ENABLE KEYS */;


-- 导出  表 ebspos.jhpay 结构
DROP TABLE IF EXISTS `jhpay`;
CREATE TABLE IF NOT EXISTS `jhpay` (
  `OrderNo` varchar(20) NOT NULL COMMENT '付款单号',
  `OrderDate` datetime default NULL COMMENT '付款日期',
  `SupplierNo` varchar(20) default NULL COMMENT '供应商',
  `DepartmentNo` varchar(20) default NULL COMMENT '部门',
  `EmployeeNo` varchar(20) default NULL COMMENT '经手人',
  `Operator` varchar(50) default NULL COMMENT '制单人',
  `PayType` smallint(6) default NULL COMMENT '账户类型',
  `RePayType` varchar(20) default NULL,
  `BankNo` varchar(20) default NULL COMMENT '账号',
  `CheckFlag` smallint(6) default NULL COMMENT '审核标志',
  `CheckMan` varchar(50) default NULL COMMENT '审核人',
  `CheckDate` datetime default NULL COMMENT '审核日期',
  `LastAmount` decimal(10,2) default NULL,
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `TAdjustAmount` decimal(10,2) default NULL,
  `RecordCount` int(11) default NULL,
  `BillOrderNo` varchar(20) default NULL COMMENT '订单号',
  `remark` varchar(100) default NULL COMMENT '备注',
  `RedFlag` smallint(6) default NULL,
  `RedDate` datetime default NULL,
  `RedMan` varchar(50) default NULL,
  `HasRed` smallint(6) default NULL,
  PRIMARY KEY  (`OrderNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购付款单';

-- 正在导出表  ebspos.jhpay 的数据: ~0 rows ((大约))
DELETE FROM `jhpay`;
/*!40000 ALTER TABLE `jhpay` DISABLE KEYS */;
/*!40000 ALTER TABLE `jhpay` ENABLE KEYS */;


-- 导出  表 ebspos.jhpaydetail 结构
DROP TABLE IF EXISTS `jhpaydetail`;
CREATE TABLE IF NOT EXISTS `jhpaydetail` (
  `OrderNo` varchar(20) NOT NULL COMMENT '付款单编号',
  `SerialNo` int(11) NOT NULL default '1' COMMENT '序号',
  `PayOrderNo` varchar(50) default NULL,
  `NowCollated` decimal(10,2) default NULL COMMENT '本次付款金额',
  `Adjust` decimal(10,2) default NULL COMMENT '抹零金额',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `remark` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`OrderNo`,`SerialNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购付款单明细';

-- 正在导出表  ebspos.jhpaydetail 的数据: ~0 rows ((大约))
DELETE FROM `jhpaydetail`;
/*!40000 ALTER TABLE `jhpaydetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `jhpaydetail` ENABLE KEYS */;


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
) ENGINE=InnoDB AUTO_INCREMENT=1051 DEFAULT CHARSET=utf8 COMMENT='系统菜单';

-- 正在导出表  ebspos.menu 的数据: ~39 rows ((大约))
DELETE FROM `menu`;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` (`id`, `name`, `url`, `type`, `menulevel`, `icon`, `ordernum`, `safecode`, `pid`, `target`, `rel`, `enable`, `remark`) VALUES
	(1, '资料管理', NULL, 0, 0, NULL, 1, NULL, 0, 0, NULL, 1, NULL),
	(2, '采购管理', NULL, 0, 0, NULL, 2, NULL, 0, 0, NULL, 1, NULL),
	(3, '销售管理', NULL, 0, 0, NULL, 3, NULL, 0, 0, NULL, 1, NULL),
	(4, '仓库管理', NULL, 0, 0, NULL, 4, NULL, 0, 0, NULL, 1, NULL),
	(5, '财务管理', NULL, 0, 0, NULL, 5, NULL, 0, 0, NULL, 1, NULL),
	(6, '报表统计', NULL, 0, 0, NULL, 6, NULL, 0, 0, NULL, 1, NULL),
	(11, '资料管理', NULL, 1, 1, NULL, 1, NULL, 1, 0, NULL, 1, NULL),
	(111, '供应商资料', 'jbsupplier', 1, 2, NULL, 1, NULL, 11, 0, NULL, 1, NULL),
	(112, '客户资料', 'jbclient', 1, 2, NULL, 2, NULL, 11, 0, NULL, 1, NULL),
	(113, '商品资料', 'jbgoods', 1, 2, NULL, 3, NULL, 11, 0, NULL, 1, NULL),
	(114, '员工资料', 'employee', 1, 2, NULL, 4, NULL, 11, 0, NULL, 1, NULL),
	(1019, '定义类别', 'types', 1, 2, NULL, 6, NULL, 11, 0, NULL, 1, NULL),
	(1021, '采购管理', NULL, 1, 1, NULL, 0, NULL, 2, 0, NULL, 1, NULL),
	(1022, '采购订单', 'cgorder', 1, 2, NULL, 0, NULL, 1021, 0, NULL, 1, NULL),
	(1023, '采购入库单', '#', 1, 2, NULL, 1, NULL, 1021, 0, NULL, 1, NULL),
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
	(1036, '仓库资料', 'jbstore', 1, 2, NULL, 5, NULL, 11, 0, NULL, 1, NULL),
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
	(1049, '平台设置', 'platform/set', 1, 2, NULL, 5, NULL, 1042, 0, NULL, 1, NULL),
	(1050, '系统表', 'xttables', 1, 2, NULL, 6, NULL, 1042, 0, NULL, 1, NULL);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;


-- 导出  表 ebspos.organization 结构
DROP TABLE IF EXISTS `organization`;
CREATE TABLE IF NOT EXISTS `organization` (
  `id` bigint(20) NOT NULL auto_increment,
  `num` varchar(20) default NULL COMMENT '编号',
  `name` varchar(30) default NULL COMMENT '名称',
  `addr` varchar(50) default NULL COMMENT '地址',
  `picid` bigint(20) default NULL,
  `sortnum` smallint(6) default NULL COMMENT '排序',
  `remark` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `num` (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='组织';

-- 正在导出表  ebspos.organization 的数据: ~1 rows ((大约))
DELETE FROM `organization`;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` (`id`, `num`, `name`, `addr`, `picid`, `sortnum`, `remark`) VALUES
	(2, '001', '昶源软件', '上海市', NULL, NULL, NULL);
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;


-- 导出  表 ebspos.partment 结构
DROP TABLE IF EXISTS `partment`;
CREATE TABLE IF NOT EXISTS `partment` (
  `id` bigint(20) NOT NULL auto_increment,
  `num` varchar(20) NOT NULL COMMENT '部门编号',
  `name` varchar(50) default NULL COMMENT '名称',
  `picid` bigint(20) default NULL,
  `orgid` bigint(20) default NULL COMMENT '组织ID',
  `remark` varchar(250) default NULL,
  `pid` bigint(10) default NULL COMMENT '父级部门id',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `num` (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='部门';

-- 正在导出表  ebspos.partment 的数据: ~13 rows ((大约))
DELETE FROM `partment`;
/*!40000 ALTER TABLE `partment` DISABLE KEYS */;
INSERT INTO `partment` (`id`, `num`, `name`, `picid`, `orgid`, `remark`, `pid`) VALUES
	(1, '001', '销售部', 4, 2, NULL, 0),
	(2, '002', '财务部', 1, 2, NULL, 0),
	(3, '003', '22222', 1, 2, NULL, 0),
	(4, '004', '33', 1, 2, NULL, 0),
	(5, '005', '33', 1, 2, NULL, 0),
	(6, '006', '23', 1, 2, NULL, 0),
	(7, '007', '21', 1, 2, NULL, 0),
	(8, '008', '22', 1, 2, NULL, 0),
	(9, '009', '44', 1, 2, NULL, 0),
	(10, '010', '21', 1, 2, NULL, 0),
	(11, '011', '111', 1, 2, NULL, 0),
	(12, '012', '3343', 1, 2, NULL, 0),
	(13, 'ejb', '财务二级部门', 1, 2, NULL, 2);
/*!40000 ALTER TABLE `partment` ENABLE KEYS */;


-- 导出  表 ebspos.powermenu 结构
DROP TABLE IF EXISTS `powermenu`;
CREATE TABLE IF NOT EXISTS `powermenu` (
  `menuid` bigint(20) NOT NULL COMMENT '菜单ID',
  `objid` bigint(20) NOT NULL COMMENT '员工id部门id机构id角色id',
  `type` smallint(1) NOT NULL COMMENT '0,2,3,1',
  UNIQUE KEY `索引 1` (`menuid`,`objid`,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.powermenu 的数据: 48 rows
DELETE FROM `powermenu`;
/*!40000 ALTER TABLE `powermenu` DISABLE KEYS */;
INSERT INTO `powermenu` (`menuid`, `objid`, `type`) VALUES
	(1, 1, 0),
	(1, 2, 1),
	(2, 1, 0),
	(2, 2, 1),
	(3, 1, 0),
	(3, 2, 1),
	(4, 1, 0),
	(4, 2, 1),
	(5, 1, 0),
	(6, 1, 0),
	(11, 1, 0),
	(11, 2, 1),
	(111, 1, 0),
	(111, 2, 1),
	(112, 1, 0),
	(112, 2, 1),
	(113, 1, 0),
	(113, 2, 1),
	(114, 1, 0),
	(114, 2, 1),
	(1019, 2, 1),
	(1021, 2, 1),
	(1022, 2, 1),
	(1023, 2, 1),
	(1024, 2, 1),
	(1025, 2, 1),
	(1026, 2, 1),
	(1027, 2, 1),
	(1028, 2, 1),
	(1029, 2, 1),
	(1030, 2, 1),
	(1031, 2, 1),
	(1032, 2, 1),
	(1033, 2, 1),
	(1036, 2, 1),
	(1037, 2, 1),
	(1038, 2, 1),
	(1039, 2, 1),
	(1040, 2, 1),
	(1041, 2, 1),
	(1042, 2, 1),
	(1043, 2, 1),
	(1044, 2, 1),
	(1046, 2, 1),
	(1047, 2, 1),
	(1048, 2, 1),
	(1049, 2, 1),
	(1050, 2, 1);
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
  `function` varchar(100) default NULL COMMENT '功能类别',
  `remark` varchar(250) default NULL COMMENT '备注',
  `pid` bigint(10) default NULL COMMENT '父级类别id',
  `num` varchar(20) default NULL COMMENT '编码',
  `level` tinyint(4) default NULL COMMENT '级别',
  `path` varchar(100) default NULL COMMENT '全路径',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`,`function`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定义类别';

-- 正在导出表  ebspos.types 的数据: ~21 rows ((大约))
DELETE FROM `types`;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` (`id`, `name`, `function`, `remark`, `pid`, `num`, `level`, `path`) VALUES
	(9, '计量单位', '计量单位', NULL, 0, 'jldw', 1, '0-9'),
	(14, '件', '计量单位', NULL, 9, 'jian', 2, '9-14'),
	(15, '个', '计量单位', NULL, 9, 'ge', 2, '9-15'),
	(16, '品牌', '品牌', NULL, 0, 'pp', 1, '0-16'),
	(17, '服装', NULL, NULL, 0, 'fuz', 1, '0-17'),
	(18, '品牌一', '品牌', NULL, 16, 'pp1', 2, '16-18'),
	(19, '品牌二', '品牌', NULL, 16, 'pp2', 2, '16-19'),
	(20, '运动装', NULL, NULL, 17, 'ydz', 2, '17-20'),
	(21, '儿童运动装', NULL, NULL, 20, 'rtydz', 3, '17-20-21'),
	(22, '斤', '计量单位', NULL, 9, 'jin', NULL, NULL),
	(23, '辆', '计量单位', NULL, 9, 'liang', NULL, NULL),
	(24, '成人运动装', NULL, NULL, 20, 'cr', NULL, NULL),
	(29, '商品类别', '商品类别', NULL, 0, 'dl', NULL, NULL),
	(30, '商品大类一', '商品类别', NULL, 29, 'dl1', NULL, NULL),
	(31, '商品大类二', '商品类别', NULL, 29, 'dl2', NULL, NULL),
	(32, '商品中类一', '商品类别', NULL, 30, 'zl', NULL, NULL),
	(33, '商品小类一', '商品类别', NULL, 32, 'xl', NULL, NULL),
	(34, '表类别', '表类别', NULL, 0, 'blb', NULL, NULL),
	(35, '基本表', '表类别', NULL, 34, 'jbb', NULL, NULL),
	(36, '系统表', '表类别', NULL, 34, 'xxb', NULL, NULL),
	(37, '其它', '表类别', NULL, 34, 'qt', NULL, NULL);
/*!40000 ALTER TABLE `types` ENABLE KEYS */;


-- 导出  表 ebspos.userrole 结构
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE IF NOT EXISTS `userrole` (
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `roleid` bigint(20) NOT NULL COMMENT '角色id',
  PRIMARY KEY  (`userid`,`roleid`)
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='系统表信息';

-- 正在导出表  ebspos.xttables 的数据: ~13 rows ((大约))
DELETE FROM `xttables`;
/*!40000 ALTER TABLE `xttables` DISABLE KEYS */;
INSERT INTO `xttables` (`id`, `tablename`, `tlevel`, `ttype`, `remark`, `sysdefault`, `ctablename`) VALUES
	(1, 'xttables', 0, 36, '记录系统表信息', 0, '系统表'),
	(2, 'JBStore', 0, 35, '定义仓库', 0, '仓库信息'),
	(11, 'calendar', 0, 37, NULL, 0, '日程表'),
	(12, 'employee', 0, 35, NULL, 0, '员工信息表'),
	(13, 'types', 0, 36, NULL, 0, '定义类别'),
	(14, 'jbgoods', 0, 35, NULL, 0, '商品资料表'),
	(15, 'menu', 0, 36, NULL, 0, '系统菜单表'),
	(16, 'organization', 0, 35, '定义组织', 0, '组织表'),
	(17, 'partment', 0, 35, NULL, 0, '部门'),
	(18, 'role', 0, 36, NULL, 0, '角色'),
	(19, 'userrole', 0, 36, NULL, 0, '用户角色'),
	(20, 'powermenu', 0, 36, NULL, 0, '权限'),
	(21, 'jbsupplier', 0, 35, NULL, 0, '供应商资料');
/*!40000 ALTER TABLE `xttables` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
