#!bin/bash

# 当前目录与父目录
current_path=$(cd `dirname $0`; pwd)
current_parent_path=$(dirname $(pwd))

# 数据文件名字与表名
table_name='updateinfo_xiaoxu.csv'

# 查询文件
oracle_file_path=$current_path'/select-sql/oracle-sql/updateinfo_xiaoxu.sql'

# 文件存放路径
data_path=$current_path'/data-dir/'$table_name

# ORACLE 链接信息
ip='192.168.***.**'

orcl='orcl'
port='1521'

user_name='******'
password='******'

# 分隔符,16进制转化过来为@@@&&&
split_char='0x400x400x400x260x260x26'

# 这里添加oracle转换的oracle-conversion.sh脚本
# time sh  "util/oracle-conversion.sh"

# 使用sqluldr2linux64下载数据到制定的目录
./sqluldr2linux64.bin  user=$user_name/$password@$ip:$port/$orcl sql=$oracle_file_path  head=no safe=yes charset=utf8 field=$split_char  FILE=$data_path

echo -e "\n\t 替换特殊字符与分隔符......"
sh $current_path"/util/fileAsciiReplaceScriptAll.sh" $current_path"/data-dir/*"

# 入库脚本
sh import-greenplum.sh $table_name

