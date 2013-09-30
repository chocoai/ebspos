/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-09-30 11:16:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `cgorderdetail`
-- ----------------------------
DROP TABLE IF EXISTS `cgorderdetail`;
CREATE TABLE `cgorderdetail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `orderCode` varchar(20) NOT NULL DEFAULT '0' COMMENT '订单号',
  `SerialNo` int(11) NOT NULL DEFAULT '1' COMMENT '序号',
  `GoodsCode` varchar(20) DEFAULT NULL COMMENT '商品编号',
  `OrigPrice` decimal(10,2) DEFAULT NULL COMMENT '原订价',
  `Price` decimal(10,2) DEFAULT NULL COMMENT '确认价',
  `Quantity` decimal(10,2) DEFAULT NULL COMMENT '数量',
  `Discount` decimal(10,2) DEFAULT NULL COMMENT '折扣',
  `InStoreQty` decimal(10,2) DEFAULT NULL COMMENT '已入库数',
  `ReturnQty` decimal(10,2) DEFAULT NULL COMMENT '退回数',
  `BuyAmount` decimal(10,2) DEFAULT NULL COMMENT '货款',
  `TaxRate` decimal(10,2) DEFAULT NULL COMMENT '税率',
  `TaxAmount` decimal(10,2) DEFAULT NULL COMMENT '税额',
  `Amount` decimal(10,2) DEFAULT NULL COMMENT '价税合计',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`,`orderCode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='采购订单明细';

-- ----------------------------
-- Records of cgorderdetail
-- ----------------------------
INSERT INTO `cgorderdetail` VALUES ('2', 'CGDD-20130918-001', '1', '1111', '0.11', null, '1.00', '1.00', null, null, null, '10.00', '0.01', '0.12', null);
INSERT INTO `cgorderdetail` VALUES ('3', 'CGDD-20130918-001', '1', '1111', '11.00', null, '1.00', '100.00', null, null, null, '17.00', '1.87', '12.87', null);
INSERT INTO `cgorderdetail` VALUES ('4', 'CGDD-20130926-001', '1', '1111', '11.00', null, '1.00', '100.00', null, null, null, '17.00', '1.87', '12.87', null);
