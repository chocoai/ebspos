-- --------------------------------------------------------
-- 主机                            :127.0.0.1
-- 服务器版本                         :5.0.67-community-log - MySQL Community Edition (GPL)
-- 服务器操作系统                       :Win32
-- HeidiSQL 版本                   :7.0.0.4278
-- 创建                            :2013-09-17 16:02:44
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 ebspos.ckcurrstore 结构
DROP TABLE IF EXISTS `ckcurrstore`;
CREATE TABLE IF NOT EXISTS `ckcurrstore` (
  `StoreNo` varchar(20) NOT NULL COMMENT '仓库编号',
  `GoodsNo` varchar(20) NOT NULL COMMENT '商品编号',
  `Quantity` decimal(10,2) default NULL COMMENT '数量',
  `CostPrice` decimal(10,2) default NULL COMMENT '单价',
  `Amount` decimal(10,2) default NULL COMMENT '金额',
  `remark` varchar(50) default NULL COMMENT '备注',
  PRIMARY KEY  (`StoreNo`,`GoodsNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存表';

-- 正在导出表  ebspos.ckcurrstore 的数据: ~0 rows ((大约))
DELETE FROM `ckcurrstore`;
/*!40000 ALTER TABLE `ckcurrstore` DISABLE KEYS */;
/*!40000 ALTER TABLE `ckcurrstore` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
