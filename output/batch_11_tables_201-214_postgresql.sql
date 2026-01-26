-- ====================================================================================================
-- PostgreSQL Migration Script
-- Converted from MySQL using automated migration tool
-- Source: bigdata-web-data.sql
-- Target Database: PostgreSQL 16.x
-- Generated: 2026-01-14 19:13:25
-- ====================================================================================================

-- Set client encoding
SET client_encoding = 'UTF8';

-- Disable foreign key checks during migration
SET session_replication_role = 'replica';


DROP TABLE IF EXISTS "t_waf";
CREATE TABLE "t_waf"  (
  "id" BIGSERIAL,
  "ip" VARCHAR(45)   NULL DEFAULT NULL,
  "port" VARCHAR(45)   NULL DEFAULT NULL,
  "status" VARCHAR(45)   NULL DEFAULT NULL,
  "create_time" timestamp NULL DEFAULT NULL,
  "update_time" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "UNIQUE_IP_PORT" ON "t_waf" ("ip", "port");

-- Column comments
COMMENT ON COLUMN "t_waf"."ip" IS 'waf地址';
COMMENT ON COLUMN "t_waf"."port" IS '接口开放端口';
COMMENT ON COLUMN "t_waf"."status" IS '状态';
COMMENT ON COLUMN "t_waf"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_waf"."update_time" IS '更新时间';


DROP TABLE IF EXISTS "t_waf_block";
CREATE TABLE "t_waf_block"  (
  "id" BIGSERIAL,
  "srcAddress" VARCHAR(45)   NULL DEFAULT NULL,
  "waf_ips" VARCHAR(10000)   NULL DEFAULT NULL,
  "uuids" VARCHAR(10000)   NULL DEFAULT NULL,
  "status" INTEGER NULL DEFAULT NULL,
  "create_time" timestamp NULL DEFAULT NULL,
  "update_time" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "src_address_UNIQUE" ON "t_waf_block" ("srcAddress");

-- Column comments
COMMENT ON COLUMN "t_waf_block"."waf_ips" IS '同步到waf的设备ip';


DROP TABLE IF EXISTS "t_web_asset";
CREATE TABLE "t_web_asset"  (
  "id" SERIAL,
  "web" INTEGER NULL DEFAULT NULL,
  "asset" INTEGER NULL DEFAULT NULL,
  "type" VARCHAR(45)   NULL DEFAULT NULL,
  "createTime" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "updateTime" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE INDEX "IDX_WEB" ON "t_web_asset" ("web");
CREATE INDEX "IDX_ASSET" ON "t_web_asset" ("asset");

-- Column comments
COMMENT ON COLUMN "t_web_asset"."type" IS '资产关联类型';


DROP TABLE IF EXISTS "t_web_info";
CREATE TABLE "t_web_info"  (
  "id" SERIAL,
  "destHostName" VARCHAR(255)   NOT NULL,
  "webName" VARCHAR(500)   NULL DEFAULT '',
  "type" VARCHAR(45)   NULL DEFAULT 'Web业务系统',
  "importance" VARCHAR(45)   NULL DEFAULT '',
  "tag" VARCHAR(500)   NULL DEFAULT '',
  "personInCharge" VARCHAR(45)   NULL DEFAULT '',
  "developer" VARCHAR(45)   NULL DEFAULT '',
  "visitAddress" INTEGER NULL DEFAULT 1,
  "visitAddressValue" VARCHAR(1000)   NULL DEFAULT '',
  "osVersion" VARCHAR(45)   NULL DEFAULT '',
  "technologyArc" VARCHAR(45)   NULL DEFAULT '',
  "serverComponentVersion" VARCHAR(45)   NULL DEFAULT '',
  "webContainnerName" VARCHAR(45)   NULL DEFAULT '',
  "webContainnerVersion" VARCHAR(45)   NULL DEFAULT '',
  "systemNo" VARCHAR(45)   NULL DEFAULT '',
  "systemStats" VARCHAR(45)   NULL DEFAULT '',
  "organisation" VARCHAR(45)   NULL DEFAULT '',
  "webUser" VARCHAR(45)   NULL DEFAULT '',
  "confidentiality" VARCHAR(45)   NULL DEFAULT '',
  "integrity" VARCHAR(45)   NULL DEFAULT '',
  "availability" VARCHAR(45)   NULL DEFAULT '',
  "isHierarchyProtection" VARCHAR(45)   NULL DEFAULT '',
  "description" VARCHAR(500)   NULL DEFAULT '',
  "netrafficMonitor" INTEGER NULL DEFAULT 1,
  "accessMonitor" INTEGER NULL DEFAULT 0,
  "accessRate" INTEGER NULL DEFAULT 80,
  "location" VARCHAR(45)   NULL DEFAULT '',
  "accessRateValue" VARCHAR(45)   NULL DEFAULT '0,0,0,0,0,0,0',
  "visitCount" VARCHAR(256)   NULL DEFAULT '0,0,0,0,0,0,0',
  "source" VARCHAR(45)   NULL DEFAULT '0',
  "sHigh" INTEGER NULL DEFAULT NULL,
  "sMiddle" INTEGER NULL DEFAULT NULL,
  "sLow" INTEGER NULL DEFAULT NULL,
  "request" VARCHAR(45)   NULL DEFAULT NULL,
  "response" VARCHAR(45)   NULL DEFAULT NULL,
  "createTime" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "updateTime" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "destHostName_UNIQUE" ON "t_web_info" ("destHostName");

-- Column comments
COMMENT ON COLUMN "t_web_info"."destHostName" IS '域名';
COMMENT ON COLUMN "t_web_info"."webName" IS '系统名称';
COMMENT ON COLUMN "t_web_info"."type" IS '系统类型';
COMMENT ON COLUMN "t_web_info"."importance" IS '系统重要性';
COMMENT ON COLUMN "t_web_info"."tag" IS '系统标签';
COMMENT ON COLUMN "t_web_info"."personInCharge" IS '责任人';
COMMENT ON COLUMN "t_web_info"."developer" IS '开发商';
COMMENT ON COLUMN "t_web_info"."visitAddress" IS '访问地址状态：0关闭，1开启。';
COMMENT ON COLUMN "t_web_info"."visitAddressValue" IS '访问地址';
COMMENT ON COLUMN "t_web_info"."osVersion" IS '系统版本';
COMMENT ON COLUMN "t_web_info"."technologyArc" IS '技术架构';
COMMENT ON COLUMN "t_web_info"."serverComponentVersion" IS '服务组件版本';
COMMENT ON COLUMN "t_web_info"."webContainnerName" IS 'Web容器名称';
COMMENT ON COLUMN "t_web_info"."webContainnerVersion" IS 'Web容器版本';
COMMENT ON COLUMN "t_web_info"."systemNo" IS '系统编号';
COMMENT ON COLUMN "t_web_info"."systemStats" IS '系统状态';
COMMENT ON COLUMN "t_web_info"."organisation" IS '组织架构';
COMMENT ON COLUMN "t_web_info"."webUser" IS '使用人';
COMMENT ON COLUMN "t_web_info"."confidentiality" IS 'C-机密性';
COMMENT ON COLUMN "t_web_info"."integrity" IS 'I-完整性';
COMMENT ON COLUMN "t_web_info"."availability" IS 'A-可用性';
COMMENT ON COLUMN "t_web_info"."isHierarchyProtection" IS '是否等保';
COMMENT ON COLUMN "t_web_info"."description" IS '描述';
COMMENT ON COLUMN "t_web_info"."netrafficMonitor" IS '流量监控；0关闭，1开启（默认）';
COMMENT ON COLUMN "t_web_info"."accessMonitor" IS '访问成功率监控：0关闭，1开启';
COMMENT ON COLUMN "t_web_info"."accessRate" IS '访问成功率';
COMMENT ON COLUMN "t_web_info"."location" IS '地理位置';
COMMENT ON COLUMN "t_web_info"."accessRateValue" IS '访问成功率7个点';
COMMENT ON COLUMN "t_web_info"."visitCount" IS '访问次数7个点';
COMMENT ON COLUMN "t_web_info"."source" IS '来源:0-人工录入，1-Web自动发现';
COMMENT ON COLUMN "t_web_info"."request" IS '请求';
COMMENT ON COLUMN "t_web_info"."response" IS '响应';


DROP TABLE IF EXISTS "t_web_sub";
CREATE TABLE "t_web_sub"  (
  "id" SERIAL,
  "web" INTEGER NOT NULL,
  "subDomain" VARCHAR(255)   NULL DEFAULT '',
  "createTime" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "updateTime" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "subDomain_UNIQUE" ON "t_web_sub" ("subDomain");

-- Column comments
COMMENT ON COLUMN "t_web_sub"."web" IS '域名id';
COMMENT ON COLUMN "t_web_sub"."subDomain" IS '子域名';


DROP TABLE IF EXISTS "t_webscan_issuedata";
CREATE TABLE "t_webscan_issuedata"  (
  "id" BIGSERIAL,
  "parentid" BIGINT NOT NULL,
  "cve" VARCHAR(128)   NULL DEFAULT NULL,
  "issue" VARCHAR(64)   NULL DEFAULT NULL,
  "url" VARCHAR(512)   NULL DEFAULT NULL,
  "value" VARCHAR(256)   NULL DEFAULT NULL,
  "state" INTEGER NOT NULL,
  PRIMARY KEY ("id", "parentid")
);

-- Column comments
COMMENT ON COLUMN "t_webscan_issuedata"."id" IS 'id';


DROP TABLE IF EXISTS "t_webscan_issuetype";
CREATE TABLE "t_webscan_issuetype"  (
  "id" BIGSERIAL,
  "parentid" BIGINT NOT NULL,
  "advice" text   NULL,
  "desc" VARCHAR(10000)   NULL DEFAULT NULL,
  "level" VARCHAR(4)   NULL DEFAULT NULL,
  "lvl" INTEGER NULL DEFAULT NULL,
  "name" VARCHAR(128)   NULL DEFAULT NULL,
  "cve" VARCHAR(256)   NULL DEFAULT NULL,
  "state" INTEGER NOT NULL,
  "application_category" VARCHAR(32)   NULL DEFAULT NULL,
  "plugin_id" INTEGER NULL DEFAULT NULL,
  "vul_id" INTEGER NULL DEFAULT NULL,
  "nsfocus_id" VARCHAR(16)   NULL DEFAULT NULL,
  "port" VARCHAR(10)   NULL DEFAULT NULL,
  "service" VARCHAR(20)   NULL DEFAULT NULL,
  "vul_type" VARCHAR(20)   NULL DEFAULT NULL,
  "weak_pass_user" VARCHAR(20)   NULL DEFAULT NULL,
  "weak_password" VARCHAR(20)   NULL DEFAULT NULL,
  "createtime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "kb" VARCHAR(20)   NULL DEFAULT NULL,
  "exist" BOOLEAN NULL DEFAULT 0,
  "pubdate" VARCHAR(30)   NULL DEFAULT NULL,
  "status" VARCHAR(20)   NULL DEFAULT NULL,
  "patch_size" VARCHAR(255)   NULL DEFAULT NULL,
  "app_name" VARCHAR(255)   NULL DEFAULT NULL,
  "app_version" VARCHAR(255)   NULL DEFAULT NULL,
  "os_version" VARCHAR(255)   NULL DEFAULT NULL,
  "edr_id" VARCHAR(255)   NULL DEFAULT NULL,
  "weak_type" VARCHAR(50)   NULL DEFAULT '其他',
  PRIMARY KEY ("id", "parentid")
);

-- Column comments
COMMENT ON COLUMN "t_webscan_issuetype"."id" IS 'id';
COMMENT ON COLUMN "t_webscan_issuetype"."port" IS '端口';
COMMENT ON COLUMN "t_webscan_issuetype"."service" IS '服务';
COMMENT ON COLUMN "t_webscan_issuetype"."vul_type" IS '漏洞类型';
COMMENT ON COLUMN "t_webscan_issuetype"."weak_pass_user" IS '弱口令用戶';
COMMENT ON COLUMN "t_webscan_issuetype"."weak_password" IS '弱口令';
COMMENT ON COLUMN "t_webscan_issuetype"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_webscan_issuetype"."updatetime" IS '修改时间';
COMMENT ON COLUMN "t_webscan_issuetype"."kb" IS 'EDR windows相关 补丁名称';
COMMENT ON COLUMN "t_webscan_issuetype"."exist" IS 'EDR windows相关 是否存在补丁';
COMMENT ON COLUMN "t_webscan_issuetype"."pubdate" IS 'EDR windows相关 发布时间';
COMMENT ON COLUMN "t_webscan_issuetype"."status" IS 'EDR windows相关 未修复 修复中...';
COMMENT ON COLUMN "t_webscan_issuetype"."patch_size" IS 'EDR windows相关 补丁大小';
COMMENT ON COLUMN "t_webscan_issuetype"."app_name" IS 'EDR linux相关 app名称';
COMMENT ON COLUMN "t_webscan_issuetype"."app_version" IS 'EDR linux相关 app版本';
COMMENT ON COLUMN "t_webscan_issuetype"."os_version" IS 'EDR linux相关 os版本';
COMMENT ON COLUMN "t_webscan_issuetype"."edr_id" IS 'EDR id';
COMMENT ON COLUMN "t_webscan_issuetype"."weak_type" IS 'EDR Windows系统补丁还是Linux系统漏洞,默认其他';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_webscan_issuetype_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updatetime" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_webscan_issuetype_update_timestamp
BEFORE UPDATE ON "t_webscan_issuetype"
FOR EACH ROW
EXECUTE FUNCTION update_t_webscan_issuetype_timestamp();


DROP TABLE IF EXISTS "t_webscan_site";
CREATE TABLE "t_webscan_site"  (
  "id" BIGSERIAL,
  "parentid" INTEGER NULL DEFAULT NULL,
  "type" VARCHAR(64)   NULL DEFAULT NULL,
  "average_response_time" VARCHAR(64)   NULL DEFAULT NULL,
  "average_send_count" VARCHAR(64)   NULL DEFAULT NULL,
  "domain" VARCHAR(64)   NULL DEFAULT NULL,
  "failed_request_count" VARCHAR(64)   NULL DEFAULT NULL,
  "issuecnt" VARCHAR(64)   NULL DEFAULT NULL,
  "name" VARCHAR(64)   NULL DEFAULT NULL,
  "receive_bytes" VARCHAR(64)   NULL DEFAULT NULL,
  "recent_failed_request_count" VARCHAR(64)   NULL DEFAULT NULL,
  "request_count" VARCHAR(64)   NULL DEFAULT NULL,
  "scan_time" VARCHAR(64)   NULL DEFAULT NULL,
  "scan_time_remain" VARCHAR(64)   NULL DEFAULT NULL,
  "score" VARCHAR(64)   NULL DEFAULT NULL,
  "send_bytes" VARCHAR(64)   NULL DEFAULT NULL,
  "server" VARCHAR(64)   NULL DEFAULT NULL,
  "site_port" VARCHAR(64)   NULL DEFAULT NULL,
  "site_progress" VARCHAR(64)   NULL DEFAULT NULL,
  "site_protocol" VARCHAR(64)   NULL DEFAULT NULL,
  "start_first_time" VARCHAR(64)   NULL DEFAULT NULL,
  "start_time" VARCHAR(64)   NULL DEFAULT NULL,
  "test_count" VARCHAR(64)   NULL DEFAULT NULL,
  "test_done_count" VARCHAR(64)   NULL DEFAULT NULL,
  "time" VARCHAR(64)   NULL DEFAULT NULL,
  "url_count" VARCHAR(64)   NULL DEFAULT NULL,
  "visited_count" VARCHAR(64)   NULL DEFAULT NULL,
  "host_score" REAL NULL DEFAULT NULL,
  "importime" TEXT   NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_webscan_site"."id" IS 'id';


DROP TABLE IF EXISTS "t_work_order";
CREATE TABLE "t_work_order"  (
  "id" SERIAL,
  "serial_id" CHAR(14)   NOT NULL,
  "subject" VARCHAR(255)   NOT NULL,
  "tags" text   NULL,
  "priority" enum('0','1','2')   NOT NULL DEFAULT '2',
  "assignee" VARCHAR(255)   NULL DEFAULT NULL,
  "assignee_id" VARCHAR(255)   NOT NULL,
  "security_object" VARCHAR(255)   NULL DEFAULT NULL,
  "security_detail" text   NULL,
  "security_info" text   NULL,
  "status" enum('0','1','2','3')   NOT NULL DEFAULT '0',
  "approach" enum('0','1')   NOT NULL DEFAULT '0',
  "author" VARCHAR(255)   NOT NULL,
  "author_id" VARCHAR(255)   NOT NULL,
  "assignee_comment" text   NULL,
  "security_alert_id" VARCHAR(255)   NULL DEFAULT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "action" enum('0','1','2','3','4','5','6')   NOT NULL DEFAULT '2',
  "attach_files" text   NULL,
  "status_modified_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_work_order"."id" IS '自增主键';
COMMENT ON COLUMN "t_work_order"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';
COMMENT ON COLUMN "t_work_order"."subject" IS '工单主题';
COMMENT ON COLUMN "t_work_order"."tags" IS '标签名称, 逗号分隔';
COMMENT ON COLUMN "t_work_order"."priority" IS '订单优先级, 高:0,中:1,低:2';
COMMENT ON COLUMN "t_work_order"."assignee" IS '工单受理人';
COMMENT ON COLUMN "t_work_order"."assignee_id" IS '工单受理人在t_user表中的id';
COMMENT ON COLUMN "t_work_order"."security_object" IS '安全对象, 如: IP, 主机名, 服务器, 部门等';
COMMENT ON COLUMN "t_work_order"."security_detail" IS '安全的详细描述';
COMMENT ON COLUMN "t_work_order"."security_info" IS '安全的举证信息: 告警事件ID, 资产IP, 域名/URL, 攻击IP';
COMMENT ON COLUMN "t_work_order"."status" IS '订单状态, 未处理:0 ,处理中:1,已解决:2,已关闭:3';
COMMENT ON COLUMN "t_work_order"."approach" IS '订单录入方式, 人工创建:0, 自动创建:1';
COMMENT ON COLUMN "t_work_order"."author" IS '工单创建人';
COMMENT ON COLUMN "t_work_order"."author_id" IS '工单创建人在t_user表中的id';
COMMENT ON COLUMN "t_work_order"."assignee_comment" IS '工单代理人的备注描述';
COMMENT ON COLUMN "t_work_order"."security_alert_id" IS '安全告警id';
COMMENT ON COLUMN "t_work_order"."created_at" IS '记录创建时间';
COMMENT ON COLUMN "t_work_order"."updated_at" IS '记录更新时间';
COMMENT ON COLUMN "t_work_order"."action" IS '处置动作, 请处理: 0, 请审批: 1, 请审核: 2, 请修补: 3, 请查杀: 4, 请验证: 5, 请测试: 6';
COMMENT ON COLUMN "t_work_order"."attach_files" IS '工单附件';
COMMENT ON COLUMN "t_work_order"."status_modified_at" IS '工单状态修改的时间点';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_work_order_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updated_at" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_work_order_update_timestamp
BEFORE UPDATE ON "t_work_order"
FOR EACH ROW
EXECUTE FUNCTION update_t_work_order_timestamp();


DROP TABLE IF EXISTS "t_work_order_operation_history";
CREATE TABLE "t_work_order_operation_history"  (
  "id" SERIAL,
  "serial_id" CHAR(14)   NOT NULL,
  "operater" VARCHAR(255)   NOT NULL,
  "operater_host_address" VARCHAR(255)   NOT NULL,
  "operater_operations" text   NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "action" enum('-1','0','1','2','3','4','5','6')   NOT NULL DEFAULT '-1',
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_work_order_operation_history"."id" IS '表自增序列';
COMMENT ON COLUMN "t_work_order_operation_history"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';
COMMENT ON COLUMN "t_work_order_operation_history"."operater" IS '工单修改人';
COMMENT ON COLUMN "t_work_order_operation_history"."operater_host_address" IS '工单修改人的主机地址';
COMMENT ON COLUMN "t_work_order_operation_history"."operater_operations" IS '工单修改人的操作';
COMMENT ON COLUMN "t_work_order_operation_history"."created_at" IS '记录创建时间';
COMMENT ON COLUMN "t_work_order_operation_history"."action" IS '处置动作, 未知动作: -1, 请处理: 0, 请审批: 1, 请审核: 2, 请修补: 3, 请查杀: 4, 请验证: 5, 请测试: 6';


DROP TABLE IF EXISTS "t_work_order_status_trace";
CREATE TABLE "t_work_order_status_trace"  (
  "id" SERIAL,
  "org_id" VARCHAR(255)   NOT NULL,
  "serial_id" CHAR(14)   NOT NULL,
  "status" enum('0','1','2','3','4')   NOT NULL DEFAULT '0',
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_work_order_status_trace"."id" IS '数据库自增id';
COMMENT ON COLUMN "t_work_order_status_trace"."org_id" IS '工单所属组织id';
COMMENT ON COLUMN "t_work_order_status_trace"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';
COMMENT ON COLUMN "t_work_order_status_trace"."status" IS '订单状态, 未处理:0 ,处理中:1,已解决:2,已关闭:3,已删除:4';
COMMENT ON COLUMN "t_work_order_status_trace"."created_at" IS '记录创建时间';


DROP TABLE IF EXISTS "t_work_order_tags_relation";
CREATE TABLE "t_work_order_tags_relation"  (
  "id" SERIAL,
  "name" VARCHAR(255)   NOT NULL,
  "serial_id" CHAR(14)   NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_work_order_tags_relation"."id" IS '自增主键';
COMMENT ON COLUMN "t_work_order_tags_relation"."name" IS 'tag 的名字';
COMMENT ON COLUMN "t_work_order_tags_relation"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';
COMMENT ON COLUMN "t_work_order_tags_relation"."created_at" IS '记录创建时间';
COMMENT ON COLUMN "t_work_order_tags_relation"."updated_at" IS '记录更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_work_order_tags_relation_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updated_at" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_work_order_tags_relation_update_timestamp
BEFORE UPDATE ON "t_work_order_tags_relation"
FOR EACH ROW
EXECUTE FUNCTION update_t_work_order_tags_relation_timestamp();


DROP TABLE IF EXISTS "t_work_order_user_org_relation";
CREATE TABLE "t_work_order_user_org_relation"  (
  "id" SERIAL,
  "user_id" VARCHAR(255)   NOT NULL,
  "org_id" VARCHAR(255)   NOT NULL DEFAULT '',
  "serial_id" CHAR(14)   NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_work_order_user_org_relation"."id" IS '自增主键';
COMMENT ON COLUMN "t_work_order_user_org_relation"."user_id" IS 'user的id';
COMMENT ON COLUMN "t_work_order_user_org_relation"."org_id" IS 'org的id';
COMMENT ON COLUMN "t_work_order_user_org_relation"."serial_id" IS '获取工单编号, 15个字符的定长序列, YYMMDD + 八位数字(00000001 - 99999999), 如 19011112120001';
COMMENT ON COLUMN "t_work_order_user_org_relation"."created_at" IS '记录创建时间';
COMMENT ON COLUMN "t_work_order_user_org_relation"."updated_at" IS '记录更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_work_order_user_org_relation_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updated_at" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_work_order_user_org_relation_update_timestamp
BEFORE UPDATE ON "t_work_order_user_org_relation"
FOR EACH ROW
EXECUTE FUNCTION update_t_work_order_user_org_relation_timestamp();


DROP TABLE IF EXISTS "updateinfo";
CREATE TABLE "updateinfo"  (
  "id" SERIAL,
  "name" VARCHAR(100)   NULL DEFAULT NULL,
  "version" VARCHAR(100)   NULL DEFAULT NULL,
  "build" VARCHAR(40)   NULL DEFAULT NULL,
  "userer" VARCHAR(40)   NULL DEFAULT NULL,
  "ip" VARCHAR(40)   NULL DEFAULT NULL,
  "updatetime" VARCHAR(40)   NULL DEFAULT NULL,
  "result" VARCHAR(100)   NULL DEFAULT NULL,
  "remark" VARCHAR(200)   NULL DEFAULT NULL,
  "upload_type" VARCHAR(32)   NULL DEFAULT NULL,
  "agent_type" VARCHAR(32)   NULL DEFAULT NULL,
  "org" VARCHAR(128)   NULL DEFAULT NULL,
  "package_type" VARCHAR(32)   NULL DEFAULT NULL,
  "data_type" VARCHAR(100)   NOT NULL,
  PRIMARY KEY ("id")
);
  "DROP" VIEW IF EXISTS "t_sev_agent_detail_view";,
  "CREATE" ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW "t_sev_agent_detail_view" AS select "tsai"."agent_code" AS "agentCode","tsai"."single_login_uri" AS "singleLoginUri","tsai"."agent_name" AS "agentName","tsat"."agent_type" AS "agentType","tsat"."agent_type_name" AS "agentTypeName","tsai"."agent_ip" AS "agentIp","tsai"."machine_code" AS "machineCode","to"."orgId" AS "orgId","to"."orgName" AS "orgName",if(("tsai"."status" = 'offline'),NULL,"tsam"."cpu_usage") AS "cpuUsage",if(("tsai"."status" = 'offline'),NULL,"tsam"."memory_total") AS "memoryTotal",if(("tsai"."status" = 'offline'),NULL,"tsam"."memory_use") AS "memoryUse",if(("tsai"."status" = 'offline'),NULL,("tsam"."memory_use" / "tsam"."memory_total")) AS "memoryRadio",if(("tsai"."status" = 'offline'),NULL,"tsam"."disk_total") AS "diskTotal",if(("tsai"."status" = 'offline'),NULL,"tsam"."disk_use") AS "diskUse",if(("tsai"."status" = 'offline'),NULL,("tsam"."disk_use" / "tsam"."disk_total")) AS "diskRadio","tsai"."status" AS "status","tsai"."regist_time" AS "registTime","tsam"."metric3" AS "metric3","tsai"."soft_version" AS "softVersion","tsai"."rule_version" AS "ruleVersion","tbf"."file_name" AS "fileName","tsal"."expire_time" AS "expireTime","tsal"."license_type" AS "licenseType","tsam"."create_time" AS "offlineTime" from ((((("t_sev_agent_info" "tsai" left join "t_sev_agent_type" "tsat" on(("tsai"."agent_type" = "tsat"."agent_type"))) left join "t_organization" "to" on(("to"."orgId" = "tsai"."org_id"))) left join "t_sev_agent_license" "tsal" on(("tsai"."agent_code" = "tsal"."agent_code"))) left join "t_bs_files" "tbf" on(("tsal"."file_uuid" = "tbf"."uuid"))) left join "t_sev_agent_monitor" "tsam" on(("tsai"."monitor_id" = "tsam"."id")));,
  "DROP" VIEW IF EXISTS "t_sev_agent_view";,
  "CREATE" ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW "t_sev_agent_view" AS select "tsai"."agent_code" AS "agentCode","tsai"."single_login_uri" AS "singleLoginUri","tsai"."agent_name" AS "agentName","tsat"."agent_type" AS "agentType","tsat"."agent_type_name" AS "agentTypeName","tsai"."agent_ip" AS "agentIp","tsai"."machine_code" AS "machineCode","to"."orgName" AS "orgName",if(("tsai"."status" = 'offline'),NULL,"tsam"."cpu_usage") AS "cpuUsage",if(("tsai"."status" = 'offline'),NULL,"tsam"."memory_total") AS "memoryTotal",if(("tsai"."status" = 'offline'),NULL,"tsam"."memory_use") AS "memoryUse",if(("tsai"."status" = 'offline'),NULL,("tsam"."memory_use" / "tsam"."memory_total")) AS "memoryRadio",if(("tsai"."status" = 'offline'),NULL,"tsam"."disk_total") AS "diskTotal",if(("tsai"."status" = 'offline'),NULL,"tsam"."disk_use") AS "diskUse",if(("tsai"."status" = 'offline'),NULL,("tsam"."disk_use" / "tsam"."disk_total")) AS "diskRadio","tsai"."status" AS "status","tsai"."regist_time" AS "registTime","tsal"."expire_time" AS "expireTime","tsal"."license_type" AS "licenseType","tsam"."create_time" AS "offlineTime" from (((("t_sev_agent_info" "tsai" left join "t_sev_agent_type" "tsat" on(("tsai"."agent_type" = "tsat"."agent_type"))) left join "t_organization" "to" on(("to"."orgId" = "tsai"."org_id"))) left join "t_sev_agent_license" "tsal" on(("tsai"."agent_code" = "tsal"."agent_code"))) left join "t_sev_agent_monitor" "tsam" on(("tsai"."monitor_id" = "tsam"."id")));,
  "DROP" PROCEDURE IF EXISTS "add_col_if_not_exists";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "add_col_if_not_exists"(var_table_name VARCHAR (100),
  "var_column_name" VARCHAR (100),
  "var_column_type_str" VARCHAR (200)),
  "IF" NOT EXISTS (,
  "SELECT" 1  FROM information_schema.COLUMNS,
  "WHERE" table_schema = DATABASE(),
  "AND" TABLE_NAME = var_table_name,
  "AND" COLUMN_NAME = var_column_name,
  "SET" @sqlcmd=concat("ALTER TABLE ",var_table_name," ADD COLUMN ",var_column_name,var_column_type_str,";");,
  "PREPARE" stmt FROM @sqlcmd;,
  "EXECUTE" stmt;,
  "select" concat(var_table_name," 's COLUMN ", var_column_name," IS EXISTS");,
  "END" IF;,
  "delimiter" ;,
  "DROP" PROCEDURE IF EXISTS "create_index";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "create_index"(given_table VARCHAR(64),
  "given_index" VARCHAR(64),
  "given_columns" VARCHAR(64)),
  "DECLARE" IndexIsThere INTEGER;,
  "SELECT" COUNT(1) INTO IndexIsThere,
  "FROM" INFORMATION_SCHEMA.STATISTICS,
  "WHERE" table_schema = DATABASE(),
  "AND" table_name = given_table,
  "AND" index_name = given_index;,
  "IF" IndexIsThere = 0 THEN,
  "SET" @sqlstmt = CONCAT('CREATE INDEX ',given_index,' ON "',
  "PREPARE" st FROM @sqlstmt;,
  "EXECUTE" st;,
  "DEALLOCATE" PREPARE st;,
  "SELECT" CONCAT('Index ',given_index,' already exists on Table ',
  "END" IF;,
  "delimiter" ;,
  "DROP" PROCEDURE IF EXISTS "drop_col_if_not_exists";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "drop_col_if_not_exists"(var_table_name VARCHAR (20),
  "var_column_name" VARCHAR (20)),
  "IF" EXISTS (,
  "SELECT" 1  FROM information_schema.COLUMNS,
  "WHERE" table_schema = DATABASE(),
  "AND" TABLE_NAME = var_table_name,
  "AND" COLUMN_NAME = var_column_name,
  "SET" @sqlcmd1=concat("ALTER TABLE ",var_table_name," DROP COLUMN ",var_column_name,";");,
  "PREPARE" stmt FROM @sqlcmd1;,
  "EXECUTE" stmt;,
  "select" concat(var_table_name," 's COLUMN ", var_column_name," IS NOT EXISTS");,
  "END" IF;,
  "delimiter" ;,
  "DROP" PROCEDURE IF EXISTS "drop_index_if_exists";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "drop_index_if_exists"(given_table VARCHAR(64),
  "given_index" VARCHAR(64)),
  "DECLARE" IndexIsThere INTEGER;,
  "SELECT" COUNT(1) INTO IndexIsThere,
  "FROM" INFORMATION_SCHEMA.STATISTICS,
  "WHERE" table_schema = DATABASE(),
  "AND" table_name = given_table,
  "AND" index_name = given_index;,
  "IF" IndexIsThere = 1 THEN,
  "SET" @sqlstmt = CONCAT('ALTER TABLE "',DATABASE(),'".',given_table,
  "PREPARE" st FROM @sqlstmt;,
  "EXECUTE" st;,
  "DEALLOCATE" PREPARE st;,
  "SELECT" CONCAT('Index ',given_index,' not exists on Table ',
  "END" IF;,
  "delimiter" ;,
  "DROP" PROCEDURE IF EXISTS "drop_primary_if_exists";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "drop_primary_if_exists"(given_table VARCHAR(64)),
  "DECLARE" PrimaryIsThere INTEGER;,
  "SELECT" COUNT(1) INTO PrimaryIsThere,
  "FROM" INFORMATION_SCHEMA.KEY_COLUMN_USAGE,
  "WHERE" table_schema = DATABASE(),
  "AND" table_name = given_table,
  "AND" CONSTRAINT_NAME = 'PRIMARY';,
  "IF" PrimaryIsThere = 1 THEN,
  "SET" @sqlstmt = CONCAT('ALTER TABLE "',DATABASE(),'".',given_table,
  "PREPARE" st FROM @sqlstmt;,
  "EXECUTE" st;,
  "DEALLOCATE" PREPARE st;,
  "SELECT" CONCAT('PRIMARY KEY not exists on Table ',
  "END" IF;,
  "delimiter" ;,
  "DROP" PROCEDURE IF EXISTS "operate_role";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "operate_role"(),
  "declare" _count int;,
  "set" _count=(select count(*) from information_schema.COLUMNS,
  "where" TABLE_NAME = 't_role' and,
  "if" _count=0 then,
  "ALTER" TABLE "t_role",
  "ADD" COLUMN "update_switch" INT NOT NULL DEFAULT 1 AFTER "updatetime",
  "ADD" COLUMN "delete_switch" INT NOT NULL DEFAULT 1 AFTER "update_switch";,
  "end" if;,
  "delimiter" ;,
  "DROP" PROCEDURE IF EXISTS "operate_role_sort";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "operate_role_sort"(),
  "declare" _count int;,
  "set" _count=(select count(*) from information_schema.COLUMNS,
  "where" TABLE_NAME = 't_role' and,
  "if" _count=0 then,
  "ALTER" TABLE "t_role",
  "ADD" COLUMN "order" INT NOT NULL DEFAULT 0 AFTER "update_switch";,
  "end" if;,
  "delimiter" ;,
  "DROP" PROCEDURE IF EXISTS "operate_user";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "operate_user"(),
  "declare" _count int;,
  "set" _count=(select count(*) from information_schema.COLUMNS,
  "where" TABLE_NAME = 't_user' and,
  "if" _count=0 then,
  "ALTER" TABLE "t_user",
  "ADD" COLUMN  "ip_switch" INT NOT NULL DEFAULT 0 AFTER "updatetime",
  "ADD" COLUMN "default_pwd" INT NOT NULL DEFAULT 0 AFTER "ip_switch";,
  "ALTER" TABLE "t_user",
  "CHANGE" COLUMN "default_pwd" "default_pwd" INT(11) NOT NULL DEFAULT 1,
  "ADD" COLUMN "update_switch" INT NOT NULL DEFAULT 1 AFTER "default_pwd",
  "ADD" COLUMN "delete_switch" INT NOT NULL DEFAULT 1 AFTER "update_switch",
  "ADD" COLUMN "reset_switch" INT NOT NULL DEFAULT 1 AFTER "delete_switch";,
  "end" if;,
  "delimiter" ;,
  "DROP" PROCEDURE IF EXISTS "operate_user_login";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "operate_user_login"(),
  "declare" _count int;,
  "set" _count=(select count(*) from information_schema.COLUMNS,
  "where" TABLE_NAME = 't_user' and,
  "if" _count=0 then,
  "ALTER" TABLE "t_user",
  "CHANGE" COLUMN "locktime" "locktime" BIGINT(20) NULL DEFAULT '0',
  "ADD" COLUMN "lock" INT NOT NULL DEFAULT 0 AFTER "reset_switch",
  "ADD" COLUMN "first_failure_time" TIMESTAMP NOT NULL DEFAULT '2013-08-08 00:00:00' AFTER "lock",
  "ADD" COLUMN "failure_times" INT NOT NULL DEFAULT 0 AFTER "first_failure_time",
  "ADD" COLUMN "first_lock_time" TIMESTAMP NOT NULL DEFAULT '2013-08-08 00:00:00' AFTER "failure_times",
  "ADD" COLUMN "out_of_date" INT NOT NULL DEFAULT 0 AFTER "first_lock_time",
  "ADD" COLUMN "reset_pwd_time" TIMESTAMP NOT NULL DEFAULT '2013-08-08 00:00:00' AFTER "out_of_date",
  "ADD" COLUMN "is_portal" INT NOT NULL DEFAULT 0 AFTER "reset_pwd_time";,
  "end" if;,
  "delimiter" ;,
  "DROP" PROCEDURE IF EXISTS "sequence_data";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "sequence_data"(),
  "DECLARE" i INT;,
  "SET" i = 0;,
  "WHILE" i < 10000 DO,
  INSERT INTO sequence (seq) VALUES (i);,
  "SET" i = i + 1;,
  "END" WHILE;,
  "delimiter" ;,
  "DROP" PROCEDURE IF EXISTS "update_assetLevel_value";,
  "delimiter" ;;,
  "CREATE" PROCEDURE "update_assetLevel_value`(),
  "IF" EXISTS (,
  "SELECT" 1  FROM information_schema.COLUMNS,
  "WHERE" table_schema = DATABASE(),
  "AND" TABLE_NAME = "t_asset_cal_results",
  "AND" COLUMN_NAME = "fallen",
  "update" t_asset_cal_results,
  "SET" assetLevel =,
  "WHEN" fallen >0 THEN 4,
  "WHEN" highRisk>0 THEN 3,
  "WHEN" lowRisk>0 THEN 2,
  "WHEN" safe>0 THEN 1,
  "ELSE" 0,
  "select" " t_asset_cal_results's COLUMN fallen IS NOT EXISTS";,
  "END" IF;,
  "delimiter" ;,
  "SET" FOREIGN_KEY_CHECKS = 1;,
  "SET" FOREIGN_KEY_CHECKS = 1;

-- Column comments
COMMENT ON COLUMN "updateinfo"."name" IS '包名';
COMMENT ON COLUMN "updateinfo"."version" IS '版本号';
COMMENT ON COLUMN "updateinfo"."build" IS 'build号';
COMMENT ON COLUMN "updateinfo"."userer" IS '更新发起用户';
COMMENT ON COLUMN "updateinfo"."ip" IS '更新发起IP';
COMMENT ON COLUMN "updateinfo"."updatetime" IS '修改时间';
COMMENT ON COLUMN "updateinfo"."result" IS '更新结果';
COMMENT ON COLUMN "updateinfo"."upload_type" IS '上传方式';
COMMENT ON COLUMN "updateinfo"."agent_type" IS '探针类型';
COMMENT ON COLUMN "updateinfo"."org" IS '组织架构';
COMMENT ON COLUMN "updateinfo"."package_type" IS '升级包类型（software、rule、intelligence）';
COMMENT ON COLUMN "updateinfo"."data_type" IS '数据类型，upload:上传记录，upgrade:升级记录';
COMMENT ON COLUMN "updateinfo"."ADD" IS '列表展示是否可以更新：0不可以，1可以';
COMMENT ON COLUMN "updateinfo"."ADD" IS '是否可以删除，0不可，1可以。';
COMMENT ON COLUMN "updateinfo"."ADD" IS '列表排序：0不参与排序，非0可以';
COMMENT ON COLUMN "updateinfo"."ADD" IS '是否制定IP登陆，0不开启，1开启。默认0。';
COMMENT ON COLUMN "updateinfo"."ADD" IS '0默认密码，需要修改；1已修改密码。  首次登陆除三个内置用户外的用户首次登陆必须修改密码。添加一个用户密码是否修改的字段 0  未修改-4 修改后字段 更新1 ；重置密码后，字段改为0，未修改-4等';
COMMENT ON COLUMN "updateinfo"."CHANGE" IS '0已修改密码，1默认密码，需要修改。  首次登陆除三个内置用户（升级除外）的用户首次登陆必须修改密码。添加一个用户密码是否修改的字段： 1  未修改-4 修改后字段 更新0 ；重置密码后，字段改为0，未修改-4等';
COMMENT ON COLUMN "updateinfo"."ADD" IS '是否允许更新：0不允许，1允许。';
COMMENT ON COLUMN "updateinfo"."ADD" IS '是否允许删除：0不允许，1允许';
COMMENT ON COLUMN "updateinfo"."ADD" IS '是否允许重制密码：0不允许；1允许';
COMMENT ON COLUMN "updateinfo"."CHANGE" IS '用户逻辑删除时locktime为-2';
COMMENT ON COLUMN "updateinfo"."ADD" IS '是否被锁，0:没有被锁，1:加锁';
COMMENT ON COLUMN "updateinfo"."ADD" IS '登录失败次数，默认0次';
COMMENT ON COLUMN "updateinfo"."ADD" IS '是否过期；0:未有过期；1过期了。';
COMMENT ON COLUMN "updateinfo"."ADD" IS '最后一次修改密码时间，默认0。';
COMMENT ON COLUMN "updateinfo"."ADD" IS '对统一门户进行启用或者禁用，默认为启用状态。1启用，0禁用。';


-- Enable foreign key checks
SET session_replication_role = 'origin';

-- Update sequences
-- Run after data import:
-- SELECT setval(pg_get_serial_sequence('table_name', 'id_column'), (SELECT MAX(id_column) FROM table_name));
