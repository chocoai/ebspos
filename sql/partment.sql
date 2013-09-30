/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50145
Source Host           : localhost:3306
Source Database       : ebspos

Target Server Type    : MYSQL
Target Server Version : 50145
File Encoding         : 65001

Date: 2013-09-30 11:17:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `partment`
-- ----------------------------
DROP TABLE IF EXISTS `partment`;
CREATE TABLE `partment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `num` varchar(20) NOT NULL COMMENT '部门编号',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `picid` bigint(20) DEFAULT NULL,
  `orgid` bigint(20) DEFAULT NULL COMMENT '组织ID',
  `remark` varchar(250) DEFAULT NULL,
  `pid` bigint(10) DEFAULT NULL COMMENT '父级部门id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `num` (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='部门';

-- ----------------------------
-- Records of partment
-- ----------------------------
INSERT INTO `partment` VALUES ('1', '001', '销售部', '4', '2', null, '0');
INSERT INTO `partment` VALUES ('2', '002', '财务部', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('3', '003', '22222', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('4', '004', '33', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('5', '005', '33', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('6', '006', '23', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('7', '007', '21', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('8', '008', '22', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('9', '009', '44', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('10', '010', '21', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('11', '011', '111', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('12', '012', '3343', '1', '2', null, '0');
INSERT INTO `partment` VALUES ('13', 'ejb', '财务二级部门', '1', '2', null, '2');
