-- --------------------------------------------------------
-- 主机                            :127.0.0.1
-- 服务器版本                         :5.0.67-community-log - MySQL Community Edition (GPL)
-- 服务器操作系统                       :Win32
-- HeidiSQL 版本                   :7.0.0.4278
-- 创建                            :2013-08-23 11:03:06
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 ebspos.jbgoods 结构
DROP TABLE IF EXISTS `jbgoods`;
CREATE TABLE IF NOT EXISTS `jbgoods` (
  `id` bigint(20) NOT NULL auto_increment,
  `GoodsCode` varchar(50) default NULL COMMENT '商品编号',
  `GoodsName` varchar(100) default NULL COMMENT '商品名称',
  `GoodsTypeNo` varchar(50) default NULL COMMENT '大类',
  `subgoodstypeno` varchar(50) default NULL COMMENT '中类',
  `smallgoodstypeno` varchar(50) default NULL COMMENT '小类',
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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='商品资料表';

-- 正在导出表  ebspos.jbgoods 的数据: ~1 rows ((大约))
DELETE FROM `jbgoods`;
/*!40000 ALTER TABLE `jbgoods` DISABLE KEYS */;
INSERT INTO `jbgoods` (`id`, `GoodsCode`, `GoodsName`, `GoodsTypeNo`, `subgoodstypeno`, `smallgoodstypeno`, `BrandNo`, `ProduceArea`, `ProduceName`, `Clolor`, `BarCode`, `Model`, `BaseUnit`, `BRefPrice`, `SRefPrice`, `CostPrice`, `Picture`, `StopFlag`, `Remark`, `Season`, `YearBy`) VALUES
	(1, '1111', '123', '3', '31', '311', '1', '1', '1', NULL, '1', '333', '1', 11.00, 11.00, 11.00, NULL, 1, 'wwww', '1', '2011');
/*!40000 ALTER TABLE `jbgoods` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
