#WORK_DIR=$PWD/videoAnalyzeService
WORK_DIR=$(cd "$(dirname $0)";pwd)
CONTAINER_NAME='test-'$GL_VISUAL_FRAME_NAME'V0.2.0'

if [ ! -d $WORK_Dir ]
then
   	echo "Cannot find "$WORK_Dir
	exit 0
fi

#删除停止所有版本的容器
if [ "$GL_VISUAL_FRAME_NAME" ];
then
	docker stop  $(docker ps -a | grep 'test-'$GL_VISUAL_FRAME_NAME|awk '{print $1}')
	docker rm  $(docker ps -a | grep 'test-'$GL_VISUAL_FRAME_NAME|awk '{print $1}')
fi

docker run -itd \
-p $GL_VISUAL_FRAME_PORT:10401 \
-p $GL_VISUAL_DB_PORT:3306 \
-w "/home/workspace" \
-v $WORK_DIR:/home/workspace \
-v /etc/localtime:/etc/localtime:ro \
--name $CONTAINER_NAME opencv-mysql:V1.3 \
/bin/bash  -c "/bin/sh start.sh"

echo "新创建的容器信息如下："
docker ps | grep $CONTAINER_NAME
