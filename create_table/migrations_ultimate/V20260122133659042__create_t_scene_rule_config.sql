/*
 * Table: t_scene_rule_config
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_scene_rule_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_scene_rule_config_id_seq" CASCADE;
CREATE SEQUENCE "t_scene_rule_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_scene_rule_config_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_scene_rule_config
-- ----------------------------
DROP TABLE IF EXISTS "t_scene_rule_config";
CREATE TABLE "t_scene_rule_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_scene_rule_config_id_seq'::regclass),
  "rule_id" varchar(255) COLLATE "pg_catalog"."default",
  "config_param" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_scene_rule_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scene_rule_config"."id" IS '唯一标识，自增';
COMMENT ON COLUMN "t_scene_rule_config"."rule_id" IS '规则id';
COMMENT ON COLUMN "t_scene_rule_config"."config_param" IS '模型配置json';
COMMENT ON COLUMN "t_scene_rule_config"."create_time" IS '创建时间';

-- ----------------------------
-- Records of t_scene_rule_config
-- ----------------------------
BEGIN;
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (1, 'privilegedAccount', '{"@class":"com.alibaba.fastjson.JSONObject","srcUserName":"admin","appProtocol":["java.util.ArrayList",["http"]]}', '2021-12-06 15:25:13+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (2, 'privilegedAccount', '{"@class":"com.alibaba.fastjson.JSONObject","srcUserName":"administrator","appProtocol":["java.util.ArrayList",["rdp"]]}', '2021-12-06 15:25:27+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (3, 'privilegedAccount', '{"@class":"com.alibaba.fastjson.JSONObject","srcUserName":"root","appProtocol":["java.util.ArrayList",["ssh"]]}', '2021-12-06 15:25:35+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (4, 'suspiciousMail:subject', '{"@class":"com.alibaba.fastjson.JSONObject","subject":"测试链接"}', '2021-12-06 17:14:39+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (5, 'suspiciousMail:subject', '{"@class":"com.alibaba.fastjson.JSONObject","subject":"重置密码"}', '2021-12-06 17:14:54+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (6, 'suspiciousMail:subject', '{"@class":"com.alibaba.fastjson.JSONObject","subject":"登录"}', '2021-12-06 17:14:59+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (7, 'suspiciousMail:subject', '{"@class":"com.alibaba.fastjson.JSONObject","subject":"员工信息"}', '2021-12-06 17:15:05+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (8, 'suspiciousMail:subject', '{"@class":"com.alibaba.fastjson.JSONObject","subject":"密码修改"}', '2021-12-06 17:15:10+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (9, 'suspiciousMail:suffix', '{"@class":"com.alibaba.fastjson.JSONObject","attachmentSuffix":"exe"}', '2021-12-06 17:16:32+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (10, 'suspiciousMail:suffix', '{"@class":"com.alibaba.fastjson.JSONObject","attachmentSuffix":"bin"}', '2021-12-06 17:16:40+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (11, 'suspiciousMail:suffix', '{"@class":"com.alibaba.fastjson.JSONObject","attachmentSuffix":"vbs"}', '2021-12-06 17:16:45+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (12, 'suspiciousMail:suffix', '{"@class":"com.alibaba.fastjson.JSONObject","attachmentSuffix":"cmd"}', '2021-12-06 17:16:51+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (13, 'suspiciousMail:suffix', '{"@class":"com.alibaba.fastjson.JSONObject","attachmentSuffix":"com"}', '2021-12-06 17:16:54+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (14, 'suspiciousWebScan', '{"@class":"com.alibaba.fastjson.JSONObject","urlCount":50}', '2026-01-15 09:31:18+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (15, 'suspiciousPosternAccess', '{"@class":"com.alibaba.fastjson.JSONObject","abnormalUrlCount":10,"normalUrlCount":200,"normalUrlPercent":85}', '2026-01-15 09:31:18+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (16, 'externalSendingMail', '{"@class":"com.alibaba.fastjson.JSONObject","sendEmailCount":100}', '2026-01-15 09:31:18+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (17, 'bruteForce:slow', '{"@class":"com.alibaba.fastjson.JSONObject","window":5,"loginCount":20,"repeatCount":10}', '2026-01-15 09:31:18+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (18, 'bruteForce:oneToMany', '{"@class":"com.alibaba.fastjson.JSONObject","window":5,"loginCount":50}', '2026-01-15 09:31:18+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (19, 'abnormalLogin', '{"@class":"com.alibaba.fastjson.JSONObject","startTime":"2330","endTime":"0530"}', '2026-01-15 09:31:18+08');
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_scene_rule_config_id_seq"
OWNED BY "t_scene_rule_config"."id";
SELECT setval('"t_scene_rule_config_id_seq"', 19, true);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_scene_rule_config
-- ----------------------------
ALTER TABLE "t_scene_rule_config" ADD CONSTRAINT "idx_94851_primary" PRIMARY KEY ("id");
