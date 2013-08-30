/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-08-30 17:03:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `createDateTime` datetime NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `url` varchar(200) DEFAULT NULL,
  `viewCount` int(11) NOT NULL DEFAULT '0',
  `replyCount` int(11) NOT NULL DEFAULT '0',
  `content` text NOT NULL,
  `categorySubId` int(11) DEFAULT NULL,
  `tags` varchar(300) NOT NULL,
  `projectId` int(11) DEFAULT NULL,
  `finish` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('2', '我的ABAP命名规范', '2012-12-11 17:33:44', '0', '', '230', '0', '<h3>\n	<strong><span style=\"background-color:#FFFFFF;color:#FF9900;line-height:2;\"><span style=\"line-height:1.5;\">目录</span><span></span></span></strong> \n</h3>\n<h4>\n	<ul>\n		<li>\n			<span style=\"color:#337FE5;\"><span style=\"color:#337FE5;\"><a href=\"#g_type\">全局类型</a></span></span> \n		</li>\n		<li>\n			<span style=\"color:#337FE5;\"><a href=\"#g_cns\">全局常量</a></span> \n		</li>\n		<li>\n			<span style=\"color:#337FE5;\"><a href=\"#g_var\">全局变量</a></span> \n		</li>\n		<li>\n			<span style=\"color:#337FE5;\"><span style=\"color:#337FE5;\"><a href=\"#l_var\">局部变量</a></span> </span> \n		</li>\n	</ul>\n</h4>\n<h3>\n	<span style=\"color:#FF9900;\"><a name=\"g_type\"></a>全局类型</span> \n</h3>\n<ol>\n	<li>\n		<span><span>表类型</span><br />\n<pre class=\"prettyprint brush:abap\">TYP_TAB_*</pre>\n</span> \n	</li>\n	<li>\n		<span><span>结构体类型</span><br />\n<pre class=\"prettyprint brush:abap\">TYP_*</pre>\n</span> \n	</li>\n</ol>\n<p>\n	<span></span> \n</p>\n<h3>\n	<span style=\"color:#FF9900;\"><a name=\"g_cns\"></a>全局常量</span> \n</h3>\n<ol>\n	<li>\n		<span>表类型常量<br />\n<pre class=\"prettyprint brush:abap\">CNS_TAB_*</pre>\n</span> \n	</li>\n	<li>\n		<span>结构体类型常量<br />\n<pre class=\"prettyprint brush:abap\">CNS_*</pre>\n</span> \n	</li>\n</ol>\n<h3>\n	<span style=\"color:#FF9900;\"><a name=\"g_var\"></a>全局变量</span> \n</h3>\n<ol>\n	<li>\n		<span>表类型变量<br />\n<pre class=\"prettyprint brush:abap\">TAB_*</pre>\n</span> \n	</li>\n	<li>\n		<span>结构体类型变量<br />\n<span></span> \n<pre class=\"prettyprint brush:abap\">W_*</pre>\n</span> \n	</li>\n</ol>\n<h3>\n	<span style=\"color:#FF9900;\"><a name=\"l_var\"></a>局部变量</span> \n</h3>\n<ol>\n	<li>\n		<span>表类型局部变量<br />\n<pre class=\"prettyprint brush:abap\">L_TAB_*</pre>\n</span> \n	</li>\n	<li>\n		<span>结构体类型变量<br />\n<pre class=\"prettyprint brush:abap\">L_W_*</pre>\n</span> \n	</li>\n</ol>', '1', 'sap,abap,types', '2', '1');
