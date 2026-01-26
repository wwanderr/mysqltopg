/*
 * Table: t_alarm_out_going_config
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- FUNCTION DEFINITIONS
-- ============================
-- ----------------------------
-- Function structure for on_update_current_timestamp_t_alarm_out_going_config
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_alarm_out_going_config"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_alarm_out_going_config"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_alarm_out_going_config"() OWNER TO "dbapp";

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_alarm_out_going_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_alarm_out_going_config_id_seq" CASCADE;
CREATE SEQUENCE "t_alarm_out_going_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_alarm_out_going_config_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_alarm_out_going_config
-- ----------------------------
DROP TABLE IF EXISTS "t_alarm_out_going_config";
CREATE TABLE "t_alarm_out_going_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_alarm_out_going_config_id_seq'::regclass),
  "alarm_source" text COLLATE "pg_catalog"."default",
  "sub_category" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(50) COLLATE "pg_catalog"."default",
  "alarm_results" varchar(50) COLLATE "pg_catalog"."default",
  "enable" int4 NOT NULL DEFAULT 1,
  "mapping_config_path" varchar(100) COLLATE "pg_catalog"."default",
  "is_del" int4 NOT NULL DEFAULT 0,
  "last_send_result" varchar(10) COLLATE "pg_catalog"."default",
  "cause_of_failure" text COLLATE "pg_catalog"."default",
  "last_send_time" timestamp(6),
  "send_count" int8 DEFAULT '0'::bigint,
  "succeed_count" int8 DEFAULT '0'::bigint,
  "create_time" timestamp(6),
  "update_time" timestamp(6)
)
;
ALTER TABLE "t_alarm_out_going_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_alarm_out_going_config"."id" IS '主键自增id';
COMMENT ON COLUMN "t_alarm_out_going_config"."alarm_source" IS '告警来源（数组）';
COMMENT ON COLUMN "t_alarm_out_going_config"."sub_category" IS '告警子类型（数组）';
COMMENT ON COLUMN "t_alarm_out_going_config"."threat_severity" IS '威胁等级（数组）';
COMMENT ON COLUMN "t_alarm_out_going_config"."alarm_results" IS '告警结果（数组）';
COMMENT ON COLUMN "t_alarm_out_going_config"."enable" IS '是否开启（1是，0否）';
COMMENT ON COLUMN "t_alarm_out_going_config"."mapping_config_path" IS '映射文件路径';
COMMENT ON COLUMN "t_alarm_out_going_config"."is_del" IS '是否已删除（1是，0否）';
COMMENT ON COLUMN "t_alarm_out_going_config"."last_send_result" IS '上次发送结果';
COMMENT ON COLUMN "t_alarm_out_going_config"."cause_of_failure" IS '发送失败的原因';
COMMENT ON COLUMN "t_alarm_out_going_config"."last_send_time" IS '上次发送时间';
COMMENT ON COLUMN "t_alarm_out_going_config"."send_count" IS '发送总次数';
COMMENT ON COLUMN "t_alarm_out_going_config"."succeed_count" IS '成功发送次数';
COMMENT ON COLUMN "t_alarm_out_going_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_alarm_out_going_config"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_alarm_out_going_config
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_alarm_out_going_config_id_seq"
OWNED BY "t_alarm_out_going_config"."id";
SELECT setval('"t_alarm_out_going_config_id_seq"', 1, true);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_alarm_out_going_config
-- ----------------------------
ALTER TABLE "t_alarm_out_going_config" ADD CONSTRAINT "idx_94452_primary" PRIMARY KEY ("id");

-- ============================
-- TRIGGERS
-- ============================
-- ----------------------------
-- Triggers structure for table t_alarm_out_going_config
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_alarm_out_going_config"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_alarm_out_going_config"();
