/*
 * Table: t_risk_incidents
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_risk_incidents_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_risk_incidents_id_seq";
CREATE SEQUENCE "t_risk_incidents_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_risk_incidents_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_risk_incidents
-- ----------------------------
DROP TABLE IF EXISTS "t_risk_incidents";
CREATE TABLE "t_risk_incidents" (
  "id" int8 NOT NULL DEFAULT nextval('t_risk_incidents_id_seq'::regclass),
  "event_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "template_id" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "threat_severity" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "top_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default",
  "second_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "focus_ip" text COLLATE "pg_catalog"."default",
  "focus_object" varchar(32) COLLATE "pg_catalog"."default",
  "counts" int8,
  "alarm_status" varchar(32) COLLATE "pg_catalog"."default",
  "alarm_results" varchar(32) COLLATE "pg_catalog"."default",
  "filter_content" varchar(512) COLLATE "pg_catalog"."default",
  "event_ids" text COLLATE "pg_catalog"."default",
  "data_source" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "tag_search" text COLLATE "pg_catalog"."default",
  "is_scenario" int4 NOT NULL DEFAULT 0,
  "filter_content_aiql" varchar(1000) COLLATE "pg_catalog"."default",
  "kill_chain" varchar(255) COLLATE "pg_catalog"."default",
  "judge_result" int4 DEFAULT 0,
  "judge_status" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;
ALTER TABLE "t_risk_incidents" OWNER TO "dbapp";
COMMENT ON COLUMN "t_risk_incidents"."id" IS '唯一id';
COMMENT ON COLUMN "t_risk_incidents"."event_code" IS '事件编号，当前日期+数据源+风险事件名称+程序版本';
COMMENT ON COLUMN "t_risk_incidents"."name" IS '事件名称';
COMMENT ON COLUMN "t_risk_incidents"."template_id" IS '模板code';
COMMENT ON COLUMN "t_risk_incidents"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_risk_incidents"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_risk_incidents"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_risk_incidents"."top_event_type_chinese" IS '一级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents"."second_event_type_chinese" IS '二级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents"."focus_ip" IS '关注IP';
COMMENT ON COLUMN "t_risk_incidents"."focus_object" IS '关注对象';
COMMENT ON COLUMN "t_risk_incidents"."counts" IS '攻击次数';
COMMENT ON COLUMN "t_risk_incidents"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_risk_incidents"."alarm_results" IS '攻击结果';
COMMENT ON COLUMN "t_risk_incidents"."filter_content" IS '告警过滤条件(用于反查告警)';
COMMENT ON COLUMN "t_risk_incidents"."event_ids" IS '安全事件id列表，用于反查安全事件';
COMMENT ON COLUMN "t_risk_incidents"."data_source" IS '数据源类型：alert-告警,incident-安全事件';
COMMENT ON COLUMN "t_risk_incidents"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_risk_incidents"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_risk_incidents"."tag_search" IS '标签（数组）';
COMMENT ON COLUMN "t_risk_incidents"."is_scenario" IS '是否符合追溯条件，符合1，不符合0';
COMMENT ON COLUMN "t_risk_incidents"."filter_content_aiql" IS '事件过滤条件Aiql';
COMMENT ON COLUMN "t_risk_incidents"."judge_result" IS '研判结果：0、不展示，1、成功，2、尝试，3、无害，4、未知';
COMMENT ON COLUMN "t_risk_incidents"."judge_status" IS '研判方式：系统自动研判，威胁情报回连时序研判，主动攻击研判，人工研判';
COMMENT ON TABLE "t_risk_incidents" IS '风险事件表';

-- ----------------------------
-- Records of t_risk_incidents
-- ----------------------------
BEGIN;
COMMIT;