SRC_DIR="/home/xh/workspace/publish"
VERSION="Grid-Alpha-WYD-TEST"
CONTAINER="grid-mysql"
docker ps -a | grep $CONTAINER
if [ $? -eq 0 ];then
	#存在，提示
	echo $CONTAINER"，容器已存在，即将删除"
	docker stop  $CONTAINER
	docker rm  $CONTAINER
fi
docker run -itd \
	--name $CONTAINER \
	-v $SRC_DIR/$VERSION:/Grid-Alpha \
	-w "/Grid-Alpha" \
	-e MYSQL_ROOT_PASSWORD=123456 \
	-p 10652:3306 mysql:latest 
if [ ! $? -eq 0 ];then
	#创建失败
	echo $CONTAINER",创建失败"
	docker stop $CONTAINER
	docker rm $CONTAINER
	exit 1
else
	#创建成功-初始化数据库
	echo $CONTAINER",创建成功"
fi
