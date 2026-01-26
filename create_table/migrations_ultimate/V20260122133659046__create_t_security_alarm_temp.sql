/*
 * Table: t_security_alarm_temp
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_security_alarm_temp
-- ----------------------------
DROP TABLE IF EXISTS "t_security_alarm_temp";
CREATE TABLE "t_security_alarm_temp" (
  "event_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "src_address" varchar(100) COLLATE "pg_catalog"."default",
  "dest_address" varchar(100) COLLATE "pg_catalog"."default",
  "attacker" varchar(100) COLLATE "pg_catalog"."default",
  "victim" varchar(100) COLLATE "pg_catalog"."default",
  "sub_category" varchar(100) COLLATE "pg_catalog"."default",
  "start_time" timestamp(6),
  "end_time" timestamp(6),
  "alarm_results" varchar(100) COLLATE "pg_catalog"."default",
  "kill_chain" varchar(100) COLLATE "pg_catalog"."default",
  "tag_search" text COLLATE "pg_catalog"."default",
  "time_part" varchar(10) COLLATE "pg_catalog"."default",
  "threat_severity" varchar(10) COLLATE "pg_catalog"."default",
  "window_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "agg_condition" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "family_id" varchar(255) COLLATE "pg_catalog"."default",
  "organization_id" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_security_alarm_temp" OWNER TO "dbapp";
COMMENT ON COLUMN "t_security_alarm_temp"."src_address" IS '来源IP';
COMMENT ON COLUMN "t_security_alarm_temp"."dest_address" IS '目的IP';
COMMENT ON COLUMN "t_security_alarm_temp"."attacker" IS '攻击者';
COMMENT ON COLUMN "t_security_alarm_temp"."victim" IS '受害者';
COMMENT ON COLUMN "t_security_alarm_temp"."sub_category" IS '告警子类型';
COMMENT ON COLUMN "t_security_alarm_temp"."alarm_results" IS '攻击结果';
COMMENT ON COLUMN "t_security_alarm_temp"."kill_chain" IS '攻击链';
COMMENT ON COLUMN "t_security_alarm_temp"."time_part" IS '时间分区，按天';
COMMENT ON COLUMN "t_security_alarm_temp"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_security_alarm_temp"."family_id" IS '家族ID';
COMMENT ON COLUMN "t_security_alarm_temp"."organization_id" IS '组织ID';
COMMENT ON TABLE "t_security_alarm_temp" IS '缓存最近一小时范围内的原始告警';

-- ----------------------------
-- Records of t_security_alarm_temp
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_security_alarm_temp
-- ----------------------------
CREATE INDEX "idx_94880_t_security_alarm_temp_attacker_idx" ON "t_security_alarm_temp" USING btree (
  "attacker" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94880_t_security_alarm_temp_end_time_idx" ON "t_security_alarm_temp" USING btree (
  "end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94880_t_security_alarm_temp_sub_category_idx" ON "t_security_alarm_temp" USING btree (
  "sub_category" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94880_t_security_alarm_temp_victim_idx" ON "t_security_alarm_temp" USING btree (
  "victim" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_security_alarm_temp
-- ----------------------------
ALTER TABLE "t_security_alarm_temp" ADD CONSTRAINT "idx_94880_primary" PRIMARY KEY ("event_id");
