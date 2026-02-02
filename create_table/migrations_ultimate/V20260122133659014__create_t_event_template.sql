/*
 * Table: t_event_template
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_event_template_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_event_template_id_seq" CASCADE;
CREATE SEQUENCE "t_event_template_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_event_template_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_event_template
-- ----------------------------
DROP TABLE IF EXISTS "t_event_template";
CREATE TABLE "t_event_template" (
  "id" int8 NOT NULL DEFAULT nextval('t_event_template_id_seq'::regclass),
  "incident_name" varchar(100) COLLATE "pg_catalog"."default",
  "incident_rule_type" varchar(100) COLLATE "pg_catalog"."default",
  "incident_class_type" varchar(100) COLLATE "pg_catalog"."default",
  "incident_sub_class_type" varchar(100) COLLATE "pg_catalog"."default",
  "incident_type" bool,
  "incident_cond" varchar(100) COLLATE "pg_catalog"."default",
  "incident_description" text COLLATE "pg_catalog"."default",
  "incident_suggestion" text COLLATE "pg_catalog"."default",
  "conclusion" text COLLATE "pg_catalog"."default",
  "focus" varchar(50) COLLATE "pg_catalog"."default",
  "display_filed" text COLLATE "pg_catalog"."default",
  "enable" bool,
  "update_time" timestamp(6),
  "last_execute_time" timestamp(6),
  "uniq_code" int8,
  "incident_children" text COLLATE "pg_catalog"."default",
  "priority" int8,
  "netflow_log_field" varchar(1000) COLLATE "pg_catalog"."default",
  "host_log_field" varchar(1000) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_event_template" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_template"."id" IS '主键id';
COMMENT ON COLUMN "t_event_template"."incident_name" IS '事件名称';
COMMENT ON COLUMN "t_event_template"."incident_rule_type" IS '告警类型';
COMMENT ON COLUMN "t_event_template"."incident_class_type" IS '一级事件类型';
COMMENT ON COLUMN "t_event_template"."incident_sub_class_type" IS '二级事件类型';
COMMENT ON COLUMN "t_event_template"."incident_type" IS '事件线头';
COMMENT ON COLUMN "t_event_template"."incident_cond" IS '事件条件';
COMMENT ON COLUMN "t_event_template"."incident_description" IS '危险描述';
COMMENT ON COLUMN "t_event_template"."incident_suggestion" IS '安全建议';
COMMENT ON COLUMN "t_event_template"."conclusion" IS '攻击总结';
COMMENT ON COLUMN "t_event_template"."focus" IS '关注对象';
COMMENT ON COLUMN "t_event_template"."display_filed" IS '攻击记录/展示字段';
COMMENT ON COLUMN "t_event_template"."enable" IS '是否启用（0不启用，1启用）';
COMMENT ON COLUMN "t_event_template"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_event_template"."last_execute_time" IS '上次执行时间';
COMMENT ON COLUMN "t_event_template"."uniq_code" IS '唯一code';
COMMENT ON COLUMN "t_event_template"."incident_children" IS '安全事件外发总结字段';
COMMENT ON COLUMN "t_event_template"."priority" IS '安全事件优先级（数字越小优先级越高）';
COMMENT ON COLUMN "t_event_template"."netflow_log_field" IS '关联网侧日志展示字段';
COMMENT ON COLUMN "t_event_template"."host_log_field" IS '关联终端日志展示字段';

-- ----------------------------
-- Records of t_event_template
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_event_template_id_seq"
OWNED BY "t_event_template"."id";
SELECT setval('"t_event_template_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_event_template
-- ----------------------------
CREATE UNIQUE INDEX "idx_94562_uniq_code" ON "t_event_template" USING btree (
  "uniq_code" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_event_template
-- ----------------------------
ALTER TABLE "t_event_template" ADD CONSTRAINT "idx_94562_primary" PRIMARY KEY ("id");
