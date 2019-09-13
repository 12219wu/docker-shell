HOSTNAME="10.100.1.140"                                          #数据库信息
PORT="3306"
USERNAME="root"
PASSWORD="123456"

DBNAME="grid_map"                                                #数据库名称

create_db_sql="create database IF NOT EXISTS ${DBNAME} CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'"
mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} -e "${create_db_sql}" 

mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} ${DBNAME} < ./data/grid_map_$PORT.sql
