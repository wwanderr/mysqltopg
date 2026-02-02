CREATE SEQUENCE "t_sev_agent_type_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE "t_sev_agent_type_rule_closed_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for t_sev_agent_type
-- ----------------------------
DROP TABLE IF EXISTS "t_sev_agent_type";
CREATE TABLE "t_sev_agent_type" (
  "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_type_id_seq'::regclass),
  "agent_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "agent_type_name" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(4096) COLLATE "pg_catalog"."default",
  "support_version" varchar(150) COLLATE "pg_catalog"."default",
  "license_pattern" varchar(100) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_sev_agent_type" OWNER TO "dbapp";
COMMENT ON COLUMN "t_sev_agent_type"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_type"."agent_type" IS 'agent类型（AiNTA、APT、SOC）';
COMMENT ON COLUMN "t_sev_agent_type"."agent_type_name" IS 'agent类型名称';
COMMENT ON COLUMN "t_sev_agent_type"."description" IS 'agent描述';
COMMENT ON COLUMN "t_sev_agent_type"."support_version" IS '支持的最小软件版本';
COMMENT ON COLUMN "t_sev_agent_type"."license_pattern" IS '许可文件名校验正则';
COMMENT ON TABLE "t_sev_agent_type" IS '探针类型表';

-- ----------------------------
-- Records of t_sev_agent_type
-- ----------------------------
BEGIN;
INSERT INTO "t_sev_agent_type" ("id", "agent_type", "agent_type_name", "description", "support_version", "license_pattern") VALUES (10, 'APT', '流量探针(APT)', NULL, NULL, '^license.dat$');

-- ----------------------------
-- Records of t_sev_agent_type
-- ----------------------------
BEGIN;
COMMIT;