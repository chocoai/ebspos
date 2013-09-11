-- --------------------------------------------------------
-- 主机                            :127.0.0.1
-- 服务器版本                         :5.0.67-community-log - MySQL Community Edition (GPL)
-- 服务器操作系统                       :Win32
-- HeidiSQL 版本                   :7.0.0.4278
-- 创建                            :2013-09-11 09:55:22
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 ebspos.jbclient 结构
DROP TABLE IF EXISTS `jbclient`;
CREATE TABLE IF NOT EXISTS `jbclient` (
  `id` bigint(20) NOT NULL auto_increment,
  `ClientCode` varchar(50) default '0' COMMENT '客户代码',
  `ClientName` varchar(50) default '0' COMMENT '客户名称',
  `TypeNo` varchar(10) default '0' COMMENT '客户类型序号',
  `EmployeeNo` varchar(10) default '0' COMMENT '相关业务员序号',
  `ClientLevelNo` varchar(10) default '0' COMMENT '客户级别 如大客户 小客户等',
  `AccounType` smallint(6) default '0',
  `LegMan` varchar(50) default '0' COMMENT '联系人',
  `Address` varchar(100) default '0' COMMENT '地址',
  `SendAddress` varchar(100) default '0' COMMENT '发货地址',
  `PostNo` varchar(20) default '0' COMMENT '邮政编码',
  `TelePhone` varchar(20) default '0' COMMENT '电话',
  `Fax` varchar(20) default '0' COMMENT '传真',
  `LinkMan` varchar(20) default '0' COMMENT '联系人',
  `MobilePhone` varchar(20) default '0' COMMENT '联系人手机',
  `LinkPhone` varchar(20) default '0' COMMENT '联系人电话',
  `Email` varchar(50) default '0' COMMENT '邮箱',
  `Url` varchar(50) default '0' COMMENT '网址',
  `CType` varchar(50) default '0' COMMENT '结账类型',
  `SDayMax` int(11) default '0' COMMENT '信用天数',
  `SAmountMax` decimal(10,2) default '0.00' COMMENT '最大销售金额（信誉额）',
  `BankNo` varchar(100) default '0' COMMENT '开户行',
  `BankAccount` varchar(100) default '0' COMMENT '银行账号',
  `PreAmount` decimal(10,2) default '0.00' COMMENT '期初应收',
  `AdvanceAmount` decimal(10,2) default '0.00' COMMENT '预收款',
  `NeedRecive` decimal(10,2) default '0.00' COMMENT '应收款',
  `SplusAmount` decimal(10,2) default '0.00' COMMENT '往来余额',
  `StopFlag` smallint(6) default '0' COMMENT '停止业务标记',
  `remark` varchar(150) default '0' COMMENT '备注',
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户资料';

-- 正在导出表  ebspos.jbclient 的数据: ~0 rows ((大约))
DELETE FROM `jbclient`;
/*!40000 ALTER TABLE `jbclient` DISABLE KEYS */;
/*!40000 ALTER TABLE `jbclient` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
