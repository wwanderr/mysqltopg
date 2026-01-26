/*
 * Table: t_event_update_ck_alarm_queue
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Table structure for t_event_update_ck_alarm_queue
-- ----------------------------
DROP TABLE IF EXISTS "t_event_update_ck_alarm_queue";
CREATE TABLE "t_event_update_ck_alarm_queue" (
  "window_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "agg_condition" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "time_part" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "event_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "end_time" timestamptz(6),
  "is_ck_sync" bool NOT NULL DEFAULT false,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
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