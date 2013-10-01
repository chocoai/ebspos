/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-09-30 11:16:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `jbstore`
-- ----------------------------
DROP TABLE IF EXISTS `jbstore`;
CREATE TABLE `jbstore` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `StoreNo` int(11) NOT NULL COMMENT '仓库id',
  `StoreCode` varchar(20) DEFAULT NULL COMMENT '仓库编号',
  `StoreName` varchar(50) DEFAULT NULL COMMENT '仓库名称',
  `TypeNo` varchar(20) DEFAULT NULL COMMENT '仓库类别',
  `LAndHeight` varchar(50) DEFAULT NULL COMMENT '面积',
  `Place` varchar(50) DEFAULT NULL COMMENT '存放位置',
  `EmployeeNo` varchar(20) DEFAULT NULL COMMENT '仓库保管员',
  `CountQuantity` decimal(18,0) DEFAULT NULL COMMENT '数量',
  `PriceType` varchar(20) DEFAULT NULL COMMENT '计价类型',
  `StopFlag` smallint(6) DEFAULT '0' COMMENT '是否停用',
  `Memo` char(10) DEFAULT NULL COMMENT '备注',
  `RetailSTFlag` smallint(6) DEFAULT NULL,
  `OtherFlag` smallint(6) DEFAULT NULL,
  `MrpFlag` smallint(6) DEFAULT NULL,
  `DownLogNo` int(11) DEFAULT NULL,
  `PriceLevel` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`StoreNo`),
  UNIQUE KEY `StoreCode` (`StoreCode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='仓库信息';

-- ----------------------------
-- Records of jbstore
-- ----------------------------
INSERT INTO `jbstore` VALUES ('3', '1', '1', '男服装', null, '10000', '八百伴', '5', '100', '按件', '1', 'T恤，牛仔裤', null, null, null, null, null);
INSERT INTO `jbstore` VALUES ('4', '2', '239', '材料', null, '1000', '张江', '4', '1888', '批发', null, '布匹', null, null, null, null, null);
