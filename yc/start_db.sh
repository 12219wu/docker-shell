usermod -d /var/lib/mysql/ mysql
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

while true
do
	service mysql stop
	service mysql start
	if [ $? -eq 0 ];then
		echo "$(date +%Y:%m:%d-%H:%M:%S) success start mysql"
		break
	else
		echo "$(date +%Y:%m:%d-%H:%M:%S) faild start mysql. Begin retry."
		sleep 1s
	fi
done

echo "mysql begin provide service."
# 阻塞
tail -f /dev/null

