WORK_DIR=$PWD
CONTAINER_NAME=CMAKE-WYD

# 判断容器是否存在
docker ps -a | grep $CONTAINER_NAME
if [ $? -eq 0 ]
	then
	#存在，提示
	echo $CONTAINER_NAME "，该容器已存在，即将删除"
	docker stop $CONTAINER_NAME
	docker rm $CONTAINER_NAME
fi
#在Docker容器退出时，默认容器内部的文件系统仍然被保留，以方便调试并保留用户数据
#因而可以在容器启动时设置--rm选项，这样在容器退出时就能够自动清理容器内部的文件系统
#-i: 以交互模式运行容器，通常与 -t 同时使用；
#-t: 为容器重新分配一个伪输入终端，通常与 -i 同时使用；
docker run --rm -it \
-w "/cmake" \
-v $WORK_DIR:/cmake \
--name $CONTAINER_NAME cmake:latest \
/bin/bash