INSERT INTO `article` VALUES ('45', 'SAP IMG 解释', '2013-01-28 17:36:50', '1', 'http://www.cnblogs.com/mybi/archive/2010/12/21/1912852.html', '10', '0', '<p>\n	<span style=\"line-height:2;\"><strong>IMG</strong> - Implementation Guide(IMG)是SAP系统的配置工具，它可按你公司的要求配置SAP系统以适合你公司的要求。</span>\n</p>\n<p>\n	<span style=\"line-height:2;\">有三种类型的IMG，分别是:</span>\n</p>\n<p>\n	<span style=\"line-height:2;\">1. SAP Reference IMG，可在这里配置SAP系统的所有功能。</span>\n</p>\n<p>\n	<span style=\"line-height:2;\">2. Project IMGs，它基于Rrference IMG，可为某个项目进行单独配置，比如我们可建立一个FI的Project IMGs，方便配置。</span>\n</p>\n<p>\n	<span style=\"line-height:2;\">3. Project view IMGs，在Project IMGs里的Project views里设置，在Project IMGs里再建立一个视图，把一些配置选项添加到该视图里。通过这样一层层的分工，就可把Reference IMG里的配置分配给不同的人员进行维护。</span>\n</p>\n<span style=\"line-height:2;\"> 我们可为不同版本的SAP系统建立IMG，如4.0x，4.5x。这种IMG叫做版本相关IMG。通过“help”--“Release notes”菜单可显示各个SAP发布版的区别。\n我们可用事务码“spro”来进入SAP Reference IMG。使用“spro_admin”进入project IMGs。</span>', '1', 'sap,img', '1', '1');

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
-- Table structure for `category_sub`
-- ----------------------------
DROP TABLE IF EXISTS `category_sub`;
CREATE TABLE `category_sub` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `pId` int(11) DEFAULT NULL,
  `order` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category_sub
-- ----------------------------
INSERT INTO `category_sub` VALUES ('1', '基础知识', '1', '0');
INSERT INTO `category_sub` VALUES ('3', 'JFINAL', '2', '0');
INSERT INTO `category_sub` VALUES ('4', 'FUNCTION详解', '1', '0');
INSERT INTO `category_sub` VALUES ('6', 'javascript', '3', '0');
INSERT INTO `category_sub` VALUES ('7', 'css', '3', '0');
INSERT INTO `category_sub` VALUES ('8', '谈谈生活', '4', '0');
INSERT INTO `category_sub` VALUES ('9', '软件分享', '4', '2');
INSERT INTO `category_sub` VALUES ('10', '图片展示', '4', '0');
INSERT INTO `category_sub` VALUES ('11', '开发需知', '1', '0');
INSERT INTO `category_sub` VALUES ('12', '代码分享', '2', '0');
INSERT INTO `category_sub` VALUES ('13', 'SAPJCO', '1', '0');
INSERT INTO `category_sub` VALUES ('15', 'ABAP', '6', '0');
INSERT INTO `category_sub` VALUES ('16', 'SAP', '6', '1');

