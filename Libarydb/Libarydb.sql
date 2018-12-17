/*
MySQL Data Transfer
Source Host: localhost
Source Database: tushuguanli
Target Host: localhost
Target Database: tushuguanli
Date: 2009-4-19 14:13:27
*/
USE Libarydb;
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for items
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `ISBN` varchar(20) NOT NULL,
  `book_name` varchar(20) NOT NULL,
  `writer` varchar(10) NOT NULL,
  `publish` varchar(30) NOT NULL,
  `publish_time` date NOT NULL,
  `price` float NOT NULL,
  `maxbook` smallint(6) NOT NULL,
  `number` smallint(6) NOT NULL default '0',
  PRIMARY KEY  (`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for loans
-- ----------------------------
DROP TABLE IF EXISTS `loans`;
CREATE TABLE `loans` (
  `manage_id` varchar(10) NOT NULL,
  `Read_id` varchar(10) NOT NULL,
  `lend_time` date NOT NULL,
  `ISBN` varchar(20) NOT NULL,
  `number` smallint(5) NOT NULL,
  `return_time` date NOT NULL,
  PRIMARY KEY  (`manage_id`,`Read_id`,`lend_time`,`ISBN`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `manage_id` varchar(10) NOT NULL,
  `manage_pwd` varchar(10) NOT NULL,
  `manage_name` varchar(10) NOT NULL,
  `manage_position` varchar(15) NOT NULL,
  PRIMARY KEY  (`manage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for manager_do
-- ----------------------------
DROP TABLE IF EXISTS `manager_do`;
CREATE TABLE `manager_do` (
  `manager_id` varchar(10) NOT NULL,
  `time` datetime NOT NULL,
  `things` text NOT NULL,
  PRIMARY KEY  (`manager_id`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader` (
  `Read_id` varchar(10) NOT NULL,
  `Read_pwd` varchar(10) NOT NULL,
  `Read_name` varchar(10) NOT NULL,
  `Read_type` smallint(6) NOT NULL,
  `lend_max` smallint(6) NOT NULL,
  `Number` smallint(6) NOT NULL,
  PRIMARY KEY  (`Read_id`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Table structure for reserve
-- ----------------------------
DROP TABLE IF EXISTS `reserve`;
CREATE TABLE `reserve` (
  `reader_id` varchar(10) NOT NULL,
  `book_name` varchar(20) NOT NULL,
  `time` datetime NOT NULL,
  `manager_id` varchar(10) default NULL,
  `state` smallint(6) NOT NULL,
  PRIMARY KEY  (`reader_id`,`book_name`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=gb2312;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `items` VALUES ('2-1234-4321-22', 'Java编程思想', '袁和平', '人民邮电出版社', '2008-04-05', '56.5', '15', '0');
INSERT INTO `items` VALUES ('3-4567-7654-33', 'C语言基础', '刘海', '清华大学出版社', '2005-06-05', '35', '20', '0');
INSERT INTO `items` VALUES ('4-4567-7654-44', 'C语言编程思想', '周涛', '邮电大学出版社', '2006-05-04', '56.9', '16', '0');
INSERT INTO `items` VALUES ('5-3456-6543-55', 'C++语言', '黎明', '机械工业出版社', '2009-05-04', '99', '12', '0');
INSERT INTO `items` VALUES ('7112-2117-345', '操作系统', '周涛', '人民邮电', '2007-04-05', '45.3', '12', '0');
INSERT INTO `loans` VALUES ('Gl001', 'Xs0601001', '2009-03-04', '1-9876-6789-11', '11', '2009-04-04');
INSERT INTO `loans` VALUES ('Gl001', 'Xs0601001', '2009-03-05', '2-1234-4321-22', '11', '2009-04-05');
INSERT INTO `loans` VALUES ('Gl002', 'Xs0601001', '2009-03-04', '3-4567-7654-33', '11', '2009-04-04');
INSERT INTO `loans` VALUES ('Gl002', 'Xs0601001', '2009-03-04', '4-4567-7654-44', '12', '2009-04-04');
INSERT INTO `loans` VALUES ('Gl002', 'Xs0601001', '2009-03-04', '5-3456-6543-55', '13', '2009-04-04');
INSERT INTO `loans` VALUES ('gl002', 'xs0601001', '2009-04-19', '7112-2117-345', '12', '2009-05-19');
INSERT INTO `manager` VALUES ('Gl001', '1234', '周涛', '超级管理员');
INSERT INTO `manager` VALUES ('gl002', '1234', '李拴鹏', '管理员');
INSERT INTO `manager` VALUES ('gl003', '1234', '自传体', '管理员');
INSERT INTO `manager` VALUES ('gl004', '1234', 'xxx', '管理员');
INSERT INTO `manager_do` VALUES ('gl002', '2009-04-19 00:00:00', '完成图书:4-4567-7654-44-1挂失成功！');
INSERT INTO `manager_do` VALUES ('gl002', '2009-04-19 14:07:24', '管理员查询未归还书本成功！');
INSERT INTO `manager_do` VALUES ('gl002', '2009-04-19 14:07:59', '管理员查询未归还书本成功！');
INSERT INTO `manager_do` VALUES ('gl002', '2009-04-19 14:08:02', '管理员查询未归还书本成功！');
INSERT INTO `reader` VALUES ('Xs0601001', '1234', '周涛', '1', '10', '1');
INSERT INTO `reader` VALUES ('Xs0601002', '1234', '李拴鹏', '1', '10', '0');
INSERT INTO `reader` VALUES ('xs0601003', '1234', '刘宇飞', '1', '10', '0');
INSERT INTO `reserve` VALUES ('xs0601001', '微机原理', '2009-04-18 00:00:00', 'gl002', '1');
