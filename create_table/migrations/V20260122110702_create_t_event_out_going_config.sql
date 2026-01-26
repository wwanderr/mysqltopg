/*
 * Table: t_event_out_going_config
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_event_out_going_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_event_out_going_config_id_seq";
CREATE SEQUENCE "t_event_out_going_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_event_out_going_config_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_out_going_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_out_going_config_id_seq";
CREATE SEQUENCE "t_out_going_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_out_going_config_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_event_out_going_config
-- ----------------------------
DROP TABLE IF EXISTS "t_event_out_going_config";
CREATE TABLE "t_event_out_going_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_event_out_going_config_id_seq'::regclass),
  "sub_category" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(50) COLLATE "pg_catalog"."default",
  "alarm_results" varchar(50) COLLATE "pg_catalog"."default",
  "enable" int4 NOT NULL DEFAULT 1,
  "mapping_config_path" text COLLATE "pg_catalog"."default",
  "last_send_time" timestamptz(6),
  "last_send_result" varchar(10) COLLATE "pg_catalog"."default",
  "cause_of_failure" text COLLATE "pg_catalog"."default",
  "is_del" int4 NOT NULL DEFAULT 0,
  "send_count" int8 DEFAULT '0'::bigint,
  "succeed_count" int8 DEFAULT '0'::bigint,
  "create_time" timestamptz(6),
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_event_out_going_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_out_going_config"."id" IS '主键自增id';
COMMENT ON COLUMN "t_event_out_going_config"."sub_category" IS '安全事件类型（数组）';
COMMENT ON COLUMN "t_event_out_going_config"."threat_severity" IS '威胁等级（数组）';
COMMENT ON COLUMN "t_event_out_going_config"."alarm_results" IS '事件结果（数组）';
COMMENT ON COLUMN "t_event_out_going_config"."enable" IS '是否开启（1是，0否）';
COMMENT ON COLUMN "t_event_out_going_config"."mapping_config_path" IS '映射文件路径';
COMMENT ON COLUMN "t_event_out_going_config"."last_send_time" IS '上次发送时间';
COMMENT ON COLUMN "t_event_out_going_config"."last_send_result" IS '上次发送结果';
COMMENT ON COLUMN "t_event_out_going_config"."cause_of_failure" IS '发送失败的原因';
COMMENT ON COLUMN "t_event_out_going_config"."is_del" IS '是否已删除（1是，0否）';
COMMENT ON COLUMN "t_event_out_going_config"."send_count" IS '发送总次数';
COMMENT ON COLUMN "t_event_out_going_config"."succeed_count" IS '成功发送次数';
COMMENT ON COLUMN "t_event_out_going_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_event_out_going_config"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_event_out_going_config
-- ----------------------------
BEGIN;
COMMIT;