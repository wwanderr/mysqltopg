/*
 * Table: t_scan_history_detail
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- TYPE DEFINITIONS
-- ============================
-- ----------------------------
-- Type structure for t_scan_history_detail_scan_scope
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_detail_scan_scope";
CREATE TYPE "t_scan_history_detail_scan_scope" AS ENUM (
  'full',
  'custom'
);
ALTER TYPE "t_scan_history_detail_scan_scope" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_detail_scan_type
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_detail_scan_type";
CREATE TYPE "t_scan_history_detail_scan_type" AS ENUM (
  'virus',
  'site',
  'vulnerability'
);
ALTER TYPE "t_scan_history_detail_scan_type" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_detail_status
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_detail_status";
CREATE TYPE "t_scan_history_detail_status" AS ENUM (
  '正在扫描',
  '扫描完成',
  '扫描失败'
);
ALTER TYPE "t_scan_history_detail_status" OWNER TO "dbapp";

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_scan_history_detail_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_scan_history_detail_id_seq" CASCADE;
CREATE SEQUENCE "t_scan_history_detail_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_scan_history_detail_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_scan_history_detail
-- ----------------------------
DROP TABLE IF EXISTS "t_scan_history_detail";
CREATE TABLE "t_scan_history_detail" (
  "id" int8 NOT NULL DEFAULT nextval('t_scan_history_detail_id_seq'::regclass),
  "strategy_id" numeric NOT NULL,
  "node_ip" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "device_ip" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "scan_time" timestamp(6) NOT NULL,
  "scan_scope" "t_scan_history_detail_scan_scope" NOT NULL DEFAULT 'full'::t_scan_history_detail_scan_scope,
  "scan_path" text COLLATE "pg_catalog"."default",
  "scan_type" "t_scan_history_detail_scan_type" NOT NULL,
  "scan_object_num" int4,
  "scan_result_num" int4,
  "scan_total_num" int4,
  "status" "t_scan_history_detail_status" NOT NULL,
  "start_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "end_time" timestamp(6),
  "source" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'manual'::character varying,
  "task_id" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_scan_history_detail" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scan_history_detail"."id" IS '主键ID';
COMMENT ON COLUMN "t_scan_history_detail"."strategy_id" IS '联动策略ID（t_linked_strategy）';
COMMENT ON COLUMN "t_scan_history_detail"."node_ip" IS '终端IP';
COMMENT ON COLUMN "t_scan_history_detail"."device_ip" IS '联动设备IP';
COMMENT ON COLUMN "t_scan_history_detail"."scan_time" IS '扫描下发时间';
COMMENT ON COLUMN "t_scan_history_detail"."scan_scope" IS '扫描范围（枚举值）：full[全盘扫描]、custom[自定义扫描]';
COMMENT ON COLUMN "t_scan_history_detail"."scan_path" IS '自定义扫描路径';
COMMENT ON COLUMN "t_scan_history_detail"."scan_type" IS '扫描类型（枚举值）：virus[病毒木马]、site[网站后门]、vulnerability[漏洞补丁]';
COMMENT ON COLUMN "t_scan_history_detail"."scan_object_num" IS '扫描对象数';
COMMENT ON COLUMN "t_scan_history_detail"."scan_result_num" IS '扫描结果数';
COMMENT ON COLUMN "t_scan_history_detail"."scan_total_num" IS '扫描对象总数';
COMMENT ON COLUMN "t_scan_history_detail"."status" IS '扫描任务状态';
COMMENT ON COLUMN "t_scan_history_detail"."start_time" IS '扫描开始时间';
COMMENT ON COLUMN "t_scan_history_detail"."end_time" IS '扫描结束时间';
COMMENT ON COLUMN "t_scan_history_detail"."source" IS '策略来源';
COMMENT ON COLUMN "t_scan_history_detail"."task_id" IS 'edr的任务id';
COMMENT ON TABLE "t_scan_history_detail" IS '扫描历史记录详情表';

-- ----------------------------
-- Records of t_scan_history_detail
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_scan_history_detail_id_seq"
OWNED BY "t_scan_history_detail"."id";
SELECT setval('"t_scan_history_detail_id_seq"', 1, true);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_scan_history_detail
-- ----------------------------
ALTER TABLE "t_scan_history_detail" ADD CONSTRAINT "idx_94820_primary" PRIMARY KEY ("id");
