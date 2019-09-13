SRC_DIR="/home/xh/workspace"
SRC_NAME="grid-map.src"
MAP_DATA="/home/xh/workspace/data"

SERVER="Service-Model"
CONTAINER="Grid-Model"
PORT=10609
CONTAINER_PORT=10609

echo $PORT $CONTAINER_PORT $SERVER $CONTAINER

#-p 确保目录名称存在，不存在的就建一个
mkdir -p $SRC_DIR/$SRC_NAME/src/GridService/$SERVER/static

#删除文件夹
rm -rf $SRC_DIR/$SRC_NAME/src/GridService/$SERVER/static/mapdata

#ln [参数][源文件或目录][目标文件或目录] 参数-s 软链接(符号链接)
ln -s /mapData/Alpha-TileData-v0.0.4 $SRC_DIR/$SRC_NAME/src/GridService/$SERVER/static/mapdata

cp $SRC_DIR/$SRC_NAME/src/config-dev/servicestart-base.sh $SRC_DIR/$SRC_NAME/src/config-dev/servicestart-dev.sh

chmod +x $SRC_DIR/$SRC_NAME/src/config-dev/servicestart-dev.sh
#sed 的-i选项可以直接修改文件内容，将SERVERBASE替换为$SERVER
sed -i "s/SERVERBASE/$SERVER/g" $SRC_DIR/$SRC_NAME/src/config-dev/servicestart-dev.sh

#判断容器是否存在
docker ps -a | grep $CONTAINER
if [ $? -eq 0 ]
	then
	#存在，提示
	echo $CONTAINER "，该容器已存在，即将删除"
	docker stop $CONTAINER
	docker rm $CONTAINER
fi

docker run -it \
-v $SRC_DIR:/go \
-v $MAP_DATA:/mapData \
-w "/go/grid-map.src/src/config-dev" \
-p $PORT:$CONTAINER_PORT \
--name $CONTAINER golang:latest \
/bin/bash \
-c "/bin/sh servicestart-model.sh"
echo "新创建的容器信息如下："
docker ps | grep $CONTAINER
