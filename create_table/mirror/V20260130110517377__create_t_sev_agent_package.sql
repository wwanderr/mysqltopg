CREATE SEQUENCE "t_sev_agent_package_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for t_sev_agent_package
-- ----------------------------
DROP TABLE IF EXISTS "t_sev_agent_package";
CREATE TABLE "t_sev_agent_package" (
  "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_package_id_seq'::regclass),
  "agent_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "package_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "package_version" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "depend_software" varchar(100) COLLATE "pg_catalog"."default",
  "file_uuid" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "file_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp,
  "upload_type" varchar(32) COLLATE "pg_catalog"."default",
  "file_size" int8 NOT NULL
)
;
ALTER TABLE "t_sev_agent_package" OWNER TO "dbapp";
COMMENT ON COLUMN "t_sev_agent_package"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_package"."agent_type" IS 'agent类型（AiNTA、APT、SOC）';
COMMENT ON COLUMN "t_sev_agent_package"."package_type" IS '升级包类型（software、rule、intelligence）';
COMMENT ON COLUMN "t_sev_agent_package"."package_version" IS '版本号';
COMMENT ON COLUMN "t_sev_agent_package"."depend_software" IS '依赖软件版本';
COMMENT ON COLUMN "t_sev_agent_package"."file_uuid" IS '升级包文件uuid';
COMMENT ON COLUMN "t_sev_agent_package"."file_name" IS '升级包文件名';
COMMENT ON COLUMN "t_sev_agent_package"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_sev_agent_package"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_sev_agent_package"."upload_type" IS '上传方式';
COMMENT ON COLUMN "t_sev_agent_package"."file_size" IS '文件大小';
COMMENT ON TABLE "t_sev_agent_package" IS '探针升级包信息表';

-- ----------------------------
-- Records of t_sev_agent_package
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_sev_agent_rule_closed
-- ----------------------------
DROP TABLE IF EXISTS "t_sev_agent_rule_closed";
CREATE TABLE "t_sev_agent_rule_closed" (
  "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_rule_closed_id_seq'::regclass),
  "rule_closed_id" int8 NOT NULL,
  "agent_code" varchar(150) COLLATE "pg_catalog"."default",
  "is_delete" bool NOT NULL DEFAULT false,
  "config_version" int8 NOT NULL
)
;
ALTER TABLE "t_sev_agent_rule_closed" OWNER TO "dbapp";
COMMENT ON COLUMN "t_sev_agent_rule_closed"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_rule_closed"."rule_closed_id" IS '探针类型与关闭规则关联表id';
COMMENT ON COLUMN "t_sev_agent_rule_closed"."agent_code" IS '探针设备唯一标识';
COMMENT ON COLUMN "t_sev_agent_rule_closed"."is_delete" IS '标记是否删除';
COMMENT ON COLUMN "t_sev_agent_rule_closed"."config_version" IS '配置版本号，创建时间戳，毫秒值';
COMMENT ON TABLE "t_sev_agent_rule_closed" IS '探针设备与关闭规则关联表';

-- ----------------------------
-- Records of t_sev_agent_rule_closed
-- ----------------------------
BEGIN;
COMMIT;

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
-- Records of t_sev_agent_package
-- ----------------------------
BEGIN;
COMMIT;