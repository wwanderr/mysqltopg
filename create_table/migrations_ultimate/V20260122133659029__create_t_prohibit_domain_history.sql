/*
 * Table: t_prohibit_domain_history
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- FUNCTION DEFINITIONS
-- ============================
-- ----------------------------
-- Function structure for on_update_current_timestamp_t_prohibit_domain_history
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_prohibit_domain_history"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_prohibit_domain_history"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_prohibit_domain_history"() OWNER TO "dbapp";

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_prohibit_domain_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_prohibit_domain_history_id_seq" CASCADE;
CREATE SEQUENCE "t_prohibit_domain_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_prohibit_domain_history_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_prohibit_domain_history
-- ----------------------------
DROP TABLE IF EXISTS "t_prohibit_domain_history";
CREATE TABLE "t_prohibit_domain_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_prohibit_domain_history_id_seq'::regclass),
  "block_domain" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_type" varchar(16) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" bool DEFAULT true,
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "effect_time" varchar(255) COLLATE "pg_catalog"."default" DEFAULT '0'::character varying,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp(6),
  "source" varchar(255) COLLATE "pg_catalog"."default" DEFAULT 'manual'::character varying,
  "create_type" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'none'::character varying,
  "strategy_id" int8 NOT NULL,
  "file_block" int4,
  "process_block" int4,
  "nta_name" varchar(100) COLLATE "pg_catalog"."default",
  "launch_times" int4 NOT NULL DEFAULT 1,
  "recovery_id" varchar(100) COLLATE "pg_catalog"."default",
  "direction" int8 NOT NULL DEFAULT '1'::bigint,
  "node_ip" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "node_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_prohibit_domain_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_prohibit_domain_history"."block_domain" IS '封禁域名';
COMMENT ON COLUMN "t_prohibit_domain_history"."link_device_ip" IS '联动设备ip';
COMMENT ON COLUMN "t_prohibit_domain_history"."link_device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_prohibit_domain_history"."status" IS '生效状态';
COMMENT ON COLUMN "t_prohibit_domain_history"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_prohibit_domain_history"."effect_time" IS '生效时长，0-永久';
COMMENT ON COLUMN "t_prohibit_domain_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_prohibit_domain_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_prohibit_domain_history"."source" IS '来源';
COMMENT ON COLUMN "t_prohibit_domain_history"."create_type" IS '添加方式';
COMMENT ON COLUMN "t_prohibit_domain_history"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_prohibit_domain_history"."file_block" IS '1-文件隔离 2-忽略';
COMMENT ON COLUMN "t_prohibit_domain_history"."process_block" IS '1-禁止联网 2-关闭进程 4-忽略';
COMMENT ON COLUMN "t_prohibit_domain_history"."nta_name" IS 'AiNTA策略名称/agent终端id';
COMMENT ON COLUMN "t_prohibit_domain_history"."launch_times" IS '下发次数';
COMMENT ON COLUMN "t_prohibit_domain_history"."recovery_id" IS 'agent解禁id';
COMMENT ON COLUMN "t_prohibit_domain_history"."direction" IS '1:入站,2:出战,3:出入站';
COMMENT ON COLUMN "t_prohibit_domain_history"."node_ip" IS '主机ip';
COMMENT ON COLUMN "t_prohibit_domain_history"."node_id" IS '主机id';
COMMENT ON TABLE "t_prohibit_domain_history" IS '域名封禁下发记录';

-- ----------------------------
-- Records of t_prohibit_domain_history
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_prohibit_domain_history_id_seq"
OWNED BY "t_prohibit_domain_history"."id";
SELECT setval('"t_prohibit_domain_history_id_seq"', 1, true);

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_prohibit_domain_history
-- ----------------------------
CREATE INDEX "idx_94705_t_link_strategy_block_domain_idx" ON "t_prohibit_domain_history" USING btree (
  "block_domain" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94705_t_link_strategy_effect_time_idx" ON "t_prohibit_domain_history" USING btree (
  "effect_time" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94705_t_link_strategy_link_device_ip_idx" ON "t_prohibit_domain_history" USING btree (
  "link_device_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_prohibit_domain_history
-- ----------------------------
ALTER TABLE "t_prohibit_domain_history" ADD CONSTRAINT "idx_94705_primary" PRIMARY KEY ("id");

-- ============================
-- TRIGGERS
-- ============================
-- ----------------------------
-- Triggers structure for table t_prohibit_domain_history
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_prohibit_domain_history"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_prohibit_domain_history"();
