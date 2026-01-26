/*
 * Table: t_log_correlation_job
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- TYPE DEFINITIONS
-- ============================
-- ----------------------------
-- Type structure for t_log_correlation_job_status
-- ----------------------------
DROP TYPE IF EXISTS "t_log_correlation_job_status";
CREATE TYPE "t_log_correlation_job_status" AS ENUM (
  'Todo',
  'Waiting'
);
ALTER TYPE "t_log_correlation_job_status" OWNER TO "dbapp";

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_log_correlation_job_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_log_correlation_job_id_seq" CASCADE;
CREATE SEQUENCE "t_log_correlation_job_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_log_correlation_job_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_log_correlation_job
-- ----------------------------
DROP TABLE IF EXISTS "t_log_correlation_job";
CREATE TABLE "t_log_correlation_job" (
  "id" int8 NOT NULL DEFAULT nextval('t_log_correlation_job_id_seq'::regclass),
  "status" "t_log_correlation_job_status" NOT NULL DEFAULT 'Todo'::t_log_correlation_job_status,
  "executor_class_name" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "parameters" text COLLATE "pg_catalog"."default",
  "echo_parameters" text COLLATE "pg_catalog"."default",
  "waiting_parameters" text COLLATE "pg_catalog"."default",
  "start_time" timestamp(6) NOT NULL,
  "query_start_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "query_end_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_log_correlation_job" OWNER TO "dbapp";
COMMENT ON COLUMN "t_log_correlation_job"."id" IS '主键ID';
COMMENT ON COLUMN "t_log_correlation_job"."status" IS '任务状态（枚举值）：Todo[未处理]、Waiting[等待结果]';
COMMENT ON COLUMN "t_log_correlation_job"."executor_class_name" IS '任务实现类类名完整路径';
COMMENT ON COLUMN "t_log_correlation_job"."parameters" IS '查询日志或查询AiGent的关键参数Json字符串';
COMMENT ON COLUMN "t_log_correlation_job"."echo_parameters" IS '查询完毕后续动作所需Json字符串';
COMMENT ON COLUMN "t_log_correlation_job"."waiting_parameters" IS '任务需要进入"Waiting[等待结果]"的状态时，保留的参数。如：记录调用AiGent异步接口后返回的taskId';
COMMENT ON COLUMN "t_log_correlation_job"."start_time" IS '告警发送时间';
COMMENT ON COLUMN "t_log_correlation_job"."query_start_time" IS '查询起始时间';
COMMENT ON COLUMN "t_log_correlation_job"."query_end_time" IS '查询结束时间（任务触发时间）';
COMMENT ON TABLE "t_log_correlation_job" IS '日志关联任务表';

-- ----------------------------
-- Records of t_log_correlation_job
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_log_correlation_job_id_seq"
OWNED BY "t_log_correlation_job"."id";
SELECT setval('"t_log_correlation_job_id_seq"', 1, true);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_log_correlation_job
-- ----------------------------
ALTER TABLE "t_log_correlation_job" ADD CONSTRAINT "idx_94644_primary" PRIMARY KEY ("id");
