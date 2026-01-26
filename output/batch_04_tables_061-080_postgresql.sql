-- ====================================================================================================
-- PostgreSQL Migration Script
-- Converted from MySQL using automated migration tool
-- Source: bigdata-web-data.sql
-- Target Database: PostgreSQL 16.x
-- Generated: 2026-01-14 19:13:24
-- ====================================================================================================

-- Set client encoding
SET client_encoding = 'UTF8';

-- Disable foreign key checks during migration
SET session_replication_role = 'replica';


DROP TABLE IF EXISTS "t_bs_apikey";
CREATE TABLE "t_bs_apikey"  (
  "id" BIGSERIAL,
  "user_id" BIGINT NOT NULL,
  "name" VARCHAR(100)   NOT NULL,
  "apikey" VARCHAR(255)   NOT NULL,
  "expire_time" BIGINT NOT NULL,
  "remark" text   NULL,
  "is_factory" BOOLEAN NOT NULL DEFAULT 0,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
  CONSTRAINT "t_bs_apikey_FK" FOREIGN KEY ("user_id") REFERENCES "t_user" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
  INSERT INTO "t_bs_apikey" VALUES (4, 1, 'default', 'bb02fdc459cc8a364bde20ba3e37fc6e', 1862966270000, '默认', 0, '2026-01-13 10:37:50');

-- Indexes
CREATE INDEX "t_bs_apikey_FK" ON "t_bs_apikey" ("user_id");

-- Column comments
COMMENT ON COLUMN "t_bs_apikey"."id" IS '主键';
COMMENT ON COLUMN "t_bs_apikey"."user_id" IS '用户id';
COMMENT ON COLUMN "t_bs_apikey"."name" IS '名称，用于日志记录、流量控制';
COMMENT ON COLUMN "t_bs_apikey"."apikey" IS 'apiKey';
COMMENT ON COLUMN "t_bs_apikey"."expire_time" IS 'apiKey超时时间';
COMMENT ON COLUMN "t_bs_apikey"."remark" IS '备注';
COMMENT ON COLUMN "t_bs_apikey"."is_factory" IS '是否默认出厂apiKey';
COMMENT ON COLUMN "t_bs_apikey"."create_time" IS '创建时间';


DROP TABLE IF EXISTS "t_bs_es_index";
CREATE TABLE "t_bs_es_index"  (
  "id" BIGSERIAL,
  "index_name" VARCHAR(128)   NULL DEFAULT NULL,
  "index_alias" VARCHAR(128)   NULL DEFAULT NULL,
  "indexing" BOOLEAN NULL DEFAULT 0,
  "time_begin" BIGINT NULL DEFAULT 0,
  "time_end" BIGINT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "index_name" ON "t_bs_es_index" ("index_name");

-- Column comments
COMMENT ON COLUMN "t_bs_es_index"."index_name" IS '索引名称';
COMMENT ON COLUMN "t_bs_es_index"."index_alias" IS '索引别名';
COMMENT ON COLUMN "t_bs_es_index"."indexing" IS '索引是否正在被写入';
COMMENT ON COLUMN "t_bs_es_index"."time_begin" IS '存储时间起始';
COMMENT ON COLUMN "t_bs_es_index"."time_end" IS '存储时间终止';


DROP TABLE IF EXISTS "t_bs_extension_history";
CREATE TABLE "t_bs_extension_history"  (
  "id" BIGSERIAL,
  "code" VARCHAR(150)   NOT NULL,
  "name" VARCHAR(150)   NOT NULL,
  "last_version" VARCHAR(100)   NULL DEFAULT NULL,
  "version" VARCHAR(100)   NOT NULL,
  "operate_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "operate_type" VARCHAR(32)   NOT NULL,
  "is_success" BOOLEAN NOT NULL,
  "result" text   NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE INDEX "t_bs_extension_history_FK" ON "t_bs_extension_history" ("code");

-- Column comments
COMMENT ON COLUMN "t_bs_extension_history"."id" IS '主键';
COMMENT ON COLUMN "t_bs_extension_history"."code" IS 'Extension英文名';
COMMENT ON COLUMN "t_bs_extension_history"."name" IS 'Extension中文名';
COMMENT ON COLUMN "t_bs_extension_history"."last_version" IS '历史版本';
COMMENT ON COLUMN "t_bs_extension_history"."version" IS '操作时版本';
COMMENT ON COLUMN "t_bs_extension_history"."operate_time" IS '操作时间';
COMMENT ON COLUMN "t_bs_extension_history"."operate_type" IS '操作类型，install:安装,upgrade:升级,uninstall:卸载';
COMMENT ON COLUMN "t_bs_extension_history"."is_success" IS '操作是否成功';
COMMENT ON COLUMN "t_bs_extension_history"."result" IS '操作结果信息';


DROP TABLE IF EXISTS "t_bs_extension_info";
CREATE TABLE "t_bs_extension_info"  (
  "id" BIGSERIAL,
  "code" VARCHAR(150)   NOT NULL,
  "name" VARCHAR(150)   NOT NULL,
  "description" VARCHAR(4096)   NULL DEFAULT NULL,
  "install_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "version" VARCHAR(100)   NOT NULL,
  "docker_id" VARCHAR(150)   NOT NULL,
  "deploy_path" VARCHAR(1024)   NOT NULL,
  "main_class" VARCHAR(150)   NOT NULL,
  "status" VARCHAR(100)   NOT NULL,
  "meta_info" text   NULL,
  "is_success" BOOLEAN NOT NULL,
  "result" text   NULL,
  "preinstall" BOOLEAN NOT NULL,
  "port" INTEGER NOT NULL,
  "authorization" INTEGER NULL DEFAULT 1,
  "modify_time" TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "t_bs_extension_info_UN" ON "t_bs_extension_info" ("code");

-- Column comments
COMMENT ON COLUMN "t_bs_extension_info"."id" IS '主键';
COMMENT ON COLUMN "t_bs_extension_info"."code" IS 'Extension英文名';
COMMENT ON COLUMN "t_bs_extension_info"."name" IS 'Extension中文名';
COMMENT ON COLUMN "t_bs_extension_info"."description" IS 'Extension描述';
COMMENT ON COLUMN "t_bs_extension_info"."install_time" IS '首次安装时间';
COMMENT ON COLUMN "t_bs_extension_info"."update_time" IS '最近一次更新时间';
COMMENT ON COLUMN "t_bs_extension_info"."version" IS '当前版本';
COMMENT ON COLUMN "t_bs_extension_info"."docker_id" IS '部署容器id';
COMMENT ON COLUMN "t_bs_extension_info"."deploy_path" IS '部署路径';
COMMENT ON COLUMN "t_bs_extension_info"."main_class" IS '启动类';
COMMENT ON COLUMN "t_bs_extension_info"."status" IS '状态，running:运行中，stopped:已停用，installing:安装中，restarting:重启中，uninstalling:卸载中，starting:启动中，stopping:停用中，failure:操作失败';
COMMENT ON COLUMN "t_bs_extension_info"."meta_info" IS '其他元数据，json格式存储';
COMMENT ON COLUMN "t_bs_extension_info"."is_success" IS '最后一次操作结果';
COMMENT ON COLUMN "t_bs_extension_info"."result" IS '最后一次操作结果描述';
COMMENT ON COLUMN "t_bs_extension_info"."preinstall" IS '是否为内置拓展';
COMMENT ON COLUMN "t_bs_extension_info"."port" IS '拓展程序服务端口号';
COMMENT ON COLUMN "t_bs_extension_info"."authorization" IS '授权：默认全授权1，未授权0';
COMMENT ON COLUMN "t_bs_extension_info"."modify_time" IS '数据更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_bs_extension_info_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."modify_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_bs_extension_info_update_timestamp
BEFORE UPDATE ON "t_bs_extension_info"
FOR EACH ROW
EXECUTE FUNCTION update_t_bs_extension_info_timestamp();


DROP TABLE IF EXISTS "t_bs_files";
CREATE TABLE "t_bs_files"  (
  "uuid" VARCHAR(64)   NOT NULL,
  "module" VARCHAR(255)   NOT NULL,
  "file_path" VARCHAR(1024)   NOT NULL,
  "file_name" VARCHAR(255)   NOT NULL,
  "file_size" BIGINT NOT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("uuid")
);

-- Column comments
COMMENT ON COLUMN "t_bs_files"."uuid" IS '主键，文件uuid';
COMMENT ON COLUMN "t_bs_files"."module" IS '业务模块，逗号分隔，多层存储';
COMMENT ON COLUMN "t_bs_files"."file_path" IS '文件路径';
COMMENT ON COLUMN "t_bs_files"."file_name" IS '文件名';
COMMENT ON COLUMN "t_bs_files"."file_size" IS '文件大小';
COMMENT ON COLUMN "t_bs_files"."create_time" IS '创建时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_bs_files_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."create_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_bs_files_update_timestamp
BEFORE UPDATE ON "t_bs_files"
FOR EACH ROW
EXECUTE FUNCTION update_t_bs_files_timestamp();


DROP TABLE IF EXISTS "t_bs_knowledge";
CREATE TABLE "t_bs_knowledge"  (
  "id" BIGSERIAL,
  "alarmTag" VARCHAR(255)   NOT NULL,
  "summary" text   NULL,
  "fileName" VARCHAR(255)   NULL DEFAULT NULL,
  "create_time" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "IDX_UN_ALARM_TAG" ON "t_bs_knowledge" ("alarmTag");
CREATE INDEX "IDX_CREATE_TIME" ON "t_bs_knowledge" ("create_time");

-- Column comments
COMMENT ON COLUMN "t_bs_knowledge"."id" IS '主键';
COMMENT ON COLUMN "t_bs_knowledge"."alarmTag" IS '唯一标识';
COMMENT ON COLUMN "t_bs_knowledge"."summary" IS '摘要';
COMMENT ON COLUMN "t_bs_knowledge"."fileName" IS '知识库文件';
COMMENT ON COLUMN "t_bs_knowledge"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_bs_knowledge"."update_time" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_bs_knowledge_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_bs_knowledge_update_timestamp
BEFORE UPDATE ON "t_bs_knowledge"
FOR EACH ROW
EXECUTE FUNCTION update_t_bs_knowledge_timestamp();


DROP TABLE IF EXISTS "t_bs_message_type";
CREATE TABLE "t_bs_message_type"  (
  "message_type" VARCHAR(100)   NOT NULL,
  "message_type_name" VARCHAR(150)   NOT NULL,
  "parent_message_type" VARCHAR(100)   NOT NULL DEFAULT 'root',
  "message_level" VARCHAR(32)   NULL DEFAULT NULL,
  "role_type" VARCHAR(100)   NULL DEFAULT NULL,
  "is_default" BOOLEAN NOT NULL DEFAULT 0,
  "is_config_type" BOOLEAN NOT NULL DEFAULT 0,
  "is_check_type" BOOLEAN NOT NULL DEFAULT 0,
  "is_inhibition" BOOLEAN NOT NULL DEFAULT 0,
  "show_type" VARCHAR(100)   NOT NULL DEFAULT '0',
  "sort" INTEGER NULL DEFAULT NULL,
  "ext_code" VARCHAR(30)   NULL DEFAULT NULL,
  "enable" BOOLEAN NULL DEFAULT 1,
  "link" VARCHAR(150)   NULL DEFAULT NULL,
  "link_type" VARCHAR(100)   NULL DEFAULT NULL,
  PRIMARY KEY ("message_type")
);

-- Column comments
COMMENT ON COLUMN "t_bs_message_type"."message_type" IS '消息类型';
COMMENT ON COLUMN "t_bs_message_type"."message_type_name" IS '消息类型名称';
COMMENT ON COLUMN "t_bs_message_type"."parent_message_type" IS '消息父类型';
COMMENT ON COLUMN "t_bs_message_type"."message_level" IS '消息级别，high：高；middle：中；low：低';
COMMENT ON COLUMN "t_bs_message_type"."role_type" IS '消息权限对象，normal：普通消息；dataAuth：数据权限，和安全域相关；userOnly：仅订阅用户可见；specifiedUser：指定用户接收';
COMMENT ON COLUMN "t_bs_message_type"."is_default" IS '是否默认订阅';
COMMENT ON COLUMN "t_bs_message_type"."is_config_type" IS '是否配置类';
COMMENT ON COLUMN "t_bs_message_type"."is_check_type" IS '是否检查类';
COMMENT ON COLUMN "t_bs_message_type"."is_inhibition" IS '是否可抑制';
COMMENT ON COLUMN "t_bs_message_type"."show_type" IS '首页展示类型';
COMMENT ON COLUMN "t_bs_message_type"."sort" IS '排序';
COMMENT ON COLUMN "t_bs_message_type"."ext_code" IS '拓展code';
COMMENT ON COLUMN "t_bs_message_type"."enable" IS '是否启用(0不启用,1启用)';
COMMENT ON COLUMN "t_bs_message_type"."link" IS '跳转链接';
COMMENT ON COLUMN "t_bs_message_type"."link_type" IS '跳转类型(立即查看/立即处理/完善剧本)';


DROP TABLE IF EXISTS "t_bs_user_subscribe_config";
CREATE TABLE "t_bs_user_subscribe_config"  (
  "id" BIGSERIAL,
  "user_id" BIGINT NOT NULL,
  "subscribe_type" VARCHAR(32)   NOT NULL,
  "message_type" VARCHAR(100)   NOT NULL,
  "custom_config" text   NULL,
  "is_subscribe" BOOLEAN NOT NULL DEFAULT 0,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "t_bs_user_subscribe_config_UN" ON "t_bs_user_subscribe_config" ("user_id", "subscribe_type", "message_type");
CREATE INDEX "t_bs_user_subscribe_config_FK" ON "t_bs_user_subscribe_config" ("message_type");
CREATE INDEX "t_bs_user_subscribe_config_FK_1" ON "t_bs_user_subscribe_config" ("subscribe_type");

-- Column comments
COMMENT ON COLUMN "t_bs_user_subscribe_config"."id" IS '主键';
COMMENT ON COLUMN "t_bs_user_subscribe_config"."user_id" IS '用户id';
COMMENT ON COLUMN "t_bs_user_subscribe_config"."subscribe_type" IS '订阅类型，robot：机器人；sms：短信；email：邮件；ding：钉钉';
COMMENT ON COLUMN "t_bs_user_subscribe_config"."message_type" IS '消息类型';
COMMENT ON COLUMN "t_bs_user_subscribe_config"."custom_config" IS '订阅自定义配置，json格式存储';
COMMENT ON COLUMN "t_bs_user_subscribe_config"."is_subscribe" IS '是否订阅';
COMMENT ON COLUMN "t_bs_user_subscribe_config"."create_time" IS '创建时间';


DROP TABLE IF EXISTS "t_center_model";
CREATE TABLE "t_center_model"  (
  "id" SERIAL,
  "pid" INTEGER NOT NULL,
  "model" VARCHAR(45)   NOT NULL,
  "authorization" INTEGER NOT NULL DEFAULT 1,
  "describe" VARCHAR(500)   NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "model_id" VARCHAR(45)   NOT NULL,
  "optional" INTEGER NOT NULL DEFAULT 0,
  "version" VARCHAR(45)   NOT NULL DEFAULT 'v3.4',
  PRIMARY KEY ("id", "pid")
);
  INSERT INTO "t_center_model" VALUES (1, 1, 'AiLPHA Baas 安全大数据', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_1', 0, 'v3.5');,
  INSERT INTO "t_center_model" VALUES (2, 1, 'Modern SIEM 安全建模中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_2', 0, 'v3.5');,
  INSERT INTO "t_center_model" VALUES (3, 1, 'Investigation 调查取证中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_3', 0, 'v3.5');,
  INSERT INTO "t_center_model" VALUES (4, 1, '资产与风险管理中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_4', 0, 'v3.1');,
  INSERT INTO "t_center_model" VALUES (5, 1, '态势感知中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_5', 0, 'v3.4');,
  INSERT INTO "t_center_model" VALUES (6, 1, 'Sherlock 威胁狩猎中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_6', 0, 'v3.5');,
  INSERT INTO "t_center_model" VALUES (7, 1, 'SOAR 编排响应中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_7', 1, 'v3.5');,
  INSERT INTO "t_center_model" VALUES (8, 1, 'UEBA 基础版', 0, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_8', 1, 'v3.1');,
  INSERT INTO "t_center_model" VALUES (9, 1, '可视化报告中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_9', 0, 'v3.0');,
  INSERT INTO "t_center_model" VALUES (10, 1, '威胁情报中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_10', 0, 'v2.3');,
  INSERT INTO "t_center_model" VALUES (11, 1, '安全运营中心', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_11', 1, 'v3.4');,
  INSERT INTO "t_center_model" VALUES (12, 1, '重大保障指挥中心', 0, '0', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_12', 1, 'v3.4');,
  INSERT INTO "t_center_model" VALUES (13, 1, '安管绩效考核', 0, '0', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_13', 1, 'v3.4');,
  INSERT INTO "t_center_model" VALUES (14, 1, '多租户', 1, '1', '2026-01-13 10:37:42', '2026-01-13 10:37:42', '1_14', 0, 'v3.4');,
  INSERT INTO "t_center_model" VALUES (15, 2, 'AiView 可视化组件', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '2_1', 0, 'v1.3');,
  INSERT INTO "t_center_model" VALUES (16, 2, 'AiView 大屏设计器', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '2_2', 0, 'v1.3');,
  INSERT INTO "t_center_model" VALUES (17, 2, 'AiView 演示控制器', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '2_3', 0, 'v1.3');,
  INSERT INTO "t_center_model" VALUES (18, 2, 'AiView 数据源管理', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '2_4', 0, 'v1.3');,
  INSERT INTO "t_center_model" VALUES (19, 3, 'UBA 用户行为分析画像', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '3_1', 0, 'v1.0');,
  INSERT INTO "t_center_model" VALUES (20, 3, 'DSI 深度感知智能引擎', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '3_2', 0, 'v1.0');,
  INSERT INTO "t_center_model" VALUES (21, 4, '资产发现引擎', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '4_1', 0, 'v1.0');,
  INSERT INTO "t_center_model" VALUES (22, 4, '漏洞生命周期管理', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '4_2', 0, 'v1.0');,
  INSERT INTO "t_center_model" VALUES (23, 4, '基线生命周期管理', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '4_3', 0, 'v1.0');,
  INSERT INTO "t_center_model" VALUES (24, 5, '情报与资讯', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '5_1', 0, 'v1.0');,
  INSERT INTO "t_center_model" VALUES (25, 5, '情报检索中心', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '5_2', 0, 'v1.0');,
  INSERT INTO "t_center_model" VALUES (26, 5, '本地情报管理', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '5_3', 0, 'v1.0');,
  INSERT INTO "t_center_model" VALUES (27, 5, '云端情报管理', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', '5_4', 0, 'v1.0');,
  INSERT INTO "t_center_model" VALUES (99, 27, '安全验证', 1, NULL, '2023-02-01 15:31:20', '2023-02-01 15:31:20', '27_1', 1, 'v2.0.5');

-- Indexes
CREATE UNIQUE INDEX "name_UNIQUE" ON "t_center_model" ("model");

-- Column comments
COMMENT ON COLUMN "t_center_model"."pid" IS '产品的id';
COMMENT ON COLUMN "t_center_model"."model" IS '最新产品的模块名称';
COMMENT ON COLUMN "t_center_model"."authorization" IS '授权：1包含；0不包含';
COMMENT ON COLUMN "t_center_model"."model_id" IS '模块id和平台保持一致。';
COMMENT ON COLUMN "t_center_model"."optional" IS '是否可选：0不可选，1可选';


DROP TABLE IF EXISTS "t_center_product";
CREATE TABLE "t_center_product"  (
  "id" SERIAL,
  "name" VARCHAR(128)   NOT NULL,
  "type" INTEGER NOT NULL DEFAULT 1,
  "describe" VARCHAR(500)   NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "stats" INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_center_product" VALUES (1, 'AiLPHA 安全分析与管理平台', 0, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', 1);,
  INSERT INTO "t_center_product" VALUES (2, 'AiView 数据可视化中心', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', 1);,
  INSERT INTO "t_center_product" VALUES (3, 'AiLPHA UBA 用户行为画像中心', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', 0);,
  INSERT INTO "t_center_product" VALUES (4, 'AiLPHA 弱点管理中心', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', 0);,
  INSERT INTO "t_center_product" VALUES (5, 'AiLPHA TIP 情报管理中心', 1, NULL, '2026-01-13 10:37:42', '2026-01-13 10:37:42', 0);,
  INSERT INTO "t_center_product" VALUES (6, 'AiCloud 云端研判', 1, NULL, '2026-01-13 10:37:47', '2026-01-13 10:37:47', 1);

-- Indexes
CREATE UNIQUE INDEX "name_UNIQUE" ON "t_center_product" ("name");

-- Column comments
COMMENT ON COLUMN "t_center_product"."name" IS '产品名称';
COMMENT ON COLUMN "t_center_product"."type" IS '产品类型:平台0，APP1';
COMMENT ON COLUMN "t_center_product"."stats" IS '状态：1可用；0不可用';


DROP TABLE IF EXISTS "t_common_config";
CREATE TABLE "t_common_config"  (
  "id" SERIAL,
  "prefix" VARCHAR(45)   NOT NULL,
  "configKey" VARCHAR(45)   NOT NULL,
  "configValue" VARCHAR(20000)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_common_config" VALUES (1, 'asset', 'soc.sync.enable', '1');,
  INSERT INTO "t_common_config" VALUES (2, 'asset', 'flaw.sync.enable', '1');,
  INSERT INTO "t_common_config" VALUES (3, 'asset', 'auto.sync.enable', '1');,
  INSERT INTO "t_common_config" VALUES (5, 'web', 'auto.web.enable', '0');,
  INSERT INTO "t_common_config" VALUES (6, 'web', 'auto.web.area', '0');,
  INSERT INTO "t_common_config" VALUES (7, 'web', 'auto.web.type', '0');,
  INSERT INTO "t_common_config" VALUES (8, 'edr', 'edr.sync.enable', '0');,
  INSERT INTO "t_common_config" VALUES (9, 'ailpha', 'version.update.time', '2026-01-13 10:37:43');,
  INSERT INTO "t_common_config" VALUES (10, 'style', 'title', 'AiLPHA安全分析与管理平台');,
  INSERT INTO "t_common_config" VALUES (11, 'style', 'color', '');,
  INSERT INTO "t_common_config" VALUES (12, 'style', 'logo', '/oem/headerLogo.png,/oem/layoutLogo.png');,
  INSERT INTO "t_common_config" VALUES (13, 'style', 'screenlogo', 'default');,
  INSERT INTO "t_common_config" VALUES (14, 'style', 'companyname', '杭州安恒信息技术股份有限公司');,
  INSERT INTO "t_common_config" VALUES (15, 'style', 'techsupport', '安恒 AiLPHA BaaS 提供计算服务');,
  INSERT INTO "t_common_config" VALUES (16, 'origin', 'title', 'AiLPHA安全分析与管理平台');,
  INSERT INTO "t_common_config" VALUES (17, 'origin', 'color', '');,
  INSERT INTO "t_common_config" VALUES (18, 'origin', 'logo', '/oem/headerLogo.png,/oem/layoutLogo.png');,
  INSERT INTO "t_common_config" VALUES (19, 'origin', 'companyname', '杭州安恒信息技术股份有限公司');,
  INSERT INTO "t_common_config" VALUES (20, 'origin', 'techsupport', '安恒 AiLPHA BaaS 提供计算服务');,
  INSERT INTO "t_common_config" VALUES (21, 'origin', 'screenlogo', 'default');,
  INSERT INTO "t_common_config" VALUES (22, 'order', 'order.auto.send.responsible', '0');,
  INSERT INTO "t_common_config" VALUES (28, 'sty', 'accessKey', 'f6feadca-38c9-471e-ba9f-fcd3eefddfbc');,
  INSERT INTO "t_common_config" VALUES (29, 'sty', 'secretKey', 'f6fsdfaca-40c9-871e-ba9f-fcd3eefdabcd');,
  INSERT INTO "t_common_config" VALUES (30, 'apikey', 'secure', 'apiTrustByDelin');,
  INSERT INTO "t_common_config" VALUES (31, 'dasca-dbappsecurity-ainta', 'accessKey', '1cf2bb1de1024a94140a9d7f8597c0ba');,
  INSERT INTO "t_common_config" VALUES (32, 'dasca-dbappsecurity-ainta', 'accessKeySecret', 'birlovoidv9S+iu45cuhfPo0g3p1J3fI3gYDGgywz6uPZRqpDW4+nspxGN8UGw6INulCihseo+Iro2xCRwnU7klt6yFY0fWTeuRQmwhPbJSdB65UHWYchjC1iQwjuv1u/ZAYqO96SJpkJhC+e0eP9A46jCo0pInQn626cOqYQzCutcbNTd7eHxUpxnC0FgsM8+TeNXB4yzaohrcg+sRcxzpW+Ugo9GptLUJfZTLkMUyNI+5GcqWJajFVozKD14L4iYUpVTEStANcf7RbPx0mOkxcsOIrCQkrJFE2NC3OWPD6L0LwPJKUQQyXfE6x4GNMCmuwv6GIvq36Xl1pmrX/fQ==');,
  INSERT INTO "t_common_config" VALUES (35, 'ailpha.cloud.access.default', 'ASE_KEY', 'SkWrZ;9A#jHc(N_6');,
  INSERT INTO "t_common_config" VALUES (36, 'ailpha.cloud.access.default', 'IV_KEY', 's5YHnw8z#U]kB;.0');,
  INSERT INTO "t_common_config" VALUES (37, 'ailpha.cloud.access.default', 'FILLING_MODE', 'AES/CBC/PKCS5Padding');,
  INSERT INTO "t_common_config" VALUES (38, 'baas', 'baas.admin.username', 'admin');,
  INSERT INTO "t_common_config" VALUES (39, 'baas', 'baas.admin.password', 'b!o3jraZ4a');,
  INSERT INTO "t_common_config" VALUES (40, 'aigent', 'aigent_api_key', '6cb6a5442d0f4030b6100e8869a4d153');,
  INSERT INTO "t_common_config" VALUES (41, 'default.password', 'admin', 'iS%4Rh37g3');,
  INSERT INTO "t_common_config" VALUES (42, 'default.password', 'userAdmin', 'iS%4Rh37g3');,
  INSERT INTO "t_common_config" VALUES (43, 'default.password', 'opAdmin', 'iS%4Rh37g3');,
  INSERT INTO "t_common_config" VALUES (44, 'default.password', 'ailpha', 'F@Jhq5GyW7');,
  INSERT INTO "t_common_config" VALUES (45, 'default.password', 'simpleUser', 'do*JKfn7PK');,
  INSERT INTO "t_common_config" VALUES (46, 'baas.admin', 'username', 'admin');,
  INSERT INTO "t_common_config" VALUES (47, 'baas.admin', 'password', 'b!o3jraZ4a');,
  INSERT INTO "t_common_config" VALUES (48, 'waf', 'token', 'dbapp-ailpha-3fd110f82c76fb8e48ce6b6493102ec5');,
  INSERT INTO "t_common_config" VALUES (49, 'ailpha.cloud.access.default', 'key', 'a1ac51403f2bd5ec26bc296edd2fb8c2');,
  INSERT INTO "t_common_config" VALUES (50, 'ailpha.cloud.access.default', 'secret', 'bd49b489c27e2e7e1ad8576181306f2f91137822c1a06d0c0aa74912930b52b1');,
  INSERT INTO "t_common_config" VALUES (51, 'dasca.access', 'key', 'a429561d31b54a37814141de9d2d823c');,
  INSERT INTO "t_common_config" VALUES (52, 'default.password', 'ssh', '1qazcde3!@#');,
  INSERT INTO "t_common_config" VALUES (53, 'secure', 'ase.key', 'SkWrZ;9A#jHc(N_6');,
  INSERT INTO "t_common_config" VALUES (54, 'secure', 'iv.key', 's5YHnw8z#U]kB;.0');,
  INSERT INTO "t_common_config" VALUES (55, 'baas', 'apikey', 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTU3NjMxMjc1M30.ptGyiP75SXrkbJ4m9RYy2AtqMQHuxWI9Bi4-lebuzC0AL65gl0BF7v289Eayu7IeiX2CM9SV1WEIsPNbpj0_lQ');,
  INSERT INTO "t_common_config" VALUES (66, 'kibana', 'user', 'admin');,
  INSERT INTO "t_common_config" VALUES (67, 'kibana', 'cipher', 'unFx7%EbR3');,
  INSERT INTO "t_common_config" VALUES (68, 'kibana', 'version', '6.8.0');,
  INSERT INTO "t_common_config" VALUES (69, 'user.data.acquisition.file', 'password', 'v58a$2nT6C');,
  INSERT INTO "t_common_config" VALUES (70, 'update.knowledge.zip', 'password', 'ePb%R7XW#$');,
  INSERT INTO "t_common_config" VALUES (71, 'ailpha.connect', 'key', 'WVdsc2NHaGhYMlJsZG05d2N3bz0K');,
  INSERT INTO "t_common_config" VALUES (72, 'update.rule.zip', 'password', 'ePb%R7XW#$');,
  INSERT INTO "t_common_config" VALUES (73, 'ailpha.unzip', 'cipher', 'ePb%R7XW#$');,
  INSERT INTO "t_common_config" VALUES (74, 'xdr.package.unzip', 'password', 'ePb%R7XW#$');,
  INSERT INTO "t_common_config" VALUES (75, 'AiNTA.api', 'key', 'DFSraR8JUvoVSvIcGMgdMjlAUjXyX18LTPglj4zWEGM=');,
  INSERT INTO "t_common_config" VALUES (76, 'ambari', 'passwd', 'bTxUv7rGU*');,
  INSERT INTO "t_common_config" VALUES (77, 'crypt', 'key', 'security_service');,
  INSERT INTO "t_common_config" VALUES (78, 'intelligence.centre', 'username', 'ailpha');,
  INSERT INTO "t_common_config" VALUES (79, 'intelligence.centre', 'cipher', 'c53083d80193b3929cd2d6d7c766e288');,
  INSERT INTO "t_common_config" VALUES (80, 'ioa.engine.zip', 'password', '4*K1woCwc1zna-zQ');,
  INSERT INTO "t_common_config" VALUES (81, 'update.aigent.zip', 'password', 'ePb%R7XW#$');,
  INSERT INTO "t_common_config" VALUES (82, 'snmp.pwd', 'aes.key', 'SkWrZ;9A#jHc(N_6');,
  INSERT INTO "t_common_config" VALUES (83, 'snmp.pwd', 'iv.key', 's5YHnw8z#U]kB;.0');,
  INSERT INTO "t_common_config" VALUES (84, 'baas', 'baas.admin.password.new', '70d26c7ff56237a12ed1c9000763aeeabc83db25');,
  INSERT INTO "t_common_config" VALUES (85, 'ailpha', 'v2.0.6.update.time', '2026-01-13 10:37:48');,
  INSERT INTO "t_common_config" VALUES (86, 'license', 'apt.private.key', 'MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJRGtA04Ue71r+OWsiAvXe0PD0wUBYQwjlzsidRPviuZMO47QaSEL4eb0sNE2c3yTIdjEa3w+FGFrVoaNuC8u6E7s+I5hquBvpJl8LZoVPCAQGHZ8fpr2Ss9aWEaC6Zrd2OLmTMgYzEKHZpKqkYVJwFaa1xMwwN0sHRfjNrdrFd5AgMBAAECgYAgu8sb8AcGfe6qi6YfPNW7c8uou/LLz/xdv0peOIx/C36l2ScQrq3ffiL1QMnkkU0bxl8syznGpYAzl/3tdzzkbhZoofqq/uRs6OF3nX2ldMAY+R/wXf3YwCbN64KHi/ieMRjlq8I32SVaGKl89Yu60PdBXUiyQZo5nxEuQx9/0QJBAP+i9ZIBpsWUDcCRrqKdhjGY+aOlVb94IJcOBKlDVKjq0N9PSxN6XC+NqZmNt55ZOUq8ok0XIhHC0YND+boC5jcCQQCUfKtkJwJxS1y0Z5XpJ0LpsteqAOK15RAQdZUppM5akzAM6k8E6eZq7QZ0mss1LnTQuafey2JfPUYesdFr5NfPAkB7WZ+TBzb4qVsFa4ZPsyDYd88ldpbsn8NiAAKhxfpo031b83/vcyBeVcXbcTWDs9vgQysxdZMb7Nx5sWgjqFh7AkABx1CCPZlg5AczPf5ksYyyoerFZYdRqHG90Lq9qfSyzwqHTRMvOuIAq+Ak62m9tFW/3klteMAv5dr+KSEaCr6vAkEA3Xa67LzDdNrRRYRU4yHfVFVn3uKDb8/dYHj36e2SPvzHFRxJ/cnNV1mpW1N16emPkhnyGMWppNoPAwD6er67Zw==');,
  INSERT INTO "t_common_config" VALUES (87, 'ah_brain', 'ah_brain_server', 'https://www.das-ai.com');,
  INSERT INTO "t_common_config" VALUES (88, 'ah_brain', 'ah_brain_appKey', 'OzlFyBdUjnFJNaR1BR3duD+1MH/qLdhY+PgYgwK9H5jW5ShCgFhOJg==');,
  INSERT INTO "t_common_config" VALUES (89, 'ah_brain', 'ah_brain_appSecret', 'XhmTVyCFZ5hTkJrpBrjgETVrfLsTmuQCxKPVxEewC/kp+2xyxrh8WSqBH9PJ4dBf');,
  INSERT INTO "t_common_config" VALUES (93, 'mss', 'openId', 'fd098fe6-195c-4aca-9963-da40729ad0cf');,
  INSERT INTO "t_common_config" VALUES (94, 'mss', 'secretKey', 'UyJzfDurBLuFIDVikEpeuKZGoeZuPpNkjChDnHsnrzbJurouFLvVyCdqHHnXiIqIlXNQocEhoSgYZfnQqbMkdAgwtOJKWESzYlvyyFOjZUrsIyMSzIGPnfqrqPWjVodA');,
  INSERT INTO "t_common_config" VALUES (95, 'mss', 'updateStatus', '1');,
  INSERT INTO "t_common_config" VALUES (98, 'init', 'ailpha_cloud_access', 'a1ac51403f2bd5ec26bc296edd2fb8c2:bd49b489c27e2e7e1ad8576181306f2f91137822c1a06d0c0aa74912930b52b1');,
  INSERT INTO "t_common_config" VALUES (102, 'ah_brain', 'filter-config-AutomaticJudge', '[{\"filterContent\":\"subCategory == \\\"/ConfigRisk/WeakPassword\\\" AND appProtocol != \\\"http\\\" AND alarmResults == \\\"OK\\\"\",\"judgeResult\":\"vulnerabilityExploitationSuccess\",\"type\":\"vulnerability\",\"updateTime\":\"2025-06-18 10:49:02\"},{\"filterContent\":\"alarmResults == \\\"OK\\\" AND subCategory == \\\"/WebAttack/BypassAccCtrl\\\"\",\"judgeResult\":\"vulnerabilityExploitationSuccess\",\"type\":\"vulnerability\",\"updateTime\":\"2025-06-18 10:49:02\"},{\"filterContent\":\"(alarmName == \\\"异常页面导致服务器路径泄漏\\\" OR alarmName == \\\"检测到目录启用了自动目录列表功能\\\") AND alarmResults == \\\"OK\\\"\",\"judgeResult\":\"vulnerabilityExploitationSuccess\",\"type\":\"vulnerability\",\"updateTime\":\"2025-06-18 10:49:02\"},{\"filterContent\":\"alarmResults == \\\"FAIL\\\"\",\"judgeResult\":\"attackFailure\",\"type\":\"attack\",\"updateTime\":\"2025-06-18 10:49:02\"},{\"filterContent\":\"category == \\\"/Scan\\\"\",\"judgeResult\":\"attackAttempt\",\"type\":\"attack\",\"updateTime\":\"2025-06-18 10:49:02\"},{\"filterContent\":\"transProtocol == \\\"TCP\\\" AND category == \\\"/Malware\\\" AND catOutcome == \\\"OK\\\" AND direction == \\\"01\\\"\",\"judgeResult\":\"attackSuccess\",\"type\":\"attack\",\"updateTime\":\"2025-06-18 10:49:02\"}]');,
  INSERT INTO "t_common_config" VALUES (103, 'ah_brain', 'filter-config-ActiveAttack', 'IoC notexist or ( IoC exist AND processId exist )');,
  INSERT INTO "t_common_config" VALUES (104, 'ah_brain', 'filter-config-TiTimeSeries', 'IoC exist  AND processId notexist ');,
  INSERT INTO "t_common_config" VALUES (105, 'style', 'showTitle', 'true');,
  INSERT INTO "t_common_config" VALUES (106, 'style', 'show_title_changed', '0');,
  INSERT INTO "t_common_config" VALUES (107, 'ah_brain', 'ah_brain_analysis_agent_id', 'd6ab0e2a-1ed5-4e4f-a5ad-3c5999be5636');,
  INSERT INTO "t_common_config" VALUES (108, 'ah_brain', 'ah_brain_handler_agent_id', 'c6770766-9df7-46a9-973b-67e2b3d2c4dc');,
  INSERT INTO "t_common_config" VALUES (109, 'ah_brain', 'ah_brain_risk_agent_id', '9566d732-5af0-440e-be98-1936913badef');,
  INSERT INTO "t_common_config" VALUES (110, 'ah_brain', 'ah_brain_review_agent_id', '3f81ebde-53c2-4344-9cc1-bf13086ce6e1');,
  INSERT INTO "t_common_config" VALUES (111, 'ah_brain', 'ah_brain_detection_agent_id', '58931f05-2556-423e-92a8-6d2ae0cbaa46');

-- Indexes
CREATE UNIQUE INDEX "name_uni" ON "t_common_config" ("prefix", "configKey");

-- Column comments
COMMENT ON COLUMN "t_common_config"."id" IS '主键Id';
COMMENT ON COLUMN "t_common_config"."prefix" IS '分类';
COMMENT ON COLUMN "t_common_config"."configKey" IS '名称';


DROP TABLE IF EXISTS "t_component_update_record";
CREATE TABLE "t_component_update_record"  (
  "id" BIGSERIAL,
  "version" VARCHAR(100)   NOT NULL,
  "package_type" VARCHAR(20)   NOT NULL,
  "file_name" VARCHAR(150)   NOT NULL,
  "success" BOOLEAN NOT NULL,
  "error_message" text   NULL,
  "create_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "unique_version_package_type_file_name" ON "t_component_update_record" ("version", "package_type", "file_name");

-- Column comments
COMMENT ON COLUMN "t_component_update_record"."id" IS '主键ID';
COMMENT ON COLUMN "t_component_update_record"."version" IS 'mirror版本信息';
COMMENT ON COLUMN "t_component_update_record"."package_type" IS '升级包类型';
COMMENT ON COLUMN "t_component_update_record"."file_name" IS '升级包文件名';
COMMENT ON COLUMN "t_component_update_record"."success" IS '是否升级成功';
COMMENT ON COLUMN "t_component_update_record"."error_message" IS '错误信息';


DROP TABLE IF EXISTS "t_dashboard";
CREATE TABLE "t_dashboard"  (
  "id" VARCHAR(100)   NOT NULL,
  "boardName" VARCHAR(255)   NOT NULL,
  "boardDescribe" text   NULL,
  "updateTime" BIGINT NOT NULL,
  "isFactory" BIGINT NOT NULL,
  "layoutJson" text   NULL,
  "userName" VARCHAR(255)   NOT NULL,
  "state" SMALLINT NOT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_dashboard" VALUES ('0b7dac0c98377864', '护网实时监测', '护网实时监测报表', 1586248286020, 0, '{\"4-4-4@0\":[\"963cb774-740e-11ea-9d6c-024248760016\",\"c222db48-740e-11ea-9d6c-024248760016\",\"7f1d2176-740e-11ea-9d6c-024248760016\"],\"3-9@1\":[\"41b681e6-748b-11ea-9d6c-024248760016\",\"07d3663e-748e-11ea-9d6c-024248760016\"],\"3-9@2\":[\"caf2158f-74ad-11ea-9d6c-024248760016\",\"e5dbb68b-78a1-11ea-9d6c-024248760016\"],\"6-6@3\":[\"d94e7e21-78af-11ea-9d6c-024248760016\",\"2bbdbbac-74ac-11ea-9d6c-024248760016\"],\"12@4\":[\"acae5fcc-740e-11ea-9d6c-024248760016\"]}', 'admin', 1);,
  INSERT INTO "t_dashboard" VALUES ('650777ab9f675283', '内网安全威胁', '展示内网威胁信息，包括各种威胁的分布，和对目标地址的访问趋势，回连，挖矿，勒索等威胁的目标地址分布等信息', 1532312937361, 0, '{\"4-4-4@0\":[\"f47a59fb-8e1d-11e8-ad15-024248760016\",\"c7643c7a-8e1d-11e8-ad15-024248760016\",\"22f2e651-8e1e-11e8-ad15-024248760016\"],\"4-4-4@1\":[\"6b379605-8e1e-11e8-ad15-024248760016\",\"b41d420f-8e1e-11e8-ad15-024248760016\",\"e8f9301e-8e1e-11e8-ad15-024248760016\"],\"4-4-4@2\":[\"09f82a23-8e1f-11e8-ad15-024248760016\",\"2e158070-8e1f-11e8-ad15-024248760016\",\"52427d82-8e1f-11e8-ad15-024248760016\"]}', 'admin', 1);,
  INSERT INTO "t_dashboard" VALUES ('b6b19dd4ac263d12', '安全数据质量监控', '安全数据质量监控', 1585908711193, 0, '{\"8-4@0\":[\"4a4f3fc4-7575-11ea-9d6c-024248760016\",\"24579617-74af-11ea-9d6c-024248760016\"],\"4-4-4@1\":[\"f21bd775-7579-11ea-9d6c-024248760016\",\"af3bf562-7579-11ea-9d6c-024248760016\",\"0af41832-74af-11ea-9d6c-024248760016\"],\"4-8@2\":[\"c507b8bc-7579-11ea-9d6c-024248760016\",\"7f1d2176-740e-11ea-9d6c-024248760016\"]}', 'admin', 1);

-- Column comments
COMMENT ON COLUMN "t_dashboard"."id" IS '主键';
COMMENT ON COLUMN "t_dashboard"."boardName" IS '仪表盘名称';
COMMENT ON COLUMN "t_dashboard"."boardDescribe" IS '描述';
COMMENT ON COLUMN "t_dashboard"."updateTime" IS '更新时间';
COMMENT ON COLUMN "t_dashboard"."isFactory" IS '是否出厂';
COMMENT ON COLUMN "t_dashboard"."layoutJson" IS '布局结构';
COMMENT ON COLUMN "t_dashboard"."userName" IS '用户名';
COMMENT ON COLUMN "t_dashboard"."state" IS '状态';


DROP TABLE IF EXISTS "t_dashboard_order";
CREATE TABLE "t_dashboard_order"  (
  "id" BIGSERIAL,
  "boardOrder" text   NULL,
  "userName" VARCHAR(255)   NOT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_dashboard_order" VALUES (1, '650777ab9f675283,0b7dac0c98377864,b6b19dd4ac263d12', 'admin');

-- Column comments
COMMENT ON COLUMN "t_dashboard_order"."id" IS '主键';
COMMENT ON COLUMN "t_dashboard_order"."boardOrder" IS '顺序';
COMMENT ON COLUMN "t_dashboard_order"."userName" IS '用户名';


DROP TABLE IF EXISTS "t_data_dict";
CREATE TABLE "t_data_dict"  (
  "id" BIGSERIAL,
  "type" VARCHAR(32)   NOT NULL,
  "label" VARCHAR(32)   NOT NULL,
  "isdel" SMALLINT NOT NULL DEFAULT 1,
  "createuser" BIGINT NOT NULL,
  "createtime" TIMESTAMP NOT NULL,
  "updateuser" BIGINT NOT NULL,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE INDEX "idx_dict_type" ON "t_data_dict" ("type");

-- Column comments
COMMENT ON COLUMN "t_data_dict"."type" IS '类型';
COMMENT ON COLUMN "t_data_dict"."label" IS '显示值';
COMMENT ON COLUMN "t_data_dict"."isdel" IS '0:删除；1:正常';
COMMENT ON COLUMN "t_data_dict"."createuser" IS '创建人';
COMMENT ON COLUMN "t_data_dict"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_data_dict"."updateuser" IS '修改人';
COMMENT ON COLUMN "t_data_dict"."updatetime" IS '修改时间';


DROP TABLE IF EXISTS "t_default_intelligence_source_function";
CREATE TABLE "t_default_intelligence_source_function"  (
  "id" SERIAL,
  "intelligence_source_code" VARCHAR(100)   NOT NULL,
  "function" enum('ONLINE_UPDATE','OFFLINE_UPDATE','API_UPDATE','EXPORT','INTELLIGENCE_ADD','INTELLIGENCE_DELETE','INTELLIGENCE_MODIFY','INTELLIGENCE_RETRIEVE','INTELLIGENCE_RETRIEVE_BY_API','SETUP','MANAGE','REMOVE','CLONE')   NOT NULL,
  "name" VARCHAR(50)   NOT NULL,
  "type" enum('tab','button','operate')   NOT NULL,
  "enable" SMALLINT NOT NULL DEFAULT 1,
  "description" VARCHAR(4096)   NULL DEFAULT NULL,
  "config" TEXT   NULL,
  "operations" TEXT   NULL,
  "order" SMALLINT NOT NULL,
  "display" SMALLINT NOT NULL DEFAULT 1,
  PRIMARY KEY ("id")
  CONSTRAINT "foreign_key_default_function_to_source" FOREIGN KEY ("intelligence_source_code") REFERENCES "t_default_intelligence_source_metadata" ("code") ON DELETE CASCADE ON UPDATE CASCADE
);
  INSERT INTO "t_default_intelligence_source_function" VALUES (1, 'ThreatIntelligenceCentreSource', 'OFFLINE_UPDATE', '离线更新', 'tab', 1, '可通过以下方式获取威胁情报许可：\n1、导出许可申请文件\n2、登录安恒公司内网，将导出的申请文件发送 http://t.dbappsecurity.com.cn ，订阅威胁情报', '{\"belongTo\":\"OFFLINE_UPDATE\"}', '{\"ExportLicenseFile\":{\"name\":\"导出许可申请文件\",\"operation\":\"ExportLicenseFile\"},\"UploadUpdatePackage\":{\"name\":\"上传更新包\",\"operation\":\"UploadUpdatePackage\"}}', 1, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (2, 'ThreatIntelligenceCentreSource', 'ONLINE_UPDATE', '在线更新', 'tab', 0, '', '{\"belongTo\":\"ONLINE_UPDATE\",\"tiToken\":\"\"}', '{\"UpdateOnline\":{\"name\":\"在线更新\",\"operation\":\"UpdateOnline\"},\"UserExperienceProgram\":{\"name\":\"参加\\\"AiLPHA用户体验改善计划\\\"\",\"operation\":\"UserExperienceProgram\",\"value\":false},\"ConnectivityTest\":{\"name\":\"连通性测试\",\"operation\":\"ConnectivityTest\"},\"UpdateNow\":{\"name\":\"立即更新\",\"operation\":\"UpdateNow\"},\"ProxyConfiguration\":{\"name\":\"代理配置\",\"operation\":\"ProxyConfiguration\"},\"DNSConfiguration\":{\"name\":\"DNS配置\",\"operation\":\"DNSConfiguration\"}}', 2, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (3, 'ThreatIntelligenceCentreSource', 'API_UPDATE', 'Api更新', 'tab', 0, '', '{\"belongTo\":\"API_UPDATE\"}', '', 3, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (4, 'ThreatIntelligenceCentreSource', 'EXPORT', '情报导出', 'tab', 0, '暂不支持', '{\"belongTo\":\"EXPORT\"}', '{\"GenerateExportFile\":{\"name\":\"生成情报导出文件\",\"operation\":\"GenerateExportFile\"},\"Download\":{\"name\":\"下载\",\"operation\":\"Download\"}}', 4, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (5, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_ADD', '情报新增', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_ADD\"}', '', 5, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (6, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_DELETE', '情报删除', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_DELETE\"}', '', 6, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (7, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_MODIFY', '情报修改', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_MODIFY\"}', '', 7, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (8, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_RETRIEVE', '情报检索', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE\"}', '', 8, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (9, 'ThreatIntelligenceCentreSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"ONLINE_UPDATE\"]}', '', 9, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (10, 'ThreatIntelligenceCentreSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 10, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (11, 'ThreatIntelligenceCentreSource', 'REMOVE', '移除', 'button', 0, '', '{\"belongTo\":\"REMOVE\"}', '', 11, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (12, 'ThreatIntelligenceCentreSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 12, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (18, 'NSFOCUSApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[]}', '', 1, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (19, 'NSFOCUSApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (20, 'NSFOCUSApiIntelligenceSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 3, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (21, 'NSFOCUSApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (22, 'NSFOCUSApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (23, 'TianJiPartnersApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[]}', '', 1, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (24, 'TianJiPartnersApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (25, 'TianJiPartnersApiIntelligenceSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 3, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (26, 'TianJiPartnersApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (27, 'TianJiPartnersApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (28, 'WeiBuApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[{\"name\":\"微步TIP情报碰撞接口\",\"code\":\"WeiBuHit\",\"use\":-1,\"tag\":1,\"method\":\"GET\",\"protocol\":\"http\",\"domain\":\"TIP:PORT\",\"path\":\"/api/v3/intelligence_search\",\"params\":[{\"key\":\"apiKey\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，微步TIP平台业务管理配置页面生成\",\"isIoC\":false},{\"key\":\"data\",\"value\":\"www.baidu.com\",\"description\":\"IP地址或域名，查询情报IoC样例，可为空\",\"isIoC\":true}],\"demo\":\"http://TIP:PORT/api/v3/intelligence_search?apiKey=YOUR-KEY&data=www.baidu.com\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"content.0.data AS IoC, content.0.now.0.type AS mclass, content.0.now.0.type AS sclass, content.0.now.0.type AS tags, content.0.now.0.confidence AS confidence, content.0.now.0.severity AS IoCLevel, content.0.data_type AS IoCType, content.0.data_type AS TIName\"},{\"name\":\"微步TIP情报查询接口\",\"code\":\"WeiBuQuery\",\"use\":1,\"tag\":1,\"method\":\"GET\",\"protocol\":\"http\",\"domain\":\"TIP:PORT\",\"path\":\"/api/v3/intelligence_search/all\",\"params\":[{\"key\":\"apiKey\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，微步TIP平台业务管理配置页面生成\",\"isIoC\":false},{\"key\":\"data\",\"value\":\"www.baidu.com\",\"description\":\"IP地址或域名，查询情报IoC样例，可为空\",\"isIoC\":true}],\"demo\":\"http://TIP:PORT/api/v3/intelligence_search/all?apiKey=YOUR-KEY&data=www.baidu.com\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"data.0.raw.ioc AS IoC, data.0.raw.intel_type AS mclass, data.0.raw.intel_type AS sclass, data.0.raw.intel_type AS tags, data.0.raw.confidence AS confidence, data.0.raw.severity AS IoCLevel, data.0.raw.ioc_type AS IoCType, data.0.raw.timestamp AS createTime, data.0.raw.APT AS isAPT, data.0.raw.whois.registrant_name AS registrationName, data.0.raw.whois.update_date AS refreshDate, data.0.raw.whois.expiry_date AS expirationDate, data.0.raw.whois.create_date AS registrationTime, data.0.raw.whois.name_server AS dns, data.0.raw.whois.registrar_name AS registrar, data.0.raw.whois.tech_street AS street, data.0.raw.whois.tech_city AS city, data.0.raw.whois.tech_country AS country, data.0.raw.whois.registrant_email AS registrationEmail, data.0.raw.whois.registrant_email AS TIName\"}]}', '', 1, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (29, 'WeiBuApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (30, 'WeiBuApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (31, 'WeiBuApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (32, 'AnHengTipApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[{\"name\":\"安恒TIP情报IP信誉接口\",\"code\":\"anhengIP\",\"use\":0,\"tag\":2,\"method\":\"POST\",\"protocol\":\"https\",\"domain\":\"TIP:PORT\",\"path\":\"/api/v2/ip_reputation\",\"headers\":[{\"key\":\"Content-Type\",\"value\":\"application/json\",\"description\":\"请求体中数据格式：application/json\",\"isIoC\":false},{\"key\":\"Tip-Token\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，安恒TIP平台情报协同页面生成\",\"isIoC\":false}],\"body\":[{\"key\":\"ioc\",\"value\":\"83.171.237.173\",\"description\":\"IP地址，查询情报IoC样例，可为空\",\"isIoC\":true},{\"key\":\"only_malicious\",\"value\":false,\"description\":\"是否只显示恶意IP，默认false即全部显示，包括安全的数据\",\"isIoC\":false}],\"demo\":\"https://TIP:PORT/api/v2/ip_reputation\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"\"},{\"name\":\"安恒TIP情报域名信誉接口\",\"code\":\"anhengDomain\",\"use\":0,\"tag\":5,\"method\":\"POST\",\"protocol\":\"https\",\"domain\":\"TIP:PORT\",\"path\":\"/api/v2/domain_reputation\",\"headers\":[{\"key\":\"Content-Type\",\"value\":\"application/json\",\"description\":\"请求体中数据格式：application/json\",\"isIoC\":false},{\"key\":\"Tip-Token\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，安恒TIP平台情报协同页面生成\",\"isIoC\":false}],\"body\":[{\"key\":\"ioc\",\"value\":\"martin27.xyz\",\"description\":\"域名，查询情报IoC样例，可为空\",\"isIoC\":true},{\"key\":\"only_malicious\",\"value\":false,\"description\":\"是否只显示恶意域名，默认false即全部显示，包括安全的数据\",\"isIoC\":false}],\"demo\":\"https://TIP:PORT/api/v2/domain_reputation\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"\"}]}', '', 1, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (33, 'AnHengTipApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (34, 'AnHengTipApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 3, 1);,
  INSERT INTO "t_default_intelligence_source_function" VALUES (35, 'AnHengTipApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 4, 0);

-- Indexes
CREATE UNIQUE INDEX "unique_intelligenceSourceCode_function" ON "t_default_intelligence_source_function" ("intelligence_source_code", "function");

-- Column comments
COMMENT ON COLUMN "t_default_intelligence_source_function"."id" IS '情报源功能ID';
COMMENT ON COLUMN "t_default_intelligence_source_function"."intelligence_source_code" IS '情报源英文标识';
COMMENT ON COLUMN "t_default_intelligence_source_function"."function" IS '情报源功能';
COMMENT ON COLUMN "t_default_intelligence_source_function"."name" IS '情报源功能名称';
COMMENT ON COLUMN "t_default_intelligence_source_function"."type" IS '情报源功能类型：tab-标签页(情报数据更新、导出等操作需要另起tab页)；button-按钮(情报源自身操作，设置、管理、移除、克隆)；operate-操作(情报操作，增删改查等)';
COMMENT ON COLUMN "t_default_intelligence_source_function"."enable" IS '情报源功能启禁用';
COMMENT ON COLUMN "t_default_intelligence_source_function"."description" IS '情报源功能描述';
COMMENT ON COLUMN "t_default_intelligence_source_function"."config" IS '情报源功能配置，JSONObject格式';
COMMENT ON COLUMN "t_default_intelligence_source_function"."operations" IS '情报源功能包含的操作、按钮等，JSONArray格式';
COMMENT ON COLUMN "t_default_intelligence_source_function"."order" IS '功能顺序';
COMMENT ON COLUMN "t_default_intelligence_source_function"."display" IS '情报源功能是否展示';


DROP TABLE IF EXISTS "t_default_intelligence_source_metadata";
CREATE TABLE "t_default_intelligence_source_metadata"  (
  "id" SERIAL,
  "name" VARCHAR(255)   NOT NULL,
  "code" VARCHAR(100)   NOT NULL,
  "icon" VARCHAR(50)   NULL DEFAULT NULL,
  "type" enum('local','API')   NOT NULL,
  "subtype" enum('custom','build-in')   NOT NULL,
  "knowledge" SMALLINT NULL DEFAULT 0,
  "flag" SMALLINT NULL DEFAULT 1,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_default_intelligence_source_metadata" VALUES (1, '安恒威胁情报中心', 'ThreatIntelligenceCentreSource', 'dbapp', 'local', 'build-in', 1, 1, '2026-01-13 10:37:46', '2026-01-13 10:37:46');,
  INSERT INTO "t_default_intelligence_source_metadata" VALUES (2, '微步威胁情报TIP平台', 'WeiBuApiIntelligenceSource', 'weibu', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50');,
  INSERT INTO "t_default_intelligence_source_metadata" VALUES (3, '绿盟威胁情报TIP平台', 'NSFOCUSApiIntelligenceSource', 'lvmeng', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50');,
  INSERT INTO "t_default_intelligence_source_metadata" VALUES (4, '天际友盟威胁情报TIP平台', 'TianJiPartnersApiIntelligenceSource', 'tianji', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50');,
  INSERT INTO "t_default_intelligence_source_metadata" VALUES (5, '安恒威胁情报TIP平台', 'AnHengTipApiIntelligenceSource', 'anhengTIP', 'API', 'build-in', 0, 0, '2026-01-13 10:37:50', '2026-01-13 10:37:50');

-- Indexes
CREATE UNIQUE INDEX "name" ON "t_default_intelligence_source_metadata" ("name");
CREATE UNIQUE INDEX "code" ON "t_default_intelligence_source_metadata" ("code");

-- Column comments
COMMENT ON COLUMN "t_default_intelligence_source_metadata"."id" IS '情报源ID';
COMMENT ON COLUMN "t_default_intelligence_source_metadata"."name" IS '情报源名称';
COMMENT ON COLUMN "t_default_intelligence_source_metadata"."code" IS '情报源英文标识（用以关联操作）';
COMMENT ON COLUMN "t_default_intelligence_source_metadata"."icon" IS '情报源图标';
COMMENT ON COLUMN "t_default_intelligence_source_metadata"."type" IS '情报源类型：local-本地情报源；API-API情报源';
COMMENT ON COLUMN "t_default_intelligence_source_metadata"."subtype" IS '情报源子类型：custom-自定义情报源；build-in-内置情报源';
COMMENT ON COLUMN "t_default_intelligence_source_metadata"."knowledge" IS '情报源是否包含知识库：0-不包含知识库；1-包含只是库，当前仅威胁情报中心具有知识库';
COMMENT ON COLUMN "t_default_intelligence_source_metadata"."flag" IS '情报源标记，1-显示（所有正常工作的情报源），0-不显示（内置情报源但默认未添加状态，如微步、绿盟、天际友盟）';
COMMENT ON COLUMN "t_default_intelligence_source_metadata"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_default_intelligence_source_metadata"."update_time" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_default_intelligence_source_metadata_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_default_intelligence_source_metadata_update_timestamp
BEFORE UPDATE ON "t_default_intelligence_source_metadata"
FOR EACH ROW
EXECUTE FUNCTION update_t_default_intelligence_source_metadata_timestamp();


DROP TABLE IF EXISTS "t_device";
CREATE TABLE "t_device"  (
  "id" SERIAL,
  "device_name" VARCHAR(255)   NULL DEFAULT NULL,
  "device_id" VARCHAR(50)   NOT NULL DEFAULT '',
  "device_state" BOOLEAN NULL DEFAULT 0,
  "tags" VARCHAR(5000)   NULL DEFAULT '',
  "config" VARCHAR(10000)   NULL DEFAULT '',
  "config_data" text   NULL,
  "app_id" VARCHAR(50)   NOT NULL DEFAULT '',
  "create_time" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "type" VARCHAR(255)   NOT NULL DEFAULT 'other',
  "linkedState" VARCHAR(50)   NULL DEFAULT NULL,
  "deviceModel" VARCHAR(50)   NULL DEFAULT NULL,
  "deviceType" VARCHAR(50)   NULL DEFAULT NULL,
  "assetType" VARCHAR(50)   NULL DEFAULT NULL,
  "linkage" VARCHAR(30)   NULL DEFAULT NULL,
  "push_default" BOOLEAN NULL DEFAULT 0,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "t_device_device_id_uindex" ON "t_device" ("device_id");
CREATE UNIQUE INDEX "t_device_device_name_uindex" ON "t_device" ("device_name");

-- Column comments
COMMENT ON COLUMN "t_device"."id" IS '序号';
COMMENT ON COLUMN "t_device"."device_name" IS '设备名称';
COMMENT ON COLUMN "t_device"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_device"."device_state" IS '设备状态[0-禁用 1-启动]';
COMMENT ON COLUMN "t_device"."tags" IS '标签，多个以英文逗号分隔';
COMMENT ON COLUMN "t_device"."config" IS '设备配置信息结构';
COMMENT ON COLUMN "t_device"."config_data" IS '设备配置信息数据';
COMMENT ON COLUMN "t_device"."app_id" IS 'app编号';
COMMENT ON COLUMN "t_device"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_device"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_device"."linkedState" IS '防火墙/EDR联动状态：连接异常、联动中、未启用';
COMMENT ON COLUMN "t_device"."deviceModel" IS '设备模块';
COMMENT ON COLUMN "t_device"."deviceType" IS '设备类型';
COMMENT ON COLUMN "t_device"."assetType" IS '资产类型';
COMMENT ON COLUMN "t_device"."linkage" IS '联动方式:https/ssh等';
COMMENT ON COLUMN "t_device"."push_default" IS '是否为默认的推送配置';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_device_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_device_update_timestamp
BEFORE UPDATE ON "t_device"
FOR EACH ROW
EXECUTE FUNCTION update_t_device_timestamp();


DROP TABLE IF EXISTS "t_dilatation_history";
CREATE TABLE "t_dilatation_history"  (
  "id" BIGSERIAL,
  "status" SMALLINT NULL DEFAULT NULL,
  "current_config" VARCHAR(2048)   NULL DEFAULT NULL,
  "last_config" VARCHAR(2048)   NULL DEFAULT NULL,
  "progress" NUMERIC(4, 2) NULL DEFAULT NULL,
  "offset" INTEGER NULL DEFAULT NULL,
  "create_user" VARCHAR(64)   NULL DEFAULT NULL,
  "create_time" TIMESTAMP NULL DEFAULT NULL,
  "update_user" VARCHAR(64)   NULL DEFAULT NULL,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "deleted" SMALLINT NULL DEFAULT 0,
  "log_path" VARCHAR(256)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_dilatation_history"."status" IS '扩容状态，-1:扩容中，0:扩容失败，1:扩容成功';
COMMENT ON COLUMN "t_dilatation_history"."current_config" IS '本次扩容配置';
COMMENT ON COLUMN "t_dilatation_history"."last_config" IS '扩容前配置';
COMMENT ON COLUMN "t_dilatation_history"."progress" IS '扩容进度';
COMMENT ON COLUMN "t_dilatation_history"."offset" IS '日志读取偏移量';
COMMENT ON COLUMN "t_dilatation_history"."create_user" IS '创建人';
COMMENT ON COLUMN "t_dilatation_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_dilatation_history"."update_user" IS '修改人';
COMMENT ON COLUMN "t_dilatation_history"."update_time" IS '修改时间';
COMMENT ON COLUMN "t_dilatation_history"."deleted" IS '0:正常；1:删除';
COMMENT ON COLUMN "t_dilatation_history"."log_path" IS '日志路径';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_dilatation_history_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_dilatation_history_update_timestamp
BEFORE UPDATE ON "t_dilatation_history"
FOR EACH ROW
EXECUTE FUNCTION update_t_dilatation_history_timestamp();


DROP TABLE IF EXISTS "t_dispose_event";
CREATE TABLE "t_dispose_event"  (
  "id" BIGSERIAL,
  "title" VARCHAR(127)   NOT NULL,
  "assigneeId" BIGINT NOT NULL,
  "creatorId" BIGINT NOT NULL,
  "disposeAction" VARCHAR(23)   NOT NULL,
  "status" VARCHAR(10)   NOT NULL,
  "domain" VARCHAR(63)   NULL DEFAULT NULL,
  "ip" VARCHAR(63)   NULL DEFAULT NULL,
  "comment" VARCHAR(255)   NULL DEFAULT NULL,
  "createTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updateTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
  CONSTRAINT "fk_assigneedId" FOREIGN KEY ("assigneeId") REFERENCES "t_user" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT
  CONSTRAINT "fk_creatorId" FOREIGN KEY ("creatorId") REFERENCES "t_user" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT
);
  "SET" FOREIGN_KEY_CHECKS = 1;

-- Indexes
CREATE INDEX "index_assignee" ON "t_dispose_event" ("assigneeId");
CREATE INDEX "index_creator" ON "t_dispose_event" ("creatorId");

-- Column comments
COMMENT ON COLUMN "t_dispose_event"."title" IS '用户ID';
COMMENT ON COLUMN "t_dispose_event"."assigneeId" IS '受理人ID';
COMMENT ON COLUMN "t_dispose_event"."creatorId" IS '创建人ID';
COMMENT ON COLUMN "t_dispose_event"."disposeAction" IS '处置动作';
COMMENT ON COLUMN "t_dispose_event"."status" IS '状态';
COMMENT ON COLUMN "t_dispose_event"."domain" IS '域名';
COMMENT ON COLUMN "t_dispose_event"."ip" IS 'IP';
COMMENT ON COLUMN "t_dispose_event"."comment" IS '备注';
COMMENT ON COLUMN "t_dispose_event"."createTime" IS '创建时间';
COMMENT ON COLUMN "t_dispose_event"."updateTime" IS '修改时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_dispose_event_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updateTime" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_dispose_event_update_timestamp
BEFORE UPDATE ON "t_dispose_event"
FOR EACH ROW
EXECUTE FUNCTION update_t_dispose_event_timestamp();


-- Enable foreign key checks
SET session_replication_role = 'origin';

-- Update sequences
-- Run after data import:
-- SELECT setval(pg_get_serial_sequence('table_name', 'id_column'), (SELECT MAX(id_column) FROM table_name));
