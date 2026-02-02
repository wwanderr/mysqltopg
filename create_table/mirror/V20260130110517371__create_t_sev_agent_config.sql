CREATE SEQUENCE "t_sev_agent_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for t_sev_agent_config
-- ----------------------------
DROP TABLE IF EXISTS "t_sev_agent_config";
CREATE TABLE "t_sev_agent_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_config_id_seq'::regclass),
  "agent_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "config_version" int8 NOT NULL,
  "config_key" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "config_content" text COLLATE "pg_catalog"."default",
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp
)
;
ALTER TABLE "t_sev_agent_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_sev_agent_config"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_config"."agent_type" IS 'agent类型（AiNTA、APT、SOC）';
COMMENT ON COLUMN "t_sev_agent_config"."config_version" IS '版本号，时间戳';
COMMENT ON COLUMN "t_sev_agent_config"."config_key" IS '配置项标识，英文名';
COMMENT ON COLUMN "t_sev_agent_config"."config_content" IS '配置内容';
COMMENT ON COLUMN "t_sev_agent_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_sev_agent_config"."update_time" IS '更新时间';
COMMENT ON TABLE "t_sev_agent_config" IS '探针配置表';

-- ----------------------------
-- Records of t_sev_agent_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_sev_agent_events
-- ----------------------------
DROP TABLE IF EXISTS "t_sev_agent_events";
CREATE TABLE "t_sev_agent_events" (
  "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_events_id_seq'::regclass),
  "agent_code" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
  "event_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "status" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "result" bool,
  "message" varchar(1024) COLLATE "pg_catalog"."default",
  "data" text COLLATE "pg_catalog"."default",
  "event_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_sev_agent_events" OWNER TO "dbapp";
COMMENT ON COLUMN "t_sev_agent_events"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_events"."agent_code" IS 'agent唯一标识';
COMMENT ON COLUMN "t_sev_agent_events"."event_type" IS '事件类型，upgrade：升级，reloadConfig：配置更新';
COMMENT ON COLUMN "t_sev_agent_events"."status" IS '事件状态，begin：开始，finish：结束';
COMMENT ON COLUMN "t_sev_agent_events"."result" IS '事件结果';
COMMENT ON COLUMN "t_sev_agent_events"."message" IS '描述信息';
COMMENT ON COLUMN "t_sev_agent_events"."data" IS '数据信息，json';
COMMENT ON COLUMN "t_sev_agent_events"."event_time" IS '事件时间';
COMMENT ON TABLE "t_sev_agent_events" IS '事件记录表';

-- ----------------------------
-- Records of t_sev_agent_events
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_sev_agent_info
-- ----------------------------
DROP TABLE IF EXISTS "t_sev_agent_info";
CREATE TABLE "t_sev_agent_info" (
  "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_info_id_seq'::regclass),
  "agent_code" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
  "agent_name" varchar(150) COLLATE "pg_catalog"."default",
  "agent_ip" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "agent_ip_num" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "agent_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "machine_code" varchar(150) COLLATE "pg_catalog"."default",
  "device_model" varchar(150) COLLATE "pg_catalog"."default",
  "soft_version" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "rule_version" varchar(256) COLLATE "pg_catalog"."default",
  "intelligence_version" varchar(256) COLLATE "pg_catalog"."default",
  "config_version" int8,
  "single_login_uri" varchar(1024) COLLATE "pg_catalog"."default",
  "status" varchar(32) COLLATE "pg_catalog"."default",
  "org_id" varchar(100) COLLATE "pg_catalog"."default",
  "regist_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp,
  "monitor_id" int8,
  "upgrade_log_id" int4
)
;
ALTER TABLE "t_sev_agent_info" OWNER TO "dbapp";
COMMENT ON COLUMN "t_sev_agent_info"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_info"."agent_code" IS 'agent英文名 - agent唯一标识';
COMMENT ON COLUMN "t_sev_agent_info"."agent_name" IS 'agent中文名，设备名称，默认设备IP';
COMMENT ON COLUMN "t_sev_agent_info"."agent_ip" IS 'agent地址，设备IP';
COMMENT ON COLUMN "t_sev_agent_info"."agent_ip_num" IS 'IP地址统一转16进制字符串';
COMMENT ON COLUMN "t_sev_agent_info"."agent_type" IS 'agent类型（AiNTA、APT、SOC）';
COMMENT ON COLUMN "t_sev_agent_info"."machine_code" IS '机器码';
COMMENT ON COLUMN "t_sev_agent_info"."device_model" IS '设备型号';
COMMENT ON COLUMN "t_sev_agent_info"."soft_version" IS '程序版本';
COMMENT ON COLUMN "t_sev_agent_info"."rule_version" IS '规则版本';
COMMENT ON COLUMN "t_sev_agent_info"."intelligence_version" IS '情报库版本';
COMMENT ON COLUMN "t_sev_agent_info"."config_version" IS '探针设备的配置版本号，时间戳';
COMMENT ON COLUMN "t_sev_agent_info"."single_login_uri" IS '单点登录的地址';
COMMENT ON COLUMN "t_sev_agent_info"."status" IS '程序状态';
COMMENT ON COLUMN "t_sev_agent_info"."org_id" IS '组织id';
COMMENT ON COLUMN "t_sev_agent_info"."regist_time" IS '注册时间';
COMMENT ON COLUMN "t_sev_agent_info"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_sev_agent_info"."upgrade_log_id" IS '升级记录id';
COMMENT ON TABLE "t_sev_agent_info" IS '探针信息表';

-- ----------------------------
-- Records of t_sev_agent_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_sev_agent_license
-- ----------------------------
DROP TABLE IF EXISTS "t_sev_agent_license";
CREATE TABLE "t_sev_agent_license" (
  "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_license_id_seq'::regclass),
  "agent_code" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
  "license_code" text COLLATE "pg_catalog"."default",
  "product_sn" varchar(256) COLLATE "pg_catalog"."default",
  "file_name" varchar(256) COLLATE "pg_catalog"."default",
  "license_type" int4,
  "version" int8 NOT NULL DEFAULT '0'::bigint,
  "expire_time" date NOT NULL,
  "file_uuid" varchar(64) COLLATE "pg_catalog"."default",
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp
)
;
ALTER TABLE "t_sev_agent_license" OWNER TO "dbapp";
COMMENT ON COLUMN "t_sev_agent_license"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_license"."agent_code" IS 'agent唯一标识';
COMMENT ON COLUMN "t_sev_agent_license"."license_code" IS '许可申请内容(新) 许可申请码(老)';
COMMENT ON COLUMN "t_sev_agent_license"."product_sn" IS '产品序列号';
COMMENT ON COLUMN "t_sev_agent_license"."file_name" IS '申请文件名';
COMMENT ON COLUMN "t_sev_agent_license"."license_type" IS '合同类型，0：试用；1：正式';
COMMENT ON COLUMN "t_sev_agent_license"."version" IS '许可版本号，自增序列，每次更新+1';
COMMENT ON COLUMN "t_sev_agent_license"."expire_time" IS '许可证到期时间';
COMMENT ON COLUMN "t_sev_agent_license"."file_uuid" IS '许可文件uuid';
COMMENT ON COLUMN "t_sev_agent_license"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_sev_agent_license"."update_time" IS '更新时间';
COMMENT ON TABLE "t_sev_agent_license" IS '探针许可文件信息表';

-- ----------------------------
-- Records of t_sev_agent_license
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_sev_agent_monitor
-- ----------------------------
DROP TABLE IF EXISTS "t_sev_agent_monitor";
CREATE TABLE "t_sev_agent_monitor" (
  "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_monitor_id_seq'::regclass),
  "agent_code" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
  "agent_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "cpu_usage" float8,
  "memory_total" float8,
  "memory_use" float8,
  "disk_total" float8,
  "disk_use" float8,
  "metric1" float8,
  "metric2" float8,
  "metric3" float8,
  "create_time" timestamp
)
;
ALTER TABLE "t_sev_agent_monitor" OWNER TO "dbapp";
COMMENT ON COLUMN "t_sev_agent_monitor"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_monitor"."agent_code" IS 'agent唯一标识';
COMMENT ON COLUMN "t_sev_agent_monitor"."cpu_usage" IS 'CPU使用率，百分制';
COMMENT ON COLUMN "t_sev_agent_monitor"."memory_total" IS '内存总量，单位B';
COMMENT ON COLUMN "t_sev_agent_monitor"."memory_use" IS '内存使用量，单位B';
COMMENT ON COLUMN "t_sev_agent_monitor"."disk_total" IS '磁盘总量，单位B';
COMMENT ON COLUMN "t_sev_agent_monitor"."disk_use" IS '磁盘使用量，单位B';
COMMENT ON COLUMN "t_sev_agent_monitor"."metric1" IS 'AiNTA：日志量(eps)；APT：已检测文件数量(个)';
COMMENT ON COLUMN "t_sev_agent_monitor"."metric2" IS 'AiNTA：流量(bps)；APT，待检测文件数量(个)';
COMMENT ON COLUMN "t_sev_agent_monitor"."metric3" IS 'AiNTA：本日日志数；APT：本日已检测文件数(个)';
COMMENT ON COLUMN "t_sev_agent_monitor"."create_time" IS '记录时间';
COMMENT ON TABLE "t_sev_agent_monitor" IS '探针监控表';

-- ----------------------------
-- Records of t_sev_agent_monitor
-- ----------------------------
BEGIN;
COMMIT;

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
-- Records of t_sev_agent_config
-- ----------------------------
BEGIN;
COMMIT;