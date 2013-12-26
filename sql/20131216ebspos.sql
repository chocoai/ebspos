-- --------------------------------------------------------
-- 主机                            :127.0.0.1
-- 服务器版本                         :5.0.67-community-log - MySQL Community Edition (GPL)
-- 服务器操作系统                       :Win32
-- HeidiSQL 版本                   :7.0.0.4278
-- 创建                            :2013-12-16 16:21:26
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 ebspos.article 结构
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.calendar 结构
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

-- 数据导出被取消选择.


-- 导出  表 ebspos.category_sub 结构
CREATE TABLE IF NOT EXISTS `category_sub` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `pId` int(11) default NULL,
  `order` int(3) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.category_super 结构
CREATE TABLE IF NOT EXISTS `category_super` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `order` int(3) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.cgorder 结构
CREATE TABLE IF NOT EXISTS `cgorder` (
  `id` bigint(20) NOT NULL auto_increment,
  `orderCode` varchar(20) NOT NULL default '0' COMMENT '订单编号',
  `orderDate` date default NULL COMMENT '订单日期',
  `Operator` varchar(20) default '0' COMMENT '制单人',
  `supplierCode` varchar(11) default '0' COMMENT '供应商编号',
  `StoreCode` varchar(50) default '0' COMMENT '仓库编号',
  `deptCode` varchar(20) default '0' COMMENT '部门编号',
  `EmpCode` varchar(20) default '0' COMMENT '业务员编号',
  `DeliveryDate` date default NULL COMMENT '收货日期',
  `FinishFlag` smallint(6) default '0' COMMENT '订单完成标志',
  `CheckFlag` smallint(6) default '0' COMMENT '审核状态',
  `CheckMan` varchar(50) default NULL COMMENT '审核人',
  `CheckDate` date default NULL COMMENT '审核日期',
  `Amount` decimal(10,2) default '0.00' COMMENT '总金额',
  `SettleTypeFlag` smallint(6) default '0' COMMENT '0：什么都不选。1：预付 2：清货 3：货款结清',
  `remark` varchar(100) default '0' COMMENT '备注',
  PRIMARY KEY  (`id`,`orderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购订单';

-- 数据导出被取消选择.


-- 导出  表 ebspos.cgorderdetail 结构
CREATE TABLE IF NOT EXISTS `cgorderdetail` (
  `id` bigint(20) NOT NULL auto_increment,
  `orderCode` varchar(20) NOT NULL default '0' COMMENT '订单号',
  `SerialNo` int(11) NOT NULL default '1' COMMENT '序号',
  `GoodsCode` varchar(20) default NULL COMMENT '商品编号',
  `OrigPrice` decimal(10,2) default NULL COMMENT '原订价',
  `Discount` decimal(10,2) default NULL COMMENT '折扣',
  `Price` decimal(10,2) default NULL COMMENT '确认价',
  `Quantity` decimal(10,2) default NULL COMMENT '数量',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `TaxRate` decimal(10,2) default NULL COMMENT '税率',
  `TaxAmount` decimal(10,2) default NULL COMMENT '税额',
  `InStoreQty` decimal(10,2) default NULL COMMENT '已入库数',
  `ReturnQty` decimal(10,2) default NULL COMMENT '退回数',
  `remark` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`,`orderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购订单明细';

-- 数据导出被取消选择.


-- 导出  表 ebspos.cgreorder 结构
CREATE TABLE IF NOT EXISTS `cgreorder` (
  `id` bigint(20) NOT NULL auto_increment,
  `orderCode` varchar(20) NOT NULL default '0' COMMENT '订单编号',
  `orderDate` date default NULL COMMENT '订单日期',
  `Operator` varchar(20) default '0' COMMENT '制单人',
  `supplierCode` varchar(20) default '0' COMMENT '供应商编号',
  `StoreCode` varchar(20) default '0' COMMENT '仓库编号',
  `DeptCode` varchar(20) default '0' COMMENT '部门编号',
  `EmpCode` varchar(20) default '0' COMMENT '业务员编号',
  `RelatedOrderCode` varchar(20) default NULL COMMENT '关联单号',
  `FinishFlag` smallint(6) default '0' COMMENT '订单完成标志',
  `CheckFlag` smallint(6) default '0' COMMENT '审核状态',
  `CheckMan` varchar(50) default NULL COMMENT '审核人',
  `CheckDate` date default NULL COMMENT '审核日期',
  `StopFlag` smallint(6) default '0' COMMENT '停用标志',
  `StopMan` varchar(20) default '0' COMMENT '终止人',
  `StopDate` date default NULL COMMENT '终止日期',
  `Amount` decimal(10,2) default '0.00' COMMENT '总金额',
  `SettleTypeFlag` smallint(6) default '0' COMMENT '0：什么都不选。1：预付 2：清货 3：货款结清',
  `remark` varchar(100) default '0' COMMENT '备注',
  PRIMARY KEY  (`id`,`orderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购退回主表';

-- 数据导出被取消选择.


-- 导出  表 ebspos.cgreorderdetail 结构
CREATE TABLE IF NOT EXISTS `cgreorderdetail` (
  `id` bigint(20) NOT NULL auto_increment,
  `orderCode` varchar(20) NOT NULL default '0' COMMENT '订单号',
  `SerialNo` int(11) NOT NULL default '1' COMMENT '序号',
  `GoodsCode` varchar(20) default NULL COMMENT '商品编号',
  `OrigPrice` decimal(10,2) default NULL COMMENT '原订价',
  `Discount` decimal(10,2) default NULL COMMENT '折扣',
  `Price` decimal(10,2) default NULL COMMENT '确认价',
  `Quantity` decimal(10,2) default NULL COMMENT '数量',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `TaxRate` decimal(10,2) default NULL COMMENT '税率',
  `TaxAmount` decimal(10,2) default NULL COMMENT '税额',
  `ReturnQty` decimal(10,2) default NULL COMMENT '已退库数',
  `remark` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`,`orderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购退回明细表';

-- 数据导出被取消选择.


-- 导出  表 ebspos.ckcurrstore 结构
CREATE TABLE IF NOT EXISTS `ckcurrstore` (
  `id` bigint(20) NOT NULL auto_increment,
  `StoreCode` varchar(20) NOT NULL COMMENT '仓库编号',
  `GoodsCode` varchar(20) NOT NULL COMMENT '商品编号',
  `Quantity` decimal(10,2) default NULL COMMENT '数量',
  `CostPrice` decimal(10,2) default NULL COMMENT '单价',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `remark` varchar(50) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `StoreCode_GoodsCode` (`StoreCode`,`GoodsCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存表';

-- 数据导出被取消选择.


-- 导出  表 ebspos.ckinitstore 结构
CREATE TABLE IF NOT EXISTS `ckinitstore` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderNo` varchar(20) NOT NULL default '',
  `OrderDate` varchar(20) default NULL,
  `StoreCode` varchar(20) default NULL,
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
  PRIMARY KEY  (`id`,`OrderNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.ckinitstoredetail 结构
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.ckjhcheck 结构
CREATE TABLE IF NOT EXISTS `ckjhcheck` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderCode` varchar(20) NOT NULL default '0' COMMENT '进货单编号',
  `OrderDate` date default NULL COMMENT '进货日期',
  `JHPayOrderNo` varchar(20) default NULL COMMENT '付款单编号',
  `SupplierCode` varchar(20) default NULL COMMENT '供应商编码',
  `StoreCode` varchar(20) default NULL COMMENT '仓库编码',
  `InOutTypeNo` varchar(20) default NULL COMMENT '入库/退货类型',
  `BillOrderNo` varchar(20) default NULL COMMENT '采购单号',
  `RelatedBillNo` varchar(20) default NULL COMMENT '关联单号',
  `DeptCode` varchar(20) default NULL COMMENT '部门编码',
  `EmpCode` varchar(20) default NULL COMMENT '经办人编码',
  `Operator` varchar(20) default NULL COMMENT '制单人',
  `PayAmount` decimal(10,2) default NULL COMMENT '已付金额',
  `CKAmount` decimal(10,2) default NULL COMMENT '入库金额',
  `CheckFlag` smallint(6) default NULL COMMENT '审核标志',
  `CheckDate` date default NULL COMMENT '审核日期',
  `CheckMan` varchar(20) default NULL COMMENT '审核人',
  `remark` varchar(100) default NULL COMMENT '备注',
  `SettleTypeFlag` smallint(6) default '0' COMMENT '是否当面付，0：不付，1：付',
  PRIMARY KEY  (`id`,`OrderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购入库表';

-- 数据导出被取消选择.


-- 导出  表 ebspos.ckjhcheckdetail 结构
CREATE TABLE IF NOT EXISTS `ckjhcheckdetail` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderCode` varchar(20) NOT NULL default '0' COMMENT '进货单号',
  `SerialNo` int(11) NOT NULL default '1' COMMENT '进货单序号',
  `GoodsCode` varchar(20) default NULL COMMENT '商品编号',
  `Quantity` decimal(10,2) default NULL COMMENT '数量',
  `OrigPrice` decimal(10,2) default NULL COMMENT '原订价',
  `Discount` decimal(10,2) default NULL COMMENT '折扣',
  `Price` decimal(10,2) default NULL COMMENT '单价',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `TaxRate` decimal(10,2) default NULL COMMENT '税率',
  `TaxAmount` decimal(10,2) default NULL COMMENT '税额',
  `remark` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`,`OrderCode`,`SerialNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购入库明细表';

-- 数据导出被取消选择.


-- 导出  表 ebspos.ckxscheck 结构
CREATE TABLE IF NOT EXISTS `ckxscheck` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderCode` varchar(20) default NULL COMMENT '单据编号',
  `OrderDate` date NOT NULL COMMENT '单据日期',
  `ClientCode` varchar(20) default NULL COMMENT '客户编码',
  `StoreCode` varchar(20) default NULL COMMENT '仓库编码',
  `EmpCode` varchar(20) default NULL COMMENT '业务员',
  `DeptCode` varchar(20) default NULL COMMENT '部门编码',
  `InOutTypeNo` varchar(20) default NULL COMMENT '出库类型',
  `BillOrderNo` varchar(20) default NULL COMMENT '订单编号',
  `RelatedBillNo` varchar(20) default NULL COMMENT '关联单据编号',
  `Operator` varchar(20) default NULL COMMENT '制单人',
  `CKAmount` decimal(10,2) default NULL COMMENT '仓库成本',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `CheckFlag` smallint(6) default NULL COMMENT '审核标志',
  `CheckDate` date NOT NULL COMMENT '审核日期',
  `CheckMan` varchar(20) default NULL COMMENT '审核人',
  `Memo` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.ckxscheckdetail 结构
CREATE TABLE IF NOT EXISTS `ckxscheckdetail` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderCode` varchar(20) default NULL COMMENT '单据编号',
  `SerialNo` int(11) default NULL COMMENT '序号',
  `GoodsCode` varchar(20) default NULL COMMENT '商品编码',
  `Quantity` decimal(10,2) default NULL COMMENT '数量',
  `Unit` varchar(20) default NULL COMMENT '单位',
  `OrigPrice` decimal(10,2) default NULL COMMENT '原价',
  `Discount` decimal(10,2) default NULL COMMENT '折扣',
  `Price` decimal(10,2) default NULL COMMENT '单价',
  `TaxRate` decimal(10,2) default NULL COMMENT '税率',
  `TaxAmount` decimal(10,2) default NULL COMMENT '税额',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `CKPrice` decimal(10,2) default NULL COMMENT '成本单价',
  `Memo` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `ordercode_idx` (`OrderCode`,`SerialNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.comment 结构
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

-- 数据导出被取消选择.


-- 导出  表 ebspos.employee 结构
CREATE TABLE IF NOT EXISTS `employee` (
  `id` bigint(20) NOT NULL auto_increment,
  `usr_no` varchar(20) NOT NULL COMMENT '员工编号',
  `usr_name` varchar(50) default NULL COMMENT '姓名',
  `pwd` varchar(50) default NULL COMMENT '密码',
  `deptcode` varchar(20) default NULL COMMENT '部门',
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
  PRIMARY KEY  (`id`,`usr_no`),
  UNIQUE KEY `usr_no` (`usr_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.jbclient 结构
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
  PRIMARY KEY  (`id`),
  UNIQUE KEY `ClientCode` (`ClientCode`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户资料';

-- 数据导出被取消选择.


-- 导出  表 ebspos.jbgoods 结构
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品资料表';

-- 数据导出被取消选择.


-- 导出  表 ebspos.jbstore 结构
CREATE TABLE IF NOT EXISTS `jbstore` (
  `id` int(20) NOT NULL auto_increment,
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
  PRIMARY KEY  (`id`),
  UNIQUE KEY `StoreCode` (`StoreCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='仓库信息';

-- 数据导出被取消选择.


-- 导出  表 ebspos.jbsupplier 结构
CREATE TABLE IF NOT EXISTS `jbsupplier` (
  `id` bigint(20) NOT NULL auto_increment,
  `supplierCode` varchar(20) default '0' COMMENT '供应商编码',
  `supplierName` varchar(50) default '0' COMMENT '供应商名称',
  `EmpCode` varchar(20) default '0' COMMENT '管辖业务员',
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
  `NeedPay` decimal(10,2) default '0.00' COMMENT '应付款',
  `BuyAmount` decimal(10,2) default '0.00' COMMENT '购买总金额',
  `SplusAmount` decimal(10,2) default '0.00' COMMENT '往来余额',
  `StopFlag` smallint(6) default '0' COMMENT '停止业务标志',
  `remark` varchar(150) default '0' COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `supplierCode` (`supplierCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商资料';

-- 数据导出被取消选择.


-- 导出  表 ebspos.jhpay 结构
CREATE TABLE IF NOT EXISTS `jhpay` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderCode` varchar(20) NOT NULL COMMENT '付款单号',
  `OrderDate` date default NULL COMMENT '付款日期',
  `SupplierCode` varchar(20) default NULL COMMENT '供应商',
  `DeptCode` varchar(20) default NULL COMMENT '部门',
  `EmpCode` varchar(20) default NULL COMMENT '经手人',
  `Operator` varchar(20) default NULL COMMENT '制单人',
  `PayType` smallint(6) default NULL COMMENT '账户类型',
  `BankNo` varchar(20) default NULL COMMENT '账号',
  `CheckFlag` smallint(6) default NULL COMMENT '审核标志',
  `CheckMan` varchar(20) default NULL COMMENT '审核人',
  `CheckDate` date default NULL COMMENT '审核日期',
  `Amount` decimal(10,2) default NULL COMMENT '付款金额',
  `BillOrderNo` varchar(20) default NULL COMMENT '关联单号',
  `remark` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `orderCode` (`OrderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购付款单';

-- 数据导出被取消选择.


-- 导出  表 ebspos.jhpaydetail 结构
CREATE TABLE IF NOT EXISTS `jhpaydetail` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderCode` varchar(20) NOT NULL COMMENT '付款单编号',
  `SerialNo` int(11) NOT NULL default '1' COMMENT '序号',
  `CollateType` varchar(50) default NULL COMMENT '单据类型',
  `PayOrderNo` varchar(20) default NULL COMMENT '所核销的单号',
  `NowCollated` decimal(10,2) default NULL COMMENT '本次核销金额',
  `Adjust` decimal(10,2) default NULL COMMENT '调整值（抹零）',
  `Amount` decimal(10,2) default NULL COMMENT '最终核销金额',
  `remark` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `OrderCode_SerialNo` (`OrderCode`,`SerialNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购付款单明细';

-- 数据导出被取消选择.


-- 导出  表 ebspos.menu 结构
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单';

-- 数据导出被取消选择.


-- 导出  表 ebspos.message 结构
CREATE TABLE IF NOT EXISTS `message` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(45) NOT NULL,
  `content` varchar(200) NOT NULL,
  `dateTime` datetime NOT NULL,
  `nick` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.module 结构
CREATE TABLE IF NOT EXISTS `module` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(20) default NULL,
  `detail` varchar(100) default NULL,
  `turn` tinyint(2) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.organization 结构
CREATE TABLE IF NOT EXISTS `organization` (
  `id` bigint(20) NOT NULL auto_increment,
  `orgcode` varchar(20) default NULL COMMENT '编号',
  `name` varchar(30) default NULL COMMENT '名称',
  `addr` varchar(50) default NULL COMMENT '地址',
  `picid` bigint(20) default NULL,
  `sortnum` smallint(6) default NULL COMMENT '排序',
  `remark` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `num` (`orgcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织';

-- 数据导出被取消选择.


-- 导出  表 ebspos.partment 结构
CREATE TABLE IF NOT EXISTS `partment` (
  `id` bigint(20) NOT NULL auto_increment,
  `deptCode` varchar(20) NOT NULL COMMENT '部门编号',
  `name` varchar(50) default NULL COMMENT '名称',
  `picid` bigint(20) default NULL,
  `orgid` bigint(20) default NULL COMMENT '组织ID',
  `remark` varchar(250) default NULL,
  `pid` bigint(10) default NULL COMMENT '父级部门id',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `num` (`deptCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门';

-- 数据导出被取消选择.


-- 导出  表 ebspos.post 结构
CREATE TABLE IF NOT EXISTS `post` (
  `id` int(11) NOT NULL auto_increment,
  `topicID` int(11) NOT NULL,
  `userID` int(11) NOT NULL default '0',
  `content` text NOT NULL,
  `createTime` timestamp NULL default CURRENT_TIMESTAMP,
  `hasReply` bit(1) NOT NULL default '\0',
  `updateTime` timestamp NULL default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.powermenu 结构
CREATE TABLE IF NOT EXISTS `powermenu` (
  `menuid` bigint(20) NOT NULL COMMENT '菜单ID',
  `objid` varchar(20) NOT NULL COMMENT '员工id部门id机构id角色id',
  `type` smallint(1) NOT NULL COMMENT '0,2,3,1',
  UNIQUE KEY `索引 1` (`menuid`,`objid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.project 结构
CREATE TABLE IF NOT EXISTS `project` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `finish` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.reply 结构
CREATE TABLE IF NOT EXISTS `reply` (
  `id` int(11) NOT NULL auto_increment,
  `topicID` int(11) NOT NULL default '1',
  `postID` int(11) NOT NULL,
  `userID` int(11) NOT NULL default '0',
  `content` varchar(300) NOT NULL,
  `createTime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.role 结构
CREATE TABLE IF NOT EXISTS `role` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(20) NOT NULL,
  `remark` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='角色';

-- 数据导出被取消选择.


-- 导出  表 ebspos.storetype 结构
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

-- 数据导出被取消选择.


-- 导出  表 ebspos.topic 结构
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.types 结构
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定义类别';

-- 数据导出被取消选择.


-- 导出  表 ebspos.user 结构
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.userrole 结构
CREATE TABLE IF NOT EXISTS `userrole` (
  `userid` bigint(20) NOT NULL COMMENT '用户id',
  `roleid` bigint(20) NOT NULL COMMENT '角色id',
  PRIMARY KEY  (`userid`,`roleid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- 数据导出被取消选择.


-- 导出  表 ebspos.xsorder 结构
CREATE TABLE IF NOT EXISTS `xsorder` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderCode` varchar(20) default NULL COMMENT '销售订单号',
  `OrderDate` date NOT NULL COMMENT '日期',
  `ClientCode` varchar(20) default NULL COMMENT '客户编码',
  `StoreCode` varchar(20) default NULL COMMENT '仓库编码',
  `FinishFlag` smallint(6) default NULL COMMENT '完成标志',
  `DeptCode` varchar(20) default NULL COMMENT '部门编码',
  `EmpCode` varchar(20) default NULL COMMENT '员工编码',
  `DeliveryDate` date NOT NULL COMMENT '发货日期',
  `Operator` varchar(20) default NULL COMMENT '制单人',
  `CheckFlag` smallint(6) default NULL COMMENT '审核标志',
  `CheckMan` varchar(20) default NULL COMMENT '审核人',
  `CheckDate` date NOT NULL COMMENT '审核日期',
  `StopFlag` smallint(6) default NULL COMMENT '终止标志',
  `StopMan` varchar(50) default NULL,
  `StopDate` date NOT NULL,
  `SettleTypeFlag` smallint(6) default NULL COMMENT '操作标志1表示清货',
  `Amount` decimal(10,2) default NULL COMMENT '订单金额',
  `CKAmount` decimal(10,2) default NULL COMMENT '成本',
  `Memo` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销售订单';

-- 数据导出被取消选择.


-- 导出  表 ebspos.xsorderdetail 结构
CREATE TABLE IF NOT EXISTS `xsorderdetail` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderCode` varchar(20) default NULL COMMENT '销售订单号',
  `SerialNo` int(11) default NULL COMMENT '序号',
  `StoreCode` varchar(20) default NULL COMMENT '仓库代码',
  `GoodsCode` varchar(20) default NULL COMMENT '商品编码',
  `OrigPrice` decimal(10,2) default NULL COMMENT '原价',
  `Discount` decimal(10,2) default NULL COMMENT '折扣',
  `Price` decimal(10,2) default NULL COMMENT '价格',
  `Quantity` decimal(10,2) default NULL COMMENT '数量',
  `Unit` varchar(20) default NULL COMMENT '单位',
  `TaxRate` decimal(10,2) default NULL COMMENT '税率',
  `TaxAmount` decimal(10,2) default NULL COMMENT '税额',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `OutStoreQty` decimal(10,2) default NULL COMMENT '出库数量',
  `ReturnQty` decimal(10,2) default NULL COMMENT '退回数量',
  `CKPrice` decimal(10,2) default NULL COMMENT '销售时的成本价',
  `Memo` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销售订单明细表';

-- 数据导出被取消选择.


-- 导出  表 ebspos.xsreorder 结构
CREATE TABLE IF NOT EXISTS `xsreorder` (
  `ID` bigint(20) NOT NULL auto_increment,
  `OrderCode` varchar(20) default NULL COMMENT '订单编号',
  `OrderDate` date NOT NULL COMMENT '单据日期',
  `ClientCode` varchar(20) default NULL COMMENT '客户编码',
  `StoreCode` varchar(20) default NULL COMMENT '仓库编码',
  `DeptCode` varchar(20) default NULL COMMENT '部门编码',
  `EmpCode` varchar(20) default NULL COMMENT '业务员编码',
  `ReturnOrderNo` varchar(20) default NULL COMMENT '退回的销售订单',
  `RelateOrderNo` varchar(20) default NULL COMMENT '关联单据',
  `Operator` varchar(20) default NULL COMMENT '制单人',
  `FinishFlag` smallint(6) default NULL COMMENT '完成标志',
  `CheckFlag` smallint(6) default NULL,
  `CheckMan` varchar(20) default NULL COMMENT '审核人',
  `CheckDate` date NOT NULL COMMENT '审核日期',
  `StopFlag` smallint(6) default NULL COMMENT '终止标志',
  `StopMan` varchar(20) default NULL COMMENT '终止人',
  `StopDate` date NOT NULL COMMENT '终止日期',
  `SettleTypeFlag` smallint(6) default NULL COMMENT '清货等的标志',
  `Amount` decimal(10,2) default NULL COMMENT '退回金额',
  `CKAmount` decimal(10,2) default NULL COMMENT '成本金额',
  `Memo` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `ordercode_idx` (`OrderCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.xsreorderdetail 结构
CREATE TABLE IF NOT EXISTS `xsreorderdetail` (
  `id` bigint(20) NOT NULL auto_increment,
  `OrderCode` varchar(20) default NULL COMMENT '退回单编号',
  `SerialNo` int(11) default NULL,
  `StoreCode` varchar(20) default NULL COMMENT '仓库编码',
  `GoodsCode` varchar(20) default NULL COMMENT '商品编码',
  `OrigPrice` decimal(10,2) default NULL COMMENT '原价',
  `Discount` decimal(10,2) default NULL COMMENT '折扣',
  `Price` decimal(10,2) default NULL COMMENT '单价',
  `Quantity` decimal(10,2) default NULL COMMENT '数量',
  `TaxRate` decimal(10,2) default NULL COMMENT '税率',
  `TaxAmount` decimal(10,2) default NULL COMMENT '税额',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `OutStoreQty` decimal(10,2) default NULL COMMENT '已出库数量',
  `CKPrice` decimal(10,2) default NULL COMMENT '成本价',
  `RelateOrderNo` varchar(20) default NULL COMMENT '相关单据',
  `OrderSerialNo` int(11) default NULL,
  `Memo` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `orderCode` (`OrderCode`,`SerialNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.xtsqldata 结构
CREATE TABLE IF NOT EXISTS `xtsqldata` (
  `id` bigint(20) NOT NULL auto_increment,
  `DataNo` varchar(40) default NULL,
  `Name` varchar(50) default NULL,
  `DataType` varchar(20) default NULL,
  `CreateMan` varchar(20) default NULL,
  `DataSql` varchar(255) default NULL,
  `SqlFields` longblob,
  `Memo` varchar(100) default NULL,
  `ClientUseFlag` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.xtsqlfield 结构
CREATE TABLE IF NOT EXISTS `xtsqlfield` (
  `id` bigint(20) NOT NULL auto_increment,
  `DataNo` varchar(40) default NULL,
  `SerialNo` int(11) default NULL,
  `SqFieldName` varchar(50) default NULL,
  `SqCFieldName` varchar(50) default NULL,
  `FieldWidth` int(11) default NULL,
  `ReadFlag` tinyint(4) default NULL,
  `VisibleFlag` tinyint(4) default NULL,
  `FixFlag` tinyint(4) default NULL,
  `KeyFlag` tinyint(4) default NULL,
  `CClientName` varchar(50) default NULL,
  `ClientWidth` int(11) default NULL,
  `ClientVisibleFlag` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据导出被取消选择.


-- 导出  表 ebspos.xttables 结构
CREATE TABLE IF NOT EXISTS `xttables` (
  `id` int(10) NOT NULL auto_increment,
  `tablename` varchar(50) default '0' COMMENT '表名',
  `tlevel` smallint(2) default '0',
  `ttype` smallint(2) default '0' COMMENT '1 JB  2 JH 3 XS 4 CK 5 CW 6 XT 7 其他',
  `remark` char(10) default '0',
  `sysdefault` smallint(2) default '0',
  `ctablename` varchar(50) default '0' COMMENT '表中文名称',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统表信息';

-- 数据导出被取消选择.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
