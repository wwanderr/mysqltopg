/*
 * Table: t_notice_history
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Type Definitions
-- ----------------------------
-- ----------------------------
-- Type structure for t_notice_history_contact_type
-- ----------------------------
DROP TYPE IF EXISTS "t_notice_history_contact_type";
CREATE TYPE "t_notice_history_contact_type" AS ENUM (
  'sms',
  'email',
  'dingtalk',
  'predict',
  'order',
  'firewall',
  'wechat'
);
ALTER TYPE "t_notice_history_contact_type" OWNER TO "dbapp";

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_notice_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_notice_history_id_seq";
CREATE SEQUENCE "t_notice_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_notice_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_notice_history
-- ----------------------------
DROP TABLE IF EXISTS "t_notice_history";
CREATE TABLE "t_notice_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_notice_history_id_seq'::regclass),
  "user_id" int8 NOT NULL,
  "contact_type" "t_notice_history_contact_type",
  "contact_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "start_time_min" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "count" int8 NOT NULL,
  "alert_content" text COLLATE "pg_catalog"."default" NOT NULL,
  "failure_msg" text COLLATE "pg_catalog"."default",
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "status" bool NOT NULL DEFAULT true,
  "event_ids" text COLLATE "pg_catalog"."default",
  "modify_by" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "strategy_id" int8 NOT NULL
)
;
ALTER TABLE "t_notice_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_notice_history"."user_id" IS '通知人ID';
COMMENT ON COLUMN "t_notice_history"."contact_at" IS '通知用户时间';
COMMENT ON COLUMN "t_notice_history"."start_time_min" IS '告警数据中最小的startTime值';
COMMENT ON COLUMN "t_notice_history"."count" IS '告警总数';
COMMENT ON COLUMN "t_notice_history"."alert_content" IS '告警内容';
COMMENT ON COLUMN "t_notice_history"."failure_msg" IS '告警执行失败原因';
COMMENT ON COLUMN "t_notice_history"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_notice_history"."status" IS '告警执行状态';
COMMENT ON COLUMN "t_notice_history"."event_ids" IS '告警检测的数据Id列表';
COMMENT ON COLUMN "t_notice_history"."modify_by" IS '记录修改人';
COMMENT ON COLUMN "t_notice_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_notice_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_notice_history"."strategy_id" IS '策略ID';

-- ----------------------------
-- Records of t_notice_history
-- ----------------------------
BEGIN;
COMMIT;