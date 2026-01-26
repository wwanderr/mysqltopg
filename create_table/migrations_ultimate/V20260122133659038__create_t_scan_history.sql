/*
 * Table: t_scan_history
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- TYPE DEFINITIONS
-- ============================
-- ----------------------------
-- Type structure for t_scan_history_node_os
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_node_os";
CREATE TYPE "t_scan_history_node_os" AS ENUM (
  'Windows',
  'Linux'
);
ALTER TYPE "t_scan_history_node_os" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_site_status
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_site_status";
CREATE TYPE "t_scan_history_site_status" AS ENUM (
  '无下发记录',
  '正在扫描',
  '扫描完成',
  '扫描失败'
);
ALTER TYPE "t_scan_history_site_status" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_virus_status
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_virus_status";
CREATE TYPE "t_scan_history_virus_status" AS ENUM (
  '无下发记录',
  '正在扫描',
  '扫描完成',
  '扫描失败'
);
ALTER TYPE "t_scan_history_virus_status" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_vulnerability_status
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_vulnerability_status";
CREATE TYPE "t_scan_history_vulnerability_status" AS ENUM (
  '无下发记录',
  '正在扫描',
  '扫描完成',
  '扫描失败'
);
ALTER TYPE "t_scan_history_vulnerability_status" OWNER TO "dbapp";

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_scan_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_scan_history_id_seq" CASCADE;
CREATE SEQUENCE "t_scan_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_scan_history_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_scan_history
-- ----------------------------
DROP TABLE IF EXISTS "t_scan_history";
CREATE TABLE "t_scan_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_scan_history_id_seq'::regclass),
  "node_ip" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "node_id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "node_os" "t_scan_history_node_os" NOT NULL,
  "device_id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "device_ip" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "device_type" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "last_scan_time" timestamp(6) NOT NULL,
  "scan_times" int4 NOT NULL DEFAULT 1,
  "virus_status" "t_scan_history_virus_status" NOT NULL DEFAULT '无下发记录'::t_scan_history_virus_status,
  "site_status" "t_scan_history_site_status" NOT NULL DEFAULT '无下发记录'::t_scan_history_site_status,
  "vulnerability_status" "t_scan_history_vulnerability_status" NOT NULL DEFAULT '无下发记录'::t_scan_history_vulnerability_status,
  "virus_result_num" int4 NOT NULL DEFAULT 0,
  "site_result_num" int4 NOT NULL DEFAULT 0,
  "vulnerability_result_num" int4 NOT NULL DEFAULT 0,
  "total_result_num" int4 DEFAULT 0
)
;
ALTER TABLE "t_scan_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scan_history"."id" IS '主键ID';
COMMENT ON COLUMN "t_scan_history"."node_ip" IS '终端IP，唯一键约束';
COMMENT ON COLUMN "t_scan_history"."node_id" IS '终端ID';
COMMENT ON COLUMN "t_scan_history"."node_os" IS '终端操作系统类型';
COMMENT ON COLUMN "t_scan_history"."device_id" IS '联动设备ID';
COMMENT ON COLUMN "t_scan_history"."device_ip" IS '联动设备IP';
COMMENT ON COLUMN "t_scan_history"."device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_scan_history"."last_scan_time" IS '最近一次扫描时间';
COMMENT ON COLUMN "t_scan_history"."scan_times" IS '下发扫描次数';
COMMENT ON COLUMN "t_scan_history"."virus_status" IS '最近一次病毒木马任务扫描状态';
COMMENT ON COLUMN "t_scan_history"."site_status" IS '最近一次网站后门任务扫描状态';
COMMENT ON COLUMN "t_scan_history"."vulnerability_status" IS '最近一次漏洞补丁任务扫描状态';
COMMENT ON COLUMN "t_scan_history"."virus_result_num" IS '最近一次病毒木马扫描完成结果数';
COMMENT ON COLUMN "t_scan_history"."site_result_num" IS '最近一次网站后门扫描完成结果数';
COMMENT ON COLUMN "t_scan_history"."vulnerability_result_num" IS '最近一次漏洞补丁扫描完成结果数';
COMMENT ON COLUMN "t_scan_history"."total_result_num" IS '三种扫描任务最近一次扫描完成结果数总和';
COMMENT ON TABLE "t_scan_history" IS '扫描历史记录表';

-- ----------------------------
-- Records of t_scan_history
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_scan_history_id_seq"
OWNED BY "t_scan_history"."id";
SELECT setval('"t_scan_history_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_scan_history
-- ----------------------------
CREATE UNIQUE INDEX "idx_94805_node_ip_unique" ON "t_scan_history" USING btree (
  "node_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_scan_history
-- ----------------------------
ALTER TABLE "t_scan_history" ADD CONSTRAINT "idx_94805_primary" PRIMARY KEY ("id");
