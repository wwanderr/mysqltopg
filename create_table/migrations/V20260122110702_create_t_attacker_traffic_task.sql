/*
 * Table: t_attacker_traffic_task
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_attacker_traffic_task_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_attacker_traffic_task_id_seq";
CREATE SEQUENCE "t_attacker_traffic_task_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_attacker_traffic_task_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_attacker_traffic_task
-- ----------------------------
DROP TABLE IF EXISTS "t_attacker_traffic_task";
CREATE TABLE "t_attacker_traffic_task" (
  "id" int8 NOT NULL DEFAULT nextval('t_attacker_traffic_task_id_seq'::regclass),
  "ip" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "date_part" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "start_time" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "time_offset" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "history_time_offset" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "is_init" bool NOT NULL DEFAULT false,
  "create_time" timestamptz(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_attacker_traffic_task" OWNER TO "dbapp";
COMMENT ON COLUMN "t_attacker_traffic_task"."id" IS '主键id';
COMMENT ON COLUMN "t_attacker_traffic_task"."ip" IS '攻击者ip';
COMMENT ON COLUMN "t_attacker_traffic_task"."date_part" IS '日期分区';
COMMENT ON COLUMN "t_attacker_traffic_task"."start_time" IS '首次计算时间';
COMMENT ON COLUMN "t_attacker_traffic_task"."time_offset" IS '当前计算时间';
COMMENT ON COLUMN "t_attacker_traffic_task"."is_init" IS '是否计算当天开始时间前数据';
COMMENT ON COLUMN "t_attacker_traffic_task"."create_time" IS '创建时间';

-- ----------------------------
-- Records of t_attacker_traffic_task
-- ----------------------------
BEGIN;
COMMIT;