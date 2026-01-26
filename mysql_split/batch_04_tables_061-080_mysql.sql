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
-- Table structure for t_bs_apikey
-- ----------------------------
DROP TABLE IF EXISTS `t_bs_apikey`;
CREATE TABLE `t_bs_apikey`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称，用于日志记录、流量控制',
  `apikey` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'apiKey',
  `expire_time` bigint(20) NOT NULL COMMENT 'apiKey超时时间',
  `remark` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '备注',
  `is_factory` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否默认出厂apiKey',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_bs_apikey_FK`(`user_id`) USING BTREE,
  CONSTRAINT `t_bs_apikey_FK` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'apikey管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_bs_apikey
-- ----------------------------
INSERT INTO `t_bs_apikey` VALUES (4, 1, 'default', 'bb02fdc459cc8a364bde20ba3e37fc6e', 1862966270000, '默认', 0, '2026-01-13 10:37:50');

-- ----------------------------

-- ----------------------------
-- Table structure for t_bs_es_index
-- ----------------------------
DROP TABLE IF EXISTS `t_bs_es_index`;
CREATE TABLE `t_bs_es_index`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `index_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '索引名称',
  `index_alias` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '索引别名',
  `indexing` tinyint(1) NULL DEFAULT 0 COMMENT '索引是否正在被写入',
  `time_begin` bigint(20) NULL DEFAULT 0 COMMENT '存储时间起始',
  `time_end` bigint(20) NULL DEFAULT 0 COMMENT '存储时间终止',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `index_name`(`index_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'elasticsearch索引表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_bs_es_index
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_bs_extension_history
-- ----------------------------
DROP TABLE IF EXISTS `t_bs_extension_history`;
CREATE TABLE `t_bs_extension_history`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Extension英文名',
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Extension中文名',
  `last_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '历史版本',
  `version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作时版本',
  `operate_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  `operate_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作类型，install:安装,upgrade:升级,uninstall:卸载',
  `is_success` tinyint(1) NOT NULL COMMENT '操作是否成功',
  `result` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '操作结果信息',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `t_bs_extension_history_FK`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Extension安装升级历史记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_bs_extension_history
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_bs_extension_info
-- ----------------------------
DROP TABLE IF EXISTS `t_bs_extension_info`;
CREATE TABLE `t_bs_extension_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Extension英文名',
  `name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Extension中文名',
  `description` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'Extension描述',
  `install_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '首次安装时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最近一次更新时间',
  `version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '当前版本',
  `docker_id` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部署容器id',
  `deploy_path` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部署路径',
  `main_class` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '启动类',
  `status` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态，running:运行中，stopped:已停用，installing:安装中，restarting:重启中，uninstalling:卸载中，starting:启动中，stopping:停用中，failure:操作失败',
  `meta_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '其他元数据，json格式存储',
  `is_success` tinyint(1) NOT NULL COMMENT '最后一次操作结果',
  `result` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '最后一次操作结果描述',
  `preinstall` tinyint(1) NOT NULL COMMENT '是否为内置拓展',
  `port` int(11) NOT NULL COMMENT '拓展程序服务端口号',
  `authorization` int(11) NULL DEFAULT 1 COMMENT '授权：默认全授权1，未授权0',
  `modify_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '数据更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_bs_extension_info_UN`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'Extension基本信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_bs_extension_info
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_bs_files
-- ----------------------------
DROP TABLE IF EXISTS `t_bs_files`;
CREATE TABLE `t_bs_files`  (
  `uuid` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键，文件uuid',
  `module` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '业务模块，逗号分隔，多层存储',
  `file_path` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件路径',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文件名',
  `file_size` bigint(20) NOT NULL COMMENT '文件大小',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '许可文件管理，升级包&许可文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_bs_files
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_bs_knowledge
-- ----------------------------
DROP TABLE IF EXISTS `t_bs_knowledge`;
CREATE TABLE `t_bs_knowledge`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `alarmTag` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '唯一标识',
  `summary` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '摘要',
  `fileName` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '知识库文件',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `IDX_UN_ALARM_TAG`(`alarmTag`) USING BTREE,
  INDEX `IDX_CREATE_TIME`(`create_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '规则知识库' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_bs_knowledge
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_bs_message_type
-- ----------------------------
DROP TABLE IF EXISTS `t_bs_message_type`;
CREATE TABLE `t_bs_message_type`  (
  `message_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息类型',
  `message_type_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息类型名称',
  `parent_message_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'root' COMMENT '消息父类型',
  `message_level` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息级别，high：高；middle：中；low：低',
  `role_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息权限对象，normal：普通消息；dataAuth：数据权限，和安全域相关；userOnly：仅订阅用户可见；specifiedUser：指定用户接收',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否默认订阅',
  `is_config_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否配置类',
  `is_check_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否检查类',
  `is_inhibition` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否可抑制',
  `show_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '首页展示类型',
  `sort` int(20) NULL DEFAULT NULL COMMENT '排序',
  `ext_code` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '拓展code',
  `enable` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用(0不启用,1启用)',
  `link` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转链接',
  `link_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转类型(立即查看/立即处理/完善剧本)',
  PRIMARY KEY (`message_type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统消息类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_bs_message_type
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_bs_user_subscribe_config
-- ----------------------------
DROP TABLE IF EXISTS `t_bs_user_subscribe_config`;
CREATE TABLE `t_bs_user_subscribe_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `subscribe_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订阅类型，robot：机器人；sms：短信；email：邮件；ding：钉钉',
  `message_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '消息类型',
  `custom_config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '订阅自定义配置，json格式存储',
  `is_subscribe` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否订阅',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_bs_user_subscribe_config_UN`(`user_id`, `subscribe_type`, `message_type`) USING BTREE,
  INDEX `t_bs_user_subscribe_config_FK`(`message_type`) USING BTREE,
  INDEX `t_bs_user_subscribe_config_FK_1`(`subscribe_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户订阅配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_bs_user_subscribe_config
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_center_model
-- ----------------------------
DROP TABLE IF EXISTS `t_center_model`;
CREATE TABLE `t_center_model`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL COMMENT '产品的id',
  `model` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '最新产品的模块名称',
  `authorization` int(11) NOT NULL DEFAULT 1 COMMENT '授权：1包含；0不包含',
  `describe` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `model_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块id和平台保持一致。',
  `optional` int(11) NOT NULL DEFAULT 0 COMMENT '是否可选：0不可选，1可选',
  `version` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'v3.4',
  PRIMARY KEY (`id`, `pid`) USING BTREE,
  UNIQUE INDEX `name_UNIQUE`(`model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_center_model
-- ----------------------------
INSERT INTO `t_center_model` VALUES (1, 1, 'AiLPHA Baas 安全大数据', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_1', 0, 'v3.5');
INSERT INTO `t_center_model` VALUES (2, 1, 'Modern SIEM 安全建模中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_2', 0, 'v3.5');
INSERT INTO `t_center_model` VALUES (3, 1, 'Investigation 调查取证中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_3', 0, 'v3.5');
INSERT INTO `t_center_model` VALUES (4, 1, '资产与风险管理中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_4', 0, 'v3.1');
INSERT INTO `t_center_model` VALUES (5, 1, '态势感知中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_5', 0, 'v3.4');
INSERT INTO `t_center_model` VALUES (6, 1, 'Sherlock 威胁狩猎中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_6', 0, 'v3.5');
INSERT INTO `t_center_model` VALUES (7, 1, 'SOAR 编排响应中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_7', 1, 'v3.5');
INSERT INTO `t_center_model` VALUES (8, 1, 'UEBA 基础版', 0, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_8', 1, 'v3.1');
INSERT INTO `t_center_model` VALUES (9, 1, '可视化报告中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_9', 0, 'v3.0');
INSERT INTO `t_center_model` VALUES (10, 1, '威胁情报中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_10', 0, 'v2.3');
INSERT INTO `t_center_model` VALUES (11, 1, '安全运营中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_11', 1, 'v3.4');
INSERT INTO `t_center_model` VALUES (12, 1, '重大保障指挥中心', 0, '0', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_12', 1, 'v3.4');
INSERT INTO `t_center_model` VALUES (13, 1, '安管绩效考核', 0, '0', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_13', 1, 'v3.4');
INSERT INTO `t_center_model` VALUES (14, 1, '多租户', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_14', 0, 'v3.4');
INSERT INTO `t_center_model` VALUES (15, 2, 'AiView 可视化组件', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '2_1', 0, 'v1.3');
INSERT INTO `t_center_model` VALUES (16, 2, 'AiView 大屏设计器', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '2_2', 0, 'v1.3');
INSERT INTO `t_center_model` VALUES (17, 2, 'AiView 演示控制器', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '2_3', 0, 'v1.3');
INSERT INTO `t_center_model` VALUES (18, 2, 'AiView 数据源管理', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '2_4', 0, 'v1.3');
INSERT INTO `t_center_model` VALUES (19, 3, 'UBA 用户行为分析画像', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '3_1', 0, 'v1.0');
INSERT INTO `t_center_model` VALUES (20, 3, 'DSI 深度感知智能引擎', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '3_2', 0, 'v1.0');
INSERT INTO `t_center_model` VALUES (21, 4, '资产发现引擎', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '4_1', 0, 'v1.0');
INSERT INTO `t_center_model` VALUES (22, 4, '漏洞生命周期管理', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '4_2', 0, 'v1.0');
INSERT INTO `t_center_model` VALUES (23, 4, '基线生命周期管理', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '4_3', 0, 'v1.0');
INSERT INTO `t_center_model` VALUES (24, 5, '情报与资讯', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '5_1', 0, 'v1.0');
INSERT INTO `t_center_model` VALUES (25, 5, '情报检索中心', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '5_2', 0, 'v1.0');
INSERT INTO `t_center_model` VALUES (26, 5, '本地情报管理', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '5_3', 0, 'v1.0');
INSERT INTO `t_center_model` VALUES (27, 5, '云端情报管理', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '5_4', 0, 'v1.0');
INSERT INTO `t_center_model` VALUES (99, 27, '安全验证', 1, NULL, '2023-02-01 15:31:20', '2023-02-01 15:31:20', '27_1', 1, 'v2.0.5');

-- ----------------------------

-- ----------------------------
-- Table structure for t_center_product
-- ----------------------------
DROP TABLE IF EXISTS `t_center_product`;
CREATE TABLE `t_center_product`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `type` int(11) NOT NULL DEFAULT 1 COMMENT '产品类型:平台0，APP1',
  `describe` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stats` int(11) NOT NULL DEFAULT 0 COMMENT '状态：1可用；0不可用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_UNIQUE`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_center_product
-- ----------------------------
INSERT INTO `t_center_product` VALUES (1, 'AiLPHA 安全分析与管理平台', 0, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', 1);
INSERT INTO `t_center_product` VALUES (2, 'AiView 数据可视化中心', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', 1);
INSERT INTO `t_center_product` VALUES (3, 'AiLPHA UBA 用户行为画像中心', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', 0);
INSERT INTO `t_center_product` VALUES (4, 'AiLPHA 弱点管理中心', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', 0);
INSERT INTO `t_center_product` VALUES (5, 'AiLPHA TIP 情报管理中心', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', 0);
INSERT INTO `t_center_product` VALUES (6, 'AiCloud 云端研判', 1, NULL, '2026-01-13 10:37:47', '2026-01-13 10:37:47', 1);

-- ----------------------------

-- ----------------------------
-- Table structure for t_common_config
-- ----------------------------
DROP TABLE IF EXISTS `t_common_config`;
CREATE TABLE `t_common_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `prefix` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类',
  `configKey` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `configValue` varchar(20000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name_uni`(`prefix`, `configKey`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '通用配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_common_config
-- ----------------------------
INSERT INTO `t_common_config` VALUES (1, 'asset', 'soc.sync.enable', '1');
INSERT INTO `t_common_config` VALUES (2, 'asset', 'flaw.sync.enable', '1');
INSERT INTO `t_common_config` VALUES (3, 'asset', 'auto.sync.enable', '1');
INSERT INTO `t_common_config` VALUES (5, 'web', 'auto.web.enable', '0');
INSERT INTO `t_common_config` VALUES (6, 'web', 'auto.web.area', '0');
INSERT INTO `t_common_config` VALUES (7, 'web', 'auto.web.type', '0');
INSERT INTO `t_common_config` VALUES (8, 'edr', 'edr.sync.enable', '0');
INSERT INTO `t_common_config` VALUES (9, 'ailpha', 'version.update.time', '2026-01-13 10:37:43');
INSERT INTO `t_common_config` VALUES (10, 'style', 'title', 'AiLPHA安全分析与管理平台');
INSERT INTO `t_common_config` VALUES (11, 'style', 'color', '');
INSERT INTO `t_common_config` VALUES (12, 'style', 'logo', '/oem/headerLogo.png,/oem/layoutLogo.png');
INSERT INTO `t_common_config` VALUES (13, 'style', 'screenlogo', 'default');
INSERT INTO `t_common_config` VALUES (14, 'style', 'companyname', '杭州安恒信息技术股份有限公司');
INSERT INTO `t_common_config` VALUES (15, 'style', 'techsupport', '安恒 AiLPHA BaaS 提供计算服务');
INSERT INTO `t_common_config` VALUES (16, 'origin', 'title', 'AiLPHA安全分析与管理平台');
INSERT INTO `t_common_config` VALUES (17, 'origin', 'color', '');
INSERT INTO `t_common_config` VALUES (18, 'origin', 'logo', '/oem/headerLogo.png,/oem/layoutLogo.png');
INSERT INTO `t_common_config` VALUES (19, 'origin', 'companyname', '杭州安恒信息技术股份有限公司');
INSERT INTO `t_common_config` VALUES (20, 'origin', 'techsupport', '安恒 AiLPHA BaaS 提供计算服务');
INSERT INTO `t_common_config` VALUES (21, 'origin', 'screenlogo', 'default');
INSERT INTO `t_common_config` VALUES (22, 'order', 'order.auto.send.responsible', '0');
INSERT INTO `t_common_config` VALUES (28, 'sty', 'accessKey', 'f6feadca-38c9-471e-ba9f-fcd3eefddfbc');
INSERT INTO `t_common_config` VALUES (29, 'sty', 'secretKey', 'f6fsdfaca-40c9-871e-ba9f-fcd3eefdabcd');
INSERT INTO `t_common_config` VALUES (30, 'apikey', 'secure', 'apiTrustByDelin');
INSERT INTO `t_common_config` VALUES (31, 'dasca-dbappsecurity-ainta', 'accessKey', '1cf2bb1de1024a94140a9d7f8597c0ba');
INSERT INTO `t_common_config` VALUES (32, 'dasca-dbappsecurity-ainta', 'accessKeySecret', 'birlovoidv9S+iu45cuhfPo0g3p1J3fI3gYDGgywz6uPZRqpDW4+nspxGN8UGw6INulCihseo+Iro2xCRwnU7klt6yFY0fWTeuRQmwhPbJSdB65UHWYchjC1iQwjuv1u/ZAYqO96SJpkJhC+e0eP9A46jCo0pInQn626cOqYQzCutcbNTd7eHxUpxnC0FgsM8+TeNXB4yzaohrcg+sRcxzpW+Ugo9GptLUJfZTLkMUyNI+5GcqWJajFVozKD14L4iYUpVTEStANcf7RbPx0mOkxcsOIrCQkrJFE2NC3OWPD6L0LwPJKUQQyXfE6x4GNMCmuwv6GIvq36Xl1pmrX/fQ==');
INSERT INTO `t_common_config` VALUES (35, 'ailpha.cloud.access.default', 'ASE_KEY', 'SkWrZ;9A#jHc(N_6');
INSERT INTO `t_common_config` VALUES (36, 'ailpha.cloud.access.default', 'IV_KEY', 's5YHnw8z#U]kB;.0');
INSERT INTO `t_common_config` VALUES (37, 'ailpha.cloud.access.default', 'FILLING_MODE', 'AES/CBC/PKCS5Padding');
INSERT INTO `t_common_config` VALUES (38, 'baas', 'baas.admin.username', 'admin');
INSERT INTO `t_common_config` VALUES (39, 'baas', 'baas.admin.password', 'b!o3jraZ4a');
INSERT INTO `t_common_config` VALUES (40, 'aigent', 'aigent_api_key', '6cb6a5442d0f4030b6100e8869a4d153');
INSERT INTO `t_common_config` VALUES (41, 'default.password', 'admin', 'iS%4Rh37g3');
INSERT INTO `t_common_config` VALUES (42, 'default.password', 'userAdmin', 'iS%4Rh37g3');
INSERT INTO `t_common_config` VALUES (43, 'default.password', 'opAdmin', 'iS%4Rh37g3');
INSERT INTO `t_common_config` VALUES (44, 'default.password', 'ailpha', 'F@Jhq5GyW7');
INSERT INTO `t_common_config` VALUES (45, 'default.password', 'simpleUser', 'do*JKfn7PK');
INSERT INTO `t_common_config` VALUES (46, 'baas.admin', 'username', 'admin');
INSERT INTO `t_common_config` VALUES (47, 'baas.admin', 'password', 'b!o3jraZ4a');
INSERT INTO `t_common_config` VALUES (48, 'waf', 'token', 'dbapp-ailpha-3fd110f82c76fb8e48ce6b6493102ec5');
INSERT INTO `t_common_config` VALUES (49, 'ailpha.cloud.access.default', 'key', 'a1ac51403f2bd5ec26bc296edd2fb8c2');
INSERT INTO `t_common_config` VALUES (50, 'ailpha.cloud.access.default', 'secret', 'bd49b489c27e2e7e1ad8576181306f2f91137822c1a06d0c0aa74912930b52b1');
INSERT INTO `t_common_config` VALUES (51, 'dasca.access', 'key', 'a429561d31b54a37814141de9d2d823c');
INSERT INTO `t_common_config` VALUES (52, 'default.password', 'ssh', '1qazcde3!@#');
INSERT INTO `t_common_config` VALUES (53, 'secure', 'ase.key', 'SkWrZ;9A#jHc(N_6');
INSERT INTO `t_common_config` VALUES (54, 'secure', 'iv.key', 's5YHnw8z#U]kB;.0');
INSERT INTO `t_common_config` VALUES (55, 'baas', 'apikey', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTU3NjMxMjc1M30.ptGyiP75SXrkbJ4m9RYy2AtqMQHuxWI9Bi4-lebuzC0AL65gl0BF7v289Eayu7IeiX2CM9SV1WEIsPNbpj0_lQ');
INSERT INTO `t_common_config` VALUES (66, 'kibana', 'user', 'admin');
INSERT INTO `t_common_config` VALUES (67, 'kibana', 'cipher', 'unFx7%EbR3');
INSERT INTO `t_common_config` VALUES (68, 'kibana', 'version', '6.8.0');
INSERT INTO `t_common_config` VALUES (69, 'user.data.acquisition.file', 'password', 'v58a$2nT6C');
INSERT INTO `t_common_config` VALUES (70, 'update.knowledge.zip', 'password', 'ePb%R7XW#$');
INSERT INTO `t_common_config` VALUES (71, 'ailpha.connect', 'key', 'WVdsc2NHaGhYMlJsZG05d2N3bz0K');
INSERT INTO `t_common_config` VALUES (72, 'update.rule.zip', 'password', 'ePb%R7XW#$');
INSERT INTO `t_common_config` VALUES (73, 'ailpha.unzip', 'cipher', 'ePb%R7XW#$');
INSERT INTO `t_common_config` VALUES (74, 'xdr.package.unzip', 'password', 'ePb%R7XW#$');
INSERT INTO `t_common_config` VALUES (75, 'AiNTA.api', 'key', 'DFSraR8JUvoVSvIcGMgdMjlAUjXyX18LTPglj4zWEGM=');
INSERT INTO `t_common_config` VALUES (76, 'ambari', 'passwd', 'bTxUv7rGU*');
INSERT INTO `t_common_config` VALUES (77, 'crypt', 'key', 'security_service');
INSERT INTO `t_common_config` VALUES (78, 'intelligence.centre', 'username', 'ailpha');
INSERT INTO `t_common_config` VALUES (79, 'intelligence.centre', 'cipher', 'c53083d80193b3929cd2d6d7c766e288');
INSERT INTO `t_common_config` VALUES (80, 'ioa.engine.zip', 'password', '4*K1woCwc1zna-zQ');
INSERT INTO `t_common_config` VALUES (81, 'update.aigent.zip', 'password', 'ePb%R7XW#$');
INSERT INTO `t_common_config` VALUES (82, 'snmp.pwd', 'aes.key', 'SkWrZ;9A#jHc(N_6');
INSERT INTO `t_common_config` VALUES (83, 'snmp.pwd', 'iv.key', 's5YHnw8z#U]kB;.0');
INSERT INTO `t_common_config` VALUES (84, 'baas', 'baas.admin.password.new', '70d26c7ff56237a12ed1c9000763aeeabc83db25');
INSERT INTO `t_common_config` VALUES (85, 'ailpha', 'v2.0.6.update.time', '2026-01-13 10:37:48');
INSERT INTO `t_common_config` VALUES (86, 'license', 'apt.private.key', 'MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJRGtA04Ue71r+OWsiAvXe0PD0wUBYQwjlzsidRPviuZMO47QaSEL4eb0sNE2c3yTIdjEa3w+FGFrVoaNuC8u6E7s+I5hquBvpJl8LZoVPCAQGHZ8fpr2Ss9aWEaC6Zrd2OLmTMgYzEKHZpKqkYVJwFaa1xMwwN0sHRfjNrdrFd5AgMBAAECgYAgu8sb8AcGfe6qi6YfPNW7c8uou/LLz/xdv0peOIx/C36l2ScQrq3ffiL1QMnkkU0bxl8syznGpYAzl/3tdzzkbhZoofqq/uRs6OF3nX2ldMAY+R/wXf3YwCbN64KHi/ieMRjlq8I32SVaGKl89Yu60PdBXUiyQZo5nxEuQx9/0QJBAP+i9ZIBpsWUDcCRrqKdhjGY+aOlVb94IJcOBKlDVKjq0N9PSxN6XC+NqZmNt55ZOUq8ok0XIhHC0YND+boC5jcCQQCUfKtkJwJxS1y0Z5XpJ0LpsteqAOK15RAQdZUppM5akzAM6k8E6eZq7QZ0mss1LnTQuafey2JfPUYesdFr5NfPAkB7WZ+TBzb4qVsFa4ZPsyDYd88ldpbsn8NiAAKhxfpo031b83/vcyBeVcXbcTWDs9vgQysxdZMb7Nx5sWgjqFh7AkABx1CCPZlg5AczPf5ksYyyoerFZYdRqHG90Lq9qfSyzwqHTRMvOuIAq+Ak62m9tFW/3klteMAv5dr+KSEaCr6vAkEA3Xa67LzDdNrRRYRU4yHfVFVn3uKDb8/dYHj36e2SPvzHFRxJ/cnNV1mpW1N16emPkhnyGMWppNoPAwD6er67Zw==');
INSERT INTO `t_common_config` VALUES (87, 'ah_brain', 'ah_brain_server', 'https://www.das-ai.com');
INSERT INTO `t_common_config` VALUES (88, 'ah_brain', 'ah_brain_appKey', 'OzlFyBdUjnFJNaR1BR3duD+1MH/qLdhY+PgYgwK9H5jW5ShCgFhOJg==');
INSERT INTO `t_common_config` VALUES (89, 'ah_brain', 'ah_brain_appSecret', 'XhmTVyCFZ5hTkJrpBrjgETVrfLsTmuQCxKPVxEewC/kp+2xyxrh8WSqBH9PJ4dBf');
INSERT INTO `t_common_config` VALUES (93, 'mss', 'openId', 'fd098fe6-195c-4aca-9963-da40729ad0cf');
INSERT INTO `t_common_config` VALUES (94, 'mss', 'secretKey', 'UyJzfDurBLuFIDVikEpeuKZGoeZuPpNkjChDnHsnrzbJurouFLvVyCdqHHnXiIqIlXNQocEhoSgYZfnQqbMkdAgwtOJKWESzYlvyyFOjZUrsIyMSzIGPnfqrqPWjVodA');
INSERT INTO `t_common_config` VALUES (95, 'mss', 'updateStatus', '1');
INSERT INTO `t_common_config` VALUES (98, 'init', 'ailpha_cloud_access', 'a1ac51403f2bd5ec26bc296edd2fb8c2:bd49b489c27e2e7e1ad8576181306f2f91137822c1a06d0c0aa74912930b52b1');
INSERT INTO `t_common_config` VALUES (102, 'ah_brain', 'filter-config-AutomaticJudge', '[{\"filterContent\":\"subCategory == \\\"/ConfigRisk/WeakPassword\\\" AND appProtocol != \\\"http\\\" AND alarmResults == \\\"OK\\\"\",\"judgeResult\":\"vulnerabilityExploitationSuccess\",\"type\":\"vulnerability\",\"updateTime\":\"2025-06-18 10:49:02\"},{\"filterContent\":\"alarmResults == \\\"OK\\\" AND subCategory == \\\"/WebAttack/BypassAccCtrl\\\"\",\"judgeResult\":\"vulnerabilityExploitationSuccess\",\"type\":\"vulnerability\",\"updateTime\":\"2025-06-18 10:49:02\"},{\"filterContent\":\"(alarmName == \\\"异常页面导致服务器路径泄漏\\\" OR alarmName == \\\"检测到目录启用了自动目录列表功能\\\") AND alarmResults == \\\"OK\\\"\",\"judgeResult\":\"vulnerabilityExploitationSuccess\",\"type\":\"vulnerability\",\"updateTime\":\"2025-06-18 10:49:02\"},{\"filterContent\":\"alarmResults == \\\"FAIL\\\"\",\"judgeResult\":\"attackFailure\",\"type\":\"attack\",\"updateTime\":\"2025-06-18 10:49:02\"},{\"filterContent\":\"category == \\\"/Scan\\\"\",\"judgeResult\":\"attackAttempt\",\"type\":\"attack\",\"updateTime\":\"2025-06-18 10:49:02\"},{\"filterContent\":\"transProtocol == \\\"TCP\\\" AND category == \\\"/Malware\\\" AND catOutcome == \\\"OK\\\" AND direction == \\\"01\\\"\",\"judgeResult\":\"attackSuccess\",\"type\":\"attack\",\"updateTime\":\"2025-06-18 10:49:02\"}]');
INSERT INTO `t_common_config` VALUES (103, 'ah_brain', 'filter-config-ActiveAttack', 'IoC notexist or ( IoC exist AND processId exist )');
INSERT INTO `t_common_config` VALUES (104, 'ah_brain', 'filter-config-TiTimeSeries', 'IoC exist  AND processId notexist ');
INSERT INTO `t_common_config` VALUES (105, 'style', 'showTitle', 'true');
INSERT INTO `t_common_config` VALUES (106, 'style', 'show_title_changed', '0');
INSERT INTO `t_common_config` VALUES (107, 'ah_brain', 'ah_brain_analysis_agent_id', 'd6ab0e2a-1ed5-4e4f-a5ad-3c5999be5636');
INSERT INTO `t_common_config` VALUES (108, 'ah_brain', 'ah_brain_handler_agent_id', 'c6770766-9df7-46a9-973b-67e2b3d2c4dc');
INSERT INTO `t_common_config` VALUES (109, 'ah_brain', 'ah_brain_risk_agent_id', '9566d732-5af0-440e-be98-1936913badef');
INSERT INTO `t_common_config` VALUES (110, 'ah_brain', 'ah_brain_review_agent_id', '3f81ebde-53c2-4344-9cc1-bf13086ce6e1');
INSERT INTO `t_common_config` VALUES (111, 'ah_brain', 'ah_brain_detection_agent_id', '58931f05-2556-423e-92a8-6d2ae0cbaa46');

-- ----------------------------

-- ----------------------------
-- Table structure for t_component_update_record
-- ----------------------------
DROP TABLE IF EXISTS `t_component_update_record`;
CREATE TABLE `t_component_update_record`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'mirror版本信息',
  `package_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '升级包类型',
  `file_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '升级包文件名',
  `success` tinyint(1) NOT NULL COMMENT '是否升级成功',
  `error_message` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '错误信息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_version_package_type_file_name`(`version`, `package_type`, `file_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组件升级记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_component_update_record
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_dashboard
-- ----------------------------
DROP TABLE IF EXISTS `t_dashboard`;
CREATE TABLE `t_dashboard`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `boardName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仪表盘名称',
  `boardDescribe` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '描述',
  `updateTime` bigint(10) NOT NULL COMMENT '更新时间',
  `isFactory` bigint(4) NOT NULL COMMENT '是否出厂',
  `layoutJson` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '布局结构',
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `state` tinyint(4) NOT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dashboard
-- ----------------------------
INSERT INTO `t_dashboard` VALUES ('0b7dac0c98377864', '护网实时监测', '护网实时监测报表', 1586248286020, 0, '{\"4-4-4@0\":[\"963cb774-740e-11ea-9d6c-024248760016\",\"c222db48-740e-11ea-9d6c-024248760016\",\"7f1d2176-740e-11ea-9d6c-024248760016\"],\"3-9@1\":[\"41b681e6-748b-11ea-9d6c-024248760016\",\"07d3663e-748e-11ea-9d6c-024248760016\"],\"3-9@2\":[\"caf2158f-74ad-11ea-9d6c-024248760016\",\"e5dbb68b-78a1-11ea-9d6c-024248760016\"],\"6-6@3\":[\"d94e7e21-78af-11ea-9d6c-024248760016\",\"2bbdbbac-74ac-11ea-9d6c-024248760016\"],\"12@4\":[\"acae5fcc-740e-11ea-9d6c-024248760016\"]}', 'admin', 1);
INSERT INTO `t_dashboard` VALUES ('650777ab9f675283', '内网安全威胁', '展示内网威胁信息，包括各种威胁的分布，和对目标地址的访问趋势，回连，挖矿，勒索等威胁的目标地址分布等信息', 1532312937361, 0, '{\"4-4-4@0\":[\"f47a59fb-8e1d-11e8-ad15-024248760016\",\"c7643c7a-8e1d-11e8-ad15-024248760016\",\"22f2e651-8e1e-11e8-ad15-024248760016\"],\"4-4-4@1\":[\"6b379605-8e1e-11e8-ad15-024248760016\",\"b41d420f-8e1e-11e8-ad15-024248760016\",\"e8f9301e-8e1e-11e8-ad15-024248760016\"],\"4-4-4@2\":[\"09f82a23-8e1f-11e8-ad15-024248760016\",\"2e158070-8e1f-11e8-ad15-024248760016\",\"52427d82-8e1f-11e8-ad15-024248760016\"]}', 'admin', 1);
INSERT INTO `t_dashboard` VALUES ('b6b19dd4ac263d12', '安全数据质量监控', '安全数据质量监控', 1585908711193, 0, '{\"8-4@0\":[\"4a4f3fc4-7575-11ea-9d6c-024248760016\",\"24579617-74af-11ea-9d6c-024248760016\"],\"4-4-4@1\":[\"f21bd775-7579-11ea-9d6c-024248760016\",\"af3bf562-7579-11ea-9d6c-024248760016\",\"0af41832-74af-11ea-9d6c-024248760016\"],\"4-8@2\":[\"c507b8bc-7579-11ea-9d6c-024248760016\",\"7f1d2176-740e-11ea-9d6c-024248760016\"]}', 'admin', 1);

-- ----------------------------

-- ----------------------------
-- Table structure for t_dashboard_order
-- ----------------------------
DROP TABLE IF EXISTS `t_dashboard_order`;
CREATE TABLE `t_dashboard_order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `boardOrder` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '顺序',
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dashboard_order
-- ----------------------------
INSERT INTO `t_dashboard_order` VALUES (1, '650777ab9f675283,0b7dac0c98377864,b6b19dd4ac263d12', 'admin');

-- ----------------------------

-- ----------------------------
-- Table structure for t_data_dict
-- ----------------------------
DROP TABLE IF EXISTS `t_data_dict`;
CREATE TABLE `t_data_dict`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型',
  `label` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '显示值',
  `isdel` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0:删除；1:正常',
  `createuser` bigint(20) NOT NULL COMMENT '创建人',
  `createtime` datetime NOT NULL COMMENT '创建时间',
  `updateuser` bigint(20) NOT NULL COMMENT '修改人',
  `updatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_dict_type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_data_dict
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_default_intelligence_source_function
-- ----------------------------
DROP TABLE IF EXISTS `t_default_intelligence_source_function`;
CREATE TABLE `t_default_intelligence_source_function`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '情报源功能ID',
  `intelligence_source_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源英文标识',
  `function` enum('ONLINE_UPDATE','OFFLINE_UPDATE','API_UPDATE','EXPORT','INTELLIGENCE_ADD','INTELLIGENCE_DELETE','INTELLIGENCE_MODIFY','INTELLIGENCE_RETRIEVE','INTELLIGENCE_RETRIEVE_BY_API','SETUP','MANAGE','REMOVE','CLONE') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源功能',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源功能名称',
  `type` enum('tab','button','operate') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情报源功能类型：tab-标签页(情报数据更新、导出等操作需要另起tab页)；button-按钮(情报源自身操作，设置、管理、移除、克隆)；operate-操作(情报操作，增删改查等)',
  `enable` tinyint(4) NOT NULL DEFAULT 1 COMMENT '情报源功能启禁用',
  `description` varchar(4096) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '情报源功能描述',
  `config` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '情报源功能配置，JSONObject格式',
  `operations` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '情报源功能包含的操作、按钮等，JSONArray格式',
  `order` tinyint(4) NOT NULL COMMENT '功能顺序',
  `display` tinyint(4) NOT NULL DEFAULT 1 COMMENT '情报源功能是否展示',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_intelligenceSourceCode_function`(`intelligence_source_code`, `function`) USING BTREE,
  CONSTRAINT `foreign_key_default_function_to_source` FOREIGN KEY (`intelligence_source_code`) REFERENCES `t_default_intelligence_source_metadata` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '默认情报源功能，用于重置情报源时恢复数据用' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_default_intelligence_source_function
-- ----------------------------
INSERT INTO `t_default_intelligence_source_function` VALUES (1, 'ThreatIntelligenceCentreSource', 'OFFLINE_UPDATE', '离线更新', 'tab', 1, '可通过以下方式获取威胁情报许可：\n1、导出许可申请文件\n2、登录安恒公司内网，将导出的申请文件发送 http://t.dbappsecurity.com.cn ，订阅威胁情报', '{\"belongTo\":\"OFFLINE_UPDATE\"}', '{\"ExportLicenseFile\":{\"name\":\"导出许可申请文件\",\"operation\":\"ExportLicenseFile\"},\"UploadUpdatePackage\":{\"name\":\"上传更新包\",\"operation\":\"UploadUpdatePackage\"}}', 1, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (2, 'ThreatIntelligenceCentreSource', 'ONLINE_UPDATE', '在线更新', 'tab', 0, '', '{\"belongTo\":\"ONLINE_UPDATE\",\"tiToken\":\"\"}', '{\"UpdateOnline\":{\"name\":\"在线更新\",\"operation\":\"UpdateOnline\"},\"UserExperienceProgram\":{\"name\":\"参加\\\"AiLPHA用户体验改善计划\\\"\",\"operation\":\"UserExperienceProgram\",\"value\":false},\"ConnectivityTest\":{\"name\":\"连通性测试\",\"operation\":\"ConnectivityTest\"},\"UpdateNow\":{\"name\":\"立即更新\",\"operation\":\"UpdateNow\"},\"ProxyConfiguration\":{\"name\":\"代理配置\",\"operation\":\"ProxyConfiguration\"},\"DNSConfiguration\":{\"name\":\"DNS配置\",\"operation\":\"DNSConfiguration\"}}', 2, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (3, 'ThreatIntelligenceCentreSource', 'API_UPDATE', 'Api更新', 'tab', 0, '', '{\"belongTo\":\"API_UPDATE\"}', '', 3, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (4, 'ThreatIntelligenceCentreSource', 'EXPORT', '情报导出', 'tab', 0, '暂不支持', '{\"belongTo\":\"EXPORT\"}', '{\"GenerateExportFile\":{\"name\":\"生成情报导出文件\",\"operation\":\"GenerateExportFile\"},\"Download\":{\"name\":\"下载\",\"operation\":\"Download\"}}', 4, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (5, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_ADD', '情报新增', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_ADD\"}', '', 5, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (6, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_DELETE', '情报删除', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_DELETE\"}', '', 6, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (7, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_MODIFY', '情报修改', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_MODIFY\"}', '', 7, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (8, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_RETRIEVE', '情报检索', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE\"}', '', 8, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (9, 'ThreatIntelligenceCentreSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"ONLINE_UPDATE\"]}', '', 9, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (10, 'ThreatIntelligenceCentreSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 10, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (11, 'ThreatIntelligenceCentreSource', 'REMOVE', '移除', 'button', 0, '', '{\"belongTo\":\"REMOVE\"}', '', 11, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (12, 'ThreatIntelligenceCentreSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 12, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (18, 'NSFOCUSApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[]}', '', 1, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (19, 'NSFOCUSApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (20, 'NSFOCUSApiIntelligenceSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 3, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (21, 'NSFOCUSApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (22, 'NSFOCUSApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (23, 'TianJiPartnersApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[]}', '', 1, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (24, 'TianJiPartnersApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (25, 'TianJiPartnersApiIntelligenceSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 3, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (26, 'TianJiPartnersApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (27, 'TianJiPartnersApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (28, 'WeiBuApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[{\"name\":\"微步TIP情报碰撞接口\",\"code\":\"WeiBuHit\",\"use\":-1,\"tag\":1,\"method\":\"GET\",\"protocol\":\"http\",\"domain\":\"TIP:PORT\",\"path\":\"/api/v3/intelligence_search\",\"params\":[{\"key\":\"apiKey\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，微步TIP平台业务管理配置页面生成\",\"isIoC\":false},{\"key\":\"data\",\"value\":\"www.baidu.com\",\"description\":\"IP地址或域名，查询情报IoC样例，可为空\",\"isIoC\":true}],\"demo\":\"http://TIP:PORT/api/v3/intelligence_search?apiKey=YOUR-KEY&data=www.baidu.com\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"content.0.data AS IoC, content.0.now.0.type AS mclass, content.0.now.0.type AS sclass, content.0.now.0.type AS tags, content.0.now.0.confidence AS confidence, content.0.now.0.severity AS IoCLevel, content.0.data_type AS IoCType, content.0.data_type AS TIName\"},{\"name\":\"微步TIP情报查询接口\",\"code\":\"WeiBuQuery\",\"use\":1,\"tag\":1,\"method\":\"GET\",\"protocol\":\"http\",\"domain\":\"TIP:PORT\",\"path\":\"/api/v3/intelligence_search/all\",\"params\":[{\"key\":\"apiKey\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，微步TIP平台业务管理配置页面生成\",\"isIoC\":false},{\"key\":\"data\",\"value\":\"www.baidu.com\",\"description\":\"IP地址或域名，查询情报IoC样例，可为空\",\"isIoC\":true}],\"demo\":\"http://TIP:PORT/api/v3/intelligence_search/all?apiKey=YOUR-KEY&data=www.baidu.com\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"data.0.raw.ioc AS IoC, data.0.raw.intel_type AS mclass, data.0.raw.intel_type AS sclass, data.0.raw.intel_type AS tags, data.0.raw.confidence AS confidence, data.0.raw.severity AS IoCLevel, data.0.raw.ioc_type AS IoCType, data.0.raw.timestamp AS createTime, data.0.raw.APT AS isAPT, data.0.raw.whois.registrant_name AS registrationName, data.0.raw.whois.update_date AS refreshDate, data.0.raw.whois.expiry_date AS expirationDate, data.0.raw.whois.create_date AS registrationTime, data.0.raw.whois.name_server AS dns, data.0.raw.whois.registrar_name AS registrar, data.0.raw.whois.tech_street AS street, data.0.raw.whois.tech_city AS city, data.0.raw.whois.tech_country AS country, data.0.raw.whois.registrant_email AS registrationEmail, data.0.raw.whois.registrant_email AS TIName\"}]}', '', 1, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (29, 'WeiBuApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (30, 'WeiBuApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (31, 'WeiBuApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);
INSERT INTO `t_default_intelligence_source_function` VALUES (32, 'AnHengTipApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[{\"name\":\"安恒TIP情报IP信誉接口\",\"code\":\"anhengIP\",\"use\":0,\"tag\":2,\"method\":\"POST\",\"protocol\":\"https\",\"domain\":\"TIP:PORT\",\"path\":\"/api/v2/ip_reputation\",\"headers\":[{\"key\":\"Content-Type\",\"value\":\"application/json\",\"description\":\"请求体中数据格式：application/json\",\"isIoC\":false},{\"key\":\"Tip-Token\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，安恒TIP平台情报协同页面生成\",\"isIoC\":false}],\"body\":[{\"key\":\"ioc\",\"value\":\"83.171.237.173\",\"description\":\"IP地址，查询情报IoC样例，可为空\",\"isIoC\":true},{\"key\":\"only_malicious\",\"value\":false,\"description\":\"是否只显示恶意IP，默认false即全部显示，包括安全的数据\",\"isIoC\":false}],\"demo\":\"https://TIP:PORT/api/v2/ip_reputation\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"\"},{\"name\":\"安恒TIP情报域名信誉接口\",\"code\":\"anhengDomain\",\"use\":0,\"tag\":5,\"method\":\"POST\",\"protocol\":\"https\",\"domain\":\"TIP:PORT\",\"path\":\"/api/v2/domain_reputation\",\"headers\":[{\"key\":\"Content-Type\",\"value\":\"application/json\",\"description\":\"请求体中数据格式：application/json\",\"isIoC\":false},{\"key\":\"Tip-Token\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，安恒TIP平台情报协同页面生成\",\"isIoC\":false}],\"body\":[{\"key\":\"ioc\",\"value\":\"martin27.xyz\",\"description\":\"域名，查询情报IoC样例，可为空\",\"isIoC\":true},{\"key\":\"only_malicious\",\"value\":false,\"description\":\"是否只显示恶意域名，默认false即全部显示，包括安全的数据\",\"isIoC\":false}],\"demo\":\"https://TIP:PORT/api/v2/domain_reputation\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"\"}]}', '', 1, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (33, 'AnHengTipApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (34, 'AnHengTipApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 3, 1);
INSERT INTO `t_default_intelligence_source_function` VALUES (35, 'AnHengTipApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 4, 0);

-- ----------------------------

-- ----------------------------
-- Table structure for t_default_intelligence_source_metadata
-- ----------------------------
DROP TABLE IF EXISTS `t_default_intelligence_source_metadata`;
CREATE TABLE `t_default_intelligence_source_metadata`  (
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
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '默认情报源，用于重置情报源时恢复数据用' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_default_intelligence_source_metadata
-- ----------------------------
INSERT INTO `t_default_intelligence_source_metadata` VALUES (1, '安恒威胁情报中心', 'ThreatIntelligenceCentreSource', 'dbapp', 'local', 'build-in', 1, 1, '2026-01-13 10:37:46', '2026-01-13 10:37:46');
INSERT INTO `t_default_intelligence_source_metadata` VALUES (2, '微步威胁情报TIP平台', 'WeiBuApiIntelligenceSource', 'weibu', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50');
INSERT INTO `t_default_intelligence_source_metadata` VALUES (3, '绿盟威胁情报TIP平台', 'NSFOCUSApiIntelligenceSource', 'lvmeng', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50');
INSERT INTO `t_default_intelligence_source_metadata` VALUES (4, '天际友盟威胁情报TIP平台', 'TianJiPartnersApiIntelligenceSource', 'tianji', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50');
INSERT INTO `t_default_intelligence_source_metadata` VALUES (5, '安恒威胁情报TIP平台', 'AnHengTipApiIntelligenceSource', 'anhengTIP', 'API', 'build-in', 0, 0, '2026-01-13 10:37:50', '2026-01-13 10:37:50');

-- ----------------------------

-- ----------------------------
-- Table structure for t_device
-- ----------------------------
DROP TABLE IF EXISTS `t_device`;
CREATE TABLE `t_device`  (
  `id` int(25) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '序号',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',
  `device_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '设备编号',
  `device_state` tinyint(1) NULL DEFAULT 0 COMMENT '设备状态[0-禁用 1-启动]',
  `tags` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '标签，多个以英文逗号分隔',
  `config` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备配置信息结构',
  `config_data` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '设备配置信息数据',
  `app_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'app编号',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'other',
  `linkedState` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '防火墙/EDR联动状态：连接异常、联动中、未启用',
  `deviceModel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备模块',
  `deviceType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备类型',
  `assetType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产类型',
  `linkage` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联动方式:https/ssh等',
  `push_default` tinyint(1) NULL DEFAULT 0 COMMENT '是否为默认的推送配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `t_device_device_id_uindex`(`device_id`) USING BTREE,
  UNIQUE INDEX `t_device_device_name_uindex`(`device_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'app下注册的设备信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_device
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_dilatation_history
-- ----------------------------
DROP TABLE IF EXISTS `t_dilatation_history`;
CREATE TABLE `t_dilatation_history`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '扩容状态，-1:扩容中，0:扩容失败，1:扩容成功',
  `current_config` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '本次扩容配置',
  `last_config` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '扩容前配置',
  `progress` decimal(4, 2) NULL DEFAULT NULL COMMENT '扩容进度',
  `offset` int(11) NULL DEFAULT NULL COMMENT '日志读取偏移量',
  `create_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted` tinyint(4) NULL DEFAULT 0 COMMENT '0:正常；1:删除',
  `log_path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dilatation_history
-- ----------------------------

-- ----------------------------

-- ----------------------------
-- Table structure for t_dispose_event
-- ----------------------------
DROP TABLE IF EXISTS `t_dispose_event`;
CREATE TABLE `t_dispose_event`  (
  `id` bigint(23) NOT NULL AUTO_INCREMENT,
  `title` varchar(127) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `assigneeId` bigint(23) NOT NULL COMMENT '受理人ID',
  `creatorId` bigint(23) NOT NULL COMMENT '创建人ID',
  `disposeAction` varchar(23) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '处置动作',
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态',
  `domain` varchar(63) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '域名',
  `ip` varchar(63) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `index_assignee`(`assigneeId`) USING BTREE,
  INDEX `index_creator`(`creatorId`) USING BTREE,
  CONSTRAINT `fk_assigneedId` FOREIGN KEY (`assigneeId`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_creatorId` FOREIGN KEY (`creatorId`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dispose_event
-- ----------------------------

-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
