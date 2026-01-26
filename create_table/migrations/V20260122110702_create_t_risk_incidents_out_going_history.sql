/*
 * Table: t_risk_incidents_out_going_history
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_risk_incidents_out_going_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_risk_incidents_out_going_history_id_seq";
CREATE SEQUENCE "t_risk_incidents_out_going_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_risk_incidents_out_going_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_risk_incidents_out_going_history
-- ----------------------------
DROP TABLE IF EXISTS "t_risk_incidents_out_going_history";
CREATE TABLE "t_risk_incidents_out_going_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_risk_incidents_out_going_history_id_seq'::regclass),
  "event_id" int8 NOT NULL,
  "uniq_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "event_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "security_incident_id" int8,
  "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "template_id" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "top_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default",
  "second_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default",
  "src_geo_region" varchar(128) COLLATE "pg_catalog"."default",
  "security_zone" varchar(128) COLLATE "pg_catalog"."default",
  "device_address" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "device_send_product_name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "send_host_address" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "machine_code" varchar(512) COLLATE "pg_catalog"."default" NOT NULL,
  "rule_type" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "focus_ip" text COLLATE "pg_catalog"."default",
  "attacker" text COLLATE "pg_catalog"."default",
  "victim" text COLLATE "pg_catalog"."default",
  "severity" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "cat_outcome" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "payload" text COLLATE "pg_catalog"."default",
  "more_field" text COLLATE "pg_catalog"."default",
  "time_part" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_risk_incidents_out_going_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."id" IS '唯一id';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."event_id" IS '风险事件id';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."uniq_code" IS '唯一code，当前日期+数据源+风险事件名称+程序版本+关注ip';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."event_code" IS '事件编号，当前日期+数据源+风险事件名称+程序版本';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."security_incident_id" IS '关联安全事件id';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."name" IS '事件名称';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."template_id" IS '模板code';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."top_event_type_chinese" IS '一级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."second_event_type_chinese" IS '二级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."src_geo_region" IS '来源地区';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."security_zone" IS '安全域';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."device_address" IS 'XDR地址';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."device_send_product_name" IS 'XDR产品名称';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."send_host_address" IS '目标地址';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."machine_code" IS 'XDR机器码';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."rule_type" IS 'XDR的事件一二级类型需要映射成告警类型';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."focus_ip" IS '关注IP';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."attacker" IS '关注对象，根据关注对象类型进行填充数值';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."victim" IS '关注对象，根据关注对象类型进行填充数值';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."severity" IS '威胁等级,高-7，中-6，低-3';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."cat_outcome" IS '事件结果,尝试-Attempt，失败-FAIL，成功-OK';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."payload" IS '子事件描述';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."more_field" IS '告警信息其他需要外发的字段，json格式存放';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."time_part" IS '时间周期';
COMMENT ON TABLE "t_risk_incidents_out_going_history" IS '风险子事件外发历史表';

-- ----------------------------
-- Records of t_risk_incidents_out_going_history
-- ----------------------------
BEGIN;
COMMIT;