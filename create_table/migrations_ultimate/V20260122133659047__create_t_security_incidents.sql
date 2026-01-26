/*
 * Table: t_security_incidents
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_security_incidents_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_security_incidents_id_seq" CASCADE;
CREATE SEQUENCE "t_security_incidents_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_security_incidents_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_security_incidents
-- ----------------------------
DROP TABLE IF EXISTS "t_security_incidents";
CREATE TABLE "t_security_incidents" (
  "id" int8 NOT NULL DEFAULT nextval('t_security_incidents_id_seq'::regclass),
  "template_id" int8,
  "template_code" varchar(50) COLLATE "pg_catalog"."default",
  "attack_conclusion" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(10) COLLATE "pg_catalog"."default",
  "start_time" timestamp(6),
  "end_time" timestamp(6),
  "create_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "sub_category" varchar(100) COLLATE "pg_catalog"."default",
  "category" varchar(100) COLLATE "pg_catalog"."default",
  "event_name" varchar(255) COLLATE "pg_catalog"."default",
  "attacker" text COLLATE "pg_catalog"."default",
  "victim" text COLLATE "pg_catalog"."default",
  "counts" int8,
  "alarm_status" varchar(20) COLLATE "pg_catalog"."default",
  "alarm_results" varchar(20) COLLATE "pg_catalog"."default",
  "kill_chain" text COLLATE "pg_catalog"."default",
  "succeed_count" int8,
  "fail_count" int8,
  "event_ids" text COLLATE "pg_catalog"."default",
  "mirror_sub_category" varchar(100) COLLATE "pg_catalog"."default",
  "family_id" text COLLATE "pg_catalog"."default",
  "organization_id" text COLLATE "pg_catalog"."default",
  "focus" varchar(10) COLLATE "pg_catalog"."default",
  "event_code" varchar(200) COLLATE "pg_catalog"."default",
  "focus_ip" text COLLATE "pg_catalog"."default",
  "incident_cond" varchar(20) COLLATE "pg_catalog"."default",
  "tag_search" text COLLATE "pg_catalog"."default",
  "is_scenario" int4,
  "update_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_ip_information" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_security_incidents" OWNER TO "dbapp";
COMMENT ON COLUMN "t_security_incidents"."id" IS '唯一id';
COMMENT ON COLUMN "t_security_incidents"."template_id" IS '模板id';
COMMENT ON COLUMN "t_security_incidents"."template_code" IS '模板code';
COMMENT ON COLUMN "t_security_incidents"."attack_conclusion" IS '攻击总结';
COMMENT ON COLUMN "t_security_incidents"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_security_incidents"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_security_incidents"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_security_incidents"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_security_incidents"."sub_category" IS '事件子类型';
COMMENT ON COLUMN "t_security_incidents"."category" IS '事件类型';
COMMENT ON COLUMN "t_security_incidents"."event_name" IS '事件名称';
COMMENT ON COLUMN "t_security_incidents"."attacker" IS '攻击者ip';
COMMENT ON COLUMN "t_security_incidents"."victim" IS '受害者ip';
COMMENT ON COLUMN "t_security_incidents"."counts" IS '攻击次数';
COMMENT ON COLUMN "t_security_incidents"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_security_incidents"."alarm_results" IS '攻击结果';
COMMENT ON COLUMN "t_security_incidents"."kill_chain" IS '攻击链';
COMMENT ON COLUMN "t_security_incidents"."succeed_count" IS '攻击成功次数';
COMMENT ON COLUMN "t_security_incidents"."fail_count" IS '攻击失败次数';
COMMENT ON COLUMN "t_security_incidents"."event_ids" IS '聚合告警id';
COMMENT ON COLUMN "t_security_incidents"."mirror_sub_category" IS 'mirror告警子类型';
COMMENT ON COLUMN "t_security_incidents"."family_id" IS '家族id';
COMMENT ON COLUMN "t_security_incidents"."organization_id" IS '组织id';
COMMENT ON COLUMN "t_security_incidents"."focus" IS '关注对象';
COMMENT ON COLUMN "t_security_incidents"."event_code" IS '事件唯一键值';
COMMENT ON COLUMN "t_security_incidents"."focus_ip" IS '关注IP';
COMMENT ON COLUMN "t_security_incidents"."incident_cond" IS '线头事件条件';
COMMENT ON COLUMN "t_security_incidents"."tag_search" IS '标签（数组）';
COMMENT ON COLUMN "t_security_incidents"."is_scenario" IS '是否符合追溯条件，符合1，不符合null';
COMMENT ON COLUMN "t_security_incidents"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_security_incidents"."update_ip_information" IS '告警子事件更新ip的信息';

-- ----------------------------
-- Records of t_security_incidents
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_security_incidents_id_seq"
OWNED BY "t_security_incidents"."id";
SELECT setval('"t_security_incidents_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_security_incidents
-- ----------------------------
CREATE INDEX "idx_94886_create_time" ON "t_security_incidents" USING btree (
  "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94886_end_time" ON "t_security_incidents" USING btree (
  "end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_94886_event_code_unique" ON "t_security_incidents" USING btree (
  "event_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94886_sub_category" ON "t_security_incidents" USING btree (
  "sub_category" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_security_incidents
-- ----------------------------
ALTER TABLE "t_security_incidents" ADD CONSTRAINT "idx_94886_primary" PRIMARY KEY ("id");
