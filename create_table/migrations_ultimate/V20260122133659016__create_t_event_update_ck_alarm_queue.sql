/*
 * Table: t_event_update_ck_alarm_queue
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- FUNCTION DEFINITIONS
-- ============================
-- ----------------------------
-- Function structure for on_update_current_timestamp_t_event_update_ck_alarm_queue
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_event_update_ck_alarm_queue"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_event_update_ck_alarm_queue"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.end_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_event_update_ck_alarm_queue"() OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_event_update_ck_alarm_queue
-- ----------------------------
DROP TABLE IF EXISTS "t_event_update_ck_alarm_queue";
CREATE TABLE "t_event_update_ck_alarm_queue" (
  "window_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "agg_condition" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "time_part" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "event_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "end_time" timestamp(6),
  "is_ck_sync" bool NOT NULL DEFAULT false,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_event_update_ck_alarm_queue" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_update_ck_alarm_queue"."time_part" IS '事件分区，按天分区';
COMMENT ON COLUMN "t_event_update_ck_alarm_queue"."event_id" IS '原始告警eventId';
COMMENT ON COLUMN "t_event_update_ck_alarm_queue"."end_time" IS '原始告警endTime';
COMMENT ON COLUMN "t_event_update_ck_alarm_queue"."is_ck_sync" IS 'ck是否已同步';
COMMENT ON COLUMN "t_event_update_ck_alarm_queue"."create_time" IS '创建时间';
COMMENT ON TABLE "t_event_update_ck_alarm_queue" IS '告警列表添加关联安全事件标签缓冲队列';

-- ----------------------------
-- Records of t_event_update_ck_alarm_queue
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_event_update_ck_alarm_queue
-- ----------------------------
CREATE INDEX "idx_94573_t_event_update_ck_alarm_queue_create_time_idx" ON "t_event_update_ck_alarm_queue" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94573_t_event_update_ck_alarm_queue_time_part_idx" ON "t_event_update_ck_alarm_queue" USING btree (
  "time_part" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_event_update_ck_alarm_queue
-- ----------------------------
ALTER TABLE "t_event_update_ck_alarm_queue" ADD CONSTRAINT "idx_94573_primary" PRIMARY KEY ("window_id", "agg_condition");

-- ============================
-- TRIGGERS
-- ============================
-- ----------------------------
-- Triggers structure for table t_event_update_ck_alarm_queue
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_event_update_ck_alarm_queue"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_event_update_ck_alarm_queue"();
