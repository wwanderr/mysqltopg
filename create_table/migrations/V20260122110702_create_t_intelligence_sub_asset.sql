/*
 * Table: t_intelligence_sub_asset
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_intelligence_sub_asset_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_intelligence_sub_asset_id_seq";
CREATE SEQUENCE "t_intelligence_sub_asset_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_intelligence_sub_asset_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_intelligence_sub_asset
-- ----------------------------
DROP TABLE IF EXISTS "t_intelligence_sub_asset";
CREATE TABLE "t_intelligence_sub_asset" (
  "id" int8 NOT NULL DEFAULT nextval('t_intelligence_sub_asset_id_seq'::regclass),
  "ioc" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "asset_ip" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "event_time" date NOT NULL,
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "response_address" text COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "alarm_status" int4,
  "counts" int8,
  "tag" varchar(20) COLLATE "pg_catalog"."default",
  "security_zone" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;
ALTER TABLE "t_intelligence_sub_asset" OWNER TO "dbapp";
COMMENT ON COLUMN "t_intelligence_sub_asset"."id" IS '主键';
COMMENT ON COLUMN "t_intelligence_sub_asset"."ioc" IS '威胁情报IoC';
COMMENT ON COLUMN "t_intelligence_sub_asset"."asset_ip" IS '资产IP';
COMMENT ON COLUMN "t_intelligence_sub_asset"."event_time" IS '创建年月日';
COMMENT ON COLUMN "t_intelligence_sub_asset"."start_time" IS '起始时间';
COMMENT ON COLUMN "t_intelligence_sub_asset"."end_time" IS '结束时间';
COMMENT ON COLUMN "t_intelligence_sub_asset"."response_address" IS 'A记录溯源ip';
COMMENT ON COLUMN "t_intelligence_sub_asset"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_intelligence_sub_asset"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_intelligence_sub_asset"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_intelligence_sub_asset"."counts" IS '告警次数';
COMMENT ON COLUMN "t_intelligence_sub_asset"."tag" IS '标签';
COMMENT ON COLUMN "t_intelligence_sub_asset"."security_zone" IS '安全域id';

-- ----------------------------
-- Records of t_intelligence_sub_asset
-- ----------------------------
BEGIN;
COMMIT;