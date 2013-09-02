-- --------------------------------------------------------
-- 主机                            :127.0.0.1
-- 服务器版本                         :5.0.67-community-log - MySQL Community Edition (GPL)
-- 服务器操作系统                       :Win32
-- HeidiSQL 版本                   :7.0.0.4278
-- 创建                            :2013-09-01 18:03:52
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 ebspos.xttables 结构
DROP TABLE IF EXISTS `xttables`;
CREATE TABLE IF NOT EXISTS `xttables` (
  `id` int(10) NOT NULL auto_increment,
  `tablename` varchar(50) default '0' COMMENT '表名',
  `tlevel` smallint(2) default '0',
  `ttype` smallint(2) default '0' COMMENT '1 JB  2 JH 3 XS 4 CK 5 CW 6 XT 7 其他',
  `remark` char(10) default '0',
  `sysdefault` smallint(2) default '0',
  `ctablename` varchar(50) default '0' COMMENT '表中文名称',
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='系统表信息';

-- 正在导出表  ebspos.xttables 的数据: ~13 rows ((大约))
DELETE FROM `xttables`;
/*!40000 ALTER TABLE `xttables` DISABLE KEYS */;
INSERT INTO `xttables` (`id`, `tablename`, `tlevel`, `ttype`, `remark`, `sysdefault`, `ctablename`) VALUES
	(1, 'xttables', 0, 36, '记录系统表信息', 0, '系统表'),
	(2, 'JBStore', 0, 35, '定义仓库', 0, '仓库信息'),
	(11, 'calendar', 0, 37, NULL, 0, '日程表'),
	(12, 'employee', 0, 35, NULL, 0, '员工信息表'),
	(13, 'types', 0, 36, NULL, 0, '定义类别'),
	(14, 'jbgoods', 0, 35, NULL, 0, '商品资料表'),
	(15, 'menu', 0, 36, NULL, 0, '系统菜单表'),
	(16, 'organization', 0, 35, '定义组织', 0, '组织表'),
	(17, 'partment', 0, 35, NULL, 0, '部门'),
	(18, 'role', 0, 36, NULL, 0, '角色'),
	(19, 'userrole', 0, 36, NULL, 0, '用户角色'),
	(20, 'powermenu', 0, 36, NULL, 0, '权限'),
	(21, 'jbsupplier', 0, 35, NULL, 0, '供应商资料');
/*!40000 ALTER TABLE `xttables` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
