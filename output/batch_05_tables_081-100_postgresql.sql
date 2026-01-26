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


DROP TABLE IF EXISTS "t_dispose_event_history";
CREATE TABLE "t_dispose_event_history"  (
  "id" BIGSERIAL,
  "eventId" BIGINT NOT NULL,
  "operatorId" BIGINT NOT NULL,
  "address" VARCHAR(23)   NOT NULL,
  "operations" VARCHAR(255)   NOT NULL,
  "action" VARCHAR(20)   NULL DEFAULT NULL,
  "createTime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
  CONSTRAINT "fk_eventId" FOREIGN KEY ("eventId") REFERENCES "t_dispose_event" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT
  CONSTRAINT "fk_operatorId" FOREIGN KEY ("operatorId") REFERENCES "t_user" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT
);

-- Indexes
CREATE INDEX "fk_eventId" ON "t_dispose_event_history" ("eventId");
CREATE INDEX "fk_operatorId" ON "t_dispose_event_history" ("operatorId");

-- Column comments
COMMENT ON COLUMN "t_dispose_event_history"."eventId" IS '处置事件ID';
COMMENT ON COLUMN "t_dispose_event_history"."operatorId" IS '操作人ID';
COMMENT ON COLUMN "t_dispose_event_history"."address" IS '操作人主机地址';
COMMENT ON COLUMN "t_dispose_event_history"."operations" IS '操作记录';
COMMENT ON COLUMN "t_dispose_event_history"."action" IS '处置动作';
COMMENT ON COLUMN "t_dispose_event_history"."createTime" IS '创建时间';


