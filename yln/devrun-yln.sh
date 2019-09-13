WORK_DIR=/home/yulineng/workspace/webFrontend.src.web/map_client_master
CONTAINER_NAME='yln-workspaceV0.4'


if [ ! -d $WORK_DIR ]
then
   	echo "Cannot find "$WORK_DIR
	exit 0
fi

#判断容器是否存在
docker ps -a | grep $CONTAINER_NAME
if [ $? -eq 0 ]
	then
	#存在，提示
	echo $CONTAINER_NAME "，该容器已存在，即将删除"
	docker stop $CONTAINER_NAME
	docker rm $CONTAINER_NAME
fi

docker run -itd \
--name=$CONTAINER_NAME \
-v $WORK_DIR:/home/workspace \
-p 10110:10110 \
-p 10117:10117 \
192.168.2.193:5000/web/nodelatest:V1.0 \
/bin/bash \
-c "/bin/sh /home/workspace/start.sh"
echo "新创建的容器信息如下："
docker ps | grep $CONTAINER_NAME
