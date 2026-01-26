/*
 * Table: t_risk_incidents_analysis
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- FUNCTION DEFINITIONS
-- ============================
-- ----------------------------
-- Function structure for on_update_current_timestamp_t_risk_incidents_analysis
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_risk_incidents_analysis"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_risk_incidents_analysis"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_risk_incidents_analysis"() OWNER TO "dbapp";

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_risk_incidents_analysis_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_risk_incidents_analysis_id_seq" CASCADE;
CREATE SEQUENCE "t_risk_incidents_analysis_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_risk_incidents_analysis_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_risk_incidents_analysis
-- ----------------------------
DROP TABLE IF EXISTS "t_risk_incidents_analysis";
CREATE TABLE "t_risk_incidents_analysis" (
  "id" int8 NOT NULL DEFAULT nextval('t_risk_incidents_analysis_id_seq'::regclass),
  "risk_incidents_event_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "status" varchar(10) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'todo'::character varying,
  "core_risks" text COLLATE "pg_catalog"."default",
  "popular_interpretation" text COLLATE "pg_catalog"."default",
  "critical_dangerpoint" text COLLATE "pg_catalog"."default",
  "attack_objective" text COLLATE "pg_catalog"."default",
  "attack_disposal_suggestions" text COLLATE "pg_catalog"."default",
  "attack_info" text COLLATE "pg_catalog"."default",
  "run_error" text COLLATE "pg_catalog"."default",
  "last_run_time" timestamp(6),
  "last_run_time_consuming" int8,
  "incidents_end_time" timestamp(6),
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6)
)
;
ALTER TABLE "t_risk_incidents_analysis" OWNER TO "dbapp";
COMMENT ON COLUMN "t_risk_incidents_analysis"."id" IS '主键ID';
COMMENT ON COLUMN "t_risk_incidents_analysis"."risk_incidents_event_code" IS '风险事件编号';
COMMENT ON COLUMN "t_risk_incidents_analysis"."status" IS '解读状态：todo[未处理]、update[有变更]、done[已经处理]';
COMMENT ON COLUMN "t_risk_incidents_analysis"."core_risks" IS '一句话描述';
COMMENT ON COLUMN "t_risk_incidents_analysis"."popular_interpretation" IS '攻击详情';
COMMENT ON COLUMN "t_risk_incidents_analysis"."critical_dangerpoint" IS '事件危害';
COMMENT ON COLUMN "t_risk_incidents_analysis"."attack_objective" IS '攻击意图';
COMMENT ON COLUMN "t_risk_incidents_analysis"."attack_disposal_suggestions" IS '处置建议';
COMMENT ON COLUMN "t_risk_incidents_analysis"."attack_info" IS '攻击信息';
COMMENT ON COLUMN "t_risk_incidents_analysis"."run_error" IS '上次执行异常';
COMMENT ON COLUMN "t_risk_incidents_analysis"."last_run_time" IS '上次执行时间';
COMMENT ON COLUMN "t_risk_incidents_analysis"."last_run_time_consuming" IS '上次执行耗时';
COMMENT ON COLUMN "t_risk_incidents_analysis"."incidents_end_time" IS '事件最近时间';
COMMENT ON COLUMN "t_risk_incidents_analysis"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_risk_incidents_analysis"."update_time" IS '更新时间';
COMMENT ON TABLE "t_risk_incidents_analysis" IS '风险事件解读结果表';

-- ----------------------------
-- Records of t_risk_incidents_analysis
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_risk_incidents_analysis_id_seq"
OWNED BY "t_risk_incidents_analysis"."id";
SELECT setval('"t_risk_incidents_analysis_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_risk_incidents_analysis
-- ----------------------------
CREATE UNIQUE INDEX "idx_94760_unique_risk_incidents_event_code" ON "t_risk_incidents_analysis" USING btree (
  "risk_incidents_event_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_risk_incidents_analysis
-- ----------------------------
ALTER TABLE "t_risk_incidents_analysis" ADD CONSTRAINT "idx_94760_primary" PRIMARY KEY ("id");

-- ============================
-- TRIGGERS
-- ============================
-- ----------------------------
-- Triggers structure for table t_risk_incidents_analysis
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_risk_incidents_analysis"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_risk_incidents_analysis"();
