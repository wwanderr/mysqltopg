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
-- Table structure for t_report_tags
-- ----------------------------
DROP TABLE IF EXISTS `t_report_tags`;
CREATE TABLE `t_report_tags`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tag_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_report_tag_name_uni`(`tag_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_report_tags
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_risk_template
-- ----------------------------
DROP TABLE IF EXISTS `t_risk_template`;
CREATE TABLE `t_risk_template`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `mode` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '生成模式：simple-简单,balance-平衡,enhance-增强',
  `data_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据源：alert-告警,incident-安全事件',
  `rule_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '告警规则类型：specific-具体,base-基本',
  `code` int(10) NULL DEFAULT NULL COMMENT '事件编号',
  `uniq_code` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一编号，mode+data_source+rule_type+code',
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '事件名称',
  `event_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件类型',
  `top_event_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一级事件类型,英文code',
  `top_event_type_chinese` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一级事件类型中文',
  `second_event_type` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二级事件类型,英文code',
  `second_event_type_chinese` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二级事件类型中文',
  `filter_ip` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关注IP类型',
  `filter_content` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件过滤条件',
  `desc` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '事件的描述信息',
  `suggest` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '事件的解决措施',
  `child_desc` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '子事件的描述,展示关注对象的具体信息',
  `priority` tinyint(4) NULL DEFAULT NULL COMMENT '优先级（数字越小优先级越高）',
  `threat_severity` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件威胁等级',
  `alarm_results` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件告警结果',
  `enable` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用（0不启用，1启用）',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `filter_content_aiql` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件过滤条件Aiql',
  `netflow_log_field` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联网侧日志展示字段',
  `host_log_field` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联终端日志展示字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_risk_template_UN`(`uniq_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '风险事件模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_risk_template
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名',
  `description` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  `createuser` bigint(20) NOT NULL COMMENT '创建人',
  `createtime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateuser` bigint(20) NOT NULL COMMENT '修改人',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_switch` int(11) NOT NULL DEFAULT 1 COMMENT '列表展示是否可以更新：0不可以，1可以',
  `order` int(11) NOT NULL DEFAULT 0 COMMENT '列表排序：0不参与排序，非0可以',
  `delete_switch` int(11) NOT NULL DEFAULT 1 COMMENT '是否可以删除，0不可，1可以。',
  `role_type_id` int(11) NOT NULL COMMENT '角色类型id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `i_role_name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (1, '系统管理员', '系统管理员，拥有系统最高权限', 1, '2016-01-01 00:00:00', 1, '2016-01-01 00:00:00', 0, 6, 0, 1);
INSERT INTO `t_role` VALUES (2, '用户管理员', '仅有用户管理权限', 1, '2026-01-13 10:37:38', 1, '2026-01-13 10:37:38', 0, 0, 0, 7);
INSERT INTO `t_role` VALUES (3, '操作审计员', '仅有操作日志查看权限', 1, '2026-01-13 10:37:38', 1, '2026-01-13 10:37:38', 0, 0, 0, 6);
INSERT INTO `t_role` VALUES (5, '总部安服人员', NULL, 1, '2018-12-13 15:39:54', 1, '2026-01-13 10:37:40', 0, 4, 0, 3);
INSERT INTO `t_role` VALUES (6, '分部安全管理员', NULL, 1, '2018-12-13 15:39:54', 1, '2018-12-13 15:39:54', 0, 3, 0, 5);
INSERT INTO `t_role` VALUES (7, '总部安全管理员', NULL, 1, '2018-12-13 15:39:54', 1, '2018-12-13 15:39:54', 0, 5, 0, 2);
INSERT INTO `t_role` VALUES (8, '分部安服人员', NULL, 1, '2018-12-13 15:39:54', 1, '2018-12-13 15:39:54', 0, 2, 0, 4);
INSERT INTO `t_role` VALUES (9, '运维管理员', NULL, 1, '2018-12-13 15:39:54', 1, '2026-01-13 10:37:46', 0, 0, 0, 8);

-- ----------------------------

