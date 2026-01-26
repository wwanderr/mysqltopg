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
-- Table structure for t_asset_attack_surface
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_attack_surface`;
CREATE TABLE `t_asset_attack_surface`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `asset_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产名称\r\n',
  `asset_info_id` int(11) NULL DEFAULT NULL,
  `asset_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产ip',
  `asset_type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产类型',
  `security_zone_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全域id\r\n',
  `exposed_ports` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '暴露端口，多个用逗号分隔',
  `app_protocol` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '协议，多个协议使用逗号分隔',
  `port_status` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '端口状态json',
  `port_protocol` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '端口协议json',
  `display_port_protocol` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '暴露端口，用于列表和详情展示',
  `fingerprint` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产指纹，用于列表和详情展示',
  `asset_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'exposed' COMMENT '多个标签使用逗号分隔',
  `visit_count` bigint(20) NULL DEFAULT 0 COMMENT '访问次数',
  `attack_count` bigint(20) NULL DEFAULT 0 COMMENT '攻击次数',
  `attack_success_count` bigint(20) NULL DEFAULT 0 COMMENT '攻击成功次数',
  `latest_time` timestamp NULL DEFAULT NULL COMMENT '最近访问时间',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日期，当前数据的日期',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ip_date`(`asset_ip`, `date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_attack_surface
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_attack_surface_port
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_attack_surface_port`;
CREATE TABLE `t_asset_attack_surface_port`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `port` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '端口',
  `is_default` tinyint(1) NULL DEFAULT 0 COMMENT '是否内置端口',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_attack_surface_port
-- ----------------------------
INSERT INTO `t_asset_attack_surface_port` VALUES (1, '20', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_asset_attack_surface_port` VALUES (2, '21', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_asset_attack_surface_port` VALUES (3, '22', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_asset_attack_surface_port` VALUES (4, '23', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_asset_attack_surface_port` VALUES (5, '25', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_asset_attack_surface_port` VALUES (6, '69', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_asset_attack_surface_port` VALUES (7, '80', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_asset_attack_surface_port` VALUES (8, '445', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_asset_attack_surface_port` VALUES (9, '3389', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_asset_attack_surface_port` VALUES (10, '514', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_attack_surface_url
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_attack_surface_url`;
CREATE TABLE `t_asset_attack_surface_url`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `asset_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `asset_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产名称',
  `asset_type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名数量',
  `dest_ports` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所有暴露端口json保存',
  `dest_host_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '域名',
  `request_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '暴露接口',
  `src_user_name` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '用户名数组json保存全部',
  `cat_outcome` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录结果',
  `visit_count` bigint(20) NULL DEFAULT NULL,
  `oldest_time` datetime NULL DEFAULT NULL,
  `latest_time` datetime NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `date` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `group_field`(`asset_ip`, `date`, `dest_ports`, `request_url`, `dest_host_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_attack_surface_url
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_cal_results
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_cal_results`;
CREATE TABLE `t_asset_cal_results`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `assetIp` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产ip',
  `flawHigh` bigint(20) NULL DEFAULT 0,
  `flawLow` bigint(20) NULL DEFAULT 0,
  `flawMiddle` bigint(20) NULL DEFAULT 0,
  `flawSum` bigint(20) NULL DEFAULT 0,
  `incidentHigh` bigint(20) NULL DEFAULT 0,
  `incidentLow` bigint(20) NULL DEFAULT 0,
  `incidentMiddle` bigint(20) NULL DEFAULT 0,
  `incidentSum` bigint(20) NULL DEFAULT 0,
  `score` double NULL DEFAULT -1 COMMENT '评分',
  `logCount` double NULL DEFAULT 0,
  `assetLevel` int(11) NULL DEFAULT 0 COMMENT '资产评级',
  `alarm_top` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警topN',
  `last_alarm_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最近告警发生时间',
  `first_fallen_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '首次失陷时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '数据更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `assetId_UNIQUE`(`assetIp`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资产管理-资产计算结果' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_cal_results
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_discover
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_discover`;
CREATE TABLE `t_asset_discover`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT 0 COMMENT '0:安全域（一对多content）；1:内部IP；2:网段',
  `item` int(11) NOT NULL DEFAULT 0 COMMENT '0:服务器；1:终端；2服务器和终端',
  `content` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT ' t_security_zone、 t_inner_ip_config的id',
  `stats` int(11) NOT NULL COMMENT '0:禁用；1:启用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资产自动发现配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_discover
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_evaluation
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_evaluation`;
CREATE TABLE `t_asset_evaluation`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `asset_ip` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产IP',
  `asset_health_state` enum('healthy','low_risk','medium_risk','high_risk','fallen','unknown') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'unknown' COMMENT '资产健康状态枚举值[\"健康\"(healthy),\"低风险\"(low_risk),\"中风险\"(medium_risk),\"高风险\"(high_risk),\"已失陷\"(fallen),\"未知\"(unknown)]',
  `asset_evaluation_tag` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产评级标签',
  `sub_category` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警子类型',
  `alarm_results` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警结果',
  `alarm_top` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '告警Top3',
  `last_alarm_time` datetime NULL DEFAULT NULL COMMENT '上一次告警发送时间',
  `vulnerability` double(4, 2) NOT NULL DEFAULT 0.00 COMMENT '脆弱性值（取值范围(0,10]，精度0.01，0表示N/A）',
  `threat` double(4, 2) NOT NULL DEFAULT 0.00 COMMENT '威胁值（取值范围(0,10]，精度0.01，0表示N/A）',
  `value` tinyint(4) NOT NULL COMMENT '资产价值（取值范围[1-5]的整数）',
  `asset_score` tinyint(4) NOT NULL DEFAULT 0 COMMENT '资产风险值（取值范围[1-100]的整数，0表示N/A）',
  `unprocessed_alarm_count` int(11) NOT NULL DEFAULT 0 COMMENT '本次评估时未处置的原始告警总数',
  `unprocessed_cve_count` int(11) NOT NULL DEFAULT 0 COMMENT '本次评估时带有cve编号的未处置原始告警总数',
  `evaluate_date` date NOT NULL COMMENT '本次评估日期',
  `evaluate_time` time NOT NULL COMMENT '本次评估时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_evaluate_date_asset_ip`(`evaluate_date`, `asset_ip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资产评估（资产评级与风险值计算）记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_evaluation
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_find
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_find`;
CREATE TABLE `t_asset_find`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产IP',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产名称',
  `deviceType` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备类型',
  `securityZone` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全域',
  `source` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '扫描自动发现' COMMENT '资产来源，1：扫描自动发现，2：流量自动发现',
  `findTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发现时间',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_ip`(`ip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_find
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_fingerprint
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_fingerprint`;
CREATE TABLE `t_asset_fingerprint`  (
  `asset_ip` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产ip',
  `port` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '端口',
  `protocol` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '协议',
  `fingerprint_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fingerprint_type` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `fingerprint_version` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`asset_ip`, `port`, `protocol`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_asset_fingerprint
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_history
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_history`;
CREATE TABLE `t_asset_history`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产IP或域名',
  `changeType` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变更类型，1：新发现未备案资产，2：备案资产不在线，3：新发现开放端口，4：以开放端口被关闭，5：新发现漏洞，6：已发现漏洞修复',
  `port` varchar(7) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '端口',
  `vul` varchar(127) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '漏洞',
  `vulType` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '漏洞类型，1：主机，2：web，3：基线，4：弱口令，5：数据库',
  `source` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产来源，1：扫描自动发现，2：流量自动发现',
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变更记录描述信息',
  `findTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发现时间',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_ip`(`ip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_history
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_history_status
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_history_status`;
CREATE TABLE `t_asset_history_status`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL COMMENT '用户ID',
  `historyId` bigint(20) NOT NULL COMMENT '变更记录ID',
  `status` enum('1','0') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '状态，1：已读，0：未读',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_ip`(`userId`) USING BTREE,
  INDEX `fk_historyId`(`historyId`) USING BTREE,
  CONSTRAINT `fk_historyId` FOREIGN KEY (`historyId`) REFERENCES `t_asset_history` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_userId` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_history_status
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_info
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_info`;
CREATE TABLE `t_asset_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `assetIp` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产ip',
  `assetName` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '资产名称',
  `assetCode` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '资产编号',
  `assetType` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '资产类型',
  `assetImportance` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '资产重要性',
  `assetStatus` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '资产状态',
  `assetTags` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '资产标签',
  `personInCharge` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '责任人',
  `assetUser` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '使用人',
  `belongedBusinessSystem` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '所属业务系统',
  `assetGroup` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '资产组',
  `location` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '地理位置',
  `storeLocation` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备存放地址',
  `confidentiality` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'C-机密性',
  `integrity` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'I-完整性',
  `availability` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'A-可用性',
  `isHierarchyProtection` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '是否等保',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '描述',
  `os` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `osVersion` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '操作系统版本',
  `macAddress` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `enablePorts` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '允许开放端口',
  `deviceManufacturer` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备厂商',
  `deviceModel` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备型号',
  `deviceVersion` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备版本',
  `source` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '来源:0-其它，1-手动，2-导入，3-自动发现',
  `lastModifiedTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后更新时间',
  `edr_id` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR资产唯一标识',
  `edr_stats` int(11) NOT NULL DEFAULT 0 COMMENT 'EDR防护状态分为：防护中（2）、停止防护（1）、-(0非EDR资产)',
  `edr_switch` int(11) NOT NULL DEFAULT 0 COMMENT '是否为安恒RDR联动设备，默认0不是，1是。',
  `assetIpNum` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP的去除符号16进制字符串',
  `app_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联动设备类型',
  `device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联动设备id',
  `value` tinyint(4) NULL DEFAULT NULL COMMENT '记录用户手动修改过的资产价值（取值范围[1-5]的整数；默认为null）',
  `asset_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产id，用来打资产ID使用',
  `edr_exception_status` tinyint(4) NULL DEFAULT -1 COMMENT 'edr隔离状态 1已隔离 0未隔离',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `assetIp_UNIQUE`(`assetIp`) USING BTREE,
  UNIQUE INDEX `assetId_UNIQUE`(`asset_id`) USING BTREE,
  INDEX `assetIpNum_uk`(`assetIpNum`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资产管理-资产信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_info
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_manage
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_manage`;
CREATE TABLE `t_asset_manage`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetIp` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `securityDevice` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `webSystem` varchar(15000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'web系统',
  `logMonitor` int(11) NOT NULL DEFAULT 0 COMMENT '0:关闭；1开启',
  `logMonitorValue` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '7各点；日期将来可能需要带',
  `onlineDetect` int(11) NOT NULL DEFAULT 0 COMMENT '0:关闭；1开启',
  `onlineDetectStats` int(11) NOT NULL DEFAULT -1 COMMENT '0:离线；1在线',
  `manageAddress` int(11) NOT NULL DEFAULT 0 COMMENT '管理地址：0:关闭；1开启',
  `manageAddressDetail` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理地址',
  `disposalLinkage` int(11) NOT NULL DEFAULT 0 COMMENT '处置联动:0:关闭；1开启',
  `disposalLinkagePort` int(11) NULL DEFAULT NULL COMMENT '处置联动端口',
  `disposalLinkageStats` int(11) NOT NULL DEFAULT 0 COMMENT '处置联动状态：0:连接失败；1连接成功',
  `onlineDetectMethod` int(11) NOT NULL DEFAULT 0 COMMENT '在线状态检测方式：0:是否接入日志；1:PING',
  `onlineDetectCycle` int(11) NOT NULL DEFAULT 2 COMMENT '在线状态检测周期：0:1分钟；1:10分钟；2:30分钟；3:1小时；4:12小时；5:1天',
  `netraffic` int(11) NOT NULL DEFAULT 0 COMMENT '流量监控:0关闭；1开启',
  `openPortMonitor` int(11) NOT NULL DEFAULT 0 COMMENT '开放端口监控:0:关闭；1开启',
  `openPortMax` int(11) NULL DEFAULT NULL COMMENT '响应流量阀值',
  `openPort` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '允许开放端口',
  `externalMonitor` int(11) NOT NULL DEFAULT 0 COMMENT '外连行为监控:0关闭，1开启',
  `externalMax` int(11) NULL DEFAULT NULL COMMENT '请求流量阀值',
  `uploadRate` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上传速率',
  `downloadRate` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '下载速率',
  `requestRate` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求速率',
  `responseRate` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '响应速率',
  `currentvolume` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sDayFlow` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '7天流量',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `other` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `edr_user` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR用户名',
  `edr_pwd` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'EDR密码',
  `edr_login` int(11) NULL DEFAULT NULL COMMENT 'EDR访问状态。0访问失败，1免登访问成功',
  `scanPort` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '弱点管理平台扫描端口',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `assetIp_UNIQUE`(`assetIp`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_manage
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_port
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_port`;
CREATE TABLE `t_asset_port`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `assetIp` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产ip',
  `port` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '端口',
  `protocol` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '协议',
  `serviceName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务名',
  `serverVersion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务版本',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '端口状态，1：开启，0：关闭',
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变更记录描述信息',
  `findTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_uni`(`assetIp`, `port`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资产管理-端口' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_port
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_asset_virus
-- ----------------------------
DROP TABLE IF EXISTS `t_asset_virus`;
CREATE TABLE `t_asset_virus`  (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '病毒名称',
  `path` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '路径',
  `hash` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件hash',
  `node_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产id，EDR_ID',
  `asset_ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产ip',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_asset_virus
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_attack_update
-- ----------------------------
DROP TABLE IF EXISTS `t_attack_update`;
CREATE TABLE `t_attack_update`  (
  `id` int(11) NOT NULL,
  `attack_intent_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attack_intent` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attack_strategy_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attack_strategy` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attack_method_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attack_method` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attack_category` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_attack_update
-- ----------------------------
INSERT INTO `t_attack_update` VALUES (1, '利用型攻击', 'exploitAttack', '信息泄露', 'infoLeakage', '数据库信息泄露', 'DBLeakage', '/SuspTraffic/SuspContent');
INSERT INTO `t_attack_update` VALUES (2, '利用型攻击', 'exploitAttack', '信息泄露', 'infoLeakage', 'web服务器信息泄露', 'webLeakage', '/WebAttack/InfoLeak');
INSERT INTO `t_attack_update` VALUES (3, '利用型攻击', 'exploitAttack', '信息泄露', 'infoLeakage', '目录信息泄漏', 'dirInfoLeakage', '/WebAttack/InfoLeak');
INSERT INTO `t_attack_update` VALUES (4, '利用型攻击', 'exploitAttack', '信息泄露', 'infoLeakage', '源代码信息泄露', 'sourceCodeInfoLeakage', '/WebAttack/InfoLeak');
INSERT INTO `t_attack_update` VALUES (5, '利用型攻击', 'exploitAttack', '信息泄露', 'infoLeakage', '其他', 'others', '/WebAttack/InfoLeak');
INSERT INTO `t_attack_update` VALUES (6, '利用型攻击', 'exploitAttack', '越权攻击', 'crossPrivilege', '绕过安全设备', 'bypassDevice', '/ConfigRisk/DeviceConf');
INSERT INTO `t_attack_update` VALUES (7, '利用型攻击', 'exploitAttack', '越权攻击', 'crossPrivilege', '其他', 'others', '/ConfigRisk/DeviceConf');
INSERT INTO `t_attack_update` VALUES (8, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', '操作系统暴力破解', 'OSBruteForce', '/AccountRisk/BruteForce');
INSERT INTO `t_attack_update` VALUES (9, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', 'Web暴力破解', 'webBruteForce', '/AccountRisk/BruteForce');
INSERT INTO `t_attack_update` VALUES (10, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', '数据库暴力破解', 'DBBruteForce', '/AccountRisk/BruteForce');
INSERT INTO `t_attack_update` VALUES (11, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', 'VPN暴力破解', 'VPNBruteForce', '/AccountRisk/BruteForce');
INSERT INTO `t_attack_update` VALUES (12, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', 'SSH暴力破解', 'SSHBruteForce', '/AccountRisk/BruteForce');
INSERT INTO `t_attack_update` VALUES (13, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', '其他', 'others', '/AccountRisk/BruteForce');
INSERT INTO `t_attack_update` VALUES (14, '利用型攻击', 'exploitAttack', '注入攻击', 'injectionAttack', 'SQL注入', 'SQLInjection', '/WebAttack/SQLInjection');
INSERT INTO `t_attack_update` VALUES (15, '利用型攻击', 'exploitAttack', '注入攻击', 'injectionAttack', '命令注入', 'commandInjection', '/WebAttack/CommandExec');
INSERT INTO `t_attack_update` VALUES (16, '利用型攻击', 'exploitAttack', '注入攻击', 'injectionAttack', '代码注入', 'codeInjection', '/WebAttack/CodeInjection');
INSERT INTO `t_attack_update` VALUES (17, '利用型攻击', 'exploitAttack', '注入攻击', 'injectionAttack', '其他', 'others', '/WebAttack/CodeInjection');
INSERT INTO `t_attack_update` VALUES (18, '利用型攻击', 'exploitAttack', '跨站攻击', 'crossSiteAttack', '跨站脚本攻击', 'XSS', '/WebAttack/XSS');
INSERT INTO `t_attack_update` VALUES (19, '利用型攻击', 'exploitAttack', '跨站攻击', 'crossSiteAttack', '跨站请求伪造', 'CSRF', '/WebAttack/CSRF');
INSERT INTO `t_attack_update` VALUES (20, '利用型攻击', 'exploitAttack', '跨站攻击', 'crossSiteAttack', '其他', 'others', '/WebAttack/Others');
INSERT INTO `t_attack_update` VALUES (21, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '网站恶意行为', 'webMalAction', '/WebAttack/Others');
INSERT INTO `t_attack_update` VALUES (22, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '邮件恶意行为', 'emailMalAction', '/Malware/MaliciousMail');
INSERT INTO `t_attack_update` VALUES (23, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '恶意链接', 'malLink', '/SuspTraffic/SuspContent');
INSERT INTO `t_attack_update` VALUES (24, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '操作系统恶意行为', 'OSMalAction', '/Exploit/SystemVul');
INSERT INTO `t_attack_update` VALUES (25, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '数据库恶意行为', 'DBMalAction', '/Exploit/SoftVul');
INSERT INTO `t_attack_update` VALUES (26, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '其他', 'others', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (27, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', 'ARP欺骗', 'ARP', '/LateralMov/SuspiciousSpread');
INSERT INTO `t_attack_update` VALUES (28, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', 'IP欺骗', 'IPSpoofing', '/SuspTraffic/MaliciousIP');
INSERT INTO `t_attack_update` VALUES (29, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', 'DNS欺骗', 'DNSSpoofing', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (30, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', 'ICMP欺骗', 'ICMPSpoofing', '/LateralMov/SuspiciousSpread');
INSERT INTO `t_attack_update` VALUES (31, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', '网络钓鱼', 'phishingSite', '/SuspTraffic/SuspContent');
INSERT INTO `t_attack_update` VALUES (32, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', '邮件欺骗', 'emailSpoofing', '/Malware/MaliciousMail');
INSERT INTO `t_attack_update` VALUES (33, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', '其他', 'others', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (34, '利用型攻击', 'exploitAttack', '漏洞利用', 'vulnerabilityExploitation', 'web漏洞', 'webVulnerability', '/WebAttack/CodeInjection');
INSERT INTO `t_attack_update` VALUES (35, '利用型攻击', 'exploitAttack', '漏洞利用', 'vulnerabilityExploitation', '系统漏洞', 'systemVulnerability', '/Exploit/SystemVul');
INSERT INTO `t_attack_update` VALUES (36, '利用型攻击', 'exploitAttack', '漏洞利用', 'vulnerabilityExploitation', '软件漏洞', 'softwareVulnerability', '/Exploit/SoftVul');
INSERT INTO `t_attack_update` VALUES (37, '利用型攻击', 'exploitAttack', '漏洞利用', 'vulnerabilityExploitation', '硬件漏洞', 'hardwareVulnerability', '/Exploit/DeviceVul');
INSERT INTO `t_attack_update` VALUES (38, '利用型攻击', 'exploitAttack', '漏洞利用', 'vulnerabilityExploitation', '其他', 'others', '/Exploit/Others');
INSERT INTO `t_attack_update` VALUES (39, '利用型攻击', 'exploitAttack', '其他', 'others', '其他', 'others', '/Exploit/Others');
INSERT INTO `t_attack_update` VALUES (40, '恶意文件', 'maliciousFile', '后门程序', 'backdoor', 'webshell', 'webshell', '/WebAttack/WebshellRequest');
INSERT INTO `t_attack_update` VALUES (41, '恶意文件', 'maliciousFile', '后门程序', 'backdoor', '主机后门', 'hostBackdoor', '/WebAttack/WebshellRequest');
INSERT INTO `t_attack_update` VALUES (42, '恶意文件', 'maliciousFile', '后门程序', 'backdoor', '其他', 'others', '/WebAttack/WebshellRequest');
INSERT INTO `t_attack_update` VALUES (43, '恶意文件', 'maliciousFile', '僵木蠕', 'botnetTrojanWorm', '木马', 'trojan', '/Malware/BotTrojWorm');
INSERT INTO `t_attack_update` VALUES (44, '恶意文件', 'maliciousFile', '僵木蠕', 'botnetTrojanWorm', '域名回连', 'domainBackConnect', '/Malware/BotTrojWorm');
INSERT INTO `t_attack_update` VALUES (45, '恶意文件', 'maliciousFile', '僵木蠕', 'botnetTrojanWorm', '僵尸网络', 'botnets', '/Malware/BotTrojWorm');
INSERT INTO `t_attack_update` VALUES (46, '恶意文件', 'maliciousFile', '僵木蠕', 'botnetTrojanWorm', '蠕虫', 'worm', '/Malware/BotTrojWorm');
INSERT INTO `t_attack_update` VALUES (47, '恶意文件', 'maliciousFile', '僵木蠕', 'botnetTrojanWorm', '其他', 'others', '/Malware/BotTrojWorm');
INSERT INTO `t_attack_update` VALUES (48, '恶意文件', 'maliciousFile', '病毒', 'virus', '网络病毒', 'networkVirus', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (49, '恶意文件', 'maliciousFile', '病毒', 'virus', '计算机病毒', 'hostVirus', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (50, '恶意文件', 'maliciousFile', '病毒', 'virus', '其他', 'others', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (51, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '恶意广告', 'malvertisement', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (52, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '勒索软件', 'ransomware', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (53, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '挖矿软件', 'miner', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (54, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '黑市工具', 'hackerKit', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (55, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '流氓推广', 'immoralSpread', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (56, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '其他', 'others', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (57, '恶意文件', 'maliciousFile', '其他', 'others', '其他', 'others', '/SuspTraffic/MaliciousDomain');
INSERT INTO `t_attack_update` VALUES (58, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'SYN Flood', 'SYNFlood', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (59, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'UDP Flood', 'UDPFlood', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (60, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'ICMP Flood', 'ICMPFlood', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (61, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'ACK Flood', 'ACKFlood', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (62, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'DNS Reqsponse Flood', 'DNSReqsponseFlood', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (63, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'DNS Request Flood', 'DNSRequestFlood', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (64, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'Http Flood', 'HttpFlood', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (65, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'Https Flood', 'HttpsFlood', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (66, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'LAND Flood', 'LANDFlood', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (67, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'IGMP Flood', 'IGMPFlood', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (68, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'cc攻击', 'CCAttack', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (69, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', '其他', 'others', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (70, '拒绝服务', 'DoS', '其他', 'others', '其他', 'others', '/Exploit/DOS');
INSERT INTO `t_attack_update` VALUES (71, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', '应用程序探测', 'applicationProbe', '/Scan/ServScan');
INSERT INTO `t_attack_update` VALUES (72, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', '数据库探测', 'DBProbe', '/Scan/ServScan');
INSERT INTO `t_attack_update` VALUES (73, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', 'DNS探测', 'DNSProbe', '/Scan/ServScan');
INSERT INTO `t_attack_update` VALUES (74, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', 'FTP探测', 'FTPProbe', '/Scan/ServScan');
INSERT INTO `t_attack_update` VALUES (75, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', 'SNMP探测', 'SNMPProbe', '/Scan/ServScan');
INSERT INTO `t_attack_update` VALUES (76, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', 'SSH探测', 'SSHProbe', '/Scan/ServScan');
INSERT INTO `t_attack_update` VALUES (77, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', 'Telnet探测', 'telnetProbe', '/Scan/ServScan');
INSERT INTO `t_attack_update` VALUES (78, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', '其它', 'others', '/Scan/ServScan');
INSERT INTO `t_attack_update` VALUES (79, '扫描探测', 'scanProbe', 'web探测', 'webProbe', '网站爬虫', 'webCrawler', '/Scan/WebScan');
INSERT INTO `t_attack_update` VALUES (80, '扫描探测', 'scanProbe', 'web探测', 'webProbe', 'web扫描', 'webScan', '/Scan/WebScan');
INSERT INTO `t_attack_update` VALUES (81, '扫描探测', 'scanProbe', 'web探测', 'webProbe', '其他', 'others', '/Scan/WebScan');
INSERT INTO `t_attack_update` VALUES (82, '扫描探测', 'scanProbe', '主机扫描', 'hostScan', '端口扫描', 'portScan', '/Scan/PortScan');
INSERT INTO `t_attack_update` VALUES (83, '扫描探测', 'scanProbe', '主机扫描', 'hostScan', 'IP扫描', 'addressScan', '/Scan/HostScan');
INSERT INTO `t_attack_update` VALUES (84, '扫描探测', 'scanProbe', '主机扫描', 'hostScan', '其他', 'others', '/Scan/Others');
INSERT INTO `t_attack_update` VALUES (85, '扫描探测', 'scanProbe', '其它', 'others', '其它', 'others', '/Scan/Others');
INSERT INTO `t_attack_update` VALUES (86, '异常事件', 'anomalyEvent', '操作异常', 'operationAnomaly', '操作异常', 'operationAnomaly', '/AccountRisk/SuspBehavior');
INSERT INTO `t_attack_update` VALUES (87, '异常事件', 'anomalyEvent', '操作异常', 'operationAnomaly', '其他', 'others', '/AccountRisk/SuspBehavior');
INSERT INTO `t_attack_update` VALUES (88, '异常事件', 'anomalyEvent', '通信异常', 'trafficAnomaly', '协议异常', 'protocolAnomaly', '/DevOps/WebError');
INSERT INTO `t_attack_update` VALUES (89, '异常事件', 'anomalyEvent', '通信异常', 'trafficAnomaly', '路由异常', 'routeAnomaly', '/DevOps/DeviceError');
INSERT INTO `t_attack_update` VALUES (90, '异常事件', 'anomalyEvent', '通信异常', 'trafficAnomaly', '其他', 'others', '/DevOps/Others');
INSERT INTO `t_attack_update` VALUES (91, '异常事件', 'anomalyEvent', '配置异常', 'configurationAnomaly', '不安全配置', 'weakConfiguration', '/ConfigRisk/Others');
INSERT INTO `t_attack_update` VALUES (92, '异常事件', 'anomalyEvent', '配置异常', 'configurationAnomaly', '配置错误', 'misConfiguration', '/ConfigRisk/Others');
INSERT INTO `t_attack_update` VALUES (93, '异常事件', 'anomalyEvent', '配置异常', 'configurationAnomaly', '其他', 'others', '/ConfigRisk/Others');
INSERT INTO `t_attack_update` VALUES (94, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', 'CPU状态异常', 'CPUStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (95, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '内存状态异常', 'memoryStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (96, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '磁盘空间状态异常', 'diskSpaceStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (97, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '驱动状态异常', 'driverStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (98, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '服务状态异常', 'serviceStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (99, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '分页状态异常', 'pageStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (100, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '进程状态异常', 'processStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (101, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '线程状态异常', 'threadStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (102, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '句柄状态异常', 'handleStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (103, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '负载状态异常', 'loadStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (104, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '用户数状态异常', 'userStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (105, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '温度状态异常', 'temperatureStatusAnomaly', '/DevOps/HostError');
INSERT INTO `t_attack_update` VALUES (106, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '设备损坏', 'deviceDamage', '/DevOps/DeviceError');
INSERT INTO `t_attack_update` VALUES (107, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '其他', 'others', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (108, '异常事件', 'anomalyEvent', '实体行为异常', 'entityBehaviorAnomaly', '流量行为异常', 'trafficBehaviorAnomaly', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (109, '异常事件', 'anomalyEvent', '实体行为异常', 'entityBehaviorAnomaly', '域名行为异常', 'domainBehaviorAnomaly', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (110, '异常事件', 'anomalyEvent', '实体行为异常', 'entityBehaviorAnomaly', 'web行为异常', 'webBehaviorAnomaly', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (111, '异常事件', 'anomalyEvent', '实体行为异常', 'entityBehaviorAnomaly', '日志行为异常', 'logBehaviorAnomaly', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (112, '异常事件', 'anomalyEvent', '实体行为异常', 'entityBehaviorAnomaly', '其他', 'others', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (113, '异常事件', 'anomalyEvent', '其他', 'others', '其他', 'others', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (114, 'APT', 'APT', 'APT', 'APT', '夜龙APT', 'nightDragon', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (115, 'APT', 'APT', 'APT', 'APT', '其他', 'others', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (116, 'APT', 'APT', '其他', 'others', '其他', 'others', '/Others/Others');
INSERT INTO `t_attack_update` VALUES (117, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '用户管理', 'userManagement', '/Audit/OpAudit');
INSERT INTO `t_attack_update` VALUES (118, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '身份验证', 'IDAuthentication', '/Audit/OpAudit');
INSERT INTO `t_attack_update` VALUES (119, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '身份授权', 'IDAuthorization', '/Audit/OpAudit');
INSERT INTO `t_attack_update` VALUES (120, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '审计管理', 'auditManagement', '/Audit/OpAudit');
INSERT INTO `t_attack_update` VALUES (121, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '用户组管理', 'userGroupManagement', '/Audit/OpAudit');
INSERT INTO `t_attack_update` VALUES (122, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '其他', 'others', '/Audit/OpAudit');
INSERT INTO `t_attack_update` VALUES (123, '系统管理', 'systemManagement', '脆弱性感知', 'vulnerabilityAwareness', '弱口令', 'weakPassword', '/ConfigRisk/WeakPassword');
INSERT INTO `t_attack_update` VALUES (124, '系统管理', 'systemManagement', '脆弱性感知', 'vulnerabilityAwareness', '明文传输', 'plaintextTransmission', '/ConfigRisk/ClearTextCredit');
INSERT INTO `t_attack_update` VALUES (125, '系统管理', 'systemManagement', '脆弱性感知', 'vulnerabilityAwareness', '其他', 'others', '/ConfigRisk/Others');
INSERT INTO `t_attack_update` VALUES (126, '系统管理', 'systemManagement', '其他', 'others', '其他', 'others', '/ConfigRisk/Others');
INSERT INTO `t_attack_update` VALUES (127, '其他', 'others', '其他', 'others', '其他', 'others', '/Others/Others');

-- ----------------------------

-- ----------------------------
-- Table structure for t_auth_version
-- ----------------------------
DROP TABLE IF EXISTS `t_auth_version`;
CREATE TABLE `t_auth_version`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'app名称',
  `type` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置类型，menu：菜单，permission：权限',
  `version` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '版本，配置文件MD5',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_auth_version_UN`(`app_name`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1216 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '各个app权限配置版本历史，对permission.json做MD5得到版本号' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_auth_version
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_autosend_history
-- ----------------------------
DROP TABLE IF EXISTS `t_autosend_history`;
CREATE TABLE `t_autosend_history`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `report_name` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `send_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发送时间',
  `time_range` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '统计时间范围',
  `begin_time` datetime NOT NULL COMMENT '统计开始时间',
  `end_time` datetime NOT NULL COMMENT '统计结束时间',
  `send_format` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发送格式',
  `mail` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发送结果',
  `idByList` int(11) NOT NULL COMMENT '对应List的ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_autosend_history
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_autosend_list
-- ----------------------------
DROP TABLE IF EXISTS `t_autosend_list`;
CREATE TABLE `t_autosend_list`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `report_name` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_enable` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '是否启用',
  `period` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发送周期,day,week,month',
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '生成时间',
  `statistics_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '统计时间',
  `time_range` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '时间范围',
  `send_format` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发送格式',
  `begin_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `end_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mail` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `milli` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_autosend_list
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_bridge_origination
-- ----------------------------
DROP TABLE IF EXISTS `t_bridge_origination`;
CREATE TABLE `t_bridge_origination`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `other_id` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '各种id',
  `origination_id` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属类型：用户:user、安全域、web业务系统',
  `default` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_bridge_origination
-- ----------------------------
INSERT INTO `t_bridge_origination` VALUES (1, '1', '7effcbb7-0c7a-4da9-bde1-32d06166acae', '2026-01-13 10:37:40', '2026-01-13 10:37:40', 'user', NULL);
INSERT INTO `t_bridge_origination` VALUES (2, '3', '7effcbb7-0c7a-4da9-bde1-32d06166acae', '2026-01-13 10:37:40', '2026-01-13 10:37:40', 'user', NULL);
INSERT INTO `t_bridge_origination` VALUES (3, '2', '7effcbb7-0c7a-4da9-bde1-32d06166acae', '2026-01-13 10:37:40', '2026-01-13 10:37:40', 'user', NULL);
INSERT INTO `t_bridge_origination` VALUES (4, '4', '7effcbb7-0c7a-4da9-bde1-32d06166acae', '2026-01-13 10:37:45', '2026-01-13 10:37:45', 'user', NULL);

-- ----------------------------

-- ----------------------------
-- Table structure for t_bs_analysis_job
-- ----------------------------
DROP TABLE IF EXISTS `t_bs_analysis_job`;
CREATE TABLE `t_bs_analysis_job`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务唯一标识',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务中文名',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务描述',
  `prefix` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'RedisKey前缀',
  `script_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '脚本类型',
  `script_path` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '脚本文件路径',
  `job_config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '任务配置参数（JSON字符串）',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务状态[running, stopped, failure]',
  `result` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '最后一次操作结果',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '离线计算任务管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_bs_analysis_job
-- ----------------------------
INSERT INTO `t_bs_analysis_job` VALUES (1, 'one2one', '一对一爆破', '单个源IP对单个目的IP的爆破策略', 'config:IOA:bruteForce:', 'python', '/usr/hdp/2.5.3.0-37/bigdata/mirror-web-api/system/scripts/python/ioa/ioa_engine/main.py', '{\"timeRange\":5,\"loginTimes\":25}', 'running', NULL, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_bs_analysis_job` VALUES (2, 'many2one', '多对一爆破', '多个源IP对一个目的IP的爆破策略', 'config:IOA:bruteForce:', 'python', '/usr/hdp/2.5.3.0-37/bigdata/mirror-web-api/system/scripts/python/ioa/ioa_engine/main.py', '{\"timeRange\":5,\"loginTimes\":25}', 'running', NULL, '2026-01-13 10:37:47', '2026-01-13 10:37:47');
INSERT INTO `t_bs_analysis_job` VALUES (3, 'slow', '慢速爆破', '单个源IP对单个目的IP的慢速爆破策略', 'config:IOA:bruteForce:', 'python', '/usr/hdp/2.5.3.0-37/bigdata/mirror-web-api/system/scripts/python/ioa/ioa_engine/main.py', '{\"timeRange\":5,\"loginTimes\":20,\"repeatTimes\":10}', 'running', NULL, '2026-01-13 10:37:47', '2026-01-13 10:37:47');

-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
