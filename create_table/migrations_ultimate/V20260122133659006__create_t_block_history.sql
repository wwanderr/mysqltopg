/*
 * Table: t_block_history
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- FUNCTION DEFINITIONS
-- ============================
-- ----------------------------
-- Function structure for on_update_current_timestamp_t_block_history
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_block_history"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_block_history"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_block_history"() OWNER TO "dbapp";

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_block_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_block_history_id_seq" CASCADE;
CREATE SEQUENCE "t_block_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_block_history_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_block_history
-- ----------------------------
DROP TABLE IF EXISTS "t_block_history";
CREATE TABLE "t_block_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_block_history_id_seq'::regclass),
  "link_device_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_type" varchar(16) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "src_address" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dest_address" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "content" text COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6),
  "strategy_id" int8 NOT NULL,
  "create_type" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'none'::character varying,
  "launch_times" int4 NOT NULL DEFAULT 1,
  "nta_name" varchar(100) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_block_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_block_history"."link_device_ip" IS '联动设备ip';
COMMENT ON COLUMN "t_block_history"."link_device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_block_history"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_block_history"."src_address" IS '来源IP';
COMMENT ON COLUMN "t_block_history"."dest_address" IS '目的IP';
COMMENT ON COLUMN "t_block_history"."content" IS '命中内容';
COMMENT ON COLUMN "t_block_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_block_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_block_history"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_block_history"."create_type" IS '添加方式';
COMMENT ON COLUMN "t_block_history"."launch_times" IS '下发次数';

-- ----------------------------
-- Records of t_block_history
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_block_history_id_seq"
OWNED BY "t_block_history"."id";
SELECT setval('"t_block_history_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_block_history
-- ----------------------------
CREATE INDEX "idx_94495_t_link_strategy_link_device_ip_idx" ON "t_block_history" USING btree (
  "link_device_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_block_history
-- ----------------------------
ALTER TABLE "t_block_history" ADD CONSTRAINT "idx_94495_primary" PRIMARY KEY ("id");

-- ============================
-- TRIGGERS
-- ============================
-- ----------------------------
-- Triggers structure for table t_block_history
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_block_history"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_block_history"();