-- ----------------------------
-- Table structure for `category_super`
-- ----------------------------
DROP TABLE IF EXISTS `category_super`;
CREATE TABLE `category_super` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `order` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category_super
-- ----------------------------
INSERT INTO `category_super` VALUES ('1', 'ABAP', '0');
INSERT INTO `category_super` VALUES ('2', 'JAVA', '1');
INSERT INTO `category_super` VALUES ('3', 'WEB技术', '2');
INSERT INTO `category_super` VALUES ('4', '@生活@', '3');
INSERT INTO `category_super` VALUES ('6', '资料分享', '4');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ckinitstore
-- ----------------------------
INSERT INTO `ckinitstore` VALUES ('5', 'CK1377840011216', '2013-08-06', '0', null, null, '1', '1', '3', '3', null, '2013-08-13', '4', null, '2', null, null, null, null);
INSERT INTO `ckinitstore` VALUES ('6', 'CK1377840751068', '2013-08-14', '0', null, null, '1', '1', 'dd', '45', null, '2013-08-20', '45', null, '5000', null, null, null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ckinitstoredetail
-- ----------------------------
INSERT INTO `ckinitstoredetail` VALUES ('29', 'CK1377830836634', null, '1111', '123', null, null, null, '0', '0', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('30', 'CK1377840751068', null, '1111', '123', null, null, null, '10', '123', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('31', 'CK1377840751068', null, '1111', null, null, null, null, '20', '123', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('32', 'CK1377840751068', null, '1111', null, null, null, null, '30', '12', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('33', 'CK1377840751068', null, '1111', null, null, null, null, '40', '0', null, '14', null, null, null, null, null);
INSERT INTO `ckinitstoredetail` VALUES ('38', 'CK1377840751068', null, '1111', '123', null, null, null, '7788', '9900', null, '14', null, null, null, null, null);

-- ----------------------------
-- Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `articleId` int(11) NOT NULL,
  `email` varchar(40) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `dateTime` datetime NOT NULL,
  `nick` varchar(45) NOT NULL,
  `pId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

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
INSERT INTO `employee` VALUES ('8', 'fdsf', 'fdfd', 'e10adc3949ba59abbe56e057f20f883e', '1', null, null, '高中', null, null, '11111', null, null, null, '业务员', null, null, null, null, null, '1', '2013-08-18 11:46:19', null, null, null, '0');
INSERT INTO `employee` VALUES ('9', '454654', '6565', 'e10adc3949ba59abbe56e057f20f883e', '1', null, null, '高中', null, null, '6565656565', null, null, null, '业务员', null, null, null, null, null, '1', '2013-08-18 11:46:31', null, null, null, '0');

-- ----------------------------
-- Table structure for `jbgoods`
-- ----------------------------
DROP TABLE IF EXISTS `jbgoods`;
CREATE TABLE `jbgoods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `GoodsCode` varchar(50) DEFAULT NULL COMMENT '商品编号',
  `GoodsName` varchar(100) DEFAULT NULL COMMENT '商品名称',
  `GoodsTypeNo` bigint(20) DEFAULT NULL COMMENT '大类',
  `subgoodstypeno` bigint(20) DEFAULT NULL COMMENT '中类',
  `smallgoodstypeno` bigint(20) DEFAULT NULL COMMENT '小类',
  `BrandNo` varchar(50) DEFAULT NULL COMMENT '品牌',
  `ProduceArea` varchar(255) DEFAULT NULL COMMENT '产地',
  `ProduceName` varchar(255) DEFAULT NULL COMMENT '生产厂家',
  `Clolor` varchar(255) DEFAULT NULL COMMENT '颜色',
  `BarCode` varchar(255) DEFAULT NULL COMMENT '条码',
  `Model` varchar(255) DEFAULT NULL COMMENT '规格型号',
  `BaseUnit` varchar(255) DEFAULT NULL COMMENT '基本单位',
  `BRefPrice` decimal(10,2) DEFAULT NULL COMMENT '参考进价',
  `SRefPrice` decimal(10,2) DEFAULT NULL COMMENT '参考销价',
  `CostPrice` decimal(10,2) DEFAULT NULL COMMENT '成本价',
  `Picture` blob COMMENT '图片',
  `StopFlag` smallint(1) DEFAULT NULL COMMENT '是否停用',
  `Remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `Season` varchar(1) DEFAULT NULL COMMENT '季度‘1、2、3、4’',
  `YearBy` varchar(4) DEFAULT NULL COMMENT '年份',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品资料表';

-- ----------------------------
-- Records of jbgoods
-- ----------------------------
INSERT INTO `jbgoods` VALUES ('1', '1111', '123', '30', '32', '33', '19', '1', '1', null, '1', '333', '14', '11.00', '11.00', '11.00', null, '1', 'wwww', '1', '2011');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='仓库信息';

-- ----------------------------
-- Records of jbstore
-- ----------------------------
INSERT INTO `jbstore` VALUES ('1', '1', '1', '男服装', null, '10000', '八百伴', '5', '100', '按件', '1', 'T恤，牛仔裤', null, null, null, null, null);
INSERT INTO `jbstore` VALUES ('2', '2', '239', '材料', null, '1000', '张江', '4', '1888', '批发', null, '布匹', null, null, null, null, null);
INSERT INTO `jbstore` VALUES ('4', '4', '4', '4', null, '4', '4', '1', '4', '4', null, null, null, null, null, null, null);
INSERT INTO `jbstore` VALUES ('5', '5', '5', '5', null, '5', '5', '1', '5', '5', null, null, null, null, null, null, null);
INSERT INTO `jbstore` VALUES ('6', '3452', '2435', '2345', null, '34', '2345', '1', '2345', '2345', null, null, null, null, null, null, null);

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
) ENGINE=MyISAM AUTO_INCREMENT=1051 DEFAULT CHARSET=utf8 COMMENT='系统菜单';

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
INSERT INTO `menu` VALUES ('113', '商品资料', 'jbgoods', '1', '2', null, '3', null, '11', '0', null, '1', null);
INSERT INTO `menu` VALUES ('11', '资料管理', null, '1', '1', null, '1', null, '1', '0', null, '1', null);
INSERT INTO `menu` VALUES ('111', '供应商资料', '#', '1', '2', null, '1', null, '11', '0', null, '1', null);
INSERT INTO `menu` VALUES ('112', '客户资料', '#', '1', '2', null, '2', null, '11', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1023', '采购入库单', '#', '1', '2', null, '1', null, '1021', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1021', '采购管理', null, '1', '1', null, '0', null, '2', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1022', '采购订单', '#', '1', '2', null, '0', null, '1021', '0', null, '1', null);
INSERT INTO `menu` VALUES ('1019', '定义类别', 'types', '1', '2', null, '6', null, '11', '0', null, '1', null);
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
INSERT INTO `menu` VALUES ('1038', '期初库存商品录入单', 'ckinitstore', '1', '2', null, '0', null, '1037', '0', null, '1', null);
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
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `content` varchar(200) NOT NULL,
  `dateTime` datetime NOT NULL,
  `nick` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for `module`
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `detail` varchar(100) DEFAULT NULL,
  `turn` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of module
-- ----------------------------
INSERT INTO `module` VALUES ('4', '屌丝一起来 ⊙ω⊙', null, '1');
INSERT INTO `module` VALUES ('5', '技术专区 (ΘｏΘ)', null, '2');
INSERT INTO `module` VALUES ('6', 'github ：）', null, '3');

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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='组织';

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='部门';

-- ----------------------------
-- Records of partment
-- ----------------------------
INSERT INTO `partment` VALUES ('1', '销售部', null, '4', '2', '0', '001');
INSERT INTO `partment` VALUES ('2', '财务部', null, '1', '2', '0', '002');
INSERT INTO `partment` VALUES ('3', '22222', null, '1', '2', '0', '222');
INSERT INTO `partment` VALUES ('4', '33', null, '1', '2', '0', '33');
INSERT INTO `partment` VALUES ('5', '33', null, '1', '2', '0', '44');
INSERT INTO `partment` VALUES ('6', '23', null, '1', '2', '0', '23');
INSERT INTO `partment` VALUES ('7', '21', null, '1', '2', '0', '21');
INSERT INTO `partment` VALUES ('8', '22', null, '1', '2', '0', '222');
INSERT INTO `partment` VALUES ('9', '44', null, '1', '2', '0', '234');
INSERT INTO `partment` VALUES ('10', '21', null, '1', '2', '0', '112');
INSERT INTO `partment` VALUES ('11', '111', null, '1', '2', '0', '121');
INSERT INTO `partment` VALUES ('12', '3343', null, '1', '2', '0', '1234');
INSERT INTO `partment` VALUES ('13', '财务二级部门', null, '1', '2', '2', 'ejb');

-- ----------------------------
-- Table structure for `post`
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topicID` int(11) NOT NULL,
  `userID` int(11) NOT NULL DEFAULT '0',
  `content` text NOT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `hasReply` bit(1) NOT NULL DEFAULT b'0',
  `updateTime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('27', '16', '11', '<p>^O^</p>', '2013-05-17 13:04:51', '', null);
INSERT INTO `post` VALUES ('28', '17', '12', '<p>^O^辅导费多发点发大幅度发</p>', '2013-08-25 16:56:12', '', null);

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
-- Table structure for `project`
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `finish` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES ('1', '无', '0');
INSERT INTO `project` VALUES ('2', 'ABAP基础', '0');
INSERT INTO `project` VALUES ('3', '报表程序--选择屏幕', '0');
INSERT INTO `project` VALUES ('4', 'FUNCTION详解', '0');
INSERT INTO `project` VALUES ('5', 'ALV细说', '0');
INSERT INTO `project` VALUES ('6', 'ABAP关于时间', '0');
INSERT INTO `project` VALUES ('7', 'DNPRO细节', '0');
INSERT INTO `project` VALUES ('8', 'ALV控件的使用', '0');
INSERT INTO `project` VALUES ('9', '资料分享', '0');

-- ----------------------------
-- Table structure for `reply`
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topicID` int(11) NOT NULL DEFAULT '1',
  `postID` int(11) NOT NULL,
  `userID` int(11) NOT NULL DEFAULT '0',
  `content` varchar(300) NOT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of reply
-- ----------------------------
INSERT INTO `reply` VALUES ('94', '16', '27', '11', '111', '2013-05-18 11:20:34');
INSERT INTO `reply` VALUES ('95', '17', '28', '12', '啥意思', '2013-08-25 16:56:32');

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色';

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
-- Table structure for `topic`
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL DEFAULT '0',
  `moduleID` int(11) NOT NULL,
  `postCount` int(11) NOT NULL DEFAULT '1',
  `replyCount` int(11) NOT NULL DEFAULT '0',
  `pv` int(11) NOT NULL DEFAULT '0',
  `content` varchar(60) NOT NULL,
  `emotion` tinyint(2) DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isNice` bit(1) NOT NULL DEFAULT b'0',
  `isUp` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES ('16', '11', '4', '1', '0', '9', 'test', null, '2013-05-17 13:04:51', '', '');
INSERT INTO `topic` VALUES ('17', '12', '4', '1', '0', '1', '不咋地嘛', null, '2013-08-25 16:56:12', '', '');

-- ----------------------------
-- Table structure for `types`
-- ----------------------------
DROP TABLE IF EXISTS `types`;
CREATE TABLE `types` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '类别名称',
  `remark` varchar(250) DEFAULT NULL COMMENT '备注',
  `pid` bigint(10) DEFAULT NULL COMMENT '父级类别id',
  `num` varchar(20) DEFAULT NULL COMMENT '编码',
  `level` tinyint(4) DEFAULT NULL COMMENT '级别',
  `path` varchar(100) DEFAULT NULL COMMENT '全路径',
  `function` varchar(100) DEFAULT NULL COMMENT '功能类别',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定义类别';

-- ----------------------------
-- Records of types
-- ----------------------------
INSERT INTO `types` VALUES ('9', '计量单位', null, '0', 'jldw', '1', '0-9', '计量单位');
INSERT INTO `types` VALUES ('14', '件', null, '9', 'jian', '2', '9-14', '计量单位');
INSERT INTO `types` VALUES ('15', '个', null, '9', 'ge', '2', '9-15', '计量单位');
INSERT INTO `types` VALUES ('16', '品牌', null, '0', 'pp', '1', '0-16', '品牌');
INSERT INTO `types` VALUES ('17', '服装', null, '0', 'fuz', '1', '0-17', null);
INSERT INTO `types` VALUES ('18', '品牌一', null, '16', 'pp1', '2', '16-18', '品牌');
INSERT INTO `types` VALUES ('19', '品牌二', null, '16', 'pp2', '2', '16-19', '品牌');
INSERT INTO `types` VALUES ('20', '运动装', null, '17', 'ydz', '2', '17-20', null);
INSERT INTO `types` VALUES ('21', '儿童运动装', null, '20', 'rtydz', '3', '17-20-21', null);
INSERT INTO `types` VALUES ('22', '斤', null, '9', 'jin', null, null, '计量单位');
INSERT INTO `types` VALUES ('23', '辆', null, '9', 'liang', null, null, '计量单位');
INSERT INTO `types` VALUES ('24', '成人运动装', null, '20', 'cr', null, null, null);
INSERT INTO `types` VALUES ('29', '商品类别', null, '0', 'dl', null, null, '商品类别');
INSERT INTO `types` VALUES ('30', '商品大类一', null, '29', 'dl', null, null, '商品类别');
INSERT INTO `types` VALUES ('31', '商品大类二', null, '29', 'dl2', null, null, '商品类别');
INSERT INTO `types` VALUES ('32', '商品中类一', null, '30', 'zl', null, null, '商品类别');
INSERT INTO `types` VALUES ('33', '商品小类一', null, '32', 'xl', null, null, '商品类别');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(40) NOT NULL,
  `sex` bit(1) NOT NULL DEFAULT b'1',
  `email` varchar(30) DEFAULT NULL,
  `headImg` varchar(120) DEFAULT 'http://static.tieba.baidu.com/tb/editor/images/ali/ali_008.gif',
  `blogUrl` varchar(80) DEFAULT NULL,
  `feeling` varchar(300) DEFAULT NULL,
  `registDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('11', 'admin', 'bfd59291e825b5f2bbf1eb76569f8fe7', '', 'iveryang@sina.cn', 'http://static.tieba.baidu.com/tb/editor/images/ali/ali_008.gif', null, null, '2013-05-17');
INSERT INTO `user` VALUES ('12', 'zzzz', 'c4996e602bf907934ca9d8d61f6429fb', '', 'hczyh_888@163.com', 'http://static.tieba.baidu.com/tb/editor/images/ali/ali_008.gif', null, null, '2013-08-25');

-- ----------------------------
-- Table structure for `userrole`
-- ----------------------------
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole` (
  `userid` bigint(20) NOT NULL,
  `roleid` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户角色';

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
  `tablename` varchar(50) DEFAULT '0' COMMENT '表名',
  `tlevel` smallint(2) DEFAULT '0',
  `ttype` smallint(2) DEFAULT '0' COMMENT '1 JB  2 JH 3 XS 4 CK 5 CW 6 XT 7 其他',
  `remark` char(10) DEFAULT '0',
  `sysdefault` smallint(2) DEFAULT '0',
  `ctablename` varchar(50) DEFAULT '0' COMMENT '表中文名称',
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='系统表信息';

-- ----------------------------
-- Records of xttables
-- ----------------------------
INSERT INTO `xttables` VALUES ('1', 'xttables', '0', '6', '记录系统表信息', '0', '系统表');
INSERT INTO `xttables` VALUES ('2', 'JBStore', '0', '1', '定义仓库', '0', '仓库信息');
INSERT INTO `xttables` VALUES ('11', 'calendar', '0', '0', null, '0', '日程表');
INSERT INTO `xttables` VALUES ('12', 'employee', '0', '1', null, '0', '员工信息表');
INSERT INTO `xttables` VALUES ('13', 'types', '0', '1', null, '0', '定义类别');
INSERT INTO `xttables` VALUES ('14', 'jbgoods', '0', '1', null, '0', '商品资料表');
INSERT INTO `xttables` VALUES ('15', 'menu', '0', '6', null, '0', '系统菜单表');
INSERT INTO `xttables` VALUES ('16', 'organization', '0', '1', '定义组织', '0', '组织表');
INSERT INTO `xttables` VALUES ('17', 'partment', '0', '1', null, '0', '部门');
INSERT INTO `xttables` VALUES ('18', 'role', '0', '6', null, '0', '角色');
INSERT INTO `xttables` VALUES ('19', 'userrole', '0', '6', null, '0', '用户角色');
INSERT INTO `xttables` VALUES ('20', 'powermenu', '0', '6', null, '0', '权限');
