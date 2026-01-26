/*
 * Table: t_scene_rule_info
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_scene_rule_info_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_scene_rule_info_id_seq" CASCADE;
CREATE SEQUENCE "t_scene_rule_info_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_scene_rule_info_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_scene_rule_info
-- ----------------------------
DROP TABLE IF EXISTS "t_scene_rule_info";
CREATE TABLE "t_scene_rule_info" (
  "id" int8 NOT NULL DEFAULT nextval('t_scene_rule_info_id_seq'::regclass),
  "rule_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "data_source" varchar(100) COLLATE "pg_catalog"."default",
  "scene_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "rule_name" varchar(100) COLLATE "pg_catalog"."default",
  "description" varchar(1000) COLLATE "pg_catalog"."default",
  "suggestion" varchar(1000) COLLATE "pg_catalog"."default",
  "group_by" text COLLATE "pg_catalog"."default",
  "list_param" text COLLATE "pg_catalog"."default",
  "chart_param" text COLLATE "pg_catalog"."default",
  "detail_condition" varchar(1000) COLLATE "pg_catalog"."default",
  "is_open" bool NOT NULL DEFAULT true,
  "default_switch" bool DEFAULT false,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_scene_rule_info" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scene_rule_info"."rule_id" IS '规则id，唯一';
COMMENT ON COLUMN "t_scene_rule_info"."data_source" IS '数据源，原始告警、原始日志';
COMMENT ON COLUMN "t_scene_rule_info"."scene_name" IS '场景名称（与菜单挂钩）';
COMMENT ON COLUMN "t_scene_rule_info"."rule_name" IS '规则中文名';
COMMENT ON COLUMN "t_scene_rule_info"."description" IS '描述及危害';
COMMENT ON COLUMN "t_scene_rule_info"."suggestion" IS '建议';
COMMENT ON COLUMN "t_scene_rule_info"."group_by" IS '聚合字段json配置';
COMMENT ON COLUMN "t_scene_rule_info"."list_param" IS '列表json配置';
COMMENT ON COLUMN "t_scene_rule_info"."chart_param" IS '图表json配置';
COMMENT ON COLUMN "t_scene_rule_info"."detail_condition" IS '列表详情搜索条件';
COMMENT ON COLUMN "t_scene_rule_info"."is_open" IS '是否开启';
COMMENT ON COLUMN "t_scene_rule_info"."default_switch" IS '默认开关状态';

-- ----------------------------
-- Records of t_scene_rule_info
-- ----------------------------
BEGIN;
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (1, 'bruteForce', 'security_alarms', '登陆分析', '暴力破解', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:19:06+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (2, 'weakPassword', 'security_alarms', '登陆分析', '弱口令', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:20:04+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (3, 'clearTextCredit', 'security_alarms', '登陆分析', '明文传输', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:20:26+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (4, 'privilegedAccount', 'security_logs', '登陆分析', '特权账号登陆', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:20:44+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (5, 'externalAccess', 'security_logs', '访问关系', '外部访问', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:21:00+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (6, 'crossAccess', 'security_logs', '访问关系', '横向访问', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:21:14+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (7, 'internalHostConnection', 'security_logs', '访问关系', '内部主机外联行为', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:21:31+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (8, 'suspiciousWebScan', 'security_logs', 'Web服务分析', '可疑Web扫描', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:22:24+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (9, 'posternUsage', 'security_alarms', 'Web服务分析', '后门利用分析', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:23:00+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (10, 'suspiciousPosternAccess', 'security_logs', 'Web服务分析', '可疑后门访问', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:23:24+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (11, 'miningHostAnalysis', 'security_alarms', '挖矿分析', '挖矿主机分析', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:24:35+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (12, 'ransomwareAnalysis', 'security_alarms', '勒索分析', '勒索病毒分析', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:24:57+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (13, 'DNSTunnel', 'security_alarms', '隐蔽隧道', 'DNS隧道', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:25:16+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (14, 'HTTPTunnel', 'security_alarms', '隐蔽隧道', 'HTTP隧道', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:25:32+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (15, 'ICMPTunnel', 'security_alarms', '隐蔽隧道', 'ICMP隧道', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:26:13+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (16, 'virusMail', 'security_alarms', '邮件分析', '病毒邮件威胁', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:26:30+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (17, 'suspiciousMail', 'security_logs', '邮件分析', '可疑邮件威胁', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:26:45+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (18, 'externalSendingMail', 'security_logs', '邮件分析', '外发邮件威胁', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:27:02+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (19, 'dataSecurity', 'security_alarms', '数据安全', '数据安全', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:27:17+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (20, 'DGADomainCheck', 'security_alarms', 'DGA域名检测', 'DGA域名检测', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:27:29+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (21, 'phishingMail', 'security_logs', '邮件分析', '钓鱼邮件威胁', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2022-04-19 18:58:47+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (22, 'decryption', 'security_alarms', '加密攻击检测', '已解密', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2022-04-19 19:00:47+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (23, 'encryption', 'security_alarms', '加密攻击检测', '未解密', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2022-04-19 19:01:17+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (24, 'abnormalLogin', 'security_log', '登陆分析', '异常登录', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2023-01-05 13:30:00+08');
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_scene_rule_info_id_seq"
OWNED BY "t_scene_rule_info"."id";
SELECT setval('"t_scene_rule_info_id_seq"', 24, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_scene_rule_info
-- ----------------------------
CREATE UNIQUE INDEX "idx_94859_t_scene_rule_info_rule_id_uindex" ON "t_scene_rule_info" USING btree (
  "rule_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_scene_rule_info
-- ----------------------------
ALTER TABLE "t_scene_rule_info" ADD CONSTRAINT "idx_94859_primary" PRIMARY KEY ("id");
