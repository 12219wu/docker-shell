echo "--------------------------------------"
echo "deploying ..."
./docker-rm-all.sh

SRC_DIR="/home/xh/workspace"
SRC_NAME="grid-map.src"
MAP_DATA="/home/xh/workspace/data"

SERVERS=("Service-Model" "Service-Route" "Service-Search" "Service-Spacdt" "Service-Updatelink") 
CONTAINERS=("Grid-Model" "Grid-Route" "Grid-Search" "Grid-Spacdt" "Grid-Updatelink") 
PORTS=(10609 10610 10611 10612 10621) 
CONTAINER_PORTS=(10609 10610 10611 10612 10621) 

COUNT=${#SERVERS[@]}
echo "servers num is" $COUNT

#for SERVER in Service-Model Service-Route Service-Search Service-Spacdt
for((i=0;i<$COUNT;i++))
do
SERVER=${SERVERS[$i]}
CONTAINER=${CONTAINERS[$i]}
PORT=${PORTS[$i]}
CONTAINER_PORT=${CONTAINER_PORTS[$i]}

echo $PORT $CONTAINER_PORT $SERVER $CONTAINER

mkdir -p $SRC_DIR/$SRC_NAME/src/GridService/$SERVER/static
rm $SRC_DIR/$SRC_NAME/src/GridService/$SERVER/static/mapdata
ln -s /mapData/Alpha-TileData-v0.0.4 $SRC_DIR/$SRC_NAME/src/GridService/$SERVER/static/mapdata

docker run -td -v $SRC_DIR:/go -v $MAP_DATA:/mapData  -p $PORT:$CONTAINER_PORT --name $CONTAINER golang:latest /bin/bash

cp $SRC_DIR/$SRC_NAME/src/config-dev/run-base.sh $SRC_DIR/$SRC_NAME/src/config-dev/run-dev.sh
sed -i "s/SERVERBASE/$SERVER/g" $SRC_DIR/$SRC_NAME/src/config-dev/run-dev.sh

chmod +x $SRC_DIR/$SRC_NAME/src/config-dev/.bashrc
chmod +x $SRC_DIR/$SRC_NAME/src/config-dev/run-dev.sh

docker cp $SRC_DIR/$SRC_NAME/src/config-dev/.bashrc $CONTAINER:/root
docker cp $SRC_DIR/$SRC_NAME/src/config-dev/run-dev.sh $CONTAINER:/root
docker restart $CONTAINER
done

#  service navi
SERVER="Service-GridNavi"
CONTAINER="Grid-Navi"
PORT=10620
CONTAINER_PORT=10620
PORT2=10660
CONTAINER_PORT2=10660

echo $PORT $CONTAINER_PORT $SERVER $CONTAINER

mkdir -p $SRC_DIR/$SRC_NAME/src/GridService/$SERVER/static
rm $SRC_DIR/$SRC_NAME/src/GridService/$SERVER/static/mapdata
ln -s /mapData/Alpha-TileData-v0.0.4 $SRC_DIR/$SRC_NAME/src/GridService/$SERVER/static/mapdata

docker run -td -v $SRC_DIR:/go -v $MAP_DATA:/mapData  -p $PORT:$CONTAINER_PORT   -p $PORT2:$CONTAINER_PORT2 --name $CONTAINER golang:latest /bin/bash

cp $SRC_DIR/$SRC_NAME/src/config-dev/run-base.sh $SRC_DIR/$SRC_NAME/src/config-dev/run-dev.sh
sed -i "s/SERVERBASE/$SERVER/g" $SRC_DIR/$SRC_NAME/src/config-dev/run-dev.sh

chmod +x $SRC_DIR/$SRC_NAME/src/config-dev/.bashrc
chmod +x $SRC_DIR/$SRC_NAME/src/config-dev/run-dev.sh

docker cp $SRC_DIR/$SRC_NAME/src/config-dev/.bashrc $CONTAINER:/root
docker cp $SRC_DIR/$SRC_NAME/src/config-dev/run-dev.sh $CONTAINER:/root
docker restart $CONTAINER


./docker-restart-all.sh
