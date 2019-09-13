SRC_DIR="/home/xh/workspace"
SRC_NAME="grid-map.src"
MAP_DATA="/home/xh/workspace/data"

SERVERS=("Service-Model" "Service-Route" "Service-Search" "Service-Spacdt" "Service-Updatelink" "Service-GridNavi")
CONTAINERS=("Grid-Model" "Grid-Route" "Grid-Search" "Grid-Spacdt" "Grid-Updatelink" "Grid-Navi")
PORTS=(10609 10610 10611 10612 10621 10620 10660)
CONTAINER_PORTS=(10609 10610 10611 10612 10621 10620 10660)

#启动rabbitmq容器
docker restart okong-rabbit

COUNT=${#SERVERS[@]}
echo "servers num is" $COUNT

for((i=0;i<$COUNT;i++))
do
SERVER=${SERVERS[$i]}
CONTAINER=${CONTAINERS[$i]}
PORT=${PORTS[$i]}
CONTAINER_PORT=${CONTAINER_PORTS[$i]}

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
docker ps | grep $CONTAINER
if [ $? -eq 0 ]
	then
	#存在，提示
	echo $CONTAINER "，该容器已存在，即将删除"
	docker stop $CONTAINER
	docker rm $CONTAINER
fi

if [ ${CONTAINER} == "Grid-Navi" ];then
PORT2=${PORTS[$i+1]}
CONTAINER_PORT2=${CONTAINER_PORTS[$i+1]}
echo $PORT2 $CONTAINER_PORT2
docker run -itd \
-w "/go/grid-map.src/src/config-dev" \
-v $SRC_DIR:/go \
-v $MAP_DATA:/mapData \
-p $PORT:$CONTAINER_PORT \
-p $PORT2:$CONTAINER_PORT2 \
--name $CONTAINER golang:latest \
/bin/bash \
-c "/bin/sh servicestart-dev.sh"
echo "新创建的容器信息如下："
docker ps | grep $CONTAINER
else
docker run -itd \
-w "/go/grid-map.src/src/config-dev" \
-v $SRC_DIR:/go \
-v $MAP_DATA:/mapData \
-p $PORT:$CONTAINER_PORT \
--name $CONTAINER golang:latest \
/bin/bash \
-c "/bin/sh servicestart-dev.sh"
echo "新创建的容器信息如下："
docker ps | grep $CONTAINER
fi
done
