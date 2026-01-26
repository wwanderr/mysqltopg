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
-- Table structure for t_sev_agent_events
-- ----------------------------
DROP TABLE IF EXISTS `t_sev_agent_events`;
CREATE TABLE `t_sev_agent_events`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agent_code` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'agent唯一标识',
  `event_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '事件类型，upgrade：升级，reloadConfig：配置更新',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '事件状态，begin：开始，finish：结束',
  `result` tinyint(1) NULL DEFAULT NULL COMMENT '事件结果',
  `message` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述信息',
  `data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '数据信息，json',
  `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '事件时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_sev_agent_events_FK`(`agent_code`) USING BTREE,
  CONSTRAINT `t_sev_agent_events_FK` FOREIGN KEY (`agent_code`) REFERENCES `t_sev_agent_info` (`agent_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 94 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事件记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sev_agent_events
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_sev_agent_info
-- ----------------------------
DROP TABLE IF EXISTS `t_sev_agent_info`;
CREATE TABLE `t_sev_agent_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agent_code` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'agent英文名 - agent唯一标识',
  `agent_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'agent中文名，设备名称，默认设备IP',
  `agent_ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'agent地址，设备IP',
  `agent_ip_num` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'IP地址统一转16进制字符串',
  `agent_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'agent类型（AiNTA、APT、SOC）',
  `machine_code` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机器码',
  `device_model` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备型号',
  `soft_version` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '程序版本',
  `rule_version` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则版本',
  `intelligence_version` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '情报库版本',
  `config_version` bigint(20) NULL DEFAULT NULL COMMENT '探针设备的配置版本号，时间戳',
  `single_login_uri` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单点登录的地址',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '程序状态',
  `org_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组织id',
  `regist_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `monitor_id` bigint(20) NULL DEFAULT NULL,
  `upgrade_log_id` int(6) NULL DEFAULT NULL COMMENT '升级记录id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_agent_info_UN`(`agent_code`) USING BTREE,
  INDEX `t_agent_info_FK`(`agent_type`) USING BTREE,
  INDEX `t_agent_info_regist_time_IDX`(`regist_time`) USING BTREE,
  INDEX `t_sev_agent_info_config_version_IDX`(`config_version`) USING BTREE,
  CONSTRAINT `t_agent_info_FK` FOREIGN KEY (`agent_type`) REFERENCES `t_sev_agent_type` (`agent_type`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '探针信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sev_agent_info
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_sev_agent_license
-- ----------------------------
DROP TABLE IF EXISTS `t_sev_agent_license`;
CREATE TABLE `t_sev_agent_license`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agent_code` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'agent唯一标识',
  `license_code` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '许可申请内容(新) 许可申请码(老)',
  `product_sn` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品序列号',
  `file_name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请文件名',
  `license_type` int(1) NULL DEFAULT NULL COMMENT '合同类型，0：试用；1：正式',
  `version` int(11) NOT NULL DEFAULT 0 COMMENT '许可版本号，自增序列，每次更新+1',
  `expire_time` date NOT NULL COMMENT '许可证到期时间',
  `file_uuid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '许可文件uuid',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_agent_license_FK_1`(`file_uuid`) USING BTREE,
  INDEX `t_sev_agent_license_FK`(`agent_code`) USING BTREE,
  CONSTRAINT `t_agent_license_FK_1` FOREIGN KEY (`file_uuid`) REFERENCES `t_bs_files` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_sev_agent_license_FK` FOREIGN KEY (`agent_code`) REFERENCES `t_sev_agent_info` (`agent_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '探针许可文件信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sev_agent_license
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_sev_agent_monitor
-- ----------------------------
DROP TABLE IF EXISTS `t_sev_agent_monitor`;
CREATE TABLE `t_sev_agent_monitor`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agent_code` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'agent唯一标识',
  `agent_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cpu_usage` double(5, 2) NULL DEFAULT NULL COMMENT 'CPU使用率，百分制',
  `memory_total` double NULL DEFAULT NULL COMMENT '内存总量，单位B',
  `memory_use` double NULL DEFAULT NULL COMMENT '内存使用量，单位B',
  `disk_total` double NULL DEFAULT NULL COMMENT '磁盘总量，单位B',
  `disk_use` double NULL DEFAULT NULL COMMENT '磁盘使用量，单位B',
  `metric1` double NULL DEFAULT NULL COMMENT 'AiNTA：日志量(eps)；APT：已检测文件数量(个)',
  `metric2` double NULL DEFAULT NULL COMMENT 'AiNTA：流量(bps)；APT，待检测文件数量(个)',
  `metric3` double NULL DEFAULT NULL COMMENT 'AiNTA：本日日志数；APT：本日已检测文件数(个)',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_agent_monitor_FK`(`agent_code`) USING BTREE,
  INDEX `t_sev_agent_monitor_create_time_IDX`(`create_time`) USING BTREE,
  CONSTRAINT `t_agent_monitor_FK` FOREIGN KEY (`agent_code`) REFERENCES `t_sev_agent_info` (`agent_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1225601 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '探针监控表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sev_agent_monitor
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_sev_agent_package
-- ----------------------------
DROP TABLE IF EXISTS `t_sev_agent_package`;
CREATE TABLE `t_sev_agent_package`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agent_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'agent类型（AiNTA、APT、SOC）',
  `package_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '升级包类型（software、rule、intelligence）',
  `package_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '版本号',
  `depend_software` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '依赖软件版本',
  `file_uuid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '升级包文件uuid',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '升级包文件名',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `upload_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上传方式',
  `file_size` bigint(20) NOT NULL COMMENT '文件大小',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_agent_package_FK`(`agent_type`) USING BTREE,
  INDEX `t_agent_package_FK_1`(`file_uuid`) USING BTREE,
  CONSTRAINT `t_agent_package_FK` FOREIGN KEY (`agent_type`) REFERENCES `t_sev_agent_type` (`agent_type`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_agent_package_FK_1` FOREIGN KEY (`file_uuid`) REFERENCES `t_bs_files` (`uuid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '探针升级包信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sev_agent_package
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_sev_agent_rule_closed
-- ----------------------------
DROP TABLE IF EXISTS `t_sev_agent_rule_closed`;
CREATE TABLE `t_sev_agent_rule_closed`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `rule_closed_id` bigint(20) NOT NULL COMMENT '探针类型与关闭规则关联表id',
  `agent_code` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '探针设备唯一标识',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '标记是否删除',
  `config_version` bigint(20) NOT NULL COMMENT '配置版本号，创建时间戳，毫秒值',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_sev_agent_rule_closed_UN`(`rule_closed_id`, `agent_code`) USING BTREE,
  INDEX `t_sev_agent_rule_closed_FK_1`(`agent_code`) USING BTREE,
  CONSTRAINT `t_sev_agent_rule_closed_FK` FOREIGN KEY (`rule_closed_id`) REFERENCES `t_sev_agent_type_rule_closed` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_sev_agent_rule_closed_FK_1` FOREIGN KEY (`agent_code`) REFERENCES `t_sev_agent_info` (`agent_code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '探针设备与关闭规则关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sev_agent_rule_closed
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_sev_agent_type
-- ----------------------------
DROP TABLE IF EXISTS `t_sev_agent_type`;
CREATE TABLE `t_sev_agent_type`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agent_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'agent类型（AiNTA、APT、SOC）',
  `agent_type_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'agent类型名称',
  `description` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'agent描述',
  `support_version` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支持的最小软件版本',
  `license_pattern` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '许可文件名校验正则',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_agent_type_UN`(`agent_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '探针类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sev_agent_type
-- ----------------------------
INSERT INTO `t_sev_agent_type` VALUES (10, 'APT', '流量探针(APT)', NULL, NULL, '^license.dat$');
INSERT INTO `t_sev_agent_type` VALUES (11, 'APT_SandBox', '沙箱', NULL, NULL, '^license.dat$');
INSERT INTO `t_sev_agent_type` VALUES (12, 'AiNTA', '流量探针(AiNTA)', NULL, NULL, '^lic_AiNTA_([a-z0-9A-Z]*-?)*[\\u4e00-\\u9fa5]?_\\d{6}.dat$');
INSERT INTO `t_sev_agent_type` VALUES (13, 'EDR', '安恒EDR', NULL, NULL, '^license.dat$');

-- ----------------------------

-- ----------------------------
-- Table structure for t_sev_agent_type_rule_closed
-- ----------------------------
DROP TABLE IF EXISTS `t_sev_agent_type_rule_closed`;
CREATE TABLE `t_sev_agent_type_rule_closed`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agent_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '探针类型',
  `rule_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规则id',
  `remarks` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `update_history_alarm` tinyint(1) NULL DEFAULT NULL COMMENT '是否将最近7天告警标记为 已处置-误报',
  `data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '附加信息，回跳告警列表查询字段',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '标记是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_sev_agent_type_rule_closed_UN`(`agent_type`, `rule_id`) USING BTREE,
  CONSTRAINT `t_sev_agent_type_rule_closed_FK` FOREIGN KEY (`agent_type`) REFERENCES `t_sev_agent_type` (`agent_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '探针类型与需要关闭规则关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sev_agent_type_rule_closed
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_sev_file_chunk
-- ----------------------------
DROP TABLE IF EXISTS `t_sev_file_chunk`;
CREATE TABLE `t_sev_file_chunk`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名',
  `chunk_number` int(11) NULL DEFAULT NULL COMMENT '当前分片，从1开始',
  `chunk_size` float NULL DEFAULT NULL COMMENT '分片大小',
  `current_chunk_size` float NULL DEFAULT NULL COMMENT '当前分片大小',
  `total_size` double NULL DEFAULT NULL COMMENT '文件总大小',
  `chunk_end` bigint(20) NULL DEFAULT NULL COMMENT '分片结束位置',
  `chunk_start` bigint(20) NULL DEFAULT NULL COMMENT '分片起始位置',
  `total_chunk` int(11) NULL DEFAULT NULL COMMENT '总分片数',
  `identifier` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'md5校验码',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '每一次分段下载，共用一个uuid',
  `save_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '本次下载目录',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sev_file_chunk
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_site
-- ----------------------------
DROP TABLE IF EXISTS `t_site`;
CREATE TABLE `t_site`  (
  `_id` int(11) NOT NULL AUTO_INCREMENT,
  `sitename` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '站点名称',
  `domain` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '站点域名',
  `ip` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'IP地址',
  `port` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '端口号',
  PRIMARY KEY (`_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_site
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_situation_awareness
-- ----------------------------
DROP TABLE IF EXISTS `t_situation_awareness`;
CREATE TABLE `t_situation_awareness`  (
  `id` bigint(20) NOT NULL,
  `awareness_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `brief` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_situation_awareness
-- ----------------------------
INSERT INTO `t_situation_awareness` VALUES (1, 'ExternalAttack', '外部攻击态势', '外部攻击态势主要关注来自全世界不同地区的攻击源对企业内部资产的威胁情况，实时监控境内境外攻击源的地域分布和国家排行，掌握各攻击链阶段的威胁变化趋势和最新外部攻击事件。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (2, 'CrossThreat', '横向威胁感知', '横向威胁感知主要关注企业内部资产之间的违规操作和病毒传播，实时监控跨安全域的访问行为和业务系统访问情况，通过自由布局和圆形布局观测资产之间的威胁关系，及时发现并制止违规资产对企业内网环境造成的破坏。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (3, 'AssetsConnection', '资产外连风险态势', '资产外连风险态势主要关注企业内网存在回连行为和对外攻击的风险资产，实时监控外连行为变化趋势、最新外连事件、外连目的国家等，掌握企业内部资产的C&C回连情况和远控团伙信息。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (4, 'Monitor', 'WEB安全态势', 'WEB安全态势监控WEB服务的被访问状态和受攻击情况，包括网站区域访问量，访问地区排行，攻击网站排行，攻击类型排行，网站访问和攻击变化趋势等。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (5, 'SafaWarn', '内网安全态势', '内网安全态势通过3D逻辑安全域展示网络系统内发生的安全事件的攻击路径、攻击手法和影响范围，支持关联用户的网络和安全域划分，支持根据具体的资产和安全域的方式告警，可以为用户提供攻击者的溯源信息以及安全事件的处置建议。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (6, 'AI_analysis', 'AI异常分析', 'AI异常分析将AI算法与观测指标结合发现网络中断异常活动和新型威胁，多种AI分析场景配合算法特征将实时数据、拟合数据、评价参数共同呈现。异常信息通过红色点或区域高亮标注，点击异常标注可弹出异常信息详情窗口，辅助用户进行分析钻取和异常定位。多场景异常分布情况通过泳道图汇总到同一时间轴，用户可及时感知某时刻安全风险的集中爆发。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (7, 'SherlockScreen', 'Sherlock大屏', '夏洛克(Sherlock)赋予你一双福尔摩斯的慧眼，帮你透视整个网络，追踪网络实体的连接关系，发现访问行为的蛛丝马迹。大数据标签画像分析寻找相似的受害团体和黑客组织，AI 算法加持发现 观测指标中隐藏的未知威胁，情报、弱点信息辅助安全事件的追根溯源。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (8, 'AssetsManageScreen', '资产态势感知', '资产态势感知通过资产卡片形式实时监控重大保障活动中的关键资产，利用标签切换不同的活动资产分组，及时发现并处置风险资产，保障用户业务的可持续平稳运行。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (9, 'TraceV2', '攻击者追踪溯源', '攻击者追踪溯源可视化分析大屏，为安全运维人员提供包括攻击行为分析、团伙分析、攻击取证信息、攻击趋势、攻击手段，攻击影响范围等信息，支持任意攻击者信息查询，可生成详细的攻击者溯源报告，并能够一键导出报告。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (10, 'AssetTrace', '资产威胁溯源', '资产威胁溯源可视化分析大屏，为安全运维人员提供包括被攻击行为分析、影响资产范围分析、攻击取证信息等，支持任意资产查询，可呈现被访问趋势、被攻击趋势、被攻击手段、资产状态，资产评分等信息。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (11, 'PortalScreen', '统一门户', '统一门户作为访问安全分析与管理平台中信息资源的统一入口，集成态势感知、业务拓扑、资产感知、威胁情报、通报预警等系统核心应用，总体提升企业安全运营和威胁应急响应工作效率。', '2026-01-13 10:37:41', NULL);
INSERT INTO `t_situation_awareness` VALUES (12, 'statusDetection', '平台运行状态监测', 'AiLPHA安全分析与管理平台运行状态监测，凸显AiLPHA具备来自全网安全设备的多元异构数据接入能力，打破数据孤岛，内置丰富的规则和知识库，利用多种计算分析引擎和安全分析工具，可长期保障用户全网资产安全，实时告警威胁情况。同时平台具备良好的数据存储和计算性能，支持动态扩容缩容，根据需求灵活配置。', '2026-01-13 10:37:41', NULL);

-- ----------------------------

-- ----------------------------
-- Table structure for t_soar_layout
-- ----------------------------
DROP TABLE IF EXISTS `t_soar_layout`;
CREATE TABLE `t_soar_layout`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `layout_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '剧本编排英文名',
  `layout_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剧本编排中文名',
  `model_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '模型英文名',
  `img` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '结构缩略图',
  `topo` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '前端拓扑结构',
  `is_enable` tinyint(1) NULL DEFAULT 1 COMMENT '编排启用禁用状态',
  `disable_reason` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剧本禁用原因，overLimit:任务数太多自动禁用，为空:界面手动禁用',
  `description` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剧本描述',
  `tags` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '剧本标签',
  `is_factory` tinyint(1) NULL DEFAULT 0 COMMENT '是否为出厂剧本编排',
  `elements` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '组成元素',
  `relational_map` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '组件的关联关系',
  `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '创建者',
  `handling_time` float NULL DEFAULT NULL COMMENT '预计人工处理时间，用于节省时间计算，单位小时',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_soar_layout_UN`(`layout_id`) USING BTREE,
  INDEX `t_model_layout_layout_name_IDX`(`layout_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '剧本编排' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_soar_layout
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_soar_layout_draft
-- ----------------------------
DROP TABLE IF EXISTS `t_soar_layout_draft`;
CREATE TABLE `t_soar_layout_draft`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pre_id` int(11) NULL DEFAULT NULL COMMENT '剧本主键id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `layout_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模型编排Id',
  `layout_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剧本编排中文名，为空标识纯草稿，t_soar_layout中不存在',
  `model_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '模型英文名',
  `description` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剧本描述',
  `tags` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '剧本标签',
  `topo` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '前端拓扑结构',
  `handling_time` float NULL DEFAULT NULL COMMENT '预计人工处理时间，用于节省时间计算，单位小时',
  `elements` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '分析组件',
  `relational_map` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '组件的关联关系',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_soar_layout_draft_UN`(`user_id`, `pre_id`) USING BTREE,
  INDEX `t_model_layout_real_time_layout_id_IDX`(`layout_id`) USING BTREE,
  INDEX `t_soar_layout_draft_FK_id`(`pre_id`) USING BTREE,
  CONSTRAINT `t_soar_layout_draft_FK` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_soar_layout_draft_FK_id` FOREIGN KEY (`pre_id`) REFERENCES `t_soar_layout` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模型' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_soar_layout_draft
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_soar_layout_history
-- ----------------------------
DROP TABLE IF EXISTS `t_soar_layout_history`;
CREATE TABLE `t_soar_layout_history`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `pre_id` int(11) NULL DEFAULT NULL COMMENT '剧本主键id',
  `layout_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剧本Id',
  `layout_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剧本名称',
  `description` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剧本描述',
  `model_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '模型Id',
  `model_id_order` int(11) NULL DEFAULT NULL COMMENT '最终输出模型id在elements中的下标位置',
  `elements` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '组成元素',
  `relational_map` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '组件的关联关系',
  `is_enable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '当前生效的记录',
  `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '创建人',
  `model_count` int(11) NULL DEFAULT NULL COMMENT '模型节点数量',
  `linkage_count` int(11) NULL DEFAULT NULL COMMENT '处置响应节点数量',
  `element_count` int(11) NULL DEFAULT NULL COMMENT '节点总数量',
  `handling_time` int(11) NULL DEFAULT NULL COMMENT '预计人工处理时间，用于节省时间计算，单位秒',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_model_layout_form_layout_id_IDX`(`layout_id`) USING BTREE,
  INDEX `t_soar_layout_history_FK`(`pre_id`) USING BTREE,
  INDEX `t_soar_layout_history_layout_name_IDX`(`layout_name`) USING BTREE,
  CONSTRAINT `t_soar_layout_history_FK` FOREIGN KEY (`pre_id`) REFERENCES `t_soar_layout` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模型编排历史记录，保证编排变更时，任务可以匹配数据' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_soar_layout_history
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_soar_notice_history
-- ----------------------------
DROP TABLE IF EXISTS `t_soar_notice_history`;
CREATE TABLE `t_soar_notice_history`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `notice_code` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通报记录code，定时处理通报，一批次code相同',
  `assignee_id` bigint(20) NOT NULL COMMENT '通知人的id',
  `assignee_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知人的name',
  `notice_way` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '通知方式',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '通知内容',
  `status` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'success' COMMENT '状态',
  `failure_msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '失败原因',
  `serial_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编号',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '记录创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_soar_notice_history_notice_code_IDX`(`notice_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通报记录表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_soar_notice_history
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_soar_task
-- ----------------------------
DROP TABLE IF EXISTS `t_soar_task`;
CREATE TABLE `t_soar_task`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务Id',
  `history_id` int(20) NOT NULL COMMENT '历史剧本Id',
  `layout_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '剧本id',
  `event_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '事件Id',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务名称，取告警事件名称',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '起始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '任务进度，running:进行中，cancel:取消，finish:完成',
  `status_percent` int(11) NULL DEFAULT NULL COMMENT '任务进度',
  `deal_time` int(11) NULL DEFAULT NULL COMMENT '处理时间',
  `save_time` int(11) NULL DEFAULT NULL COMMENT '节省时间',
  `message` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '告警信息',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_soar_task_layout_id_IDX`(`layout_id`, `status`) USING BTREE,
  INDEX `t_soar_task_FK`(`history_id`) USING BTREE,
  INDEX `t_soar_task_deal_time_IDX`(`deal_time`) USING BTREE,
  INDEX `t_soar_task_save_time_IDX`(`save_time`) USING BTREE,
  INDEX `t_soar_task_id_IDX`(`id`, `history_id`, `status`) USING BTREE,
  CONSTRAINT `t_soar_task_FK` FOREIGN KEY (`history_id`) REFERENCES `t_soar_layout_history` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务看板' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_soar_task
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_soar_task_action
-- ----------------------------
DROP TABLE IF EXISTS `t_soar_task_action`;
CREATE TABLE `t_soar_task_action`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `history_id` int(20) NULL DEFAULT NULL COMMENT '模块id',
  `order_idx` tinyint(8) NOT NULL COMMENT '模块内编号',
  `task_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '任务Id',
  `action_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作状态',
  `data` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预留字段，存储节点数据',
  `is_finish` tinyint(1) NOT NULL COMMENT '任务节点是否执行完成',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_model_layout_action_time_formId_IDX`(`history_id`, `order_idx`) USING BTREE,
  INDEX `t_soar_task_action_task_id_IDX`(`task_id`, `order_idx`) USING BTREE,
  INDEX `t_soar_task_action_data_IDX`(`data`) USING BTREE,
  INDEX `t_soar_task_action_action_time_IDX`(`action_time`) USING BTREE,
  CONSTRAINT `t_model_layout_action_time_FK_form_id` FOREIGN KEY (`history_id`) REFERENCES `t_soar_layout_history` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_soar_task_action_FK` FOREIGN KEY (`task_id`) REFERENCES `t_soar_task` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '任务操作详情' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of t_soar_task_action
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_soc_asset
-- ----------------------------
DROP TABLE IF EXISTS `t_soc_asset`;
CREATE TABLE `t_soc_asset`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assetId` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `identify` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `name` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `alias` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `categoryId` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `groupId` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `groupName` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `vendor` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `securityLevel` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `price` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `monitorDomainId` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `restrictMapperMode` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `importance` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `importime` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `tag` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `otherAttributeInfo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `updatetime` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `incidentHigh` bigint(20) NULL DEFAULT 0,
  `incidentMiddle` bigint(20) NULL DEFAULT 0,
  `incidentLow` bigint(20) NULL DEFAULT 0,
  `flawHigh` bigint(20) NULL DEFAULT 0,
  `flawMiddle` bigint(20) NULL DEFAULT 0,
  `flawLow` bigint(20) NULL DEFAULT 0,
  `score` double NULL DEFAULT 0,
  `categoryName` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `INDEX_UNIQ_IP`(`ip`(200)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_soc_asset
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_soc_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_soc_customer`;
CREATE TABLE `t_soc_customer`  (
  `area` int(11) NULL DEFAULT NULL,
  `note` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `salePersonId` int(11) NULL DEFAULT NULL,
  `descrip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` int(11) NULL DEFAULT NULL,
  `defaultCustomer` int(11) NULL DEFAULT NULL,
  `importance` int(11) NULL DEFAULT NULL,
  `pid` bigint(20) NULL DEFAULT NULL,
  `telephone` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uuid` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version` bigint(20) NULL DEFAULT NULL,
  `industryId` int(11) NULL DEFAULT NULL,
  `assetNumber` int(11) NULL DEFAULT NULL,
  `province` int(11) NULL DEFAULT NULL,
  `geoX` int(11) NULL DEFAULT NULL,
  `contact` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `geoY` int(11) NULL DEFAULT NULL,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `belongTo` int(11) NULL DEFAULT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `maxAssetNumber` int(11) NULL DEFAULT NULL,
  `email` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_soc_customer
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_system_config
-- ----------------------------
DROP TABLE IF EXISTS `t_system_config`;
CREATE TABLE `t_system_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `value` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值',
  `description` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `i_system_config_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_system_config
-- ----------------------------
INSERT INTO `t_system_config` VALUES (1, 'version', '1.0.0.0', '系统版本号', '2015-01-01 00:00:00', '2015-01-01 00:00:00');
INSERT INTO `t_system_config` VALUES (2, 'sqlUpdateRows', '0', '更新SQL已执行到的行数', '2015-01-01 00:00:00', '2015-01-01 00:00:00');
INSERT INTO `t_system_config` VALUES (3, 'maxPwdError', '3', '允许最大输入错误次数', '2015-01-01 00:00:00', '2015-01-01 00:00:00');
INSERT INTO `t_system_config` VALUES (4, 'locktime', '0', '超过指定次数后锁定时间，单位：分', '2015-01-01 00:00:00', '2015-01-01 00:00:00');
INSERT INTO `t_system_config` VALUES (5, 'errorIntervalTime', '10', '累计统计错误次数时间，单位：分', '2015-01-01 00:00:00', '2015-01-01 00:00:00');
INSERT INTO `t_system_config` VALUES (6, 'sessionTimeout', '30', '无操作退出时间，单位：分', '2015-01-01 00:00:00', '2015-01-01 00:00:00');
INSERT INTO `t_system_config` VALUES (7, 'p1title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');
INSERT INTO `t_system_config` VALUES (8, 'p2title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');
INSERT INTO `t_system_config` VALUES (9, 'p3title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');
INSERT INTO `t_system_config` VALUES (10, 'p4title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');
INSERT INTO `t_system_config` VALUES (11, 'p5title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');
INSERT INTO `t_system_config` VALUES (12, 'p6title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');
INSERT INTO `t_system_config` VALUES (13, 'p7title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');
INSERT INTO `t_system_config` VALUES (14, 'clientDomain', 'AiLPHA安全分析与管理平台', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');
INSERT INTO `t_system_config` VALUES (15, 'clientProvince', '浙江', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');

-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
