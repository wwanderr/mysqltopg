/*
 * Table: t_intelligence_sub_asset
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- FUNCTION DEFINITIONS
-- ============================
-- ----------------------------
-- Function structure for on_update_current_timestamp_t_intelligence_sub_asset
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_intelligence_sub_asset"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_intelligence_sub_asset"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_intelligence_sub_asset"() OWNER TO "dbapp";

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_intelligence_sub_asset_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_intelligence_sub_asset_id_seq" CASCADE;
CREATE SEQUENCE "t_intelligence_sub_asset_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_intelligence_sub_asset_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_intelligence_sub_asset
-- ----------------------------
DROP TABLE IF EXISTS "t_intelligence_sub_asset";
CREATE TABLE "t_intelligence_sub_asset" (
  "id" int8 NOT NULL DEFAULT nextval('t_intelligence_sub_asset_id_seq'::regclass),
  "ioc" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "asset_ip" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "event_time" date NOT NULL,
  "start_time" timestamp(6),
  "end_time" timestamp(6),
  "response_address" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6),
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

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_intelligence_sub_asset_id_seq"
OWNED BY "t_intelligence_sub_asset"."id";
SELECT setval('"t_intelligence_sub_asset_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_intelligence_sub_asset
-- ----------------------------
CREATE UNIQUE INDEX "idx_94586_t_intelligence_sub_asset_un" ON "t_intelligence_sub_asset" USING btree (
  "event_time" "pg_catalog"."date_ops" ASC NULLS LAST,
  "ioc" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "asset_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_intelligence_sub_asset
-- ----------------------------
ALTER TABLE "t_intelligence_sub_asset" ADD CONSTRAINT "idx_94586_primary" PRIMARY KEY ("id");

-- ============================
-- TRIGGERS
-- ============================
-- ----------------------------
-- Triggers structure for table t_intelligence_sub_asset
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_intelligence_sub_asset"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_intelligence_sub_asset"();
