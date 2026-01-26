/*
 * Table: t_scan_job
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Type Definitions
-- ----------------------------
-- ----------------------------
-- Type structure for t_scan_job_scan_scope
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_job_scan_scope";
CREATE TYPE "t_scan_job_scan_scope" AS ENUM (
  'full',
  'custom'
);
ALTER TYPE "t_scan_job_scan_scope" OWNER TO "dbapp";

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_scan_job_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_scan_job_id_seq";
CREATE SEQUENCE "t_scan_job_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_scan_job_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_scan_job
-- ----------------------------
DROP TABLE IF EXISTS "t_scan_job";
CREATE TABLE "t_scan_job" (
  "id" int8 NOT NULL DEFAULT nextval('t_scan_job_id_seq'::regclass),
  "strategy_id" int8 NOT NULL,
  "device_id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "device_ip" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "device_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "scan_scope" "t_scan_job_scan_scope" NOT NULL DEFAULT 'full'::xdr22.t_scan_job_scan_scope,
  "scan_path" text COLLATE "pg_catalog"."default",
  "scan_cycle" int4 NOT NULL DEFAULT 0,
  "scan_type" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "node_list" text COLLATE "pg_catalog"."default" NOT NULL,
  "next_scan_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "action" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'scan'::character varying,
  "source" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'manual'::character varying,
  "hashes" text COLLATE "pg_catalog"."default",
  "process_info_list" text COLLATE "pg_catalog"."default",
  "error_count" int4 NOT NULL DEFAULT 0,
  "error_message" varchar(1000) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_scan_job" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scan_job"."id" IS '主键ID';
COMMENT ON COLUMN "t_scan_job"."strategy_id" IS '联动策略ID';
COMMENT ON COLUMN "t_scan_job"."device_id" IS '联动设备ID';
COMMENT ON COLUMN "t_scan_job"."device_ip" IS '联动设备IP';
COMMENT ON COLUMN "t_scan_job"."device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_scan_job"."scan_scope" IS '扫描范围（枚举值）：full[全盘扫描]、custom[自定义扫描]';
COMMENT ON COLUMN "t_scan_job"."scan_path" IS '自定义扫描路径';
COMMENT ON COLUMN "t_scan_job"."scan_cycle" IS '扫描周期（默认为0，表示仅扫描一次）';
COMMENT ON COLUMN "t_scan_job"."scan_type" IS '扫描类型列表';
COMMENT ON COLUMN "t_scan_job"."node_list" IS '终端信息列表';
COMMENT ON COLUMN "t_scan_job"."next_scan_time" IS '下次扫描时间';
COMMENT ON COLUMN "t_scan_job"."source" IS '策略来源';
COMMENT ON COLUMN "t_scan_job"."hashes" IS '病毒文件的hashes';
COMMENT ON COLUMN "t_scan_job"."process_info_list" IS '进程相关信息';
COMMENT ON COLUMN "t_scan_job"."error_count" IS '错误次数，默认10次，超过就不再执行';
COMMENT ON COLUMN "t_scan_job"."error_message" IS '错误信息';
COMMENT ON TABLE "t_scan_job" IS '扫描任务表';

-- ----------------------------
-- Records of t_scan_job
-- ----------------------------
BEGIN;
COMMIT;