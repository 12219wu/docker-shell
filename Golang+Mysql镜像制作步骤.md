##EasydarwinRTSP服务NODE容器说明

部署docker和关闭防火墙等操作省略

## 在容器中安装goland
1. 基础镜像
docker run -it -v ~/workspace:/home/workspace --name go-mysql-temp ubuntu16.04:V1.0 /bin/bash
 
2.部署golang环境
```
apt-get update
apt-get install golang-1.10
echo "export GOROOT=/usr/lib/go-1.10" >> /etc/bash.bashrc
echo "export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/go-1.10/bin" >> /etc/bash.bashrc
echo "export GOPATH=/go:/go/my_gopath" >> /etc/bash.bashrc
mkdir /go
cd /go
ln -s /home/workspace/my_gopath/ my_gopath
ln -s /home/workspace/videoAnalyze.src/  src

3.部署mysql

apt-get install mysql-server
安装中提示输入root的密码:root（自定）

vi /etc/mysql/mysql.conf.d/mysqld.cnf 　//将bind-address = 127.0.0.1 修改成 bind-address = 0.0.0.0 
mysql -u root -proot #登录mysql
use mysql;		#进入mysql数据库
select Host,User from user;	#查看user表中root是否支持外部访问，localhost 只支持本地；
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;  #改为%-外部都可以访问
FLUSH PRIVILEGES; #刷新表
quit;#退出mysql

echo "service mysql start" >> /etc/bash.bashrc  #重启数据库

#制作镜像文件并发布镜像
docker export go-mysql-temp > golang-mysqlV1.0.tar

docker import golang-mysqlV1.0.tar
查看安装的镜像ID (最顶层，有很多none的)
#docker images
docker tag 4459db374b42 golang-mysql:V1.0
