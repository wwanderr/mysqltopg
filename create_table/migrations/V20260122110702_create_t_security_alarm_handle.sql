/*
 * Table: t_security_alarm_handle
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_security_alarm_handle_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_security_alarm_handle_id_seq";
CREATE SEQUENCE "t_security_alarm_handle_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_security_alarm_handle_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_security_alarm_handle
-- ----------------------------
DROP TABLE IF EXISTS "t_security_alarm_handle";
CREATE TABLE "t_security_alarm_handle" (
  "id" int8 NOT NULL DEFAULT nextval('t_security_alarm_handle_id_seq'::regclass),
  "agg_condition" varchar(50) COLLATE "pg_catalog"."default",
  "window_id" varchar(50) COLLATE "pg_catalog"."default",
  "execute_time" timestamptz(6),
  "handle_status" varchar(50) COLLATE "pg_catalog"."default",
  "result" bool DEFAULT false
)
;
ALTER TABLE "t_security_alarm_handle" OWNER TO "dbapp";
COMMENT ON COLUMN "t_security_alarm_handle"."execute_time" IS '可执行时间';
COMMENT ON COLUMN "t_security_alarm_handle"."handle_status" IS '处置状态';
COMMENT ON COLUMN "t_security_alarm_handle"."result" IS '处置结果：0未处置，1已处置';

-- ----------------------------
-- Records of t_security_alarm_handle
-- ----------------------------
BEGIN;
COMMIT;