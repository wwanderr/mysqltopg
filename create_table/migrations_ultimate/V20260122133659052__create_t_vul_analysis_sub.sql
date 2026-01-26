/*
 * Table: t_vul_analysis_sub
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_vul_analysis_sub_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_vul_analysis_sub_id_seq" CASCADE;
CREATE SEQUENCE "t_vul_analysis_sub_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_vul_analysis_sub_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_vul_analysis_sub
-- ----------------------------
DROP TABLE IF EXISTS "t_vul_analysis_sub";
CREATE TABLE "t_vul_analysis_sub" (
  "id" int8 NOT NULL DEFAULT nextval('t_vul_analysis_sub_id_seq'::regclass),
  "end_time" timestamp(6),
  "start_time" timestamp(6),
  "alarm_result" int4,
  "alarm_status" int4,
  "app_protocol" varchar(30) COLLATE "pg_catalog"."default",
  "source" int8,
  "chart_id" int8,
  "asset_ip" varchar(30) COLLATE "pg_catalog"."default",
  "asset_tags" text COLLATE "pg_catalog"."default",
  "asset_name" varchar(255) COLLATE "pg_catalog"."default",
  "dest_security_zone" text COLLATE "pg_catalog"."default",
  "asset_type" varchar(30) COLLATE "pg_catalog"."default",
  "clear_text" varchar(255) COLLATE "pg_catalog"."default",
  "request_url" varchar(255) COLLATE "pg_catalog"."default",
  "cve" varchar(100) COLLATE "pg_catalog"."default",
  "severity_level" varchar(30) COLLATE "pg_catalog"."default",
  "vulnerability_name" varchar(100) COLLATE "pg_catalog"."default",
  "class_type" varchar(100) COLLATE "pg_catalog"."default",
  "src_user_name" varchar(255) COLLATE "pg_catalog"."default",
  "passwd" varchar(255) COLLATE "pg_catalog"."default",
  "high" int8,
  "medium" int8,
  "low" int8,
  "agg_count" int8,
  "event_code" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" timestamp(6)
)
;
ALTER TABLE "t_vul_analysis_sub" OWNER TO "dbapp";
COMMENT ON COLUMN "t_vul_analysis_sub"."id" IS '主键id';
COMMENT ON COLUMN "t_vul_analysis_sub"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_vul_analysis_sub"."start_time" IS '最先发生时间';
COMMENT ON COLUMN "t_vul_analysis_sub"."alarm_result" IS '告警结果';
COMMENT ON COLUMN "t_vul_analysis_sub"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_vul_analysis_sub"."app_protocol" IS '传输协议';
COMMENT ON COLUMN "t_vul_analysis_sub"."source" IS '资产来源';
COMMENT ON COLUMN "t_vul_analysis_sub"."chart_id" IS '模板id';
COMMENT ON COLUMN "t_vul_analysis_sub"."asset_ip" IS '资产ip';
COMMENT ON COLUMN "t_vul_analysis_sub"."asset_tags" IS '资产标签';
COMMENT ON COLUMN "t_vul_analysis_sub"."asset_name" IS '资产名称';
COMMENT ON COLUMN "t_vul_analysis_sub"."dest_security_zone" IS '安全域';
COMMENT ON COLUMN "t_vul_analysis_sub"."asset_type" IS '资产类型';
COMMENT ON COLUMN "t_vul_analysis_sub"."clear_text" IS '明文传输内容';
COMMENT ON COLUMN "t_vul_analysis_sub"."request_url" IS '请求地址';
COMMENT ON COLUMN "t_vul_analysis_sub"."cve" IS 'cve编号';
COMMENT ON COLUMN "t_vul_analysis_sub"."severity_level" IS '漏洞威胁等级';
COMMENT ON COLUMN "t_vul_analysis_sub"."vulnerability_name" IS '漏洞名称';
COMMENT ON COLUMN "t_vul_analysis_sub"."class_type" IS '漏洞类型';
COMMENT ON COLUMN "t_vul_analysis_sub"."src_user_name" IS '登录用户名';
COMMENT ON COLUMN "t_vul_analysis_sub"."passwd" IS '密码';
COMMENT ON COLUMN "t_vul_analysis_sub"."high" IS '高危漏洞数量';
COMMENT ON COLUMN "t_vul_analysis_sub"."medium" IS '中危漏洞数量';
COMMENT ON COLUMN "t_vul_analysis_sub"."low" IS '低危漏洞数量';
COMMENT ON COLUMN "t_vul_analysis_sub"."agg_count" IS '告警聚合数量';
COMMENT ON COLUMN "t_vul_analysis_sub"."event_code" IS '更新键值';
COMMENT ON COLUMN "t_vul_analysis_sub"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_vul_analysis_sub
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_vul_analysis_sub_id_seq"
OWNED BY "t_vul_analysis_sub"."id";
SELECT setval('"t_vul_analysis_sub_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_vul_analysis_sub
-- ----------------------------
CREATE INDEX "idx_94932_assetip" ON "t_vul_analysis_sub" USING btree (
  "asset_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94932_chartid" ON "t_vul_analysis_sub" USING btree (
  "chart_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94932_time" ON "t_vul_analysis_sub" USING btree (
  "end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_94932_uniq" ON "t_vul_analysis_sub" USING btree (
  "event_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "asset_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_vul_analysis_sub
-- ----------------------------
ALTER TABLE "t_vul_analysis_sub" ADD CONSTRAINT "idx_94932_primary" PRIMARY KEY ("id");