DROP TABLE IF EXISTS "t_edr_asset_bug";
CREATE TABLE "t_edr_asset_bug"  (
  "id" SERIAL,
  "ip" VARCHAR(255)   NOT NULL,
  "scan_batch_no" VARCHAR(255)   NOT NULL,
  "serverity" VARCHAR(255)   NULL DEFAULT '',
  "size" VARCHAR(255)   NULL DEFAULT '',
  "publish_time" VARCHAR(255)   NULL DEFAULT '',
  "description" text   NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_edr_asset_bug"."id" IS '自增主键';
COMMENT ON COLUMN "t_edr_asset_bug"."ip" IS '资产ip';
COMMENT ON COLUMN "t_edr_asset_bug"."scan_batch_no" IS '批次编号';
COMMENT ON COLUMN "t_edr_asset_bug"."serverity" IS '状态';
COMMENT ON COLUMN "t_edr_asset_bug"."size" IS '补丁大小';
COMMENT ON COLUMN "t_edr_asset_bug"."publish_time" IS '发布日期';
COMMENT ON COLUMN "t_edr_asset_bug"."description" IS '漏洞补丁描述';
COMMENT ON COLUMN "t_edr_asset_bug"."created_at" IS '记录创建时间';
COMMENT ON COLUMN "t_edr_asset_bug"."updated_at" IS '记录更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_edr_asset_bug_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updated_at" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_edr_asset_bug_update_timestamp
BEFORE UPDATE ON "t_edr_asset_bug"
FOR EACH ROW
EXECUTE FUNCTION update_t_edr_asset_bug_timestamp();


DROP TABLE IF EXISTS "t_edr_asset_site";
CREATE TABLE "t_edr_asset_site"  (
  "id" SERIAL,
  "ip" VARCHAR(255)   NOT NULL,
  "scan_batch_no" VARCHAR(255)   NOT NULL,
  "file" VARCHAR(255)   NULL DEFAULT '',
  "time" VARCHAR(255)   NULL DEFAULT '',
  "type" VARCHAR(255)   NULL DEFAULT '',
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_edr_asset_site"."id" IS '自增主键';
COMMENT ON COLUMN "t_edr_asset_site"."ip" IS '资产ip';
COMMENT ON COLUMN "t_edr_asset_site"."scan_batch_no" IS '批次编号';
COMMENT ON COLUMN "t_edr_asset_site"."file" IS '网站后门文件';
COMMENT ON COLUMN "t_edr_asset_site"."time" IS '发现时间';
COMMENT ON COLUMN "t_edr_asset_site"."type" IS '后门类型';
COMMENT ON COLUMN "t_edr_asset_site"."created_at" IS '记录创建时间';
COMMENT ON COLUMN "t_edr_asset_site"."updated_at" IS '记录更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_edr_asset_site_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updated_at" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_edr_asset_site_update_timestamp
BEFORE UPDATE ON "t_edr_asset_site"
FOR EACH ROW
EXECUTE FUNCTION update_t_edr_asset_site_timestamp();


DROP TABLE IF EXISTS "t_edr_asset_virus";
CREATE TABLE "t_edr_asset_virus"  (
  "id" SERIAL,
  "ip" VARCHAR(255)   NOT NULL,
  "scan_batch_no" VARCHAR(255)   NOT NULL,
  "file" VARCHAR(255)   NULL DEFAULT '',
  "time" VARCHAR(255)   NULL DEFAULT '',
  "name" VARCHAR(255)   NULL DEFAULT '',
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_edr_asset_virus"."id" IS '自增主键';
COMMENT ON COLUMN "t_edr_asset_virus"."ip" IS '资产ip';
COMMENT ON COLUMN "t_edr_asset_virus"."scan_batch_no" IS '批次编号';
COMMENT ON COLUMN "t_edr_asset_virus"."file" IS '网站后门文件';
COMMENT ON COLUMN "t_edr_asset_virus"."time" IS '发现时间';
COMMENT ON COLUMN "t_edr_asset_virus"."name" IS '病毒木马名称';
COMMENT ON COLUMN "t_edr_asset_virus"."created_at" IS '记录创建时间';
COMMENT ON COLUMN "t_edr_asset_virus"."updated_at" IS '记录更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_edr_asset_virus_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updated_at" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_edr_asset_virus_update_timestamp
BEFORE UPDATE ON "t_edr_asset_virus"
FOR EACH ROW
EXECUTE FUNCTION update_t_edr_asset_virus_timestamp();


DROP TABLE IF EXISTS "t_filteritem";
CREATE TABLE "t_filteritem"  (
  "id" SERIAL,
  "pid" INTEGER NULL DEFAULT NULL,
  "operator" INTEGER NULL DEFAULT 0,
  "field" VARCHAR(100)   NULL DEFAULT NULL,
  "text" text   NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_filteritem" VALUES (1, -1, 0, '目的主机名(destHostName)', '*.163.com');,
  INSERT INTO "t_filteritem" VALUES (2, -1, 0, '目的主机名(destHostName)', '*.qq.com');,
  INSERT INTO "t_filteritem" VALUES (3, -1, 0, '目的主机名(destHostName)', '*.189.cn');,
  INSERT INTO "t_filteritem" VALUES (4, -1, 0, '目的主机名(destHostName)', '*.microsoft.com');,
  INSERT INTO "t_filteritem" VALUES (5, -1, 0, '目的主机名(destHostName)', '*.sohu.com');,
  INSERT INTO "t_filteritem" VALUES (6, -1, 0, '目的主机名(destHostName)', '*.taobao.com');,
  INSERT INTO "t_filteritem" VALUES (7, -1, 0, '目的主机名(destHostName)', '*.baidu.com');,
  INSERT INTO "t_filteritem" VALUES (8, -1, 0, '目的主机名(destHostName)', '*.kugou.com');,
  INSERT INTO "t_filteritem" VALUES (9, -1, 0, '目的主机名(destHostName)', '*.oracle.com');,
  INSERT INTO "t_filteritem" VALUES (10, -1, 0, '目的主机名(destHostName)', '*.windowsupdate.com');,
  INSERT INTO "t_filteritem" VALUES (11, -1, 0, '目的主机名(destHostName)', '*.360.cn');,
  INSERT INTO "t_filteritem" VALUES (12, -1, 0, '目的主机名(destHostName)', '*.360.net');,
  INSERT INTO "t_filteritem" VALUES (13, -1, 0, '目的主机名(destHostName)', '*.nginx.org');,
  INSERT INTO "t_filteritem" VALUES (14, -1, 0, '目的主机名(destHostName)', '*.lenovo.com');,
  INSERT INTO "t_filteritem" VALUES (15, -1, 0, '目的主机名(destHostName)', '*.meituan.com');,
  INSERT INTO "t_filteritem" VALUES (16, -1, 0, '目的主机名(destHostName)', '*.iqiyi.com');,
  INSERT INTO "t_filteritem" VALUES (17, -1, 0, '目的主机名(destHostName)', '*.youku.com');,
  INSERT INTO "t_filteritem" VALUES (18, -1, 0, '目的主机名(destHostName)', '*.360safe.com');,
  INSERT INTO "t_filteritem" VALUES (19, -1, 0, '目的主机名(destHostName)', '*.adobe.com');,
  INSERT INTO "t_filteritem" VALUES (20, -1, 0, '目的主机名(destHostName)', '*.sogou.com');,
  INSERT INTO "t_filteritem" VALUES (21, -1, 0, '目的主机名(destHostName)', '*.apple.com');,
  INSERT INTO "t_filteritem" VALUES (22, -1, 0, '目的主机名(destHostName)', '*.netease.com');,
  INSERT INTO "t_filteritem" VALUES (23, -1, 0, '目的主机名(destHostName)', '*.weibo.cn');,
  INSERT INTO "t_filteritem" VALUES (24, -1, 1, '目的主机名(destHostName)', '1.1.1.2,1.1.1.1,www.freebsd.org');,
  INSERT INTO "t_filteritem" VALUES (25, -2, 1, '目的IP(destAddress)', '127.0.0.1');

-- Column comments
COMMENT ON COLUMN "t_filteritem"."operator" IS '0，通配符；1，包含';


DROP TABLE IF EXISTS "t_filterlist";
CREATE TABLE "t_filterlist"  (
  "id" SERIAL,
  "analyse" INTEGER NULL DEFAULT NULL,
  "name" text   NULL,
  "creator" VARCHAR(64)   NULL DEFAULT NULL,
  "createtime" TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_filterlist" VALUES (-2, 0, '内置白名单1', 'admin', '2019-06-27 17:29:49');,
  INSERT INTO "t_filterlist" VALUES (-1, 0, '内置白名单', 'admin', '2019-06-27 17:12:43');

-- Column comments
COMMENT ON COLUMN "t_filterlist"."analyse" IS '0,不分析，白名单；1，分析，黑名单';
COMMENT ON COLUMN "t_filterlist"."name" IS '支持特殊字符';


DROP TABLE IF EXISTS "t_flow_ids_policy";
CREATE TABLE "t_flow_ids_policy"  (
  "ids_policy_id" varbinary(64) NOT NULL,
  "tenant_id" VARCHAR(64)   NOT NULL,
  "security_policy_ids" text   NOT NULL,
  "ids_policy_template_id" VARCHAR(1)   NOT NULL,
  "ids_policy_template_name" VARCHAR(255)   NOT NULL,
  "enable" BOOLEAN NOT NULL,
  "logging" BOOLEAN NOT NULL,
  "name" VARCHAR(255)   NOT NULL,
  "description" text   NULL,
  "linked_strategy_id" BIGINT NOT NULL,
  PRIMARY KEY ("ids_policy_id")
);

-- Column comments
COMMENT ON COLUMN "t_flow_ids_policy"."ids_policy_id" IS 'IDS策略id';
COMMENT ON COLUMN "t_flow_ids_policy"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "t_flow_ids_policy"."security_policy_ids" IS '引用安全策略ID（列表），每个IPS策略对应至少一个安全策略';
COMMENT ON COLUMN "t_flow_ids_policy"."ids_policy_template_id" IS 'IDS策略模板id（1：低级防护模板，2：中级防护模板，3：高级防护模板）（AXDR仅存储）';
COMMENT ON COLUMN "t_flow_ids_policy"."ids_policy_template_name" IS 'IDS策略模板名称（AXDR仅存储）';
COMMENT ON COLUMN "t_flow_ids_policy"."enable" IS '是否启用，0:不启用，1:启用';
COMMENT ON COLUMN "t_flow_ids_policy"."logging" IS '是否开启日志记录，0:不启用，1:启用（AXDR不支持，仅存储）';
COMMENT ON COLUMN "t_flow_ids_policy"."name" IS '策略名称';
COMMENT ON COLUMN "t_flow_ids_policy"."description" IS '策略描述';
COMMENT ON COLUMN "t_flow_ids_policy"."linked_strategy_id" IS '联动策略ID';


DROP TABLE IF EXISTS "t_flow_security_policy";
CREATE TABLE "t_flow_security_policy"  (
  "security_policy_id" varbinary(64) NOT NULL,
  "tenant_id" VARCHAR(64)   NOT NULL,
  "name" VARCHAR(255)   NOT NULL,
  "description" text   NULL,
  "priority" BOOLEAN NULL DEFAULT NULL,
  "src_zone" VARCHAR(64)   NULL DEFAULT NULL,
  "dst_zone" VARCHAR(64)   NULL DEFAULT NULL,
  "protocol" BOOLEAN NULL DEFAULT NULL,
  "src_address" text   NOT NULL,
  "dst_address" text   NOT NULL,
  "service_items" text   NULL,
  "time_items" text   NOT NULL,
  "app_items" text   NULL,
  "url_items" text   NULL,
  "action" BOOLEAN NOT NULL,
  "logging" BOOLEAN NOT NULL,
  "enable" BOOLEAN NOT NULL,
  PRIMARY KEY ("security_policy_id")
);

-- Column comments
COMMENT ON COLUMN "t_flow_security_policy"."security_policy_id" IS '安全策略id';
COMMENT ON COLUMN "t_flow_security_policy"."tenant_id" IS '租户ID';
COMMENT ON COLUMN "t_flow_security_policy"."name" IS '策略名称';
COMMENT ON COLUMN "t_flow_security_policy"."description" IS '策略描述';
COMMENT ON COLUMN "t_flow_security_policy"."priority" IS '安全策略优先级序号（租户级），1为最上/优先策略（AXDR目前没有策略优先级，仅存储）';
COMMENT ON COLUMN "t_flow_security_policy"."src_zone" IS '源区域（AXDR仅存储）';
COMMENT ON COLUMN "t_flow_security_policy"."dst_zone" IS '目的区域（AXDR仅存储）';
COMMENT ON COLUMN "t_flow_security_policy"."protocol" IS '协议类型，0: ipv4, 1: ipv6（AXDR目前仅支持IPv4）';
COMMENT ON COLUMN "t_flow_security_policy"."src_address" IS '源地址对象，支持ip_object_id或ip_group_object_id，上限为1000个';
COMMENT ON COLUMN "t_flow_security_policy"."dst_address" IS '目的地址，支持ip_object_id或ip_group_object_id，上限为1000个';
COMMENT ON COLUMN "t_flow_security_policy"."service_items" IS '服务对象，service_object_id或service_group_object_id（AXDR仅存储）';
COMMENT ON COLUMN "t_flow_security_policy"."time_items" IS '时间对象，time_object_id，默认为[”any”]（AXDR仅支持”any”--永久策略）';
COMMENT ON COLUMN "t_flow_security_policy"."app_items" IS '应用对象，app_object_id（AXDR仅存储）';
COMMENT ON COLUMN "t_flow_security_policy"."url_items" IS 'URL对象，url_object_id（AXDR仅存储）';
COMMENT ON COLUMN "t_flow_security_policy"."action" IS '动作，0:deny,1:allow（AXDR仅支持\"deny\"--封禁）';
COMMENT ON COLUMN "t_flow_security_policy"."logging" IS '是否开启日志记录，0:不启用，1:启用（AXDR不支持，仅存储）';
COMMENT ON COLUMN "t_flow_security_policy"."enable" IS '是否启用，0:不启用，1:启用（AXDR仅存储）';


DROP TABLE IF EXISTS "t_index";
CREATE TABLE "t_index"  (
  "id" SERIAL,
  "name" VARCHAR(128)   NULL DEFAULT NULL,
  "days" INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_index"."id" IS 'id';
COMMENT ON COLUMN "t_index"."name" IS '索引名称';
COMMENT ON COLUMN "t_index"."days" IS '开启天数';


DROP TABLE IF EXISTS "t_inner_ip_config";
CREATE TABLE "t_inner_ip_config"  (
  "id" VARCHAR(100)   NOT NULL,
  "globalMonitor" VARCHAR(100)   NOT NULL,
  "monitorArea" VARCHAR(500)   NULL DEFAULT NULL,
  "ipConfStr" TEXT   NOT NULL,
  "uiIpConfStr" TEXT   NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_inner_ip_config" VALUES ('inner_4d9fc34d-e1ca-41d8-9c75-f3041c3b6675_1537173372312', '内部ip', '', '{\"ipInterval\":[[\"10.0.0.0\",\"10.255.255.255\"],[\"172.16.0.0\",\"172.31.255.255\"],[\"192.168.0.0\",\"192.168.255.255\"]],\"ip\":[\"127.0.0.1\"],\"subnetMask\":[]}', '{\"ipInterval\":[1,2,3],\"ip\":[0],\"subnetMask\":[]}');

-- Column comments
COMMENT ON COLUMN "t_inner_ip_config"."id" IS 'Id';
COMMENT ON COLUMN "t_inner_ip_config"."globalMonitor" IS '全局监控';
COMMENT ON COLUMN "t_inner_ip_config"."monitorArea" IS '监控地区';
COMMENT ON COLUMN "t_inner_ip_config"."ipConfStr" IS 'ip、ip区间、子网掩码配置';
COMMENT ON COLUMN "t_inner_ip_config"."uiIpConfStr" IS 'Ip、ip区间、子网掩码对应前端位置';


DROP TABLE IF EXISTS "t_intelligence_knowledge_family";
CREATE TABLE "t_intelligence_knowledge_family"  (
  "id" VARCHAR(100)   NOT NULL DEFAULT '',
  "name" VARCHAR(200)   NULL DEFAULT NULL,
  "alias" text   NULL,
  "organization_ids" text   NULL,
  "organization_names" text   NULL,
  "description" text   NULL,
  "os" text   NULL,
  "refs" text   NULL,
  "expired" BOOLEAN NULL DEFAULT NULL,
  "update_time" TEXT   NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_intelligence_knowledge_family"."id" IS '唯一ID编号，可以和情报中family_id做关联';
COMMENT ON COLUMN "t_intelligence_knowledge_family"."name" IS '家族名称';
COMMENT ON COLUMN "t_intelligence_knowledge_family"."alias" IS '别名';
COMMENT ON COLUMN "t_intelligence_knowledge_family"."organization_names" IS '关联组织名称';
COMMENT ON COLUMN "t_intelligence_knowledge_family"."description" IS '详情描述';
COMMENT ON COLUMN "t_intelligence_knowledge_family"."os" IS '该家族影响的平台';
COMMENT ON COLUMN "t_intelligence_knowledge_family"."refs" IS '家族信息参考链接';
COMMENT ON COLUMN "t_intelligence_knowledge_family"."expired" IS '是否失效，false -未失效，true- 已失效';
COMMENT ON COLUMN "t_intelligence_knowledge_family"."update_time" IS '更新时间，毫秒级时间戳';


DROP TABLE IF EXISTS "t_intelligence_knowledge_org";
CREATE TABLE "t_intelligence_knowledge_org"  (
  "id" VARCHAR(100)   NOT NULL DEFAULT '',
  "name" VARCHAR(200)   NULL DEFAULT NULL,
  "attack_method" text   NULL,
  "regions" text   NULL,
  "industries" text   NULL,
  "description" text   NULL,
  "os" text   NULL,
  "refs" text   NULL,
  "expired" BOOLEAN NULL DEFAULT NULL,
  "update_time" TEXT   NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_intelligence_knowledge_org"."id" IS '唯一ID编号，可以和情报中organization_id做关联';
COMMENT ON COLUMN "t_intelligence_knowledge_org"."name" IS '组织名称';
COMMENT ON COLUMN "t_intelligence_knowledge_org"."attack_method" IS '攻击方法';
COMMENT ON COLUMN "t_intelligence_knowledge_org"."regions" IS '团伙所在国家/地区';
COMMENT ON COLUMN "t_intelligence_knowledge_org"."industries" IS '受影响的行业';
COMMENT ON COLUMN "t_intelligence_knowledge_org"."description" IS '详情描述';
COMMENT ON COLUMN "t_intelligence_knowledge_org"."os" IS '该家族影响的系统';
COMMENT ON COLUMN "t_intelligence_knowledge_org"."refs" IS '报告链接';
COMMENT ON COLUMN "t_intelligence_knowledge_org"."expired" IS '是否失效，false -未失效，true- 已失效';
COMMENT ON COLUMN "t_intelligence_knowledge_org"."update_time" IS '更新时间，毫秒级时间戳';


DROP TABLE IF EXISTS "t_intelligence_source_function";
CREATE TABLE "t_intelligence_source_function"  (
  "id" SERIAL,
  "intelligence_source_code" VARCHAR(100)   NOT NULL,
  "function" enum('ONLINE_UPDATE','OFFLINE_UPDATE','API_UPDATE','EXPORT','INTELLIGENCE_ADD','INTELLIGENCE_DELETE','INTELLIGENCE_MODIFY','INTELLIGENCE_RETRIEVE','INTELLIGENCE_RETRIEVE_BY_API','SETUP','MANAGE','REMOVE','CLONE','DEVICE_INFO')   NULL DEFAULT NULL,
  "name" VARCHAR(50)   NOT NULL,
  "type" enum('tab','button','operate')   NOT NULL,
  "enable" SMALLINT NOT NULL DEFAULT 1,
  "description" VARCHAR(4096)   NULL DEFAULT NULL,
  "config" TEXT   NULL,
  "operations" TEXT   NULL,
  "order" SMALLINT NOT NULL,
  "display" SMALLINT NOT NULL DEFAULT 1,
  PRIMARY KEY ("id")
  CONSTRAINT "foreign_key_function_to_source" FOREIGN KEY ("intelligence_source_code") REFERENCES "t_intelligence_source_metadata" ("code") ON DELETE CASCADE ON UPDATE CASCADE
);
  INSERT INTO "t_intelligence_source_function" VALUES (1, 'ThreatIntelligenceCentreSource', 'OFFLINE_UPDATE', '离线更新', 'tab', 1, '可通过以下方式获取威胁情报许可：\n1、导出许可申请文件\n2、登录安恒公司内网，将导出的申请文件发送 http://t.dbappsecurity.com.cn ，订阅威胁情报', '{\"belongTo\":\"OFFLINE_UPDATE\"}', '{\"ExportLicenseFile\":{\"name\":\"导出许可申请文件\",\"operation\":\"ExportLicenseFile\"},\"UploadUpdatePackage\":{\"name\":\"上传更新包\",\"operation\":\"UploadUpdatePackage\"}}', 1, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (2, 'ThreatIntelligenceCentreSource', 'ONLINE_UPDATE', '在线更新', 'tab', 0, '', '{\"belongTo\":\"ONLINE_UPDATE\",\"tiToken\":\"\"}', '{\"UpdateOnline\":{\"name\":\"在线更新\",\"operation\":\"UpdateOnline\"},\"UserExperienceProgram\":{\"name\":\"参加\\\"AiLPHA用户体验改善计划\\\"\",\"operation\":\"UserExperienceProgram\",\"value\":false},\"ConnectivityTest\":{\"name\":\"连通性测试\",\"operation\":\"ConnectivityTest\"},\"UpdateNow\":{\"name\":\"立即更新\",\"operation\":\"UpdateNow\"},\"ProxyConfiguration\":{\"name\":\"代理配置\",\"operation\":\"ProxyConfiguration\"},\"DNSConfiguration\":{\"name\":\"DNS配置\",\"operation\":\"DNSConfiguration\"}}', 2, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (3, 'ThreatIntelligenceCentreSource', 'API_UPDATE', 'Api更新', 'tab', 0, '', '{\"belongTo\":\"API_UPDATE\"}', '', 3, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (4, 'ThreatIntelligenceCentreSource', 'EXPORT', '情报导出', 'tab', 0, '暂不支持', '{\"belongTo\":\"EXPORT\"}', '{\"GenerateExportFile\":{\"name\":\"生成情报导出文件\",\"operation\":\"GenerateExportFile\"},\"Download\":{\"name\":\"下载\",\"operation\":\"Download\"}}', 4, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (5, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_ADD', '情报新增', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_ADD\"}', '', 5, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (6, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_DELETE', '情报删除', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_DELETE\"}', '', 6, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (7, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_MODIFY', '情报修改', 'operate', 0, '', '{\"belongTo\":\"INTELLIGENCE_MODIFY\"}', '', 7, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (8, 'ThreatIntelligenceCentreSource', 'INTELLIGENCE_RETRIEVE', '情报检索', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE\"}', '', 8, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (9, 'ThreatIntelligenceCentreSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"ONLINE_UPDATE\"]}', '', 9, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (10, 'ThreatIntelligenceCentreSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 10, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (11, 'ThreatIntelligenceCentreSource', 'REMOVE', '移除', 'button', 0, '', '{\"belongTo\":\"REMOVE\"}', '', 11, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (12, 'ThreatIntelligenceCentreSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 12, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (13, 'WeiBuApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[{\"name\":\"微步TIP情报失陷检测接口\",\"code\":\"WeiBuV4Dns\",\"use\":0,\"tag\":1,\"method\":\"GET\",\"protocol\":\"http\",\"domain\":\"TIP:PORT\",\"path\":\"/tip_api/v4/dns\",\"params\":[{\"key\":\"apikey\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，在微步TIP平台的平台管理-业务管理-业务接入页面生成\",\"isIoC\":false},{\"key\":\"resource\",\"value\":\"www.baidu.com\",\"description\":\"IP地址或域名，查询情报IoC样例\",\"isIoC\":true}],\"demo\":\"http://TIP:PORT/tip_api/v4/dns?apikey=YOUR-KEY&resource=www.baidu.com\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"\"},{\"name\":\"微步TIP情报IP信誉接口\",\"code\":\"WeiBuV4Ip\",\"use\":0,\"tag\":2,\"method\":\"GET\",\"protocol\":\"http\",\"domain\":\"TIP:PORT\",\"path\":\"/tip_api/v4/ip\",\"params\":[{\"key\":\"apikey\",\"value\":\"YOUR-KEY\",\"description\":\"API请求的身份标识，在微步TIP平台的平台管理-业务管理-业务接入页面生成\",\"isIoC\":false},{\"key\":\"resource\",\"value\":\"192.168.1.1\",\"description\":\"IP地址，查询情报IoC样例\",\"isIoC\":true}],\"demo\":\"http://TIP:PORT/tip_api/v4/ip?apikey=YOUR-KEY&resource=192.168.1.1\",\"frequency\":200,\"frequencyEnable\":true,\"parseRule\":\"\"}]}', '', 1, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (14, 'WeiBuApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (15, 'WeiBuApiIntelligenceSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 3, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (16, 'WeiBuApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (17, 'WeiBuApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (18, 'NSFOCUSApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[]}', '', 1, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (19, 'NSFOCUSApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (20, 'NSFOCUSApiIntelligenceSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 3, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (21, 'NSFOCUSApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (22, 'NSFOCUSApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);,
  INSERT INTO "t_intelligence_source_function" VALUES (23, 'TianJiPartnersApiIntelligenceSource', 'INTELLIGENCE_RETRIEVE_BY_API', '情报接口查询', 'operate', 1, '', '{\"belongTo\":\"INTELLIGENCE_RETRIEVE_BY_API\",\"interfaces\":[]}', '', 1, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (24, 'TianJiPartnersApiIntelligenceSource', 'SETUP', '设置', 'button', 1, '', '{\"belongTo\":\"SETUP\",\"update\":[\"INTELLIGENCE_RETRIEVE_BY_API\"]}', '', 2, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (25, 'TianJiPartnersApiIntelligenceSource', 'MANAGE', '管理', 'button', 1, '', '{\"belongTo\":\"MANAGE\"}', '', 3, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (26, 'TianJiPartnersApiIntelligenceSource', 'REMOVE', '移除', 'button', 1, '', '{\"belongTo\":\"REMOVE\"}', '', 4, 1);,
  INSERT INTO "t_intelligence_source_function" VALUES (27, 'TianJiPartnersApiIntelligenceSource', 'CLONE', '克隆', 'button', 0, '', '{\"belongTo\":\"CLONE\"}', '', 5, 0);

-- Indexes
CREATE UNIQUE INDEX "unique_intelligenceSourceId_function" ON "t_intelligence_source_function" ("intelligence_source_code", "function");

-- Column comments
COMMENT ON COLUMN "t_intelligence_source_function"."id" IS '情报源功能ID';
COMMENT ON COLUMN "t_intelligence_source_function"."intelligence_source_code" IS '情报源英文标识';
COMMENT ON COLUMN "t_intelligence_source_function"."name" IS '情报源功能名称';
COMMENT ON COLUMN "t_intelligence_source_function"."type" IS '情报源功能类型：tab-标签页(情报数据更新、导出等操作需要另起tab页)；button-按钮(情报源自身操作，设置、管理、移除、克隆)；operate-操作(情报操作，增删改查等)';
COMMENT ON COLUMN "t_intelligence_source_function"."enable" IS '情报源功能启禁用';
COMMENT ON COLUMN "t_intelligence_source_function"."description" IS '情报源功能描述';
COMMENT ON COLUMN "t_intelligence_source_function"."config" IS '情报源功能配置，JSONObject格式';
COMMENT ON COLUMN "t_intelligence_source_function"."operations" IS '情报源功能包含的操作、按钮等，JSONArray格式';
COMMENT ON COLUMN "t_intelligence_source_function"."order" IS '功能顺序';
COMMENT ON COLUMN "t_intelligence_source_function"."display" IS '情报源功能是否展示';


DROP TABLE IF EXISTS "t_intelligence_source_log";
CREATE TABLE "t_intelligence_source_log"  (
  "id" VARCHAR(100)   NOT NULL,
  "intelligence_source_code" VARCHAR(100)   NOT NULL,
  "update_type" enum('ONLINE_UPDATE','OFFLINE_UPDATE','API_UPDATE','EXPORT','INTELLIGENCE_ADD','INTELLIGENCE_DELETE','INTELLIGENCE_MODIFY','INTELLIGENCE_RETRIEVE','INTELLIGENCE_RETRIEVE_BY_API')   NOT NULL,
  "operator" VARCHAR(500)   NOT NULL,
  "ip" VARCHAR(100)   NOT NULL,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "state" INTEGER NULL DEFAULT NULL,
  "progress" VARCHAR(100)   NULL DEFAULT NULL,
  "log" TEXT   NULL,
  "effective_rows" INTEGER NOT NULL DEFAULT 0,
  "failed_rows" INTEGER NOT NULL DEFAULT 0,
  "file" VARCHAR(100)   NULL DEFAULT NULL,
  "delete" SMALLINT NOT NULL DEFAULT 0,
  "dasca_device_id" VARCHAR(50)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_intelligence_source_log"."id" IS '更新日志ID';
COMMENT ON COLUMN "t_intelligence_source_log"."intelligence_source_code" IS '情报源英文标识';
COMMENT ON COLUMN "t_intelligence_source_log"."update_type" IS '情报操作类型';
COMMENT ON COLUMN "t_intelligence_source_log"."operator" IS '操作人';
COMMENT ON COLUMN "t_intelligence_source_log"."ip" IS '操作者ip';
COMMENT ON COLUMN "t_intelligence_source_log"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_intelligence_source_log"."state" IS '操作状态，0-开始，1-进行中，2-成功，3-失败，4-取消，5-异常，大于1为结束';
COMMENT ON COLUMN "t_intelligence_source_log"."progress" IS '操作进度';
COMMENT ON COLUMN "t_intelligence_source_log"."log" IS '备注，操作日志';
COMMENT ON COLUMN "t_intelligence_source_log"."effective_rows" IS '影响情报数据量';
COMMENT ON COLUMN "t_intelligence_source_log"."failed_rows" IS '失败情报数';
COMMENT ON COLUMN "t_intelligence_source_log"."file" IS '情报导入包名称';
COMMENT ON COLUMN "t_intelligence_source_log"."delete" IS '所属情报库是否被删除，0-false，1-true';
COMMENT ON COLUMN "t_intelligence_source_log"."dasca_device_id" IS 'dasca_device_id';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_intelligence_source_log_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_intelligence_source_log_update_timestamp
BEFORE UPDATE ON "t_intelligence_source_log"
FOR EACH ROW
EXECUTE FUNCTION update_t_intelligence_source_log_timestamp();


DROP TABLE IF EXISTS "t_intelligence_source_metadata";
CREATE TABLE "t_intelligence_source_metadata"  (
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
  "app_id" VARCHAR(255)   NULL DEFAULT NULL,
  "dasca_device_id" VARCHAR(50)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_intelligence_source_metadata" VALUES (1, '安恒威胁情报中心', 'ThreatIntelligenceCentreSource', 'dbapp', 'local', 'build-in', 1, 1, '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, NULL);,
  INSERT INTO "t_intelligence_source_metadata" VALUES (2, '微步威胁情报TIP平台', 'WeiBuApiIntelligenceSource', 'weibu', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50', NULL, NULL);,
  INSERT INTO "t_intelligence_source_metadata" VALUES (3, '绿盟威胁情报TIP平台', 'NSFOCUSApiIntelligenceSource', 'lvmeng', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50', NULL, NULL);,
  INSERT INTO "t_intelligence_source_metadata" VALUES (4, '天际友盟威胁情报TIP平台', 'TianJiPartnersApiIntelligenceSource', 'tianji', 'API', 'custom', 0, 0, '2026-01-13 10:37:46', '2026-01-13 10:37:50', NULL, NULL);

-- Indexes
CREATE UNIQUE INDEX "name" ON "t_intelligence_source_metadata" ("name");
CREATE UNIQUE INDEX "code" ON "t_intelligence_source_metadata" ("code");

-- Column comments
COMMENT ON COLUMN "t_intelligence_source_metadata"."id" IS '情报源ID';
COMMENT ON COLUMN "t_intelligence_source_metadata"."name" IS '情报源名称';
COMMENT ON COLUMN "t_intelligence_source_metadata"."code" IS '情报源英文标识（用以关联操作）';
COMMENT ON COLUMN "t_intelligence_source_metadata"."icon" IS '情报源图标';
COMMENT ON COLUMN "t_intelligence_source_metadata"."type" IS '情报源类型：local-本地情报源；API-API情报源';
COMMENT ON COLUMN "t_intelligence_source_metadata"."subtype" IS '情报源子类型：custom-自定义情报源；build-in-内置情报源';
COMMENT ON COLUMN "t_intelligence_source_metadata"."knowledge" IS '情报源是否包含知识库：0-不包含知识库；1-包含只是库，当前仅威胁情报中心具有知识库';
COMMENT ON COLUMN "t_intelligence_source_metadata"."flag" IS '情报源标记，1-显示（所有正常工作的情报源），0-不显示（内置情报源但默认未添加状态，如微步、绿盟、天际友盟）';
COMMENT ON COLUMN "t_intelligence_source_metadata"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_intelligence_source_metadata"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_intelligence_source_metadata"."app_id" IS 'app标识';
COMMENT ON COLUMN "t_intelligence_source_metadata"."dasca_device_id" IS 'dasca_device_id';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_intelligence_source_metadata_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_intelligence_source_metadata_update_timestamp
BEFORE UPDATE ON "t_intelligence_source_metadata"
FOR EACH ROW
EXECUTE FUNCTION update_t_intelligence_source_metadata_timestamp();


DROP TABLE IF EXISTS "t_knowledge_port";
CREATE TABLE "t_knowledge_port"  (
  "port_id" INTEGER NOT NULL,
  "port_name" VARCHAR(140)   NULL DEFAULT NULL,
  "port_detail" VARCHAR(255)   NULL DEFAULT NULL,
  "risk_level" INTEGER UNSIGNED ZEROFILL NOT NULL,
  "vulnerability" VARCHAR(510)   NULL DEFAULT NULL,
  "frequency" INTEGER NULL DEFAULT NULL,
  "port_protocol_v7" VARCHAR(40)   NULL DEFAULT NULL,
  "port_protocol_v4" VARCHAR(40)   NULL DEFAULT NULL,
  PRIMARY KEY ("port_id")
);

-- Column comments
COMMENT ON COLUMN "t_knowledge_port"."port_id" IS '端口号';
COMMENT ON COLUMN "t_knowledge_port"."port_name" IS '端口名称';
COMMENT ON COLUMN "t_knowledge_port"."port_detail" IS '端口描述';
COMMENT ON COLUMN "t_knowledge_port"."risk_level" IS '风险等级 0：无风险 1：有风险';
COMMENT ON COLUMN "t_knowledge_port"."vulnerability" IS '相关漏洞';
COMMENT ON COLUMN "t_knowledge_port"."frequency" IS '使用频率';
COMMENT ON COLUMN "t_knowledge_port"."port_protocol_v7" IS '端口协议7层';
COMMENT ON COLUMN "t_knowledge_port"."port_protocol_v4" IS '端口协议4层 TCP UDP';


DROP TABLE IF EXISTS "t_kpi_statistic";
CREATE TABLE "t_kpi_statistic"  (
  "id" SERIAL,
  "org_id" VARCHAR(255)   NOT NULL,
  "un_closed_order" INTEGER UNSIGNED NOT NULL DEFAULT 0,
  "pending_order_24h" INTEGER UNSIGNED NOT NULL DEFAULT 0,
  "pending_order_3d" INTEGER UNSIGNED NOT NULL DEFAULT 0,
  "pending_order_7d" INTEGER UNSIGNED NOT NULL DEFAULT 0,
  "asset" BIGINT UNSIGNED NOT NULL DEFAULT 0,
  "risk_asset" BIGINT UNSIGNED NOT NULL DEFAULT 0,
  "risk_percent" VARCHAR(255)   NOT NULL DEFAULT '0%',
  "period" enum('week','month')   NOT NULL,
  "deadline" VARCHAR(255)   NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_kpi_statistic"."id" IS '表结构本身的自增主键';
COMMENT ON COLUMN "t_kpi_statistic"."org_id" IS '组织id';
COMMENT ON COLUMN "t_kpi_statistic"."un_closed_order" IS '选定时间段内指派给对应组织且未关闭(关闭重新开启也算在内)的工单数量';
COMMENT ON COLUMN "t_kpi_statistic"."pending_order_24h" IS '选定时间段内滞留时间超过24小时的工单数';
COMMENT ON COLUMN "t_kpi_statistic"."pending_order_3d" IS '选定时间段内滞留时间超过3天的工单数';
COMMENT ON COLUMN "t_kpi_statistic"."pending_order_7d" IS '选定时间段内滞留时间超过7天的工单数';
COMMENT ON COLUMN "t_kpi_statistic"."asset" IS '根据组织架构与安全域绑定的关系，判断现有组织下的资产总数';
COMMENT ON COLUMN "t_kpi_statistic"."risk_asset" IS '根据组织架构与安全域绑定的关系，判断现有组织下的风险资产总数(资产感知中统计: 失陷资产+高风险资产+低风险资产)';
COMMENT ON COLUMN "t_kpi_statistic"."risk_percent" IS '根据组织架构与安全域绑定的关系，现有组织下风险资产总数/现有组织下资产总数';
COMMENT ON COLUMN "t_kpi_statistic"."period" IS '数据所属周期: week, 周, month, 月';
COMMENT ON COLUMN "t_kpi_statistic"."deadline" IS '记录数据时的时间, yyyy-MM-dd HH:mm:ss';
COMMENT ON COLUMN "t_kpi_statistic"."created_at" IS '记录创建时间';
COMMENT ON COLUMN "t_kpi_statistic"."updated_at" IS '记录更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_kpi_statistic_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updated_at" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_kpi_statistic_update_timestamp
BEFORE UPDATE ON "t_kpi_statistic"
FOR EACH ROW
EXECUTE FUNCTION update_t_kpi_statistic_timestamp();


DROP TABLE IF EXISTS "t_layout_notice_history";
CREATE TABLE "t_layout_notice_history"  (
  "id" SERIAL,
  "layout_task_id" VARCHAR(255)   NOT NULL,
  "assignee_id" VARCHAR(255)   NOT NULL,
  "assignee_name" VARCHAR(255)   NOT NULL,
  "notice_way" VARCHAR(255)   NOT NULL DEFAULT '',
  "content" text   NOT NULL,
  "status" VARCHAR(255)   NOT NULL DEFAULT 'success',
  "failure_msg" text   NULL,
  "serial_id" VARCHAR(255)   NOT NULL DEFAULT '-',
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_layout_notice_history"."id" IS '自增主键';
COMMENT ON COLUMN "t_layout_notice_history"."layout_task_id" IS '剧本编排的唯一主键';
COMMENT ON COLUMN "t_layout_notice_history"."assignee_id" IS '通知人的id';
COMMENT ON COLUMN "t_layout_notice_history"."assignee_name" IS '通知人的name';
COMMENT ON COLUMN "t_layout_notice_history"."notice_way" IS '通知方式';
COMMENT ON COLUMN "t_layout_notice_history"."content" IS '通知内容';
COMMENT ON COLUMN "t_layout_notice_history"."status" IS '状态';
COMMENT ON COLUMN "t_layout_notice_history"."failure_msg" IS '失败原因';
COMMENT ON COLUMN "t_layout_notice_history"."serial_id" IS '编号';
COMMENT ON COLUMN "t_layout_notice_history"."created_at" IS '记录创建时间';


DROP TABLE IF EXISTS "t_license";
CREATE TABLE "t_license"  (
  "uuid" VARCHAR(200)   NOT NULL,
  "type" VARCHAR(45)   NOT NULL,
  "machine_code" VARCHAR(64)   NOT NULL,
  "version" VARCHAR(64)   NULL DEFAULT NULL,
  "build" VARCHAR(64)   NULL DEFAULT NULL,
  "online" INTEGER NOT NULL DEFAULT 0,
  "license_filename" VARCHAR(100)   NULL DEFAULT NULL,
  "license_content" VARCHAR(10000)   NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "sync" INTEGER NOT NULL DEFAULT 1,
  "timeout" INTEGER NOT NULL DEFAULT 1,
  "device_model" VARCHAR(150)   NULL DEFAULT NULL,
  PRIMARY KEY ("uuid")
);

-- Column comments
COMMENT ON COLUMN "t_license"."type" IS '合同类型：AILPHA、AIVIEW';
COMMENT ON COLUMN "t_license"."version" IS '版本号';
COMMENT ON COLUMN "t_license"."build" IS 'build号，最后一次commit的id';
COMMENT ON COLUMN "t_license"."online" IS '在线状态。0:离线，1在线。';
COMMENT ON COLUMN "t_license"."license_filename" IS '许可证文件名';
COMMENT ON COLUMN "t_license"."license_content" IS '许可内容';
COMMENT ON COLUMN "t_license"."sync" IS '是否要将许可内容同步给AiView.0不需要，1需要。';
COMMENT ON COLUMN "t_license"."timeout" IS '是否过期，程序需要在宿主机执行，由AiView发送过来。0未过期，1过期。';
COMMENT ON COLUMN "t_license"."device_model" IS '设备型号';


DROP TABLE IF EXISTS "t_linkage_device";
CREATE TABLE "t_linkage_device"  (
  "id" BIGSERIAL,
  "name" VARCHAR(512)   NULL DEFAULT '',
  "ip" VARCHAR(128)   NULL DEFAULT '',
  "port" INTEGER UNSIGNED NULL DEFAULT 0,
  "status" VARCHAR(10)   NULL DEFAULT 'down',
  "category_name" VARCHAR(512)   NULL DEFAULT '',
  "type" VARCHAR(512)   NULL DEFAULT '',
  "type_name" VARCHAR(512)   NULL DEFAULT '',
  "bean_name" VARCHAR(256)   NULL DEFAULT '',
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "other" VARCHAR(2048)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  "SET" FOREIGN_KEY_CHECKS = 1;

-- Column comments
COMMENT ON COLUMN "t_linkage_device"."name" IS '设备名称';
COMMENT ON COLUMN "t_linkage_device"."ip" IS '设备ip';
COMMENT ON COLUMN "t_linkage_device"."port" IS '设备端口号';
COMMENT ON COLUMN "t_linkage_device"."status" IS '设备是否可用up-不可用,down-可用';
COMMENT ON COLUMN "t_linkage_device"."category_name" IS '设备分类来自soc';
COMMENT ON COLUMN "t_linkage_device"."type" IS '设备类型';
COMMENT ON COLUMN "t_linkage_device"."type_name" IS '类型名称和type对应';
COMMENT ON COLUMN "t_linkage_device"."bean_name" IS 'spring beanName';
COMMENT ON COLUMN "t_linkage_device"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_linkage_device"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_linkage_device"."other" IS '其他信息';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_linkage_device_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_linkage_device_update_timestamp
BEFORE UPDATE ON "t_linkage_device"
FOR EACH ROW
EXECUTE FUNCTION update_t_linkage_device_timestamp();


-- Enable foreign key checks
SET session_replication_role = 'origin';

-- Update sequences
-- Run after data import:
-- SELECT setval(pg_get_serial_sequence('table_name', 'id_column'), (SELECT MAX(id_column) FROM table_name));
