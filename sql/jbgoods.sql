/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-09-30 11:16:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `jbgoods`
-- ----------------------------
DROP TABLE IF EXISTS `jbgoods`;
CREATE TABLE `jbgoods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `GoodsCode` varchar(20) DEFAULT NULL COMMENT '商品编号',
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `GoodsCode` (`GoodsCode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商品资料表';

-- ----------------------------
-- Records of jbgoods
-- ----------------------------
INSERT INTO `jbgoods` VALUES ('1', '1111', '123', '30', '32', '33', '19', '1', '1', null, '1', '333', '14', '11.00', '11.00', '11.00', null, '1', 'wwww', '1', '2011');
INSERT INTO `jbgoods` VALUES ('2', 'dss', 'dsa', '30', '32', '33', '18', null, null, null, null, 'dsads', '14', null, null, null, null, null, null, '1', '2011');
