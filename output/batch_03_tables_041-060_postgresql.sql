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


DROP TABLE IF EXISTS "t_asset_attack_surface";
CREATE TABLE "t_asset_attack_surface"  (
  "id" VARCHAR(50)   NOT NULL,
  "asset_name" VARCHAR(255)   NULL DEFAULT NULL,
  "asset_info_id" INTEGER NULL DEFAULT NULL,
  "asset_ip" VARCHAR(255)   NULL DEFAULT NULL,
  "asset_type_name" VARCHAR(255)   NULL DEFAULT NULL,
  "security_zone_id" VARCHAR(255)   NULL DEFAULT NULL,
  "exposed_ports" VARCHAR(5000)   NULL DEFAULT NULL,
  "app_protocol" VARCHAR(2000)   NULL DEFAULT NULL,
  "port_status" text   NULL,
  "port_protocol" text   NULL,
  "display_port_protocol" VARCHAR(2000)   NULL DEFAULT NULL,
  "fingerprint" VARCHAR(2000)   NULL DEFAULT NULL,
  "asset_status" VARCHAR(255)   NULL DEFAULT 'exposed',
  "visit_count" BIGINT NULL DEFAULT 0,
  "attack_count" BIGINT NULL DEFAULT 0,
  "attack_success_count" BIGINT NULL DEFAULT 0,
  "latest_time" timestamp NULL DEFAULT NULL,
  "create_time" timestamp NULL DEFAULT NULL,
  "update_time" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "date" VARCHAR(255)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "ip_date" ON "t_asset_attack_surface" ("asset_ip", "date");

-- Column comments
COMMENT ON COLUMN "t_asset_attack_surface"."id" IS '主键';
COMMENT ON COLUMN "t_asset_attack_surface"."asset_name" IS '资产名称\r\n';
COMMENT ON COLUMN "t_asset_attack_surface"."asset_ip" IS '资产ip';
COMMENT ON COLUMN "t_asset_attack_surface"."asset_type_name" IS '资产类型';
COMMENT ON COLUMN "t_asset_attack_surface"."security_zone_id" IS '安全域id\r\n';
COMMENT ON COLUMN "t_asset_attack_surface"."exposed_ports" IS '暴露端口，多个用逗号分隔';
COMMENT ON COLUMN "t_asset_attack_surface"."app_protocol" IS '协议，多个协议使用逗号分隔';
COMMENT ON COLUMN "t_asset_attack_surface"."port_status" IS '端口状态json';
COMMENT ON COLUMN "t_asset_attack_surface"."port_protocol" IS '端口协议json';
COMMENT ON COLUMN "t_asset_attack_surface"."display_port_protocol" IS '暴露端口，用于列表和详情展示';
COMMENT ON COLUMN "t_asset_attack_surface"."fingerprint" IS '资产指纹，用于列表和详情展示';
COMMENT ON COLUMN "t_asset_attack_surface"."asset_status" IS '多个标签使用逗号分隔';
COMMENT ON COLUMN "t_asset_attack_surface"."visit_count" IS '访问次数';
COMMENT ON COLUMN "t_asset_attack_surface"."attack_count" IS '攻击次数';
COMMENT ON COLUMN "t_asset_attack_surface"."attack_success_count" IS '攻击成功次数';
COMMENT ON COLUMN "t_asset_attack_surface"."latest_time" IS '最近访问时间';
COMMENT ON COLUMN "t_asset_attack_surface"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_asset_attack_surface"."date" IS '日期，当前数据的日期';


DROP TABLE IF EXISTS "t_asset_attack_surface_port";
CREATE TABLE "t_asset_attack_surface_port"  (
  "id" SERIAL,
  "port" VARCHAR(255)   NULL DEFAULT NULL,
  "is_default" BOOLEAN NULL DEFAULT 0,
  "create_time" timestamp NULL DEFAULT NULL,
  "update_time" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_asset_attack_surface_port" VALUES (1, '20', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_asset_attack_surface_port" VALUES (2, '21', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_asset_attack_surface_port" VALUES (3, '22', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_asset_attack_surface_port" VALUES (4, '23', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_asset_attack_surface_port" VALUES (5, '25', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_asset_attack_surface_port" VALUES (6, '69', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_asset_attack_surface_port" VALUES (7, '80', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_asset_attack_surface_port" VALUES (8, '445', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_asset_attack_surface_port" VALUES (9, '3389', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_asset_attack_surface_port" VALUES (10, '514', 1, '2026-01-13 10:37:47', '2026-01-13 10:37:47');

-- Column comments
COMMENT ON COLUMN "t_asset_attack_surface_port"."port" IS '端口';
COMMENT ON COLUMN "t_asset_attack_surface_port"."is_default" IS '是否内置端口';
COMMENT ON COLUMN "t_asset_attack_surface_port"."create_time" IS '创建时间';


DROP TABLE IF EXISTS "t_asset_attack_surface_url";
CREATE TABLE "t_asset_attack_surface_url"  (
  "id" VARCHAR(50)   NOT NULL,
  "asset_ip" VARCHAR(50)   NULL DEFAULT NULL,
  "asset_name" VARCHAR(255)   NULL DEFAULT NULL,
  "asset_type_name" VARCHAR(255)   NULL DEFAULT NULL,
  "dest_ports" VARCHAR(20)   NULL DEFAULT NULL,
  "dest_host_name" VARCHAR(255)   NULL DEFAULT NULL,
  "request_url" VARCHAR(255)   NULL DEFAULT NULL,
  "src_user_name" text   NULL,
  "cat_outcome" VARCHAR(255)   NULL DEFAULT NULL,
  "visit_count" BIGINT NULL DEFAULT NULL,
  "oldest_time" TIMESTAMP NULL DEFAULT NULL,
  "latest_time" TIMESTAMP NULL DEFAULT NULL,
  "create_time" TIMESTAMP NULL DEFAULT NULL,
  "update_time" TIMESTAMP NULL DEFAULT NULL,
  "date" VARCHAR(50)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "group_field" ON "t_asset_attack_surface_url" ("asset_ip", "date", "dest_ports", "request_url", "dest_host_name");

-- Column comments
COMMENT ON COLUMN "t_asset_attack_surface_url"."id" IS '主键';
COMMENT ON COLUMN "t_asset_attack_surface_url"."asset_name" IS '资产名称';
COMMENT ON COLUMN "t_asset_attack_surface_url"."asset_type_name" IS '用户名数量';
COMMENT ON COLUMN "t_asset_attack_surface_url"."dest_ports" IS '所有暴露端口json保存';
COMMENT ON COLUMN "t_asset_attack_surface_url"."dest_host_name" IS '域名';
COMMENT ON COLUMN "t_asset_attack_surface_url"."request_url" IS '暴露接口';
COMMENT ON COLUMN "t_asset_attack_surface_url"."src_user_name" IS '用户名数组json保存全部';
COMMENT ON COLUMN "t_asset_attack_surface_url"."cat_outcome" IS '登录结果';


DROP TABLE IF EXISTS "t_asset_cal_results";
CREATE TABLE "t_asset_cal_results"  (
  "id" BIGSERIAL,
  "assetIp" VARCHAR(45)   NOT NULL,
  "flawHigh" BIGINT NULL DEFAULT 0,
  "flawLow" BIGINT NULL DEFAULT 0,
  "flawMiddle" BIGINT NULL DEFAULT 0,
  "flawSum" BIGINT NULL DEFAULT 0,
  "incidentHigh" BIGINT NULL DEFAULT 0,
  "incidentLow" BIGINT NULL DEFAULT 0,
  "incidentMiddle" BIGINT NULL DEFAULT 0,
  "incidentSum" BIGINT NULL DEFAULT 0,
  "score" DOUBLE PRECISION NULL DEFAULT -1,
  "logCount" DOUBLE PRECISION NULL DEFAULT 0,
  "assetLevel" INTEGER NULL DEFAULT 0,
  "alarm_top" VARCHAR(2000)   NULL DEFAULT NULL,
  "last_alarm_time" VARCHAR(100)   NULL DEFAULT NULL,
  "first_fallen_time" VARCHAR(100)   NULL DEFAULT NULL,
  "update_time" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "assetId_UNIQUE" ON "t_asset_cal_results" ("assetIp");

-- Column comments
COMMENT ON COLUMN "t_asset_cal_results"."id" IS '主键Id';
COMMENT ON COLUMN "t_asset_cal_results"."assetIp" IS '资产ip';
COMMENT ON COLUMN "t_asset_cal_results"."score" IS '评分';
COMMENT ON COLUMN "t_asset_cal_results"."assetLevel" IS '资产评级';
COMMENT ON COLUMN "t_asset_cal_results"."alarm_top" IS '告警topN';
COMMENT ON COLUMN "t_asset_cal_results"."last_alarm_time" IS '最近告警发生时间';
COMMENT ON COLUMN "t_asset_cal_results"."first_fallen_time" IS '首次失陷时间';
COMMENT ON COLUMN "t_asset_cal_results"."update_time" IS '数据更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_asset_cal_results_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_asset_cal_results_update_timestamp
BEFORE UPDATE ON "t_asset_cal_results"
FOR EACH ROW
EXECUTE FUNCTION update_t_asset_cal_results_timestamp();


DROP TABLE IF EXISTS "t_asset_discover";
CREATE TABLE "t_asset_discover"  (
  "id" SERIAL,
  "type" INTEGER NOT NULL DEFAULT 0,
  "item" INTEGER NOT NULL DEFAULT 0,
  "content" VARCHAR(100)   NOT NULL,
  "stats" INTEGER NOT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_asset_discover"."type" IS '0:安全域（一对多content）；1:内部IP；2:网段';
COMMENT ON COLUMN "t_asset_discover"."item" IS '0:服务器；1:终端；2服务器和终端';
COMMENT ON COLUMN "t_asset_discover"."content" IS ' t_security_zone、 t_inner_ip_config的id';
COMMENT ON COLUMN "t_asset_discover"."stats" IS '0:禁用；1:启用';


DROP TABLE IF EXISTS "t_asset_evaluation";
CREATE TABLE "t_asset_evaluation"  (
  "id" BIGSERIAL,
  "asset_ip" VARCHAR(200)   NOT NULL,
  "asset_health_state" enum('healthy','low_risk','medium_risk','high_risk','fallen','unknown')   NOT NULL DEFAULT 'unknown',
  "asset_evaluation_tag" VARCHAR(50)   NULL DEFAULT NULL,
  "sub_category" VARCHAR(50)   NULL DEFAULT NULL,
  "alarm_results" VARCHAR(10)   NULL DEFAULT NULL,
  "alarm_top" text   NULL,
  "last_alarm_time" TIMESTAMP NULL DEFAULT NULL,
  "vulnerability" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
  "threat" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
  "value" SMALLINT NOT NULL,
  "asset_score" SMALLINT NOT NULL DEFAULT 0,
  "unprocessed_alarm_count" INTEGER NOT NULL DEFAULT 0,
  "unprocessed_cve_count" INTEGER NOT NULL DEFAULT 0,
  "evaluate_date" date NOT NULL,
  "evaluate_time" time NOT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "unique_evaluate_date_asset_ip" ON "t_asset_evaluation" ("evaluate_date", "asset_ip");

-- Column comments
COMMENT ON COLUMN "t_asset_evaluation"."id" IS '主键ID';
COMMENT ON COLUMN "t_asset_evaluation"."asset_ip" IS '资产IP';
COMMENT ON COLUMN "t_asset_evaluation"."asset_health_state" IS '资产健康状态枚举值[\"健康\"(healthy),\"低风险\"(low_risk),\"中风险\"(medium_risk),\"高风险\"(high_risk),\"已失陷\"(fallen),\"未知\"(unknown)]';
COMMENT ON COLUMN "t_asset_evaluation"."asset_evaluation_tag" IS '资产评级标签';
COMMENT ON COLUMN "t_asset_evaluation"."sub_category" IS '告警子类型';
COMMENT ON COLUMN "t_asset_evaluation"."alarm_results" IS '告警结果';
COMMENT ON COLUMN "t_asset_evaluation"."alarm_top" IS '告警Top3';
COMMENT ON COLUMN "t_asset_evaluation"."last_alarm_time" IS '上一次告警发送时间';
COMMENT ON COLUMN "t_asset_evaluation"."vulnerability" IS '脆弱性值（取值范围(0,10]，精度0.01，0表示N/A）';
COMMENT ON COLUMN "t_asset_evaluation"."threat" IS '威胁值（取值范围(0,10]，精度0.01，0表示N/A）';
COMMENT ON COLUMN "t_asset_evaluation"."value" IS '资产价值（取值范围[1-5]的整数）';
COMMENT ON COLUMN "t_asset_evaluation"."asset_score" IS '资产风险值（取值范围[1-100]的整数，0表示N/A）';
COMMENT ON COLUMN "t_asset_evaluation"."unprocessed_alarm_count" IS '本次评估时未处置的原始告警总数';
COMMENT ON COLUMN "t_asset_evaluation"."unprocessed_cve_count" IS '本次评估时带有cve编号的未处置原始告警总数';
COMMENT ON COLUMN "t_asset_evaluation"."evaluate_date" IS '本次评估日期';
COMMENT ON COLUMN "t_asset_evaluation"."evaluate_time" IS '本次评估时间';


DROP TABLE IF EXISTS "t_asset_find";
CREATE TABLE "t_asset_find"  (
  "id" BIGSERIAL,
  "ip" VARCHAR(20)   NOT NULL,
  "name" VARCHAR(100)   NOT NULL,
  "deviceType" VARCHAR(20)   NULL DEFAULT NULL,
  "securityZone" VARCHAR(128)   NULL DEFAULT NULL,
  "source" VARCHAR(20)   NOT NULL DEFAULT '扫描自动发现',
  "findTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "createtime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE INDEX "index_ip" ON "t_asset_find" ("ip");

-- Column comments
COMMENT ON COLUMN "t_asset_find"."ip" IS '资产IP';
COMMENT ON COLUMN "t_asset_find"."name" IS '资产名称';
COMMENT ON COLUMN "t_asset_find"."deviceType" IS '设备类型';
COMMENT ON COLUMN "t_asset_find"."securityZone" IS '安全域';
COMMENT ON COLUMN "t_asset_find"."source" IS '资产来源，1：扫描自动发现，2：流量自动发现';
COMMENT ON COLUMN "t_asset_find"."findTime" IS '发现时间';
COMMENT ON COLUMN "t_asset_find"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_asset_find"."updatetime" IS '修改时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_asset_find_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updatetime" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_asset_find_update_timestamp
BEFORE UPDATE ON "t_asset_find"
FOR EACH ROW
EXECUTE FUNCTION update_t_asset_find_timestamp();


DROP TABLE IF EXISTS "t_asset_fingerprint";
CREATE TABLE "t_asset_fingerprint"  (
  "asset_ip" VARCHAR(45)   NOT NULL,
  "port" VARCHAR(45)   NOT NULL,
  "protocol" VARCHAR(100)   NOT NULL,
  "fingerprint_name" VARCHAR(500)   NULL DEFAULT NULL,
  "fingerprint_type" VARCHAR(500)   NULL DEFAULT NULL,
  "create_time" timestamp NULL DEFAULT NULL,
  "update_time" timestamp NULL DEFAULT NULL,
  "fingerprint_version" VARCHAR(500)   NULL DEFAULT NULL,
  PRIMARY KEY ("asset_ip", "port", "protocol")
);

-- Column comments
COMMENT ON COLUMN "t_asset_fingerprint"."asset_ip" IS '资产ip';
COMMENT ON COLUMN "t_asset_fingerprint"."port" IS '端口';
COMMENT ON COLUMN "t_asset_fingerprint"."protocol" IS '协议';
COMMENT ON COLUMN "t_asset_fingerprint"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_asset_fingerprint"."update_time" IS '更新时间';


DROP TABLE IF EXISTS "t_asset_history";
CREATE TABLE "t_asset_history"  (
  "id" BIGSERIAL,
  "ip" VARCHAR(50)   NOT NULL,
  "changeType" VARCHAR(40)   NULL DEFAULT NULL,
  "port" VARCHAR(7)   NULL DEFAULT NULL,
  "vul" VARCHAR(127)   NULL DEFAULT NULL,
  "vulType" VARCHAR(40)   NULL DEFAULT NULL,
  "source" VARCHAR(40)   NULL DEFAULT NULL,
  "message" VARCHAR(255)   NULL DEFAULT NULL,
  "findTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "createtime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE INDEX "index_ip" ON "t_asset_history" ("ip");

-- Column comments
COMMENT ON COLUMN "t_asset_history"."ip" IS '资产IP或域名';
COMMENT ON COLUMN "t_asset_history"."changeType" IS '变更类型，1：新发现未备案资产，2：备案资产不在线，3：新发现开放端口，4：以开放端口被关闭，5：新发现漏洞，6：已发现漏洞修复';
COMMENT ON COLUMN "t_asset_history"."port" IS '端口';
COMMENT ON COLUMN "t_asset_history"."vul" IS '漏洞';
COMMENT ON COLUMN "t_asset_history"."vulType" IS '漏洞类型，1：主机，2：web，3：基线，4：弱口令，5：数据库';
COMMENT ON COLUMN "t_asset_history"."source" IS '资产来源，1：扫描自动发现，2：流量自动发现';
COMMENT ON COLUMN "t_asset_history"."message" IS '变更记录描述信息';
COMMENT ON COLUMN "t_asset_history"."findTime" IS '发现时间';
COMMENT ON COLUMN "t_asset_history"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_asset_history"."updatetime" IS '修改时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_asset_history_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updatetime" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_asset_history_update_timestamp
BEFORE UPDATE ON "t_asset_history"
FOR EACH ROW
EXECUTE FUNCTION update_t_asset_history_timestamp();


DROP TABLE IF EXISTS "t_asset_history_status";
CREATE TABLE "t_asset_history_status"  (
  "id" BIGSERIAL,
  "userId" BIGINT NOT NULL,
  "historyId" BIGINT NOT NULL,
  "status" enum('1','0')   NOT NULL DEFAULT '1',
  "createtime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
  CONSTRAINT "fk_historyId" FOREIGN KEY ("historyId") REFERENCES "t_asset_history" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT
  CONSTRAINT "fk_userId" FOREIGN KEY ("userId") REFERENCES "t_user" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Indexes
CREATE INDEX "index_ip" ON "t_asset_history_status" ("userId");
CREATE INDEX "fk_historyId" ON "t_asset_history_status" ("historyId");

-- Column comments
COMMENT ON COLUMN "t_asset_history_status"."userId" IS '用户ID';
COMMENT ON COLUMN "t_asset_history_status"."historyId" IS '变更记录ID';
COMMENT ON COLUMN "t_asset_history_status"."status" IS '状态，1：已读，0：未读';
COMMENT ON COLUMN "t_asset_history_status"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_asset_history_status"."updatetime" IS '修改时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_asset_history_status_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updatetime" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_asset_history_status_update_timestamp
BEFORE UPDATE ON "t_asset_history_status"
FOR EACH ROW
EXECUTE FUNCTION update_t_asset_history_status_timestamp();


DROP TABLE IF EXISTS "t_asset_info";
CREATE TABLE "t_asset_info"  (
  "id" SERIAL,
  "assetIp" VARCHAR(45)   NOT NULL,
  "assetName" VARCHAR(300)   NOT NULL DEFAULT '',
  "assetCode" VARCHAR(45)   NULL DEFAULT '',
  "assetType" VARCHAR(45)   NULL DEFAULT '',
  "assetImportance" VARCHAR(45)   NULL DEFAULT '',
  "assetStatus" VARCHAR(45)   NULL DEFAULT '',
  "assetTags" VARCHAR(500)   NULL DEFAULT '',
  "personInCharge" VARCHAR(45)   NULL DEFAULT '',
  "assetUser" VARCHAR(45)   NULL DEFAULT '',
  "belongedBusinessSystem" VARCHAR(45)   NULL DEFAULT '',
  "assetGroup" VARCHAR(45)   NULL DEFAULT '',
  "location" VARCHAR(45)   NULL DEFAULT '',
  "storeLocation" VARCHAR(45)   NULL DEFAULT '',
  "confidentiality" VARCHAR(45)   NULL DEFAULT '',
  "integrity" VARCHAR(45)   NULL DEFAULT '',
  "availability" VARCHAR(45)   NULL DEFAULT '',
  "isHierarchyProtection" VARCHAR(45)   NULL DEFAULT '',
  "description" VARCHAR(500)   NULL DEFAULT '',
  "os" VARCHAR(150)   NULL DEFAULT '',
  "osVersion" VARCHAR(150)   NULL DEFAULT '',
  "macAddress" VARCHAR(255)   NULL DEFAULT NULL,
  "enablePorts" VARCHAR(500)   NULL DEFAULT '',
  "deviceManufacturer" VARCHAR(45)   NULL DEFAULT '',
  "deviceModel" VARCHAR(45)   NULL DEFAULT '',
  "deviceVersion" VARCHAR(45)   NULL DEFAULT '',
  "source" VARCHAR(45)   NULL DEFAULT '0',
  "lastModifiedTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "edr_id" VARCHAR(150)   NULL DEFAULT NULL,
  "edr_stats" INTEGER NOT NULL DEFAULT 0,
  "edr_switch" INTEGER NOT NULL DEFAULT 0,
  "assetIpNum" VARCHAR(100)   NULL DEFAULT NULL,
  "app_id" VARCHAR(50)   NULL DEFAULT NULL,
  "device_id" VARCHAR(50)   NULL DEFAULT NULL,
  "value" SMALLINT NULL DEFAULT NULL,
  "asset_id" VARCHAR(100)   NULL DEFAULT NULL,
  "edr_exception_status" SMALLINT NULL DEFAULT -1,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "assetIp_UNIQUE" ON "t_asset_info" ("assetIp");
CREATE UNIQUE INDEX "assetId_UNIQUE" ON "t_asset_info" ("asset_id");
CREATE INDEX "assetIpNum_uk" ON "t_asset_info" ("assetIpNum");

-- Column comments
COMMENT ON COLUMN "t_asset_info"."id" IS '主键id';
COMMENT ON COLUMN "t_asset_info"."assetIp" IS '资产ip';
COMMENT ON COLUMN "t_asset_info"."assetName" IS '资产名称';
COMMENT ON COLUMN "t_asset_info"."assetCode" IS '资产编号';
COMMENT ON COLUMN "t_asset_info"."assetType" IS '资产类型';
COMMENT ON COLUMN "t_asset_info"."assetImportance" IS '资产重要性';
COMMENT ON COLUMN "t_asset_info"."assetStatus" IS '资产状态';
COMMENT ON COLUMN "t_asset_info"."assetTags" IS '资产标签';
COMMENT ON COLUMN "t_asset_info"."personInCharge" IS '责任人';
COMMENT ON COLUMN "t_asset_info"."assetUser" IS '使用人';
COMMENT ON COLUMN "t_asset_info"."belongedBusinessSystem" IS '所属业务系统';
COMMENT ON COLUMN "t_asset_info"."assetGroup" IS '资产组';
COMMENT ON COLUMN "t_asset_info"."location" IS '地理位置';
COMMENT ON COLUMN "t_asset_info"."storeLocation" IS '设备存放地址';
COMMENT ON COLUMN "t_asset_info"."confidentiality" IS 'C-机密性';
COMMENT ON COLUMN "t_asset_info"."integrity" IS 'I-完整性';
COMMENT ON COLUMN "t_asset_info"."availability" IS 'A-可用性';
COMMENT ON COLUMN "t_asset_info"."isHierarchyProtection" IS '是否等保';
COMMENT ON COLUMN "t_asset_info"."description" IS '描述';
COMMENT ON COLUMN "t_asset_info"."os" IS '操作系统';
COMMENT ON COLUMN "t_asset_info"."osVersion" IS '操作系统版本';
COMMENT ON COLUMN "t_asset_info"."enablePorts" IS '允许开放端口';
COMMENT ON COLUMN "t_asset_info"."deviceManufacturer" IS '设备厂商';
COMMENT ON COLUMN "t_asset_info"."deviceModel" IS '设备型号';
COMMENT ON COLUMN "t_asset_info"."deviceVersion" IS '设备版本';
COMMENT ON COLUMN "t_asset_info"."source" IS '来源:0-其它，1-手动，2-导入，3-自动发现';
COMMENT ON COLUMN "t_asset_info"."lastModifiedTime" IS '最后更新时间';
COMMENT ON COLUMN "t_asset_info"."edr_id" IS 'EDR资产唯一标识';
COMMENT ON COLUMN "t_asset_info"."edr_stats" IS 'EDR防护状态分为：防护中（2）、停止防护（1）、-(0非EDR资产)';
COMMENT ON COLUMN "t_asset_info"."edr_switch" IS '是否为安恒RDR联动设备，默认0不是，1是。';
COMMENT ON COLUMN "t_asset_info"."assetIpNum" IS 'IP的去除符号16进制字符串';
COMMENT ON COLUMN "t_asset_info"."app_id" IS '联动设备类型';
COMMENT ON COLUMN "t_asset_info"."device_id" IS '联动设备id';
COMMENT ON COLUMN "t_asset_info"."value" IS '记录用户手动修改过的资产价值（取值范围[1-5]的整数；默认为null）';
COMMENT ON COLUMN "t_asset_info"."asset_id" IS '资产id，用来打资产ID使用';
COMMENT ON COLUMN "t_asset_info"."edr_exception_status" IS 'edr隔离状态 1已隔离 0未隔离';


DROP TABLE IF EXISTS "t_asset_manage";
CREATE TABLE "t_asset_manage"  (
  "id" SERIAL,
  "assetIp" VARCHAR(45)   NOT NULL,
  "securityDevice" VARCHAR(150)   NULL DEFAULT NULL,
  "webSystem" VARCHAR(15000)   NULL DEFAULT NULL,
  "logMonitor" INTEGER NOT NULL DEFAULT 0,
  "logMonitorValue" VARCHAR(100)   NULL DEFAULT NULL,
  "onlineDetect" INTEGER NOT NULL DEFAULT 0,
  "onlineDetectStats" INTEGER NOT NULL DEFAULT -1,
  "manageAddress" INTEGER NOT NULL DEFAULT 0,
  "manageAddressDetail" VARCHAR(1000)   NULL DEFAULT NULL,
  "disposalLinkage" INTEGER NOT NULL DEFAULT 0,
  "disposalLinkagePort" INTEGER NULL DEFAULT NULL,
  "disposalLinkageStats" INTEGER NOT NULL DEFAULT 0,
  "onlineDetectMethod" INTEGER NOT NULL DEFAULT 0,
  "onlineDetectCycle" INTEGER NOT NULL DEFAULT 2,
  "netraffic" INTEGER NOT NULL DEFAULT 0,
  "openPortMonitor" INTEGER NOT NULL DEFAULT 0,
  "openPortMax" INTEGER NULL DEFAULT NULL,
  "openPort" VARCHAR(100)   NULL DEFAULT NULL,
  "externalMonitor" INTEGER NOT NULL DEFAULT 0,
  "externalMax" INTEGER NULL DEFAULT NULL,
  "uploadRate" VARCHAR(45)   NULL DEFAULT NULL,
  "downloadRate" VARCHAR(45)   NULL DEFAULT NULL,
  "requestRate" VARCHAR(45)   NULL DEFAULT NULL,
  "responseRate" VARCHAR(45)   NULL DEFAULT NULL,
  "currentvolume" VARCHAR(45)   NULL DEFAULT NULL,
  "sDayFlow" VARCHAR(45)   NULL DEFAULT NULL,
  "createTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updateTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "other" VARCHAR(45)   NULL DEFAULT NULL,
  "edr_user" VARCHAR(45)   NULL DEFAULT NULL,
  "edr_pwd" VARCHAR(45)   NULL DEFAULT NULL,
  "edr_login" INTEGER NULL DEFAULT NULL,
  "scanPort" VARCHAR(50)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "assetIp_UNIQUE" ON "t_asset_manage" ("assetIp");

-- Column comments
COMMENT ON COLUMN "t_asset_manage"."webSystem" IS 'web系统';
COMMENT ON COLUMN "t_asset_manage"."logMonitor" IS '0:关闭；1开启';
COMMENT ON COLUMN "t_asset_manage"."logMonitorValue" IS '7各点；日期将来可能需要带';
COMMENT ON COLUMN "t_asset_manage"."onlineDetect" IS '0:关闭；1开启';
COMMENT ON COLUMN "t_asset_manage"."onlineDetectStats" IS '0:离线；1在线';
COMMENT ON COLUMN "t_asset_manage"."manageAddress" IS '管理地址：0:关闭；1开启';
COMMENT ON COLUMN "t_asset_manage"."manageAddressDetail" IS '管理地址';
COMMENT ON COLUMN "t_asset_manage"."disposalLinkage" IS '处置联动:0:关闭；1开启';
COMMENT ON COLUMN "t_asset_manage"."disposalLinkagePort" IS '处置联动端口';
COMMENT ON COLUMN "t_asset_manage"."disposalLinkageStats" IS '处置联动状态：0:连接失败；1连接成功';
COMMENT ON COLUMN "t_asset_manage"."onlineDetectMethod" IS '在线状态检测方式：0:是否接入日志；1:PING';
COMMENT ON COLUMN "t_asset_manage"."onlineDetectCycle" IS '在线状态检测周期：0:1分钟；1:10分钟；2:30分钟；3:1小时；4:12小时；5:1天';
COMMENT ON COLUMN "t_asset_manage"."netraffic" IS '流量监控:0关闭；1开启';
COMMENT ON COLUMN "t_asset_manage"."openPortMonitor" IS '开放端口监控:0:关闭；1开启';
COMMENT ON COLUMN "t_asset_manage"."openPortMax" IS '响应流量阀值';
COMMENT ON COLUMN "t_asset_manage"."openPort" IS '允许开放端口';
COMMENT ON COLUMN "t_asset_manage"."externalMonitor" IS '外连行为监控:0关闭，1开启';
COMMENT ON COLUMN "t_asset_manage"."externalMax" IS '请求流量阀值';
COMMENT ON COLUMN "t_asset_manage"."uploadRate" IS '上传速率';
COMMENT ON COLUMN "t_asset_manage"."downloadRate" IS '下载速率';
COMMENT ON COLUMN "t_asset_manage"."requestRate" IS '请求速率';
COMMENT ON COLUMN "t_asset_manage"."responseRate" IS '响应速率';
COMMENT ON COLUMN "t_asset_manage"."sDayFlow" IS '7天流量';
COMMENT ON COLUMN "t_asset_manage"."edr_user" IS 'EDR用户名';
COMMENT ON COLUMN "t_asset_manage"."edr_pwd" IS 'EDR密码';
COMMENT ON COLUMN "t_asset_manage"."edr_login" IS 'EDR访问状态。0访问失败，1免登访问成功';
COMMENT ON COLUMN "t_asset_manage"."scanPort" IS '弱点管理平台扫描端口';


DROP TABLE IF EXISTS "t_asset_port";
CREATE TABLE "t_asset_port"  (
  "id" SERIAL,
  "assetIp" VARCHAR(45)   NOT NULL,
  "port" VARCHAR(45)   NOT NULL,
  "protocol" VARCHAR(100)   NULL DEFAULT NULL,
  "serviceName" VARCHAR(255)   NULL DEFAULT NULL,
  "serverVersion" VARCHAR(255)   NULL DEFAULT NULL,
  "status" CHAR(1)   NOT NULL,
  "message" VARCHAR(255)   NULL DEFAULT NULL,
  "findTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "createtime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "name_uni" ON "t_asset_port" ("assetIp", "port");

-- Column comments
COMMENT ON COLUMN "t_asset_port"."id" IS '主键Id';
COMMENT ON COLUMN "t_asset_port"."assetIp" IS '资产ip';
COMMENT ON COLUMN "t_asset_port"."port" IS '端口';
COMMENT ON COLUMN "t_asset_port"."protocol" IS '协议';
COMMENT ON COLUMN "t_asset_port"."serviceName" IS '服务名';
COMMENT ON COLUMN "t_asset_port"."serverVersion" IS '服务版本';
COMMENT ON COLUMN "t_asset_port"."status" IS '端口状态，1：开启，0：关闭';
COMMENT ON COLUMN "t_asset_port"."message" IS '变更记录描述信息';
COMMENT ON COLUMN "t_asset_port"."findTime" IS '创建时间';
COMMENT ON COLUMN "t_asset_port"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_asset_port"."updatetime" IS '修改时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_asset_port_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updatetime" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_asset_port_update_timestamp
BEFORE UPDATE ON "t_asset_port"
FOR EACH ROW
EXECUTE FUNCTION update_t_asset_port_timestamp();


DROP TABLE IF EXISTS "t_asset_virus";
CREATE TABLE "t_asset_virus"  (
  "id" BIGSERIAL,
  "name" VARCHAR(255)   NOT NULL,
  "path" VARCHAR(1024)   NOT NULL,
  "hash" VARCHAR(64)   NOT NULL,
  "node_id" VARCHAR(64)   NOT NULL,
  "asset_ip" VARCHAR(64)   NOT NULL,
  "create_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_asset_virus"."id" IS '主键';
COMMENT ON COLUMN "t_asset_virus"."name" IS '病毒名称';
COMMENT ON COLUMN "t_asset_virus"."path" IS '路径';
COMMENT ON COLUMN "t_asset_virus"."hash" IS '文件hash';
COMMENT ON COLUMN "t_asset_virus"."node_id" IS '资产id，EDR_ID';
COMMENT ON COLUMN "t_asset_virus"."asset_ip" IS '资产ip';
COMMENT ON COLUMN "t_asset_virus"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_asset_virus"."update_time" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_asset_virus_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_asset_virus_update_timestamp
BEFORE UPDATE ON "t_asset_virus"
FOR EACH ROW
EXECUTE FUNCTION update_t_asset_virus_timestamp();


DROP TABLE IF EXISTS "t_attack_update";
CREATE TABLE "t_attack_update"  (
  "id" INTEGER NOT NULL,
  "attack_intent_name" VARCHAR(512)   NOT NULL,
  "attack_intent" VARCHAR(512)   NOT NULL,
  "attack_strategy_name" VARCHAR(512)   NOT NULL,
  "attack_strategy" VARCHAR(512)   NOT NULL,
  "attack_method_name" VARCHAR(512)   NOT NULL,
  "attack_method" VARCHAR(512)   NOT NULL,
  "attack_category" VARCHAR(512)   NOT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_attack_update" VALUES (1, '利用型攻击', 'exploitAttack', '信息泄露', 'infoLeakage', '数据库信息泄露', 'DBLeakage', '/SuspTraffic/SuspContent');,
  INSERT INTO "t_attack_update" VALUES (2, '利用型攻击', 'exploitAttack', '信息泄露', 'infoLeakage', 'web服务器信息泄露', 'webLeakage', '/WebAttack/InfoLeak');,
  INSERT INTO "t_attack_update" VALUES (3, '利用型攻击', 'exploitAttack', '信息泄露', 'infoLeakage', '目录信息泄漏', 'dirInfoLeakage', '/WebAttack/InfoLeak');,
  INSERT INTO "t_attack_update" VALUES (4, '利用型攻击', 'exploitAttack', '信息泄露', 'infoLeakage', '源代码信息泄露', 'sourceCodeInfoLeakage', '/WebAttack/InfoLeak');,
  INSERT INTO "t_attack_update" VALUES (5, '利用型攻击', 'exploitAttack', '信息泄露', 'infoLeakage', '其他', 'others', '/WebAttack/InfoLeak');,
  INSERT INTO "t_attack_update" VALUES (6, '利用型攻击', 'exploitAttack', '越权攻击', 'crossPrivilege', '绕过安全设备', 'bypassDevice', '/ConfigRisk/DeviceConf');,
  INSERT INTO "t_attack_update" VALUES (7, '利用型攻击', 'exploitAttack', '越权攻击', 'crossPrivilege', '其他', 'others', '/ConfigRisk/DeviceConf');,
  INSERT INTO "t_attack_update" VALUES (8, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', '操作系统暴力破解', 'OSBruteForce', '/AccountRisk/BruteForce');,
  INSERT INTO "t_attack_update" VALUES (9, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', 'Web暴力破解', 'webBruteForce', '/AccountRisk/BruteForce');,
  INSERT INTO "t_attack_update" VALUES (10, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', '数据库暴力破解', 'DBBruteForce', '/AccountRisk/BruteForce');,
  INSERT INTO "t_attack_update" VALUES (11, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', 'VPN暴力破解', 'VPNBruteForce', '/AccountRisk/BruteForce');,
  INSERT INTO "t_attack_update" VALUES (12, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', 'SSH暴力破解', 'SSHBruteForce', '/AccountRisk/BruteForce');,
  INSERT INTO "t_attack_update" VALUES (13, '利用型攻击', 'exploitAttack', '密码破解', 'passwordCracking', '其他', 'others', '/AccountRisk/BruteForce');,
  INSERT INTO "t_attack_update" VALUES (14, '利用型攻击', 'exploitAttack', '注入攻击', 'injectionAttack', 'SQL注入', 'SQLInjection', '/WebAttack/SQLInjection');,
  INSERT INTO "t_attack_update" VALUES (15, '利用型攻击', 'exploitAttack', '注入攻击', 'injectionAttack', '命令注入', 'commandInjection', '/WebAttack/CommandExec');,
  INSERT INTO "t_attack_update" VALUES (16, '利用型攻击', 'exploitAttack', '注入攻击', 'injectionAttack', '代码注入', 'codeInjection', '/WebAttack/CodeInjection');,
  INSERT INTO "t_attack_update" VALUES (17, '利用型攻击', 'exploitAttack', '注入攻击', 'injectionAttack', '其他', 'others', '/WebAttack/CodeInjection');,
  INSERT INTO "t_attack_update" VALUES (18, '利用型攻击', 'exploitAttack', '跨站攻击', 'crossSiteAttack', '跨站脚本攻击', 'XSS', '/WebAttack/XSS');,
  INSERT INTO "t_attack_update" VALUES (19, '利用型攻击', 'exploitAttack', '跨站攻击', 'crossSiteAttack', '跨站请求伪造', 'CSRF', '/WebAttack/CSRF');,
  INSERT INTO "t_attack_update" VALUES (20, '利用型攻击', 'exploitAttack', '跨站攻击', 'crossSiteAttack', '其他', 'others', '/WebAttack/Others');,
  INSERT INTO "t_attack_update" VALUES (21, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '网站恶意行为', 'webMalAction', '/WebAttack/Others');,
  INSERT INTO "t_attack_update" VALUES (22, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '邮件恶意行为', 'emailMalAction', '/Malware/MaliciousMail');,
  INSERT INTO "t_attack_update" VALUES (23, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '恶意链接', 'malLink', '/SuspTraffic/SuspContent');,
  INSERT INTO "t_attack_update" VALUES (24, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '操作系统恶意行为', 'OSMalAction', '/Exploit/SystemVul');,
  INSERT INTO "t_attack_update" VALUES (25, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '数据库恶意行为', 'DBMalAction', '/Exploit/SoftVul');,
  INSERT INTO "t_attack_update" VALUES (26, '利用型攻击', 'exploitAttack', '恶意行为', 'malAction', '其他', 'others', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (27, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', 'ARP欺骗', 'ARP', '/LateralMov/SuspiciousSpread');,
  INSERT INTO "t_attack_update" VALUES (28, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', 'IP欺骗', 'IPSpoofing', '/SuspTraffic/MaliciousIP');,
  INSERT INTO "t_attack_update" VALUES (29, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', 'DNS欺骗', 'DNSSpoofing', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (30, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', 'ICMP欺骗', 'ICMPSpoofing', '/LateralMov/SuspiciousSpread');,
  INSERT INTO "t_attack_update" VALUES (31, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', '网络钓鱼', 'phishingSite', '/SuspTraffic/SuspContent');,
  INSERT INTO "t_attack_update" VALUES (32, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', '邮件欺骗', 'emailSpoofing', '/Malware/MaliciousMail');,
  INSERT INTO "t_attack_update" VALUES (33, '利用型攻击', 'exploitAttack', '欺骗型攻击', 'spoofingAttack', '其他', 'others', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (34, '利用型攻击', 'exploitAttack', '漏洞利用', 'vulnerabilityExploitation', 'web漏洞', 'webVulnerability', '/WebAttack/CodeInjection');,
  INSERT INTO "t_attack_update" VALUES (35, '利用型攻击', 'exploitAttack', '漏洞利用', 'vulnerabilityExploitation', '系统漏洞', 'systemVulnerability', '/Exploit/SystemVul');,
  INSERT INTO "t_attack_update" VALUES (36, '利用型攻击', 'exploitAttack', '漏洞利用', 'vulnerabilityExploitation', '软件漏洞', 'softwareVulnerability', '/Exploit/SoftVul');,
  INSERT INTO "t_attack_update" VALUES (37, '利用型攻击', 'exploitAttack', '漏洞利用', 'vulnerabilityExploitation', '硬件漏洞', 'hardwareVulnerability', '/Exploit/DeviceVul');,
  INSERT INTO "t_attack_update" VALUES (38, '利用型攻击', 'exploitAttack', '漏洞利用', 'vulnerabilityExploitation', '其他', 'others', '/Exploit/Others');,
  INSERT INTO "t_attack_update" VALUES (39, '利用型攻击', 'exploitAttack', '其他', 'others', '其他', 'others', '/Exploit/Others');,
  INSERT INTO "t_attack_update" VALUES (40, '恶意文件', 'maliciousFile', '后门程序', 'backdoor', 'webshell', 'webshell', '/WebAttack/WebshellRequest');,
  INSERT INTO "t_attack_update" VALUES (41, '恶意文件', 'maliciousFile', '后门程序', 'backdoor', '主机后门', 'hostBackdoor', '/WebAttack/WebshellRequest');,
  INSERT INTO "t_attack_update" VALUES (42, '恶意文件', 'maliciousFile', '后门程序', 'backdoor', '其他', 'others', '/WebAttack/WebshellRequest');,
  INSERT INTO "t_attack_update" VALUES (43, '恶意文件', 'maliciousFile', '僵木蠕', 'botnetTrojanWorm', '木马', 'trojan', '/Malware/BotTrojWorm');,
  INSERT INTO "t_attack_update" VALUES (44, '恶意文件', 'maliciousFile', '僵木蠕', 'botnetTrojanWorm', '域名回连', 'domainBackConnect', '/Malware/BotTrojWorm');,
  INSERT INTO "t_attack_update" VALUES (45, '恶意文件', 'maliciousFile', '僵木蠕', 'botnetTrojanWorm', '僵尸网络', 'botnets', '/Malware/BotTrojWorm');,
  INSERT INTO "t_attack_update" VALUES (46, '恶意文件', 'maliciousFile', '僵木蠕', 'botnetTrojanWorm', '蠕虫', 'worm', '/Malware/BotTrojWorm');,
  INSERT INTO "t_attack_update" VALUES (47, '恶意文件', 'maliciousFile', '僵木蠕', 'botnetTrojanWorm', '其他', 'others', '/Malware/BotTrojWorm');,
  INSERT INTO "t_attack_update" VALUES (48, '恶意文件', 'maliciousFile', '病毒', 'virus', '网络病毒', 'networkVirus', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (49, '恶意文件', 'maliciousFile', '病毒', 'virus', '计算机病毒', 'hostVirus', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (50, '恶意文件', 'maliciousFile', '病毒', 'virus', '其他', 'others', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (51, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '恶意广告', 'malvertisement', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (52, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '勒索软件', 'ransomware', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (53, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '挖矿软件', 'miner', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (54, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '黑市工具', 'hackerKit', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (55, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '流氓推广', 'immoralSpread', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (56, '恶意文件', 'maliciousFile', '灰色软件', 'grayware', '其他', 'others', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (57, '恶意文件', 'maliciousFile', '其他', 'others', '其他', 'others', '/SuspTraffic/MaliciousDomain');,
  INSERT INTO "t_attack_update" VALUES (58, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'SYN Flood', 'SYNFlood', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (59, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'UDP Flood', 'UDPFlood', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (60, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'ICMP Flood', 'ICMPFlood', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (61, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'ACK Flood', 'ACKFlood', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (62, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'DNS Reqsponse Flood', 'DNSReqsponseFlood', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (63, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'DNS Request Flood', 'DNSRequestFlood', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (64, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'Http Flood', 'HttpFlood', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (65, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'Https Flood', 'HttpsFlood', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (66, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'LAND Flood', 'LANDFlood', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (67, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'IGMP Flood', 'IGMPFlood', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (68, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', 'cc攻击', 'CCAttack', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (69, '拒绝服务', 'DoS', '连通性攻击', 'connectionAttack', '其他', 'others', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (70, '拒绝服务', 'DoS', '其他', 'others', '其他', 'others', '/Exploit/DOS');,
  INSERT INTO "t_attack_update" VALUES (71, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', '应用程序探测', 'applicationProbe', '/Scan/ServScan');,
  INSERT INTO "t_attack_update" VALUES (72, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', '数据库探测', 'DBProbe', '/Scan/ServScan');,
  INSERT INTO "t_attack_update" VALUES (73, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', 'DNS探测', 'DNSProbe', '/Scan/ServScan');,
  INSERT INTO "t_attack_update" VALUES (74, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', 'FTP探测', 'FTPProbe', '/Scan/ServScan');,
  INSERT INTO "t_attack_update" VALUES (75, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', 'SNMP探测', 'SNMPProbe', '/Scan/ServScan');,
  INSERT INTO "t_attack_update" VALUES (76, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', 'SSH探测', 'SSHProbe', '/Scan/ServScan');,
  INSERT INTO "t_attack_update" VALUES (77, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', 'Telnet探测', 'telnetProbe', '/Scan/ServScan');,
  INSERT INTO "t_attack_update" VALUES (78, '扫描探测', 'scanProbe', '服务扫描', 'serviceScan', '其它', 'others', '/Scan/ServScan');,
  INSERT INTO "t_attack_update" VALUES (79, '扫描探测', 'scanProbe', 'web探测', 'webProbe', '网站爬虫', 'webCrawler', '/Scan/WebScan');,
  INSERT INTO "t_attack_update" VALUES (80, '扫描探测', 'scanProbe', 'web探测', 'webProbe', 'web扫描', 'webScan', '/Scan/WebScan');,
  INSERT INTO "t_attack_update" VALUES (81, '扫描探测', 'scanProbe', 'web探测', 'webProbe', '其他', 'others', '/Scan/WebScan');,
  INSERT INTO "t_attack_update" VALUES (82, '扫描探测', 'scanProbe', '主机扫描', 'hostScan', '端口扫描', 'portScan', '/Scan/PortScan');,
  INSERT INTO "t_attack_update" VALUES (83, '扫描探测', 'scanProbe', '主机扫描', 'hostScan', 'IP扫描', 'addressScan', '/Scan/HostScan');,
  INSERT INTO "t_attack_update" VALUES (84, '扫描探测', 'scanProbe', '主机扫描', 'hostScan', '其他', 'others', '/Scan/Others');,
  INSERT INTO "t_attack_update" VALUES (85, '扫描探测', 'scanProbe', '其它', 'others', '其它', 'others', '/Scan/Others');,
  INSERT INTO "t_attack_update" VALUES (86, '异常事件', 'anomalyEvent', '操作异常', 'operationAnomaly', '操作异常', 'operationAnomaly', '/AccountRisk/SuspBehavior');,
  INSERT INTO "t_attack_update" VALUES (87, '异常事件', 'anomalyEvent', '操作异常', 'operationAnomaly', '其他', 'others', '/AccountRisk/SuspBehavior');,
  INSERT INTO "t_attack_update" VALUES (88, '异常事件', 'anomalyEvent', '通信异常', 'trafficAnomaly', '协议异常', 'protocolAnomaly', '/DevOps/WebError');,
  INSERT INTO "t_attack_update" VALUES (89, '异常事件', 'anomalyEvent', '通信异常', 'trafficAnomaly', '路由异常', 'routeAnomaly', '/DevOps/DeviceError');,
  INSERT INTO "t_attack_update" VALUES (90, '异常事件', 'anomalyEvent', '通信异常', 'trafficAnomaly', '其他', 'others', '/DevOps/Others');,
  INSERT INTO "t_attack_update" VALUES (91, '异常事件', 'anomalyEvent', '配置异常', 'configurationAnomaly', '不安全配置', 'weakConfiguration', '/ConfigRisk/Others');,
  INSERT INTO "t_attack_update" VALUES (92, '异常事件', 'anomalyEvent', '配置异常', 'configurationAnomaly', '配置错误', 'misConfiguration', '/ConfigRisk/Others');,
  INSERT INTO "t_attack_update" VALUES (93, '异常事件', 'anomalyEvent', '配置异常', 'configurationAnomaly', '其他', 'others', '/ConfigRisk/Others');,
  INSERT INTO "t_attack_update" VALUES (94, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', 'CPU状态异常', 'CPUStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (95, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '内存状态异常', 'memoryStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (96, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '磁盘空间状态异常', 'diskSpaceStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (97, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '驱动状态异常', 'driverStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (98, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '服务状态异常', 'serviceStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (99, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '分页状态异常', 'pageStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (100, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '进程状态异常', 'processStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (101, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '线程状态异常', 'threadStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (102, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '句柄状态异常', 'handleStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (103, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '负载状态异常', 'loadStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (104, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '用户数状态异常', 'userStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (105, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '温度状态异常', 'temperatureStatusAnomaly', '/DevOps/HostError');,
  INSERT INTO "t_attack_update" VALUES (106, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '设备损坏', 'deviceDamage', '/DevOps/DeviceError');,
  INSERT INTO "t_attack_update" VALUES (107, '异常事件', 'anomalyEvent', '资源异常', 'resourceAnomaly', '其他', 'others', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (108, '异常事件', 'anomalyEvent', '实体行为异常', 'entityBehaviorAnomaly', '流量行为异常', 'trafficBehaviorAnomaly', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (109, '异常事件', 'anomalyEvent', '实体行为异常', 'entityBehaviorAnomaly', '域名行为异常', 'domainBehaviorAnomaly', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (110, '异常事件', 'anomalyEvent', '实体行为异常', 'entityBehaviorAnomaly', 'web行为异常', 'webBehaviorAnomaly', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (111, '异常事件', 'anomalyEvent', '实体行为异常', 'entityBehaviorAnomaly', '日志行为异常', 'logBehaviorAnomaly', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (112, '异常事件', 'anomalyEvent', '实体行为异常', 'entityBehaviorAnomaly', '其他', 'others', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (113, '异常事件', 'anomalyEvent', '其他', 'others', '其他', 'others', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (114, 'APT', 'APT', 'APT', 'APT', '夜龙APT', 'nightDragon', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (115, 'APT', 'APT', 'APT', 'APT', '其他', 'others', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (116, 'APT', 'APT', '其他', 'others', '其他', 'others', '/Others/Others');,
  INSERT INTO "t_attack_update" VALUES (117, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '用户管理', 'userManagement', '/Audit/OpAudit');,
  INSERT INTO "t_attack_update" VALUES (118, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '身份验证', 'IDAuthentication', '/Audit/OpAudit');,
  INSERT INTO "t_attack_update" VALUES (119, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '身份授权', 'IDAuthorization', '/Audit/OpAudit');,
  INSERT INTO "t_attack_update" VALUES (120, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '审计管理', 'auditManagement', '/Audit/OpAudit');,
  INSERT INTO "t_attack_update" VALUES (121, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '用户组管理', 'userGroupManagement', '/Audit/OpAudit');,
  INSERT INTO "t_attack_update" VALUES (122, '系统管理', 'systemManagement', '用户感知', 'userAwareness', '其他', 'others', '/Audit/OpAudit');,
  INSERT INTO "t_attack_update" VALUES (123, '系统管理', 'systemManagement', '脆弱性感知', 'vulnerabilityAwareness', '弱口令', 'weakPassword', '/ConfigRisk/WeakPassword');,
  INSERT INTO "t_attack_update" VALUES (124, '系统管理', 'systemManagement', '脆弱性感知', 'vulnerabilityAwareness', '明文传输', 'plaintextTransmission', '/ConfigRisk/ClearTextCredit');,
  INSERT INTO "t_attack_update" VALUES (125, '系统管理', 'systemManagement', '脆弱性感知', 'vulnerabilityAwareness', '其他', 'others', '/ConfigRisk/Others');,
  INSERT INTO "t_attack_update" VALUES (126, '系统管理', 'systemManagement', '其他', 'others', '其他', 'others', '/ConfigRisk/Others');,
  INSERT INTO "t_attack_update" VALUES (127, '其他', 'others', '其他', 'others', '其他', 'others', '/Others/Others');

DROP TABLE IF EXISTS "t_auth_version";
CREATE TABLE "t_auth_version"  (
  "id" BIGSERIAL,
  "app_name" VARCHAR(128)   NOT NULL,
  "type" VARCHAR(16)   NOT NULL,
  "version" VARCHAR(128)   NOT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "t_auth_version_UN" ON "t_auth_version" ("app_name", "type");

-- Column comments
COMMENT ON COLUMN "t_auth_version"."id" IS '主键';
COMMENT ON COLUMN "t_auth_version"."app_name" IS 'app名称';
COMMENT ON COLUMN "t_auth_version"."type" IS '配置类型，menu：菜单，permission：权限';
COMMENT ON COLUMN "t_auth_version"."version" IS '版本，配置文件MD5';
COMMENT ON COLUMN "t_auth_version"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_auth_version"."update_time" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_auth_version_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_auth_version_update_timestamp
BEFORE UPDATE ON "t_auth_version"
FOR EACH ROW
EXECUTE FUNCTION update_t_auth_version_timestamp();


DROP TABLE IF EXISTS "t_autosend_history";
CREATE TABLE "t_autosend_history"  (
  "id" SERIAL,
  "report_name" VARCHAR(1024)   NULL DEFAULT NULL,
  "send_time" VARCHAR(50)   NOT NULL,
  "time_range" VARCHAR(50)   NOT NULL,
  "begin_time" TIMESTAMP NOT NULL,
  "end_time" TIMESTAMP NOT NULL,
  "send_format" VARCHAR(50)   NOT NULL,
  "mail" VARCHAR(1024)   NULL DEFAULT NULL,
  "result" VARCHAR(50)   NOT NULL,
  "idByList" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_autosend_history"."id" IS '主键Id';
COMMENT ON COLUMN "t_autosend_history"."send_time" IS '发送时间';
COMMENT ON COLUMN "t_autosend_history"."time_range" IS '统计时间范围';
COMMENT ON COLUMN "t_autosend_history"."begin_time" IS '统计开始时间';
COMMENT ON COLUMN "t_autosend_history"."end_time" IS '统计结束时间';
COMMENT ON COLUMN "t_autosend_history"."send_format" IS '发送格式';
COMMENT ON COLUMN "t_autosend_history"."result" IS '发送结果';
COMMENT ON COLUMN "t_autosend_history"."idByList" IS '对应List的ID';


DROP TABLE IF EXISTS "t_autosend_list";
CREATE TABLE "t_autosend_list"  (
  "id" SERIAL,
  "report_name" VARCHAR(1024)   NULL DEFAULT NULL,
  "is_enable" VARCHAR(20)   NOT NULL DEFAULT '0',
  "period" VARCHAR(20)   NOT NULL,
  "create_time" VARCHAR(50)   NOT NULL,
  "statistics_time" VARCHAR(50)   NOT NULL,
  "time_range" VARCHAR(50)   NOT NULL,
  "send_format" VARCHAR(50)   NOT NULL,
  "begin_time" VARCHAR(50)   NOT NULL,
  "end_time" VARCHAR(50)   NOT NULL,
  "mail" VARCHAR(1024)   NULL DEFAULT NULL,
  "milli" VARCHAR(50)   NOT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_autosend_list"."id" IS '主键Id';
COMMENT ON COLUMN "t_autosend_list"."is_enable" IS '是否启用';
COMMENT ON COLUMN "t_autosend_list"."period" IS '发送周期,day,week,month';
COMMENT ON COLUMN "t_autosend_list"."create_time" IS '生成时间';
COMMENT ON COLUMN "t_autosend_list"."statistics_time" IS '统计时间';
COMMENT ON COLUMN "t_autosend_list"."time_range" IS '时间范围';
COMMENT ON COLUMN "t_autosend_list"."send_format" IS '发送格式';
COMMENT ON COLUMN "t_autosend_list"."milli" IS '最后更新时间';


DROP TABLE IF EXISTS "t_bridge_origination";
CREATE TABLE "t_bridge_origination"  (
  "id" SERIAL,
  "other_id" VARCHAR(150)   NOT NULL,
  "origination_id" VARCHAR(150)   NOT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "type" VARCHAR(45)   NOT NULL,
  "default" VARCHAR(150)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_bridge_origination" VALUES (1, '1', '7effcbb7-0c7a-4da9-bde1-32d06166acae', '2026-01-13 10:37:40', '2026-01-13 10:37:40', 'user', NULL);,
  INSERT INTO "t_bridge_origination" VALUES (2, '3', '7effcbb7-0c7a-4da9-bde1-32d06166acae', '2026-01-13 10:37:40', '2026-01-13 10:37:40', 'user', NULL);,
  INSERT INTO "t_bridge_origination" VALUES (3, '2', '7effcbb7-0c7a-4da9-bde1-32d06166acae', '2026-01-13 10:37:40', '2026-01-13 10:37:40', 'user', NULL);,
  INSERT INTO "t_bridge_origination" VALUES (4, '4', '7effcbb7-0c7a-4da9-bde1-32d06166acae', '2026-01-13 10:37:45', '2026-01-13 10:37:45', 'user', NULL);

-- Column comments
COMMENT ON COLUMN "t_bridge_origination"."other_id" IS '各种id';
COMMENT ON COLUMN "t_bridge_origination"."type" IS '所属类型：用户:user、安全域、web业务系统';


DROP TABLE IF EXISTS "t_bs_analysis_job";
CREATE TABLE "t_bs_analysis_job"  (
  "id" BIGSERIAL,
  "code" VARCHAR(50)   NOT NULL,
  "name" VARCHAR(255)   NULL DEFAULT NULL,
  "description" VARCHAR(1000)   NULL DEFAULT NULL,
  "prefix" VARCHAR(100)   NULL DEFAULT NULL,
  "script_type" VARCHAR(50)   NOT NULL,
  "script_path" VARCHAR(500)   NOT NULL,
  "job_config" text   NULL,
  "status" VARCHAR(10)   NOT NULL,
  "result" text   NULL,
  "create_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_bs_analysis_job" VALUES (1, 'one2one', '一对一爆破', '单个源IP对单个目的IP的爆破策略', 'config:IOA:bruteForce:', 'python', '/usr/hdp/2.5.3.0-37/bigdata/mirror-web-api/system/scripts/python/ioa/ioa_engine/main.py', '{\"timeRange\":5,\"loginTimes\":25}', 'running', NULL, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_bs_analysis_job" VALUES (2, 'many2one', '多对一爆破', '多个源IP对一个目的IP的爆破策略', 'config:IOA:bruteForce:', 'python', '/usr/hdp/2.5.3.0-37/bigdata/mirror-web-api/system/scripts/python/ioa/ioa_engine/main.py', '{\"timeRange\":5,\"loginTimes\":25}', 'running', NULL, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  INSERT INTO "t_bs_analysis_job" VALUES (3, 'slow', '慢速爆破', '单个源IP对单个目的IP的慢速爆破策略', 'config:IOA:bruteForce:', 'python', '/usr/hdp/2.5.3.0-37/bigdata/mirror-web-api/system/scripts/python/ioa/ioa_engine/main.py', '{\"timeRange\":5,\"loginTimes\":20,\"repeatTimes\":10}', 'running', NULL, '2026-01-13 10:37:47', '2026-01-13 10:37:47');,
  "SET" FOREIGN_KEY_CHECKS = 1;

-- Indexes
CREATE UNIQUE INDEX "code" ON "t_bs_analysis_job" ("code");

-- Column comments
COMMENT ON COLUMN "t_bs_analysis_job"."id" IS '主键ID';
COMMENT ON COLUMN "t_bs_analysis_job"."code" IS '任务唯一标识';
COMMENT ON COLUMN "t_bs_analysis_job"."name" IS '任务中文名';
COMMENT ON COLUMN "t_bs_analysis_job"."description" IS '任务描述';
COMMENT ON COLUMN "t_bs_analysis_job"."prefix" IS 'RedisKey前缀';
COMMENT ON COLUMN "t_bs_analysis_job"."script_type" IS '脚本类型';
COMMENT ON COLUMN "t_bs_analysis_job"."script_path" IS '脚本文件路径';
COMMENT ON COLUMN "t_bs_analysis_job"."job_config" IS '任务配置参数（JSON字符串）';
COMMENT ON COLUMN "t_bs_analysis_job"."status" IS '任务状态[running, stopped, failure]';
COMMENT ON COLUMN "t_bs_analysis_job"."result" IS '最后一次操作结果';
COMMENT ON COLUMN "t_bs_analysis_job"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_bs_analysis_job"."update_time" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_bs_analysis_job_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_bs_analysis_job_update_timestamp
BEFORE UPDATE ON "t_bs_analysis_job"
FOR EACH ROW
EXECUTE FUNCTION update_t_bs_analysis_job_timestamp();


-- Enable foreign key checks
SET session_replication_role = 'origin';

-- Update sequences
-- Run after data import:
-- SELECT setval(pg_get_serial_sequence('table_name', 'id_column'), (SELECT MAX(id_column) FROM table_name));
