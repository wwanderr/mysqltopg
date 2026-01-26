/*
 * Table: t_event_scenario_data
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_event_scenario_data_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_event_scenario_data_id_seq" CASCADE;
CREATE SEQUENCE "t_event_scenario_data_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_event_scenario_data_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_event_scenario_data
-- ----------------------------
DROP TABLE IF EXISTS "t_event_scenario_data";
CREATE TABLE "t_event_scenario_data" (
  "id" int8 NOT NULL DEFAULT nextval('t_event_scenario_data_id_seq'::regclass),
  "result" text COLLATE "pg_catalog"."default",
  "log_session_id" varchar(200) COLLATE "pg_catalog"."default",
  "incident_id" int8,
  "scenario_id" int8,
  "event_time" date,
  "update_time" timestamp(6),
  "focus_ip" varchar(100) COLLATE "pg_catalog"."default",
  "target_ip" varchar(100) COLLATE "pg_catalog"."default",
  "conclusion" text COLLATE "pg_catalog"."default",
  "trace_graph_version" varchar(100) COLLATE "pg_catalog"."default",
  "trace_graph" text COLLATE "pg_catalog"."default",
  "risk_id" int8
)
;
ALTER TABLE "t_event_scenario_data" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_scenario_data"."id" IS '主键id';
COMMENT ON COLUMN "t_event_scenario_data"."result" IS '返回值';
COMMENT ON COLUMN "t_event_scenario_data"."log_session_id" IS '溯源id';
COMMENT ON COLUMN "t_event_scenario_data"."incident_id" IS '关联安全事件id';
COMMENT ON COLUMN "t_event_scenario_data"."scenario_id" IS '关联场景id';
COMMENT ON COLUMN "t_event_scenario_data"."event_time" IS '创建年日';
COMMENT ON COLUMN "t_event_scenario_data"."update_time" IS '更新日期';
COMMENT ON COLUMN "t_event_scenario_data"."focus_ip" IS '关注ip';
COMMENT ON COLUMN "t_event_scenario_data"."target_ip" IS '目标ip';
COMMENT ON COLUMN "t_event_scenario_data"."conclusion" IS '总结';
COMMENT ON COLUMN "t_event_scenario_data"."trace_graph_version" IS '溯源树解析版本';
COMMENT ON COLUMN "t_event_scenario_data"."trace_graph" IS '简化后溯源图';
COMMENT ON COLUMN "t_event_scenario_data"."risk_id" IS '聚合事件的id';

-- ----------------------------
-- Records of t_event_scenario_data
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_event_scenario_data_id_seq"
OWNED BY "t_event_scenario_data"."id";
SELECT setval('"t_event_scenario_data_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_event_scenario_data
-- ----------------------------
CREATE INDEX "idx_94541_eventid" ON "t_event_scenario_data" USING btree (
  "incident_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_94541_unique" ON "t_event_scenario_data" USING btree (
  "incident_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "scenario_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "focus_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "target_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_event_scenario_data
-- ----------------------------
ALTER TABLE "t_event_scenario_data" ADD CONSTRAINT "idx_94541_primary" PRIMARY KEY ("id");
