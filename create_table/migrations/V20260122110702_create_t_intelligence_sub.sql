/*
 * Table: t_intelligence_sub
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_intelligence_sub_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_intelligence_sub_id_seq";
CREATE SEQUENCE "t_intelligence_sub_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_intelligence_sub_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_intelligence_sub
-- ----------------------------
DROP TABLE IF EXISTS "t_intelligence_sub";
CREATE TABLE "t_intelligence_sub" (
  "id" int8 NOT NULL DEFAULT nextval('t_intelligence_sub_id_seq'::regclass),
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "update_time" timestamptz(6),
  "ioc" varchar(200) COLLATE "pg_catalog"."default",
  "sub_category" varchar(30) COLLATE "pg_catalog"."default",
  "alarm_name" varchar(255) COLLATE "pg_catalog"."default",
  "threat_severity" int4,
  "counts" int8,
  "tag" varchar(20) COLLATE "pg_catalog"."default",
  "alarm_status" int4,
  "event_time" date,
  "asset_count" int8
)
;
ALTER TABLE "t_intelligence_sub" OWNER TO "dbapp";
COMMENT ON COLUMN "t_intelligence_sub"."id" IS '主键id';
COMMENT ON COLUMN "t_intelligence_sub"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_intelligence_sub"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_intelligence_sub"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_intelligence_sub"."ioc" IS 'ioC编号';
COMMENT ON COLUMN "t_intelligence_sub"."sub_category" IS '告警子类型';
COMMENT ON COLUMN "t_intelligence_sub"."alarm_name" IS '告警名称';
COMMENT ON COLUMN "t_intelligence_sub"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_intelligence_sub"."counts" IS '攻击次数';
COMMENT ON COLUMN "t_intelligence_sub"."tag" IS '标签';
COMMENT ON COLUMN "t_intelligence_sub"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_intelligence_sub"."event_time" IS '创建年日';
COMMENT ON COLUMN "t_intelligence_sub"."asset_count" IS '受影响资产数量';

-- ----------------------------
-- Records of t_intelligence_sub
-- ----------------------------
BEGIN;
COMMIT;