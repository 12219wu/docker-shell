SRC_DIR=`pwd`
MAP_DATA=$SRC_DIR/../data

SRCIP="10.100.1.140"
SRCPORT="3306"
DESTIP="10.100.100.183"
DESTPORT="10652"

SERVERS=("Service-Model" "Service-Route" "Service-Search" "Service-Spacdt" "Service-Updatelink" "Service-GridNavi")
CONTAINERS=("publish-Grid-Model" "publish-Grid-Route" "publish-Grid-Search" "publish-Grid-Spacdt" "publish-Grid-Updatelink" "publish-Grid-Navi") 
PORTS=(10609 10610 10611 10612 10621 10620 10660)
CONTAINER_PORTS=(10609 10610 10611 10612 10621 10620 10660)

COUNT=${#SERVERS[@]}
echo "servers num is" $COUNT

find $SRC_DIR -iname "app.conf" | xargs sed -i "s/$SRCIP/$DESTIP/g"
find $SRC_DIR -iname "app.conf" | xargs sed -i "s/$SRCPORT/$DESTPORT/g"

#for SERVER in Service-Model Service-Route Service-Search Service-Spacdt Service-GridNavi
for((i=0;i<$COUNT;i++))
do
SERVER=${SERVERS[$i]}
CONTAINER=${CONTAINERS[$i]}
PORT=${PORTS[$i]}
CONTAINER_PORT=${CONTAINER_PORTS[$i]}

echo $PORT $CONTAINER_PORT $SERVER $CONTAINER

mkdir -p $SERVER/static
rm $SERVER/static/mapdata
ln -s /mapData/Alpha-TileData-v0.0.4 $SERVER/static/mapdata

cp $SRC_DIR/run-base-wyd.sh $SRC_DIR/run-publish-wyd.sh
chmod +x $SRC_DIR/run-publish-wyd.sh
sed -i "s/SERVERBASE/$SERVER/g" $SRC_DIR/run-publish-wyd.sh

#判断容器是否存在
docker ps -a | grep $CONTAINER
if [ $? -eq 0 ]
	then
	#存在，提示
	echo $CONTAINER "，该容器已存在，即将删除"
	docker stop $CONTAINER
	docker rm $CONTAINER
fi

if [ ${CONTAINER} == "publish-Grid-Navi" ];then
PORT2=${PORTS[$i+1]}
CONTAINER_PORT2=${CONTAINER_PORTS[$i+1]}
echo $PORT2 $CONTAINER_PORT2
docker run -itd \
-w "/go" \
-v $SRC_DIR:/go \
-v $MAP_DATA:/mapData \
-p $PORT:$CONTAINER_PORT \
-p $PORT2:$CONTAINER_PORT2 \
--name $CONTAINER golang:latest \
/bin/bash \
-c "/bin/sh run-publish-wyd.sh"
echo "新创建的容器信息如下："
docker ps | grep $CONTAINER
else
docker run -itd \
-w "/go" \
-v $SRC_DIR:/go \
-v $MAP_DATA:/mapData \
-p $PORT:$CONTAINER_PORT \
--name $CONTAINER golang:latest \
/bin/bash \
-c "/bin/sh run-publish-wyd.sh"
echo "新创建的容器信息如下："
docker ps | grep $CONTAINER
fi
done
