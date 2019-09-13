SRCIP="10.100.1.140"
SRCPORT="3306"
IP="10.100.100.183"
PORT="10652"
SRC_DIR="/home/xh/workspace/publish/Grid-Alpha-WYD-TEST"

chmod 777 publish-mysql.sh
./publish-mysql.sh
chmod 777 publish-go-service.sh
./publish-go-service.sh

