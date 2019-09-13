echo "--------------------------------------"
echo "deploying ..."
./docker-rm-all.sh

SRC_DIR=`pwd`
MAP_DATA=$SRC_DIR/../data

SERVERS=("Service-Model" "Service-Route" "Service-Search" "Service-Spacdt" "Service-Updatelink") 
CONTAINERS=("publish-Grid-Model" "publish-Grid-Route" "publish-Grid-Search" "publish-Grid-Spacdt" "publish-Grid-Updatelink") 
PORTS=(10609 10610 10611 10612 10621) 
CONTAINER_PORTS=(10609 10610 10611 10612 10621) 

COUNT=${#SERVERS[@]}
echo "servers num is" $COUNT

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

docker run -td -v $SRC_DIR:/go -v $MAP_DATA:/mapData -p $PORT:$CONTAINER_PORT --name $CONTAINER golang:latest /bin/bash

cp $SRC_DIR/run-base.sh $SRC_DIR/run-publish.sh
sed -i "s/SERVERBASE/$SERVER/g" $SRC_DIR/run-publish.sh

chmod +x $SRC_DIR/.bashrc
chmod +x $SRC_DIR/run-publish.sh

docker cp $SRC_DIR/.bashrc $CONTAINER:/root
docker cp $SRC_DIR/run-publish.sh $CONTAINER:/root
docker restart $CONTAINER
done

#  service navi
SERVER="Service-GridNavi"
CONTAINER="publish-Grid-Navi"
PORT=10620
CONTAINER_PORT=10620
PORT2=10660
CONTAINER_PORT2=10660

echo $PORT $CONTAINER_PORT $SERVER $CONTAINER

mkdir -p $SERVER/static
rm $SERVER/static/mapdata
ln -s /mapData/Alpha-TileData-v0.0.4 $SERVER/static/mapdata

docker run -td -v $SRC_DIR:/go -v $MAP_DATA:/mapData -p $PORT:$CONTAINER_PORT -p $PORT2:$CONTAINER_PORT2  --name $CONTAINER golang:latest /bin/bash


cp $SRC_DIR/run-base.sh $SRC_DIR/run-publish.sh
sed -i "s/SERVERBASE/$SERVER/g" $SRC_DIR/run-publish.sh

chmod +x $SRC_DIR/.bashrc
chmod +x $SRC_DIR/run-publish.sh

docker cp $SRC_DIR/.bashrc $CONTAINER:/root
docker cp $SRC_DIR/run-publish.sh $CONTAINER:/root
docker restart $CONTAINER



./docker-restart-all.sh
