#mysql数据库 
currentDir=$(cd "$(dirname $0)";pwd)
cd $currentDir

if [ -z $GL_BACK_MYSQL_PORT ];then
	echo 'undefined: GL_BACK_MYSQL_PORT'
	exit 0
fi

if [ -z $GL_BACK_MYSQL_NAME ];then
	export GL_BACK_MYSQL_NAME=back-server-mysql-1
fi

HOST_PORT=$GL_BACK_MYSQL_PORT
CONTAINER_NAME=$GL_BACK_MYSQL_NAME

echo '-----------------------------------------'
# -----------------------------------------
# 下面自动执行
# -----------------------------------------

# 重置数据库函数
reset_db_method(){
	echo "是否重置mysql数据库:"$GL_BACK_SERVER_DB_RESET
	if [ ! -z $GL_BACK_SERVER_DB_RESET ] && [ $GL_BACK_SERVER_DB_RESET'X' = 'true''X' ]; then
		do_reset_db_method
	fi
}

do_reset_db_method(){
	echo "重置数据库 mysql >>>>>>>>>>>>>>>>>>>>>>>>"
	docker exec -i $CONTAINER_NAME /bin/bash "/home/workspace/init_db.sh"
	echo "重置数据库 mysql <<<<<<<<<<<<<<<<<<<<<<<<"
	exit 0
}

docker ps | grep $CONTAINER_NAME
if [ $? -eq 0 ];then
	#存在，提示
	echo $CONTAINER_NAME "，Mysql容器已存在，请勿重新初始化DB"
	reset_db_method
	exit 0
fi
docker ps -a | grep $CONTAINER_NAME
if [ $? -eq 0 ];then
	#存在，提示
	echo $CONTAINER_NAME "，Mysql容器已存在，且已停止，重新启动。"
	docker start $CONTAINER_NAME
	reset_db_method
	exit 0
fi

echo "创建mysql容器："$CONTAINER_NAME 
docker run -itd --name=$CONTAINER_NAME -p $HOST_PORT:3306 -v $currentDir:/home/workspace jdk1.8-mysql5.7:V1.2 /bin/bash -c "/bin/sh /home/workspace/start_db.sh"
if [ ! $? -eq 0 ];then
	#创建失败
	echo $CONTAINER_NAME "，创建失败"
	echo $1
	docker stop $CONTAINER_NAME
	docker rm $CONTAINER_NAME
	exit 0
else
	#创建成功-初始化数据库
	do_reset_db_method
	echo "创建成功-初始化数据库"
fi
