/*
 * Table: t_linkage_strategy_validtime
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_linkage_strategy_validtime_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_linkage_strategy_validtime_id_seq" CASCADE;
CREATE SEQUENCE "t_linkage_strategy_validtime_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_linkage_strategy_validtime_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
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

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_linkage_strategy_validtime_id_seq"
OWNED BY "t_linkage_strategy_validtime"."id";
SELECT setval('"t_linkage_strategy_validtime_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_linkage_strategy_validtime
-- ----------------------------
CREATE UNIQUE INDEX "idx_94609_t_linkage_strategy_validtime_un" ON "t_linkage_strategy_validtime" USING btree (
  "link_device_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "block_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "block_domain" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "node_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_linkage_strategy_validtime
-- ----------------------------
ALTER TABLE "t_linkage_strategy_validtime" ADD CONSTRAINT "idx_94609_primary" PRIMARY KEY ("id");
