# encoding:utf-8
# 1.表字段列表 --MySQLdb
# 2.MySQL二进制日志解析成文本文件 -- mysqlbinlog 具体参数
# 3.构建反向SQL --update-where-set/delete/insert
import sys
import MySQLdb
import argparse
import os


class DB:
    def __init__(self, host, port, user, passwd, db):
        self.host = host
        self.port = port
        self.user = user
        self.passwd = passwd
        self.db = db
        self.connect()

    def connect(self):
        self.conn = MySQLdb.connect(host=self.host, port=self.port,
                                    user=self.user, passwd=self.passwd, db=self.db, charset='utf8')
        # self.cursor = self.conn.cursor(cursorclass=MySQLdb.cursors.DictCursor)
        self.conn.autocommit(True)
        self.cursor = self.conn.cursor()
        return self.cursor

    def query(self, sql):
        self.cursor.execute(sql)
        return self.cursor.fetchall()


def parse_args(args):
    '''' 输入必要的参数 '''
    parser = argparse.ArgumentParser(
        description="connect MySQL parameter", add_help=False)
    connect_setting = parser.add_argument_group('connect_setting')
    connect_setting.add_argument('-h', '--host', dest='host', type=str,
                                 help='Host the MySQL database server located', default='127.0.0.01')
    connect_setting.add_argument('-u', '--user', dest='user', type=str,
                                 help='MySQL username to login', default='root')
    connect_setting.add_argument('-p', '--password', dest='password', type=str,
                                 help='MySQL password to login', default='')
    connect_setting.add_argument('-P', '--port', dest='port', type=int,
                                 help='MySQL port to login', default=3306)

    range = parser.add_argument_group('range filter')
    range.add_argument('--start-file', dest='startfile', type=str,
                       help='Start binlog file to be parsed')
    range.add_argument('--start-position', '--start-pos', dest='startPos', type=int,
                       help='Start position of the --start-file', default=4)
    range.add_argument('--stop-position', '--stop-pos', dest='stopPos', type=int,
                       help='stop position of --stop-file', default=0)
    range.add_argument('--start-datetime', dest='startTime', type=str,
                       help='start datetime from reading binlog')
    range.add_argument('--stop-datetime', dest='StopTime', type=str,
                       help='stop reading the binlog at stop datetime')

    parser.add_argument('--help', dest='help', action='store_true',
                        help='help information', default=False)

    schema = parser.add_argument_group('schema filter')
    schema.add_argument('-d', '--databases', dest='databases', type=str,
                        help='dbs which to process', default='')
    schema.add_argument('-t', '--tables', dest='tables', type=str,
                        help='tables which to process', default='')
    return parser


def command_line_args(args):
    needPrintHelp = False if args else True
    parser = parse_args(args)
    args = parser.parse_args(args)
    if args.help or needPrintHelp:
        parser.print_help()
        sys.exit(1)
    return args


def table_fields():
    # ''' 返回表字段列表 '''
    sql = "desc %s" % (args.tables)
    return db.query(sql)


def process_set():
    ''' 处理where set 列与列之间连接串是逗号还是and '''
    field_set = []
    # 获取表的字段名,第1个字段保持不变，自第2字段起，加特殊标志，用于替换对应的符号(and/,)
    fields = table_fields()
    i = 0
    for col in fields:
        if i == 0:
            field_set.append(col[0])
            i += 1
        else:
            field_set.append('/*set*/ , /*set*/' + col[0])
    return field_set


def process_where():
    ''' 处理where set 列与列之间连接串是逗号还是and '''
    field_where = []
    # 获取表的字段名
    fields = table_fields()
    i = 0
    for col in fields:
        if i == 0:
            field_where.append(col[0])
            i += 1
        else:
            field_where.append('/*where*/ and /*where*/' + col[0])
    return field_where


