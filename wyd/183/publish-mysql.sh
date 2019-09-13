
CONTAINER="grid-mysql"
chmod 777 ./run-mysql.sh
./run-mysql.sh
echo "数据库正在初始化..."
init_db(){
	while true
	do
		docker exec -it $CONTAINER /bin/bash "create-db.sh"
		if [ $? -eq 0 ];then
			echo "数据库初始化完毕"
			break
		else
			echo "数据库正在初始化..."
			sleep 5s
		fi
	done

}
if [ $? -eq 0 ];then
	init_db
fi
