-- --------------------------------------------------------
-- 主机                            :127.0.0.1
-- 服务器版本                         :5.0.67-community-log - MySQL Community Edition (GPL)
-- 服务器操作系统                       :Win32
-- HeidiSQL 版本                   :7.0.0.4278
-- 创建                            :2013-11-28 13:19:09
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出  表 ebspos.employee 结构
DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  `id` bigint(20) NOT NULL auto_increment,
  `usr_no` varchar(20) NOT NULL COMMENT '员工编号',
  `usr_name` varchar(50) default NULL COMMENT '姓名',
  `pwd` varchar(50) default NULL COMMENT '密码',
  `deptcode` varchar(20) default NULL COMMENT '部门',
  `age` tinyint(4) default NULL COMMENT '年龄',
  `gender` varchar(20) default NULL COMMENT '籍贯',
  `edu_bg` varchar(50) default NULL COMMENT '学历',
  `birthday` varchar(50) default NULL COMMENT '生日',
  `entry_date` varchar(50) default NULL COMMENT '入职时间',
  `id_card_no` bigint(20) default NULL,
  `fax_no` bigint(20) default NULL COMMENT '传真',
  `phone_no` bigint(20) default NULL COMMENT '电话号码',
  `address` varchar(255) default NULL COMMENT '地址',
  `position` varchar(50) default NULL COMMENT '联系地址',
  `salary` int(11) default NULL COMMENT '工资',
  `email` varchar(255) default NULL COMMENT '邮箱',
  `royalty_rate` decimal(10,0) default NULL,
  `remark` varchar(255) default NULL COMMENT '备注',
  `is_use` tinyint(4) default NULL COMMENT '是否在职',
  `usr_type` tinyint(4) default NULL,
  `upd_time` datetime default NULL,
  `crd_time` datetime default NULL,
  `upd_usr` varchar(255) default NULL,
  `crd_usr` varchar(255) default NULL,
  `del_flg` tinyint(4) default '0' COMMENT '删除标志',
  PRIMARY KEY  (`id`,`usr_no`),
  UNIQUE KEY `usr_no` (`usr_no`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- 正在导出表  ebspos.employee 的数据: ~8 rows ((大约))
DELETE FROM `employee`;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` (`id`, `usr_no`, `usr_name`, `pwd`, `deptcode`, `age`, `gender`, `edu_bg`, `birthday`, `entry_date`, `id_card_no`, `fax_no`, `phone_no`, `address`, `position`, `salary`, `email`, `royalty_rate`, `remark`, `is_use`, `usr_type`, `upd_time`, `crd_time`, `upd_usr`, `crd_usr`, `del_flg`) VALUES
	(1, 'admin', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '001', 1, '男', '本科', '2013-06-28', '2013-06-28', 36010319880999, NULL, 13809876543, 'vasdfasdfadsf', '导购员', 100000, 'xxxx@163.com', 0, '弄阿克苏打发第三方', 1, 1, '2013-08-07 21:06:02', NULL, NULL, NULL, NULL),
	(2, 'pk', '彭科', 'e10adc3949ba59abbe56e057f20f883e', '001', NULL, '男', '高中', '2013-07-24', '2013-07-31', 23412343324, NULL, NULL, NULL, '业务员', NULL, NULL, NULL, NULL, NULL, 1, '2013-07-09 14:44:39', NULL, NULL, NULL, NULL),
	(3, 'wcc', '吴春明', 'e10adc3949ba59abbe56e057f20f883e', '001', 5, '女', '本科', '2013-07-23', '2013-07-26', 188888888, 13241324, 2341234, 'qer123r', '导购员', 10, '2@124.com', 20, '来这个啊京东方卡迪夫', NULL, NULL, '2013-07-18 10:53:54', NULL, NULL, NULL, 0),
	(4, 'zyh', '湛原红', 'e10adc3949ba59abbe56e057f20f883e', '001', 30, '男', '高中', '1980-07-27', '2013-08-01', 1234567890, NULL, 111111, '呃呃呃', '业务员', 5000, 'hczyh_888@163.com', 20, '呃呃呃', NULL, NULL, '2013-08-06 10:37:40', NULL, NULL, NULL, 0),
	(5, 'zs', '张三', 'e10adc3949ba59abbe56e057f20f883e', '001', 11, NULL, '高中', '1971-10-10', '2013-08-06', 11111, NULL, NULL, NULL, '业务员', 1111, NULL, 10, NULL, NULL, NULL, '2013-08-07 21:17:10', NULL, NULL, NULL, 0),
	(13, '123', '123', 'e10adc3949ba59abbe56e057f20f883e', '002', NULL, NULL, '高中', NULL, NULL, 123, NULL, NULL, NULL, '业务员', NULL, NULL, NULL, NULL, NULL, 1, '2013-09-26 16:11:29', NULL, NULL, NULL, 0),
	(16, 'uy', 'ftv', 'e10adc3949ba59abbe56e057f20f883e', '002', NULL, NULL, '高中', NULL, NULL, 78, NULL, NULL, NULL, '业务员', NULL, NULL, NULL, NULL, NULL, 1, '2013-09-26 16:27:21', NULL, NULL, NULL, 0),
	(17, '33333', '3333', 'e10adc3949ba59abbe56e057f20f883e', '001', 33, '男', '高中', NULL, NULL, 3333333, NULL, NULL, NULL, '业务员', NULL, NULL, NULL, NULL, NULL, 1, '2013-11-08 16:50:01', NULL, NULL, NULL, 0);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;


-- 导出  表 ebspos.organization 结构
DROP TABLE IF EXISTS `organization`;
CREATE TABLE IF NOT EXISTS `organization` (
  `id` bigint(20) NOT NULL auto_increment,
  `orgcode` varchar(20) default NULL COMMENT '编号',
  `name` varchar(30) default NULL COMMENT '名称',
  `addr` varchar(50) default NULL COMMENT '地址',
  `picid` bigint(20) default NULL,
  `sortnum` smallint(6) default NULL COMMENT '排序',
  `remark` varchar(100) default NULL COMMENT '备注',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `num` (`orgcode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='组织';

-- 正在导出表  ebspos.organization 的数据: ~1 rows ((大约))
DELETE FROM `organization`;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` (`id`, `orgcode`, `name`, `addr`, `picid`, `sortnum`, `remark`) VALUES
	(2, '001', '昶源软件', '上海市', NULL, NULL, 'fdsafdsfds');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;


-- 导出  表 ebspos.partment 结构
DROP TABLE IF EXISTS `partment`;
CREATE TABLE IF NOT EXISTS `partment` (
  `id` bigint(20) NOT NULL auto_increment,
  `deptCode` varchar(20) NOT NULL COMMENT '部门编号',
  `name` varchar(50) default NULL COMMENT '名称',
  `picid` bigint(20) default NULL,
  `orgid` bigint(20) default NULL COMMENT '组织ID',
  `remark` varchar(250) default NULL,
  `pid` bigint(10) default NULL COMMENT '父级部门id',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `num` (`deptCode`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='部门';

-- 正在导出表  ebspos.partment 的数据: ~13 rows ((大约))
DELETE FROM `partment`;
/*!40000 ALTER TABLE `partment` DISABLE KEYS */;
INSERT INTO `partment` (`id`, `deptCode`, `name`, `picid`, `orgid`, `remark`, `pid`) VALUES
	(1, '001', '销售部', 4, 2, NULL, 0),
	(2, '002', '财务部', 1, 2, NULL, 0),
	(3, '003', '22222', 1, 2, NULL, 0),
	(4, '004', '33', 1, 2, NULL, 0),
	(5, '005', '33', 1, 2, NULL, 0),
	(6, '006', '23', 1, 2, NULL, 0),
	(7, '007', '21', 1, 2, NULL, 0),
	(8, '008', '22', 1, 2, NULL, 0),
	(9, '009', '44', 1, 2, NULL, 0),
	(10, '010', '21', 1, 2, NULL, 0),
	(11, '011', '111', 1, 2, NULL, 0),
	(12, '012', '3343', 1, 2, NULL, 0),
	(13, 'ejb', '财务二级部门', 1, 2, NULL, 2);
/*!40000 ALTER TABLE `partment` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
