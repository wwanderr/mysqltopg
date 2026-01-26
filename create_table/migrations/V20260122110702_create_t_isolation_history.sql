/*
 * Table: t_isolation_history
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Type Definitions
-- ----------------------------
-- ----------------------------
-- Type structure for t_isolation_history_action
-- ----------------------------
DROP TYPE IF EXISTS "t_isolation_history_action";
CREATE TYPE "t_isolation_history_action" AS ENUM (
  '主机一键隔离',
  '主机取消隔离',
  '未知'
);
ALTER TYPE "t_isolation_history_action" OWNER TO "dbapp";

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_isolation_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_isolation_history_id_seq";
CREATE SEQUENCE "t_isolation_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_isolation_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_isolation_history
-- ----------------------------
DROP TABLE IF EXISTS "t_isolation_history";
CREATE TABLE "t_isolation_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_isolation_history_id_seq'::regclass),
  "strategy_id" int8 NOT NULL,
  "strategy_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "node_ip" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "node_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "os_str" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "device_ip" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "device_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "device_type" varchar(255) COLLATE "pg_catalog"."default",
  "action" "t_isolation_history_action" NOT NULL DEFAULT '未知'::xdr22.t_isolation_history_action,
  "last_occur_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "source" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'manual'::character varying
)
;
ALTER TABLE "t_isolation_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_isolation_history"."id" IS '主键ID';
COMMENT ON COLUMN "t_isolation_history"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_isolation_history"."strategy_name" IS '策略名称';
COMMENT ON COLUMN "t_isolation_history"."node_ip" IS '终端操作系统IP';
COMMENT ON COLUMN "t_isolation_history"."node_id" IS '联动设备ID';
COMMENT ON COLUMN "t_isolation_history"."os_str" IS '终端操作系统类型';
COMMENT ON COLUMN "t_isolation_history"."device_ip" IS '联动设备IP';
COMMENT ON COLUMN "t_isolation_history"."device_id" IS '联动设备id';
COMMENT ON COLUMN "t_isolation_history"."device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_isolation_history"."action" IS '下发的主机动作';
COMMENT ON COLUMN "t_isolation_history"."last_occur_time" IS '最后一次时间';
COMMENT ON COLUMN "t_isolation_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_isolation_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_isolation_history"."source" IS '策略来源';
COMMENT ON TABLE "t_isolation_history" IS '主机隔离下发记录表';

-- ----------------------------
-- Records of t_isolation_history
-- ----------------------------
BEGIN;
COMMIT;