-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: localhost    Database: mini_gate
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `JOB_EXECUTION_LOG`
--

DROP TABLE IF EXISTS `JOB_EXECUTION_LOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `JOB_EXECUTION_LOG` (
  `id` varchar(40) NOT NULL,
  `job_name` varchar(100) NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `hostname` varchar(255) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `sharding_item` int(11) NOT NULL,
  `execution_source` varchar(20) NOT NULL,
  `failure_cause` varchar(4000) DEFAULT NULL,
  `is_success` int(11) NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `complete_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `JOB_STATUS_TRACE_LOG`
--

DROP TABLE IF EXISTS `JOB_STATUS_TRACE_LOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `JOB_STATUS_TRACE_LOG` (
  `id` varchar(40) NOT NULL,
  `job_name` varchar(100) NOT NULL,
  `original_task_id` varchar(255) NOT NULL,
  `task_id` varchar(255) NOT NULL,
  `slave_id` varchar(50) NOT NULL,
  `source` varchar(50) NOT NULL,
  `execution_type` varchar(20) NOT NULL,
  `sharding_item` varchar(100) NOT NULL,
  `state` varchar(20) NOT NULL,
  `message` varchar(4000) DEFAULT NULL,
  `creation_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `TASK_ID_STATE_INDEX` (`task_id`,`state`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exchange_rel_queue`
--

DROP TABLE IF EXISTS `exchange_rel_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exchange_rel_queue` (
  `ex_id` int(11) DEFAULT NULL,
  `que_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mg_exchange`
--

DROP TABLE IF EXISTS `mg_exchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_exchange` (
  `ex_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'exchang id',
  `ex_name` varchar(50) DEFAULT NULL COMMENT '交换机名',
  `ex_descr` varchar(255) DEFAULT NULL COMMENT '描述',
  `ex_type` varchar(50) DEFAULT NULL COMMENT '交换机类型',
  PRIMARY KEY (`ex_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mg_queue`
--

DROP TABLE IF EXISTS `mg_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_queue` (
  `que_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '交换机id',
  `queue_name` varchar(50) DEFAULT NULL COMMENT '队列名',
  `queue_descr` varchar(255) DEFAULT NULL COMMENT '队列描述',
  PRIMARY KEY (`que_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='队列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mg_request`
--

DROP TABLE IF EXISTS `mg_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_request` (
  `id` int(11) NOT NULL,
  `request_id` int(11) DEFAULT NULL COMMENT '请求id',
  `request_name` varchar(255) DEFAULT NULL COMMENT '请求name',
  `request_method` varchar(25) DEFAULT NULL COMMENT '请求method',
  `request_url` varchar(255) DEFAULT NULL COMMENT '请求url',
  `request_verison` varchar(25) DEFAULT NULL COMMENT '请求version',
  `transmit_url` varchar(255) DEFAULT NULL COMMENT '转发url',
  `server_id` int(11) DEFAULT NULL COMMENT '服务id',
  `server_name` varchar(255) DEFAULT NULL COMMENT '服务name',
  `server_url` varchar(255) DEFAULT NULL COMMENT '服务url',
  `server_status` int(11) DEFAULT NULL COMMENT '微服务状态 1.可用  0.不可用',
  `is_admin` int(11) DEFAULT NULL COMMENT '管理员可用。 1可用。 0 不可用',
  `is_user` int(11) DEFAULT NULL COMMENT '用户是否可用。 1可用。 0不可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mg_request_log`
--

DROP TABLE IF EXISTS `mg_request_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_request_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `service_id` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '服务id',
  `request_url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '请求url',
  `request_version` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '请求版本',
  `request_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '请求时间',
  `request_ip` varchar(25) CHARACTER SET utf8 DEFAULT NULL COMMENT '请求ip地址',
  `transmit_url` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '转发url',
  `request_method` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '请求方法',
  `user_agent` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '浏览器',
  `request_content` text CHARACTER SET utf8 COMMENT '请求内容',
  `response_content` longtext COMMENT '返回内容',
  `response_time` timestamp NULL DEFAULT NULL COMMENT '响应时间',
  `execute_time` mediumtext CHARACTER SET utf8 COMMENT '执行时间',
  `need_token` int(11) DEFAULT NULL COMMENT '是否需要token 1.需要 0.不需',
  `verify_token` int(11) DEFAULT NULL COMMENT '1：校验成功  0：校验不成功',
  `mic_serv_status_code` int(11) DEFAULT NULL COMMENT '微服务状态码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mg_service`
--

DROP TABLE IF EXISTS `mg_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '服务名称',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '服务路由地址',
  `is_online` int(11) DEFAULT NULL COMMENT '是否在线 1.在线 0：否',
  `version` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '服务版本号',
  `service_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微服务名称',
  `retryable` tinyint(1) DEFAULT NULL COMMENT '是否重试 1:是 0：否',
  `strip_prefix` tinyint(1) DEFAULT NULL COMMENT '是否去前缀 1:是 0：否',
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '路由地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mg_token`
--

DROP TABLE IF EXISTS `mg_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mg_token` (
  `id` int(11) NOT NULL COMMENT '序号',
  `request_id` int(11) DEFAULT NULL COMMENT '外部请求的id',
  `server_id` int(11) DEFAULT NULL COMMENT '微服务id',
  `need_token` int(11) DEFAULT NULL COMMENT '是否需要token 1 : 需要 0: 不需要',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='token表，记录需要token才可访问的服务';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `request_join_token`
--

DROP TABLE IF EXISTS `request_join_token`;
/*!50001 DROP VIEW IF EXISTS `request_join_token`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `request_join_token` AS SELECT 
 1 AS `id`,
 1 AS `request_id`,
 1 AS `request_name`,
 1 AS `request_method`,
 1 AS `request_url`,
 1 AS `request_verison`,
 1 AS `transmit_url`,
 1 AS `server_id`,
 1 AS `server_name`,
 1 AS `server_url`,
 1 AS `server_status`,
 1 AS `is_admin`,
 1 AS `is_user`,
 1 AS `need_token`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `zipkin_annotations`
--

DROP TABLE IF EXISTS `zipkin_annotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zipkin_annotations` (
  `trace_id_high` bigint(20) NOT NULL DEFAULT '0' COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
  `trace_id` bigint(20) NOT NULL COMMENT 'coincides with zipkin_spans.trace_id',
  `span_id` bigint(20) NOT NULL COMMENT 'coincides with zipkin_spans.id',
  `a_key` varchar(255) NOT NULL COMMENT 'BinaryAnnotation.key or Annotation.value if type == -1',
  `a_value` blob COMMENT 'BinaryAnnotation.value(), which must be smaller than 64KB',
  `a_type` int(11) NOT NULL COMMENT 'BinaryAnnotation.type() or -1 if Annotation',
  `a_timestamp` bigint(20) DEFAULT NULL COMMENT 'Used to implement TTL; Annotation.timestamp or zipkin_spans.timestamp',
  `endpoint_ipv4` int(11) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_ipv6` binary(16) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null, or no IPv6 address',
  `endpoint_port` smallint(6) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
  `endpoint_service_name` varchar(255) DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zipkin_dependencies`
--

DROP TABLE IF EXISTS `zipkin_dependencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zipkin_dependencies` (
  `day` date NOT NULL,
  `parent` varchar(255) NOT NULL,
  `child` varchar(255) NOT NULL,
  `call_count` bigint(20) DEFAULT NULL,
  `error_count` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `zipkin_spans`
--

DROP TABLE IF EXISTS `zipkin_spans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zipkin_spans` (
  `trace_id_high` bigint(20) NOT NULL DEFAULT '0' COMMENT 'If non zero, this means the trace uses 128 bit traceIds instead of 64 bit',
  `trace_id` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `debug` bit(1) DEFAULT NULL,
  `start_ts` bigint(20) DEFAULT NULL COMMENT 'Span.timestamp(): epoch micros used for endTs query and to implement TTL',
  `duration` bigint(20) DEFAULT NULL COMMENT 'Span.duration(): micros used for minDuration and maxDuration query'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `request_join_token`
--

/*!50001 DROP VIEW IF EXISTS `request_join_token`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `request_join_token` AS select `t1`.`id` AS `id`,`t1`.`request_id` AS `request_id`,`t1`.`request_name` AS `request_name`,`t1`.`request_method` AS `request_method`,`t1`.`request_url` AS `request_url`,`t1`.`request_verison` AS `request_verison`,`t1`.`transmit_url` AS `transmit_url`,`t1`.`server_id` AS `server_id`,`t1`.`server_name` AS `server_name`,`t1`.`server_url` AS `server_url`,`t1`.`server_status` AS `server_status`,`t1`.`is_admin` AS `is_admin`,`t1`.`is_user` AS `is_user`,`t2`.`need_token` AS `need_token` from (`mg_request` `t1` left join `mg_token` `t2` on(((`t1`.`request_id` = `t2`.`request_id`) and (`t1`.`server_id` = `t2`.`server_id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-20 11:52:28
-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: localhost    Database: mini_gate
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `mg_request`
--

LOCK TABLES `mg_request` WRITE;
/*!40000 ALTER TABLE `mg_request` DISABLE KEYS */;
INSERT INTO `mg_request` VALUES (2,2,'微服务','','/mini-vms/demo/test','0.1','http://192.168.2.248:8080/video-api/query/camera/info.json',2,'mini-vam','',1,NULL,NULL),(3,3,'微服务-无注册',NULL,'/vms2Server/vms2/test1','0.1','http://fuck123',3,'vsm2',NULL,1,NULL,NULL),(4,4,'微服务2',NULL,'/mini-user-service/demo/test','0.1','',5,'mini-user-service',NULL,1,NULL,NULL),(5,5,'刷新令牌',NULL,'/mini-auth/jwt/refresh','0.1',NULL,5,'mini-auth',NULL,1,NULL,NULL),(6,6,'令牌获取当前用户信息',NULL,'/mini-user-service/user/info','0.1',NULL,5,'mini-user-service',NULL,1,NULL,NULL),(7,7,'获取当前用户菜单列表',NULL,'/mini-user-service/menu/userMenu','0.1',NULL,5,'mini-user-service',NULL,1,NULL,NULL),(8,8,'查询菜单的详细信息',NULL,'/mini-user-service/menu/mini_user','0.1',NULL,5,'mini-user-service',NULL,1,NULL,NULL),(9,9,'返回树形菜单集合',NULL,'/mini-user-service/menu/allTree','0.1',NULL,5,'mini-user-service',NULL,1,NULL,NULL),(10,10,'角色的菜单集合',NULL,'/mini-user-service/menu/roleTree/admin','0.1',NULL,5,'mini-user-service',NULL,1,NULL,NULL),(11,11,'分配角色菜单',NULL,'/mini-user-service/roleMenuUpd','0.1',NULL,5,'mini-user-service',NULL,1,NULL,NULL),(12,12,'上传文件',NULL,'/mini-user-service/upload','0.1',NULL,NULL,'mini-user-service',NULL,1,NULL,NULL),(101,101,'普通用户登录','POST','/mini-auth/jwt/user/token','0.1','http://192.168.2.248:8080/video-api/query/camera/list.json',1,'mini-auth','',1,1,1),(102,102,'用户注销','GET','/mini-auth/jwt/logout','0.1',NULL,1,'mini-auth',NULL,1,1,1),(103,103,'获取用户信息','POST','/mini-user-service/admin/user/info','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(104,104,'刷新令牌','GET','/mini-auth/jwt/refresh','0.1',NULL,1,'mini-auth',NULL,1,1,1),(201,201,'获取当前用户信息','GET','/mini-user-service/admin/user/{id}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(202,202,'删除用户','DELETE','/mini-user-service/admin/user/{id}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(203,203,'增加用户','POST','/mini-user-service/admin/user','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(204,204,'更新用户信息','PUT','/mini-user-service/admin/user','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(205,205,'查询用户及其角色信息','GET','/mini-user-service/admin/user/findUserRoleByUsername/{username}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(206,206,'分页查询所有用户','POST','/mini-user-service/admin/user/userPage','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(207,207,'上传用户头像','POST','/mini-user-service/admin/user/upload','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(208,208,'批量删除用户','DELETE','/mini-user-service/admin/user/list','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(209,209,'用户-模糊查询用户(分页)','POST','/mini-user-service/admin/user/userPage/fuzzy','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(210,210,'用户信息导出表格','GET','/mini-user-service/admin/user/export','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(211,211,'操作日志添加','POST','/mini-user-service/opear/log','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(212,212,'操作日志浏览','POST','/mini-user-service/opear/log/logPage','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(213,213,'操作日志删除','DELETE','/mini-user-service/opear/log/{id}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(214,214,'批量删除操作日志','DELETE','/mini-user-service/opear/log/delete/{ids}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(215,215,'操作日志详情','GET','/mini-user-service/opear/log/{id}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(216,216,'运行日志浏览','POST','/restAPI/mini-gate-service/mgLogPage','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(217,217,'运行日志批量删除','DELETE','/restAPI/mini-gate-service/deleteMgLogList/{ids}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(218,218,'运行日志导出','POST','/restAPI/mini-gate-service/exportMgLog','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(219,219,'运行日志详情','GET','/restAPI/mini-gate-service/info/{id}','0.1','',5,'mini-user-service','',1,1,1),(220,220,'运行日志删除','DELETE','/restAPI/mini-gate-service/deleteMgLog/{id}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(222,222,'添加配置信息','POST','/mini-user-service/server','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(223,223,'更新配置信息','PUT','/mini-user-service/server','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(224,224,'配置信息分页查询','POST','/mini-user-service/server/serverPage','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(225,225,'删除配置信息','DELETE','/mini-user-service/server/{id}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(226,226,'批量删除配置信息','DELETE','/mini-user-service/server/delete/{ids}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(227,227,'配置信息详情','GET','/mini-user-service/server/{id}','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(301,301,'导入标签CSV','POST','/mini-label-service/label/batch/upload','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(302,302,'查询所有的综合体','POST','/mini-label-service/build/alllist','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(303,303,'分页查询综合体','POST','/mini-label-service/build/buildPage','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(304,304,'导入前端设备CSV','POST','/mini-label-service/camera/batch/upload','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(305,305,'查询相机列表','POST','/mini-label-service/camera/list','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(306,306,'查询附近相机','POST','/mini-label-service/camera/near/list','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(307,307,'分页查询前端设备','POST','/mini-label-service/camera/cameraPage','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(312,312,'查询前端设备树形结构','POST','/mini-label-service/camera/tree','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(313,313,'添加综合体','POST','/mini-label-service/build','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(314,314,'更新综合体','PUT','/mini-label-service/build','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(315,315,'删除综合体','DELETE','/mini-label-service/build/{id}','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(316,316,'BIM分页浏览','POST','/mini-label-service/model/list',NULL,NULL,7,'mini-label-service',NULL,1,1,1),(317,317,'BIM详情','POST','/mini-label-service/model/info',NULL,NULL,7,'mini-label-service',NULL,1,1,1),(318,318,'bim新增','POST','/mini-label-service/model',NULL,NULL,7,'mini-label-service',NULL,1,1,1),(319,319,'BIM删除','DELETE','/mini-label-service/model/{id}',NULL,NULL,7,'mini-label-service',NULL,1,1,1),(320,320,'楼栋查询BIM楼层信息','POST','/mini-label-service/model/selectlist','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(321,321,'bim修改','PUT','/mini-label-service/model',NULL,NULL,7,'mini-label-service',NULL,1,1,1),(322,322,'查询图层列表','POST','/mini-label-service/label/list','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(323,323,'查询标签详情','GET','/mini-label-service/label/{id}','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(324,324,'查询图层类型列表','POST','/mini-label-service/label/type/list','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(325,325,'视频收藏-增加','POST','/mini-label-service/camera/favorites','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(326,326,'视频收藏-删除','DELETE','/mini-label-service/camera/favorites','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(327,327,'视频收藏-查询列表','GET','/mini-label-service/camera/favorites/tree','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(328,328,'导出标签','GET','/mini-label-service/label/export/{id}','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(329,329,'添加前端设备','POST','/mini-label-service/camera','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(330,330,'更新前端设备','PUT','/mini-label-service/camera','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(331,331,'删除前端设备','DELETE','/mini-label-service/camera/{id}','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(332,332,'批量删除前端设备','DELETE','/mini-label-service/camera/delete/{ids}','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(333,333,'导出所有前端设备','GET','/mini-label-service/camera/export','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(334,334,'图层搜索','POST','/mini-label-service/label/search','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(335,335,'视频搜索','POST','/mini-label-service/camera/search','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(336,336,'查询相机详情','GET','/mini-label-service/camera/detail/{id}','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(337,337,'查询多个相机详情','POST','/mini-label-service/camera/multi/detail','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(338,338,'添加视频标注','POST','/mini-label-service/video/tag','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(339,339,'视频标注查询','POST','/mini-label-service/video/tag/query','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(340,340,'Bim文件批量删除','POST','/mini-label-service/model/deleteModelList','0.1',NULL,7,'mini-label-service',NULL,1,1,1),(341,341,'摄像头收藏 - 查询用户收藏视频列表','GET','/mini-label-service/camera/collect/tree','0.1','',7,'mini-label-service','',1,1,1),(342,342,'摄像头收藏 - 添加摄像头收藏','POST','/mini-label-service/camera/collect/add','0.1','',7,'mini-label-service','',1,1,1),(343,343,'摄像头收藏 - 删除摄像头收藏','DELETE','/mini-label-service/camera/collect/delete','0.1','',7,'mini-label-service','',1,1,1),(344,344,'摄像头收藏 - 查询用户收藏夹列表','GET','/mini-label-service/camera/collect/group','0.1','',7,'mini-label-service','',1,1,1),(345,345,'摄像头收藏 - 创建收藏夹','POST','/mini-label-service/camera/collect/group/create','0.1','',7,'mini-label-service','',1,1,1),(346,346,'摄像头收藏 - 删除收藏夹','DELETE','/mini-label-service/camera/collect/group/delete','0.1','',7,'mini-label-service','',1,1,1),(347,347,'摄像头收藏 - 修改收藏夹','POST','/mini-label-service/camera/collect/group/update','0.1','',7,'mini-label-service','',1,1,1),(401,401,'布控- 分页查询所有布控','POST','/mini-event-service/control/pageList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(402,402,'布控- 查询安全布控详情','GET','/mini-event-service/control/detail/{id}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(403,403,'布控- 修改布控状态','PUT','/mini-event-service/control/status','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(404,404,'布控- 增加图像布控 人脸/行人','POST','/mini-event-service/control/image','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(405,405,'布控- 修改图像布控 人脸/行人','PUT','/mini-event-service/control/image','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(406,406,'布控- 增加结构化布控 人脸/行人','POST','/mini-event-service/control/structure','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(407,407,'布控- 修改结构化布控 人脸/行人','PUT','/mini-event-service/control/structure','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(408,408,'布控- 模糊分页查询所有布控','POST','/mini-event-service/control/pageList/fuzzy','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(411,411,'批量删除布控','DELETE','/mini-event-service/control/{ids}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(412,412,'查询历史轨迹列表','POST','/mini-event-service/video/playback','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(414,414,'查询字典信息','GET','/mini-event-service/enum/{id}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(415,415,'布控-增加关注','POST','/mini-event-service/control/favorite','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(416,416,'布控-删除关注','DELETE','/mini-event-service/control/favorite','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(417,417,'布控-查询关注的所有布控','POST','/mini-event-service/control/favorite/pageList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(418,418,'历史截图-增加','POST','/mini-event-service/capture/pic','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(419,419,'历史截图-删除','DELETE','/mini-event-service/capture/pic','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(420,420,'历史截图-查询','POST','/mini-event-service/capture/pic/pageList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(421,421,'批量删除案事件','DELETE','/mini-event-service/event/delete/{ids}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(422,422,'告警收藏-增加','GET','/mini-event-service/alarm/favorite/{ids}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(423,423,'告警收藏-删除','DELETE','/mini-event-service/alarm/favorite/{ids}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(424,424,'告警收藏-分页查询','POST','/mini-event-service/alarm/favorite/pageList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(425,425,'删除所属用户全部布控列表','DELETE','/mini-event-service/control/currentuser/deleteall','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(426,426,'获取当天产生告警的布控','GET','/mini-event-service/alarm/event','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(427,427,'查询告警-按布控分组','GET','/mini-event-service/alarm/group','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(428,428,'获取全部已启动布控','GET','/mini-event-service/control/get/controlling','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(432,432,'新增录屏数据','POST','/mini-event-service/screencap/add','0.1','',6,'mini-event-service','',1,1,1),(433,433,'分页查询历史录屏','POST','/mini-event-service/screencap/pageList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(434,434,'新增执法人员','POST','/mini-event-service/lawperson','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(435,435,'分页查询执法人员详情','POST','/mini-event-service/lawperson/pagelist','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(436,436,'查询执法人员列表','GET','/mini-event-service/lawperson/list','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(437,437,'更新执法人员','PUT','/mini-event-service/lawperson','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(438,438,'删除执法人员','DELETE','/mini-event-service/lawperson/delete/{lawId}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(439,439,'批量删除执法人员','DELETE','/mini-event-service/lawperson/delete/lawIdList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(440,440,'新增执法人员','POST','/mini-event-service/emergencyplan','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(441,441,'更新执法人员','PUT','/mini-event-service/emergencyplan','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(442,442,'获取应急预案详情','GET','/mini-event-service/emergencyplan/{id}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(443,443,'分页查询应急预案','POST','/mini-event-service/emergencyplan/pagelist','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(444,444,'批量删除应急预案','DELETE','/mini-event-service/emergencyplan/delete/idList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(445,445,'查询单个执法人员详情','GET','/mini-event-service/lawperson/{lawId}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(501,501,'案事件创建','POST','/mini-event-service/event','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(502,502,'案事件分页查询','POST','/mini-event-service/event/eventPage','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(503,503,'案事件详情','GET','/mini-event-service/event/{id}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(505,505,'案事件更新','PUT','/mini-event-service/event','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(506,506,'案事件删除','DELETE','/mini-event-service/event/{id}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(507,507,'查看布控详情','GET','/mini-event-service/alarm/detail/{id}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(508,508,'查看告警','POST','/mini-event-service/alarm/pageList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(510,510,'布控回放-增加','POST','/mini-event-service/control/callBack/copy','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(511,511,'布控回放-分页查看','POST','/mini-event-service/control/callBack/pageList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(1101,1101,'流媒体-查询设备信息','GET','/media-service/api/media/v02/device/list','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1102,1102,'流媒体-查询设备详细信息','GET','/media-service/api/media/v02/device/info','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1103,1103,'流媒体-查询全部可用摄像头','GET','/media-service/api/media/v02/channel/all','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1104,1104,'流媒体-实时视频点播','GET','/media-service/api/media/v02/stream/start','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1105,1105,'流媒体-实时视频停止','GET','/media-service/api/media/v02/stream/stop','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1106,1106,'流媒体-实时直播列表','GET','/media-service/api/media/v02/stream/list','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1107,1107,'流媒体-录像查询','GET','/media-service/api/media/v02/record/info','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1108,1108,'流媒体-开始回放','GET','/media-service/api/media/v02/playback/start','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1109,1109,'流媒体-结束回放','GET','/media-service/api/media/v02/playback/stop','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1110,1110,'流媒体-回放控制','GET','/media-service/api/media/v02/playback/control','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1111,1111,'流媒体-录像下载','GET','/media-service/api/media/v02/playback/download','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1113,1113,'流媒体-通道截图','GET','/media-service/api/media/v02/channelsnap','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1114,1114,'流媒体-多段回放','GET','/media-service/api/media/v02/playback/split','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1115,1115,'流媒体-多选摄像头直播','POST','/media-service/api/media/v02/stream/multi','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1116,1116,'流媒体-停止分段回放','GET','/media-service/api/media/v02/playback/split/stop','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1117,1117,'流媒体-停止全部实时直播','GET','/media-service/api/media/v02/all/stream/stop','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1118,1118,'流媒体-下载录像文件','POST','/media-service/api/media/v04/simulation/download','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1119,1119,'流媒体-查询录像文件','GET','/media-service/api/media/v04/simulation/query','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1120,1120,'流媒体-删除录像文件','GET','/media-service/api/media/v04/simulation/delete','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1121,1121,'流媒体-开始推送录像文件','GET','/media-service/api/media/v04/stream/simulation/start','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1122,1122,'流媒体-停止推送录像文件','GET','/media-service/api/media/v04/stream/simulation/stop','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1123,1123,'流媒体-回放/下载信息查询','GET','/media-service/api/media/v04/playback/download/information','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1124,1124,'流媒体-检查可用性','GET','/media-service/api/media/v04/camera/check/number','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1125,1125,'流媒体-控制云台转动','GET','/media-service/api/media/v05/ptz/control','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1126,1126,'流媒体-预置点的控制','GET','/media-service/api/media/v05/preset/control','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1127,1127,'流媒体-焦点和光圈控制','GET','/media-service/api/media/v05/fi/control','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1128,1128,'流媒体-放大指定区域画面','GET','/media-service/api/media/v05/dragzoomin/control','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1129,1129,'流媒体-缩小指定区域画面','GET','/media-service/api/media/v05/dragzoomout/control','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1130,1130,'流媒体高级控制-加载json','GET','/media-service/api/media/v05/sdk/load/sdkjson','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1131,1131,'流媒体高级控制-链接状态查询','GET','/media-service/api/media/v05/sdk/connection/state','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1132,1132,'流媒体高级控制-登录','GET','/media-service/api/media/v05/sdk/login','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1133,1133,'流媒体高级控制-退出','GET','/media-service/api/media/v05/sdk/logout','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1134,1134,'流媒体高级控制-退出','GET','/media-service/api/media/v05/sdk/basic/control','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1135,1135,'流媒体高级控制-精确控制球机转动','GET','/media-service/api/media/v05/sdk/exact/goto','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1136,1136,'流媒体高级控制-云台状态查询','GET','/media-service/api/media/v05/sdk/query/location','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1137,1137,'流媒体-拉取视频缩略图','GET','/media-service/api/media/v1/channel/capture','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1138,1138,'流媒体-控制球机','GET','/media-service/api/media/v05/sdk/fast/goto','0.1',NULL,101,'out-media-service',NULL,1,1,1),(1201,1201,'视频分析集成框架-图片人脸人体检测','POST','/video-analysis-service/verify/facebody/detectAndQuality','0.1',NULL,102,'out-video-analysis',NULL,1,1,1),(1202,1202,'视频分析集成框架-新增图片','POST','/video-analysis-service/Task/AddImage','0.1',NULL,102,'out-video-analysis',NULL,1,1,1),(1203,1203,'视频分析集成框架-查询resouce','GET','/video-analysis-service/Task/QueryResource','0.1',NULL,102,'out-video-analysis',NULL,1,1,1),(1204,1204,'视频分析集成框架-启动人流统计','GET','/video-analysis-service/Mall/Server/HeadCount/Start','0.1',NULL,102,'out-video-analysis',NULL,1,1,1),(1205,1205,'视频分析集成框架-停止人流统计','GET','/video-analysis-service/Mall/Server/HeadCount/Stop','0.1',NULL,102,'out-video-analysis',NULL,1,1,1),(1206,1206,'视频分析集成框架-球机联动','POST','/video-analysis-service/Mall/CameraLinkage','0.1',NULL,102,'out-video-analysis',NULL,1,1,1),(1207,1207,'视频分析集成框架-球机状态查询','GET','/video-analysis-service/Mall/QueryWorkStatus','0.1',NULL,102,'out-video-analysis',NULL,1,1,1),(1208,1208,'视频分析集成框架-检测图片人脸框','POST','/video-analysis-service/Mall/Face/Detect','0.1',NULL,102,'out-video-analysis',NULL,1,1,1),(1301,1301,'视觉定位-根据相机ID','POST','/vision-localization-back/v1/loc/zhang/ID/locationBody','0.1',NULL,103,'vision-localization-back',NULL,1,1,1),(1302,1302,'视觉定位-根据相机Name','POST','/vision-localization-back/v1/loc/zhang/Name/locationBody','0.1',NULL,103,'vision-localization-back',NULL,1,1,1),(1303,1303,'视觉定位-球机定位','POST','/vision-localization-back/v1/outdoorLoc/ID/locationPTZ','0.1',NULL,103,'vision-localization-back',NULL,1,1,1),(1900,1900,'消息订阅- (弃用 暂时保留)','POST','/mini-user-service/mq/subscribe','0.1',NULL,5,'mini-user-service',NULL,1,1,1),(9999,9999,'全局查找','GET','/mini-event-service/search','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(99991,99991,'行人轨迹追踪 - 查询目标此前一段时间内全部轨迹','POST','/mini-event-service/person/trail','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(99992,99992,'行人数据查询 - 通过行人id获取行人详情','GET','/mini-event-service/person/detail/{personId}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(99993,99993,'行人数据查询 - 获取全部person详情','POST','/mini-event-service/person/all','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(99994,99994,'行人轨迹追踪 - 获取当前展厅总人数','GET','/mini-event-service/person/trail/current/all','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(99995,99995,'行人轨迹追踪 - 获取统计信息','GET','/mini-event-service/person/trail/current/statistics','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(99996,99996,'行人潮汐图-查询历史行人轨迹点','GET','/mini-event-service/person/tidalFigure/{timeStamp}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(99997,99997,'行人类型-更改','POST','/mini-event-service/person/changeType','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(99998,99998,'行人关注','GET','/mini-event-service/person/setFocus/{id}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(99999,99999,'行人关注-取消','GET','/mini-event-service/person/cancelFocus','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100000,100000,'查询展品在摄像头中位置','POST','/mini-label-service/label/exhibits/camera','0.1','',7,'mini-label-service','',1,1,1),(100001,100001,'查询摄像头在摄像头中位置','POST','/mini-label-service/camera/pixel/camera','0.1','',7,'mini-label-service','',1,1,1),(100011,100011,'获取全部任务单信息','GET','/mini-event-service/task/ticket/all','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100012,100012,'分页查询任务单信息','POST','/mini-event-service/task/ticket/pageList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100013,100013,'创建并且分发人员调度任务单','POST','/mini-event-service/task/ticket/create/personnel','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100014,100014,'取消任务单','POST','/mini-event-service/task/task/ticket/cancel','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100015,100015,'批量取消个人人员调度任务单','POST','/mini-event-service/task/ticket/cancel/person/personnel','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100016,100016,'通过任务id查询任务单信息','POST','/mini-event-service/task/ticket/pageList','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100017,100017,'创建并且分发保洁任务单','POST','/mini-event-service/PushCleaningOrderInfo','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100018,100018,'取消清洁调度任务单','POST','/mini-event-service/task/ticket/cancel/clean','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100019,100019,'获取全部厕所/清洁对象信息','GET','/mini-event-service/restroom/all','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100020,100020,'获取全部厕所/清洁对象状态','POST','/mini-event-service/restroom/status','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100021,100021,'添加人脸信息','POST','/mini-event-service/person/face/add','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100022,100022,'获取全部人脸信息','GET','/mini-event-service/person/face/all','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100023,100023,'通过id查询人脸信息','GET','/mini-event-service/person/face/{personFaceId}','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100024,100024,'分页查询人脸信息','POST','/mini-event-service/person/face/page','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100025,100025,'更新修改人脸数据','POST','/mini-event-service/person/face/update','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100026,100026,'通过id删除人脸信息','POST','/mini-event-service/person/face/delete','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100027,100027,'接收视频分析人脸告警信息','POST','/mini-event-service/upload/person/face/alarm','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100028,100028,'更新人员调度任务路径规划截图','POST','/mini-event-service/task/ticket/update/personnel/grideRouteUrl','0.1',NULL,6,'mini-event-service',NULL,1,1,1),(100029,100029,'7.7.批量取消人员调度任务单','POST','/mini-event-service/task/ticket/cancel/personnel','0.1',NULL,6,'mini-event-service',NULL,1,1,1);
/*!40000 ALTER TABLE `mg_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `mg_service`
--

LOCK TABLES `mg_service` WRITE;
/*!40000 ALTER TABLE `mg_service` DISABLE KEYS */;
INSERT INTO `mg_service` VALUES (1,'auth','/mini-auth/**',1,'V0.1','mini-auth',1,1,NULL),(2,'mini-vms','/mini-vms/**',1,'V0.1','mini-vms',1,1,NULL),(5,'mini-user-service','/mini-user-service/**',1,'V0.1','mini-user-service',1,1,NULL),(6,'mini-event-service','/mini-event-service/**',1,'V0.1','mini-event-service',1,1,NULL),(7,'mini-label-service','/mini-label-service/**',1,'V0.1','mini-label-service',1,1,NULL),(101,'media-service','/media-service/**',1,'V0.1','media-service',1,1,''),(102,'video-analysis-service','/video-analysis-service/**',1,'V0.1','video-analysis-service',1,1,''),(103,'vision-localization-back','/vision-localization-back/**',1,'V0.1','vision-localization-back',1,1,'');
/*!40000 ALTER TABLE `mg_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `mg_token`
--

LOCK TABLES `mg_token` WRITE;
/*!40000 ALTER TABLE `mg_token` DISABLE KEYS */;
INSERT INTO `mg_token` VALUES (101,101,1,0),(102,102,1,1),(103,103,5,1),(104,104,1,0),(201,201,5,1),(202,202,5,1),(203,203,5,1),(204,204,5,1),(205,205,5,1),(206,206,5,1),(207,207,5,1),(208,208,5,1),(209,209,5,1),(210,210,5,0),(211,211,5,1),(212,212,5,1),(214,214,5,1),(215,215,5,1),(216,216,5,1),(217,217,5,1),(218,218,5,1),(219,219,5,1),(220,220,5,1),(222,222,5,1),(223,223,5,1),(224,224,5,1),(227,227,5,1),(302,302,7,1),(303,303,7,1),(304,304,7,1),(305,305,7,1),(307,307,7,1),(312,312,7,1),(313,313,7,1),(314,314,7,1),(315,315,7,1),(316,316,7,1),(317,317,7,1),(318,318,7,1),(319,319,7,1),(320,320,7,1),(321,321,7,1),(322,322,7,1),(323,323,7,1),(324,324,7,1),(325,325,7,1),(326,326,7,1),(327,327,7,1),(328,328,7,0),(329,329,7,1),(330,330,7,1),(331,331,7,1),(332,332,7,1),(333,333,7,0),(334,334,7,1),(335,335,7,1),(336,336,7,1),(337,337,7,1),(338,338,7,1),(339,339,7,1),(340,340,7,1),(341,341,7,1),(342,342,7,1),(343,343,7,1),(344,344,7,1),(345,345,7,1),(346,346,7,1),(347,347,7,1),(401,401,6,1),(402,402,6,1),(403,403,6,1),(404,404,6,1),(405,405,6,1),(406,406,6,1),(407,407,6,1),(408,408,6,1),(412,412,6,1),(414,414,6,1),(415,415,6,1),(416,416,6,1),(417,417,6,1),(418,418,6,1),(419,419,6,1),(420,420,6,1),(421,421,6,1),(425,425,6,1),(426,426,6,1),(427,427,6,1),(428,428,6,0),(432,432,6,1),(433,433,6,1),(434,434,6,1),(435,435,6,1),(437,437,6,1),(438,438,6,1),(439,439,6,1),(440,440,6,1),(441,441,6,1),(443,443,6,1),(444,444,6,1),(501,501,6,1),(502,502,6,1),(505,505,6,1),(506,506,6,1),(507,507,6,1),(508,508,6,1),(509,509,6,1),(510,510,6,1),(511,511,6,1),(1101,1101,101,1),(1102,1102,101,1),(1103,1103,101,1),(1104,1104,101,1),(1105,1105,101,1),(1106,1106,101,1),(1107,1107,101,1),(1108,1108,101,1),(1109,1109,101,1),(1110,1110,101,1),(1111,1111,101,1),(1112,1112,101,1),(1113,1113,101,1),(1114,1114,101,1),(1115,1115,101,1),(1116,1116,101,1),(1117,1117,101,1),(1124,1124,101,1),(1125,1125,101,1),(1126,1126,101,1),(1127,1127,101,1),(1128,1128,101,1),(1129,1129,101,1),(1130,1130,101,1),(1131,1131,101,1),(1132,1132,101,1),(1133,1133,101,1),(1134,1134,101,1),(1135,1135,101,1),(1136,1136,101,1),(1201,1201,102,0),(1202,1202,102,0),(1203,1203,102,0),(1204,1204,102,0),(1205,1205,102,1),(1206,1206,102,1),(1207,1207,102,1),(1301,1301,103,1),(9999,9999,6,1),(99991,99991,6,1),(99992,99992,6,1),(99993,99993,6,1),(99994,99994,6,1),(99995,99995,6,0),(100000,100000,7,0),(100011,100011,6,1),(100012,100012,6,1),(100013,100013,6,1),(100014,100014,6,1),(100015,100015,6,1),(100016,100016,6,1),(100017,100017,6,1),(100018,100018,6,1),(100019,100019,6,1),(100020,100020,6,1),(100021,100021,6,1),(100022,100022,6,1),(100023,100023,6,1),(100024,100024,6,1),(100025,100025,6,1),(100026,100026,6,1),(100027,100027,6,1),(100028,100028,6,1),(100029,100029,6,1);
/*!40000 ALTER TABLE `mg_token` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-20 11:52:28
