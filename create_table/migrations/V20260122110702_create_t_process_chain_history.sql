/*
 * Table: t_process_chain_history
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_process_chain_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_process_chain_history_id_seq";
CREATE SEQUENCE "t_process_chain_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_process_chain_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_process_chain_history
-- ----------------------------
DROP TABLE IF EXISTS "t_process_chain_history";
CREATE TABLE "t_process_chain_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_process_chain_history_id_seq'::regclass),
  "cache_key" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "chain_data" text COLLATE "pg_catalog"."default" NOT NULL,
  "trace_ids" text COLLATE "pg_catalog"."default",
  "host_addresses" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(50) COLLATE "pg_catalog"."default",
  "node_count" int8,
  "edge_count" int8,
  "create_time" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_process_chain_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_process_chain_history"."id" IS '主键ID';
COMMENT ON COLUMN "t_process_chain_history"."cache_key" IS '缓存键：eventCode_ip 即子事件 uniq_code';
COMMENT ON COLUMN "t_process_chain_history"."chain_data" IS '进程链JSON数据';
COMMENT ON COLUMN "t_process_chain_history"."trace_ids" IS 'traceId列表（逗号分隔）';
COMMENT ON COLUMN "t_process_chain_history"."host_addresses" IS 'IP地址列表（逗号分隔）';
COMMENT ON COLUMN "t_process_chain_history"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_process_chain_history"."node_count" IS '节点数量';
COMMENT ON COLUMN "t_process_chain_history"."edge_count" IS '边数量';
COMMENT ON COLUMN "t_process_chain_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_process_chain_history"."update_time" IS '更新时间';
COMMENT ON TABLE "t_process_chain_history" IS '历史进程链缓存表';

-- ----------------------------
-- Records of t_process_chain_history
-- ----------------------------
BEGIN;
COMMIT;