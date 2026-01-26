/*
 * Table: t_alarm_status_timing_task
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_alarm_status_timing_task_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_alarm_status_timing_task_id_seq";
CREATE SEQUENCE "t_alarm_status_timing_task_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_alarm_status_timing_task_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_alarm_status_timing_task
-- ----------------------------
DROP TABLE IF EXISTS "t_alarm_status_timing_task";
CREATE TABLE "t_alarm_status_timing_task" (
  "id" int8 NOT NULL DEFAULT nextval('t_alarm_status_timing_task_id_seq'::regclass),
  "task_type" varchar(50) COLLATE "pg_catalog"."default",
  "alarm_status" varchar(20) COLLATE "pg_catalog"."default",
  "remarks" text COLLATE "pg_catalog"."default",
  "operator" varchar(150) COLLATE "pg_catalog"."default",
  "condition" text COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6),
  "task_end_time" timestamptz(6),
  "associated_field" varchar(100) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_alarm_status_timing_task" OWNER TO "dbapp";
COMMENT ON COLUMN "t_alarm_status_timing_task"."id" IS '主键自增id';
COMMENT ON COLUMN "t_alarm_status_timing_task"."task_type" IS '任务类型（区分不同模块）';
COMMENT ON COLUMN "t_alarm_status_timing_task"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_alarm_status_timing_task"."remarks" IS '备注';
COMMENT ON COLUMN "t_alarm_status_timing_task"."operator" IS '责任人';
COMMENT ON COLUMN "t_alarm_status_timing_task"."condition" IS '处置条件（以JSON格式存储）';
COMMENT ON COLUMN "t_alarm_status_timing_task"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_alarm_status_timing_task"."task_end_time" IS '任务结束时间';
COMMENT ON COLUMN "t_alarm_status_timing_task"."associated_field" IS '关联字段';

-- ----------------------------
-- Records of t_alarm_status_timing_task
-- ----------------------------
BEGIN;
COMMIT;