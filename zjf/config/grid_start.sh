echo "--------------------------------------"
echo "grid start ..."
SRCIP="10.100.1.140"
SRCPORT="10501"
IP="10.100.1.141"
PORT="10698"
SRC_DIR="/home/xh/workspace/publish/Grid-Alpha-V0.2.0"

cd $SRC_DIR

CONTAINER="grid-mysql"
docker stop $CONTAINER
docker rm $CONTAINER

#-----导入数据库
sed -i "s/$SRCIP/$IP/g" $SRC_DIR/Service-MySQL/run-publish.sh

docker run -d -e MYSQL_ROOT_PASSWORD=123456 -p 10652:3306 --name $CONTAINER mysql:latest

chmod +x $SRC_DIR/.bashrc
chmod +x $SRC_DIR/Service-MySQL/run-publish.sh
docker cp $SRC_DIR/.bashrc $CONTAINER:/root
docker cp $SRC_DIR/Service-MySQL/run-publish.sh $CONTAINER:/root
docker cp $SRC_DIR/Service-MySQL/data/grid_map_10652.sql $CONTAINER:/root
sleep 20s
docker restart $CONTAINER
sleep 10s
docker exec -t $CONTAINER /bin/bash &
#----end

find $SRC_DIR -iname "app.conf" | xargs sed -i "s/$SRCIP/$IP/g"
sed -i "s/$SRCIP:$SRCPORT/$IP:$PORT/g" $SRC_DIR/Service-GridNavi/static/libs/js/*.js
sed -i "s/$SRCIP:$SRCPORT/$IP:$PORT/g" $SRC_DIR/Service-GridNavi/static/gred-web/dist/*.html
sed -i "s/$SRCIP:$SRCPORT/$IP:$PORT/g" $SRC_DIR/Service-GridNavi/static/*/dist/*.js
sed -i "s/$SRCIP:$SRCPORT/$IP:$PORT/g" $SRC_DIR/Service-GridNavi/static/*/examples/*.html
sed -i "s/$SRCIP/$IP/g" $SRC_DIR/Service-GridNavi/static/libs/js/*.js

./docker-deploy.sh



