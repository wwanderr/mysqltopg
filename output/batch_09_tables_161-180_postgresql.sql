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


DROP TABLE IF EXISTS "t_sev_agent_events";
CREATE TABLE "t_sev_agent_events"  (
  "id" BIGSERIAL,
  "agent_code" VARCHAR(150)   NOT NULL,
  "event_type" VARCHAR(32)   NOT NULL,
  "status" VARCHAR(32)   NOT NULL,
  "result" BOOLEAN NULL DEFAULT NULL,
  "message" VARCHAR(1024)   NULL DEFAULT NULL,
  "data" text   NULL,
  "event_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
  CONSTRAINT "t_sev_agent_events_FK" FOREIGN KEY ("agent_code") REFERENCES "t_sev_agent_info" ("agent_code") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE INDEX "t_sev_agent_events_FK" ON "t_sev_agent_events" ("agent_code");

-- Column comments
COMMENT ON COLUMN "t_sev_agent_events"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_events"."agent_code" IS 'agent唯一标识';
COMMENT ON COLUMN "t_sev_agent_events"."event_type" IS '事件类型，upgrade：升级，reloadConfig：配置更新';
COMMENT ON COLUMN "t_sev_agent_events"."status" IS '事件状态，begin：开始，finish：结束';
COMMENT ON COLUMN "t_sev_agent_events"."result" IS '事件结果';
COMMENT ON COLUMN "t_sev_agent_events"."message" IS '描述信息';
COMMENT ON COLUMN "t_sev_agent_events"."data" IS '数据信息，json';
COMMENT ON COLUMN "t_sev_agent_events"."event_time" IS '事件时间';


DROP TABLE IF EXISTS "t_sev_agent_info";
CREATE TABLE "t_sev_agent_info"  (
  "id" BIGSERIAL,
  "agent_code" VARCHAR(150)   NOT NULL,
  "agent_name" VARCHAR(150)   NULL DEFAULT NULL,
  "agent_ip" VARCHAR(64)   NOT NULL,
  "agent_ip_num" VARCHAR(64)   NOT NULL,
  "agent_type" VARCHAR(32)   NOT NULL,
  "machine_code" VARCHAR(150)   NULL DEFAULT NULL,
  "device_model" VARCHAR(150)   NULL DEFAULT NULL,
  "soft_version" VARCHAR(256)   NOT NULL,
  "rule_version" VARCHAR(256)   NULL DEFAULT NULL,
  "intelligence_version" VARCHAR(256)   NULL DEFAULT NULL,
  "config_version" BIGINT NULL DEFAULT NULL,
  "single_login_uri" VARCHAR(1024)   NULL DEFAULT NULL,
  "status" VARCHAR(32)   NULL DEFAULT NULL,
  "org_id" VARCHAR(100)   NULL DEFAULT NULL,
  "regist_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "monitor_id" BIGINT NULL DEFAULT NULL,
  "upgrade_log_id" INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ("id")
  CONSTRAINT "t_agent_info_FK" FOREIGN KEY ("agent_type") REFERENCES "t_sev_agent_type" ("agent_type") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Indexes
CREATE UNIQUE INDEX "t_agent_info_UN" ON "t_sev_agent_info" ("agent_code");
CREATE INDEX "t_agent_info_FK" ON "t_sev_agent_info" ("agent_type");
CREATE INDEX "t_agent_info_regist_time_IDX" ON "t_sev_agent_info" ("regist_time");
CREATE INDEX "t_sev_agent_info_config_version_IDX" ON "t_sev_agent_info" ("config_version");

-- Column comments
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


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_sev_agent_info_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_sev_agent_info_update_timestamp
BEFORE UPDATE ON "t_sev_agent_info"
FOR EACH ROW
EXECUTE FUNCTION update_t_sev_agent_info_timestamp();


DROP TABLE IF EXISTS "t_sev_agent_license";
CREATE TABLE "t_sev_agent_license"  (
  "id" BIGSERIAL,
  "agent_code" VARCHAR(150)   NOT NULL,
  "license_code" TEXT   NULL,
  "product_sn" VARCHAR(256)   NULL DEFAULT NULL,
  "file_name" VARCHAR(256)   NULL DEFAULT NULL,
  "license_type" INTEGER NULL DEFAULT NULL,
  "version" INTEGER NOT NULL DEFAULT 0,
  "expire_time" date NOT NULL,
  "file_uuid" VARCHAR(64)   NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
  CONSTRAINT "t_agent_license_FK_1" FOREIGN KEY ("file_uuid") REFERENCES "t_bs_files" ("uuid") ON DELETE RESTRICT ON UPDATE RESTRICT
  CONSTRAINT "t_sev_agent_license_FK" FOREIGN KEY ("agent_code") REFERENCES "t_sev_agent_info" ("agent_code") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE INDEX "t_agent_license_FK_1" ON "t_sev_agent_license" ("file_uuid");
CREATE INDEX "t_sev_agent_license_FK" ON "t_sev_agent_license" ("agent_code");

-- Column comments
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


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_sev_agent_license_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_sev_agent_license_update_timestamp
BEFORE UPDATE ON "t_sev_agent_license"
FOR EACH ROW
EXECUTE FUNCTION update_t_sev_agent_license_timestamp();


DROP TABLE IF EXISTS "t_sev_agent_monitor";
CREATE TABLE "t_sev_agent_monitor"  (
  "id" BIGSERIAL,
  "agent_code" VARCHAR(150)   NOT NULL,
  "agent_type" VARCHAR(32)   NOT NULL,
  "cpu_usage" DOUBLE PRECISION NULL DEFAULT NULL,
  "memory_total" DOUBLE PRECISION NULL DEFAULT NULL,
  "memory_use" DOUBLE PRECISION NULL DEFAULT NULL,
  "disk_total" DOUBLE PRECISION NULL DEFAULT NULL,
  "disk_use" DOUBLE PRECISION NULL DEFAULT NULL,
  "metric1" DOUBLE PRECISION NULL DEFAULT NULL,
  "metric2" DOUBLE PRECISION NULL DEFAULT NULL,
  "metric3" DOUBLE PRECISION NULL DEFAULT NULL,
  "create_time" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id")
  CONSTRAINT "t_agent_monitor_FK" FOREIGN KEY ("agent_code") REFERENCES "t_sev_agent_info" ("agent_code") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE INDEX "t_agent_monitor_FK" ON "t_sev_agent_monitor" ("agent_code");
CREATE INDEX "t_sev_agent_monitor_create_time_IDX" ON "t_sev_agent_monitor" ("create_time");

-- Column comments
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


DROP TABLE IF EXISTS "t_sev_agent_package";
CREATE TABLE "t_sev_agent_package"  (
  "id" BIGSERIAL,
  "agent_type" VARCHAR(32)   NOT NULL,
  "package_type" VARCHAR(32)   NOT NULL,
  "package_version" VARCHAR(100)   NOT NULL,
  "depend_software" VARCHAR(100)   NULL DEFAULT NULL,
  "file_uuid" VARCHAR(100)   NOT NULL,
  "file_name" VARCHAR(255)   NOT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "upload_type" VARCHAR(32)   NULL DEFAULT NULL,
  "file_size" BIGINT NOT NULL,
  PRIMARY KEY ("id")
  CONSTRAINT "t_agent_package_FK" FOREIGN KEY ("agent_type") REFERENCES "t_sev_agent_type" ("agent_type") ON DELETE CASCADE ON UPDATE CASCADE
  CONSTRAINT "t_agent_package_FK_1" FOREIGN KEY ("file_uuid") REFERENCES "t_bs_files" ("uuid") ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Indexes
CREATE INDEX "t_agent_package_FK" ON "t_sev_agent_package" ("agent_type");
CREATE INDEX "t_agent_package_FK_1" ON "t_sev_agent_package" ("file_uuid");

-- Column comments
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


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_sev_agent_package_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_sev_agent_package_update_timestamp
BEFORE UPDATE ON "t_sev_agent_package"
FOR EACH ROW
EXECUTE FUNCTION update_t_sev_agent_package_timestamp();


DROP TABLE IF EXISTS "t_sev_agent_rule_closed";
CREATE TABLE "t_sev_agent_rule_closed"  (
  "id" BIGSERIAL,
  "rule_closed_id" BIGINT NOT NULL,
  "agent_code" VARCHAR(150)   NULL DEFAULT NULL,
  "is_delete" BOOLEAN NOT NULL DEFAULT 0,
  "config_version" BIGINT NOT NULL,
  PRIMARY KEY ("id")
  CONSTRAINT "t_sev_agent_rule_closed_FK" FOREIGN KEY ("rule_closed_id") REFERENCES "t_sev_agent_type_rule_closed" ("id") ON DELETE CASCADE ON UPDATE CASCADE
  CONSTRAINT "t_sev_agent_rule_closed_FK_1" FOREIGN KEY ("agent_code") REFERENCES "t_sev_agent_info" ("agent_code") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE UNIQUE INDEX "t_sev_agent_rule_closed_UN" ON "t_sev_agent_rule_closed" ("rule_closed_id", "agent_code");
CREATE INDEX "t_sev_agent_rule_closed_FK_1" ON "t_sev_agent_rule_closed" ("agent_code");

-- Column comments
COMMENT ON COLUMN "t_sev_agent_rule_closed"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_rule_closed"."rule_closed_id" IS '探针类型与关闭规则关联表id';
COMMENT ON COLUMN "t_sev_agent_rule_closed"."agent_code" IS '探针设备唯一标识';
COMMENT ON COLUMN "t_sev_agent_rule_closed"."is_delete" IS '标记是否删除';
COMMENT ON COLUMN "t_sev_agent_rule_closed"."config_version" IS '配置版本号，创建时间戳，毫秒值';


DROP TABLE IF EXISTS "t_sev_agent_type";
CREATE TABLE "t_sev_agent_type"  (
  "id" BIGSERIAL,
  "agent_type" VARCHAR(32)   NOT NULL,
  "agent_type_name" VARCHAR(150)   NOT NULL,
  "description" VARCHAR(4096)   NULL DEFAULT NULL,
  "support_version" VARCHAR(150)   NULL DEFAULT NULL,
  "license_pattern" VARCHAR(100)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_sev_agent_type" VALUES (10, 'APT', '流量探针(APT)', NULL, NULL, '^license.dat$');,
  INSERT INTO "t_sev_agent_type" VALUES (11, 'APT_SandBox', '沙箱', NULL, NULL, '^license.dat$');,
  INSERT INTO "t_sev_agent_type" VALUES (12, 'AiNTA', '流量探针(AiNTA)', NULL, NULL, '^lic_AiNTA_([a-z0-9A-Z]*-?)*[\\u4e00-\\u9fa5]?_\\d{6}.dat$');,
  INSERT INTO "t_sev_agent_type" VALUES (13, 'EDR', '安恒EDR', NULL, NULL, '^license.dat$');

-- Indexes
CREATE UNIQUE INDEX "t_agent_type_UN" ON "t_sev_agent_type" ("agent_type");

-- Column comments
COMMENT ON COLUMN "t_sev_agent_type"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_type"."agent_type" IS 'agent类型（AiNTA、APT、SOC）';
COMMENT ON COLUMN "t_sev_agent_type"."agent_type_name" IS 'agent类型名称';
COMMENT ON COLUMN "t_sev_agent_type"."description" IS 'agent描述';
COMMENT ON COLUMN "t_sev_agent_type"."support_version" IS '支持的最小软件版本';
COMMENT ON COLUMN "t_sev_agent_type"."license_pattern" IS '许可文件名校验正则';


DROP TABLE IF EXISTS "t_sev_agent_type_rule_closed";
CREATE TABLE "t_sev_agent_type_rule_closed"  (
  "id" BIGSERIAL,
  "agent_type" VARCHAR(32)   NOT NULL,
  "rule_id" VARCHAR(255)   NOT NULL,
  "remarks" text   NULL,
  "update_history_alarm" BOOLEAN NULL DEFAULT NULL,
  "data" text   NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_delete" BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
  CONSTRAINT "t_sev_agent_type_rule_closed_FK" FOREIGN KEY ("agent_type") REFERENCES "t_sev_agent_type" ("agent_type") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE UNIQUE INDEX "t_sev_agent_type_rule_closed_UN" ON "t_sev_agent_type_rule_closed" ("agent_type", "rule_id");

-- Column comments
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."agent_type" IS '探针类型';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."rule_id" IS '规则id';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."remarks" IS '备注';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."update_history_alarm" IS '是否将最近7天告警标记为 已处置-误报';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."data" IS '附加信息，回跳告警列表查询字段';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."is_delete" IS '标记是否删除';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_sev_agent_type_rule_closed_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_sev_agent_type_rule_closed_update_timestamp
BEFORE UPDATE ON "t_sev_agent_type_rule_closed"
FOR EACH ROW
EXECUTE FUNCTION update_t_sev_agent_type_rule_closed_timestamp();


DROP TABLE IF EXISTS "t_sev_file_chunk";
CREATE TABLE "t_sev_file_chunk"  (
  "id" SERIAL,
  "file_name" VARCHAR(255)   NULL DEFAULT NULL,
  "chunk_number" INTEGER NULL DEFAULT NULL,
  "chunk_size" REAL NULL DEFAULT NULL,
  "current_chunk_size" REAL NULL DEFAULT NULL,
  "total_size" DOUBLE PRECISION NULL DEFAULT NULL,
  "chunk_end" BIGINT NULL DEFAULT NULL,
  "chunk_start" BIGINT NULL DEFAULT NULL,
  "total_chunk" INTEGER NULL DEFAULT NULL,
  "identifier" VARCHAR(45)   NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "uuid" VARCHAR(255)   NULL DEFAULT NULL,
  "save_path" VARCHAR(255)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_sev_file_chunk"."id" IS '主键id';
COMMENT ON COLUMN "t_sev_file_chunk"."file_name" IS '文件名';
COMMENT ON COLUMN "t_sev_file_chunk"."chunk_number" IS '当前分片，从1开始';
COMMENT ON COLUMN "t_sev_file_chunk"."chunk_size" IS '分片大小';
COMMENT ON COLUMN "t_sev_file_chunk"."current_chunk_size" IS '当前分片大小';
COMMENT ON COLUMN "t_sev_file_chunk"."total_size" IS '文件总大小';
COMMENT ON COLUMN "t_sev_file_chunk"."chunk_end" IS '分片结束位置';
COMMENT ON COLUMN "t_sev_file_chunk"."chunk_start" IS '分片起始位置';
COMMENT ON COLUMN "t_sev_file_chunk"."total_chunk" IS '总分片数';
COMMENT ON COLUMN "t_sev_file_chunk"."identifier" IS 'md5校验码';
COMMENT ON COLUMN "t_sev_file_chunk"."uuid" IS '每一次分段下载，共用一个uuid';
COMMENT ON COLUMN "t_sev_file_chunk"."save_path" IS '本次下载目录';


DROP TABLE IF EXISTS "t_site";
CREATE TABLE "t_site"  (
  "_id" SERIAL,
  "sitename" VARCHAR(256)   NULL DEFAULT NULL,
  "domain" VARCHAR(256)   NULL DEFAULT NULL,
  "ip" VARCHAR(45)   NULL DEFAULT NULL,
  "port" VARCHAR(45)   NULL DEFAULT NULL,
  PRIMARY KEY ("_id")
);

-- Column comments
COMMENT ON COLUMN "t_site"."sitename" IS '站点名称';
COMMENT ON COLUMN "t_site"."domain" IS '站点域名';
COMMENT ON COLUMN "t_site"."ip" IS 'IP地址';
COMMENT ON COLUMN "t_site"."port" IS '端口号';


DROP TABLE IF EXISTS "t_situation_awareness";
CREATE TABLE "t_situation_awareness"  (
  "id" BIGINT NOT NULL,
  "awareness_id" VARCHAR(255)   NOT NULL,
  "title" VARCHAR(255)   NOT NULL,
  "brief" text   NOT NULL,
  "create_time" timestamp NULL DEFAULT NULL,
  "update_time" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_situation_awareness" VALUES (1, 'ExternalAttack', '外部攻击态势', '外部攻击态势主要关注来自全世界不同地区的攻击源对企业内部资产的威胁情况，实时监控境内境外攻击源的地域分布和国家排行，掌握各攻击链阶段的威胁变化趋势和最新外部攻击事件。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (2, 'CrossThreat', '横向威胁感知', '横向威胁感知主要关注企业内部资产之间的违规操作和病毒传播，实时监控跨安全域的访问行为和业务系统访问情况，通过自由布局和圆形布局观测资产之间的威胁关系，及时发现并制止违规资产对企业内网环境造成的破坏。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (3, 'AssetsConnection', '资产外连风险态势', '资产外连风险态势主要关注企业内网存在回连行为和对外攻击的风险资产，实时监控外连行为变化趋势、最新外连事件、外连目的国家等，掌握企业内部资产的C&C回连情况和远控团伙信息。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (4, 'Monitor', 'WEB安全态势', 'WEB安全态势监控WEB服务的被访问状态和受攻击情况，包括网站区域访问量，访问地区排行，攻击网站排行，攻击类型排行，网站访问和攻击变化趋势等。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (5, 'SafaWarn', '内网安全态势', '内网安全态势通过3D逻辑安全域展示网络系统内发生的安全事件的攻击路径、攻击手法和影响范围，支持关联用户的网络和安全域划分，支持根据具体的资产和安全域的方式告警，可以为用户提供攻击者的溯源信息以及安全事件的处置建议。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (6, 'AI_analysis', 'AI异常分析', 'AI异常分析将AI算法与观测指标结合发现网络中断异常活动和新型威胁，多种AI分析场景配合算法特征将实时数据、拟合数据、评价参数共同呈现。异常信息通过红色点或区域高亮标注，点击异常标注可弹出异常信息详情窗口，辅助用户进行分析钻取和异常定位。多场景异常分布情况通过泳道图汇总到同一时间轴，用户可及时感知某时刻安全风险的集中爆发。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (7, 'SherlockScreen', 'Sherlock大屏', '夏洛克(Sherlock)赋予你一双福尔摩斯的慧眼，帮你透视整个网络，追踪网络实体的连接关系，发现访问行为的蛛丝马迹。大数据标签画像分析寻找相似的受害团体和黑客组织，AI 算法加持发现 观测指标中隐藏的未知威胁，情报、弱点信息辅助安全事件的追根溯源。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (8, 'AssetsManageScreen', '资产态势感知', '资产态势感知通过资产卡片形式实时监控重大保障活动中的关键资产，利用标签切换不同的活动资产分组，及时发现并处置风险资产，保障用户业务的可持续平稳运行。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (9, 'TraceV2', '攻击者追踪溯源', '攻击者追踪溯源可视化分析大屏，为安全运维人员提供包括攻击行为分析、团伙分析、攻击取证信息、攻击趋势、攻击手段，攻击影响范围等信息，支持任意攻击者信息查询，可生成详细的攻击者溯源报告，并能够一键导出报告。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (10, 'AssetTrace', '资产威胁溯源', '资产威胁溯源可视化分析大屏，为安全运维人员提供包括被攻击行为分析、影响资产范围分析、攻击取证信息等，支持任意资产查询，可呈现被访问趋势、被攻击趋势、被攻击手段、资产状态，资产评分等信息。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (11, 'PortalScreen', '统一门户', '统一门户作为访问安全分析与管理平台中信息资源的统一入口，集成态势感知、业务拓扑、资产感知、威胁情报、通报预警等系统核心应用，总体提升企业安全运营和威胁应急响应工作效率。', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_situation_awareness" VALUES (12, 'statusDetection', '平台运行状态监测', 'AiLPHA安全分析与管理平台运行状态监测，凸显AiLPHA具备来自全网安全设备的多元异构数据接入能力，打破数据孤岛，内置丰富的规则和知识库，利用多种计算分析引擎和安全分析工具，可长期保障用户全网资产安全，实时告警威胁情况。同时平台具备良好的数据存储和计算性能，支持动态扩容缩容，根据需求灵活配置。', '2026-01-13 10:37:41', NULL);

DROP TABLE IF EXISTS "t_soar_layout";
CREATE TABLE "t_soar_layout"  (
  "id" SERIAL,
  "layout_id" VARCHAR(255)   NOT NULL DEFAULT '',
  "layout_name" VARCHAR(255)   NULL DEFAULT NULL,
  "model_id" VARCHAR(255)   NULL DEFAULT NULL,
  "img" TEXT   NULL,
  "topo" TEXT   NULL,
  "is_enable" BOOLEAN NULL DEFAULT 1,
  "disable_reason" VARCHAR(32)   NULL DEFAULT NULL,
  "description" VARCHAR(4096)   NULL DEFAULT NULL,
  "tags" text   NULL,
  "is_factory" BOOLEAN NULL DEFAULT 0,
  "elements" text   NULL,
  "relational_map" TEXT   NULL,
  "creator" VARCHAR(255)   NULL DEFAULT '',
  "handling_time" REAL NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "t_soar_layout_UN" ON "t_soar_layout" ("layout_id");
CREATE INDEX "t_model_layout_layout_name_IDX" ON "t_soar_layout" ("layout_name");

-- Column comments
COMMENT ON COLUMN "t_soar_layout"."id" IS '主键';
COMMENT ON COLUMN "t_soar_layout"."layout_id" IS '剧本编排英文名';
COMMENT ON COLUMN "t_soar_layout"."layout_name" IS '剧本编排中文名';
COMMENT ON COLUMN "t_soar_layout"."model_id" IS '模型英文名';
COMMENT ON COLUMN "t_soar_layout"."img" IS '结构缩略图';
COMMENT ON COLUMN "t_soar_layout"."topo" IS '前端拓扑结构';
COMMENT ON COLUMN "t_soar_layout"."is_enable" IS '编排启用禁用状态';
COMMENT ON COLUMN "t_soar_layout"."disable_reason" IS '剧本禁用原因，overLimit:任务数太多自动禁用，为空:界面手动禁用';
COMMENT ON COLUMN "t_soar_layout"."description" IS '剧本描述';
COMMENT ON COLUMN "t_soar_layout"."tags" IS '剧本标签';
COMMENT ON COLUMN "t_soar_layout"."is_factory" IS '是否为出厂剧本编排';
COMMENT ON COLUMN "t_soar_layout"."elements" IS '组成元素';
COMMENT ON COLUMN "t_soar_layout"."relational_map" IS '组件的关联关系';
COMMENT ON COLUMN "t_soar_layout"."creator" IS '创建者';
COMMENT ON COLUMN "t_soar_layout"."handling_time" IS '预计人工处理时间，用于节省时间计算，单位小时';
COMMENT ON COLUMN "t_soar_layout"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_soar_layout"."update_time" IS '修改时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_soar_layout_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_soar_layout_update_timestamp
BEFORE UPDATE ON "t_soar_layout"
FOR EACH ROW
EXECUTE FUNCTION update_t_soar_layout_timestamp();


DROP TABLE IF EXISTS "t_soar_layout_draft";
CREATE TABLE "t_soar_layout_draft"  (
  "id" SERIAL,
  "pre_id" INTEGER NULL DEFAULT NULL,
  "user_id" BIGINT NULL DEFAULT NULL,
  "layout_id" VARCHAR(255)   NULL DEFAULT NULL,
  "layout_name" VARCHAR(255)   NULL DEFAULT NULL,
  "model_id" VARCHAR(255)   NULL DEFAULT NULL,
  "description" VARCHAR(4096)   NULL DEFAULT NULL,
  "tags" text   NULL,
  "topo" TEXT   NULL,
  "handling_time" REAL NULL DEFAULT NULL,
  "elements" text   NULL,
  "relational_map" TEXT   NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
  CONSTRAINT "t_soar_layout_draft_FK" FOREIGN KEY ("user_id") REFERENCES "t_user" ("id") ON DELETE CASCADE ON UPDATE CASCADE
  CONSTRAINT "t_soar_layout_draft_FK_id" FOREIGN KEY ("pre_id") REFERENCES "t_soar_layout" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE UNIQUE INDEX "t_soar_layout_draft_UN" ON "t_soar_layout_draft" ("user_id", "pre_id");
CREATE INDEX "t_model_layout_real_time_layout_id_IDX" ON "t_soar_layout_draft" ("layout_id");
CREATE INDEX "t_soar_layout_draft_FK_id" ON "t_soar_layout_draft" ("pre_id");

-- Column comments
COMMENT ON COLUMN "t_soar_layout_draft"."pre_id" IS '剧本主键id';
COMMENT ON COLUMN "t_soar_layout_draft"."user_id" IS '用户id';
COMMENT ON COLUMN "t_soar_layout_draft"."layout_id" IS '模型编排Id';
COMMENT ON COLUMN "t_soar_layout_draft"."layout_name" IS '剧本编排中文名，为空标识纯草稿，t_soar_layout中不存在';
COMMENT ON COLUMN "t_soar_layout_draft"."model_id" IS '模型英文名';
COMMENT ON COLUMN "t_soar_layout_draft"."description" IS '剧本描述';
COMMENT ON COLUMN "t_soar_layout_draft"."tags" IS '剧本标签';
COMMENT ON COLUMN "t_soar_layout_draft"."topo" IS '前端拓扑结构';
COMMENT ON COLUMN "t_soar_layout_draft"."handling_time" IS '预计人工处理时间，用于节省时间计算，单位小时';
COMMENT ON COLUMN "t_soar_layout_draft"."elements" IS '分析组件';
COMMENT ON COLUMN "t_soar_layout_draft"."relational_map" IS '组件的关联关系';
COMMENT ON COLUMN "t_soar_layout_draft"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_soar_layout_draft"."update_time" IS '修改时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_soar_layout_draft_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_soar_layout_draft_update_timestamp
BEFORE UPDATE ON "t_soar_layout_draft"
FOR EACH ROW
EXECUTE FUNCTION update_t_soar_layout_draft_timestamp();


DROP TABLE IF EXISTS "t_soar_layout_history";
CREATE TABLE "t_soar_layout_history"  (
  "id" SERIAL,
  "pre_id" INTEGER NULL DEFAULT NULL,
  "layout_id" VARCHAR(255)   NULL DEFAULT NULL,
  "layout_name" VARCHAR(255)   NULL DEFAULT NULL,
  "description" VARCHAR(4096)   NULL DEFAULT NULL,
  "model_id" VARCHAR(255)   NULL DEFAULT NULL,
  "model_id_order" INTEGER NULL DEFAULT NULL,
  "elements" text   NULL,
  "relational_map" TEXT   NULL,
  "is_enable" BOOLEAN NOT NULL DEFAULT 1,
  "creator" VARCHAR(255)   NULL DEFAULT NULL,
  "model_count" INTEGER NULL DEFAULT NULL,
  "linkage_count" INTEGER NULL DEFAULT NULL,
  "element_count" INTEGER NULL DEFAULT NULL,
  "handling_time" INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ("id")
  CONSTRAINT "t_soar_layout_history_FK" FOREIGN KEY ("pre_id") REFERENCES "t_soar_layout" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- Indexes
CREATE INDEX "t_model_layout_form_layout_id_IDX" ON "t_soar_layout_history" ("layout_id");
CREATE INDEX "t_soar_layout_history_FK" ON "t_soar_layout_history" ("pre_id");
CREATE INDEX "t_soar_layout_history_layout_name_IDX" ON "t_soar_layout_history" ("layout_name");

-- Column comments
COMMENT ON COLUMN "t_soar_layout_history"."pre_id" IS '剧本主键id';
COMMENT ON COLUMN "t_soar_layout_history"."layout_id" IS '剧本Id';
COMMENT ON COLUMN "t_soar_layout_history"."layout_name" IS '剧本名称';
COMMENT ON COLUMN "t_soar_layout_history"."description" IS '剧本描述';
COMMENT ON COLUMN "t_soar_layout_history"."model_id" IS '模型Id';
COMMENT ON COLUMN "t_soar_layout_history"."model_id_order" IS '最终输出模型id在elements中的下标位置';
COMMENT ON COLUMN "t_soar_layout_history"."elements" IS '组成元素';
COMMENT ON COLUMN "t_soar_layout_history"."relational_map" IS '组件的关联关系';
COMMENT ON COLUMN "t_soar_layout_history"."is_enable" IS '当前生效的记录';
COMMENT ON COLUMN "t_soar_layout_history"."creator" IS '创建人';
COMMENT ON COLUMN "t_soar_layout_history"."model_count" IS '模型节点数量';
COMMENT ON COLUMN "t_soar_layout_history"."linkage_count" IS '处置响应节点数量';
COMMENT ON COLUMN "t_soar_layout_history"."element_count" IS '节点总数量';
COMMENT ON COLUMN "t_soar_layout_history"."handling_time" IS '预计人工处理时间，用于节省时间计算，单位秒';


DROP TABLE IF EXISTS "t_soar_notice_history";
CREATE TABLE "t_soar_notice_history"  (
  "id" SERIAL,
  "notice_code" VARCHAR(32)   NOT NULL,
  "assignee_id" BIGINT NOT NULL,
  "assignee_name" VARCHAR(255)   NOT NULL,
  "notice_way" VARCHAR(32)   NOT NULL,
  "content" text   NULL,
  "status" VARCHAR(16)   NOT NULL DEFAULT 'success',
  "failure_msg" text   NULL,
  "serial_id" VARCHAR(255)   NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE INDEX "t_soar_notice_history_notice_code_IDX" ON "t_soar_notice_history" ("notice_code");

-- Column comments
COMMENT ON COLUMN "t_soar_notice_history"."id" IS '自增主键';
COMMENT ON COLUMN "t_soar_notice_history"."notice_code" IS '通报记录code，定时处理通报，一批次code相同';
COMMENT ON COLUMN "t_soar_notice_history"."assignee_id" IS '通知人的id';
COMMENT ON COLUMN "t_soar_notice_history"."assignee_name" IS '通知人的name';
COMMENT ON COLUMN "t_soar_notice_history"."notice_way" IS '通知方式';
COMMENT ON COLUMN "t_soar_notice_history"."content" IS '通知内容';
COMMENT ON COLUMN "t_soar_notice_history"."status" IS '状态';
COMMENT ON COLUMN "t_soar_notice_history"."failure_msg" IS '失败原因';
COMMENT ON COLUMN "t_soar_notice_history"."serial_id" IS '编号';
COMMENT ON COLUMN "t_soar_notice_history"."create_time" IS '记录创建时间';


DROP TABLE IF EXISTS "t_soar_task";
CREATE TABLE "t_soar_task"  (
  "id" VARCHAR(32)   NOT NULL,
  "history_id" INTEGER NOT NULL,
  "layout_id" VARCHAR(255)   NOT NULL,
  "event_id" VARCHAR(255)   NOT NULL,
  "task_name" VARCHAR(255)   NULL DEFAULT NULL,
  "start_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "end_time" timestamp NULL DEFAULT NULL,
  "status" VARCHAR(32)   NULL DEFAULT NULL,
  "status_percent" INTEGER NULL DEFAULT NULL,
  "deal_time" INTEGER NULL DEFAULT NULL,
  "save_time" INTEGER NULL DEFAULT NULL,
  "message" text   NULL,
  PRIMARY KEY ("id")
  CONSTRAINT "t_soar_task_FK" FOREIGN KEY ("history_id") REFERENCES "t_soar_layout_history" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE INDEX "t_soar_task_layout_id_IDX" ON "t_soar_task" ("layout_id", "status");
CREATE INDEX "t_soar_task_FK" ON "t_soar_task" ("history_id");
CREATE INDEX "t_soar_task_deal_time_IDX" ON "t_soar_task" ("deal_time");
CREATE INDEX "t_soar_task_save_time_IDX" ON "t_soar_task" ("save_time");
CREATE INDEX "t_soar_task_id_IDX" ON "t_soar_task" ("id", "history_id", "status");

-- Column comments
COMMENT ON COLUMN "t_soar_task"."id" IS '任务Id';
COMMENT ON COLUMN "t_soar_task"."history_id" IS '历史剧本Id';
COMMENT ON COLUMN "t_soar_task"."layout_id" IS '剧本id';
COMMENT ON COLUMN "t_soar_task"."event_id" IS '事件Id';
COMMENT ON COLUMN "t_soar_task"."task_name" IS '任务名称，取告警事件名称';
COMMENT ON COLUMN "t_soar_task"."start_time" IS '起始时间';
COMMENT ON COLUMN "t_soar_task"."end_time" IS '结束时间';
COMMENT ON COLUMN "t_soar_task"."status" IS '任务进度，running:进行中，cancel:取消，finish:完成';
COMMENT ON COLUMN "t_soar_task"."status_percent" IS '任务进度';
COMMENT ON COLUMN "t_soar_task"."deal_time" IS '处理时间';
COMMENT ON COLUMN "t_soar_task"."save_time" IS '节省时间';
COMMENT ON COLUMN "t_soar_task"."message" IS '告警信息';


DROP TABLE IF EXISTS "t_soar_task_action";
CREATE TABLE "t_soar_task_action"  (
  "id" SERIAL,
  "history_id" INTEGER NULL DEFAULT NULL,
  "order_idx" SMALLINT NOT NULL,
  "task_id" VARCHAR(32)   NOT NULL,
  "action_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "type" VARCHAR(255)   NOT NULL,
  "data" VARCHAR(128)   NULL DEFAULT NULL,
  "is_finish" BOOLEAN NOT NULL,
  PRIMARY KEY ("id")
  CONSTRAINT "t_model_layout_action_time_FK_form_id" FOREIGN KEY ("history_id") REFERENCES "t_soar_layout_history" ("id") ON DELETE CASCADE ON UPDATE CASCADE
  CONSTRAINT "t_soar_task_action_FK" FOREIGN KEY ("task_id") REFERENCES "t_soar_task" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE INDEX "t_model_layout_action_time_formId_IDX" ON "t_soar_task_action" ("history_id", "order_idx");
CREATE INDEX "t_soar_task_action_task_id_IDX" ON "t_soar_task_action" ("task_id", "order_idx");
CREATE INDEX "t_soar_task_action_data_IDX" ON "t_soar_task_action" ("data");
CREATE INDEX "t_soar_task_action_action_time_IDX" ON "t_soar_task_action" ("action_time");

-- Column comments
COMMENT ON COLUMN "t_soar_task_action"."history_id" IS '模块id';
COMMENT ON COLUMN "t_soar_task_action"."order_idx" IS '模块内编号';
COMMENT ON COLUMN "t_soar_task_action"."task_id" IS '任务Id';
COMMENT ON COLUMN "t_soar_task_action"."action_time" IS '操作时间';
COMMENT ON COLUMN "t_soar_task_action"."type" IS '操作状态';
COMMENT ON COLUMN "t_soar_task_action"."data" IS '预留字段，存储节点数据';
COMMENT ON COLUMN "t_soar_task_action"."is_finish" IS '任务节点是否执行完成';


DROP TABLE IF EXISTS "t_soc_asset";
CREATE TABLE "t_soc_asset"  (
  "id" BIGSERIAL,
  "assetId" text   NOT NULL,
  "identify" text   NULL,
  "name" text   NULL,
  "alias" text   NULL,
  "categoryId" text   NULL,
  "groupId" text   NULL,
  "groupName" text   NULL,
  "vendor" text   NULL,
  "securityLevel" text   NULL,
  "price" text   NULL,
  "monitorDomainId" text   NULL,
  "ip" text   NULL,
  "restrictMapperMode" text   NULL,
  "importance" text   NULL,
  "importime" TEXT   NULL,
  "tag" text   NULL,
  "otherAttributeInfo" text   NULL,
  "updatetime" TEXT   NULL,
  "incidentHigh" BIGINT NULL DEFAULT 0,
  "incidentMiddle" BIGINT NULL DEFAULT 0,
  "incidentLow" BIGINT NULL DEFAULT 0,
  "flawHigh" BIGINT NULL DEFAULT 0,
  "flawMiddle" BIGINT NULL DEFAULT 0,
  "flawLow" BIGINT NULL DEFAULT 0,
  "score" DOUBLE PRECISION NULL DEFAULT 0,
  "categoryName" text   NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "INDEX_UNIQ_IP" ON "t_soc_asset" ("ip"(200");

DROP TABLE IF EXISTS "t_soc_customer";
CREATE TABLE "t_soc_customer"  (
  "area" INTEGER NULL DEFAULT NULL,
  "note" VARCHAR(128)   NULL DEFAULT NULL,
  "salePersonId" INTEGER NULL DEFAULT NULL,
  "descrip" VARCHAR(128)   NULL DEFAULT NULL,
  "city" INTEGER NULL DEFAULT NULL,
  "defaultCustomer" INTEGER NULL DEFAULT NULL,
  "importance" INTEGER NULL DEFAULT NULL,
  "pid" BIGINT NULL DEFAULT NULL,
  "telephone" VARCHAR(128)   NULL DEFAULT NULL,
  "uuid" VARCHAR(128)   NULL DEFAULT NULL,
  "version" BIGINT NULL DEFAULT NULL,
  "industryId" INTEGER NULL DEFAULT NULL,
  "assetNumber" INTEGER NULL DEFAULT NULL,
  "province" INTEGER NULL DEFAULT NULL,
  "geoX" INTEGER NULL DEFAULT NULL,
  "contact" VARCHAR(128)   NULL DEFAULT NULL,
  "geoY" INTEGER NULL DEFAULT NULL,
  "name" VARCHAR(128)   NULL DEFAULT NULL,
  "belongTo" INTEGER NULL DEFAULT NULL,
  "id" BIGSERIAL,
  "maxAssetNumber" INTEGER NULL DEFAULT NULL,
  "email" VARCHAR(128)   NULL DEFAULT NULL,
  "status" INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "t_system_config";
CREATE TABLE "t_system_config"  (
  "id" BIGSERIAL,
  "name" VARCHAR(64)   NOT NULL,
  "value" VARCHAR(256)   NULL DEFAULT NULL,
  "description" VARCHAR(256)   NULL DEFAULT NULL,
  "createtime" TIMESTAMP NOT NULL,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_system_config" VALUES (1, 'version', '1.0.0.0', '系统版本号', '2015-01-01 00:00:00', '2015-01-01 00:00:00');,
  INSERT INTO "t_system_config" VALUES (2, 'sqlUpdateRows', '0', '更新SQL已执行到的行数', '2015-01-01 00:00:00', '2015-01-01 00:00:00');,
  INSERT INTO "t_system_config" VALUES (3, 'maxPwdError', '3', '允许最大输入错误次数', '2015-01-01 00:00:00', '2015-01-01 00:00:00');,
  INSERT INTO "t_system_config" VALUES (4, 'locktime', '0', '超过指定次数后锁定时间，单位：分', '2015-01-01 00:00:00', '2015-01-01 00:00:00');,
  INSERT INTO "t_system_config" VALUES (5, 'errorIntervalTime', '10', '累计统计错误次数时间，单位：分', '2015-01-01 00:00:00', '2015-01-01 00:00:00');,
  INSERT INTO "t_system_config" VALUES (6, 'sessionTimeout', '30', '无操作退出时间，单位：分', '2015-01-01 00:00:00', '2015-01-01 00:00:00');,
  INSERT INTO "t_system_config" VALUES (7, 'p1title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');,
  INSERT INTO "t_system_config" VALUES (8, 'p2title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');,
  INSERT INTO "t_system_config" VALUES (9, 'p3title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');,
  INSERT INTO "t_system_config" VALUES (10, 'p4title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');,
  INSERT INTO "t_system_config" VALUES (11, 'p5title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');,
  INSERT INTO "t_system_config" VALUES (12, 'p6title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');,
  INSERT INTO "t_system_config" VALUES (13, 'p7title', '标题', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');,
  INSERT INTO "t_system_config" VALUES (14, 'clientDomain', 'AiLPHA安全分析与管理平台', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');,
  INSERT INTO "t_system_config` VALUES (15, 'clientProvince', '浙江', 'NULL', '2026-01-13 10:37:38', '2026-01-13 10:37:38');,
  "SET" FOREIGN_KEY_CHECKS = 1;

-- Indexes
CREATE UNIQUE INDEX "i_system_config_name" ON "t_system_config" ("name");

-- Column comments
COMMENT ON COLUMN "t_system_config"."id" IS 'id';
COMMENT ON COLUMN "t_system_config"."name" IS '名称';
COMMENT ON COLUMN "t_system_config"."value" IS '值';
COMMENT ON COLUMN "t_system_config"."description" IS '描述';
COMMENT ON COLUMN "t_system_config"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_system_config"."updatetime" IS '修改时间';


-- Enable foreign key checks
SET session_replication_role = 'origin';

-- Update sequences
-- Run after data import:
-- SELECT setval(pg_get_serial_sequence('table_name', 'id_column'), (SELECT MAX(id_column) FROM table_name));
