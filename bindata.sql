/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=1*/;
/*!50003 SET @OLD_COMPLETION_TYPE=@@COMPLETION_TYPE,COMPLETION_TYPE=0*/;
DELIMITER /*!*/;
# at 4
#170911 16:37:21 server id 13711  end_log_pos 123 CRC32 0x204e7e9f 	Start: binlog v 4, server v 5.7.16-log created 170911 16:37:21
# Warning: this binlog is either in use or was not closed properly.
# at 123
#170911 16:37:21 server id 13711  end_log_pos 154 CRC32 0x2ef18969 	Previous-GTIDs
# [empty]
# at 154
#170911 16:37:59 server id 13711  end_log_pos 219 CRC32 0xfee48f9f 	Anonymous_GTID	last_committed=0	sequence_number=1
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 219
#170911 16:37:59 server id 13711  end_log_pos 292 CRC32 0xc142d87d 	Query	thread_id=13907	exec_time=1	error_code=0
SET TIMESTAMP=1505119079/*!*/;
SET @@session.pseudo_thread_id=13907/*!*/;
SET @@session.foreign_key_checks=1, @@session.sql_auto_is_null=0, @@session.unique_checks=1, @@session.autocommit=1/*!*/;
SET @@session.sql_mode=1436549152/*!*/;
SET @@session.auto_increment_increment=1, @@session.auto_increment_offset=1/*!*/;
/*!\C utf8 *//*!*/;
SET @@session.character_set_client=33,@@session.collation_connection=33,@@session.collation_server=33/*!*/;
SET @@session.lc_time_names=0/*!*/;
SET @@session.collation_database=DEFAULT/*!*/;
BEGIN
/*!*/;
# at 292
#170911 16:37:59 server id 13711  end_log_pos 349 CRC32 0xc8220d3f 	Rows_query
# delete from slow_log where id = 2
# at 349
#170911 16:37:59 server id 13711  end_log_pos 418 CRC32 0x733ab467 	Table_map: `myapp`.`slow_log` mapped to number 125
# at 418
#170911 16:37:59 server id 13711  end_log_pos 542 CRC32 0xe33f5a38 	Delete_rows: table id 125 flags: STMT_END_F
### DELETE FROM `myapp`.`slow_log`
### WHERE
###   @1=2 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1484875999 /* INT meta=0 nullable=0 is_null=0 */
###   @3=' test_user_db' /* VARSTRING(60) meta=60 nullable=0 is_null=0 */
###   @4='192.168.137.111' /* VARSTRING(45) meta=45 nullable=0 is_null=0 */
###   @5=137691 /* INT meta=0 nullable=0 is_null=0 */
###   @6=1.760822 /* DECIMAL(8,6) meta=2054 nullable=0 is_null=0 */
###   @7=0 /* INT meta=0 nullable=0 is_null=0 */
###   @8=371481 /* INT meta=0 nullable=0 is_null=0 */
###   @9='SELECT * FROM dbname.tbl2;' /* VARSTRING(12000) meta=12000 nullable=0 is_null=0 */
# at 542
#170911 16:37:59 server id 13711  end_log_pos 573 CRC32 0xc3b203b5 	Xid = 178141
COMMIT/*!*/;
# at 992
#170911 16:39:01 server id 13711  end_log_pos 1057 CRC32 0xd171865a 	Anonymous_GTID	last_committed=2	sequence_number=3
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1057
#170911 16:39:01 server id 13711  end_log_pos 1130 CRC32 0x0ac2f1b0 	Query	thread_id=13907	exec_time=0	error_code=0
SET TIMESTAMP=1505119141/*!*/;
BEGIN
/*!*/;
# at 1130
#170911 16:39:01 server id 13711  end_log_pos 1211 CRC32 0xd3d717bc 	Rows_query
# update slow_log set app_ip='192.168.137.100' where id = 3
# at 1211
#170911 16:39:01 server id 13711  end_log_pos 1280 CRC32 0xc77e77e2 	Table_map: `myapp`.`slow_log` mapped to number 125
# at 1280
#170911 16:39:01 server id 13711  end_log_pos 1494 CRC32 0xb0394743 	Update_rows: table id 125 flags: STMT_END_F
### UPDATE `myapp`.`slow_log`
### WHERE
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1484876000 /* INT meta=0 nullable=0 is_null=0 */
###   @3=' test_user_db' /* VARSTRING(60) meta=60 nullable=0 is_null=0 */
###   @4='192.168.137.111' /* VARSTRING(45) meta=45 nullable=0 is_null=0 */
###   @5=137685 /* INT meta=0 nullable=0 is_null=0 */
###   @6=3.282591 /* DECIMAL(8,6) meta=2054 nullable=0 is_null=0 */
###   @7=369055 /* INT meta=0 nullable=0 is_null=0 */
###   @8=369055 /* INT meta=0 nullable=0 is_null=0 */
###   @9='select * from dbname.tbl3;' /* VARSTRING(12000) meta=12000 nullable=0 is_null=0 */
### SET
###   @1=3 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1484876000 /* INT meta=0 nullable=0 is_null=0 */
###   @3=' test_user_db' /* VARSTRING(60) meta=60 nullable=0 is_null=0 */
###   @4='192.168.137.100' /* VARSTRING(45) meta=45 nullable=0 is_null=0 */
###   @5=137685 /* INT meta=0 nullable=0 is_null=0 */
###   @6=3.282591 /* DECIMAL(8,6) meta=2054 nullable=0 is_null=0 */
###   @7=369055 /* INT meta=0 nullable=0 is_null=0 */
###   @8=369055 /* INT meta=0 nullable=0 is_null=0 */
###   @9='select * from dbname.tbl3;' /* VARSTRING(12000) meta=12000 nullable=0 is_null=0 */
# at 1494
#170911 16:39:01 server id 13711  end_log_pos 1525 CRC32 0xf8f786fc 	Xid = 178149
COMMIT/*!*/;
# at 1525
#170911 16:45:38 server id 13711  end_log_pos 1590 CRC32 0x3a6f09c0 	Anonymous_GTID	last_committed=3	sequence_number=4
SET @@SESSION.GTID_NEXT= 'ANONYMOUS'/*!*/;
# at 1590
#170911 16:45:38 server id 13711  end_log_pos 1671 CRC32 0x2d051339 	Query	thread_id=13907	exec_time=0	error_code=0
SET TIMESTAMP=1505119538/*!*/;
SET @@session.time_zone='SYSTEM'/*!*/;
BEGIN
/*!*/;
# at 1671
#170911 16:45:38 server id 13711  end_log_pos 1892 CRC32 0x1bb71b96 	Rows_query
# insert into slow_log(start_time,db_user,app_ip,thread_id,exec_duration,rows_sent,rows_examined,slowsql)values(unix_timestamp(now()),'test_user_db','192.168.137.12',1233,20,120,120,'call sp_test()')
# at 1892
#170911 16:45:38 server id 13711  end_log_pos 1961 CRC32 0xacfa84aa 	Table_map: `myapp`.`slow_log` mapped to number 125
# at 1961
#170911 16:45:38 server id 13711  end_log_pos 2071 CRC32 0x62f42f6c 	Write_rows: table id 125 flags: STMT_END_F
### INSERT INTO `myapp`.`slow_log`
### SET
###   @1=7 /* LONGINT meta=0 nullable=0 is_null=0 */
###   @2=1505119538 /* INT meta=0 nullable=0 is_null=0 */
###   @3='test_user_db' /* VARSTRING(60) meta=60 nullable=0 is_null=0 */
###   @4='192.168.137.12' /* VARSTRING(45) meta=45 nullable=0 is_null=0 */
###   @5=1233 /* INT meta=0 nullable=0 is_null=0 */
###   @6=20.000000 /* DECIMAL(8,6) meta=2054 nullable=0 is_null=0 */
###   @7=120 /* INT meta=0 nullable=0 is_null=0 */
###   @8=120 /* INT meta=0 nullable=0 is_null=0 */
###   @9='call sp_test()' /* VARSTRING(12000) meta=12000 nullable=0 is_null=0 */
# at 2071
#170911 16:45:38 server id 13711  end_log_pos 2102 CRC32 0x5a478371 	Xid = 178162
COMMIT/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
