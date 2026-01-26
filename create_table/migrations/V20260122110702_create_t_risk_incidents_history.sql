/*
 * Table: t_risk_incidents_history
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_risk_incidents_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_risk_incidents_history_id_seq";
CREATE SEQUENCE "t_risk_incidents_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_risk_incidents_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_risk_incidents_history
-- ----------------------------
DROP TABLE IF EXISTS "t_risk_incidents_history";
CREATE TABLE "t_risk_incidents_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_risk_incidents_history_id_seq'::regclass),
  "event_id" int8 NOT NULL,
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
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_risk_incidents_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_risk_incidents_history"."id" IS '唯一id';
COMMENT ON COLUMN "t_risk_incidents_history"."event_id" IS '风险事件id';
COMMENT ON COLUMN "t_risk_incidents_history"."event_code" IS '事件编号，当前日期+数据源+风险事件名称+程序版本';
COMMENT ON COLUMN "t_risk_incidents_history"."name" IS '事件名称';
COMMENT ON COLUMN "t_risk_incidents_history"."template_id" IS '模板code';
COMMENT ON COLUMN "t_risk_incidents_history"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_risk_incidents_history"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_risk_incidents_history"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_risk_incidents_history"."top_event_type_chinese" IS '一级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents_history"."second_event_type_chinese" IS '二级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents_history"."focus_ip" IS '关注IP';
COMMENT ON COLUMN "t_risk_incidents_history"."focus_object" IS '关注对象';
COMMENT ON COLUMN "t_risk_incidents_history"."counts" IS '攻击次数';
COMMENT ON COLUMN "t_risk_incidents_history"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_risk_incidents_history"."alarm_results" IS '攻击结果';
COMMENT ON COLUMN "t_risk_incidents_history"."filter_content" IS '告警过滤条件(用于反查告警)';
COMMENT ON COLUMN "t_risk_incidents_history"."event_ids" IS '安全事件id列表，用于反查安全事件';
COMMENT ON COLUMN "t_risk_incidents_history"."data_source" IS '数据源类型：alert-告警,incident-安全事件';
COMMENT ON COLUMN "t_risk_incidents_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_risk_incidents_history"."update_time" IS '更新时间';
COMMENT ON TABLE "t_risk_incidents_history" IS '风险事件历史表';

-- ----------------------------
-- Records of t_risk_incidents_history
-- ----------------------------
BEGIN;
COMMIT;