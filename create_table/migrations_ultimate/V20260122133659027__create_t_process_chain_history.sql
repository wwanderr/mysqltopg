/*
 * Table: t_process_chain_history
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- FUNCTION DEFINITIONS
-- ============================
-- ----------------------------
-- Function structure for on_update_current_timestamp_t_process_chain_history
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_process_chain_history"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_process_chain_history"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_process_chain_history"() OWNER TO "dbapp";

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_process_chain_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_process_chain_history_id_seq" CASCADE;
CREATE SEQUENCE "t_process_chain_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_process_chain_history_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_process_chain_history
-- ----------------------------
DROP TABLE IF EXISTS "t_process_chain_history";
CREATE TABLE "t_process_chain_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_process_chain_history_id_seq'::regclass),
  "cache_key" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "chain_data" text COLLATE "pg_catalog"."default" NOT NULL,
  "trace_ids" text COLLATE "pg_catalog"."default",
  "host_addresses" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(50) COLLATE "pg_catalog"."default",
  "node_count" int8,
  "edge_count" int8,
  "create_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6)
)
;
ALTER TABLE "t_process_chain_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_process_chain_history"."id" IS '主键ID';
COMMENT ON COLUMN "t_process_chain_history"."cache_key" IS '缓存键：eventCode_ip 即子事件 uniq_code';
COMMENT ON COLUMN "t_process_chain_history"."chain_data" IS '进程链JSON数据';
COMMENT ON COLUMN "t_process_chain_history"."trace_ids" IS 'traceId列表（逗号分隔）';
COMMENT ON COLUMN "t_process_chain_history"."host_addresses" IS 'IP地址列表（逗号分隔）';
COMMENT ON COLUMN "t_process_chain_history"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_process_chain_history"."node_count" IS '节点数量';
COMMENT ON COLUMN "t_process_chain_history"."edge_count" IS '边数量';
COMMENT ON COLUMN "t_process_chain_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_process_chain_history"."update_time" IS '更新时间';
COMMENT ON TABLE "t_process_chain_history" IS '历史进程链缓存表';

-- ----------------------------
-- Records of t_process_chain_history
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_process_chain_history_id_seq"
OWNED BY "t_process_chain_history"."id";
SELECT setval('"t_process_chain_history_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_process_chain_history
-- ----------------------------
CREATE UNIQUE INDEX "idx_94683_cachekey" ON "t_process_chain_history" USING btree (
  "cache_key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_process_chain_history
-- ----------------------------
ALTER TABLE "t_process_chain_history" ADD CONSTRAINT "idx_94683_primary" PRIMARY KEY ("id");

-- ============================
-- TRIGGERS
-- ============================
-- ----------------------------
-- Triggers structure for table t_process_chain_history
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_process_chain_history"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_process_chain_history"();
