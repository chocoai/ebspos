-- --------------------------------------------------------
-- 主机                            :127.0.0.1
-- 服务器版本                         :5.0.67-community-log - MySQL Community Edition (GPL)
-- 服务器操作系统                       :Win32
-- HeidiSQL 版本                   :7.0.0.4278
-- 创建                            :2013-09-01 18:03:13
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 ebspos.jbsupplier 结构
DROP TABLE IF EXISTS `jbsupplier`;
CREATE TABLE IF NOT EXISTS `jbsupplier` (
  `id` bigint(20) NOT NULL auto_increment,
  `supplierCode` varchar(50) default '0' COMMENT '供应商编码',
  `supplierName` varchar(50) default '0' COMMENT '供应商名称',
  `supplierTypeNo` int(11) default '0' COMMENT '供应商类别',
  `EmployeeNo` int(11) default '0' COMMENT '管辖业务员',
  `Address` varchar(150) default '0' COMMENT '联系地址',
  `SendAddress` varchar(150) default '0' COMMENT '发货地址',
  `PostNo` varchar(50) default '0' COMMENT '邮编',
  `TelePhone` varchar(50) default '0' COMMENT '公司电话',
  `Fax` varchar(50) default '0' COMMENT '传真',
  `Email` varchar(50) default '0' COMMENT '邮箱',
  `LinkMan` varchar(50) default '0' COMMENT '联系人',
  `LinkPhone` varchar(50) default '0' COMMENT '联系人电话',
  `Url` varchar(50) default '0' COMMENT '网址',
  `PDayMax` int(11) default '0' COMMENT '信用天数',
  `PAmountMax` decimal(10,2) default '0.00' COMMENT '信用金额',
  `BankNo` varchar(100) default '0' COMMENT '开户行',
  `BankAccount` varchar(100) default '0' COMMENT '账号',
  `PreAmount` decimal(10,2) default '0.00' COMMENT '期初应付',
  `AdvanceAmount` decimal(10,2) default '0.00' COMMENT '预付款',
  `BuyAmount` decimal(10,2) default '0.00' COMMENT '购买总金额',
  `SplusAmount` decimal(10,2) default '0.00' COMMENT '往来余额',
  `StopFlag` smallint(6) default '0' COMMENT '停止业务标志',
  `remark` varchar(150) default '0' COMMENT '备注',
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='供应商资料';

-- 正在导出表  ebspos.jbsupplier 的数据: ~1 rows ((大约))
DELETE FROM `jbsupplier`;
/*!40000 ALTER TABLE `jbsupplier` DISABLE KEYS */;
INSERT INTO `jbsupplier` (`id`, `supplierCode`, `supplierName`, `supplierTypeNo`, `EmployeeNo`, `Address`, `SendAddress`, `PostNo`, `TelePhone`, `Fax`, `Email`, `LinkMan`, `LinkPhone`, `Url`, `PDayMax`, `PAmountMax`, `BankNo`, `BankAccount`, `PreAmount`, `AdvanceAmount`, `BuyAmount`, `SplusAmount`, `StopFlag`, `remark`) VALUES
	(1, '112', '2222', 0, 22, '2', '2', '2', '2', NULL, NULL, '2', '2', '2', 2, 22.00, '22', '222', 2.00, 0.00, 0.00, 0.00, NULL, '2');
/*!40000 ALTER TABLE `jbsupplier` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
