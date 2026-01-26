/*
 * Table: t_atip_config
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_atip_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_atip_config_id_seq" CASCADE;
CREATE SEQUENCE "t_atip_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_atip_config_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_atip_config
-- ----------------------------
DROP TABLE IF EXISTS "t_atip_config";
CREATE TABLE "t_atip_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_atip_config_id_seq'::regclass),
  "host" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "port" varchar(255) COLLATE "pg_catalog"."default",
  "is_ssl" int2 NOT NULL DEFAULT '0'::smallint,
  "is_report" int2 NOT NULL DEFAULT '0'::smallint,
  "user" varchar(255) COLLATE "pg_catalog"."default",
  "token" varchar(255) COLLATE "pg_catalog"."default",
  "device_id" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_atip_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_atip_config"."id" IS '主键ID';
COMMENT ON COLUMN "t_atip_config"."host" IS 'host';
COMMENT ON COLUMN "t_atip_config"."port" IS '端口';
COMMENT ON COLUMN "t_atip_config"."is_ssl" IS '是否http';
COMMENT ON COLUMN "t_atip_config"."is_report" IS '是否上报';
COMMENT ON COLUMN "t_atip_config"."user" IS '账号';
COMMENT ON COLUMN "t_atip_config"."token" IS '密码';
COMMENT ON COLUMN "t_atip_config"."device_id" IS '联动设备id';
COMMENT ON COLUMN "t_atip_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_atip_config"."update_time" IS '更新时间';
COMMENT ON TABLE "t_atip_config" IS 'atip配置表';

-- ----------------------------
-- Records of t_atip_config
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_atip_config_id_seq"
OWNED BY "t_atip_config"."id";
SELECT setval('"t_atip_config_id_seq"', 1, true);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_atip_config
-- ----------------------------
ALTER TABLE "t_atip_config" ADD CONSTRAINT "idx_94470_primary" PRIMARY KEY ("id");
