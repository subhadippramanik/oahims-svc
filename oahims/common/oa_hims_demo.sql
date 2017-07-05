/*
SQLyog Community v12.2.5 (32 bit)
MySQL - 5.0.45-community-nt : Database - oa_hims_demo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`oa_hims_demo` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `oa_hims_demo`;

/*Table structure for table `doctor_leave` */

DROP TABLE IF EXISTS `doctor_leave`;

CREATE TABLE `doctor_leave` (
  `objid` bigint(20) NOT NULL auto_increment,
  `doctorobjid` bigint(20) default NULL,
  `leavefrom` datetime default NULL,
  `leaveto` datetime default NULL,
  `isactive` char(1) default NULL,
  `byuser` varchar(12) default NULL,
  `createddate` datetime default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `doctor_leave` */

/*Table structure for table `doctor_schedule` */

DROP TABLE IF EXISTS `doctor_schedule`;

CREATE TABLE `doctor_schedule` (
  `objid` bigint(20) NOT NULL auto_increment,
  `doctorobjid` bigint(20) default NULL,
  `dscheduleorleavedate` date default NULL,
  `dscheduletimefrom` time default NULL,
  `dscheduletimeto` time default NULL,
  `scheduleorleave` char(1) default 'S',
  `attendedyn` char(1) default 'N',
  `isactive` char(1) default NULL,
  `byuser` varchar(12) default NULL,
  `createddate` datetime default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `doctor_schedule` */

insert  into `doctor_schedule`(`objid`,`doctorobjid`,`dscheduleorleavedate`,`dscheduletimefrom`,`dscheduletimeto`,`scheduleorleave`,`attendedyn`,`isactive`,`byuser`,`createddate`) values 
(1,1,'2008-12-04','12:30:00','14:30:00','S','N',NULL,NULL,NULL),
(2,1,'2013-07-18','02:00:00','03:00:00','S','N',NULL,'admin',NULL);

/*Table structure for table `emp_relationship` */

DROP TABLE IF EXISTS `emp_relationship`;

CREATE TABLE `emp_relationship` (
  `objid` bigint(20) NOT NULL auto_increment,
  `empobjid` bigint(20) default NULL,
  `emprelationship` varchar(12) default NULL,
  `emprelname` varchar(52) default NULL,
  `empreldob` date default NULL,
  `emprelsex` char(1) default NULL,
  `isactive` char(1) default NULL,
  `emprelphoto` varchar(32) default NULL,
  `byuser` varchar(12) default NULL,
  `createddate` datetime default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

/*Data for the table `emp_relationship` */

insert  into `emp_relationship`(`objid`,`empobjid`,`emprelationship`,`emprelname`,`empreldob`,`emprelsex`,`isactive`,`emprelphoto`,`byuser`,`createddate`) values 
(31,2,'FATHER','PRATAP NARAYAN PAUL','1934-11-19','M','Y','KH1016_1.jpg','admin',NULL),
(37,4,'SPOUSE','HAIMANTI DUTTA','1965-11-22','F','Y','KH1042_1.jpg','admin',NULL),
(38,4,'CHILD','TARUN DUTTA','1998-11-16','M','Y','KH1042_2.jpg','admin',NULL),
(39,1,'MOTHER','RIMA BANERJEE','1950-11-23','F','Y','KH1010_1.jpg','admin',NULL),
(40,1,'FATHER','PRAFULLA BANERJEE','1940-11-23','M','Y','KH1010_2.jpg','admin',NULL),
(41,3,'SPOUSE','KABITA BISWAS','2009-02-14','F','Y','KH1017_2.jpg','admin',NULL),
(42,3,'CHILD','PARTHA BISWAS','2009-02-14','M','Y','KH1017_3.jpg','admin',NULL),
(43,3,'MOTHER','KALPANA BISWAS1','2009-02-14','F','Y','KH1017_1.jpg','admin',NULL);

/*Table structure for table `event_log` */

DROP TABLE IF EXISTS `event_log`;

CREATE TABLE `event_log` (
  `objid` bigint(20) NOT NULL auto_increment,
  `crDateTime` datetime default NULL,
  `EventName` varchar(100) default NULL,
  `EventValue` text,
  `Description` text,
  `byUser` varchar(32) default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `event_log` */

/*Table structure for table `mbillformatmaster` */

DROP TABLE IF EXISTS `mbillformatmaster`;

CREATE TABLE `mbillformatmaster` (
  `objid` bigint(11) NOT NULL auto_increment,
  `BillFormatName` varchar(20) default NULL,
  `StartingFrom` int(11) default NULL,
  `BillPrefix` varchar(20) default NULL,
  `IsActive` varchar(1) default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `mbillformatmaster` */

insert  into `mbillformatmaster`(`objid`,`BillFormatName`,`StartingFrom`,`BillPrefix`,`IsActive`) values 
(1,'RECEIVE_PAYMENT',1,'RCV/','Y'),
(2,'LAB_BILL',1,'BILL/','Y'),
(3,'PATIENT_ID',1,'PAT/','Y'),
(4,'JOURNAL',1,'JOR/','Y'),
(5,'RECEIPT',1,'RET/','Y'),
(6,'MAKE_PAYMENT',1,'PMT/','Y'),
(7,'PERSON_CODE',1,'PCD/','Y'),
(8,'TEST_CODE',1,'TC/','Y'),
(9,'PATIENT_REG',1,'OPAT/','Y'),
(10,'OPD_REG',2,'OPD/','Y'),
(11,'IPD_REG',1,'IPD/','Y');

/*Table structure for table `mst_doctor` */

DROP TABLE IF EXISTS `mst_doctor`;

CREATE TABLE `mst_doctor` (
  `objid` bigint(20) NOT NULL auto_increment,
  `dcode` varchar(12) default NULL,
  `dtitle` varchar(4) default NULL,
  `dnamef` varchar(16) default NULL,
  `dnamel` varchar(10) default NULL,
  `dnamem` varchar(16) default NULL,
  `quali_splist` varchar(120) default NULL,
  `contactno` varchar(32) default NULL,
  `dadd` varchar(120) default NULL,
  `dpin` varchar(12) default NULL,
  `isactive` char(1) default NULL,
  `byuser` varchar(12) default NULL,
  `updateddate` datetime default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `mst_doctor` */

insert  into `mst_doctor`(`objid`,`dcode`,`dtitle`,`dnamef`,`dnamel`,`dnamem`,`quali_splist`,`contactno`,`dadd`,`dpin`,`isactive`,`byuser`,`updateddate`) values 
(1,'1234',NULL,'ARBIND','DAS','',NULL,'423423432','dum dum',NULL,'Y','admin','2008-11-21 00:00:00'),
(2,'890',NULL,'SWAPAN','NIYOGI','',NULL,'65789041','Salt Lake',NULL,'Y','admin','2008-11-20 00:00:00'),
(3,'123456789',NULL,'SANTANU','DAS','',NULL,'7890567899','ukilpara',NULL,'Y','admin',NULL);

/*Table structure for table `mst_emp` */

DROP TABLE IF EXISTS `mst_emp`;

CREATE TABLE `mst_emp` (
  `objid` bigint(20) NOT NULL auto_increment,
  `empcode` varchar(12) default NULL,
  `emptitle` varchar(8) default NULL,
  `empnamef` varchar(16) default NULL,
  `empnamem` varchar(16) default NULL,
  `empnamel` varchar(16) default NULL,
  `empsex` varchar(1) default NULL,
  `empdob` date default NULL,
  `contactno` varchar(32) default NULL,
  `empadd` varchar(32) default NULL,
  `empdoj` date default NULL,
  `isactive` char(1) default NULL,
  `empphoto` varchar(32) default NULL,
  `byuser` varchar(12) default NULL,
  `createddate` datetime default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `mst_emp` */

insert  into `mst_emp`(`objid`,`empcode`,`emptitle`,`empnamef`,`empnamem`,`empnamel`,`empsex`,`empdob`,`contactno`,`empadd`,`empdoj`,`isactive`,`empphoto`,`byuser`,`createddate`) values 
(1,'KH1010','Miss.','SUMANA','','BANERJEE','F','1988-11-15','43432424','dum dum','2008-11-23','Y','KH1010_0.jpg','admin',NULL),
(2,'KH1016','Mrs.','MANASI','','PAUL','M','1970-11-23','3242424','','1995-11-06','Y','KH1016_0.jpg','admin',NULL),
(3,'KH1017','Mr.','NARAYAN','','BISWAS','M','2008-11-23','9830012345','KHIDIPUR','2008-11-23','Y','KH1017_0.jpg','admin',NULL),
(4,'KH1042','Mr.','HIMANGSHU','','DUTTA','M','2008-11-23','6456466464','','2008-11-23','Y','KH1042_0.jpg','admin',NULL);

/*Table structure for table `mst_ipd_patient` */

DROP TABLE IF EXISTS `mst_ipd_patient`;

CREATE TABLE `mst_ipd_patient` (
  `objid` bigint(20) NOT NULL auto_increment,
  `mrno` varchar(32) default NULL,
  `indate` datetime default NULL,
  `visitno` varchar(32) default NULL,
  `empobjid` bigint(20) default NULL,
  `oldnew` varchar(1) default 'N',
  `patientname` varchar(120) default NULL,
  `fmsh_guardians` varchar(120) default NULL,
  `patientphoto` varchar(100) default NULL,
  `patageyrs` double default NULL,
  `patagemts` double default NULL,
  `patagedays` double default NULL,
  `patsex` varchar(1) default NULL,
  `patmarriedyn` varchar(1) default 'N',
  `birthplace` varchar(100) default NULL,
  `proffession` varchar(100) default NULL,
  `medicalpolyn` varchar(1) default 'N',
  `height` varchar(12) default NULL,
  `bloodgroup` varchar(12) default NULL,
  `allergies` varchar(220) default NULL,
  `isactive` varchar(1) default NULL,
  `byuser` varchar(12) default NULL,
  `createddate` date default NULL,
  `updateddatetime` datetime default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `mst_ipd_patient` */

/*Table structure for table `mst_ipd_patient_address` */

DROP TABLE IF EXISTS `mst_ipd_patient_address`;

CREATE TABLE `mst_ipd_patient_address` (
  `objid` bigint(20) NOT NULL auto_increment,
  `ipd_objid` bigint(20) default NULL,
  `addressdetails` varchar(200) default NULL,
  `patstate` varchar(32) default NULL,
  `patdistrict` varchar(32) default NULL,
  `patps` varchar(32) default NULL,
  `pin` varchar(12) default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `mst_ipd_patient_address` */

/*Table structure for table `mst_ipd_patient_checkin` */

DROP TABLE IF EXISTS `mst_ipd_patient_checkin`;

CREATE TABLE `mst_ipd_patient_checkin` (
  `objid` bigint(20) default NULL,
  `ipd_objid` bigint(20) default NULL,
  `mrno` varchar(32) default NULL,
  `visitno` varchar(32) default NULL,
  `admit_trans_refer_relaese` varchar(1) default 'A',
  `asondt` datetime default NULL,
  `bed_objid` bigint(20) default NULL,
  `bed_no` double default NULL,
  `charges` double default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `mst_ipd_patient_checkin` */

/*Table structure for table `mst_ipd_patient_contacts` */

DROP TABLE IF EXISTS `mst_ipd_patient_contacts`;

CREATE TABLE `mst_ipd_patient_contacts` (
  `objid` bigint(20) NOT NULL auto_increment,
  `ipd_objid` bigint(20) default NULL,
  `con_name` varchar(120) default NULL,
  `con_prof` varchar(100) default NULL,
  `con_address` varchar(200) default NULL,
  `con_state` varchar(32) default NULL,
  `con_dist` varchar(32) default NULL,
  `con_ps` varchar(32) default NULL,
  `con_pin` varchar(12) default NULL,
  `con_mob_no` varchar(45) default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `mst_ipd_patient_contacts` */

/*Table structure for table `mst_ipd_patient_diagnosis` */

DROP TABLE IF EXISTS `mst_ipd_patient_diagnosis`;

CREATE TABLE `mst_ipd_patient_diagnosis` (
  `objid` bigint(20) NOT NULL auto_increment,
  `ipd_objid` bigint(20) default NULL,
  `icd_code` varchar(12) default NULL,
  `diagnosis` varchar(240) default NULL,
  `pri_pro` varchar(1) default 'P',
  `asondt` datetime default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `mst_ipd_patient_diagnosis` */

/*Table structure for table `mst_ipd_patient_doctors` */

DROP TABLE IF EXISTS `mst_ipd_patient_doctors`;

CREATE TABLE `mst_ipd_patient_doctors` (
  `objid` bigint(20) NOT NULL auto_increment,
  `ipd_objid` bigint(20) default NULL,
  `doc_objid` bigint(20) default NULL,
  `doc_name` varchar(60) default NULL,
  `doc_address` varchar(120) default NULL,
  `doc_pin` varchar(12) default NULL,
  `doc_mob` varchar(45) default NULL,
  `doc_visit_date` date default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `mst_ipd_patient_doctors` */

/*Table structure for table `mst_ipd_patient_medical` */

DROP TABLE IF EXISTS `mst_ipd_patient_medical`;

CREATE TABLE `mst_ipd_patient_medical` (
  `objid` bigint(20) NOT NULL auto_increment,
  `ipd_objid` bigint(20) default NULL,
  `weight` double default NULL,
  `weight_dt` datetime default NULL,
  `bp` varchar(12) default NULL,
  `bp_dt` datetime default NULL,
  `pulse` double default NULL,
  `pulse_dt` datetime default NULL,
  `glucose` double default NULL,
  `glucose_dt` datetime default NULL,
  `temparature` double default NULL,
  `temp_dt` datetime default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `mst_ipd_patient_medical` */

/*Table structure for table `mst_ipd_patient_policies` */

DROP TABLE IF EXISTS `mst_ipd_patient_policies`;

CREATE TABLE `mst_ipd_patient_policies` (
  `objid` bigint(20) NOT NULL auto_increment,
  `ipd_objid` bigint(20) default NULL,
  `poli_objid` bigint(20) default NULL,
  `policy_holder` varchar(120) default NULL,
  `relation_patient` varchar(32) default NULL,
  `valid_till_dt` datetime default NULL,
  `tpa_code` varchar(22) default NULL,
  `tpa_name` varchar(120) default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `mst_ipd_patient_policies` */

/*Table structure for table `mst_opd_registration` */

DROP TABLE IF EXISTS `mst_opd_registration`;

CREATE TABLE `mst_opd_registration` (
  `objid` bigint(20) NOT NULL auto_increment,
  `regnno` varchar(12) default NULL,
  `billamnt` double default NULL,
  `stafffree` char(1) default NULL,
  `empobjid` bigint(20) default '0',
  `oldnew` char(1) default NULL,
  `patientname` varchar(32) default NULL,
  `patientphoto` varchar(32) default NULL,
  `patstate` varchar(16) default NULL,
  `patdistrict` varchar(16) default NULL,
  `patps` varchar(16) default NULL,
  `patageyrs` int(11) default '0',
  `patagemts` int(11) default '0',
  `patageday` int(11) default '0',
  `patsex` char(1) default NULL,
  `doctorobjid` bigint(20) default NULL,
  `printstatus` char(1) default 'N',
  `isactive` char(1) default NULL,
  `byuser` varchar(12) default NULL,
  `createddate` date default NULL,
  `updateddatetime` datetime default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

/*Data for the table `mst_opd_registration` */

insert  into `mst_opd_registration`(`objid`,`regnno`,`billamnt`,`stafffree`,`empobjid`,`oldnew`,`patientname`,`patientphoto`,`patstate`,`patdistrict`,`patps`,`patageyrs`,`patagemts`,`patageday`,`patsex`,`doctorobjid`,`printstatus`,`isactive`,`byuser`,`createddate`,`updateddatetime`) values 
(1,'6',0,'S',1,'N','PARAG DAS',NULL,'','','',1,9,1,'M',1,'Y','Y','admin','2008-11-22',NULL),
(2,'8',40,'',0,'N','PRANAB DAS',NULL,'WB','NADIA','CHAKDAH',12,0,0,'M',2,'N','Y','user','2008-11-22',NULL),
(3,'10',0,'F',0,'N','PRATIMA DUTTA',NULL,'','','',0,23,0,'F',1,'N','Y','admin','2008-11-22',NULL),
(5,'14',0,'F',0,'N','PRANAB CHOWDHURY',NULL,'','','',23,0,0,'M',1,'N','Y','user','2008-11-22',NULL),
(6,'15',40,'',0,'N','SUBRATA DAS',NULL,'','','',12,0,0,'F',1,'N','Y','user','2008-11-22',NULL),
(7,'16',40,'',0,'N','P RUDRA',NULL,'','','',34,8,0,'M',1,'N','Y','user','2008-11-22',NULL),
(8,'17',0,'S',2,'N','PRATAP NARAYAN PAUL','KH1016_1.jpg','','','',74,0,9,'M',1,'N','Y','user','2008-11-28',NULL),
(9,'18',0,'F',0,'N','SANTANU DHAR',NULL,'WB','BELGHARIA','',23,0,0,'M',1,'N','Y','user','2008-11-22',NULL),
(10,'21',40,'',0,'N','TAPASI MALLICK',NULL,'','','',0,0,12,'M',2,'Y','Y','user','2008-11-23',NULL),
(11,'23',0,'S',1,'N','SUMANA BANERJEE','KH1010_0.jpg','','','',20,0,8,'F',1,'N','Y','admin','2008-11-23',NULL),
(12,'24',0,'S',2,'N','MANASI PAUL','KH1016_0.jpg','','','',38,0,0,'M',1,'Y','Y','admin','2008-11-23',NULL),
(13,'25',0,'S',1,'N','SUMANA BANERJEE','KH1010_0.jpg','','','',20,0,10,'F',1,'N','Y','admin','2008-12-04',NULL),
(14,'26',40,'',0,'N','P DAS','','','','',12,0,0,'M',2,'N','Y','user','2008-11-25',NULL),
(15,'27',0,'S',1,'N','PRAFULLA BANERJEE','KH1010_2.jpg','','','',68,2,19,'M',1,'N','Y','admin',NULL,NULL),
(16,'28',40,'',0,'N','TEST PATIENT','','WB','UD','RGJ',34,0,0,'M',3,'N','Y','admin',NULL,NULL),
(17,'29',40,'',0,'N','SANTA','','WB','','',45,0,0,'F',1,'N','Y','admin',NULL,NULL),
(18,'30',0,'S',1,'N','PRAFULLA BANERJEE','KH1010_2.jpg','WB','','',75,4,18,'M',3,'N','Y','admin',NULL,NULL),
(19,'31',40,'B',1,'N','PRAFULLA BANERJEE','','WB','VMVMV','NVBMVM',23,0,0,'M',1,'N','Y','admin',NULL,NULL),
(20,'34',0,'S',1,'N','SUMANA BANERJEE','KH1010_0.jpg','WB','','',27,4,27,'F',3,'N','Y','admin','2016-04-11','2016-04-11 21:18:52'),
(21,'37',0,'F',0,'N','TEST','','WB','','',12,0,0,'M',1,'N','Y','admin','2016-06-22','2016-06-22 20:22:35'),
(22,'39',0,'F',0,'N','T K BISWAS','','WB','HOOGLY','CHINSURA',45,2,0,'M',1,'N','Y','admin','2016-06-27','2016-06-27 14:04:49'),
(23,'42',40,'B',0,'N','SAIFUL DAUD','','WB','UD','UD',45,4,0,'M',3,'N','Y','admin','2016-08-16','2016-08-16 07:54:21'),
(24,'61',40,'B',0,'N','BADAL GHOSH','','','','',34,0,0,'M',3,'Y','Y','admin','2016-08-16','2016-08-16 08:04:48'),
(26,'63',40,'B',0,'N','TEST PATIENT 5555','','','','',12,0,0,'F',1,'Y','Y','admin','2016-08-16','2016-08-16 09:07:33'),
(27,'',0,'F',0,'N','TEST PATIENT','','WBN','SSS','BWN',12,0,0,'M',1,'N','Y','admin','2017-03-01','2017-03-01 22:11:00'),
(28,'',0,'F',0,'N','SDFSDFSDF','','FDSF','FDSF','DSFSD',22,0,0,'M',3,'N','Y','admin','2017-03-01','2017-03-01 22:55:38'),
(29,'',0,'F',0,'N','DASDSAD','','ASDASD','DSADA','DASDAS',22,0,0,'F',3,'N','Y','admin','2017-03-01','2017-03-01 23:37:16'),
(30,'',0,'F',0,'N','ADAS','','WB','KOL','BEL',11,0,0,'F',3,'N','Y','admin','2017-03-01','2017-03-01 23:40:02'),
(31,'OPD/1',0,'F',0,'N','DAS DA','','WB','DEL','WW',23,0,0,'M',2,'N','Y','admin','2017-03-01','2017-03-01 23:44:02');

/*Table structure for table `pat_opd_visit` */

DROP TABLE IF EXISTS `pat_opd_visit`;

CREATE TABLE `pat_opd_visit` (
  `objid` bigint(20) default NULL,
  `patobjid` bigint(20) default NULL,
  `visitno` varchar(12) default NULL,
  `visitdate` datetime default NULL,
  `doctorobjid` bigint(20) default NULL,
  `visitfees` float default NULL,
  `isactive` char(1) default NULL,
  `byuser` varchar(12) default NULL,
  `createddate` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `pat_opd_visit` */

/*Table structure for table `seq_no` */

DROP TABLE IF EXISTS `seq_no`;

CREATE TABLE `seq_no` (
  `seqno` bigint(20) unsigned NOT NULL auto_increment,
  `id` bigint(20) default NULL,
  PRIMARY KEY  (`seqno`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

/*Data for the table `seq_no` */

insert  into `seq_no`(`seqno`,`id`) values 
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),
(17,1),
(18,1),
(19,1),
(20,1),
(21,1),
(22,1),
(23,1),
(24,1),
(25,1),
(26,1),
(27,1),
(28,1),
(29,1),
(30,1),
(31,1),
(32,1),
(33,1),
(34,1),
(35,1),
(36,1),
(37,1),
(38,1),
(39,1),
(40,1),
(41,1),
(42,1),
(43,1),
(44,1),
(45,1),
(46,1),
(47,1),
(48,1),
(49,1),
(50,1),
(51,1),
(52,1),
(53,1),
(54,1),
(55,1),
(56,1),
(57,1),
(58,1),
(59,1),
(60,1),
(61,1),
(62,1),
(63,1);

/*Table structure for table `user_mst` */

DROP TABLE IF EXISTS `user_mst`;

CREATE TABLE `user_mst` (
  `objid` bigint(10) NOT NULL auto_increment,
  `login` varchar(256) default NULL,
  `pswd` varchar(256) default NULL,
  `access_type` int(11) default NULL,
  PRIMARY KEY  (`objid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `user_mst` */

insert  into `user_mst`(`objid`,`login`,`pswd`,`access_type`) values 
(1,'admin','admin',1),
(4,'user','user',2),
(5,'sumi','sumi',2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
