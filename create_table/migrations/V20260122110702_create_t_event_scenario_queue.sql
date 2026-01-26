/*
 * Table: t_event_scenario_queue
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Table structure for t_event_scenario_queue
-- ----------------------------
DROP TABLE IF EXISTS "t_event_scenario_queue";
CREATE TABLE "t_event_scenario_queue" (
  "focus_ip" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "target_ip" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "event_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "scenario_template_id" int8 NOT NULL,
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "alarm_info" text COLLATE "pg_catalog"."default",
  "src_address" varchar(50) COLLATE "pg_catalog"."default",
  "dest_address" varchar(50) COLLATE "pg_catalog"."default",
  "time_part" varchar(10) COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_job_commit" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "t_event_scenario_queue" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_scenario_queue"."focus_ip" IS '关注ip';
COMMENT ON COLUMN "t_event_scenario_queue"."target_ip" IS '目的IP';
COMMENT ON COLUMN "t_event_scenario_queue"."event_code" IS '安全事件唯一标识code';
COMMENT ON COLUMN "t_event_scenario_queue"."scenario_template_id" IS '安全事件场景模板id';
COMMENT ON COLUMN "t_event_scenario_queue"."start_time" IS '开始时间';
COMMENT ON COLUMN "t_event_scenario_queue"."end_time" IS '结束时间';
COMMENT ON COLUMN "t_event_scenario_queue"."alarm_info" IS '告警列表信息，windowId，aggCondition，eventId，endTime';
COMMENT ON COLUMN "t_event_scenario_queue"."src_address" IS '来源IP';
COMMENT ON COLUMN "t_event_scenario_queue"."dest_address" IS '目的IP';
COMMENT ON COLUMN "t_event_scenario_queue"."time_part" IS '时间分区';
COMMENT ON COLUMN "t_event_scenario_queue"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_event_scenario_queue"."is_job_commit" IS '溯源任务是否已提交';
COMMENT ON TABLE "t_event_scenario_queue" IS '安全事件场景缓冲队列';

-- ----------------------------
-- Records of t_event_scenario_queue
-- ----------------------------
BEGIN;
COMMIT;