def process_binlog(filename):
    # 遍历解析出需要关键字
    with open(filename) as f:
        # 引入变量sqlcomm用于表示SQL执行是否是insert/delete/where 其中一类
        sqlcomm = 0
        dml_sql = ''
        for line in f:
            # line = line.strip()
            # if line.rstrip('\n') == 'BEGIN':
            #     line = line.replace('BEGIN', '')
            if line.rstrip() == '### SET':
                line = line[3:]
                sqlcomm = 1
            elif line.rstrip() == '### WHERE':
                line = line[3:]
                sqlcomm = 2
            elif line.startswith('###   @'):
                # 获取@后面的序号用于对应表中字段名称
                len_num = len('###   @')
                i = line[len_num:].split('=')[0]
                # 转换TIMESTAMP时间类型
                if line[8 + len(i):].split(' ')[2] == 'TIMESTAMP(0)':
                    # patt = re.compile("/* .* */")
                    pos = line.find('/* TIMESTAMP(0) meta=')
                    line = line.split('=')[0] + '=' + 'from_unixtime(' + \
                        line[:pos][8 + len(i):].rstrip() + ')' + '\n'
                # 处理负数存储方式 ###   @11=-1 (255)
                if line.split('=')[1].startswith('-'):
                        # 去除后面括号及范围
                    line = line.split('=')[0] + '=' + \
                        line.split('=')[1].split(' ')[0] + '\n'
                if sqlcomm == 1:
                    line = str(process_set()[int(i) - 1]) + \
                        line[(len_num + len(i)):].split('/* ')[0]
                elif sqlcomm == 2:
                    line = str(process_where()[
                               int(i) - 1]) + line[(len_num + len(i)):].split('/* ')[0]
            elif line.startswith('### DELETE') or line.startswith('### INSERT') or line.startswith('### UPDATE'):
                line = '\n' + line[3:]
                # print line
            # elif line.find('Xid =') != -1:
            #     # 事务结束时间 + end_log_pos
            #     pass
            #     # print line
            else:
                # 清理sql之外的内容，否则多余内容记录到dml_sql
                line = ''
            if line.rstrip('\n') != '':
                dml_sql += line + ' '
    # 返回解析后的内容
    return dml_sql


def construct_sql_dml(filename):
    # 根据dml_sql内容，拼接成规范SQL语句
    dml_sql = process_binlog(filename)
    undo_sql = ''
    undo_sql = dml_sql.replace(' INSERT INTO', ';DELETE FROM_x ').replace(' UPDATE', ';UPDATE ').replace(' DELETE FROM', ';INSERT INTO').replace(';DELETE FROM_x', ';DELETE FROM').replace(
        'WHERE', 'WHERE_y').replace('SET', 'WHERE').replace('WHERE_y', 'SET').replace('/*set*/ , /*set*/', ' and ').replace('/*where*/ and /*where*/', ' , ')
    # dml_sql = dml_sql.replace(
    #     '/*set*/ , /*set*/', ' , ').replace('/*where*/ and /*where*/', ' and  ')
    record_sql = ''
    undosql_desc = ''
    finish_sql = list()
    for sql in undo_sql.splitlines():
        # 拼接一行一条完整的SQL
        if sql.startswith(';UPDATE') or sql.startswith(';INSERT') or sql.startswith(';DELETE'):
            undosql_desc = record_sql + undosql_desc
            record_sql = ''
            record_sql = record_sql + sql
        else:
            record_sql = record_sql + sql
    undo_sql = record_sql + undosql_desc
    undo_sql = undo_sql.lstrip()[1:] + ';'
    for x in undo_sql.strip().split(';'):
        if x == '\n' or x == '':
            continue
        finish_sql.append(x+';')
    # 返回解析完成的SQL
    return finish_sql


if __name__ == '__main__':
    # print sys.argv
    args = command_line_args(sys.argv[1:])
    # # print args.host, args.port, args.user, args.password, args.databases, args.tables
    db = DB(host=args.host, port=args.port, user=args.user,
            passwd=args.password, db=args.databases)
    # print construct_sql_dml('bindata.sql')
    # 首先将MySQL的二进制日子通过工具mysqlbinlog转换成文本格式
    #print args.startTime, args.StopTime
    if args.startTime:
        cmd = "/usr/bin/mysqlbinlog --base64-output=decode-rows -v -v --start-datetime='%s' --stop-datetime='%s' %s > %s" % (args.startTime, args.StopTime,args.startfile,'bindata.sql')
    elif args.startPos:
        cmd = "/usr/bin/mysqlbinlog --base64-output=decode-rows -v -v --start-position=%d --stop-position='%d' %s > bindata.sql" % (
            args.startPos, args.stopPos,args.startfile)
    import commands
    res = commands.getstatusoutput(cmd)
    if res[0] != 0:
        print "Error:%s"%(res[1])
    # 格式化结果输出
    for sql in construct_sql_dml('bindata.sql'):
        print sql
