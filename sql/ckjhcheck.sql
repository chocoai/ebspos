/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-09-30 11:16:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ckjhcheck`
-- ----------------------------
DROP TABLE IF EXISTS `ckjhcheck`;
CREATE TABLE `ckjhcheck` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(20) NOT NULL DEFAULT '0' COMMENT '进货单编号',
  `OrderDate` date DEFAULT NULL COMMENT '进货日期',
  `JHPayOrderNo` varchar(20) DEFAULT NULL,
  `SupplierNo` varchar(11) DEFAULT NULL COMMENT '供应商id',
  `StoreNo` int(11) DEFAULT NULL COMMENT '仓库id',
  `InOutTypeNo` varchar(20) DEFAULT NULL COMMENT '入库/退货类型',
  `BillOrderNo` varchar(20) DEFAULT NULL COMMENT '采购单号',
  `RelatedBillNo` varchar(20) DEFAULT NULL,
  `DepartmentNo` int(11) DEFAULT NULL COMMENT '部门id',
  `EmployeeNo` varchar(20) DEFAULT NULL COMMENT '经办人id',
  `Operator` varchar(50) DEFAULT NULL COMMENT '制单人',
  `PayAmount` decimal(10,2) DEFAULT NULL COMMENT '已付金额',
  `AdjustAmount` decimal(10,2) DEFAULT NULL,
  `CKAmount` decimal(10,2) DEFAULT NULL COMMENT '入库金额',
  `Amount` decimal(10,2) DEFAULT NULL COMMENT '购货金额',
  `PatchAmount` decimal(10,2) DEFAULT NULL,
  `CheckFlag` smallint(6) DEFAULT NULL COMMENT '审核标志',
  `CheckDate` datetime DEFAULT NULL COMMENT '审核日期',
  `CheckMan` varchar(50) DEFAULT NULL COMMENT '审核人',
  `RePayType` varchar(20) DEFAULT NULL,
  `CollateType` smallint(6) DEFAULT NULL,
  `RecordCount` int(11) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `RedFlag` smallint(6) DEFAULT NULL,
  `RedDate` datetime DEFAULT NULL,
  `RedMan` varchar(50) DEFAULT NULL,
  `SettleTypeFlag` smallint(6) DEFAULT '0' COMMENT '是否当面付，0：不付，1：付',
  `HasRed` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`,`OrderNo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='采购入库表';

-- ----------------------------
-- Records of ckjhcheck
-- ----------------------------
INSERT INTO `ckjhcheck` VALUES ('6', 'PK-20130926-001', null, null, '112', '1', '42', null, null, '1', 'zyh', '系统管理员', null, null, null, null, null, '1', '2013-09-26 17:08:30', '系统管理员', null, null, null, null, null, null, null, '0', null);
INSERT INTO `ckjhcheck` VALUES ('7', 'PK-20130926-002', '2013-09-17', null, '112', '239', '42', null, null, '1', 'admin', '系统管理员', null, null, null, null, null, '1', '2013-09-26 17:09:07', '系统管理员', null, null, null, null, null, null, null, '0', null);
INSERT INTO `ckjhcheck` VALUES ('8', 'PK-20130926-003', '2013-10-08', null, '112', '1', '42', null, null, '1', 'admin', '系统管理员', null, null, null, null, null, '1', '2013-09-26 17:10:34', '系统管理员', null, null, null, null, null, null, null, '0', null);
INSERT INTO `ckjhcheck` VALUES ('9', 'PK-20130926-004', '2013-09-25', null, '112', '239', '42', null, null, '2', 'wcc', '系统管理员', null, null, null, null, null, '1', '2013-09-26 17:13:11', '系统管理员', null, null, null, null, null, null, null, '0', null);
INSERT INTO `ckjhcheck` VALUES ('10', 'PK-20130926-005', '2013-09-26', null, '112', '1', '42', null, null, '1', 'admin', '系统管理员', null, null, null, null, null, '1', '2013-09-26 17:17:08', '系统管理员', null, null, null, null, null, null, null, '0', null);
INSERT INTO `ckjhcheck` VALUES ('11', 'PK-20130926-006', null, null, '112', '1', '42', null, null, '2', 'wcc', '系统管理员', null, null, null, null, null, '1', '2013-09-26 17:26:12', '系统管理员', null, null, null, null, null, null, null, '0', null);
INSERT INTO `ckjhcheck` VALUES ('13', 'PK-20130926-007', null, null, '112', '1', '42', null, null, '3', 'zyh', '系统管理员', null, null, null, null, null, '1', '2013-09-26 17:27:40', '系统管理员', null, null, null, null, null, null, null, '0', null);
INSERT INTO `ckjhcheck` VALUES ('14', 'PK-20130926-008', null, null, '112', '1', '42', null, null, '1', 'admin', '系统管理员', null, null, null, null, null, '1', '2013-09-26 17:28:11', '系统管理员', null, null, null, null, null, null, null, '0', null);
INSERT INTO `ckjhcheck` VALUES ('20', 'PK-20130930-001', '2013-09-13', null, '112', '239', '1', 'CGDD-20130926-001', null, '3', 'wcc', '系统管理员', null, null, '12.87', '12.87', null, null, null, null, null, null, null, null, null, null, null, '0', null);
