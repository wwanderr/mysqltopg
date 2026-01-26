/*
 * Table: t_linkage_strategy_validtime
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_linkage_strategy_validtime_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_linkage_strategy_validtime_id_seq";
CREATE SEQUENCE "t_linkage_strategy_validtime_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_linkage_strategy_validtime_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_linkage_strategy_validtime
-- ----------------------------
DROP TABLE IF EXISTS "t_linkage_strategy_validtime";
CREATE TABLE "t_linkage_strategy_validtime" (
  "id" int8 NOT NULL DEFAULT nextval('t_linkage_strategy_validtime_id_seq'::regclass),
  "block_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "block_domain" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "end_time" int8,
  "node_id" varchar(255) COLLATE "pg_catalog"."default",
  "direction" int8 NOT NULL DEFAULT '3'::bigint,
  "effect_time" varchar(255) COLLATE "pg_catalog"."default" DEFAULT '0'::character varying
)
;
ALTER TABLE "t_linkage_strategy_validtime" OWNER TO "dbapp";
COMMENT ON COLUMN "t_linkage_strategy_validtime"."block_ip" IS '阻断ip';
COMMENT ON COLUMN "t_linkage_strategy_validtime"."block_domain" IS '封禁域名';
COMMENT ON COLUMN "t_linkage_strategy_validtime"."link_device_ip" IS '联动设备ip';
COMMENT ON COLUMN "t_linkage_strategy_validtime"."end_time" IS '结束时间';
COMMENT ON COLUMN "t_linkage_strategy_validtime"."node_id" IS '终端id';
COMMENT ON COLUMN "t_linkage_strategy_validtime"."effect_time" IS '生效时长，0-永久';

-- ----------------------------
-- Records of t_linkage_strategy_validtime
-- ----------------------------
BEGIN;
COMMIT;