#启动数据库 
usermod -d /var/lib/mysql/ mysql
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
service mysql start

#数据库信息
HOSTNAME="127.0.0.1"                                           
PORT="3306"
USERNAME="root"
PASSWORD="my123456"

#初始化数据库:mini_gate

DBNAME_gate="mini_gate"
create_db_sql_gate="create database IF NOT EXISTS ${DBNAME_gate} CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'"
mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} -e "${create_db_sql_gate}"
mysql -u${USERNAME} -p${PASSWORD} ${DBNAME_gate} < /home/workspace/data/mini_gate.sql
echo 'Finish init DB:'$DBNAME_gate

DBNAME_xxljob="xxl_job"
create_db_sql_xxljob="create database IF NOT EXISTS ${DBNAME_xxljob} CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'"
mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} -e "${create_db_sql_xxljob}"
mysql -u${USERNAME} -p${PASSWORD} ${DBNAME_xxljob} < /home/workspace/data/xxl_job.sql
echo 'Finish init DB:'$DBNAME_xxljob

DBNAME_fdfs="fast_dfs"
create_db_sql_fdfs="create database IF NOT EXISTS ${DBNAME_fdfs} CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'"
mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} -e "${create_db_sql_fdfs}"
mysql -u${USERNAME} -p${PASSWORD} ${DBNAME_fdfs} < /home/workspace/data/fast_dfs.sql
echo 'Finish init DB:'$DBNAME_fdfs

#休眠一下，等待数据初始化完成
sleep 3s