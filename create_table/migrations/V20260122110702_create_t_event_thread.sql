/*
 * Table: t_event_thread
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Table structure for t_event_thread
-- ----------------------------
DROP TABLE IF EXISTS "t_event_thread";
CREATE TABLE "t_event_thread" (
  "template_id" int8 NOT NULL,
  "incident_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "focus" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "focus_ip" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "time_part" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "event_code" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "attacker" varchar(20) COLLATE "pg_catalog"."default",
  "victim" varchar(20) COLLATE "pg_catalog"."default",
  "end_time" timestamptz(6),
  "is_delete" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "t_event_thread" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_thread"."template_id" IS '安全事件模板id';
COMMENT ON COLUMN "t_event_thread"."incident_name" IS '安全事件名称';
COMMENT ON COLUMN "t_event_thread"."focus" IS '关注类型，attacker、victim';
COMMENT ON COLUMN "t_event_thread"."focus_ip" IS '关注ip';
COMMENT ON COLUMN "t_event_thread"."time_part" IS '时间分区，按天分区';
COMMENT ON COLUMN "t_event_thread"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_event_thread"."event_code" IS '安全事件唯一code';
COMMENT ON COLUMN "t_event_thread"."attacker" IS '攻击者';
COMMENT ON COLUMN "t_event_thread"."victim" IS '受害者';
COMMENT ON COLUMN "t_event_thread"."is_delete" IS '是否已删除';
COMMENT ON TABLE "t_event_thread" IS '保存安全事件线头';

-- ----------------------------
-- Records of t_event_thread
-- ----------------------------
BEGIN;
COMMIT;