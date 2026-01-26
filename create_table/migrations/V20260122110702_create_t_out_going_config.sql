/*
 * Table: t_out_going_config
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
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
-- Table structure for t_out_going_config
-- ----------------------------
DROP TABLE IF EXISTS "t_out_going_config";
CREATE TABLE "t_out_going_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_out_going_config_id_seq'::regclass),
  "server_name" varchar(255) COLLATE "pg_catalog"."default",
  "server_address" text COLLATE "pg_catalog"."default",
  "auth_tick" text COLLATE "pg_catalog"."default",
  "port" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "protocol" varchar(10) COLLATE "pg_catalog"."default",
  "enable" int4 NOT NULL DEFAULT 1,
  "type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "alarm_config_id" int8,
  "event_config_id" int8,
  "risk_config_id" int8,
  "is_del" int4 NOT NULL DEFAULT 0,
  "create_time" timestamptz(6),
  "update_time" timestamptz(6),
  "kafka_topic" text COLLATE "pg_catalog"."default",
  "encryption_type" varchar(20) COLLATE "pg_catalog"."default",
  "ca_cert_path" text COLLATE "pg_catalog"."default",
  "is_system_ca" bool,
  "compress_mode" varchar(20) COLLATE "pg_catalog"."default",
  "principal" varchar(255) COLLATE "pg_catalog"."default",
  "key_tab_path" varchar(255) COLLATE "pg_catalog"."default",
  "kdc_server_name" varchar(255) COLLATE "pg_catalog"."default",
  "kafka_server_name" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_out_going_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_out_going_config"."id" IS '主键id';
COMMENT ON COLUMN "t_out_going_config"."server_name" IS '服务器名称';
COMMENT ON COLUMN "t_out_going_config"."server_address" IS '服务器地址';
COMMENT ON COLUMN "t_out_going_config"."auth_tick" IS '认证凭证，JSON格式';
COMMENT ON COLUMN "t_out_going_config"."port" IS '端口';
COMMENT ON COLUMN "t_out_going_config"."protocol" IS '传输协议（UDP/TCP）';
COMMENT ON COLUMN "t_out_going_config"."enable" IS '是否开启（1是，0否）';
COMMENT ON COLUMN "t_out_going_config"."type" IS '外发类型（API/SYSLOG）';
COMMENT ON COLUMN "t_out_going_config"."alarm_config_id" IS '告警配置表关联id';
COMMENT ON COLUMN "t_out_going_config"."event_config_id" IS '事件配置表关联id';
COMMENT ON COLUMN "t_out_going_config"."risk_config_id" IS '风险事件配置关联id';
COMMENT ON COLUMN "t_out_going_config"."is_del" IS '是否已删除（1是，0否）';
COMMENT ON COLUMN "t_out_going_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_out_going_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_out_going_config"."kafka_topic" IS 'kafka发送主题';
COMMENT ON COLUMN "t_out_going_config"."encryption_type" IS 'kafka加密方式';
COMMENT ON COLUMN "t_out_going_config"."ca_cert_path" IS 'kafka ca证书路径';
COMMENT ON COLUMN "t_out_going_config"."is_system_ca" IS '是否系统默认ca证书';
COMMENT ON COLUMN "t_out_going_config"."compress_mode" IS 'kafka压缩方式';
COMMENT ON COLUMN "t_out_going_config"."principal" IS 'kafka权限校验';
COMMENT ON COLUMN "t_out_going_config"."key_tab_path" IS 'kafka keyTab文件路径';
COMMENT ON COLUMN "t_out_going_config"."kdc_server_name" IS 'kdc主机名';
COMMENT ON COLUMN "t_out_going_config"."kafka_server_name" IS '服务名称';

-- ----------------------------
-- Records of t_out_going_config
-- ----------------------------
BEGIN;
COMMIT;