/*
 * Table: t_event_out_going_data
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_event_out_going_data_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_event_out_going_data_id_seq" CASCADE;
CREATE SEQUENCE "t_event_out_going_data_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_event_out_going_data_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_event_out_going_data
-- ----------------------------
DROP TABLE IF EXISTS "t_event_out_going_data";
CREATE TABLE "t_event_out_going_data" (
  "id" int8 NOT NULL DEFAULT nextval('t_event_out_going_data_id_seq'::regclass),
  "event_code" varchar(100) COLLATE "pg_catalog"."default",
  "category" varchar(50) COLLATE "pg_catalog"."default",
  "sub_category" varchar(50) COLLATE "pg_catalog"."default",
  "threat_severity" varchar(10) COLLATE "pg_catalog"."default",
  "incident_name" varchar(100) COLLATE "pg_catalog"."default",
  "event_description" text COLLATE "pg_catalog"."default",
  "start_time" timestamp(6),
  "end_time" timestamp(6),
  "attacker" text COLLATE "pg_catalog"."default",
  "victim" text COLLATE "pg_catalog"."default",
  "dest_address" text COLLATE "pg_catalog"."default",
  "src_address" text COLLATE "pg_catalog"."default",
  "request_url" text COLLATE "pg_catalog"."default",
  "request_domain" text COLLATE "pg_catalog"."default",
  "dest_port" int8,
  "dest_geo_region" varchar(100) COLLATE "pg_catalog"."default",
  "dest_geo_city" varchar(100) COLLATE "pg_catalog"."default",
  "dest_geo_county" varchar(100) COLLATE "pg_catalog"."default",
  "src_port" int8,
  "src_geo_region" varchar(100) COLLATE "pg_catalog"."default",
  "src_geo_city" varchar(100) COLLATE "pg_catalog"."default",
  "src_geo_county" varchar(100) COLLATE "pg_catalog"."default",
  "alarm_result" varchar(50) COLLATE "pg_catalog"."default",
  "event_count" int8,
  "kill_chain" text COLLATE "pg_catalog"."default",
  "mirror_category" varchar(100) COLLATE "pg_catalog"."default",
  "focus" varchar(10) COLLATE "pg_catalog"."default",
  "focus_ip" text COLLATE "pg_catalog"."default",
  "tag_search" varchar(255) COLLATE "pg_catalog"."default",
  "alarm" text COLLATE "pg_catalog"."default",
  "time_part" date,
  "create_time" timestamp(6),
  "update_time" timestamp(6),
  "incident_description" text COLLATE "pg_catalog"."default",
  "incident_suggestion" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_event_out_going_data" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_out_going_data"."id" IS '事件自增ID';
COMMENT ON COLUMN "t_event_out_going_data"."event_code" IS '事件唯一键值';
COMMENT ON COLUMN "t_event_out_going_data"."category" IS '事件类型';
COMMENT ON COLUMN "t_event_out_going_data"."sub_category" IS '事件子类型';
COMMENT ON COLUMN "t_event_out_going_data"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_event_out_going_data"."incident_name" IS '安全事件名称';
COMMENT ON COLUMN "t_event_out_going_data"."event_description" IS '安全事件详细描述';
COMMENT ON COLUMN "t_event_out_going_data"."start_time" IS '事件发生时间';
COMMENT ON COLUMN "t_event_out_going_data"."end_time" IS '事件结束时间';
COMMENT ON COLUMN "t_event_out_going_data"."attacker" IS '攻击者ip';
COMMENT ON COLUMN "t_event_out_going_data"."victim" IS '受害者ip';
COMMENT ON COLUMN "t_event_out_going_data"."dest_address" IS '目的ip';
COMMENT ON COLUMN "t_event_out_going_data"."src_address" IS '来源ip';
COMMENT ON COLUMN "t_event_out_going_data"."request_url" IS '目标对象URL';
COMMENT ON COLUMN "t_event_out_going_data"."request_domain" IS '目标对象域名';
COMMENT ON COLUMN "t_event_out_going_data"."dest_port" IS '目标对象端口';
COMMENT ON COLUMN "t_event_out_going_data"."dest_geo_region" IS '目的省会';
COMMENT ON COLUMN "t_event_out_going_data"."dest_geo_city" IS '目的城市';
COMMENT ON COLUMN "t_event_out_going_data"."dest_geo_county" IS '目的国家';
COMMENT ON COLUMN "t_event_out_going_data"."src_port" IS '来源端口';
COMMENT ON COLUMN "t_event_out_going_data"."src_geo_region" IS '来源省会';
COMMENT ON COLUMN "t_event_out_going_data"."src_geo_city" IS '来源城市';
COMMENT ON COLUMN "t_event_out_going_data"."src_geo_county" IS '来源国家';
COMMENT ON COLUMN "t_event_out_going_data"."alarm_result" IS '攻击结果';
COMMENT ON COLUMN "t_event_out_going_data"."event_count" IS '攻击次数';
COMMENT ON COLUMN "t_event_out_going_data"."kill_chain" IS '攻击链';
COMMENT ON COLUMN "t_event_out_going_data"."mirror_category" IS 'mirror告警类型';
COMMENT ON COLUMN "t_event_out_going_data"."focus" IS '关注对象';
COMMENT ON COLUMN "t_event_out_going_data"."focus_ip" IS '关注Ip';
COMMENT ON COLUMN "t_event_out_going_data"."tag_search" IS '标签';
COMMENT ON COLUMN "t_event_out_going_data"."alarm" IS '原始告警';
COMMENT ON COLUMN "t_event_out_going_data"."time_part" IS '时间分区';
COMMENT ON COLUMN "t_event_out_going_data"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_event_out_going_data"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_event_out_going_data"."incident_description" IS '事件描述';
COMMENT ON COLUMN "t_event_out_going_data"."incident_suggestion" IS '安全建议';

-- ----------------------------
-- Records of t_event_out_going_data
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_event_out_going_data_id_seq"
OWNED BY "t_event_out_going_data"."id";
SELECT setval('"t_event_out_going_data_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_event_out_going_data
-- ----------------------------
CREATE UNIQUE INDEX "idx_94534_eventcode" ON "t_event_out_going_data" USING btree (
  "event_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94534_timepart" ON "t_event_out_going_data" USING btree (
  "time_part" "pg_catalog"."date_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94534_timestamp" ON "t_event_out_going_data" USING btree (
  "start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
  "end_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_event_out_going_data
-- ----------------------------
ALTER TABLE "t_event_out_going_data" ADD CONSTRAINT "idx_94534_primary" PRIMARY KEY ("id");
