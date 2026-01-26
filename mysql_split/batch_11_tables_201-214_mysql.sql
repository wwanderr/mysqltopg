/*
 Navicat Premium Dump SQL

 Source Server         : 192.168.31.173
 Source Server Type    : MySQL
 Source Server Version : 50743 (5.7.43-log)
 Source Host           : 192.168.31.173:43306
 Source Schema         : bigdata-web-test

 Target Server Type    : MySQL
 Target Server Version : 50743 (5.7.43-log)
 File Encoding         : 65001

 Date: 13/01/2026 19:00:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ----------------------------
-- Table structure for t_waf
-- ----------------------------
DROP TABLE IF EXISTS `t_waf`;
CREATE TABLE `t_waf`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'waf地址',
  `port` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口开放端口',
  `status` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UNIQUE_IP_PORT`(`ip`, `port`) USING BTREE COMMENT 'ip、port唯一性索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_waf
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_waf_block
-- ----------------------------
DROP TABLE IF EXISTS `t_waf_block`;
CREATE TABLE `t_waf_block`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `srcAddress` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `waf_ips` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '同步到waf的设备ip',
  `uuids` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(1) NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `src_address_UNIQUE`(`srcAddress`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_waf_block
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_web_asset
-- ----------------------------
DROP TABLE IF EXISTS `t_web_asset`;
CREATE TABLE `t_web_asset`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `web` int(11) NULL DEFAULT NULL,
  `asset` int(11) NULL DEFAULT NULL,
  `type` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产关联类型',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `IDX_WEB`(`web`) USING BTREE,
  INDEX `IDX_ASSET`(`asset`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_web_asset
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_web_info
-- ----------------------------
DROP TABLE IF EXISTS `t_web_info`;
CREATE TABLE `t_web_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `destHostName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '域名',
  `webName` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统名称',
  `type` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'Web业务系统' COMMENT '系统类型',
  `importance` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统重要性',
  `tag` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统标签',
  `personInCharge` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '责任人',
  `developer` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '开发商',
  `visitAddress` int(11) NULL DEFAULT 1 COMMENT '访问地址状态：0关闭，1开启。',
  `visitAddressValue` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '访问地址',
  `osVersion` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统版本',
  `technologyArc` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '技术架构',
  `serverComponentVersion` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '服务组件版本',
  `webContainnerName` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'Web容器名称',
  `webContainnerVersion` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'Web容器版本',
  `systemNo` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统编号',
  `systemStats` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统状态',
  `organisation` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '组织架构',
  `webUser` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '使用人',
  `confidentiality` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'C-机密性',
  `integrity` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'I-完整性',
  `availability` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'A-可用性',
  `isHierarchyProtection` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '是否等保',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '描述',
  `netrafficMonitor` int(11) NULL DEFAULT 1 COMMENT '流量监控；0关闭，1开启（默认）',
  `accessMonitor` int(11) NULL DEFAULT 0 COMMENT '访问成功率监控：0关闭，1开启',
  `accessRate` int(11) NULL DEFAULT 80 COMMENT '访问成功率',
  `location` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '地理位置',
  `accessRateValue` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0,0,0,0,0,0,0' COMMENT '访问成功率7个点',
  `visitCount` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0,0,0,0,0,0,0' COMMENT '访问次数7个点',
  `source` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '来源:0-人工录入，1-Web自动发现',
  `sHigh` int(11) NULL DEFAULT NULL,
  `sMiddle` int(11) NULL DEFAULT NULL,
  `sLow` int(11) NULL DEFAULT NULL,
  `request` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求',
  `response` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '响应',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `destHostName_UNIQUE`(`destHostName`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_web_info
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_web_sub
-- ----------------------------
DROP TABLE IF EXISTS `t_web_sub`;
CREATE TABLE `t_web_sub`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `web` int(11) NOT NULL COMMENT '域名id',
  `subDomain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '子域名',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `subDomain_UNIQUE`(`subDomain`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_web_sub
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_webscan_issuedata
-- ----------------------------
DROP TABLE IF EXISTS `t_webscan_issuedata`;
CREATE TABLE `t_webscan_issuedata`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parentid` bigint(20) NOT NULL,
  `cve` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `issue` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(11) NOT NULL,
  PRIMARY KEY (`id`, `parentid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_webscan_issuedata
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_webscan_issuetype
-- ----------------------------
DROP TABLE IF EXISTS `t_webscan_issuetype`;
CREATE TABLE `t_webscan_issuetype`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parentid` bigint(20) NOT NULL,
  `advice` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `desc` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `level` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lvl` int(10) NULL DEFAULT NULL,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cve` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(11) NOT NULL,
  `application_category` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `plugin_id` int(11) NULL DEFAULT NULL,
  `vul_id` int(11) NULL DEFAULT NULL,
  `nsfocus_id` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `port` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '端口',
  `service` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务',
  `vul_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '漏洞类型',
  `weak_pass_user` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '弱口令用戶',
  `weak_password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '弱口令',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `kb` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR windows相关 补丁名称',
  `exist` tinyint(1) NULL DEFAULT 0 COMMENT 'EDR windows相关 是否存在补丁',
  `pubdate` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR windows相关 发布时间',
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR windows相关 未修复 修复中...',
  `patch_size` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR windows相关 补丁大小',
  `app_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR linux相关 app名称',
  `app_version` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR linux相关 app版本',
  `os_version` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR linux相关 os版本',
  `edr_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR id',
  `weak_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '其他' COMMENT 'EDR Windows系统补丁还是Linux系统漏洞,默认其他',
  PRIMARY KEY (`id`, `parentid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_webscan_issuetype
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_webscan_site
-- ----------------------------
DROP TABLE IF EXISTS `t_webscan_site`;
CREATE TABLE `t_webscan_site`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parentid` int(11) NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `average_response_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `average_send_count` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `domain` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `failed_request_count` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `issuecnt` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `receive_bytes` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `recent_failed_request_count` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `request_count` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scan_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `scan_time_remain` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `send_bytes` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `server` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `site_port` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `site_progress` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `site_protocol` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `start_first_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `start_time` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `test_count` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `test_done_count` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `time` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url_count` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `visited_count` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `host_score` float(3, 1) NULL DEFAULT NULL,
  `importime` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_webscan_site
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_work_order
-- ----------------------------
DROP TABLE IF EXISTS `t_work_order`;
CREATE TABLE `t_work_order`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `serial_id` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001',
  `subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单主题',
  `tags` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '标签名称, 逗号分隔',
  `priority` enum('0','1','2') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2' COMMENT '订单优先级, 高:0,中:1,低:2',
  `assignee` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工单受理人',
  `assignee_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单受理人在t_user表中的id',
  `security_object` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全对象, 如: IP, 主机名, 服务器, 部门等',
  `security_detail` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '安全的详细描述',
  `security_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '安全的举证信息: 告警事件ID, 资产IP, 域名/URL, 攻击IP',
  `status` enum('0','1','2','3') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '订单状态, 未处理:0 ,处理中:1,已解决:2,已关闭:3',
  `approach` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '订单录入方式, 人工创建:0, 自动创建:1',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单创建人',
  `author_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单创建人在t_user表中的id',
  `assignee_comment` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '工单代理人的备注描述',
  `security_alert_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全告警id',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  `action` enum('0','1','2','3','4','5','6') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '2' COMMENT '处置动作, 请处理: 0, 请审批: 1, 请审核: 2, 请修补: 3, 请查杀: 4, 请验证: 5, 请测试: 6',
  `attach_files` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '工单附件',
  `status_modified_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '工单状态修改的时间点',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `table.hash.unique.key.serial_id`(`serial_id`) USING BTREE,
  INDEX `table.btree.key.updated_at.status`(`updated_at`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_work_order
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_work_order_operation_history
-- ----------------------------
DROP TABLE IF EXISTS `t_work_order_operation_history`;
CREATE TABLE `t_work_order_operation_history`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '表自增序列',
  `serial_id` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001',
  `operater` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单修改人',
  `operater_host_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单修改人的主机地址',
  `operater_operations` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单修改人的操作',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `action` enum('-1','0','1','2','3','4','5','6') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '-1' COMMENT '处置动作, 未知动作: -1, 请处理: 0, 请审批: 1, 请审核: 2, 请修补: 3, 请查杀: 4, 请验证: 5, 请测试: 6',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `table.hash.key.serial_id`(`serial_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_work_order_operation_history
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_work_order_status_trace
-- ----------------------------
DROP TABLE IF EXISTS `t_work_order_status_trace`;
CREATE TABLE `t_work_order_status_trace`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '数据库自增id',
  `org_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单所属组织id',
  `serial_id` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001',
  `status` enum('0','1','2','3','4') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '订单状态, 未处理:0 ,处理中:1,已解决:2,已关闭:3,已删除:4',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `table.btree.key.org_id`(`org_id`) USING BTREE,
  INDEX `table.btree.key.serial_id`(`serial_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_work_order_status_trace
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_work_order_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_work_order_tags_relation`;
CREATE TABLE `t_work_order_tags_relation`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'tag 的名字',
  `serial_id` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `table.hash.unique.key.name.serial_id`(`name`, `serial_id`) USING BTREE,
  INDEX `table.hash.unique.key.serial_id`(`serial_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_work_order_tags_relation
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_work_order_user_org_relation
-- ----------------------------
DROP TABLE IF EXISTS `t_work_order_user_org_relation`;
CREATE TABLE `t_work_order_user_org_relation`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'user的id',
  `org_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'org的id',
  `serial_id` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '获取工单编号, 15个字符的定长序列, YYMMDD + 八位数字(00000001 - 99999999), 如 19011112120001',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `table.hash.unique.key.user_id.serial_id`(`user_id`, `serial_id`) USING BTREE,
  INDEX `table.hash.unique.key.org_id.serial_id`(`org_id`, `serial_id`) USING BTREE,
  INDEX `table.hash.unique.key.serial_id`(`serial_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_work_order_user_org_relation
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for updateinfo
-- ----------------------------
DROP TABLE IF EXISTS `updateinfo`;
CREATE TABLE `updateinfo`  (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '包名',
  `version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '版本号',
  `build` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'build号',
  `userer` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新发起用户',
  `ip` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新发起IP',
  `updatetime` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改时间',
  `result` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新结果',
  `remark` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `upload_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上传方式',
  `agent_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '探针类型',
  `org` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织架构',
  `package_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '升级包类型（software、rule、intelligence）',
  `data_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据类型，upload:上传记录，upgrade:升级记录',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of updateinfo
-- ----------------------------

-- ----------------------------
-- View structure for t_sev_agent_detail_view
-- ----------------------------
DROP VIEW IF EXISTS `t_sev_agent_detail_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `t_sev_agent_detail_view` AS select `tsai`.`agent_code` AS `agentCode`,`tsai`.`single_login_uri` AS `singleLoginUri`,`tsai`.`agent_name` AS `agentName`,`tsat`.`agent_type` AS `agentType`,`tsat`.`agent_type_name` AS `agentTypeName`,`tsai`.`agent_ip` AS `agentIp`,`tsai`.`machine_code` AS `machineCode`,`to`.`orgId` AS `orgId`,`to`.`orgName` AS `orgName`,if((`tsai`.`status` = 'offline'),NULL,`tsam`.`cpu_usage`) AS `cpuUsage`,if((`tsai`.`status` = 'offline'),NULL,`tsam`.`memory_total`) AS `memoryTotal`,if((`tsai`.`status` = 'offline'),NULL,`tsam`.`memory_use`) AS `memoryUse`,if((`tsai`.`status` = 'offline'),NULL,(`tsam`.`memory_use` / `tsam`.`memory_total`)) AS `memoryRadio`,if((`tsai`.`status` = 'offline'),NULL,`tsam`.`disk_total`) AS `diskTotal`,if((`tsai`.`status` = 'offline'),NULL,`tsam`.`disk_use`) AS `diskUse`,if((`tsai`.`status` = 'offline'),NULL,(`tsam`.`disk_use` / `tsam`.`disk_total`)) AS `diskRadio`,`tsai`.`status` AS `status`,`tsai`.`regist_time` AS `registTime`,`tsam`.`metric3` AS `metric3`,`tsai`.`soft_version` AS `softVersion`,`tsai`.`rule_version` AS `ruleVersion`,`tbf`.`file_name` AS `fileName`,`tsal`.`expire_time` AS `expireTime`,`tsal`.`license_type` AS `licenseType`,`tsam`.`create_time` AS `offlineTime` from (((((`t_sev_agent_info` `tsai` left join `t_sev_agent_type` `tsat` on((`tsai`.`agent_type` = `tsat`.`agent_type`))) left join `t_organization` `to` on((`to`.`orgId` = `tsai`.`org_id`))) left join `t_sev_agent_license` `tsal` on((`tsai`.`agent_code` = `tsal`.`agent_code`))) left join `t_bs_files` `tbf` on((`tsal`.`file_uuid` = `tbf`.`uuid`))) left join `t_sev_agent_monitor` `tsam` on((`tsai`.`monitor_id` = `tsam`.`id`)));

-- ----------------------------
-- View structure for t_sev_agent_view
-- ----------------------------
DROP VIEW IF EXISTS `t_sev_agent_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `t_sev_agent_view` AS select `tsai`.`agent_code` AS `agentCode`,`tsai`.`single_login_uri` AS `singleLoginUri`,`tsai`.`agent_name` AS `agentName`,`tsat`.`agent_type` AS `agentType`,`tsat`.`agent_type_name` AS `agentTypeName`,`tsai`.`agent_ip` AS `agentIp`,`tsai`.`machine_code` AS `machineCode`,`to`.`orgName` AS `orgName`,if((`tsai`.`status` = 'offline'),NULL,`tsam`.`cpu_usage`) AS `cpuUsage`,if((`tsai`.`status` = 'offline'),NULL,`tsam`.`memory_total`) AS `memoryTotal`,if((`tsai`.`status` = 'offline'),NULL,`tsam`.`memory_use`) AS `memoryUse`,if((`tsai`.`status` = 'offline'),NULL,(`tsam`.`memory_use` / `tsam`.`memory_total`)) AS `memoryRadio`,if((`tsai`.`status` = 'offline'),NULL,`tsam`.`disk_total`) AS `diskTotal`,if((`tsai`.`status` = 'offline'),NULL,`tsam`.`disk_use`) AS `diskUse`,if((`tsai`.`status` = 'offline'),NULL,(`tsam`.`disk_use` / `tsam`.`disk_total`)) AS `diskRadio`,`tsai`.`status` AS `status`,`tsai`.`regist_time` AS `registTime`,`tsal`.`expire_time` AS `expireTime`,`tsal`.`license_type` AS `licenseType`,`tsam`.`create_time` AS `offlineTime` from ((((`t_sev_agent_info` `tsai` left join `t_sev_agent_type` `tsat` on((`tsai`.`agent_type` = `tsat`.`agent_type`))) left join `t_organization` `to` on((`to`.`orgId` = `tsai`.`org_id`))) left join `t_sev_agent_license` `tsal` on((`tsai`.`agent_code` = `tsal`.`agent_code`))) left join `t_sev_agent_monitor` `tsam` on((`tsai`.`monitor_id` = `tsam`.`id`)));

-- ----------------------------
-- Procedure structure for add_col_if_not_exists
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_col_if_not_exists`;
delimiter ;;
CREATE PROCEDURE `add_col_if_not_exists`(var_table_name VARCHAR (100),
    var_column_name VARCHAR (100),
    var_column_type_str VARCHAR (200))
BEGIN
    IF NOT EXISTS (
        SELECT 1  FROM information_schema.COLUMNS
        WHERE table_schema = DATABASE()
              AND TABLE_NAME = var_table_name COLLATE utf8_general_ci
              AND COLUMN_NAME = var_column_name COLLATE utf8_general_ci
    )
    THEN
      SET @sqlcmd=concat("ALTER TABLE ",var_table_name," ADD COLUMN ",var_column_name,var_column_type_str,";");
PREPARE stmt FROM @sqlcmd;
EXECUTE stmt;
ELSE
select concat(var_table_name," 's COLUMN ", var_column_name," IS EXISTS");
END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for create_index
-- ----------------------------
DROP PROCEDURE IF EXISTS `create_index`;
delimiter ;;
CREATE PROCEDURE `create_index`(given_table VARCHAR(64),
    given_index VARCHAR(64),
    given_columns VARCHAR(64))
BEGIN

    DECLARE IndexIsThere INTEGER;

    SELECT COUNT(1) INTO IndexIsThere
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE table_schema = DATABASE()
      AND table_name = given_table
      AND index_name = given_index;

    IF IndexIsThere = 0 THEN
        SET @sqlstmt = CONCAT('CREATE INDEX ',given_index,' ON `',
                              DATABASE(),'`.',given_table,' (',given_columns,')');
        PREPARE st FROM @sqlstmt;
        EXECUTE st;
        DEALLOCATE PREPARE st;
    ELSE
        SELECT CONCAT('Index ',given_index,' already exists on Table ',
                      DATABASE(),'.',given_table) CreateindexErrorMessage;
    END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for drop_col_if_not_exists
-- ----------------------------
DROP PROCEDURE IF EXISTS `drop_col_if_not_exists`;
delimiter ;;
CREATE PROCEDURE `drop_col_if_not_exists`(var_table_name VARCHAR (20),
  var_column_name VARCHAR (20))
BEGIN
    IF EXISTS (
        SELECT 1  FROM information_schema.COLUMNS
        WHERE table_schema = DATABASE()
              AND TABLE_NAME = var_table_name COLLATE utf8_general_ci
              AND COLUMN_NAME = var_column_name COLLATE utf8_general_ci
    )
    THEN
      SET @sqlcmd1=concat("ALTER TABLE ",var_table_name," DROP COLUMN ",var_column_name,";");
      PREPARE stmt FROM @sqlcmd1;
      EXECUTE stmt;
    ELSE
      select concat(var_table_name," 's COLUMN ", var_column_name," IS NOT EXISTS");
    END IF;
  END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for drop_index_if_exists
-- ----------------------------
DROP PROCEDURE IF EXISTS `drop_index_if_exists`;
delimiter ;;
CREATE PROCEDURE `drop_index_if_exists`(given_table VARCHAR(64),
    given_index VARCHAR(64))
BEGIN

    DECLARE IndexIsThere INTEGER;

    SELECT COUNT(1) INTO IndexIsThere
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE table_schema = DATABASE()
      AND table_name = given_table
      AND index_name = given_index;

    IF IndexIsThere = 1 THEN
            SET @sqlstmt = CONCAT('ALTER TABLE `',DATABASE(),'`.',given_table,
                            ' DROP INDEX ',given_index);
        PREPARE st FROM @sqlstmt;
        EXECUTE st;
        DEALLOCATE PREPARE st;
    ELSE
        SELECT CONCAT('Index ',given_index,' not exists on Table ',
                  DATABASE(),'.',given_table) DropindexErrorMessage;
    END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for drop_primary_if_exists
-- ----------------------------
DROP PROCEDURE IF EXISTS `drop_primary_if_exists`;
delimiter ;;
CREATE PROCEDURE `drop_primary_if_exists`(given_table VARCHAR(64))
BEGIN

    DECLARE PrimaryIsThere INTEGER;

    SELECT COUNT(1) INTO PrimaryIsThere
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    WHERE table_schema = DATABASE()
      AND table_name = given_table
      AND CONSTRAINT_NAME = 'PRIMARY';

    IF PrimaryIsThere = 1 THEN
            SET @sqlstmt = CONCAT('ALTER TABLE `',DATABASE(),'`.',given_table,
                            ' DROP PRIMARY KEY');
        PREPARE st FROM @sqlstmt;
        EXECUTE st;
        DEALLOCATE PREPARE st;
    ELSE
        SELECT CONCAT('PRIMARY KEY not exists on Table ',
                  DATABASE(),'.',given_table) DropindexErrorMessage;
    END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for operate_role
-- ----------------------------
DROP PROCEDURE IF EXISTS `operate_role`;
delimiter ;;
CREATE PROCEDURE `operate_role`()
BEGIN
declare _count int;
set _count=(select count(*) from information_schema.COLUMNS
where TABLE_NAME = 't_role' and
table_schema= (select database()) and
column_name='update_switch');
if _count=0 then
ALTER TABLE `t_role`
ADD COLUMN `update_switch` INT NOT NULL DEFAULT 1 COMMENT '列表展示是否可以更新：0不可以，1可以' AFTER `updatetime`,
ADD COLUMN `delete_switch` INT NOT NULL DEFAULT 1 COMMENT '是否可以删除，0不可，1可以。' AFTER `update_switch`;
end if;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for operate_role_sort
-- ----------------------------
DROP PROCEDURE IF EXISTS `operate_role_sort`;
delimiter ;;
CREATE PROCEDURE `operate_role_sort`()
BEGIN
declare _count int;
set _count=(select count(*) from information_schema.COLUMNS
where TABLE_NAME = 't_role' and
table_schema= (select database()) and
column_name='order');
if _count=0 then
ALTER TABLE `t_role`
ADD COLUMN `order` INT NOT NULL DEFAULT 0 COMMENT '列表排序：0不参与排序，非0可以' AFTER `update_switch`;
end if;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for operate_user
-- ----------------------------
DROP PROCEDURE IF EXISTS `operate_user`;
delimiter ;;
CREATE PROCEDURE `operate_user`()
BEGIN
declare _count int;
set _count=(select count(*) from information_schema.COLUMNS
where TABLE_NAME = 't_user' and
table_schema= (select database()) and
column_name='ip_switch');
if _count=0 then
ALTER TABLE `t_user`
ADD COLUMN  `ip_switch` INT NOT NULL DEFAULT 0 COMMENT '是否制定IP登陆，0不开启，1开启。默认0。' AFTER `updatetime`,
ADD COLUMN `default_pwd` INT NOT NULL DEFAULT 0 COMMENT '0默认密码，需要修改；1已修改密码。  首次登陆除三个内置用户外的用户首次登陆必须修改密码。添加一个用户密码是否修改的字段 0  未修改-4 修改后字段 更新1 ；重置密码后，字段改为0，未修改-4等' AFTER `ip_switch`;
ALTER TABLE `t_user`
CHANGE COLUMN `default_pwd` `default_pwd` INT(11) NOT NULL DEFAULT 1 COMMENT '0已修改密码，1默认密码，需要修改。  首次登陆除三个内置用户（升级除外）的用户首次登陆必须修改密码。添加一个用户密码是否修改的字段： 1  未修改-4 修改后字段 更新0 ；重置密码后，字段改为0，未修改-4等' ,
ADD COLUMN `update_switch` INT NOT NULL DEFAULT 1 COMMENT '是否允许更新：0不允许，1允许。' AFTER `default_pwd`,
ADD COLUMN `delete_switch` INT NOT NULL DEFAULT 1 COMMENT '是否允许删除：0不允许，1允许' AFTER `update_switch`,
ADD COLUMN `reset_switch` INT NOT NULL DEFAULT 1 COMMENT '是否允许重制密码：0不允许；1允许' AFTER `delete_switch`;
end if;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for operate_user_login
-- ----------------------------
DROP PROCEDURE IF EXISTS `operate_user_login`;
delimiter ;;
CREATE PROCEDURE `operate_user_login`()
BEGIN
declare _count int;
set _count=(select count(*) from information_schema.COLUMNS
where TABLE_NAME = 't_user' and
table_schema= (select database()) and
column_name='first_failure_time');
if _count=0 then
ALTER TABLE `t_user`
CHANGE COLUMN `locktime` `locktime` BIGINT(20) NULL DEFAULT '0' COMMENT '用户逻辑删除时locktime为-2' ,
ADD COLUMN `lock` INT NOT NULL DEFAULT 0 COMMENT '是否被锁，0:没有被锁，1:加锁' AFTER `reset_switch`,
ADD COLUMN `first_failure_time` TIMESTAMP NOT NULL DEFAULT '2013-08-08 00:00:00' AFTER `lock`,
ADD COLUMN `failure_times` INT NOT NULL DEFAULT 0 COMMENT '登录失败次数，默认0次' AFTER `first_failure_time`,
ADD COLUMN `first_lock_time` TIMESTAMP NOT NULL DEFAULT '2013-08-08 00:00:00' AFTER `failure_times`,
ADD COLUMN `out_of_date` INT NOT NULL DEFAULT 0 COMMENT '是否过期；0:未有过期；1过期了。' AFTER `first_lock_time`,
ADD COLUMN `reset_pwd_time` TIMESTAMP NOT NULL DEFAULT '2013-08-08 00:00:00' COMMENT '最后一次修改密码时间，默认0。' AFTER `out_of_date`,
ADD COLUMN `is_portal` INT NOT NULL DEFAULT 0 COMMENT '对统一门户进行启用或者禁用，默认为启用状态。1启用，0禁用。' AFTER `reset_pwd_time`;
end if;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sequence_data
-- ----------------------------
DROP PROCEDURE IF EXISTS `sequence_data`;
delimiter ;;
CREATE PROCEDURE `sequence_data`()
BEGIN
    DECLARE i INT;
    SET i = 0;
    WHILE i < 10000 DO
      INSERT INTO sequence (seq) VALUES (i);
      SET i = i + 1;
    END WHILE;
  END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_assetLevel_value
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_assetLevel_value`;
delimiter ;;
CREATE PROCEDURE `update_assetLevel_value`()
BEGIN
    IF EXISTS (
        SELECT 1  FROM information_schema.COLUMNS
        WHERE table_schema = DATABASE()
              AND TABLE_NAME = "t_asset_cal_results"
              AND COLUMN_NAME = "fallen"
    )
    THEN
      update t_asset_cal_results
      SET assetLevel =
      CASE
      WHEN fallen >0 THEN 4
      WHEN highRisk>0 THEN 3
      WHEN lowRisk>0 THEN 2
      WHEN safe>0 THEN 1
      ELSE 0
      END;
    ELSE
      select " t_asset_cal_results's COLUMN fallen IS NOT EXISTS";
    END IF;
  END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;

SET FOREIGN_KEY_CHECKS = 1;
