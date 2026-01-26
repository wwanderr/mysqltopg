/*
 * Table: t_event_scenario_template
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_event_scenario_template_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_event_scenario_template_id_seq";
CREATE SEQUENCE "t_event_scenario_template_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_event_scenario_template_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_event_scenario_template
-- ----------------------------
DROP TABLE IF EXISTS "t_event_scenario_template";
CREATE TABLE "t_event_scenario_template" (
  "id" int8 NOT NULL DEFAULT nextval('t_event_scenario_template_id_seq'::regclass),
  "scenario_name" varchar(50) COLLATE "pg_catalog"."default",
  "scenario_code" varchar(50) COLLATE "pg_catalog"."default",
  "source" varchar(20) COLLATE "pg_catalog"."default",
  "request_url" varchar(100) COLLATE "pg_catalog"."default",
  "condition" text COLLATE "pg_catalog"."default",
  "event_name" text COLLATE "pg_catalog"."default",
  "parameter" text COLLATE "pg_catalog"."default",
  "result" text COLLATE "pg_catalog"."default",
  "executor_class_name" text COLLATE "pg_catalog"."default",
  "drill_down" int4,
  "update_time" timestamptz(6),
  "conclusion" text COLLATE "pg_catalog"."default",
  "log_aiql" varchar(255) COLLATE "pg_catalog"."default",
  "alarm_aiql" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_event_scenario_template" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_scenario_template"."id" IS '主键id';
COMMENT ON COLUMN "t_event_scenario_template"."scenario_name" IS '场景名称';
COMMENT ON COLUMN "t_event_scenario_template"."scenario_code" IS '场景英文名';
COMMENT ON COLUMN "t_event_scenario_template"."source" IS '数据源';
COMMENT ON COLUMN "t_event_scenario_template"."request_url" IS '请求地址';
COMMENT ON COLUMN "t_event_scenario_template"."condition" IS '筛选条件';
COMMENT ON COLUMN "t_event_scenario_template"."event_name" IS '关联安全事件名称';
COMMENT ON COLUMN "t_event_scenario_template"."parameter" IS '传入参数';
COMMENT ON COLUMN "t_event_scenario_template"."result" IS '返回值';
COMMENT ON COLUMN "t_event_scenario_template"."executor_class_name" IS '执行器类名';
COMMENT ON COLUMN "t_event_scenario_template"."drill_down" IS '是否可下钻';
COMMENT ON COLUMN "t_event_scenario_template"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_event_scenario_template"."conclusion" IS '总结';
COMMENT ON COLUMN "t_event_scenario_template"."log_aiql" IS '日志查询AiQL';
COMMENT ON COLUMN "t_event_scenario_template"."alarm_aiql" IS '告警查询AiQL';

-- ----------------------------
-- Records of t_event_scenario_template
-- ----------------------------
BEGIN;
COMMIT;