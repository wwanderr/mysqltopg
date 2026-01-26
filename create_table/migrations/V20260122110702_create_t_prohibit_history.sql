/*
 * Table: t_prohibit_history
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_prohibit_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_prohibit_history_id_seq";
CREATE SEQUENCE "t_prohibit_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_prohibit_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_prohibit_history
-- ----------------------------
DROP TABLE IF EXISTS "t_prohibit_history";
CREATE TABLE "t_prohibit_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_prohibit_history_id_seq'::regclass),
  "block_ip" varchar(2048) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "second_ip" varchar(2048) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_type" varchar(16) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" bool DEFAULT true,
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "effect_time" varchar(255) COLLATE "pg_catalog"."default" DEFAULT '0'::character varying,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "source" varchar(255) COLLATE "pg_catalog"."default" DEFAULT 'manual'::character varying,
  "create_type" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'none'::character varying,
  "strategy_id" int8 NOT NULL,
  "file_block" int4,
  "process_block" int4,
  "nta_name" varchar(100) COLLATE "pg_catalog"."default",
  "launch_times" int4 NOT NULL DEFAULT 1,
  "recovery_id" varchar(100) COLLATE "pg_catalog"."default",
  "direction" int8 NOT NULL DEFAULT '3'::bigint,
  "node_ip" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "node_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_prohibit_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_prohibit_history"."block_ip" IS '阻断ip';
COMMENT ON COLUMN "t_prohibit_history"."second_ip" IS '目的ip';
COMMENT ON COLUMN "t_prohibit_history"."link_device_ip" IS '联动设备ip';
COMMENT ON COLUMN "t_prohibit_history"."link_device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_prohibit_history"."status" IS '生效状态';
COMMENT ON COLUMN "t_prohibit_history"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_prohibit_history"."effect_time" IS '生效时长，0-永久';
COMMENT ON COLUMN "t_prohibit_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_prohibit_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_prohibit_history"."source" IS '来源';
COMMENT ON COLUMN "t_prohibit_history"."create_type" IS '添加方式';
COMMENT ON COLUMN "t_prohibit_history"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_prohibit_history"."file_block" IS '1-文件隔离 2-忽略';
COMMENT ON COLUMN "t_prohibit_history"."process_block" IS '1-禁止联网 2-关闭进程 4-忽略';
COMMENT ON COLUMN "t_prohibit_history"."launch_times" IS '下发次数';
COMMENT ON COLUMN "t_prohibit_history"."recovery_id" IS 'agent解禁id';
COMMENT ON COLUMN "t_prohibit_history"."direction" IS '1:入站,2:出战,3:出入站';
COMMENT ON COLUMN "t_prohibit_history"."node_ip" IS '主机ip';
COMMENT ON COLUMN "t_prohibit_history"."node_id" IS '主机id';

-- ----------------------------
-- Records of t_prohibit_history
-- ----------------------------
BEGIN;
COMMIT;