#备份mysq数据库中
CONTAINER_NAME=back-server-mysql-1

#备份文件服务数据库：结构
#mysqldump -uroot -pmy123456 -P3306 fast_dfs -d | sed 's/AUTO_INCREMENT=[0-9]*\s*//g' > /fast_dfs.sql
docker exec -i $CONTAINER_NAME /bin/bash -c "mysqldump -uroot -pmy123456 -P3306 fast_dfs -d | sed 's/AUTO_INCREMENT=[0-9]*\s*//g' > /fast_dfs.sql"

#备份xxl-job数据库：结构+部分数据
#mysqldump -uroot -pmy123456 -P3306 xxl_job -d | sed 's/AUTO_INCREMENT=[0-9]*\s*//g' > /xxl_job.sql
docker exec -i $CONTAINER_NAME /bin/bash -c "mysqldump -uroot -pmy123456 -P3306 xxl_job -d | sed 's/AUTO_INCREMENT=[0-9]*\s*//g' > /xxl_job.sql"
docker exec -i $CONTAINER_NAME /bin/bash -c "mysqldump -uroot -pmy123456 -P3306 xxl_job XXL_JOB_QRTZ_TRIGGER_GROUP XXL_JOB_QRTZ_TRIGGER_INFO XXL_JOB_QRTZ_CRON_TRIGGERS XXL_JOB_QRTZ_FIRED_TRIGGERS XXL_JOB_QRTZ_JOB_DETAILS XXL_JOB_QRTZ_TRIGGERS -t >> /xxl_job.sql"

#备份mini-gate网关数据库。结构 + mg_request，mg_service，mg_token的数据
#mysqldump -uroot -pmy123456 -P3306 mini_gate -d | sed 's/AUTO_INCREMENT=[0-9]*\s*//g' > /mini_gate.sql
#mysqldump -uroot -pmy123456 -P3306 mini_gate mg_request mg_service mg_token -t | sed 's/AUTO_INCREMENT=[0-9]*\s*//g' >> /mini_gate.sql
docker exec -i $CONTAINER_NAME /bin/bash -c "mysqldump -uroot -pmy123456 -P3306 mini_gate -d | sed 's/AUTO_INCREMENT=[0-9]*\s*//g' > /mini_gate.sql"
docker exec -i $CONTAINER_NAME /bin/bash -c "mysqldump -uroot -pmy123456 -P3306 mini_gate mg_request mg_service mg_token -t | sed 's/AUTO_INCREMENT=[0-9]*\s*//g' >> /mini_gate.sql"

dataBakDir=data_bak_mys
mkdir $dataBakDir
#echo $dataBakDir
echo '备份完成。正在复制'
docker cp $CONTAINER_NAME:/fast_dfs.sql ./$dataBakDir/
docker cp $CONTAINER_NAME:/xxl_job.sql ./$dataBakDir/
docker cp $CONTAINER_NAME:/mini_gate.sql ./$dataBakDir/
echo '备份完成。完成复制'