/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-09-30 11:16:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ckjhcheckdetail`
-- ----------------------------
DROP TABLE IF EXISTS `ckjhcheckdetail`;
CREATE TABLE `ckjhcheckdetail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(20) NOT NULL DEFAULT '0' COMMENT '进货单号',
  `SerialNo` int(11) NOT NULL DEFAULT '1' COMMENT '进货单序号',
  `GoodsNo` varchar(20) DEFAULT NULL COMMENT '商品编号',
  `Quantity` decimal(10,2) DEFAULT NULL COMMENT '数量',
  `OrigPrice` decimal(10,2) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL COMMENT '单价',
  `DisCount` decimal(10,2) DEFAULT NULL,
  `BuyAmount` decimal(10,2) DEFAULT NULL,
  `TaxRate` decimal(10,2) DEFAULT NULL COMMENT '税率',
  `TaxAmount` decimal(10,2) DEFAULT NULL COMMENT '价税合计',
  `Amount` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `CKPrice` decimal(10,2) DEFAULT NULL COMMENT '入库单价',
  `CKAmount` decimal(10,2) DEFAULT NULL COMMENT '入库金额',
  `PatchPrice` decimal(10,2) DEFAULT NULL,
  `PatchAmount` decimal(10,2) DEFAULT NULL,
  `Unit` varchar(20) DEFAULT NULL COMMENT '单位',
  `MixUnit` varchar(20) DEFAULT NULL,
  `UnitRate` varchar(20) DEFAULT NULL,
  `RelatedOrderNo` varchar(20) DEFAULT NULL COMMENT '关联单号',
  `OrderSerialNo` int(11) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `LastPrice` decimal(10,2) DEFAULT NULL COMMENT '最近进价',
  PRIMARY KEY (`id`,`OrderNo`,`SerialNo`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='采购入库明细表';

-- ----------------------------
-- Records of ckjhcheckdetail
-- ----------------------------
INSERT INTO `ckjhcheckdetail` VALUES ('6', 'PK-20130926-001', '1', '1111', '1.00', null, null, '100.00', null, '17.00', '1.87', '11.00', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ckjhcheckdetail` VALUES ('7', 'PK-20130926-002', '1', 'dss', '2.00', null, null, '100.00', null, '17.00', '3.74', '22.00', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ckjhcheckdetail` VALUES ('8', 'PK-20130926-005', '1', '1111', '1.00', null, null, '100.00', null, '17.00', '1.87', '11.00', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ckjhcheckdetail` VALUES ('10', 'PK-20130930-001', '1', '1111', '1.00', '11.00', null, null, null, '17.00', '1.87', null, null, null, null, null, null, null, null, null, null, null, null);
