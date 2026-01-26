/*
 * Table: t_strategy_device_rel
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- FUNCTION DEFINITIONS
-- ============================
-- ----------------------------
-- Function structure for on_update_current_timestamp_t_strategy_device_rel
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_strategy_device_rel"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_strategy_device_rel"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_strategy_device_rel"() OWNER TO "dbapp";

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_strategy_device_rel_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_strategy_device_rel_id_seq" CASCADE;
CREATE SEQUENCE "t_strategy_device_rel_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_strategy_device_rel_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_strategy_device_rel
-- ----------------------------
DROP TABLE IF EXISTS "t_strategy_device_rel";
CREATE TABLE "t_strategy_device_rel" (
  "id" int8 NOT NULL DEFAULT nextval('t_strategy_device_rel_id_seq'::regclass),
  "strategy_id" int8 NOT NULL,
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "link_device_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_type" varchar(16) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "area" varchar(50) COLLATE "pg_catalog"."default",
  "area_data" text COLLATE "pg_catalog"."default",
  "agents" text COLLATE "pg_catalog"."default",
  "action" varchar(50) COLLATE "pg_catalog"."default",
  "action_config" text COLLATE "pg_catalog"."default",
  "app_id" varchar(100) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6)
)
;
ALTER TABLE "t_strategy_device_rel" OWNER TO "dbapp";
COMMENT ON COLUMN "t_strategy_device_rel"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_strategy_device_rel"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_strategy_device_rel"."link_device_ip" IS '联动设备ip';
COMMENT ON COLUMN "t_strategy_device_rel"."link_device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_strategy_device_rel"."area" IS '防护范围';
COMMENT ON COLUMN "t_strategy_device_rel"."area_data" IS '防护范围配置';
COMMENT ON COLUMN "t_strategy_device_rel"."agents" IS '终端信息列表Json字符串';
COMMENT ON COLUMN "t_strategy_device_rel"."action" IS '动作';
COMMENT ON COLUMN "t_strategy_device_rel"."action_config" IS '配置策略';
COMMENT ON COLUMN "t_strategy_device_rel"."app_id" IS '设备app类型';
COMMENT ON COLUMN "t_strategy_device_rel"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_strategy_device_rel"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_strategy_device_rel
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_strategy_device_rel_id_seq"
OWNED BY "t_strategy_device_rel"."id";
SELECT setval('"t_strategy_device_rel_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_strategy_device_rel
-- ----------------------------
CREATE UNIQUE INDEX "idx_94901_t_strategy_device_rel_un" ON "t_strategy_device_rel" USING btree (
  "strategy_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "device_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "action" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_strategy_device_rel
-- ----------------------------
ALTER TABLE "t_strategy_device_rel" ADD CONSTRAINT "idx_94901_primary" PRIMARY KEY ("id");

-- ============================
-- TRIGGERS
-- ============================
-- ----------------------------
-- Triggers structure for table t_strategy_device_rel
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_strategy_device_rel"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_strategy_device_rel"();