-- ----------------------------
-- Table structure for t_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE `t_role_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role` bigint(20) NOT NULL COMMENT '角色ID',
  `permission` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限表ID',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_role_permission_UN`(`role`, `permission`) USING BTREE,
  INDEX `idx_role`(`role`) USING BTREE,
  INDEX `t_role_permission_FK`(`permission`) USING BTREE,
  CONSTRAINT `t_role_permission_FK` FOREIGN KEY (`permission`) REFERENCES `t_permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------
INSERT INTO `t_role_permission` VALUES (1, 1, 'mirror:menu:Kpi', '2019-05-08 18:50:22', '2019-05-08 18:50:22');
INSERT INTO `t_role_permission` VALUES (6, 5, 'mirror:menu:Kpi', '2019-05-08 15:50:16', '2019-05-08 15:50:16');
INSERT INTO `t_role_permission` VALUES (7, 7, 'mirror:menu:Kpi', '2019-05-08 15:50:16', '2019-05-08 15:50:16');

-- ----------------------------

-- ----------------------------
-- Table structure for t_role_role_type
-- ----------------------------
DROP TABLE IF EXISTS `t_role_role_type`;
CREATE TABLE `t_role_role_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `role_type_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `default` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role_role_type
-- ----------------------------
INSERT INTO `t_role_role_type` VALUES (1, 6, 5, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);
INSERT INTO `t_role_role_type` VALUES (2, 8, 4, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);
INSERT INTO `t_role_role_type` VALUES (3, 7, 2, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);
INSERT INTO `t_role_role_type` VALUES (4, 5, 3, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);
INSERT INTO `t_role_role_type` VALUES (5, 3, 6, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);
INSERT INTO `t_role_role_type` VALUES (6, 2, 7, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);
INSERT INTO `t_role_role_type` VALUES (7, 1, 1, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);
INSERT INTO `t_role_role_type` VALUES (8, 4, 1, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);
INSERT INTO `t_role_role_type` VALUES (9, 9, 8, '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL);

-- ----------------------------

-- ----------------------------
-- Table structure for t_role_type
-- ----------------------------
DROP TABLE IF EXISTS `t_role_type`;
CREATE TABLE `t_role_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `describe` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色类型的描述信息',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `default` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `delete_switch` int(11) NOT NULL DEFAULT 1 COMMENT '是否支持删除：0不支持；1支持',
  `update_switch` int(11) NOT NULL DEFAULT 1 COMMENT '是否支持更新：0不支持；1支持',
  `add_switch` int(11) NOT NULL DEFAULT 1 COMMENT '是否支持新增：0不支持；1支持',
  `import_switch` int(11) NOT NULL DEFAULT 1 COMMENT '是否支持导入：0不支持；1支持',
  `export_switch` int(11) NOT NULL DEFAULT 1 COMMENT '是否支持导出；0不支持，1支持。',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_UNIQUE`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role_type
-- ----------------------------
INSERT INTO `t_role_type` VALUES (1, '系统管理员', '拥有系统最大数据权限和操作权限，主要负责整个系的正常运行及维护。只有组织架构为根节点（总部）的用户账号才能选择“系统管理员”类型的角色。系统已内置一个系统管理员：admin。', '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_role_type` VALUES (2, '总部安全管理员', '负责组织安全管理、组织内部安全问题的审批、处置、审核等工作。总部安全管理员拥有查看整个组织数据权限及大部分操作权限。', '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_role_type` VALUES (3, '总部安服人员', '负责组织内部安全测试、问题单提交，回归测试等工作。总部安服人员提交问题单给总部安全管理员审批，总部安全管理员下发问题单给总部安服人员处理。总部安服人员拥有查看整个组织的数据权限。', '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_role_type` VALUES (4, '分部安服人员', '负责组织内部安全测试、问题单提交，回归测试等工作。分部安服人员提交问题单给本组织安全管理员审批，分部安全管理员下发问题单给本组织安服人员处理。分部安服人员拥有查看本组织及下级组织的数据权限。', '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 0, 0, 0, 0, 0);
INSERT INTO `t_role_type` VALUES (5, '分部安全管理员', '负责分部组织安全管理、组织内部安全问题的审批、处置、审核等工作。分部安全管理员拥有查看本组织及下级组织的数据，还支持查看上级组织通报的数据，拥有部分操作权限。', '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 0, 0, 0, 0, 0);
INSERT INTO `t_role_type` VALUES (6, '操作审计员', NULL, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_role_type` VALUES (7, '用户管理员', NULL, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_role_type` VALUES (8, '运维管理员', NULL, '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, 1, 1, 1, 1, 1);

-- ----------------------------

-- ----------------------------
-- Table structure for t_role_type_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_role_type_permission`;
CREATE TABLE `t_role_type_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `default` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_type_id` int(11) NOT NULL COMMENT '角色类型名称默认7个',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_role_type_permission_UN`(`role_type_id`, `permission`) USING BTREE,
  INDEX `t_role_type_permission_FK`(`permission`) USING BTREE,
  CONSTRAINT `t_role_type_permission_FK` FOREIGN KEY (`permission`) REFERENCES `t_permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role_type_permission
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_scan_strategy
-- ----------------------------
DROP TABLE IF EXISTS `t_scan_strategy`;
CREATE TABLE `t_scan_strategy`  (
  `id` int(25) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '序号',
  `task_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `host_id` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'EDR主机唯一标识',
  `device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'dasca联动设备deviceId',
  `scan_device_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '扫描设备IP',
  `security_device_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '安全设备名称',
  `strategy_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '策略类型,1--漏洞扫描，2--病毒木马，3--网站后门',
  `strategy_source` tinyint(1) NOT NULL DEFAULT 0 COMMENT '策略来源,1--自建，2--SOAR',
  `scan_object` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '扫描对象',
  `scan_object_num` int(10) NULL DEFAULT 0 COMMENT '扫描对象数',
  `scan_result_num` int(10) NULL DEFAULT 0 COMMENT '扫描结果数',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `task_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '任务状态,0--未扫描，1--扫描中，2--扫描完成，3--扫描失败',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_scan_strategy
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_scene
-- ----------------------------
DROP TABLE IF EXISTS `t_scene`;
CREATE TABLE `t_scene`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '场景ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '场景名称',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '场景类型',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '场景描述',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '场景标签',
  `config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '场景配置',
  `activated` tinyint(1) NULL DEFAULT 0 COMMENT '是否激活',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '场景标题',
  `market_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '场景市场描述',
  `sort` bigint(20) NULL DEFAULT NULL COMMENT '场景排序',
  `template_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '场景模版类型',
  `cycle` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '场景检索周期',
  `show_export_report` int(11) NULL DEFAULT 1 COMMENT '是否展示导出报告按钮 0:不展示 1:展示',
  `is_default` int(11) NULL DEFAULT 1 COMMENT '是否是默认场景 1:默认 0:自定义',
  `market_sort` bigint(20) NULL DEFAULT NULL COMMENT '场景市场排序',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场景表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_scene
-- ----------------------------
INSERT INTO `t_scene` VALUES ('MINER', '挖矿活动', 'MINER', '恶意程序通信', '挖矿活动是指攻击者利用系统漏洞、钓鱼邮件、弱密码爆破等方式渗透目标主机植入木马，并在受控设备中部署挖矿木马，此类程序占用主机算力资源导致计算机硬件过载，引发服务中断和业务连续性问题。这些挖矿木马通常具有横向渗透能力，它们可以从单点感染迅速扩散至整个网络，增加内部风险。', '矿池,币种,挖矿阶段', '{\"stats\": [{\"name\": \"failedHost\", \"title\": \"失陷主机\", \"icon\": \"failedHost\"}]}', 1, '2026-01-13 10:37:49', '2026-01-13 10:37:50', '挖矿活动专项分析与处置中心', '通过分析挖矿活动行为，以及终端上进程网络访问行为，判定当前网络中资产是否存在挖矿活动情况，给出对应的修复建议，可以一键联动以及一键生成报告。', 5, NULL, NULL, 1, 1, 5);
INSERT INTO `t_scene` VALUES ('RANSOMWARE', '勒索病毒', 'RANSOMWARE', '恶意程序通信', '勒索病毒是一种特殊的恶意软件，它通过加密受害者的文件或锁定访问系统的方式，对用户的数据进行劫持，并要求支付赎金以换取数据的恢复或系统的访问权限。勒索病毒通常采用高强度的加密算法，使得受害者在没有攻击者提供的解密密钥的情况下几乎不可能自行恢复数据。', '勒索阶段,恶意程序,可疑通信', '{\"stats\": [{\"name\": \"failedHost\", \"title\": \"失陷主机\", \"icon\": \"failedHost\"}]}', 1, '2026-01-13 10:37:49', '2026-01-13 10:37:50', '勒索病毒专项分析与处置中心', '通过分析勒索病毒活动行为，以及终端上进程行为、文件操作日志等，判定当前网络中资产是否存在勒索病毒活动情况，给出对应的修复建议，可以一键联动以及一键生成报告。', 4, NULL, NULL, 1, 1, 4);
INSERT INTO `t_scene` VALUES ('SQL_INJECTION', 'SQL注入', 'SQL_INJECTION', 'Web攻击', 'SQL注入攻击是一种针对数据库驱动应用程序的安全漏洞利用方式，它允许攻击者通过在应用程序的输入字段中插入或\"注入\"恶意构造的SQL代码片段，从而执行未经授权的SQL命令。这种攻击能够导致数据泄露、数据丢失、数据损坏、拒绝服务以及完全控制数据库服务器等严重后果。', '注入事件,资产漏洞', '{\"stats\": [{\"name\": \"externalAttacker\", \"title\": \"外部攻击者\", \"icon\": \"externalAttacker\"}, {\"name\": \"internalAttacker\", \"title\": \"内部攻击者\", \"icon\": \"internalAttacker\"}]}', 1, '2026-01-13 10:37:48', '2026-01-13 10:37:50', 'SQL注入攻击专项分析与处置中心', '通过分析SQL注入漏洞攻击行为，判定当前网络中资产是否存在SQL注入漏洞以及针对该漏洞的攻击情况，给出对应的修复建议，可以一键联动以及一键生成报告。', 1, NULL, NULL, 1, 1, 1);
INSERT INTO `t_scene` VALUES ('UNAUTHORIZED_ACCESS', '未授权访问', 'UNAUTHORIZED_ACCESS', 'Web攻击', '未授权访问是指攻击者通过绕过身份认证机制、利用系统配置缺陷（如开放端口、默认权限）或漏洞，非法获取对系统、服务、数据的访问权限。此类行为通常利用缺乏访问控制策略、权限配置错误或暴露在公网的敏感接口，直接突破安全边界，形成隐蔽的入侵通道。', '越权访问', '{\"stats\": [{\"name\": \"unAuthorizedAccessAsset\", \"title\": \"未授权访问资产\", \"icon\": \"unAuthorizedAccessAsset\"}]}', 1, '2026-01-13 10:37:49', '2026-01-13 10:37:50', '未授权访问专项分析中心', '通过分析未授权漏洞攻击行为，判定当前网络中资产是否存在未授权访问漏洞，以及针对该漏洞的攻击情况，给出对应的修复建议，可以一键联动以及一键生成报告。', 2, NULL, NULL, 1, 1, 2);
INSERT INTO `t_scene` VALUES ('WEAK_PASSWORD', '弱口令', 'WEAK_PASSWORD', '账号安全', '弱口令是指系统或设备中存在的简单密码、默认密码、规律性字符组合等易被猜测或破解的凭证（如 admin/123456、空口令、生日格式等）。攻击者利用自动化工具（暴力破解、字典攻击）或社工手段，通过弱口令直接获取目标系统的控制权限。', 'HTTP,FTP,邮件,数据库', '{\"stats\": [{\"name\": \"weakPasswordAsset\", \"title\": \"弱口令资产\", \"icon\": \"weakPasswordAsset\"}]}', 1, '2026-01-13 10:37:49', '2026-01-13 10:37:50', '弱口令专项分析中心', '通过分析弱口令访问行为，以及终端上登录行为，判定当前网络中资产是否存在弱口令以及针对弱口令的访问情况，给出对应的修复建议，可以一键联动以及一键生成报告。', 3, NULL, NULL, 1, 1, 3);

-- ----------------------------

-- ----------------------------
-- Table structure for t_scene_component
-- ----------------------------
DROP TABLE IF EXISTS `t_scene_component`;
CREATE TABLE `t_scene_component`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '组件ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '组件名称',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件类型',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '组件描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场景组件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_scene_component
-- ----------------------------
INSERT INTO `t_scene_component` VALUES ('ALARM_LIST', '告警列表', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('ATTACK_DETAIL', '攻击详情', '2026-01-13 10:37:48', '2026-01-13 10:37:48', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('DISPOSAL_RECORD', '处置记录', '2026-01-13 10:37:48', '2026-01-13 10:37:48', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('EMERGENCY_ALARM', '紧急安全报警', '2026-01-13 10:37:48', '2026-01-13 10:37:48', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('EMERGENCY_FORECAST', '紧急安全警报', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('HANDLE_RECORD', '处置记录', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('MINER_EMERGENCY_FORECAST', '紧急安全警报', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('MINER_HANDLE_RECORD', '处置记录', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('MINER_RISK_HOST', '挖矿主机', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('RISK_HOST', '风险主机', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('UNAUTHORIZED_ALARM_LIST', '告警列表', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('UNAUTHORIZED_ANALYSIS', '未授权访问分析', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('UNAUTHORIZED_ASSET', '未授权访问资产', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('VULNERABILITY', '漏洞利用', '2026-01-13 10:37:48', '2026-01-13 10:37:48', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('WEAK_PASSWORD_ANALYSIS', '弱口令分析', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);
INSERT INTO `t_scene_component` VALUES ('WEAK_PASSWORD_ASSET', '弱口令资产', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);

-- ----------------------------

-- ----------------------------
-- Table structure for t_scene_component_rel
-- ----------------------------
DROP TABLE IF EXISTS `t_scene_component_rel`;
CREATE TABLE `t_scene_component_rel`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '关联ID',
  `scene_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '场景ID',
  `component_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '组件ID',
  `config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '关联配置',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_unique_rel`(`scene_id`, `component_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '场景组件关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_scene_component_rel
-- ----------------------------
INSERT INTO `t_scene_component_rel` VALUES (1, 'SQL_INJECTION', 'EMERGENCY_ALARM', '{\r\n    \"filter\": {\r\n        \"external\": \"direction == \\\"10\\\" AND (((alarmName contains \\\"TheMole\\\" OR alarmName contains \\\"SQLNinja\\\" OR alarmName contains \\\"AutoGetColumn\\\" OR alarmName contains \\\"SQLBrute\\\" OR alarmName contains \\\"SQLMAP\\\" OR alarmName contains \\\"bsqlbf\\\" OR alarmName contains \\\"pangolin\\\" OR alarmName contains \\\"漏扫工具\\\" OR alarmName contains \\\"注入工具\\\" OR alarmName contains \\\"扫描工具\\\") AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (judgeResult in [\\\"attackSuccess\\\",\\\"attackFailure\\\",\\\"attackAttempt\\\",\\\"vulnerabilityExploitationSuccess\\\",\\\"vulnerabilityExploitationFailure\\\",\\\"vulnerabilityRisk\\\"] AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (confidence == \\\"High\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (attackerTags contains \\\"SQL注入研判\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\"))\",\r\n        \"internal\": \"direction == \\\"00\\\" AND (((alarmName contains \\\"TheMole\\\" OR alarmName contains \\\"SQLNinja\\\" OR alarmName contains \\\"AutoGetColumn\\\" OR alarmName contains \\\"SQLBrute\\\" OR alarmName contains \\\"SQLMAP\\\" OR alarmName contains \\\"bsqlbf\\\" OR alarmName contains \\\"pangolin\\\" OR alarmName contains \\\"漏扫工具\\\" OR alarmName contains \\\"注入工具\\\" OR alarmName contains \\\"扫描工具\\\") AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (judgeResult in [\\\"attackSuccess\\\",\\\"attackFailure\\\",\\\"attackAttempt\\\",\\\"vulnerabilityExploitationSuccess\\\",\\\"vulnerabilityExploitationFailure\\\",\\\"vulnerabilityRisk\\\"] AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (confidence == \\\"High\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (attackerTags contains \\\"SQL注入研判\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\"))\"\r\n    }\r\n}', '2026-01-13 10:37:48', '2026-01-13 10:37:50');
INSERT INTO `t_scene_component_rel` VALUES (2, 'SQL_INJECTION', 'VULNERABILITY', '{\r\n    \"filter\": \"direction in [\\\"00\\\",\\\"10\\\"] AND (((alarmName contains \\\"TheMole\\\" OR alarmName contains \\\"SQLNinja\\\" OR alarmName contains \\\"AutoGetColumn\\\" OR alarmName contains \\\"SQLBrute\\\" OR alarmName contains \\\"SQLMAP\\\" OR alarmName contains \\\"bsqlbf\\\" OR alarmName contains \\\"pangolin\\\" OR alarmName contains \\\"漏扫工具\\\" OR alarmName contains \\\"注入工具\\\" OR alarmName contains \\\"扫描工具\\\") AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (judgeResult in [\\\"attackSuccess\\\",\\\"attackFailure\\\",\\\"attackAttempt\\\",\\\"vulnerabilityExploitationSuccess\\\",\\\"vulnerabilityExploitationFailure\\\",\\\"vulnerabilityRisk\\\"] AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (confidence == \\\"High\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (attackerTags contains \\\"SQL注入研判\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\"))\"\r\n}', '2026-01-13 10:37:48', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (3, 'SQL_INJECTION', 'ATTACK_DETAIL', '{\r\n    \"filter\": \"direction in [\\\"00\\\",\\\"10\\\"] AND (((alarmName contains \\\"TheMole\\\" OR alarmName contains \\\"SQLNinja\\\" OR alarmName contains \\\"AutoGetColumn\\\" OR alarmName contains \\\"SQLBrute\\\" OR alarmName contains \\\"SQLMAP\\\" OR alarmName contains \\\"bsqlbf\\\" OR alarmName contains \\\"pangolin\\\" OR alarmName contains \\\"漏扫工具\\\" OR alarmName contains \\\"注入工具\\\" OR alarmName contains \\\"扫描工具\\\") AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (judgeResult in [\\\"attackSuccess\\\",\\\"attackFailure\\\",\\\"attackAttempt\\\",\\\"vulnerabilityExploitationSuccess\\\",\\\"vulnerabilityExploitationFailure\\\",\\\"vulnerabilityRisk\\\"] AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (confidence == \\\"High\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (attackerTags contains \\\"SQL注入研判\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\"))\"\r\n}', '2026-01-13 10:37:48', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (4, 'SQL_INJECTION', 'DISPOSAL_RECORD', '{\r\n    \"source\": \"SQL_INJECTION\",\r\n    \"action\": \"prohibit\"\r\n}', '2026-01-13 10:37:48', '2026-01-13 10:37:48');
INSERT INTO `t_scene_component_rel` VALUES (5, 'WEAK_PASSWORD', 'WEAK_PASSWORD_ASSET', '{\r\n    \"filter\": {\r\n        \"web\": \"subCategory == \\\"/ConfigRisk/WeakPassword\\\" AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND loginType != \\\"Basic认证\\\" AND appProtocol in [\\\"http\\\"]\",   \r\n        \"other\": \"subCategory == \\\"/ConfigRisk/WeakPassword\\\" AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND loginType != \\\"Basic认证\\\" AND appProtocol notin [\\\"http\\\"]\"\r\n    }\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (6, 'WEAK_PASSWORD', 'WEAK_PASSWORD_ANALYSIS', '{\r\n    \"filter\": {\r\n        \"web\": \"subCategory == \\\"/ConfigRisk/WeakPassword\\\" AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND loginType != \\\"Basic认证\\\" AND appProtocol in [\\\"http\\\"]\",   \r\n        \"other\": \"subCategory == \\\"/ConfigRisk/WeakPassword\\\" AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND loginType != \\\"Basic认证\\\" AND appProtocol notin [\\\"http\\\"]\"\r\n    }\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (7, 'WEAK_PASSWORD', 'ALARM_LIST', '{\"filter\":\"\"}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (8, 'UNAUTHORIZED_ACCESS', 'UNAUTHORIZED_ASSET', '{\r\n    \"filter\": {\r\n        \"web\": \"(subCategory == \\\"/DataSteal/UnauthorizedAccess\\\"  OR alarmName contains \\\"未授权\\\") AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND appProtocol in [\\\"http\\\"]\",\r\n        \"other\": \"(subCategory == \\\"/DataSteal/UnauthorizedAccess\\\"  OR alarmName contains \\\"未授权\\\") AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND appProtocol notin [\\\"http\\\"]\"\r\n    }\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (9, 'UNAUTHORIZED_ACCESS', 'UNAUTHORIZED_ANALYSIS', '{\r\n    \"filter\": {\r\n        \"web\": \"(subCategory == \\\"/DataSteal/UnauthorizedAccess\\\" OR alarmName contains \\\"未授权\\\") AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND appProtocol in [\\\"http\\\"]\",\r\n        \"other\": \"(subCategory == \\\"/DataSteal/UnauthorizedAccess\\\" OR alarmName contains \\\"未授权\\\") AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND appProtocol notin [\\\"http\\\"]\"\r\n    }\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (10, 'UNAUTHORIZED_ACCESS', 'UNAUTHORIZED_ALARM_LIST', '{\"filter\":\"\"}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (11, 'RANSOMWARE', 'EMERGENCY_FORECAST', '{\r\n    \"filter\": \"(subCategory == \\\"/Malware/Ransomware\\\" OR ruleType == \\\"/Malware/Ransomware\\\") AND alarmResults == \\\"OK\\\" AND ((alarmSource == \\\"安恒EDR\\\" AND dvcAction in [\\\"pass\\\",\\\"failed\\\"]) OR alarmSource != \\\"安恒EDR\\\")\"\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (12, 'RANSOMWARE', 'RISK_HOST', '{\r\n    \"filter\": \"(subCategory == \\\"/Malware/Ransomware\\\" OR ruleType == \\\"/Malware/Ransomware\\\")\"\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (13, 'RANSOMWARE', 'HANDLE_RECORD', '{\"filter\":\"\"}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (14, 'MINER', 'MINER_EMERGENCY_FORECAST', '{\r\n    \"filter\": \"(subCategory == \\\"/Malware/Miner\\\" OR ruleType == \\\"/Malware/Miner\\\") AND alarmResults == \\\"OK\\\" AND ((alarmSource == \\\"安恒EDR\\\" AND dvcAction in [\\\"pass\\\",\\\"failed\\\"]) OR alarmSource != \\\"安恒EDR\\\")\"\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (15, 'MINER', 'MINER_RISK_HOST', '{\r\n    \"filter\": \"(subCategory == \\\"/Malware/Miner\\\" OR ruleType == \\\"/Malware/Miner\\\")\"\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');
INSERT INTO `t_scene_component_rel` VALUES (16, 'MINER', 'MINER_HANDLE_RECORD', '{\"filter\":\"\"}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');

-- ----------------------------

-- ----------------------------
-- Table structure for t_screen_rotation_config
-- ----------------------------
DROP TABLE IF EXISTS `t_screen_rotation_config`;
CREATE TABLE `t_screen_rotation_config`  (
  `uuid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '大屏本身id，来源不同可能导致id重复',
  `system` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'bigdata-web' COMMENT '大屏所在系统，微服务中会用到，默认主产品',
  `source` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '大屏所在程序中的来源',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '大屏名称',
  `url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '大屏地址，部分为全路径，部分为路由',
  `router` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由(预留字段)',
  `param` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '参数',
  `order` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '大屏轮播配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_screen_rotation_config
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_search_save
-- ----------------------------
DROP TABLE IF EXISTS `t_search_save`;
CREATE TABLE `t_search_save`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `groupId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组id',
  `conditionStr` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '树状结构',
  `queryStr` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '查询语句',
  `hasChart` tinyint(1) NULL DEFAULT NULL COMMENT '是否包含图表语句',
  `chartStr` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '图表语句',
  `hasAggregation` tinyint(1) NULL DEFAULT NULL COMMENT '是否包含聚合语句',
  `aggregationStr` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '聚合语句',
  `basicQuery` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '基本查询条件',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '元素创建时间',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '元素更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_search_save_UN`(`name`, `groupId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_search_save
-- ----------------------------
INSERT INTO `t_search_save` VALUES (1, '流量会话', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"flow\"}}}}}', 'logType == \"flow\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:07:22.242Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"type\":\"int\",\"key\":\"目的端口(destPort)\"},{\"en\":\"transProtocol\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"传输协议\",\"key\":\"传输协议(transProtocol)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"bytesIn\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"请求流量\",\"key\":\"请求流量(bytesIn)\"},{\"en\":\"bytesOut\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"响应流量\",\"key\":\"响应流量(bytesOut)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 10:15:40', '2020-05-14 10:15:40');
INSERT INTO `t_search_save` VALUES (2, 'RDP连接', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"rdp\"}}}}}', 'logType == \"rdp\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 10:25:30', '2020-05-14 10:25:30');
INSERT INTO `t_search_save` VALUES (3, 'TELNET请求', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"telnet\"}}}}}', 'logType == \"telnet\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"srcUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源用户名\",\"key\":\"来源用户名(srcUserName)\"},{\"ch\":\"请求方法\",\"en\":\"requestMethod\",\"type\":\"string\",\"key\":\"请求方法(requestMethod)\"},{\"ch\":\"响应内容\",\"en\":\"responseMsg\",\"type\":\"string\",\"key\":\"响应内容(responseMsg)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 10:36:21', '2020-05-14 10:36:21');
INSERT INTO `t_search_save` VALUES (4, 'SMB通信', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"smb\"}}}}}', 'logType == \"smb\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"来源用户名\",\"en\":\"srcUserName\",\"type\":\"string\",\"key\":\"来源用户名(srcUserName)\"},{\"en\":\"destHostName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"目的主机名\",\"key\":\"目的主机名(destHostName)\"},{\"en\":\"cmdContent\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"命令行\",\"key\":\"命令行(cmdContent)\"},{\"en\":\"status\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"状态\",\"key\":\"状态(status)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 11:15:40', '2020-05-14 11:15:40');
INSERT INTO `t_search_save` VALUES (5, '邮件通信', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"smtp\"}}}}}', 'logType == \"smtp\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"来源用户名\",\"en\":\"srcUserName\",\"type\":\"string\",\"key\":\"来源用户名(srcUserName)\"},{\"en\":\"destUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"目的用户名\",\"key\":\"目的用户名(destUserName)\"},{\"en\":\"ccUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"抄送人\",\"key\":\"抄送人(ccUserName)\"},{\"en\":\"mailTitle\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"邮件标题\",\"key\":\"邮件标题(mailTitle)\"},{\"en\":\"srcGeoCountry\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源国家\",\"key\":\"来源国家(srcGeoCountry)\"},{\"en\":\"srcGeoRegion\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源地区\",\"key\":\"来源地区(srcGeoRegion)\"},{\"en\":\"srcGeoCity\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源城市\",\"key\":\"来源城市(srcGeoCity)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 11:20:26', '2020-05-14 11:20:26');
INSERT INTO `t_search_save` VALUES (6, 'TFTP访问', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"tftp\"}}}}}', 'logType == \"tftp\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"opType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"操作类型\",\"key\":\"操作类型(opType)\"},{\"en\":\"fileName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件名\",\"key\":\"文件名(fileName)\"},{\"en\":\"transMode\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"传输模式\",\"key\":\"传输模式(transMode)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 13:55:55', '2020-05-14 13:55:55');
INSERT INTO `t_search_save` VALUES (7, 'FTP命令执行', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"ftp\"}}}}}', 'logType == \"ftp\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"requestMethod\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求方法\",\"key\":\"请求方法(requestMethod)\"},{\"en\":\"requestParameters\",\"isQuery\":true,\"isAgg\":false,\"type\":\"string\",\"ch\":\"请求参数\",\"key\":\"请求参数(requestParameters)\"},{\"en\":\"responseCode\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求响应码\",\"key\":\"请求响应码(responseCode)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 13:58:35', '2020-05-14 13:58:35');
INSERT INTO `t_search_save` VALUES (8, 'DNS查询', '1', '{\"query\":{\"bool\":{\"filter\":[{\"term\":{\"logType\":\"dns\"}},{\"term\":{\"dnsType\":\"answer\"}}]}}}', 'logType == \"dns\" AND dnsType == \"answer\" ', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"查询类型\",\"en\":\"queryType\",\"type\":\"string\",\"key\":\"查询类型(queryType)\"},{\"ch\":\"dns请求域名\",\"en\":\"requestDomain\",\"type\":\"string\",\"key\":\"dns请求域名(requestDomain)\"},{\"ch\":\"返回的IP地址\",\"en\":\"responseAddress\",\"type\":\"string\",\"key\":\"返回的IP地址(responseAddress)\"},{\"ch\":\"请求响应码\",\"en\":\"responseCode\",\"type\":\"string\",\"key\":\"请求响应码(responseCode)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 14:06:57', '2020-05-14 14:06:57');
INSERT INTO `t_search_save` VALUES (9, 'WEB访问', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"http\"}}}}}', 'logType == \"http\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"requestMethod\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求方法\",\"key\":\"请求方法(requestMethod)\"},{\"en\":\"destHostName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"目的主机名\",\"key\":\"目的主机名(destHostName)\"},{\"en\":\"requestUrl\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"URL\",\"key\":\"URL(requestUrl)\"},{\"ch\":\"请求响应码\",\"en\":\"responseCode\",\"type\":\"string\",\"key\":\"请求响应码(responseCode)\"},{\"en\":\"bytesIn\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"请求流量\",\"key\":\"请求流量(bytesIn)\"},{\"en\":\"bytesOut\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"响应流量\",\"key\":\"响应流量(bytesOut)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 14:11:47', '2020-05-14 14:11:47');
INSERT INTO `t_search_save` VALUES (10, '文件传输', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"fileinfo\"}}}}}', 'logType == \"fileinfo\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"opType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"操作类型\",\"key\":\"操作类型(opType)\"},{\"en\":\"fileName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件名\",\"key\":\"文件名(fileName)\"},{\"en\":\"fileType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件类型\",\"key\":\"文件类型(fileType)\"},{\"en\":\"fileMd5\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件MD5\",\"key\":\"文件MD5(fileMd5)\"},{\"en\":\"fileSize\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"文件大小\",\"key\":\"文件大小(fileSize)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 14:29:31', '2020-05-14 14:29:31');
INSERT INTO `t_search_save` VALUES (11, '用户登录行为', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"login\"}}}}}', 'logType == \"login\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"srcUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源用户名\",\"key\":\"来源用户名(srcUserName)\"},{\"en\":\"catOutcome\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"事件结果分类\",\"key\":\"事件结果分类(catOutcome)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 14:33:33', '2020-05-14 14:33:33');
INSERT INTO `t_search_save` VALUES (12, '探针告警', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"alert\"}}}}}', 'logType == \"alert\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"en\":\"severity\",\"isQuery\":true,\"isAgg\":true,\"type\":\"int\",\"ch\":\"安全日志威胁等级\",\"key\":\"安全日志威胁等级(severity)\"},{\"en\":\"ruleType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"探针设备告警类型\",\"key\":\"探针设备告警类型(ruleType)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 14:37:46', '2020-05-14 14:37:46');
INSERT INTO `t_search_save` VALUES (13, '配置风险', '3', '{\"query\":{\"bool\":{\"filter\":{\"terms\":{\"subCategory\":[\"/ConfigRisk/HTTPServer\",\"/ConfigRisk/MidWare\",\"/ConfigRisk/Database\",\"/ConfigRisk/Service\",\"/ConfigRisk/DeviceConf\",\"/ConfigRisk/Others\"]}}}}}', 'subCategory in [\"/ConfigRisk/HTTPServer\",\"/ConfigRisk/MidWare\",\"/ConfigRisk/Database\",\"/ConfigRisk/Service\",\"/ConfigRisk/DeviceConf\",\"/ConfigRisk/Others\"]', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"目的端口\",\"key\":\"目的端口(destPort)\",\"value\":\"destPort\",\"index\":1},{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":2},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":3},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":4}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:01:05.652Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:01:18', '2020-05-15 10:01:18');
INSERT INTO `t_search_save` VALUES (14, '企业形象不良影响', '3', '{\"query\":{\"bool\":{\"filter\":{\"terms\":{\"subCategory\":[\"/SuspEndpoint/Attack\",\"/SuspEndpoint/ExternalScan\",\"/WebAttack/WebTempering\"]}}}}}', 'subCategory in [\"/SuspEndpoint/Attack\",\"/SuspEndpoint/ExternalScan\",\"/WebAttack/WebTempering\"]', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":1},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":2}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:01:22.872Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:01:35', '2020-05-15 10:01:35');
INSERT INTO `t_search_save` VALUES (15, '信息明文传输风险', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"subCategory\":\"/ConfigRisk/ClearTextCredit\"}}}}}', 'subCategory == \"/ConfigRisk/ClearTextCredit\" ', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"目的主机名\",\"key\":\"目的主机名(destHostName)\",\"value\":\"destHostName\",\"index\":0}],\"unSelected\":[{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":1},{\"name\":\"URL\",\"key\":\"URL(requestUrl)\",\"value\":\"requestUrl\",\"index\":2},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":3}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:01:45.204Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:01:54', '2020-05-15 10:01:54');
INSERT INTO `t_search_save` VALUES (16, '弱口令', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"subCategory\":\"/ConfigRisk/WeakPassword\"}}}}}', 'subCategory == \"/ConfigRisk/WeakPassword\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"目的端口\",\"key\":\"目的端口(destPort)\",\"value\":\"destPort\",\"index\":1},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":2},{\"name\":\"应用协议\",\"key\":\"应用协议(appProtocol)\",\"value\":\"appProtocol\",\"index\":3},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":4}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:02:12.477Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:02:18', '2020-05-15 10:02:18');
INSERT INTO `t_search_save` VALUES (17, '高危事件', '3', '{\"query\":{\"bool\":{\"filter\":[{\"terms\":{\"threatSeverity\":[\"High\"]}},{\"term\":{\"alarmStatus\":\"unprocessed\"}}]}}}', 'threatSeverity in [\"High\"] AND alarmStatus == \"unprocessed\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"攻击者\",\"key\":\"攻击者(attacker)\",\"value\":\"attacker\",\"index\":0},{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":1}],\"unSelected\":[{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":2},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":3},{\"name\":\"目的端口\",\"key\":\"目的端口(destPort)\",\"value\":\"destPort\",\"index\":4},{\"name\":\"应用协议\",\"key\":\"应用协议(appProtocol)\",\"value\":\"appProtocol\",\"index\":5},{\"name\":\"告警标签\",\"key\":\"告警标签(alarmTag)\",\"value\":\"alarmTag\",\"index\":6},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":7}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:02:25.922Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:02:33', '2020-05-15 10:02:33');
INSERT INTO `t_search_save` VALUES (18, '钓鱼邮件', '3', '{\"query\":{\"bool\":{\"filter\":[{\"term\":{\"name\":\"恶意文件攻击\"}},{\"term\":{\"catOutcome\":\"OK\"}},{\"terms\":{\"appProtocol\":[\"pop2\",\"pop3\",\"smtp\",\"imap\"]}}]}}}', 'name == \"恶意文件攻击\" and catOutcome == \"OK\" and appProtocol in [\"pop2\",\"pop3\",\"smtp\",\"imap\"]', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"目的用户名\",\"key\":\"目的用户名(destUserName)\",\"value\":\"destUserName\",\"index\":2}],\"unSelected\":[{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":0},{\"name\":\"来源用户名\",\"key\":\"来源用户名(srcUserName)\",\"value\":\"srcUserName\",\"index\":1},{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":3},{\"name\":\"来源IP\",\"key\":\"来源IP(srcAddress)\",\"value\":\"srcAddress\",\"index\":4},{\"name\":\"目的IP\",\"key\":\"目的IP(destAddress)\",\"value\":\"destAddress\",\"index\":5},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":6}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:02:47.341Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:02:52', '2020-05-15 10:02:52');
INSERT INTO `t_search_save` VALUES (19, '站点存在webshell后门', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"subCategory\":\"/Malware/Webshell\"}}}}}', 'subCategory == \"/Malware/Webshell\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0},{\"name\":\"URL\",\"key\":\"URL(requestUrl)\",\"value\":\"requestUrl\",\"index\":1}],\"unSelected\":[{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":2},{\"name\":\"目的主机名\",\"key\":\"目的主机名(destHostName)\",\"value\":\"destHostName\",\"index\":3},{\"name\":\"攻击者\",\"key\":\"攻击者(attacker)\",\"value\":\"attacker\",\"index\":4},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":5}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-04-30T16:00:00.000Z\",\"2020-05-15T02:02:58.238Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本月\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:03:06', '2020-05-15 10:03:06');
INSERT INTO `t_search_save` VALUES (20, '搜索', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"appProtocol\":\"discard\"}}}}}', 'appProtocol == \"discard\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-01 00:00:00\",\"2020-05-18 00:00:00\"],\"isShortcutObj\":{\"isShortcut\":false,\"timeValue\":\"2020-05-01 00:00:00 ~ 2020-05-18 00:00:00\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"查询类型\",\"en\":\"queryType\",\"type\":\"string\",\"key\":\"查询类型(queryType)\"},{\"ch\":\"dns请求域名\",\"en\":\"requestDomain\",\"type\":\"string\",\"key\":\"dns请求域名(requestDomain)\"},{\"ch\":\"返回的IP地址\",\"en\":\"responseAddress\",\"type\":\"string\",\"key\":\"返回的IP地址(responseAddress)\"},{\"ch\":\"请求响应码\",\"en\":\"responseCode\",\"type\":\"string\",\"key\":\"请求响应码(responseCode)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-19 14:03:13', '2020-05-19 14:03:13');
INSERT INTO `t_search_save` VALUES (21, '威胁情报', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"modelType\":\"intelligence\"}}}}}', 'modelType == \"intelligence\" ', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":1},{\"name\":\"情报IoC\",\"key\":\"情报IoC(IoC)\",\"value\":\"IoC\",\"index\":2},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":3}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-22T16:00:00.000Z\",\"2020-05-23T05:17:22.423Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-23 13:24:31', '2020-05-23 13:24:31');
INSERT INTO `t_search_save` VALUES (22, '挖矿活动', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"subCategory\":\"/Malware/Miner\"}}}}}', 'subCategory == \"/Malware/Miner\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":1},{\"name\":\"攻击者\",\"key\":\"攻击者(attacker)\",\"value\":\"attacker\",\"index\":2},{\"name\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\",\"value\":\"srcSecurityZone\",\"index\":3},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":4}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-22T16:00:00.000Z\",\"2020-05-23T05:46:48.004Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-23 13:47:14', '2020-05-23 13:47:14');
INSERT INTO `t_search_save` VALUES (23, '勒索病毒', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"subCategory\":\"/Malware/Ransomware\"}}}}}', 'subCategory == \"/Malware/Ransomware\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":1}],\"unSelected\":[{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":0},{\"name\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\",\"value\":\"srcSecurityZone\",\"index\":2}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-22T16:00:00.000Z\",\"2020-05-23T05:47:21.276Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-23 13:47:44', '2020-05-23 13:47:44');
INSERT INTO `t_search_save` VALUES (24, 'CVE漏洞利用成功', '3', '{\"query\":{\"bool\":{\"filter\":{\"bool\":{\"must_not\":[{\"term\":{\"direction\":\"01\"}}],\"must\":[{\"exists\":{\"field\":\"cve\"}},{\"bool\":{\"should\":[{\"query_string\":{\"query\":\"name:*成功*\"}},{\"term\":{\"alarmResults\":\"OK\"}}],\"minimum_should_match\":1,\"boost\":1}}]}}}}}', 'cve exist AND (name contains \"成功\" OR alarmResults == \"OK\") AND direction != \"01\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"目的端口\",\"key\":\"目的端口(destPort)\",\"value\":\"destPort\",\"index\":1},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":2},{\"name\":\"cve编号\",\"key\":\"cve编号(cve)\",\"value\":\"cve\",\"index\":3},{\"name\":\"应用协议\",\"key\":\"应用协议(appProtocol)\",\"value\":\"appProtocol\",\"index\":4},{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":5},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":6}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-22T16:00:00.000Z\",\"2020-05-23T05:48:23.364Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-23 13:48:45', '2020-05-23 13:48:45');
INSERT INTO `t_search_save` VALUES (25, '外部攻击者', '3', '{\"query\":{\"bool\":{\"filter\":[{\"term\":{\"direction\":\"10\"}},{\"terms\":{\"threatSeverity\":[\"High\",\"Medium\"]}}]}}}', 'direction == \"10\" AND (threatSeverity in [\"High\",\"Medium\"])', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"攻击者\",\"key\":\"攻击者(attacker)\",\"value\":\"attacker\",\"index\":0}],\"unSelected\":[{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":1},{\"name\":\"来源国家\",\"key\":\"来源国家(srcGeoCountry)\",\"value\":\"srcGeoCountry\",\"index\":2},{\"name\":\"来源地区\",\"key\":\"来源地区(srcGeoRegion)\",\"value\":\"srcGeoRegion\",\"index\":3},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":4},{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":5},{\"name\":\"目的端口\",\"key\":\"目的端口(destPort)\",\"value\":\"destPort\",\"index\":6},{\"name\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\",\"value\":\"destSecurityZone\",\"index\":7},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":8}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-22T16:00:00.000Z\",\"2020-05-23T05:48:53.434Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-23 13:49:11', '2020-05-23 13:49:11');

-- ----------------------------

-- ----------------------------
-- Table structure for t_search_save_group
-- ----------------------------
DROP TABLE IF EXISTS `t_search_save_group`;
CREATE TABLE `t_search_save_group`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分组名称',
  `isFactory` tinyint(4) NOT NULL COMMENT '是否出厂',
  `searchTypeNum` tinyint(4) NOT NULL COMMENT '检索分类',
  `userId` bigint(20) NOT NULL COMMENT '用户id',
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_search_save_group_UN`(`groupName`, `searchTypeNum`, `userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_search_save_group
-- ----------------------------
INSERT INTO `t_search_save_group` VALUES (1, '默认', 1, 1, 1, '2026-01-13 10:37:43', '2026-01-13 10:37:43');
INSERT INTO `t_search_save_group` VALUES (2, '默认', 1, 2, 1, '2026-01-13 10:37:43', '2026-01-13 10:37:43');
INSERT INTO `t_search_save_group` VALUES (3, '默认', 1, 3, 1, '2026-01-13 10:37:43', '2026-01-13 10:37:43');

-- ----------------------------

-- ----------------------------
-- Table structure for t_security_device
-- ----------------------------
DROP TABLE IF EXISTS `t_security_device`;
CREATE TABLE `t_security_device`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '安全设备ID',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '安全设备名称',
  `geo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地理位置',
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备类型',
  `manufacturer` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备厂商',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备图标',
  `description` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述信息',
  `related_assets` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '关联资产',
  `related_assets_num` int(10) NULL DEFAULT NULL COMMENT '关联资产数',
  `add_screen` int(10) NULL DEFAULT 0 COMMENT '是否投屏, 1是，0否',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 116 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_security_device
-- ----------------------------
INSERT INTO `t_security_device` VALUES (112, '安恒全流量综合探针', '北京市/市辖区/西城区', '48,14', '安恒(DBAPPSecurity)', 'flm', '安恒全流量综合探针具备高性能抓包、协议解析、文件还原、杀毒引擎等高级威胁检测能力。是一个面向全流量安全分析、业务分析、审计分析的产品，可广泛适用于银行、公安、政府、运营商、电子商务、能源、企业等各行业的流量深度威胁监控与分析。', '', 0, 0, '2026-01-13 10:37:40', '2026-01-13 10:37:40');
INSERT INTO `t_security_device` VALUES (113, '安恒日志标准化引擎', '北京市/市辖区/西城区', '48,28', '安恒(DBAPPSecurity)', 'las', '安恒日志标准化引擎通过对客户网络设备、安全设备、主机和应用系统日志进行全面的标准化处理，及时发现各种安全威胁、异常行为事件，为管理人员提供全局的视角，确保客户业务的不间断运营安全。', '', 0, 0, '2026-01-13 10:37:40', '2026-01-13 10:37:40');
INSERT INTO `t_security_device` VALUES (114, '安恒WAF', '北京市/市辖区/西城区', '48,13', '安恒(DBAPPSecurity)', 'waf', '应用防火墙专注于网站及Web应用系统的应用层专业安全防护。可以快速地应对恶意攻击者对Web业务带来的冲击；可以智能锁定攻击者并通知管理员对网站代码进行合理的加固。', '', 0, 0, '2026-01-13 10:37:40', '2026-01-13 10:37:40');
INSERT INTO `t_security_device` VALUES (115, '安恒EDR', '北京市/市辖区/西城区', '48,56', '安恒(DBAPPSecurity)', 'edr', '主机安全及管理系统是一款集成了丰富的系统防护与加固、网络防护与加固等功能的主机安全产品。通过自主研发的文件诱饵引擎，有着业界领先的勒索专防专杀能力；通过内核级东西向流量隔离技术，实现网络隔离与防护；通过流量画像，实现全网流量可视化且支持一键阻断；拥有补丁修复、外设管控、文件审计、违规外联检测与阻断等主机安全能力。目前产品广泛应用在服务器、桌面PC、虚拟机、工控系统、国产操作系统、容器安全等各个场景。', '', 0, 0, '2026-01-13 10:37:40', '2026-01-13 10:37:40');

-- ----------------------------

-- ----------------------------
-- Table structure for t_security_group
-- ----------------------------
DROP TABLE IF EXISTS `t_security_group`;
CREATE TABLE `t_security_group`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '安全域名称',
  `customer_ids` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '资产组id列表',
  `customer_names` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '资产组name列表',
  `save_time` timestamp NULL DEFAULT NULL COMMENT '保存时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_security_group
-- ----------------------------
INSERT INTO `t_security_group` VALUES (1, '核心网络区', '', '', '2026-01-13 10:37:38');
INSERT INTO `t_security_group` VALUES (2, '业务核心区', '', '', '2026-01-13 10:37:38');
INSERT INTO `t_security_group` VALUES (3, '模拟监控区', '', '', '2026-01-13 10:37:38');
INSERT INTO `t_security_group` VALUES (4, '终端接入区', '', '', '2026-01-13 10:37:38');

-- ----------------------------

-- ----------------------------
-- Table structure for t_security_incidents
-- ----------------------------
DROP TABLE IF EXISTS `t_security_incidents`;
CREATE TABLE `t_security_incidents`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '安全事件来源',
  `incidentModelId` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件模型ID',
  `incidentModelName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件模型名称',
  `incidentName` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件名称',
  `threatSeverity` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件等级',
  `describe` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `incidentTag` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '标签',
  `startTime` timestamp NULL DEFAULT NULL COMMENT '首次发生时间',
  `endTime` timestamp NULL DEFAULT NULL COMMENT '最近发生时间',
  `lastUpdateTime` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  `evidence` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '举证',
  `attacker` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '攻击者',
  `victim` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '受害者',
  `retrievalTemplate` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '查询模板',
  `createTime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '安全事件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_security_incidents
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_security_zone
-- ----------------------------
DROP TABLE IF EXISTS `t_security_zone`;
CREATE TABLE `t_security_zone`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '安全域名称',
  `description` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '安全域描述',
  `iconPath` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标路径',
  `ipConfStr` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ip、ip区间、子网掩码配置',
  `uiIpConfStr` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'Ip、ip区间、子网掩码对应前端位置',
  `createTime` bigint(20) NULL DEFAULT NULL COMMENT '创建时间',
  `tag` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统标签',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_security_zone
-- ----------------------------
INSERT INTO `t_security_zone` VALUES ('inner_886da035-c033-46b8-8ce8-b31e03db7ab2_1537173568979', '局域网', '企业局域网。未配置情况下，默认以下区间IP为局域网IP：\n1.     Class A 127.0.0.1\n2.     Class B 10.0.0.0-10.255.255.255，默认子网掩码:255.0.0.0\n3.     Class C 172.16.0.0-172.31.255.255，默认子网掩码:255.240.0.0\n4.     Class D 192.168.0.0-192.168.255.255，默认子网掩码:255.255.0.0', 'internet', '{\"ipInterval\":[[\"10.0.0.0\",\"10.255.255.255\"],[\"172.16.0.0\",\"172.31.255.255\"],[\"192.168.0.0\",\"192.168.255.255\"]],\"ip\":[\"127.0.0.1\"],\"subnetMask\":[]}', '{\"ipInterval\":[1,2,3],\"ip\":[0],\"subnetMask\":[]}', 1537173568979, '');

-- ----------------------------

-- ----------------------------
-- Table structure for t_serv_report
-- ----------------------------
DROP TABLE IF EXISTS `t_serv_report`;
CREATE TABLE `t_serv_report`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `report_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报告名称',
  `begin_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '导出数据开始时间',
  `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '导出数据结束时间',
  `file_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件类型，doc、pdf',
  `template_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键，报告模板id',
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态，generating：生成中；generated：已生成；failure：生成失败',
  `fail_message` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '失败原因',
  `file_uuid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报告文件uuid，存储下临时目录/tmp/report下',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报告生成' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_serv_report
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_sev_agent_config
-- ----------------------------
DROP TABLE IF EXISTS `t_sev_agent_config`;
CREATE TABLE `t_sev_agent_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `agent_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'agent类型（AiNTA、APT、SOC）',
  `config_version` bigint(20) NOT NULL COMMENT '版本号，时间戳',
  `config_key` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配置项标识，英文名',
  `config_content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '配置内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_agent_config_FK`(`agent_type`) USING BTREE,
  CONSTRAINT `t_agent_config_FK` FOREIGN KEY (`agent_type`) REFERENCES `t_sev_agent_type` (`agent_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '探针配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sev_agent_config
-- ----------------------------

-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
