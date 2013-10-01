/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-09-30 11:16:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cgorder`
-- ----------------------------
DROP TABLE IF EXISTS `cgorder`;
CREATE TABLE `cgorder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `orderCode` varchar(20) NOT NULL DEFAULT '0' COMMENT '订单编号',
  `orderDate` date DEFAULT NULL COMMENT '订单日期',
  `Operator` varchar(50) DEFAULT '0' COMMENT '制单人',
  `supplierCode` varchar(11) DEFAULT '0' COMMENT '供应商编号',
  `StoreCode` int(11) DEFAULT '0' COMMENT '仓库编号',
  `partmentNo` int(11) DEFAULT '0' COMMENT '部门编号',
  `EmployeeNo` varchar(20) DEFAULT '0' COMMENT '业务员编号',
  `DeliveryDate` date DEFAULT NULL COMMENT '收货日期',
  `FinishFlag` smallint(6) DEFAULT '0' COMMENT '订单完成标志',
  `CheckFlag` smallint(6) DEFAULT '0' COMMENT '审核状态',
  `CheckMan` varchar(50) DEFAULT NULL COMMENT '审核人',
  `CheckDate` date DEFAULT NULL COMMENT '审核日期',
  `StopFlag` smallint(6) DEFAULT '0' COMMENT '停用标志',
  `StopMan` varchar(50) DEFAULT '0' COMMENT '终止人',
  `StopDate` date DEFAULT NULL COMMENT '终止日期',
  `PreAmount` decimal(10,2) DEFAULT '0.00' COMMENT '预付金额',
  `SettleTypeFlag` smallint(6) DEFAULT '0' COMMENT '0：什么都不选。1：预付 2：清货 3：货款结清',
  `remark` varchar(100) DEFAULT '0' COMMENT '备注',
  PRIMARY KEY (`id`,`orderCode`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='采购订单';

-- ----------------------------
-- Records of cgorder
-- ----------------------------
INSERT INTO `cgorder` VALUES ('13', 'CGDD-20130918-001', '2013-09-19', 'dadf', '112', '1', '1', 'wcc', '2013-09-21', '0', '1', 'dadf', '2013-09-24', '0', '0', null, '0.00', '2', '3241234');
INSERT INTO `cgorder` VALUES ('14', 'CGDD-20130926-001', '2013-09-10', '系统管理员', '112', '239', '3', 'wcc', '2013-09-13', '0', '1', null, '2013-09-26', '0', '0', null, '0.00', '2', null);
