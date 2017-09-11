# mysqlbinlog2sql
解析MySQL二进制日志中DML 实现flaskback方法


# 条件
1.Python2.7
2.MySQLdb
3.binlog_format = row 且 binlog_row_image=full
4.解析数据量较少

# 功能
1.通过mysqlbinlog 将二进制日志转成文本文件
2.delete from => insert into
3.update => where/set对调位置
4.insert => delete

# 使用方法
python bin2sql.py -hip -Pport -uroot -ppassword -ddatabase -ttables --start-datetime='' --stop-datetime='' --start-file=bin-log.000001 
-h: 数据库服务所在的ip
-P: 端口
-u: 用户
-p: 密码
-d: 数据库名
-t: 表名
--start-datetime: mysqlbinlog参数
--stop-datetime: mysqlbinlog参数
--start-file:二进制文件

# 例子
mysql-bin.000016

python bin2sql.py -h192.168.137.11 -P3376 -uroot -p123456 -dmyapp -tslow_log --start-position=4 --stop-position=2071 --start-file=mysql-bin.000016