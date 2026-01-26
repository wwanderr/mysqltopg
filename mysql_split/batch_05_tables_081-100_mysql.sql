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
-- Table structure for t_dispose_event_history
-- ----------------------------
DROP TABLE IF EXISTS `t_dispose_event_history`;
CREATE TABLE `t_dispose_event_history`  (
  `id` bigint(23) NOT NULL AUTO_INCREMENT,
  `eventId` bigint(23) NOT NULL COMMENT '处置事件ID',
  `operatorId` bigint(23) NOT NULL COMMENT '操作人ID',
  `address` varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作人主机地址',
  `operations` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作记录',
  `action` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处置动作',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_eventId`(`eventId`) USING BTREE,
  INDEX `fk_operatorId`(`operatorId`) USING BTREE,
  CONSTRAINT `fk_eventId` FOREIGN KEY (`eventId`) REFERENCES `t_dispose_event` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_operatorId` FOREIGN KEY (`operatorId`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dispose_event_history
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_edr_asset_bug
-- ----------------------------
DROP TABLE IF EXISTS `t_edr_asset_bug`;
CREATE TABLE `t_edr_asset_bug`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产ip',
  `scan_batch_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '批次编号',
  `serverity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '状态',
  `size` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '补丁大小',
  `publish_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '发布日期',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '漏洞补丁描述',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `table.hash.key.ip`(`ip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_edr_asset_bug
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_edr_asset_site
-- ----------------------------
DROP TABLE IF EXISTS `t_edr_asset_site`;
CREATE TABLE `t_edr_asset_site`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产ip',
  `scan_batch_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '批次编号',
  `file` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '网站后门文件',
  `time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '发现时间',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '后门类型',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `table.hash.key.ip`(`ip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_edr_asset_site
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_edr_asset_virus
-- ----------------------------
DROP TABLE IF EXISTS `t_edr_asset_virus`;
CREATE TABLE `t_edr_asset_virus`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产ip',
  `scan_batch_no` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '批次编号',
  `file` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '网站后门文件',
  `time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '发现时间',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '病毒木马名称',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `table.hash.key.ip`(`ip`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_edr_asset_virus
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_filteritem
-- ----------------------------
DROP TABLE IF EXISTS `t_filteritem`;
CREATE TABLE `t_filteritem`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NULL DEFAULT NULL,
  `operator` int(11) NULL DEFAULT 0 COMMENT '0，通配符；1，包含',
  `field` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_filteritem
-- ----------------------------
INSERT INTO `t_filteritem` VALUES (1, -1, 0, '目的主机名(destHostName)', '*.163.com');
INSERT INTO `t_filteritem` VALUES (2, -1, 0, '目的主机名(destHostName)', '*.qq.com');
INSERT INTO `t_filteritem` VALUES (3, -1, 0, '目的主机名(destHostName)', '*.189.cn');
INSERT INTO `t_filteritem` VALUES (4, -1, 0, '目的主机名(destHostName)', '*.microsoft.com');
INSERT INTO `t_filteritem` VALUES (5, -1, 0, '目的主机名(destHostName)', '*.sohu.com');
INSERT INTO `t_filteritem` VALUES (6, -1, 0, '目的主机名(destHostName)', '*.taobao.com');
INSERT INTO `t_filteritem` VALUES (7, -1, 0, '目的主机名(destHostName)', '*.baidu.com');
INSERT INTO `t_filteritem` VALUES (8, -1, 0, '目的主机名(destHostName)', '*.kugou.com');
INSERT INTO `t_filteritem` VALUES (9, -1, 0, '目的主机名(destHostName)', '*.oracle.com');
INSERT INTO `t_filteritem` VALUES (10, -1, 0, '目的主机名(destHostName)', '*.windowsupdate.com');
INSERT INTO `t_filteritem` VALUES (11, -1, 0, '目的主机名(destHostName)', '*.360.cn');
INSERT INTO `t_filteritem` VALUES (12, -1, 0, '目的主机名(destHostName)', '*.360.net');
INSERT INTO `t_filteritem` VALUES (13, -1, 0, '目的主机名(destHostName)', '*.nginx.org');
INSERT INTO `t_filteritem` VALUES (14, -1, 0, '目的主机名(destHostName)', '*.lenovo.com');
INSERT INTO `t_filteritem` VALUES (15, -1, 0, '目的主机名(destHostName)', '*.meituan.com');
INSERT INTO `t_filteritem` VALUES (16, -1, 0, '目的主机名(destHostName)', '*.iqiyi.com');
INSERT INTO `t_filteritem` VALUES (17, -1, 0, '目的主机名(destHostName)', '*.youku.com');
INSERT INTO `t_filteritem` VALUES (18, -1, 0, '目的主机名(destHostName)', '*.360safe.com');
INSERT INTO `t_filteritem` VALUES (19, -1, 0, '目的主机名(destHostName)', '*.adobe.com');
INSERT INTO `t_filteritem` VALUES (20, -1, 0, '目的主机名(destHostName)', '*.sogou.com');
INSERT INTO `t_filteritem` VALUES (21, -1, 0, '目的主机名(destHostName)', '*.apple.com');
INSERT INTO `t_filteritem` VALUES (22, -1, 0, '目的主机名(destHostName)', '*.netease.com');
INSERT INTO `t_filteritem` VALUES (23, -1, 0, '目的主机名(destHostName)', '*.weibo.cn');
INSERT INTO `t_filteritem` VALUES (24, -1, 1, '目的主机名(destHostName)', '1.1.1.2,1.1.1.1,www.freebsd.org');
INSERT INTO `t_filteritem` VALUES (25, -2, 1, '目的IP(destAddress)', '127.0.0.1');

-- ----------------------------

-- ----------------------------
-- Table structure for t_filterlist
-- ----------------------------
DROP TABLE IF EXISTS `t_filterlist`;
CREATE TABLE `t_filterlist`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `analyse` int(11) NULL DEFAULT NULL COMMENT '0,不分析，白名单；1，分析，黑名单',
  `name` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '支持特殊字符',
  `creator` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createtime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_filterlist
-- ----------------------------
INSERT INTO `t_filterlist` VALUES (-2, 0, '内置白名单1', 'admin', '2019-06-27 17:29:49');
INSERT INTO `t_filterlist` VALUES (-1, 0, '内置白名单', 'admin', '2019-06-27 17:12:43');

-- ----------------------------

-- ----------------------------
-- Table structure for t_flow_ids_policy
-- ----------------------------
DROP TABLE IF EXISTS `t_flow_ids_policy`;
CREATE TABLE `t_flow_ids_policy`  (
  `ids_policy_id` varbinary(64) NOT NULL COMMENT 'IDS策略id',
  `tenant_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '租户ID',
  `security_policy_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '引用安全策略ID（列表），每个IPS策略对应至少一个安全策略',
  `ids_policy_template_id` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IDS策略模板id（1：低级防护模板，2：中级防护模板，3：高级防护模板）（AXDR仅存储）',
  `ids_policy_template_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IDS策略模板名称（AXDR仅存储）',
  `enable` tinyint(1) NOT NULL COMMENT '是否启用，0:不启用，1:启用',
  `logging` tinyint(1) NOT NULL COMMENT '是否开启日志记录，0:不启用，1:启用（AXDR不支持，仅存储）',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '策略描述',
  `linked_strategy_id` bigint(20) NOT NULL COMMENT '联动策略ID',
  PRIMARY KEY (`ids_policy_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'STY电信接口规范IDS策略表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_flow_ids_policy
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_flow_security_policy
-- ----------------------------
DROP TABLE IF EXISTS `t_flow_security_policy`;
CREATE TABLE `t_flow_security_policy`  (
  `security_policy_id` varbinary(64) NOT NULL COMMENT '安全策略id',
  `tenant_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '租户ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '策略名称',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '策略描述',
  `priority` tinyint(1) NULL DEFAULT NULL COMMENT '安全策略优先级序号（租户级），1为最上/优先策略（AXDR目前没有策略优先级，仅存储）',
  `src_zone` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '源区域（AXDR仅存储）',
  `dst_zone` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目的区域（AXDR仅存储）',
  `protocol` tinyint(1) NULL DEFAULT NULL COMMENT '协议类型，0: ipv4, 1: ipv6（AXDR目前仅支持IPv4）',
  `src_address` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '源地址对象，支持ip_object_id或ip_group_object_id，上限为1000个',
  `dst_address` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '目的地址，支持ip_object_id或ip_group_object_id，上限为1000个',
  `service_items` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '服务对象，service_object_id或service_group_object_id（AXDR仅存储）',
  `time_items` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '时间对象，time_object_id，默认为[”any”]（AXDR仅支持”any”--永久策略）',
  `app_items` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '应用对象，app_object_id（AXDR仅存储）',
  `url_items` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'URL对象，url_object_id（AXDR仅存储）',
  `action` tinyint(1) NOT NULL COMMENT '动作，0:deny,1:allow（AXDR仅支持\"deny\"--封禁）',
  `logging` tinyint(1) NOT NULL COMMENT '是否开启日志记录，0:不启用，1:启用（AXDR不支持，仅存储）',
  `enable` tinyint(1) NOT NULL COMMENT '是否启用，0:不启用，1:启用（AXDR仅存储）',
  PRIMARY KEY (`security_policy_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'STY电信接口规范安全策略表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_flow_security_policy
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_index
-- ----------------------------
DROP TABLE IF EXISTS `t_index`;
CREATE TABLE `t_index`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '索引名称',
  `days` int(11) NULL DEFAULT NULL COMMENT '开启天数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_index
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_inner_ip_config
-- ----------------------------
DROP TABLE IF EXISTS `t_inner_ip_config`;
CREATE TABLE `t_inner_ip_config`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Id',
  `globalMonitor` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '全局监控',
  `monitorArea` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '监控地区',
  `ipConfStr` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ip、ip区间、子网掩码配置',
  `uiIpConfStr` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'Ip、ip区间、子网掩码对应前端位置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_inner_ip_config
-- ----------------------------
INSERT INTO `t_inner_ip_config` VALUES ('inner_4d9fc34d-e1ca-41d8-9c75-f3041c3b6675_1537173372312', '内部ip', '', '{\"ipInterval\":[[\"10.0.0.0\",\"10.255.255.255\"],[\"172.16.0.0\",\"172.31.255.255\"],[\"192.168.0.0\",\"192.168.255.255\"]],\"ip\":[\"127.0.0.1\"],\"subnetMask\":[]}', '{\"ipInterval\":[1,2,3],\"ip\":[0],\"subnetMask\":[]}');

-- ----------------------------

-- ----------------------------
-- Table structure for t_intelligence_knowledge_family
-- ----------------------------
DROP TABLE IF EXISTS `t_intelligence_knowledge_family`;
CREATE TABLE `t_intelligence_knowledge_family`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '唯一ID编号，可以和情报中family_id做关联',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家族名称',
  `alias` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '别名',
  `organization_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `organization_names` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '关联组织名称',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '详情描述',
  `os` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '该家族影响的平台',
  `refs` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '家族信息参考链接',
  `expired` tinyint(1) NULL DEFAULT NULL COMMENT '是否失效，false -未失效，true- 已失效',
  `update_time` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '更新时间，毫秒级时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_intelligence_knowledge_family
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_intelligence_knowledge_org
-- ----------------------------
DROP TABLE IF EXISTS `t_intelligence_knowledge_org`;
CREATE TABLE `t_intelligence_knowledge_org`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '唯一ID编号，可以和情报中organization_id做关联',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织名称',
  `attack_method` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '攻击方法',
  `regions` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '团伙所在国家/地区',
  `industries` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '受影响的行业',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '详情描述',
  `os` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '该家族影响的系统',
  `refs` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '报告链接',
  `expired` tinyint(1) NULL DEFAULT NULL COMMENT '是否失效，false -未失效，true- 已失效',
  `update_time` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '更新时间，毫秒级时间戳',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_intelligence_knowledge_org
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_intelligence_source_function
-- ----------------------------
DROP TABLE IF EXISTS `t_intelligence_source_function`;
CREATE TABLE `t_intelligence_source_function`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '情报源功能ID',
  `intelligence_source_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源英文标识',
  `function` enum('ONLINE_UPDATE','OFFLINE_UPDATE','API_UPDATE','EXPORT','INTELLIGENCE_ADD','INTELLIGENCE_DELETE','INTELLIGENCE_MODIFY','INTELLIGENCE_RETRIEVE','INTELLIGENCE_RETRIEVE_BY_API','SETUP','MANAGE','REMOVE','CLONE','DEVICE_INFO') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源功能名称',
  `type` enum('tab','button','operate') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源功能类型：tab-标签页(情报数据更新、导出等操作需要另起tab页)；button-按钮(情报源自身操作，设置、管理、移除、克隆)；operate-操作(情报操作，增删改查等)',
  `enable` tinyint(4) NOT NULL DEFAULT 1 COMMENT '情报源功能启禁用',
  `description` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '情报源功能描述',
  `config` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '情报源功能配置，JSONObject格式',
  `operations` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '情报源功能包含的操作、按钮等，JSONArray格式',
  `order` tinyint(4) NOT NULL COMMENT '功能顺序',
  `display` tinyint(4) NOT NULL DEFAULT 1 COMMENT '情报源功能是否展示',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_intelligenceSourceId_function`(`intelligence_source_code`, `function`) USING BTREE,
  CONSTRAINT `foreign_key_function_to_source` FOREIGN KEY (`intelligence_source_code`) REFERENCES `t_intelligence_source_metadata` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '情报源功能，存储所有情报源功能数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_intelligence_source_function
-- ----------------------------
INSERT INTO `t_intelligence_source_function` VALUES (1, 'ThreatIntelligenceCentreSource', 'OFFLINE_UPDATE', '离线更新', 'tab', 1, '可通过以下方式获取威胁情报许可：\n1、导出许可申请文件\n2、登录安恒公司内网，将导出的申请文件发送 http://t.dbappsecurity.com.cn ，订阅威胁情报', '{\"belongTo\":\"OFFLINE_UPDATE\"}', '{\"ExportLicenseFile\":{\"name\":\"导出许可申请文件\",\"operation\":\"ExportLicenseFile\"},\"UploadUpdatePackage\":{\"name\":\"上传更新包\",\"operation\":\"UploadUpdatePackage\"}}', 1, 1);
INSERT INTO `t_intelligence_source_function` VALUES (2, 'ThreatIntelligenceCentreSource', 'ONLINE_UPDATE', '在线更新', 'tab', 0, '', '{\"belongTo\":\"ONLINE_UPDATE\",\"tiToken\":\"\"}', '{\"UpdateOnline\":{\"name\":\"在线更新\",\"operation\":\"UpdateOnline\"},\"UserExperienceProgram\":{\"name\":\"参加\\\"AiLPHA用户体验改善计划\\\"\",\"operation\":\"UserExperienceProgram\",\"value\":false},\"ConnectivityTest\":{\"name\":\"连通性测试\",\"operation\":\"ConnectivityTest\"},\"UpdateNow\":{\"name\":\"立即更新\",\"operation\":\"UpdateNow\"},\"ProxyConfiguration\":{\"name\":\"代理配置\",\"operation\":\"ProxyConfiguration\"},\"DNSConfiguration\":{\"name\":\"DNS配置\",\"operation\":\"DNSConfiguration\"}}', 2, 1);
INSERT INTO `t_intelligence_source_function` VALUES (3, 'ThreatIntelligenceCentreSource', 'API_UPDATE', 'Api更新', 'tab', 0, '', '{\"belongTo\":\"API_UPDATE\"}', '', 3, 0);
INSERT INTO `t_intelligence_source_function` VALUES (4, 'ThreatIntelligenceCentreSource', 'EXPORT', '情报导出', 'tab', 0, '暂不支持', '{\"belongTo\":\"EXPORT\"}', '{\"GenerateExportFile\":{\"name\":\"生成情报导出文件\",\"operation\":\"GenerateExportFile\"},\"Download\":{\"name\":\"下载\",\"operation\":\"Download\"}}', 4, 0);
INSERT INTO `t_intelligence_source_function` VALUES (5, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_ADD', '情报新增', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_ADD\"}', '', 5, 0);
INSERT INTO `t_intelligence_source_function` VALUES (6, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_DELETE', '情报删除', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_DELETE\"}', '', 6, 0);
INSERT INTO `t_intelligence_source_function` VALUES (7, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_MODIFY', '情报修改', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_MODIFY\"}', '', 7, 0);
INSERT INTO `t_intelligence_source_function` VALUES (8, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_RETRIEVE', '情报检索', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE\"}', '', 8, 1);
INSERT INTO `t_intelligence_source_function` VALUES (9, 'ThreatIntelligenceCentreSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"ONLINE_UPDATE\"]}', '', 9, 0);
INSERT INTO `t_intelligence_source_function` VALUES (10, 'ThreatIntelligenceCentreSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 10, 0);
INSERT INTO `t_intelligence_source_function` VALUES (11, 'ThreatIntelligenceCentreSource', 'REMOVE', '移除', 'button', 0, '', '{\"belongTo\":\"REMOVE\"}', '', 11, 0);
INSERT INTO `t_intelligence_source_function` VALUES (12, 'ThreatIntelligenceCentreSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 12, 0);
INSERT INTO `t_intelligence_source_function` VALUES (13, 'WeiBuApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[{\"name\":\"微步TIP情报失陷检测接口\",\"code\":\"WeiBuV4Dns\",\"use\":0,\"tag\":1,\"method\":\"GET\",\"protocol\":\"http\",\"domain\":\"TIP:PORT\",\"path\":\"/tip_api/v4/dns\",\"params\":[{\"key\":\"apikey\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，在微步TIP平台的平台管理-业务管理-业务接入页面生成\",\"isIoC\":false},{\"key\":\"resource\",\"value\":\"www.baidu.com\",\"description\":\"IP地址或域名，查询情报IoC样例\",\"isIoC\":true}],\"demo\":\"http://TIP:PORT/tip_api/v4/dns?apikey=YOUR-KEY&resource=www.baidu.com\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"\"},{\"name\":\"微步TIP情报IP信誉接口\",\"code\":\"WeiBuV4Ip\",\"use\":0,\"tag\":2,\"method\":\"GET\",\"protocol\":\"http\",\"domain\":\"TIP:PORT\",\"path\":\"/tip_api/v4/ip\",\"params\":[{\"key\":\"apikey\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，在微步TIP平台的平台管理-业务管理-业务接入页面生成\",\"isIoC\":false},{\"key\":\"resource\",\"value\":\"192.168.1.1\",\"description\":\"IP地址，查询情报IoC样例\",\"isIoC\":true}],\"demo\":\"http://TIP:PORT/tip_api/v4/ip?apikey=YOUR-KEY&resource=192.168.1.1\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"\"}]}', '', 1, 1);
INSERT INTO `t_intelligence_source_function` VALUES (14, 'WeiBuApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);
INSERT INTO `t_intelligence_source_function` VALUES (15, 'WeiBuApiIntelligenceSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 3, 1);
INSERT INTO `t_intelligence_source_function` VALUES (16, 'WeiBuApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);
INSERT INTO `t_intelligence_source_function` VALUES (17, 'WeiBuApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);
INSERT INTO `t_intelligence_source_function` VALUES (18, 'NSFOCUSApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[]}', '', 1, 1);
INSERT INTO `t_intelligence_source_function` VALUES (19, 'NSFOCUSApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);
INSERT INTO `t_intelligence_source_function` VALUES (20, 'NSFOCUSApiIntelligenceSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 3, 1);
INSERT INTO `t_intelligence_source_function` VALUES (21, 'NSFOCUSApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);
INSERT INTO `t_intelligence_source_function` VALUES (22, 'NSFOCUSApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);
INSERT INTO `t_intelligence_source_function` VALUES (23, 'TianJiPartnersApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[]}', '', 1, 1);
INSERT INTO `t_intelligence_source_function` VALUES (24, 'TianJiPartnersApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);
INSERT INTO `t_intelligence_source_function` VALUES (25, 'TianJiPartnersApiIntelligenceSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 3, 1);
INSERT INTO `t_intelligence_source_function` VALUES (26, 'TianJiPartnersApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);
INSERT INTO `t_intelligence_source_function` VALUES (27, 'TianJiPartnersApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);

-- ----------------------------

-- ----------------------------
-- Table structure for t_intelligence_source_log
-- ----------------------------
DROP TABLE IF EXISTS `t_intelligence_source_log`;
CREATE TABLE `t_intelligence_source_log`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '更新日志ID',
  `intelligence_source_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源英文标识',
  `update_type` enum('ONLINE_UPDATE','OFFLINE_UPDATE','API_UPDATE','EXPORT','INTELLIGENCE_ADD','INTELLIGENCE_DELETE','INTELLIGENCE_MODIFY','INTELLIGENCE_RETRIEVE','INTELLIGENCE_RETRIEVE_BY_API') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报操作类型',
  `operator` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作人',
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作者ip',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `state` int(11) NULL DEFAULT NULL COMMENT '操作状态，0-开始，1-进行中，2-成功，3-失败，4-取消，5-异常，大于1为结束',
  `progress` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作进度',
  `log` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注，操作日志',
  `effective_rows` int(11) NOT NULL DEFAULT 0 COMMENT '影响情报数据量',
  `failed_rows` int(11) NOT NULL DEFAULT 0 COMMENT '失败情报数',
  `file` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '情报导入包名称',
  `delete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '所属情报库是否被删除，0-false，1-true',
  `dasca_device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'dasca_device_id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_intelligence_source_log
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_intelligence_source_metadata
-- ----------------------------
DROP TABLE IF EXISTS `t_intelligence_source_metadata`;
CREATE TABLE `t_intelligence_source_metadata`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '情报源ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源名称',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源英文标识（用以关联操作）',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '情报源图标',
  `type` enum('local','API') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源类型：local-本地情报源；API-API情报源',
  `subtype` enum('custom','build-in') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源子类型：custom-自定义情报源；build-in-内置情报源',
  `knowledge` tinyint(4) NULL DEFAULT 0 COMMENT '情报源是否包含知识库：0-不包含知识库；1-包含只是库，当前仅威胁情报中心具有知识库',
  `flag` tinyint(4) NULL DEFAULT 1 COMMENT '情报源标记，1-显示（所有正常工作的情报源），0-不显示（内置情报源但默认未添加状态，如微步、绿盟、天际友盟）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `app_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'app标识',
  `dasca_device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'dasca_device_id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '情报源，存储所有情报源数据' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_intelligence_source_metadata
-- ----------------------------
INSERT INTO `t_intelligence_source_metadata` VALUES (1, '安恒威胁情报中心', 'ThreatIntelligenceCentreSource', 'dbapp', 'local', 'build-in', 1, 1, '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, NULL);
INSERT INTO `t_intelligence_source_metadata` VALUES (2, '微步威胁情报TIP平台', 'WeiBuApiIntelligenceSource', 'weibu', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50', NULL, NULL);
INSERT INTO `t_intelligence_source_metadata` VALUES (3, '绿盟威胁情报TIP平台', 'NSFOCUSApiIntelligenceSource', 'lvmeng', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50', NULL, NULL);
INSERT INTO `t_intelligence_source_metadata` VALUES (4, '天际友盟威胁情报TIP平台', 'TianJiPartnersApiIntelligenceSource', 'tianji', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50', NULL, NULL);

-- ----------------------------

-- ----------------------------
-- Table structure for t_knowledge_port
-- ----------------------------
DROP TABLE IF EXISTS `t_knowledge_port`;
CREATE TABLE `t_knowledge_port`  (
  `port_id` int(11) NOT NULL COMMENT '端口号',
  `port_name` varchar(140) CHARACTER SET utf8 COLLATE utf8_danish_ci NULL DEFAULT NULL COMMENT '端口名称',
  `port_detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_danish_ci NULL DEFAULT NULL COMMENT '端口描述',
  `risk_level` int(1) UNSIGNED ZEROFILL NOT NULL COMMENT '风险等级 0：无风险 1：有风险',
  `vulnerability` varchar(510) CHARACTER SET utf8 COLLATE utf8_danish_ci NULL DEFAULT NULL COMMENT '相关漏洞',
  `frequency` int(1) NULL DEFAULT NULL COMMENT '使用频率',
  `port_protocol_v7` varchar(40) CHARACTER SET utf8 COLLATE utf8_danish_ci NULL DEFAULT NULL COMMENT '端口协议7层',
  `port_protocol_v4` varchar(40) CHARACTER SET utf8 COLLATE utf8_danish_ci NULL DEFAULT NULL COMMENT '端口协议4层 TCP UDP',
  PRIMARY KEY (`port_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_knowledge_port
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_kpi_statistic
-- ----------------------------
DROP TABLE IF EXISTS `t_kpi_statistic`;
CREATE TABLE `t_kpi_statistic`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '表结构本身的自增主键',
  `org_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '组织id',
  `un_closed_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '选定时间段内指派给对应组织且未关闭(关闭重新开启也算在内)的工单数量',
  `pending_order_24h` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '选定时间段内滞留时间超过24小时的工单数',
  `pending_order_3d` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '选定时间段内滞留时间超过3天的工单数',
  `pending_order_7d` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '选定时间段内滞留时间超过7天的工单数',
  `asset` bigint(21) UNSIGNED NOT NULL DEFAULT 0 COMMENT '根据组织架构与安全域绑定的关系，判断现有组织下的资产总数',
  `risk_asset` bigint(21) UNSIGNED NOT NULL DEFAULT 0 COMMENT '根据组织架构与安全域绑定的关系，判断现有组织下的风险资产总数(资产感知中统计: 失陷资产+高风险资产+低风险资产)',
  `risk_percent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0%' COMMENT '根据组织架构与安全域绑定的关系，现有组织下风险资产总数/现有组织下资产总数',
  `period` enum('week','month') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据所属周期: week, 周, month, 月',
  `deadline` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '记录数据时的时间, yyyy-MM-dd HH:mm:ss',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `table.hash.unique.key.org_id.period.deadline`(`org_id`, `period`, `deadline`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_kpi_statistic
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_layout_notice_history
-- ----------------------------
DROP TABLE IF EXISTS `t_layout_notice_history`;
CREATE TABLE `t_layout_notice_history`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `layout_task_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '剧本编排的唯一主键',
  `assignee_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知人的id',
  `assignee_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知人的name',
  `notice_way` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '通知方式',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知内容',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'success' COMMENT '状态',
  `failure_msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '失败原因',
  `serial_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '-' COMMENT '编号',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `table.hash.key.layout_task_id`(`layout_task_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_layout_notice_history
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_license
-- ----------------------------
DROP TABLE IF EXISTS `t_license`;
CREATE TABLE `t_license`  (
  `uuid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '合同类型：AILPHA、AIVIEW',
  `machine_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `version` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '版本号',
  `build` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'build号，最后一次commit的id',
  `online` int(11) NOT NULL DEFAULT 0 COMMENT '在线状态。0:离线，1在线。',
  `license_filename` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '许可证文件名',
  `license_content` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '许可内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sync` int(11) NOT NULL DEFAULT 1 COMMENT '是否要将许可内容同步给AiView.0不需要，1需要。',
  `timeout` int(11) NOT NULL DEFAULT 1 COMMENT '是否过期，程序需要在宿主机执行，由AiView发送过来。0未过期，1过期。',
  `device_model` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备型号',
  PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_license
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_linkage_device
-- ----------------------------
DROP TABLE IF EXISTS `t_linkage_device`;
CREATE TABLE `t_linkage_device`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备名称',
  `ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备ip',
  `port` int(5) UNSIGNED NULL DEFAULT 0 COMMENT '设备端口号',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'down' COMMENT '设备是否可用up-不可用,down-可用',
  `category_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备分类来自soc',
  `type` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备类型',
  `type_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '类型名称和type对应',
  `bean_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'spring beanName',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `other` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其他信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_linkage_device
-- ----------------------------

-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
