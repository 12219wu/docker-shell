##EasydarwinRTSP����NODE����˵��

����docker�͹رշ���ǽ�Ȳ���ʡ��

## �������а�װgoland
1. ��������
docker run -it -v ~/workspace:/home/workspace --name go-mysql-temp ubuntu16.04:V1.0 /bin/bash
 
2.����golang����
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

3.����mysql

apt-get install mysql-server
��װ����ʾ����root������:root���Զ���

vi /etc/mysql/mysql.conf.d/mysqld.cnf ��//��bind-address = 127.0.0.1 �޸ĳ� bind-address = 0.0.0.0 
mysql -u root -proot #��¼mysql
use mysql;		#����mysql���ݿ�
select Host,User from user;	#�鿴user����root�Ƿ�֧���ⲿ���ʣ�localhost ֻ֧�ֱ��أ�
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;  #��Ϊ%-�ⲿ�����Է���
FLUSH PRIVILEGES; #ˢ�±�
quit;#�˳�mysql

echo "service mysql start" >> /etc/bash.bashrc  #�������ݿ�

#���������ļ�����������
docker export go-mysql-temp > golang-mysqlV1.0.tar

docker import golang-mysqlV1.0.tar
�鿴��װ�ľ���ID (��㣬�кܶ�none��)
#docker images
docker tag 4459db374b42 golang-mysql:V1.0
