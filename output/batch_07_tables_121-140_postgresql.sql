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


DROP TABLE IF EXISTS "t_nsfocus_task";
CREATE TABLE "t_nsfocus_task"  (
  "id" SERIAL,
  "deviceid" INTEGER NOT NULL,
  "taskid" INTEGER NOT NULL,
  "name" VARCHAR(64)   NULL DEFAULT NULL,
  "type" INTEGER NULL DEFAULT NULL,
  "status" INTEGER NULL DEFAULT NULL,
  "process" INTEGER NULL DEFAULT NULL,
  "starttime" VARCHAR(32)   NULL DEFAULT NULL,
  "endtime" VARCHAR(32)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_nsfocus_task"."id" IS 'id';


DROP TABLE IF EXISTS "t_online_judge";
CREATE TABLE "t_online_judge"  (
  "id" BIGSERIAL,
  "windowId" VARCHAR(255)   NULL DEFAULT NULL,
  "aggCondition" VARCHAR(255)   NULL DEFAULT NULL,
  "eventId" VARCHAR(255)   NULL DEFAULT NULL,
  "label" VARCHAR(255)   NULL DEFAULT NULL,
  "level" INTEGER NULL DEFAULT NULL,
  "alarm_detail" text   NULL,
  "report_type" INTEGER NULL DEFAULT NULL,
  "report_reason" TEXT   NULL,
  "user_name" VARCHAR(255)   NULL DEFAULT NULL,
  "phone" VARCHAR(255)   NULL DEFAULT NULL,
  "alarm_json" text   NULL,
  "enclosure" text   NULL,
  "handle_time" TIMESTAMP NULL DEFAULT NULL,
  "handle_type" VARCHAR(255)   NULL DEFAULT NULL,
  "handle_username" VARCHAR(255)   NULL DEFAULT NULL,
  "handle_keyword" VARCHAR(255)   NULL DEFAULT NULL,
  "handle_name" VARCHAR(255)   NULL DEFAULT NULL,
  "handle_suggest" text   NULL,
  "handle_classify" VARCHAR(255)   NULL DEFAULT NULL,
  "handle_cveId" VARCHAR(255)   NULL DEFAULT '',
  "handle_id" VARCHAR(50)   NULL DEFAULT NULL,
  "status" INTEGER NULL DEFAULT NULL,
  "create_time" TIMESTAMP NULL DEFAULT NULL,
  "update_time" TIMESTAMP NULL DEFAULT NULL,
  "is_delete" SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_online_judge"."windowId" IS '归并告警字段';
COMMENT ON COLUMN "t_online_judge"."aggCondition" IS '归并告警查询字段';
COMMENT ON COLUMN "t_online_judge"."eventId" IS '归并告警字段';
COMMENT ON COLUMN "t_online_judge"."label" IS '事件类型';
COMMENT ON COLUMN "t_online_judge"."level" IS '事件等级';
COMMENT ON COLUMN "t_online_judge"."alarm_detail" IS '告警详情';
COMMENT ON COLUMN "t_online_judge"."report_type" IS '上报类型';
COMMENT ON COLUMN "t_online_judge"."report_reason" IS '上报原因';
COMMENT ON COLUMN "t_online_judge"."user_name" IS '上报人';
COMMENT ON COLUMN "t_online_judge"."phone" IS '手机号';
COMMENT ON COLUMN "t_online_judge"."alarm_json" IS '告警json';
COMMENT ON COLUMN "t_online_judge"."enclosure" IS '附件';
COMMENT ON COLUMN "t_online_judge"."handle_time" IS '处置时间';
COMMENT ON COLUMN "t_online_judge"."handle_type" IS '处置方案';
COMMENT ON COLUMN "t_online_judge"."handle_username" IS '处置人员名称';
COMMENT ON COLUMN "t_online_judge"."handle_keyword" IS '案件关键词';
COMMENT ON COLUMN "t_online_judge"."handle_name" IS '处置方案名称';
COMMENT ON COLUMN "t_online_judge"."handle_suggest" IS '处置建议';
COMMENT ON COLUMN "t_online_judge"."handle_classify" IS '漏洞类型';
COMMENT ON COLUMN "t_online_judge"."handle_cveId" IS 'cve编号';
COMMENT ON COLUMN "t_online_judge"."handle_id" IS '研判事件ID';
COMMENT ON COLUMN "t_online_judge"."status" IS '研判状态';
COMMENT ON COLUMN "t_online_judge"."is_delete" IS '是否删除(0:未删除,1:删除)';


DROP TABLE IF EXISTS "t_oplog";
CREATE TABLE "t_oplog"  (
  "id" BIGSERIAL,
  "username" VARCHAR(64)   NULL DEFAULT NULL,
  "module" VARCHAR(64)   NOT NULL,
  "op_type" VARCHAR(64)   NOT NULL,
  "optime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "op_result" BOOLEAN NULL DEFAULT NULL,
  "op_desc" text   NULL,
  "message" text   NULL,
  "ip" VARCHAR(32)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_oplog"."username" IS '操作用户名';
COMMENT ON COLUMN "t_oplog"."module" IS '操作模块';
COMMENT ON COLUMN "t_oplog"."op_type" IS '操作类型';
COMMENT ON COLUMN "t_oplog"."optime" IS '操作时间';
COMMENT ON COLUMN "t_oplog"."op_result" IS '操作成功与否,true/false或者是code错误码之类';
COMMENT ON COLUMN "t_oplog"."op_desc" IS '描述';
COMMENT ON COLUMN "t_oplog"."message" IS '消息(用于存放异常，警告，提醒等消息)';


DROP TABLE IF EXISTS "t_organization";
CREATE TABLE "t_organization"  (
  "id" BIGSERIAL,
  "orgName" VARCHAR(150)   NOT NULL,
  "abbreviation" VARCHAR(256)   NULL DEFAULT NULL,
  "orgId" VARCHAR(128)   NOT NULL,
  "parentOrgId" VARCHAR(128)   NOT NULL DEFAULT '',
  "orgIdentifier" VARCHAR(256)   NULL DEFAULT '',
  "orgAddress" VARCHAR(256)   NULL DEFAULT '',
  "orgArea" VARCHAR(256)   NULL DEFAULT '',
  "createtime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_organization" VALUES (1, '总部', NULL, '7effcbb7-0c7a-4da9-bde1-32d06166acae', '', '', '', '', '2026-01-13 10:37:40', '2026-01-13 10:37:40');

-- Indexes
CREATE UNIQUE INDEX "orgId" ON "t_organization" ("orgId");
CREATE INDEX "index_parentOrgId" ON "t_organization" ("parentOrgId");
CREATE INDEX "index_orgId" ON "t_organization" ("orgId");
CREATE INDEX "index_orgName" ON "t_organization" ("orgName");

-- Column comments
COMMENT ON COLUMN "t_organization"."orgName" IS '组织名称';
COMMENT ON COLUMN "t_organization"."abbreviation" IS '简称';
COMMENT ON COLUMN "t_organization"."orgId" IS '组织标识';
COMMENT ON COLUMN "t_organization"."parentOrgId" IS '父组织标识';
COMMENT ON COLUMN "t_organization"."orgIdentifier" IS '组织编号';
COMMENT ON COLUMN "t_organization"."orgAddress" IS '地址';
COMMENT ON COLUMN "t_organization"."orgArea" IS '地区';
COMMENT ON COLUMN "t_organization"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_organization"."updatetime" IS '修改时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_organization_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updatetime" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_organization_update_timestamp
BEFORE UPDATE ON "t_organization"
FOR EACH ROW
EXECUTE FUNCTION update_t_organization_timestamp();


DROP TABLE IF EXISTS "t_permission";
CREATE TABLE "t_permission"  (
  "id" VARCHAR(150)   NOT NULL,
  "code" VARCHAR(150)   NOT NULL,
  "name" VARCHAR(150)   NOT NULL,
  "parentid" VARCHAR(150)   NOT NULL DEFAULT 'root',
  "url" VARCHAR(1000)   NULL DEFAULT NULL,
  "sort" DOUBLE PRECISION NULL DEFAULT NULL,
  "createtime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "icon" VARCHAR(150)   NULL DEFAULT '',
  "module" SMALLINT NULL DEFAULT 0,
  "href" VARCHAR(1000)   NULL DEFAULT NULL,
  "authorization" INTEGER NULL DEFAULT 1,
  "permission_type" VARCHAR(16)   NOT NULL,
  "app_name" VARCHAR(100)   NOT NULL,
  "is_enable" BOOLEAN NOT NULL DEFAULT 1,
  "type" VARCHAR(32)   NOT NULL DEFAULT 'page',
  "description" text   NULL,
  "group" VARCHAR(1024)   NULL DEFAULT NULL,
  "special" VARCHAR(1024)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_permission" VALUES ('mirror:menu:EarlyWarn', 'EarlyWarn', 'EarlyWarn', 'root', NULL, NULL, '2026-01-13 10:37:44', '2026-01-13 10:37:44', '', 0, NULL, 1, 'menu', 'mirror', 1, 'page', NULL, NULL, NULL);,
  INSERT INTO "t_permission" VALUES ('mirror:menu:Kpi', 'Kpi', 'Kpi', 'root', NULL, NULL, '2026-01-13 10:37:44', '2026-01-13 10:37:44', '', 0, NULL, 1, 'menu', 'mirror', 1, 'page', NULL, NULL, NULL);,
  INSERT INTO "t_permission" VALUES ('mirror:menu:SubscriptionRule', 'SubscriptionRule', 'SubscriptionRule', 'root', NULL, NULL, '2026-01-13 10:37:44', '2026-01-13 10:37:44', '', 0, NULL, 1, 'menu', 'mirror', 1, 'page', NULL, NULL, NULL);,
  INSERT INTO "t_permission" VALUES ('mirror:menu:WorkOrder', 'WorkOrder', 'WorkOrder', 'root', NULL, NULL, '2026-01-13 10:37:44', '2026-01-13 10:37:44', '', 0, NULL, 1, 'menu', 'mirror', 1, 'page', NULL, NULL, NULL);,
  INSERT INTO "t_permission" VALUES ('mirror:menu:WorkTable', 'WorkTable', 'WorkTable', 'root', NULL, NULL, '2026-01-13 10:37:44', '2026-01-13 10:37:44', '', 0, NULL, 1, 'menu', 'mirror', 1, 'page', NULL, NULL, NULL);

-- Indexes
CREATE INDEX "t_permission_parentid_IDX" ON "t_permission" ("parentid");

-- Column comments
COMMENT ON COLUMN "t_permission"."code" IS '权限code';
COMMENT ON COLUMN "t_permission"."name" IS '名称';
COMMENT ON COLUMN "t_permission"."parentid" IS '上级id';
COMMENT ON COLUMN "t_permission"."url" IS '菜单为url';
COMMENT ON COLUMN "t_permission"."sort" IS '排序(从小到大)';
COMMENT ON COLUMN "t_permission"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_permission"."updatetime" IS '修改时间';
COMMENT ON COLUMN "t_permission"."icon" IS '图标';
COMMENT ON COLUMN "t_permission"."module" IS '模块';
COMMENT ON COLUMN "t_permission"."href" IS '跳转';
COMMENT ON COLUMN "t_permission"."authorization" IS '授权：默认全授权1，未授权0';
COMMENT ON COLUMN "t_permission"."permission_type" IS '权限类型，menu:菜单权限，operation:操作权限';
COMMENT ON COLUMN "t_permission"."app_name" IS '权限所属app名称';
COMMENT ON COLUMN "t_permission"."is_enable" IS '是否启用权限';
COMMENT ON COLUMN "t_permission"."type" IS 'page：菜单页面，iframe：嵌套页面，button：界面按钮';
COMMENT ON COLUMN "t_permission"."description" IS '描述';
COMMENT ON COLUMN "t_permission"."group" IS '业务分组，用于角色管理的权限联动';
COMMENT ON COLUMN "t_permission"."special" IS '特殊业务逻辑的类（spring管理）';


DROP TABLE IF EXISTS "t_portal_screen";
CREATE TABLE "t_portal_screen"  (
  "id" BIGSERIAL,
  "name" VARCHAR(100)   NULL DEFAULT NULL,
  "menu_id" VARCHAR(100)   NULL DEFAULT NULL,
  "menu_name" VARCHAR(100)   NULL DEFAULT NULL,
  "url" VARCHAR(255)   NULL DEFAULT NULL,
  "icon" VARCHAR(50)   NULL DEFAULT NULL,
  "outlink" BOOLEAN NULL DEFAULT NULL,
  "app" BOOLEAN NULL DEFAULT NULL,
  "app_tip" VARCHAR(100)   NULL DEFAULT NULL,
  "create_time" timestamp NULL DEFAULT NULL,
  "update_time" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_portal_screen" VALUES (1, '外部攻击态势', 'ExternalAttack', '外部攻击态势', '/externalAttack', 'state', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (2, '业务全景', 'BusinessEntry', '业务全景', '/business/entry', 'topo', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (3, '态势感知', 'Situation', '态势感知', '/monitor', 'link', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (4, '资产感知', 'Hosts', '资产感知', '/business/hosts', 'asset', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (5, '威胁狩猎', 'SherlockScreen', '威胁狩猎', '/sherlockScreen', 'hunt', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (6, '威胁情报', 'ThreatsSearch', '威胁情报', '/analysis/threats/search', 'paper', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (7, '通报预警', 'EarlyWarn', '通报预警', '/operation/workTable', 'alarm', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (8, '联动策略', 'LinkageStrategy', '联动策略', '/operation/linkageStrategy', 'link', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (9, 'UEBA', 'UserPortrait', 'UEBA', '/ueba/userPortrait', 'ueba', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (10, 'Ai异常检测', 'AI_analysis', 'Ai异常检测', '/pages/visualize/AI_analysis.html', 'operation', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (11, '运行监测', 'statusDetection', '运行监测', '/statusDetection', 'grade', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (12, '原始告警', 'AnalysisAlarms', '原始告警', '/analysis/alarms', 'alarm', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (13, '资产管理', 'AssetManage', '资产管理', '/assets/manage', 'asset', 0, 1, '', '2026-01-13 10:37:41', NULL);,
  INSERT INTO "t_portal_screen" VALUES (14, '安全态势', 'SecuritySituation', '安全态势', '/securitySituation', 'link', 0, 1, '', '2026-01-13 10:37:41', NULL);

DROP TABLE IF EXISTS "t_predict_alert_report";
CREATE TABLE "t_predict_alert_report"  (
  "id" SERIAL,
  "serial_id" CHAR(14)   NOT NULL,
  "subject" VARCHAR(255)   NOT NULL,
  "tags" text   NULL,
  "level" enum('0','1','2')   NULL DEFAULT NULL,
  "security_object" VARCHAR(255)   NULL DEFAULT NULL,
  "security_detail" text   NULL,
  "security_detail_text" text   NULL,
  "security_info" text   NULL,
  "author" VARCHAR(255)   NOT NULL,
  "author_id" VARCHAR(255)   NOT NULL,
  "type" enum('0','1')   NOT NULL DEFAULT '0',
  "publisher" VARCHAR(255)   NULL DEFAULT NULL,
  "publisher_id" VARCHAR(255)   NULL DEFAULT NULL,
  "report_created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "report_status" enum('0','1')   NOT NULL DEFAULT '0',
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "attach_files" text   NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_predict_alert_report"."id" IS '表的自增序列';
COMMENT ON COLUMN "t_predict_alert_report"."serial_id" IS '通报预警编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';
COMMENT ON COLUMN "t_predict_alert_report"."subject" IS '预警通报主题';
COMMENT ON COLUMN "t_predict_alert_report"."tags" IS '标签名称, 逗号分隔';
COMMENT ON COLUMN "t_predict_alert_report"."level" IS '预警通报级别, 紧急:0, 警告:1, 一般:2';
COMMENT ON COLUMN "t_predict_alert_report"."security_object" IS '安全对象, 如: IP, 主机名, 服务器, 部门等';
COMMENT ON COLUMN "t_predict_alert_report"."security_detail" IS '安全的详细描述';
COMMENT ON COLUMN "t_predict_alert_report"."security_detail_text" IS '安全的详细描述';
COMMENT ON COLUMN "t_predict_alert_report"."security_info" IS '安全的举证信息: 告警事件ID, 资产IP, 域名/URL, 攻击IP';
COMMENT ON COLUMN "t_predict_alert_report"."author" IS '预警创建人';
COMMENT ON COLUMN "t_predict_alert_report"."author_id" IS '预警创建人在t_user表中的id';
COMMENT ON COLUMN "t_predict_alert_report"."type" IS '记录所属类别:预警 0, 通报 1';
COMMENT ON COLUMN "t_predict_alert_report"."publisher" IS '通报发布人';
COMMENT ON COLUMN "t_predict_alert_report"."publisher_id" IS '通报发布人在t_user表中的id';
COMMENT ON COLUMN "t_predict_alert_report"."report_created_at" IS '通报创建时间';
COMMENT ON COLUMN "t_predict_alert_report"."report_status" IS '通报是否被关闭: 0未关闭, 1关闭';
COMMENT ON COLUMN "t_predict_alert_report"."created_at" IS '记录创建时间';
COMMENT ON COLUMN "t_predict_alert_report"."updated_at" IS '记录更新时间';
COMMENT ON COLUMN "t_predict_alert_report"."attach_files" IS '工单附件';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_predict_alert_report_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updated_at" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_predict_alert_report_update_timestamp
BEFORE UPDATE ON "t_predict_alert_report"
FOR EACH ROW
EXECUTE FUNCTION update_t_predict_alert_report_timestamp();


DROP TABLE IF EXISTS "t_predict_alert_report_operation_history";
CREATE TABLE "t_predict_alert_report_operation_history"  (
  "id" SERIAL,
  "serial_id" CHAR(14)   NOT NULL,
  "operater" VARCHAR(255)   NOT NULL,
  "operater_host_address" VARCHAR(255)   NOT NULL,
  "operater_operations" text   NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_predict_alert_report_operation_history"."id" IS '表自增序列';
COMMENT ON COLUMN "t_predict_alert_report_operation_history"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';
COMMENT ON COLUMN "t_predict_alert_report_operation_history"."operater" IS '预警通报修改人';
COMMENT ON COLUMN "t_predict_alert_report_operation_history"."operater_host_address" IS '预警通报修改人的主机地址';
COMMENT ON COLUMN "t_predict_alert_report_operation_history"."operater_operations" IS '预警通报修改人的操作';
COMMENT ON COLUMN "t_predict_alert_report_operation_history"."created_at" IS '记录创建时间';


DROP TABLE IF EXISTS "t_predict_alert_report_tags_relation";
CREATE TABLE "t_predict_alert_report_tags_relation"  (
  "id" SERIAL,
  "name" VARCHAR(255)   NOT NULL,
  "serial_id" CHAR(14)   NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_predict_alert_report_tags_relation"."id" IS '自增主键';
COMMENT ON COLUMN "t_predict_alert_report_tags_relation"."name" IS 'tag 的名字';
COMMENT ON COLUMN "t_predict_alert_report_tags_relation"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';
COMMENT ON COLUMN "t_predict_alert_report_tags_relation"."created_at" IS '记录创建时间';
COMMENT ON COLUMN "t_predict_alert_report_tags_relation"."updated_at" IS '记录更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_predict_alert_report_tags_relation_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updated_at" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_predict_alert_report_tags_relation_update_timestamp
BEFORE UPDATE ON "t_predict_alert_report_tags_relation"
FOR EACH ROW
EXECUTE FUNCTION update_t_predict_alert_report_tags_relation_timestamp();


DROP TABLE IF EXISTS "t_quartz_job";
CREATE TABLE "t_quartz_job"  (
  "id" SERIAL,
  "name" VARCHAR(128)   NULL DEFAULT NULL,
  "bean_name" VARCHAR(255)   NOT NULL,
  "job_name" VARCHAR(255)   NULL DEFAULT NULL,
  "job_group" VARCHAR(128)   NULL DEFAULT NULL,
  "trigger_name" VARCHAR(255)   NULL DEFAULT NULL,
  "trigger_group" VARCHAR(128)   NULL DEFAULT NULL,
  "trigger_type" VARCHAR(2)   NULL DEFAULT NULL,
  "cron_expression" VARCHAR(64)   NULL DEFAULT NULL,
  "simple_trigger_interval" INTEGER NULL DEFAULT NULL,
  "simple_trigger_count" INTEGER NULL DEFAULT NULL,
  "delay" INTEGER NULL DEFAULT NULL,
  "type" VARCHAR(2)   NULL DEFAULT '03',
  "job_status" VARCHAR(2)   NULL DEFAULT NULL,
  "description" VARCHAR(1024)   NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "last_run_time" timestamp NULL DEFAULT NULL,
  "start_up" VARCHAR(2)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_quartz_job" VALUES (2, '信誉度数据获取任务', 'com.dbapp.intel.schedule.ReputationTask$Task1', 'com.dbapp.intel.schedule.ReputationTask$Task1', 'ReputationTask', 'com.dbapp.intel.schedule.ReputationTask$Task1', 'ReputationTask', '00', '1 0 0 * * ? ', NULL, NULL, 0, '01', '00', '定时获取待计算信誉度数据，为了补齐数据', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (3, '信誉度计算任务', 'com.dbapp.intel.schedule.ReputationTask$Task2', 'com.dbapp.intel.schedule.ReputationTask$Task2', 'ReputationTask', 'com.dbapp.intel.schedule.ReputationTask$Task2', 'ReputationTask', '00', '0 1 * * * ?', NULL, NULL, 0, '01', '00', '根据已预先获取的数据，定时计算信誉度', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (4, '资产相似性计算', 'com.dbapp.cpsysportal.assetSimilarity.AssetSimilarityCache$Task', 'com.dbapp.cpsysportal.assetSimilarity.AssetSimilarityCache$Task', 'AssetSimilarityCache', 'com.dbapp.cpsysportal.assetSimilarity.AssetSimilarityCache$Task', 'AssetSimilarityCache', '00', '0 0 2 * * ?', NULL, NULL, 0, '02', '00', '计算资产相似性', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (6, 'UEBA统计任务', 'com.dbapp.ueba.task.UebaTask', 'com.dbapp.ueba.task.UebaTask', 'UebaTask', 'com.dbapp.ueba.task.UebaTask', 'UebaTask', '00', '0 0 0 * * ? ', NULL, NULL, 0, '02', '00', '每日0时0分0秒执行前一天UEBA统计任务', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (7, 'UEBA统计任务', 'com.dbapp.ueba.task.UebaTask$UebaStats', 'com.dbapp.ueba.task.UebaTask$UebaStats', 'UebaTask', 'com.dbapp.ueba.task.UebaTask$UebaStats', 'UebaTask', '01', NULL, 600, NULL, 180, '01', '00', '定时执行UEBA统计任务', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (14, '重大保障所处阶段更新定时任务', 'com.dbapp.majorSafeguard.task.MajorSafeguardTask', 'com.dbapp.majorSafeguard.task.MajorSafeguardTask', 'MajorSafeguardTask', 'com.dbapp.majorSafeguard.task.MajorSafeguardTask', 'MajorSafeguardTask', '00', '0 0 0 * * ? ', NULL, NULL, 0, '02', '00', '每日更新重大保障所处的保障阶段', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (15, '安全告警数据监控', 'com.dbapp.alert.task.SecurityAlarmMonitorSchedule$ScanSecurityAlarm', 'com.dbapp.alert.task.SecurityAlarmMonitorSchedule$ScanSecurityAlarm', 'SecurityAlarmMonitorSchedule', 'com.dbapp.alert.task.SecurityAlarmMonitorSchedule$ScanSecurityAlarm', 'SecurityAlarmMonitorSchedule', '01', NULL, 10, NULL, 0, '00', '00', '定时读取kafka中的告警信息, 并聚合在内存中', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (16, '安全告警数据监控', 'com.dbapp.alert.task.SecurityAlarmMonitorSchedule$SendAlert', 'com.dbapp.alert.task.SecurityAlarmMonitorSchedule$SendAlert', 'SecurityAlarmMonitorSchedule', 'com.dbapp.alert.task.SecurityAlarmMonitorSchedule$SendAlert', 'SecurityAlarmMonitorSchedule', '01', NULL, 600, NULL, 1, '00', '00', '定时清理聚合在内存中的告警信息', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (17, '构建绩效考核上周数据', 'com.dbapp.alert.task.KpiDataStatisticSchedule$KpiWeekTask', 'com.dbapp.alert.task.KpiDataStatisticSchedule$KpiWeekTask', 'KpiDataStatisticSchedule', 'com.dbapp.alert.task.KpiDataStatisticSchedule$KpiWeekTask', 'KpiDataStatisticSchedule', '00', '0 0 0 ? * MON', NULL, NULL, 0, '00', '00', '构建绩效考核上周数据', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (18, '构建绩效考核上月数据', 'com.dbapp.alert.task.KpiDataStatisticSchedule$KpiMonthTask', 'com.dbapp.alert.task.KpiDataStatisticSchedule$KpiMonthTask', 'KpiDataStatisticSchedule', 'com.dbapp.alert.task.KpiDataStatisticSchedule$KpiMonthTask', 'KpiDataStatisticSchedule', '00', '0 0 1 1 * ?', NULL, NULL, 0, '00', '00', '构建绩效考核上月数据', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (19, 'sherlock大屏展示统计日志访问TOP800数据', 'com.dbapp.sherlock.schedule.TopologyScheduler', 'com.dbapp.sherlock.schedule.TopologyScheduler', 'TopologyScheduler', 'com.dbapp.sherlock.schedule.TopologyScheduler', 'TopologyScheduler', '00', '0 0 */6 * * ?', NULL, NULL, 0, '02', '00', '统计日志src-destTOP800数据', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (21, '资产漏洞数统计', 'com.dbapp.assetmanagement.task.AssetCalTask$UpdateCalTask', 'com.dbapp.assetmanagement.task.AssetCalTask$UpdateCalTask', 'AssetCalTask', 'com.dbapp.assetmanagement.task.AssetCalTask$UpdateCalTask', 'AssetCalTask', '00', '0 0 */1 * * ?', NULL, NULL, 0, '01', '00', '从弱点数据中统计资产漏洞数，入mysql', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (23, 'IP相似度', 'com.dbapp.cpsysportal.SimilarModel.schedule.IpSimilarTask1_3', 'com.dbapp.cpsysportal.SimilarModel.schedule.IpSimilarTask1_3', 'IpSimilarTask1_3', 'com.dbapp.cpsysportal.SimilarModel.schedule.IpSimilarTask1_3', 'IpSimilarTask1_3', '00', '0 0 2 * * ?', NULL, NULL, 0, '02', '00', '计算攻击者IP相似度', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (31, '日志量监控', 'com.dbapp.assetmanagement.task.LogMonitorTask$Task', 'com.dbapp.assetmanagement.task.LogMonitorTask$Task', 'taskLogMonitorTask', 'com.dbapp.assetmanagement.task.LogMonitorTask$Task', 'taskLogMonitorTask', '00', '0 0/10 * * * ?', NULL, NULL, 0, '02', '00', '根据日志查看资产日志量入mysql，界面显示', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (32, 'soc资产同步', 'com.dbapp.assetmanagement.task.AssetSOCSyncTask', 'com.dbapp.assetmanagement.task.AssetSOCSyncTask', 'taskAssetSOCSyncTask', 'com.dbapp.assetmanagement.task.AssetSOCSyncTask', 'taskAssetSOCSyncTask', '00', '0 0 1 * * ?', NULL, NULL, 0, '03', '00', '根据SOC API同步资产', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (35, '流量监控', 'com.dbapp.assetmanagement.task.NetrafficTask$Task', 'com.dbapp.assetmanagement.task.NetrafficTask$Task', 'NetrafficTask', 'com.dbapp.assetmanagement.task.NetrafficTask$Task', 'NetrafficTask', '00', '0 0/10 * * * ?', NULL, NULL, 0, '02', '00', '根据日志查看资产流量入mysql，界面显示', '2026-01-13 10:37:41', '2026-01-13 10:37:41', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (36, 'waf联动策略取消', 'com.dbapp.linkage.task.LinkageStrategyTask', 'com.dbapp.linkage.task.LinkageStrategyTask', 'LinkageStrategyTask', 'com.dbapp.linkage.task.LinkageStrategyTask', 'LinkageStrategyTask', '00', '0 */1 * * * ?', NULL, NULL, 0, '00', '00', '剧本编排设置了联动策略定时时长，到时自动取消waf阻断', '2026-01-13 10:37:42', '2026-01-13 10:37:42', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (39, '模型编排定时发送通报预警', 'com.dbapp.soar.task.SoarLinkageConsumer', 'com.dbapp.soar.task.SoarLinkageConsumer', 'SoarLinkageConsumer', 'com.dbapp.soar.task.SoarLinkageConsumer', 'SoarLinkageConsumer', '00', '0 0/10 * * * ?', NULL, NULL, 0, '00', '00', '定时清理聚合在内存中的告警信息, 模型编排定时发送通报预警', '2026-01-13 10:37:43', '2026-01-13 10:37:43', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (40, '剧本编排拉取告警数据', 'com.dbapp.soar.task.SoarAlarmConsumer', 'com.dbapp.soar.task.SoarAlarmConsumer', 'SoarAlarmConsumer', 'com.dbapp.soar.task.SoarAlarmConsumer', 'SoarAlarmConsumer', '01', NULL, 10, 0, 0, '00', '00', '剧本编排拉取告警数据，生成任务', '2026-01-13 10:37:43', '2026-01-13 10:37:43', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (41, '安全事件拉取任务', 'com.dbapp.securityIncident.task.center.IncidentCenter$RetrievalTemplateIncidentTask', 'com.dbapp.securityIncident.task.center.IncidentCenter$RetrievalTemplateIncidentTask', 'IncidentCenter', 'com.dbapp.securityIncident.task.center.IncidentCenter$RetrievalTemplateIncidentTask', 'IncidentCenter', '00', '0 58 * * * ? ', NULL, NULL, 0, '02', '00', '后台轮询拉取安全事件模板任务，每小时的58-60分为处理时间不建议增删改模板', '2026-01-13 10:37:43', '2026-01-13 10:37:43', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (42, '产品上线数据收集任务', 'com.dbapp.scada.task.DataAcquisitionTask', 'com.dbapp.scada.task.DataAcquisitionTask', 'DataAcquisitionTask', 'com.dbapp.scada.task.DataAcquisitionTask', 'DataAcquisitionTask', '00', '0 0 1 * * ? ', NULL, NULL, 0, '02', '00', '每日定时收集系统上线数据', '2026-01-13 10:37:44', '2026-01-13 10:37:44', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (43, '归并告警归档任务', 'com.dbapp.merge.task.ArchiveMergeAlarmTask', 'com.dbapp.merge.task.ArchiveMergeAlarmTask', 'ArchiveMergeAlarmTask', 'com.dbapp.merge.task.ArchiveMergeAlarmTask', 'ArchiveMergeAlarmTask', '00', '0 20 0 * * ?', NULL, NULL, 0, '02', '00', '归并告警归档，写入历史表', '2026-01-13 10:37:45', '2026-01-13 10:37:45', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (44, '统一分析检查沙箱结果任务', 'com.dbapp.xdr.task.CheckAptResultTask', 'com.dbapp.xdr.task.CheckAptResultTask', 'CheckAptResultTask', 'com.dbapp.xdr.task.CheckAptResultTask', 'CheckAptResultTask', '00', '0 0/1 * * * ?', NULL, 0, 0, '01', '02', '根据沙箱结果，写入文件上传列表', '2026-01-13 10:37:45', '2026-01-13 10:37:45', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (45, '统一设备状态检测', 'com.dbapp.xdr.task.AgentStatusDetectTask', 'com.dbapp.xdr.task.AgentStatusDetectTask', 'AgentStatusDetectTask', 'com.dbapp.xdr.task.AgentStatusDetectTask', 'AgentStatusDetectTask', '01', NULL, 60, 0, 300, '01', '02', '检测设备在线状态，升级超时状态', '2026-01-13 10:37:45', '2026-01-13 10:37:45', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (46, '统一设备在线同步升级包', 'com.dbapp.xdr.task.GetUpgradePackageTask', 'com.dbapp.xdr.task.GetUpgradePackageTask', 'GetUpgradePackageTask', 'com.dbapp.xdr.task.GetUpgradePackageTask', 'GetUpgradePackageTask', '00', '0 0 3 * * ?', NULL, 0, 0, '01', '02', '每天凌晨3点从云端同步最新的探针升级包', '2026-01-13 10:37:45', '2026-01-13 10:37:45', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (47, 'DASCA设备状态同步任务', 'com.dbapp.dasca.task.DeviceStatusSyncTask$Task', 'com.dbapp.dasca.task.DeviceStatusSyncTask$Task', 'DeviceStatusSyncTask', 'com.dbapp.dasca.task.DeviceStatusSyncTask$Task', 'DeviceStatusSyncTask', '00', '0 0/10 * * * ? ', NULL, NULL, 0, '02', '00', '联动设备-状态更新,每隔10分钟进行', '2026-01-13 10:37:45', '2026-01-13 10:37:45', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (48, 'EDR资产同步任务', 'com.dbapp.linkDevie.task.ScanStrategyResultTask$Task', 'com.dbapp.linkDevie.task.ScanStrategyResultTask$Task', 'ScanStrategyResultTask', 'com.dbapp.linkDevie.task.ScanStrategyResultTask$Task', 'ScanStrategyResultTask', '00', '0 0/10 * * * ? ', NULL, NULL, 0, '02', '00', 'EDR扫描任务-状态和结果更新,每隔10分钟进行', '2026-01-13 10:37:45', '2026-01-13 10:37:45', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (49, '系统消息配置监控', 'com.dbapp.xdr.task.SystemConfigMonitorTask', 'com.dbapp.xdr.task.SystemConfigMonitorTask', 'SystemConfigMonitorTask', 'com.dbapp.xdr.task.SystemConfigMonitorTask', 'SystemConfigMonitorTask', '00', '0 0 10 * * ? ', NULL, NULL, 0, '02', '00', '系统配置监控每天早上10点', '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (50, '许可过期监控任务', 'com.dbapp.xdr.task.CheckLicenseExpiredTask', 'com.dbapp.xdr.task.CheckLicenseExpiredTask', 'CheckLicenseExpiredTask', 'com.dbapp.xdr.task.CheckLicenseExpiredTask', 'CheckLicenseExpiredTask', '00', '0 0/10 * * * ? ', NULL, NULL, 0, '02', '00', 'license过期每10分钟发送一次消息', '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (51, '系统消息入库任务', 'com.dbapp.message.listener.MessageListener', 'com.dbapp.message.listener.MessageListener', 'MessageListener', 'com.dbapp.message.listener.MessageListener', 'MessageListener', '00', '0/10 * * * * ? ', NULL, NULL, 0, '02', '00', '10秒拉一次数据', '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (52, '安恒威胁情报中心定时同步任务', 'com.dbapp.intelligence.task.ThreatIntelligenceTask$ThreatIntelligenceCentreTask', 'com.dbapp.intelligence.task.ThreatIntelligenceTask$ThreatIntelligenceCentreTask', 'ThreatIntelligenceCentreTask', 'com.dbapp.intelligence.task.ThreatIntelligenceTask$ThreatIntelligenceCentreTask', 'ThreatIntelligenceCentreTask', '00', '0 0 2 * * ?', NULL, NULL, 0, '02', '00', '安恒威胁情报中心定时同步任务，增量更新情报信息', '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (53, '威胁情报内置情报文件导入任务', 'com.dbapp.intelligence.task.ThreatIntelligenceTask$ThreatIntelligenceBuildInTask', 'com.dbapp.intelligence.task.ThreatIntelligenceTask$ThreatIntelligenceBuildInTask', 'ThreatIntelligenceBuildInTask', 'com.dbapp.intelligence.task.ThreatIntelligenceTask$ThreatIntelligenceBuildInTask', 'ThreatIntelligenceBuildInTask', '01', NULL, 1000000, 0, 10, '02', '00', '威胁情报内置情报文件导入任务，仅启动时执行一次，成功后不再继续', '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (54, '每半小时产品上线数据收集任务', 'com.dbapp.scada.task.HalfOfHourDataAcquisitionTask', 'com.dbapp.scada.task.HalfOfHourDataAcquisitionTask', 'HalfOfHourDataAcquisitionTask', 'com.dbapp.scada.task.HalfOfHourDataAcquisitionTask', 'HalfOfHourDataAcquisitionTask', '00', '0 0/30 * * * ?', NULL, NULL, 0, '02', '00', '每半小时收集系统上线数据', '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (55, '每日23时产品上线数据收集任务', 'com.dbapp.scada.task.TTDataAcquisitionTask', 'com.dbapp.scada.task.TTDataAcquisitionTask', 'TTDataAcquisitionTask', 'com.dbapp.scada.task.TTDataAcquisitionTask', 'TTDataAcquisitionTask', '00', '0 0 23 * * ? ', NULL, NULL, 0, '02', '00', '每日23时定时收集系统上线数据', '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (57, '云端研判', 'com.dbapp.judge.task.OnlineJudgeTask', 'com.dbapp.judge.task.OnlineJudgeTask', 'OnlineJudgeTask', 'com.dbapp.judge.task.OnlineJudgeTask', 'OnlineJudgeTask', '01', NULL, 600, 0, 50, '01', '02', '全部待研判的记录更新研判状态', '2022-03-02 19:25:31', '2022-03-09 14:02:29', '2022-03-14 14:32:04', '01');,
  INSERT INTO "t_quartz_job" VALUES (58, '云端研判周数据重置', 'com.dbapp.judge.task.OnlineJudgeWeekTask', 'com.dbapp.judge.task.OnlineJudgeWeekTask', 'OnlineJudgeWeekTask', 'com.dbapp.judge.task.OnlineJudgeWeekTask', 'OnlineJudgeWeekTask', '00', '0 0 0 ? * MON', NULL, NULL, 0, '02', '02', '云端研判数据重置周数据', '2022-03-10 13:26:21', '2022-03-10 13:26:21', '2022-03-14 09:02:30', '01');,
  INSERT INTO "t_quartz_job" VALUES (59, '资产攻击面统计', 'com.dbapp.assetmanagement.task.AssetAttackSurfaceTask$Task', 'com.dbapp.assetmanagement.task.AssetAttackSurfaceTask$Task', 'AssetAttackSurfaceTask', 'com.dbapp.assetmanagement.task.AssetAttackSurfaceTask', '.AssetAttackSurfaceTask', '01', NULL, 600, NULL, 1, '01', '02', '根据原始日志和原始告警数据对资产的暴露和受攻击情况进行统计', '2026-01-13 10:37:47', '2026-01-13 10:37:47', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (60, '资产评估（资产评级与风险值计算）定时任务', 'com.dbapp.cpsysportal.task.AlarmCenterTask$AssetEvaluationTask', 'com.dbapp.cpsysportal.task.AlarmCenterTask$AssetEvaluationTask', 'AlarmCenterTask', 'com.dbapp.cpsysportal.task.AlarmCenterTask$AssetEvaluationTask', 'AlarmCenterTask', '01', NULL, 600, NULL, 1, '03', '00', '根据本日告警列表的告警数据，采用内置预定义的规则与计算公式对资产进行评级，计算资产风险值，统计各资产告警数，获取资产最近告警时间', '2026-01-13 10:37:47', '2026-01-13 10:37:47', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (61, '健康检查', 'com.dbapp.patrol.task.PatrolTask', 'com.dbapp.patrol.task.PatrolTask', 'PatrolTask', 'com.dbapp.patrol.task.PatrolTask', 'PatrolTask', '00', '0 0 2 ? * SUN', NULL, NULL, 0, '01', '02', '每周日凌晨2点进行一次健康检查，触发一键巡检', '2026-01-13 10:37:48', '2026-01-13 10:37:48', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (62, '智能告警研判', 'com.dbapp.scada.task.AlarmJudgeTask', 'com.dbapp.scada.task.AlarmJudgeTask', 'AlarmJudge', 'com.dbapp.scada.task.AlarmJudgeTask', 'AlarmJudge', '00', '0 0/30 * * * ?', 60, NULL, 0, '01', '02', '定时查询聚合告警表当天的数据，并对数据逐条进行判断是否符合告警要求', '2025-02-26 11:20:31', '2025-02-26 11:20:31', '2025-02-27 15:06:10', '01');,
  INSERT INTO "t_quartz_job" VALUES (63, '攻击者标签统计', 'com.dbapp.attackertags.task.AttackerTagsTask', 'com.dbapp.attackertags.task.AttackerTagsTask', 'AttackerTagsTask', 'com.dbapp.attackertags.task.AttackerTagsTask', 'AttackerTagsTask', '00', '0 */5 * * * ?', NULL, NULL, 0, '01', '02', '每5分钟从ES异常记录中统计攻击者标签数据写入ClickHouse', '2026-01-13 10:37:48', '2026-01-13 10:37:48', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (64, '上报用设备基础信息到MSS任务', 'com.dbapp.xdr.task.DeviceHeartbeatReportTask', 'com.dbapp.xdr.task.DeviceHeartbeatReportTask', 'DeviceHeartbeatReportTask', 'com.dbapp.xdr.task.DeviceHeartbeatReportTask', 'DeviceHeartbeatReportTask', '00', '0 0 0 * * ?', NULL, NULL, 0, '03', '00', '每天零点定时向MSS上报用设备基础信息', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (65, 'MDR是否过期检查任务', 'com.dbapp.xdr.task.MdrExpirationCheckTask', 'com.dbapp.xdr.task.MdrExpirationCheckTask', 'MdrExpirationCheckTask', 'com.dbapp.xdr.task.MdrExpirationCheckTask', 'MdrExpirationCheckTask', '00', '0 */5 * * * ?', NULL, NULL, 0, '03', '00', '每5分钟检查一下MDR是否过期', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (66, 'EDR系统漏洞信息获取', 'com.dbapp.assetmanagement.task.SystemVulnSyncTask$Task', 'com.dbapp.assetmanagement.task.SystemVulnSyncTask$Task', 'SystemVulnSyncTask', 'com.dbapp.assetmanagement.task.SystemVulnSyncTask$Task', 'SystemVulnSyncTask', '00', '0 0 */1 * * ?', NULL, NULL, 0, '01', '02', '后台轮询拉取EDR Windows补丁或Linux系统漏洞，默认每一小时拉取一次', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (67, 'EDR病毒木马获取', 'com.dbapp.assetmanagement.task.VirusSyncTask$Task', 'com.dbapp.assetmanagement.task.VirusSyncTask$Task', 'VirusSyncTask', 'com.dbapp.assetmanagement.task.VirusSyncTask$Task', 'VirusSyncTask', '00', '2 0 */1 * * ?', NULL, NULL, 0, '01', '02', '后台轮询拉取EDR病毒木马，默认每一小时拉取一次', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (68, '更新MSS服务有效时间任务', 'com.dbapp.xdr.task.UpdateMssServiceTimeTask', 'com.dbapp.xdr.task.UpdateMssServiceTimeTask', 'UpdateMssServiceTimeTask', 'com.dbapp.xdr.task.UpdateMssServiceTimeTask', 'UpdateMssServiceTimeTask', '00', '0 0 0 ? * MON', NULL, NULL, 0, '03', '00', '每周定时更新一次MSS服务有效时间', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (69, '恒脑服务监控', 'com.dbapp.hengnao.task.HengNaoMonitorTask', 'com.dbapp.hengnao.task.HengNaoMonitorTask', 'HengNaoMonitorTask', 'com.dbapp.hengnao.task.HengNaoMonitorTask', 'HengNaoMonitorTask', '00', '0 0 */1 * * ?', NULL, NULL, 0, '01', '02', '每小时一次对恒脑服务过期与token剩余情况进行监控', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (70, '原始日志EPS超限监测', 'com.dbapp.baas.task.MonitorOriginalLogEpsTask', 'com.dbapp.baas.task.MonitorOriginalLogEpsTasksk', 'MonitorOriginalLogEpsTask', 'com.dbapp.baas.task.MonitorOriginalLogEpsTask', 'MonitorOriginalLogEpsTask', '00', '0 0 */2 * * ?', NULL, NULL, 0, '01', '02', '每2小时执行一次对原始日志EPS超限监测', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (71, '智能告警研判补偿', 'com.dbapp.scada.task.AlarmJudgeCompensateTask', 'com.dbapp.scada.task.AlarmJudgeCompensateTask', 'AlarmJudgeCompensateTask', 'com.dbapp.scada.task.AlarmJudgeCompensateTask', 'AlarmJudgeCompensateTask', '00', '0 45 0 * * ?', NULL, NULL, 0, '01', '02', '定时补偿查询聚合告警表延迟的昨天数据，并对数据逐条进行判断是否符合告警要求', '2026-01-13 10:37:50', '2026-01-13 10:37:50', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (72, '归并告警清理历史记录', 'com.dbapp.xdr.task.AlarmDataCleanTimeTask', 'com.dbapp.xdr.task.AlarmDataCleanTimeTask', 'AlarmDataCleanTimeTask', 'com.dbapp.xdr.task.AlarmDataCleanTimeTask', 'AlarmDataCleanTimeTask', '00', '25 2 2 * * ?', NULL, NULL, 0, '01', '02', '每天凌晨对归并告警的历史数据进行清理', '2026-01-13 10:37:50', '2026-01-13 10:37:50', NULL, '01');,
  INSERT INTO "t_quartz_job" VALUES (73, '向ATIP推送IP、域名情报', 'com.dbapp.xdr.task.ATIPSyncTask', 'com.dbapp.xdr.task.ATIPSyncTask', 'ATIPSyncTask', 'com.dbapp.xdr.task.ATIPSyncTask', 'ATIPSyncTask', '00', '0 0 3 * * ?', NULL, NULL, 0, '01', '02', '向安恒ATIP威胁情报平台推送IP、域名情报', '2026-01-13 10:37:50', '2026-01-13 10:37:50', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (74, '堡垒机审阅智能体日志分析', 'com.dbapp.agent.task.ReviewAgentAnalysisTask', 'com.dbapp.agent.task.ReviewAgentAnalysisTask', 'ReviewAgentAnalysisTask', 'com.dbapp.agent.task.ReviewAgentAnalysisTask', 'ReviewAgentAnalysisTask', '00', '0 */5 * * * ?', NULL, NULL, 0, '01', '00', '向审阅智能体推送数据，并将智能体的分析结果写入到rawevent中', '2026-01-13 10:37:50', '2026-01-13 10:37:50', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (75, '堡垒机探测智能体日志分析', 'com.dbapp.agent.task.DetectionAgentAnalysisTask', 'com.dbapp.agent.task.DetectionAgentAnalysisTask', 'DetectionAgentAnalysisTask', 'com.dbapp.agent.task.DetectionAgentAnalysisTask', 'DetectionAgentAnalysisTask', '00', '0 */15 * * * ?', NULL, NULL, 0, '01', '00', '向探测智能体推送数据，并将智能体的分析结果写入到rawevent中', '2026-01-13 10:37:50', '2026-01-13 10:37:50', NULL, '00');,
  INSERT INTO "t_quartz_job" VALUES (76, '威胁场景统计数据缓存任务', 'com.dbapp.scenes.task.SceneStatsCacheTask', 'com.dbapp.scenes.task.SceneStatsCacheTask', 'SceneStatsCacheTask', 'com.dbapp.scenes.task.SceneStatsCacheTask', 'SceneStatsCacheTask', '00', '0 */5 * * * ?', NULL, NULL, 0, '01', '02', '威胁场景首页统计数据默认每5分钟缓存一次', '2026-01-13 10:37:50', '2026-01-13 10:37:50', NULL, '01');

-- Column comments
COMMENT ON COLUMN "t_quartz_job"."id" IS '主键';
COMMENT ON COLUMN "t_quartz_job"."name" IS '任务名称';
COMMENT ON COLUMN "t_quartz_job"."bean_name" IS '包名+类名';
COMMENT ON COLUMN "t_quartz_job"."job_name" IS '任务名';
COMMENT ON COLUMN "t_quartz_job"."job_group" IS '任务组';
COMMENT ON COLUMN "t_quartz_job"."trigger_name" IS '触发器名称';
COMMENT ON COLUMN "t_quartz_job"."trigger_group" IS '触发器组';
COMMENT ON COLUMN "t_quartz_job"."trigger_type" IS '触发器类型，00代表cronTrigger，01代表simpleTrigger';
COMMENT ON COLUMN "t_quartz_job"."cron_expression" IS 'cron表达式';
COMMENT ON COLUMN "t_quartz_job"."simple_trigger_interval" IS '间隔时间，单位秒';
COMMENT ON COLUMN "t_quartz_job"."simple_trigger_count" IS '运行次数';
COMMENT ON COLUMN "t_quartz_job"."delay" IS '延时，单位秒';
COMMENT ON COLUMN "t_quartz_job"."type" IS '类型，00不可以编辑，可以启动停止; 01可以编辑，可以启动停止; 02不可以编辑，不可以启动停止;03可以编辑，不可以启动停止';
COMMENT ON COLUMN "t_quartz_job"."job_status" IS '任务状态,	00代表停止状态，01代表暂停状态，02代表运行状态';
COMMENT ON COLUMN "t_quartz_job"."description" IS '任务描述';
COMMENT ON COLUMN "t_quartz_job"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_quartz_job"."last_run_time" IS '上次运行时间';
COMMENT ON COLUMN "t_quartz_job"."start_up" IS '是否随项目启动,00代表否，01代表是';


DROP TABLE IF EXISTS "t_query_scene";
CREATE TABLE "t_query_scene"  (
  "id" VARCHAR(50)   NOT NULL,
  "user_id" BIGINT NULL DEFAULT NULL,
  "scene_name" VARCHAR(50)   NULL DEFAULT NULL,
  "source" VARCHAR(50)   NULL DEFAULT 'custom',
  "datasource" VARCHAR(100)   NULL DEFAULT 'merge_alarms',
  "query_str" text   NULL,
  "query_str_user_hash" INTEGER NULL DEFAULT NULL,
  "sort_num" INTEGER NOT NULL,
  "is_top" BOOLEAN NULL DEFAULT 0,
  "create_time" TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE INDEX "hash_key" ON "t_query_scene" ("query_str_user_hash");

-- Column comments
COMMENT ON COLUMN "t_query_scene"."user_id" IS '用户id';
COMMENT ON COLUMN "t_query_scene"."scene_name" IS '场景名称';
COMMENT ON COLUMN "t_query_scene"."source" IS '场景来源，build-in：内置；custom：自定义；other：其他。默认为自定义';
COMMENT ON COLUMN "t_query_scene"."datasource" IS '数据源，当前仅支持告警列表。';
COMMENT ON COLUMN "t_query_scene"."query_str" IS '查询条件';
COMMENT ON COLUMN "t_query_scene"."query_str_user_hash" IS '查询语句+用户名hash值，增加查询效率';
COMMENT ON COLUMN "t_query_scene"."sort_num" IS '排序编号';
COMMENT ON COLUMN "t_query_scene"."is_top" IS '是否置顶';
COMMENT ON COLUMN "t_query_scene"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_query_scene"."update_time" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_query_scene_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_query_scene_update_timestamp
BEFORE UPDATE ON "t_query_scene"
FOR EACH ROW
EXECUTE FUNCTION update_t_query_scene_timestamp();


DROP TABLE IF EXISTS "t_query_template";
CREATE TABLE "t_query_template"  (
  "id" VARCHAR(100)   NOT NULL DEFAULT '',
  "templateName" VARCHAR(150)   NOT NULL,
  "groupId" VARCHAR(100)   NOT NULL,
  "source" VARCHAR(50)   NOT NULL DEFAULT 'custom',
  "saveType" INTEGER UNSIGNED ZEROFILL NOT NULL DEFAULT 0000000100,
  "dataSource" VARCHAR(100)   NULL DEFAULT NULL,
  "indexOptions" TEXT   NULL,
  "query" TEXT   NULL,
  "retrievalFields" TEXT   NULL,
  "moreOptions" TEXT   NULL,
  "visualization" TEXT   NULL,
  "aggregation" TEXT   NULL,
  "timeRange" TEXT   NULL,
  "description" TEXT   NULL,
  "suggestion" TEXT   NULL,
  "orderNumber" INTEGER NOT NULL,
  "is_top" BOOLEAN NULL DEFAULT 0,
  "createTime" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "updateTime" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
  CONSTRAINT "foreign_key_template_to_group" FOREIGN KEY ("groupId") REFERENCES "t_query_template_group" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
  INSERT INTO "t_query_template" VALUES ('defaultBuildInAlarmConfigTemplateFreeExploration', '自由探索', 'defaultBuildInConfigAlarmTemplateGroup', '\"build_in_config\"', 0000000005, 'security_alarms', NULL, '*', '[{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"告警名称\",\"en\":\"alarmName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警名称(alarmName)\",\"type\":\"string\"},{\"ch\":\"威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警结果\",\"en\":\"alarmResults\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"攻击链\",\"en\":\"killChain\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击链(killChain)\",\"type\":\"enum\"}]', '{\"killChain\":[{\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[],\"unSelected\":[{\"index\":0,\"key\":\"告警名称(alarmName)\",\"name\":\"告警名称\",\"value\":\"alarmName\"},{\"index\":1,\"key\":\"攻击者(attacker)\",\"name\":\"攻击者\",\"value\":\"attacker\"},{\"index\":2,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"},{\"index\":3,\"key\":\"目的端口(destPort)\",\"name\":\"目的端口\",\"value\":\"destPort\"},{\"index\":4,\"key\":\"告警子类型(subCategory)\",\"name\":\"告警子类型\",\"value\":\"subCategory\"},{\"index\":5,\"key\":\"应用协议(appProtocol)\",\"name\":\"应用协议\",\"value\":\"appProtocol\"},{\"index\":6,\"key\":\"攻击链(killChain)\",\"name\":\"攻击链\",\"value\":\"killChain\"}]}', NULL, '', '', 1, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:50');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInEventConfigTemplateFreeExploration', '自由探索', 'defaultBuildInConfigEventTemplateGroup', '\"build_in_config\"', 0000000004, 'security_events', NULL, '*', '[{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"告警结果\",\"en\":\"alarmResults\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"threatSeverity\":[{\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, NULL, NULL, '', '', 1, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInLogConfigTemplateFreeExploration', '自由探索', 'defaultBuildInConfigLogTemplateGroup', '\"build_in_config\"', 0000000004, 'security_logs', '[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}]', '*', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, NULL, NULL, '', '', 1, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:47');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInMergeAlarmConfigTemplateFreeExploration', '自由探索', 'defaultBuildInConfigMergeAlarmTemplateGroup', '\"build_in_config\"', 0000000005, 'merge_alarms', '', '*', '[{\"ch\":\"最近发生时间\",\"en\":\"endTime\",\"isAgg\":false,\"isQuery\":true,\"key\":\"最近发生时间(endTime)\",\"type\":\"timestamp\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":false,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"威胁名称\",\"en\":\"alarmName\",\"isAgg\":false,\"isQuery\":true,\"key\":\"威胁名称(alarmName)\",\"type\":\"string\"},{\"ch\":\"威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":false,\"isQuery\":true,\"key\":\"威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":false,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":false,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"攻击结果\",\"en\":\"alarmResults\",\"isAgg\":false,\"isQuery\":true,\"key\":\"攻击结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"次数\",\"en\":\"eventCount\",\"isAgg\":false,\"isQuery\":true,\"key\":\"次数(eventCount)\",\"type\":\"Long\"},{\"ch\": \"研判结果\",\"en\": \"judgeResult\",\"isAgg\": false,\"isQuery\": true,\"key\": \"研判结果(judgeResult)\",\"type\": \"string\"}]', '', '', '', '', '', '', 1, 0, '2026-01-13 10:37:48', '2026-01-13 10:37:48');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateAlarmAdSecurity', '域安全', 'defaultGroupBuildInAlarmSceneTemplateGroup', '\"custom\"', 0000000004, 'security_alarms', NULL, 'tagSearch in [\"attack_drill\"] AND tagContent contains \"ad_security\"', '[{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警结果\",\"en\":\"alarmResults\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"攻击链\",\"en\":\"killChain\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击链(killChain)\",\"type\":\"enum\"}]', '{}', NULL, '', NULL, '', '', 2, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateAlarmCmdexec', '命令执行', 'defaultGroupBuildInAlarmSceneTemplateGroup', '\"custom\"', 0000000004, 'security_alarms', NULL, 'tagSearch in [\"attack_drill\"] AND tagContent contains \"cmdexec\"', '[{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警结果\",\"en\":\"alarmResults\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"攻击链\",\"en\":\"killChain\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击链(killChain)\",\"type\":\"enum\"}]', '{}', NULL, '', NULL, '', '', 4, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateAlarmCompromised', '失陷', 'defaultGroupBuildInAlarmSceneTemplateGroup', '\"custom\"', 0000000004, 'security_alarms', NULL, 'tagSearch in [\"attack_drill\"] AND tagContent contains \"success\"', '[{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警结果\",\"en\":\"alarmResults\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"攻击链\",\"en\":\"killChain\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击链(killChain)\",\"type\":\"enum\"}]', '{}', NULL, '', NULL, '', '', 0, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateAlarmHacktool', '黑客工具', 'defaultGroupBuildInAlarmSceneTemplateGroup', '\"custom\"', 0000000004, 'security_alarms', NULL, 'tagSearch in [\"attack_drill\"] AND tagContent contains \"hacktool\"', '[{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警结果\",\"en\":\"alarmResults\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"攻击链\",\"en\":\"killChain\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击链(killChain)\",\"type\":\"enum\"}]', '{}', NULL, '', NULL, '', '', 5, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateAlarmMalware', '可疑文件', 'defaultGroupBuildInAlarmSceneTemplateGroup', '\"custom\"', 0000000004, 'security_alarms', NULL, 'tagSearch in [\"attack_drill\"] AND tagContent contains \"malware\"', '[{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警结果\",\"en\":\"alarmResults\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"攻击链\",\"en\":\"killChain\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击链(killChain)\",\"type\":\"enum\"}]', '{}', NULL, '', NULL, '', '', 7, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateAlarmMiddlevul', '中间件漏洞', 'defaultGroupBuildInAlarmSceneTemplateGroup', '\"custom\"', 0000000004, 'security_alarms', NULL, 'tagSearch in [\"attack_drill\"] AND tagContent contains \"middlevul\"', '[{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警结果\",\"en\":\"alarmResults\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"攻击链\",\"en\":\"killChain\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击链(killChain)\",\"type\":\"enum\"}]', '{}', NULL, '', NULL, '', '', 1, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateAlarmTunnel', '隐蔽隧道', 'defaultGroupBuildInAlarmSceneTemplateGroup', '\"custom\"', 0000000004, 'security_alarms', NULL, 'tagSearch in [\"attack_drill\"] AND tagContent contains \"tunnel\"', '[{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警结果\",\"en\":\"alarmResults\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"攻击链\",\"en\":\"killChain\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击链(killChain)\",\"type\":\"enum\"}]', '{}', NULL, '', NULL, '', '', 6, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateAlarmWebshell', 'Webshell', 'defaultGroupBuildInAlarmSceneTemplateGroup', '\"custom\"', 0000000004, 'security_alarms', NULL, 'tagSearch in [\"attack_drill\"] AND tagContent contains \"webshell\"', '[{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警结果\",\"en\":\"alarmResults\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警结果(alarmResults)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"攻击链\",\"en\":\"killChain\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击链(killChain)\",\"type\":\"enum\"}]', '{}', NULL, '', NULL, '', '', 3, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateBlackmailVirus', '勒索病毒', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'subCategory == \"/Malware/Ransomware\"', '[{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源安全域(srcSecurityZone)\",\"type\":\"enum\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的安全域(destSecurityZone)\",\"type\":\"enum\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"uuid\":\"\",\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"uuid\":\"15783746223661366\",\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"uuid\":\"\",\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"uuid\":\"\",\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"uuid\":\"\",\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"uuid\":\"\",\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"uuid\":\"\",\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"uuid\":\"\",\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"uuid\":\"\",\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"uuid\":\"\",\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"uuid\":\"\",\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":1,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"}],\"unSelected\":[{\"index\":0,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":2,\"key\":\"来源安全域(srcSecurityZone)\",\"name\":\"来源安全域\",\"value\":\"srcSecurityZone\"}]}', NULL, '内部存在勒索病毒，尝试连接黑客的C&C服务器。\r\n勒索病毒主要以邮件为传播方式，会对指定类型的文件进行加密，无需联网下载密钥即可实现对文件加密。加密完成后，还会在桌面等明显位置生成勒索提示文件，指导用户去缴纳赎金。', '1、在终端或服务器上查杀勒索病毒。', 3, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateBruteForce', '正在暴力破解的攻击者', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'subCategory == \"/AccountRisk/BruteForce\"', '[{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"目的主机名\",\"en\":\"destHostName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的主机名(destHostName)\",\"type\":\"string\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"来源用户名\",\"en\":\"srcUserName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源用户名(srcUserName)\",\"type\":\"string\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"isAgg\":true,\"isQuery\":true,\"key\":\"应用协议(appProtocol)\",\"type\":\"enum\"}]', '{\"killChain\":[{\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false},{\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false}],\"alarmStatus\":[{\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false},{\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true}],\"alarmResults\":[{\"key\":\"UNKNOWN\",\"name\":\"尝试\",\"value\":false},{\"key\":\"FAIL\",\"name\":\"失败\",\"value\":false},{\"key\":\"OK\",\"name\":\"成功\",\"value\":false}],\"threatSeverity\":[{\"key\":\"High\",\"name\":\"高\",\"value\":false},{\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"key\":\"Low\",\"name\":\"低\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"攻击者(attacker)\",\"name\":\"攻击者\",\"value\":\"attacker\"}],\"unSelected\":[{\"index\":1,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"},{\"index\":2,\"key\":\"来源用户名(srcUserName)\",\"name\":\"来源用户名\",\"value\":\"srcUserName\"},{\"index\":3,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":4,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"},{\"index\":5,\"key\":\"应用协议(appProtocol)\",\"name\":\"应用协议\",\"value\":\"appProtocol\"}]}', NULL, '暴力破解通过使用枚举方法，一个一个使用用户名和密码字典，尝试登录各种系统，如：WEB、FTP、邮箱、SMB，直到得到正确结果，是一种攻击手段。为了提高效率，暴力破解一般会使用带有字典的攻击来进行自动化操作。\n采用比较弱的认证策略，系统账号可能会被暴破成功，建议系统完善认证策略，如：1.要求用户设置复杂的密码；2.对尝试登录行为进行判断及限制；3.采用双因子认证。', '1、确认暴破来源\n2、当攻击者来源于互联网时，请使用 <处置联动> 功能进行一键封堵\n3、当攻击者来源于内网时，排查处置对应来源设备', 10, 0, '2026-01-13 10:37:44', '2026-01-13 10:37:44');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateConfigurationRisk', '配置风险', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'subCategory in [\"/ConfigRisk/HTTPServer\",\"/ConfigRisk/MidWare\",\"/ConfigRisk/Database\",\"/ConfigRisk/Service\",\"/ConfigRisk/DeviceConf\",\"/ConfigRisk/Others\"]', '[{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的安全域(destSecurityZone)\",\"type\":\"enum\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"}],\"unSelected\":[{\"index\":1,\"key\":\"目的端口(destPort)\",\"name\":\"目的端口\",\"value\":\"destPort\"},{\"index\":2,\"key\":\"告警子类型(subCategory)\",\"name\":\"告警子类型\",\"value\":\"subCategory\"},{\"index\":3,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":4,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"}]}', NULL, '内部服务器存在配置风险。配置风险包括HTTP配置风险、中间件暗配置风险、数据库配置风险、服务配置风险。攻击者可以利用这些风险配置项，寻找服务器存在的漏洞，继而根据漏洞访问未经授权的功能和数据。', '1、修改出口防火墙、业务服务器上的错误配置。', 14, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:44');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateCorporateImage', '企业形象不良影响', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'subCategory in [\"/SuspEndpoint/Attack\",\"/SuspEndpoint/ExternalScan\",\"/WebAttack/WebTempering\"]', '[{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源安全域(srcSecurityZone)\",\"type\":\"enum\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"}],\"unSelected\":[{\"index\":1,\"key\":\"告警子类型(subCategory)\",\"name\":\"告警子类型\",\"value\":\"subCategory\"},{\"index\":2,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"}]}', NULL, '检测到内部服务器存在对外攻击、对外扫描、网页篡改等行为，造成不良社会影响，有损公司形象及利益。', '1、修改问题终端和服务器，停止对外发起的扫描和攻击行为。', 13, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:44');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateCVEExploit', 'CVE漏洞利用成功', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'cve exist AND (name contains \"成功\" OR alarmResults == \"OK\") AND direction != \"01\"', '[{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"cve编号\",\"en\":\"cve\",\"isAgg\":true,\"isQuery\":true,\"key\":\"cve编号(cve)\",\"type\":\"string\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"uuid\":\"\",\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"uuid\":\"15783746223661366\",\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"uuid\":\"\",\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"uuid\":\"\",\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"uuid\":\"\",\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"uuid\":\"\",\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"uuid\":\"\",\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"uuid\":\"\",\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"uuid\":\"\",\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"uuid\":\"\",\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"uuid\":\"\",\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"}],\"unSelected\":[{\"index\":1,\"key\":\"目的端口(destPort)\",\"name\":\"目的端口\",\"value\":\"destPort\"},{\"index\":2,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":3,\"key\":\"cve编号(cve)\",\"name\":\"cve编号\",\"value\":\"cve\"},{\"index\":4,\"key\":\"应用协议(appProtocol)\",\"name\":\"应用协议\",\"value\":\"appProtocol\"},{\"index\":5,\"key\":\"告警子类型(subCategory)\",\"name\":\"告警子类型\",\"value\":\"subCategory\"},{\"index\":6,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"}]}', NULL, '内部系统存在CVE漏洞，并被成功利用，及时修复漏洞。\r\n漏洞利用是获得系统控制权限的重要途径，攻击者利用工具，采用不同方法，从目标系统中找到容易攻击的漏洞，然后利用该漏洞获取权限，从而实现对目标系统的控制，能够在未授权的情况下访问或者破坏系统。', '1、修补终端或服务器上存在的漏洞。', 2, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateDNSQuery', 'DNS查询', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"dns\" AND dnsType == \"answer\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"queryType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"查询类型\",\"key\":\"查询类型(queryType)\"},{\"en\":\"requestDomain\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"dns请求域名\",\"key\":\"dns请求域名(requestDomain)\"},{\"en\":\"responseAddress\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"返回的IP地址\",\"key\":\"返回的IP地址(responseAddress)\"},{\"en\":\"responseCode\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求响应码\",\"key\":\"请求响应码(responseCode)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 4, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateFileTransfer', '文件传输', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"fileinfo\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"opType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"操作类型\",\"key\":\"操作类型(opType)\"},{\"en\":\"fileName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件名\",\"key\":\"文件名(fileName)\"},{\"en\":\"fileType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件类型\",\"key\":\"文件类型(fileType)\"},{\"en\":\"fileMd5\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件MD5\",\"key\":\"文件MD5(fileMd5)\"},{\"en\":\"fileSize\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"文件大小\",\"key\":\"文件大小(fileSize)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 2, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateFTPCommandExecution', 'FTP命令执行', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"ftp\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"requestMethod\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求方法\",\"key\":\"请求方法(requestMethod)\"},{\"en\":\"requestParameters\",\"isQuery\":true,\"isAgg\":false,\"type\":\"string\",\"ch\":\"请求参数\",\"key\":\"请求参数(requestParameters)\"},{\"en\":\"responseCode\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求响应码\",\"key\":\"请求响应码(responseCode)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 5, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateHighRiskEvent', '高危事件', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'threatSeverity in [\"High\"] AND alarmStatus == \"unprocessed\"', '[{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"isAgg\":true,\"isQuery\":true,\"key\":\"应用协议(appProtocol)\",\"type\":\"enum\"},{\"ch\":\"告警标签\",\"en\":\"alarmTag\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警标签(alarmTag)\",\"type\":\"array\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"uuid\":\"\",\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"uuid\":\"15783746223661366\",\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"uuid\":\"\",\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"uuid\":\"\",\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"uuid\":\"\",\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"uuid\":\"\",\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"uuid\":\"\",\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"uuid\":\"\",\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"uuid\":\"\",\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"uuid\":\"\",\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"uuid\":\"\",\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"攻击者(attacker)\",\"name\":\"攻击者\",\"value\":\"attacker\"},{\"index\":1,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"}],\"unSelected\":[{\"index\":2,\"key\":\"告警子类型(subCategory)\",\"name\":\"告警子类型\",\"value\":\"subCategory\"},{\"index\":3,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":4,\"key\":\"目的端口(destPort)\",\"name\":\"目的端口\",\"value\":\"destPort\"},{\"index\":5,\"key\":\"应用协议(appProtocol)\",\"name\":\"应用协议\",\"value\":\"appProtocol\"},{\"index\":6,\"key\":\"告警标签(alarmTag)\",\"name\":\"告警标签\",\"value\":\"alarmTag\"},{\"index\":7,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"}]}', NULL, '检测到高危事件，根据事件名称、告警类型、攻击者、受害者等进行专项分析研判，并进行应急处置。', '1、进行专项分析研判，并进行应急处置。', 9, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:44');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLogAlert', '威胁告警', 'defaultGroupBuildInLogSceneTemplateGroup', '\"custom\"', 0000000004, 'security_logs', NULL, 'logType == \"alert\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, '', NULL, '', '', 0, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLogDNS', 'DNS查询', 'defaultGroupBuildInLogSceneTemplateGroup', '\"custom\"', 0000000004, 'security_logs', NULL, 'logType == \"dns\" AND dnsType == \"answer\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, '', NULL, '', '', 6, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLogFileinfo', '文件传输', 'defaultGroupBuildInLogSceneTemplateGroup', '\"custom\"', 0000000004, 'security_logs', NULL, 'logType == \"fileinfo\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, '', NULL, '', '', 2, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLogFlow', '流量会话', 'defaultGroupBuildInLogSceneTemplateGroup', '\"custom\"', 0000000004, 'security_logs', NULL, 'logType == \"flow\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, '', NULL, '', '', 5, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLogHttp', 'WEB访问', 'defaultGroupBuildInLogSceneTemplateGroup', '\"custom\"', 0000000004, 'security_logs', NULL, 'logType == \"http\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, '', NULL, '', '', 3, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLogHttpError', 'HTTP服务响应异常', 'defaultGroupBuildInLogSceneTemplateGroup', '\"custom\"', 0000000004, 'security_logs', NULL, 'appProtocol == \"http\" AND responseCode != \"200\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, '', NULL, '', '', 7, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLogIllegalSmtp', '非法利用业务端口邮件传输', 'defaultGroupBuildInLogSceneTemplateGroup', '\"custom\"', 0000000004, 'security_logs', NULL, 'appProtocol == \"smtp\" AND destPort != 25', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, '', NULL, '', '', 7, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLogIllegalSsh', '非法利用业务端口ssh远程连接', 'defaultGroupBuildInLogSceneTemplateGroup', '\"custom\"', 0000000004, 'security_logs', NULL, 'appProtocol == \"ssh\" AND destPort != 22', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, '', NULL, '', '', 7, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLoginBehavior', '登录行为', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"login\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"srcUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源用户名\",\"key\":\"来源用户名(srcUserName)\"},{\"en\":\"catOutcome\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"事件结果分类\",\"key\":\"事件结果分类(catOutcome)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 1, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLogLogin', '登录日志', 'defaultGroupBuildInLogSceneTemplateGroup', '\"custom\"', 0000000004, 'security_logs', NULL, 'logType == \"login\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, '', NULL, '', '', 1, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateLogSmtp', '邮件通信', 'defaultGroupBuildInLogSceneTemplateGroup', '\"custom\"', 0000000004, 'security_logs', NULL, 'logType == \"smtp\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"采集器接收时间(collectorReceiptTime)\",\"type\":\"timestamp\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"解析产品名称\",\"en\":\"deviceSendProductName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"解析产品名称(deviceSendProductName)\",\"type\":\"string\"},{\"ch\":\"事件结果分类\",\"en\":\"catOutcome\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件结果分类(catOutcome)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"}]', '{}', NULL, '', NULL, '', '', 4, 0, '2023-05-08 15:34:43', '2023-05-08 15:34:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateMailCommunication', '邮件通信', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"smtp\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"srcUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源用户名\",\"key\":\"来源用户名(srcUserName)\"},{\"en\":\"destUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"目的用户名\",\"key\":\"目的用户名(destUserName)\"},{\"en\":\"ccUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"抄送人\",\"key\":\"抄送人(ccUserName)\"},{\"en\":\"mailTitle\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"邮件标题\",\"key\":\"邮件标题(mailTitle)\"},{\"en\":\"srcGeoCountry\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源国家\",\"key\":\"来源国家(srcGeoCountry)\"},{\"en\":\"srcGeoRegion\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源地区\",\"key\":\"来源地区(srcGeoRegion)\"},{\"en\":\"srcGeoCity\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源城市\",\"key\":\"来源城市(srcGeoCity)\"}]', '{}', NULL, NULL, NULL, '', '', 7, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateMiningActivity', '挖矿活动', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'subCategory == \"/Malware/Miner\"', '[{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源安全域(srcSecurityZone)\",\"type\":\"enum\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的安全域(destSecurityZone)\",\"type\":\"enum\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"uuid\":\"\",\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"uuid\":\"15783746223661366\",\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"uuid\":\"\",\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"uuid\":\"\",\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"uuid\":\"\",\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"uuid\":\"\",\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"uuid\":\"\",\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"uuid\":\"\",\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"uuid\":\"\",\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"uuid\":\"\",\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"uuid\":\"\",\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"}],\"unSelected\":[{\"index\":1,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":2,\"key\":\"攻击者(attacker)\",\"name\":\"攻击者\",\"value\":\"attacker\"},{\"index\":3,\"key\":\"来源安全域(srcSecurityZone)\",\"name\":\"来源安全域\",\"value\":\"srcSecurityZone\"},{\"index\":4,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"}]}', NULL, '内部服务器被植入挖矿木马，正在使用计算机资源进行挖矿活动，获取数字货币。计算机会出现电脑卡顿，进程缓慢，发热耗电等情况。\r\n挖矿木马通过漏洞利用、网站挂马等方式进行传播，被植入木马的终端会被攻击者用作矿机，由于挖矿程序会占用大量系统资源，容易导致cpu温度过高、终端无法正常工作、服务器瘫痪等问题。', '1、在终端或服务器上查杀挖矿木马，停止挖矿行为。', 4, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateOutAttacker', '外部攻击者', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'direction == \"10\" AND (threatSeverity in [\"High\",\"Medium\"])', '[{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"来源国家\",\"en\":\"srcGeoCountry\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源国家(srcGeoCountry)\",\"type\":\"string\"},{\"ch\":\"来源地区\",\"en\":\"srcGeoRegion\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源地区(srcGeoRegion)\",\"type\":\"string\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的安全域(destSecurityZone)\",\"type\":\"enum\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"uuid\":\"\",\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"uuid\":\"15783746223661366\",\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"uuid\":\"\",\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"uuid\":\"\",\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"uuid\":\"\",\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"uuid\":\"\",\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"uuid\":\"\",\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"uuid\":\"\",\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"uuid\":\"\",\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"uuid\":\"\",\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"uuid\":\"\",\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"攻击者(attacker)\",\"name\":\"攻击者\",\"value\":\"attacker\"}],\"unSelected\":[{\"index\":1,\"key\":\"来源国家(srcGeoCountry)\",\"name\":\"来源国家\",\"value\":\"srcGeoCountry\"},{\"index\":2,\"key\":\"来源地区(srcGeoRegion)\",\"name\":\"来源地区\",\"value\":\"srcGeoRegion\"},{\"index\":3,\"key\":\"告警子类型(subCategory)\",\"name\":\"告警子类型\",\"value\":\"subCategory\"},{\"index\":4,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":5,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"},{\"index\":6,\"key\":\"目的端口(destPort)\",\"name\":\"目的端口\",\"value\":\"destPort\"},{\"index\":7,\"key\":\"目的安全域(destSecurityZone)\",\"name\":\"目的安全域\",\"value\":\"destSecurityZone\"},{\"index\":8,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"}]}', NULL, '内部受到外部攻击，外部攻击是典型的主动攻击，及时关注并采取相应措施。\r\n外部攻击由网络外部的恶意节点发起，其手法包含端口扫描、漏洞探测及利用、邮件欺骗、口令入侵等，其目的包括探测内部存在漏洞服务、传播异常数据包，导致网络堵塞，切断服务、篡改、盗取数据等。', '1、在出口防火墙上添加黑名单封禁外部攻击者。', 0, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:44');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateOutAttackerIntruded', '外部攻击者入侵成功', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'direction == \"10\" AND (threatSeverity in [\"High\",\"Medium\"]) AND alarmResults == \"OK\"', '[{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"来源国家\",\"en\":\"srcGeoCountry\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源国家(srcGeoCountry)\",\"type\":\"string\"},{\"ch\":\"来源地区\",\"en\":\"srcGeoRegion\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源地区(srcGeoRegion)\",\"type\":\"string\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的安全域(destSecurityZone)\",\"type\":\"enum\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false},{\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false}],\"alarmStatus\":[{\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false},{\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true}],\"alarmResults\":[{\"key\":\"UNKNOWN\",\"name\":\"尝试\",\"value\":false},{\"key\":\"FAIL\",\"name\":\"失败\",\"value\":false},{\"key\":\"OK\",\"name\":\"成功\",\"value\":false}],\"threatSeverity\":[{\"key\":\"High\",\"name\":\"高\",\"value\":false},{\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"key\":\"Low\",\"name\":\"低\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"攻击者(attacker)\",\"name\":\"攻击者\",\"value\":\"attacker\"},{\"index\":1,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"}],\"unSelected\":[{\"index\":2,\"key\":\"来源国家(srcGeoCountry)\",\"name\":\"来源国家\",\"value\":\"srcGeoCountry\"},{\"index\":3,\"key\":\"来源地区(srcGeoRegion)\",\"name\":\"来源地区\",\"value\":\"srcGeoRegion\"},{\"index\":4,\"key\":\"告警子类型(subCategory)\",\"name\":\"告警子类型\",\"value\":\"subCategory\"},{\"index\":5,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":6,\"key\":\"目的端口(destPort)\",\"name\":\"目的端口\",\"value\":\"destPort\"},{\"index\":7,\"key\":\"目的安全域(destSecurityZone)\",\"name\":\"目的安全域\",\"value\":\"destSecurityZone\"},{\"index\":8,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"}]}', NULL, '内部设备已被成功入侵，外部攻击者通过扫描探测、漏洞利用、暴力破解等手法，攻陷内部设备，关注并采取相应措施。', '1、在出口防火墙上添加黑名单封禁外部攻击者。\n2、联系安全服务人员处置被攻陷设备', 1, 0, '2026-01-13 10:37:44', '2026-01-13 10:37:44');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplatePhishingMail', '钓鱼邮件', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, '(name == \"恶意文件攻击\" OR ruleName == \"发现恶意文件传输\") AND catOutcome == \"OK\" AND appProtocol in [\"pop2\",\"pop3\",\"smtp\",\"imap\"]', '[{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"来源用户名\",\"en\":\"srcUserName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源用户名(srcUserName)\",\"type\":\"string\"},{\"ch\":\"目的用户名\",\"en\":\"destUserName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的用户名(destUserName)\",\"type\":\"string\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"uuid\":\"\",\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"uuid\":\"15783746223661366\",\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"uuid\":\"\",\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"uuid\":\"\",\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"uuid\":\"\",\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"uuid\":\"\",\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"uuid\":\"\",\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"uuid\":\"\",\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"uuid\":\"\",\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"uuid\":\"\",\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"uuid\":\"\",\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":2,\"key\":\"目的用户名(destUserName)\",\"name\":\"目的用户名\",\"value\":\"destUserName\"}],\"unSelected\":[{\"index\":0,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":1,\"key\":\"来源用户名(srcUserName)\",\"name\":\"来源用户名\",\"value\":\"srcUserName\"},{\"index\":3,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"},{\"index\":4,\"key\":\"来源IP(srcAddress)\",\"name\":\"来源IP\",\"value\":\"srcAddress\"},{\"index\":5,\"key\":\"目的IP(destAddress)\",\"name\":\"目的IP\",\"value\":\"destAddress\"},{\"index\":6,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"}]}', NULL, '内部存在钓鱼邮件通信。\r\n钓鱼邮件利用伪装的电邮，欺骗收件人将账号、口令等信息回复给指定的接收者；引导收件人连接到特制的网页，这些网页通常会伪装成和真实网站一样，如银行或理财的网页，令登录者信以为真，输入信用卡或银行卡号码、账户名称及密码等而被盗取。', '1、保持对平台的关注，定期巡检。\r\n2、做好安全培训工作，提醒内部人员不轻易下载未知来源的邮件附件。', 7, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:44');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplatePlaintextTransmission', '信息明文传输风险', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'subCategory == \"/ConfigRisk/ClearTextCredit\"', '[{\"ch\":\"目的主机名\",\"en\":\"destHostName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的主机名(destHostName)\",\"type\":\"string\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"uuid\":\"\",\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"uuid\":\"15783746223661366\",\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"uuid\":\"\",\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"uuid\":\"\",\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"uuid\":\"\",\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"uuid\":\"\",\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"uuid\":\"\",\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"uuid\":\"\",\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"uuid\":\"\",\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"uuid\":\"\",\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"uuid\":\"\",\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"目的主机名(destHostName)\",\"name\":\"目的主机名\",\"value\":\"destHostName\"}],\"unSelected\":[{\"index\":1,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":2,\"key\":\"URL(requestUrl)\",\"name\":\"URL\",\"value\":\"requestUrl\"},{\"index\":3,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"}]}', NULL, '检测到信息明文传输风险，攻击者可通过更改用户代理的方式截获用户敏感数据，比如在网页登录的账号密码。会导致信息泄漏，服务器沦陷等风险。\r\n信息明文传输是一个很常见的漏洞，当遭受中间人劫持攻击的时候会获取到传输中的明文数据，这里建议即便网站使用HTTPS协议进行数据传输，也要将数据在前端经过JS加密后再进行传输。这样即使攻击者截获用户流量，在经过HTTPS解密后拿到的依然是通过JS加密后的敏感数据。这样就进一步给攻击者增加了攻击成本。', '1、网站使用HTTPS协议进行数据传输。', 12, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:44');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateRDPConnection', 'RDP连接', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"rdp\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 10, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateSMBCommunication', 'SMB通信', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"smb\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"srcUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源用户名\",\"key\":\"来源用户名(srcUserName)\"},{\"en\":\"destHostName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"目的主机名\",\"key\":\"目的主机名(destHostName)\"},{\"en\":\"cmdContent\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"命令行\",\"key\":\"命令行(cmdContent)\"},{\"en\":\"status\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"状态\",\"key\":\"状态(status)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 8, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateSpreadViruses', '内网传播的病毒', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'ruleName == \"发现恶意文件传输\" AND direction == \"00\" AND appProtocol notin [\"pop2\",\"pop3\",\"smtp\",\"imap\"]', '[{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"病毒名称\",\"en\":\"virusName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"病毒名称(virusName)\",\"type\":\"string\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"isAgg\":true,\"isQuery\":true,\"key\":\"应用协议(appProtocol)\",\"type\":\"enum\"},{\"ch\":\"操作类型\",\"en\":\"opType\",\"isAgg\":true,\"isQuery\":true,\"key\":\"操作类型(opType)\",\"type\":\"string\"},{\"ch\":\"文件名\",\"en\":\"fileName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"文件名(fileName)\",\"type\":\"string\"},{\"ch\":\"文件MD5\",\"en\":\"fileMd5\",\"isAgg\":true,\"isQuery\":true,\"key\":\"文件MD5(fileMd5)\",\"type\":\"string\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false},{\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false}],\"alarmStatus\":[{\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false},{\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true}],\"alarmResults\":[{\"key\":\"UNKNOWN\",\"name\":\"尝试\",\"value\":false},{\"key\":\"FAIL\",\"name\":\"失败\",\"value\":false},{\"key\":\"OK\",\"name\":\"成功\",\"value\":false}],\"threatSeverity\":[{\"key\":\"High\",\"name\":\"高\",\"value\":false},{\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"key\":\"Low\",\"name\":\"低\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"病毒名称(virusName)\",\"name\":\"病毒名称\",\"value\":\"virusName\"}],\"unSelected\":[{\"index\":1,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"},{\"index\":2,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":3,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"},{\"index\":4,\"key\":\"攻击者(attacker)\",\"name\":\"攻击者\",\"value\":\"attacker\"},{\"index\":5,\"key\":\"来源IP(srcAddress)\",\"name\":\"来源IP\",\"value\":\"srcAddress\"},{\"index\":6,\"key\":\"目的IP(destAddress)\",\"name\":\"目的IP\",\"value\":\"destAddress\"},{\"index\":7,\"key\":\"操作类型(opType)\",\"name\":\"操作类型\",\"value\":\"opType\"},{\"index\":8,\"key\":\"文件名(fileName)\",\"name\":\"文件名\",\"value\":\"fileName\"},{\"index\":9,\"key\":\"文件MD5(fileMd5)\",\"name\":\"文件MD5\",\"value\":\"fileMd5\"}]}', NULL, '杀毒引擎和沙箱检测引擎发现文件型病毒，文件型病毒是计算机病毒的一种，主要通过感染计算机中的可执行文件（.exe）和命令文件(.com)，对计算机的源文件进行修改，使其成为新的带毒文件。一旦计算机运行该文件就会被感染，从而达到传播的目的。', '1、在终端或服务器上删除病毒文件，查杀病毒，删除恶意进程。', 8, 0, '2026-01-13 10:37:44', '2026-01-13 10:37:44');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateTELNETRequest', 'TELNET请求', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"telnet\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"srcUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源用户名\",\"key\":\"来源用户名(srcUserName)\"},{\"en\":\"requestMethod\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求方法\",\"key\":\"请求方法(requestMethod)\"},{\"en\":\"responseMsg\",\"isQuery\":true,\"isAgg\":false,\"type\":\"string\",\"ch\":\"响应内容\",\"key\":\"响应内容(responseMsg)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 9, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateTFTPVisit', 'TFTP访问', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"tftp\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"opType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"操作类型\",\"key\":\"操作类型(opType)\"},{\"en\":\"fileName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件名\",\"key\":\"文件名(fileName)\"},{\"en\":\"transMode\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"传输模式\",\"key\":\"传输模式(transMode)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 6, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateThreatAlarm', '威胁告警', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"alert\"', '[{\"en\":\"collectorReceiptTime\",\"isQuery\":true,\"isAgg\":true,\"type\":\"timestamp\",\"ch\":\"采集器接收时间\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"en\":\"severity\",\"isQuery\":true,\"isAgg\":true,\"type\":\"int\",\"ch\":\"安全日志威胁等级\",\"key\":\"安全日志威胁等级(severity)\"},{\"en\":\"ruleType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"探针设备告警类型\",\"key\":\"探针设备告警类型(ruleType)\"},{\"en\":\"catOutcome\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"事件结果分类\",\"key\":\"事件结果分类(catOutcome)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 0, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateThreatIntelligence', '威胁情报', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'modelType == \"intelligence\"', '[{\"ch\":\"情报IoC\",\"en\":\"IoC\",\"isAgg\":true,\"isQuery\":true,\"key\":\"情报IoC(IoC)\",\"type\":\"string\"},{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"告警子类型\",\"en\":\"subCategory\",\"isAgg\":true,\"isQuery\":true,\"key\":\"告警子类型(subCategory)\",\"type\":\"enum\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源安全域(srcSecurityZone)\",\"type\":\"enum\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"uuid\":\"\",\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"uuid\":\"15783746223661366\",\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"uuid\":\"\",\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"uuid\":\"\",\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"uuid\":\"\",\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"uuid\":\"\",\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"uuid\":\"\",\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"uuid\":\"\",\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"uuid\":\"\",\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"uuid\":\"\",\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"uuid\":\"\",\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"情报IoC(IoC)\",\"name\":\"情报IoC\",\"value\":\"IoC\"}],\"unSelected\":[{\"index\":1,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"},{\"index\":2,\"key\":\"告警子类型(subCategory)\",\"name\":\"告警子类型\",\"value\":\"subCategory\"},{\"index\":3,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"}]}', NULL, '攻击者常常向企业和组织发起针对性的高级持续性攻击，这类攻击无法通过恶意程序签名或者过去的攻击技术报告进行检测，通过威胁情报能简单快捷发现攻击行为。根据威胁情报数据库，检测到恶意情报活动，存在恶意域名请求，恶意IP回连，或者存在恶意文件传输等行为。\r\n由此判断内部主机可能存在远程木马、僵尸程序、勒索病毒等，面临丢失帐号或者隐私信息等危险，请尽快处理。', '1、将外连域名进行DNS解析重定向，同时处理内部失陷主机。', 5, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateTrafficSession', '流量会话', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"flow\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"en\":\"srcPort\",\"isQuery\":true,\"isAgg\":true,\"type\":\"int\",\"ch\":\"来源端口\",\"key\":\"来源端口(srcPort)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"en\":\"destPort\",\"isQuery\":true,\"isAgg\":true,\"type\":\"int\",\"ch\":\"目的端口\",\"key\":\"目的端口(destPort)\"},{\"en\":\"transProtocol\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"传输协议\",\"key\":\"传输协议(transProtocol)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"bytesIn\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"请求流量\",\"key\":\"请求流量(bytesIn)\"},{\"en\":\"bytesOut\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"响应流量\",\"key\":\"响应流量(bytesOut)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 11, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateWeakPassword', '弱口令', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'subCategory == \"/ConfigRisk/WeakPassword\"', '[{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的端口(destPort)\",\"type\":\"int\"},{\"ch\":\"来源用户名\",\"en\":\"srcUserName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源用户名(srcUserName)\",\"type\":\"string\"},{\"ch\":\"密码\",\"en\":\"passwd\",\"isAgg\":true,\"isQuery\":true,\"key\":\"密码(passwd)\",\"type\":\"string\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"isAgg\":true,\"isQuery\":true,\"key\":\"应用协议(appProtocol)\",\"type\":\"enum\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"uuid\":\"\",\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"uuid\":\"15783746223661366\",\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"uuid\":\"\",\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"uuid\":\"\",\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"uuid\":\"\",\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"uuid\":\"\",\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"uuid\":\"\",\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"uuid\":\"\",\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"uuid\":\"\",\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"uuid\":\"\",\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"uuid\":\"\",\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"}],\"unSelected\":[{\"index\":1,\"key\":\"目的端口(destPort)\",\"name\":\"目的端口\",\"value\":\"destPort\"},{\"index\":2,\"key\":\"来源用户名(srcUserName)\",\"name\":\"来源用户名\",\"value\":\"srcUserName\"},{\"index\":3,\"key\":\"密码(passwd)\",\"name\":\"密码\",\"value\":\"passwd\"},{\"index\":4,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":5,\"key\":\"应用协议(appProtocol)\",\"name\":\"应用协议\",\"value\":\"appProtocol\"},{\"index\":6,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"}]}', NULL, '内部存在弱口令系统，容易被攻击者猜测或使用暴力破解攻击破解，服务器面临风险，可能导致内部系统和服务器沦陷。\r\n常见的弱口令可分为系统弱口令（ssh、ftp、telnet等），组件弱口令（tomcat、weblogic、redis等），设备弱口令（路由器、安全设备、监控设备等），网页弱口令。', '1、修改账号口令，口令尽量复杂，尽量包括字符、数字及特殊字符。', 11, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:44');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateWebShell', '站点存在webshell后门', 'defaultBuildInRetrievalAlarmTemplateGroup', '\"build_in\"', 0000000005, 'security_alarms', NULL, 'subCategory == \"/Malware/Webshell\"', '[{\"ch\":\"受害者\",\"en\":\"victim\",\"isAgg\":true,\"isQuery\":true,\"key\":\"受害者(victim)\",\"type\":\"array\"},{\"ch\":\"目的主机名\",\"en\":\"destHostName\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的主机名(destHostName)\",\"type\":\"string\"},{\"ch\":\"URL\",\"en\":\"requestUrl\",\"isAgg\":true,\"isQuery\":true,\"key\":\"URL(requestUrl)\",\"type\":\"string\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"isAgg\":true,\"isQuery\":true,\"key\":\"事件名称(name)\",\"type\":\"string\"},{\"ch\":\"安全告警威胁等级\",\"en\":\"threatSeverity\",\"isAgg\":true,\"isQuery\":true,\"key\":\"安全告警威胁等级(threatSeverity)\",\"type\":\"enum\"},{\"ch\":\"攻击者\",\"en\":\"attacker\",\"isAgg\":true,\"isQuery\":true,\"key\":\"攻击者(attacker)\",\"type\":\"array\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"目的IP(destAddress)\",\"type\":\"ip\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"isAgg\":true,\"isQuery\":true,\"key\":\"来源IP(srcAddress)\",\"type\":\"ip\"},{\"ch\":\"起始时间\",\"en\":\"startTime\",\"isAgg\":true,\"isQuery\":true,\"key\":\"起始时间(startTime)\",\"type\":\"timestamp\"}]', '{\"killChain\":[{\"uuid\":\"\",\"key\":\"KC_Reconnaissance\",\"name\":\"侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Delivery\",\"name\":\"投递\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Exploitation\",\"name\":\"利用\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_CommandControl\",\"name\":\"命令控制\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_InternalRecon\",\"name\":\"内部侦查\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_LateralMov\",\"name\":\"横向渗透\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Profit\",\"name\":\"获利\",\"value\":false},{\"uuid\":\"\",\"key\":\"KC_Others\",\"name\":\"无\",\"value\":false}],\"alarmStatus\":[{\"uuid\":\"15783746223661366\",\"key\":\"unprocessed\",\"name\":\"未处理\",\"value\":true},{\"uuid\":\"\",\"key\":\"processing\",\"name\":\"处理中\",\"value\":false},{\"uuid\":\"\",\"key\":\"processed\",\"name\":\"处理完成\",\"value\":false},{\"uuid\":\"\",\"key\":\"falsePositives\",\"name\":\"误报\",\"value\":false}],\"alarmResults\":[{\"uuid\":\"\",\"key\":\"OK\",\"name\":\"攻击成功\",\"value\":false},{\"uuid\":\"\",\"key\":\"FAIL\",\"name\":\"攻击失败\",\"value\":false},{\"uuid\":\"\",\"key\":\"UNKOWN\",\"name\":\"未知\",\"value\":false}],\"threatSeverity\":[{\"uuid\":\"\",\"key\":\"Low\",\"name\":\"低\",\"value\":false},{\"uuid\":\"\",\"key\":\"Medium\",\"name\":\"中\",\"value\":false},{\"uuid\":\"\",\"key\":\"High\",\"name\":\"高\",\"value\":false}]}', NULL, '{\"selected\":[{\"index\":0,\"key\":\"受害者(victim)\",\"name\":\"受害者\",\"value\":\"victim\"},{\"index\":1,\"key\":\"URL(requestUrl)\",\"name\":\"URL\",\"value\":\"requestUrl\"}],\"unSelected\":[{\"index\":2,\"key\":\"事件名称(name)\",\"name\":\"事件名称\",\"value\":\"name\"},{\"index\":3,\"key\":\"目的主机名(destHostName)\",\"name\":\"目的主机名\",\"value\":\"destHostName\"},{\"index\":4,\"key\":\"攻击者(attacker)\",\"name\":\"攻击者\",\"value\":\"attacker\"},{\"index\":5,\"key\":\"安全告警威胁等级(threatSeverity)\",\"name\":\"安全告警威胁等级\",\"value\":\"threatSeverity\"}]}', NULL, '系统站点存在webshell网页木马。\r\nwebshel网页木马就是以asp、php、jsp或者cgi脚本木马后门。黑客在入侵了一个网站后，常常会在将这些 asp或php木马后门文件放置在网站服务器的web目录中，与正常的网页文件混在一起。然后黑客就可以用web的方式，通过asp或php木马后门控制网站服务器，包括上传下载编辑以及篡改网站文件代码、查看数据库、执行任意程序命令拿到服务器权限等。', '1、在服务器上找到并删除Webshell后门文件。', 6, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template" VALUES ('defaultBuildInTemplateWebVisit', 'WEB访问', 'defaultBuildInRetrievalLogTemplateGroup', '\"build_in\"', 0000000004, 'security_logs', '[{\"key\": \"log\", \"name\": \"日志\", \"value\": false}, {\"key\": \"flow\", \"name\": \"流量\", \"value\": false}]', 'logType == \"http\"', '[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"requestMethod\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求方法\",\"key\":\"请求方法(requestMethod)\"},{\"en\":\"destHostName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"目的主机名\",\"key\":\"目的主机名(destHostName)\"},{\"en\":\"requestUrl\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"URL\",\"key\":\"URL(requestUrl)\"},{\"en\":\"responseCode\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求响应码\",\"key\":\"请求响应码(responseCode)\"},{\"en\":\"bytesIn\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"请求流量\",\"key\":\"请求流量(bytesIn)\"},{\"en\":\"bytesOut\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"响应流量\",\"key\":\"响应流量(bytesOut)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}]', '{}', NULL, NULL, NULL, '', '', 3, 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');

-- Indexes
CREATE UNIQUE INDEX "unique_groupId_templateName" ON "t_query_template" ("groupId", "templateName");

-- Column comments
COMMENT ON COLUMN "t_query_template"."id" IS '唯一ID';
COMMENT ON COLUMN "t_query_template"."templateName" IS '模板名称';
COMMENT ON COLUMN "t_query_template"."groupId" IS '分组id';
COMMENT ON COLUMN "t_query_template"."source" IS '模板来源，build-in：内置；custom：自定义；fileInput：文件导入；other：其他';
COMMENT ON COLUMN "t_query_template"."saveType" IS '保存的模板内容类型，4-检索，2-可视化，1-聚合，多种内容则进行与运算，如：6-检索+可视化';
COMMENT ON COLUMN "t_query_template"."dataSource" IS '数据源(根据数据字典分类)';
COMMENT ON COLUMN "t_query_template"."indexOptions" IS '索引选项，与数据源以及时间范围配合定位具体检索的索引';
COMMENT ON COLUMN "t_query_template"."query" IS '查询语句';
COMMENT ON COLUMN "t_query_template"."retrievalFields" IS '检索字段';
COMMENT ON COLUMN "t_query_template"."moreOptions" IS '可选项条件(必须数据字典存在的字段)，key-字典字段，value-字典字段对应枚举值信息';
COMMENT ON COLUMN "t_query_template"."visualization" IS '可视化条件详情，含可视化的样式条件';
COMMENT ON COLUMN "t_query_template"."aggregation" IS '聚合条件详情，含聚合字段';
COMMENT ON COLUMN "t_query_template"."timeRange" IS '时间字段';
COMMENT ON COLUMN "t_query_template"."description" IS '描述';
COMMENT ON COLUMN "t_query_template"."suggestion" IS '建议';
COMMENT ON COLUMN "t_query_template"."orderNumber" IS '排序字段';
COMMENT ON COLUMN "t_query_template"."is_top" IS '是否置顶';
COMMENT ON COLUMN "t_query_template"."createTime" IS '创建时间';
COMMENT ON COLUMN "t_query_template"."updateTime" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_query_template_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updateTime" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_query_template_update_timestamp
BEFORE UPDATE ON "t_query_template"
FOR EACH ROW
EXECUTE FUNCTION update_t_query_template_timestamp();


DROP TABLE IF EXISTS "t_query_template_group";
CREATE TABLE "t_query_template_group"  (
  "id" VARCHAR(100)   NOT NULL DEFAULT '',
  "userId" INTEGER NOT NULL,
  "groupName" VARCHAR(150)   NOT NULL,
  "dataSource" VARCHAR(50)   NOT NULL,
  "source" VARCHAR(50)   NOT NULL DEFAULT 'custom',
  "description" TEXT   NULL,
  "orderNumber" INTEGER NOT NULL,
  "createTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updateTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_query_template_group" VALUES ('defaultBuildInConfigAlarmTemplateGroup', 0, '', 'security_alarms', '\"build_in_config\"', '', 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template_group" VALUES ('defaultBuildInConfigEventTemplateGroup', 0, '', 'security_events', '\"build_in_config\"', '', 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template_group" VALUES ('defaultBuildInConfigLogTemplateGroup', 0, '', 'security_logs', '\"build_in_config\"', '', 0, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template_group" VALUES ('defaultBuildInConfigMergeAlarmTemplateGroup', 0, ' ', 'merge_alarms', '\"build_in_config\"', '', 0, '2026-01-13 10:37:48', '2026-01-13 10:37:48');,
  INSERT INTO "t_query_template_group" VALUES ('defaultBuildInRetrievalAlarmTemplateGroup', 0, '安全事件', 'security_alarms', '\"build_in\"', '', 2, '2026-01-13 10:37:43', '2026-01-13 10:37:48');,
  INSERT INTO "t_query_template_group" VALUES ('defaultBuildInRetrievalLogTemplateGroup', 0, '分析场景', 'security_logs', '\"build_in\"', '', 2, '2026-01-13 10:37:43', '2026-01-13 10:37:48');,
  INSERT INTO "t_query_template_group" VALUES ('defaultGroupBuildInAlarmSceneTemplateGroup', 0, '查询场景', 'security_alarms', '\"build_in\"', NULL, 1, '2023-05-08 16:22:30', '2023-05-08 16:22:30');,
  INSERT INTO "t_query_template_group" VALUES ('defaultGroupBuildInLogSceneTemplateGroup', 0, '查询场景', 'security_logs', '\"build_in\"', NULL, 1, '2023-05-08 16:22:30', '2023-05-08 16:22:30');,
  INSERT INTO "t_query_template_group" VALUES ('defaultGroupBuildInRetrievalAlarmTemplateGroup', 0, '默认', 'security_alarms', '\"build_in\"', '', 3, '2026-01-13 10:37:43', '2026-01-13 10:37:48');,
  INSERT INTO "t_query_template_group" VALUES ('defaultGroupBuildInRetrievalEventTemplateGroup', 0, '默认', 'security_events', '\"build_in\"', '', 1, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_query_template_group" VALUES ('defaultGroupBuildInRetrievalLogTemplateGroup', 0, '默认', 'security_logs', '\"build_in\"', '', 3, '2026-01-13 10:37:43', '2026-01-13 10:37:48');

-- Indexes
CREATE UNIQUE INDEX "unique_userId_dataSource_groupName" ON "t_query_template_group" ("userId", "dataSource", "groupName");

-- Column comments
COMMENT ON COLUMN "t_query_template_group"."id" IS '唯一ID';
COMMENT ON COLUMN "t_query_template_group"."userId" IS '用户id';
COMMENT ON COLUMN "t_query_template_group"."groupName" IS '分组名称：分析场景-出厂默认的存在的分组，不可删除，不可编辑';
COMMENT ON COLUMN "t_query_template_group"."dataSource" IS '检索模块：alarm-告警、log-日志';
COMMENT ON COLUMN "t_query_template_group"."source" IS '分组来源，内置：built-in；自定义：custom；文件导入：fileInput；其他：other；…';
COMMENT ON COLUMN "t_query_template_group"."description" IS '描述';
COMMENT ON COLUMN "t_query_template_group"."orderNumber" IS '排序';
COMMENT ON COLUMN "t_query_template_group"."createTime" IS '创建时间';
COMMENT ON COLUMN "t_query_template_group"."updateTime" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_query_template_group_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updateTime" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_query_template_group_update_timestamp
BEFORE UPDATE ON "t_query_template_group"
FOR EACH ROW
EXECUTE FUNCTION update_t_query_template_group_timestamp();


DROP TABLE IF EXISTS "t_region";
CREATE TABLE "t_region"  (
  "code" VARCHAR(8)   NOT NULL,
  "name" VARCHAR(64)   NOT NULL,
  "x_axis" VARCHAR(32)   NULL DEFAULT NULL,
  "y_axis" VARCHAR(32)   NULL DEFAULT NULL,
  PRIMARY KEY ("code")
);

-- Column comments
COMMENT ON COLUMN "t_region"."code" IS '区域代码';
COMMENT ON COLUMN "t_region"."name" IS '区域名称';


DROP TABLE IF EXISTS "t_rel_report_form";
CREATE TABLE "t_rel_report_form"  (
  "id" VARCHAR(50)   NOT NULL,
  "report_id" VARCHAR(50)   NULL DEFAULT NULL,
  "form_id" VARCHAR(36)   NOT NULL,
  "form_order" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_rel_report_form" VALUES ('00a149457801410fb30454b0498107751532395901', 'c1001d868e1f11e8ad150242487600161532312766', 'c7643c7a-8e1d-11e8-ad15-024248760016', 1);,
  INSERT INTO "t_rel_report_form" VALUES ('03ba10ef657b4637a39c55dd44835f9b1532395901', 'c1001d868e1f11e8ad150242487600161532312766', '52427d82-8e1f-11e8-ad15-024248760016', 9);,
  INSERT INTO "t_rel_report_form" VALUES ('3ccaef296e81450db6c46d561e394c601532395901', 'c1001d868e1f11e8ad150242487600161532312766', '09f82a23-8e1f-11e8-ad15-024248760016', 6);,
  INSERT INTO "t_rel_report_form" VALUES ('508bcad469e94f0a8f7ca426a238af191532395901', 'c1001d868e1f11e8ad150242487600161532312766', '22f2e651-8e1e-11e8-ad15-024248760016', 7);,
  INSERT INTO "t_rel_report_form" VALUES ('618fed08c24448cd8bf6a66fd1ac48301532395901', 'c1001d868e1f11e8ad150242487600161532312766', 'f47a59fb-8e1d-11e8-ad15-024248760016', 2);,
  INSERT INTO "t_rel_report_form" VALUES ('6b7bfa01027146a3815c95334e430c9b1532395901', 'c1001d868e1f11e8ad150242487600161532312766', 'e8f9301e-8e1e-11e8-ad15-024248760016', 3);,
  INSERT INTO "t_rel_report_form" VALUES ('75d6e9f10d854c4f9cbc441b7805847c1532395901', 'c1001d868e1f11e8ad150242487600161532312766', '6b379605-8e1e-11e8-ad15-024248760016', 4);,
  INSERT INTO "t_rel_report_form" VALUES ('a3eccff0a477499091d213414db58f4a1532395901', 'c1001d868e1f11e8ad150242487600161532312766', '2e158070-8e1f-11e8-ad15-024248760016', 8);,
  INSERT INTO "t_rel_report_form" VALUES ('fe0433064960404fb5ea5540b0c5235b1532395901', 'c1001d868e1f11e8ad150242487600161532312766', 'b41d420f-8e1e-11e8-ad15-024248760016', 5);

-- Indexes
CREATE UNIQUE INDEX "index_report_form_uni" ON "t_rel_report_form" ("report_id", "form_id");

DROP TABLE IF EXISTS "t_rel_report_tag";
CREATE TABLE "t_rel_report_tag"  (
  "id" VARCHAR(50)   NOT NULL,
  "report_id" VARCHAR(50)   NULL DEFAULT NULL,
  "tag_id" VARCHAR(50)   NULL DEFAULT NULL,
  "tag_order" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "Index_report_tag_uni" ON "t_rel_report_tag" ("report_id", "tag_id");

-- Column comments
COMMENT ON COLUMN "t_rel_report_tag"."tag_order" IS '标签顺序';


DROP TABLE IF EXISTS "t_report_center_report";
CREATE TABLE "t_report_center_report"  (
  "id" VARCHAR(50)   NOT NULL,
  "report_name" VARCHAR(100)   NOT NULL,
  "description" VARCHAR(300)   NOT NULL,
  "create_user" VARCHAR(50)   NULL DEFAULT NULL,
  "create_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "last_modified_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_factory_setting" SMALLINT NOT NULL,
  "is_show_desc" SMALLINT NOT NULL DEFAULT 1,
  "is_show_form" SMALLINT NOT NULL DEFAULT 1,
  "code" VARCHAR(50)   NOT NULL,
  "support_file_type" text   NOT NULL,
  "configuration_level" VARCHAR(50)   NOT NULL DEFAULT 'general',
  "ext_code" VARCHAR(100)   NOT NULL DEFAULT 'mirror',
  "is_enable" BOOLEAN NOT NULL DEFAULT 1,
  "permission" VARCHAR(100)   NULL DEFAULT 'mirror:menu:ReportManage',
  PRIMARY KEY ("id")
);
  INSERT INTO "t_report_center_report" VALUES ('0489a693c43a11eb86d80242487601161622703902', '风险资产报告', '风险资产报告', 'admin', '2021-01-01 00:00:00', '2021-01-01 00:00:00', 0, 1, 1, 'riskyAssets', '{\"excel\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"word\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false}}', 'none', 'mirror', 1, 'mirror:menu:ReportManage');,
  INSERT INTO "t_report_center_report" VALUES ('5445bb0cba4411e8b3050050569a240c1537166326', '深度威胁分析报告', '对安全告警进行深度分析，从多种角度进行深度分析，从不同的攻击方向进行深度分析，分析数据完整性、资产态势、攻击源感知态势及重点告警问题，给具体取证信息及处置建议。', 'admin', '2018-01-01 00:00:00', '2018-01-01 00:00:00', 0, 1, 1, 'deepThreat', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"word\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false}}', 'general', 'mirror', 1, 'mirror:menu:ReportManage');,
  INSERT INTO "t_report_center_report" VALUES ('7b818e97-75a6-4e62-8634-56b6e7552b15', '挖矿分析报告', 'AXDR高级威胁检测与分析系统从挖矿告警分布、挖矿生命阶段周期等多个方面进行评估分析，帮助用户了解当前企业面临挖矿风险，及时进行处置修复。', 'admin', '2026-01-13 10:37:47', '2026-01-13 10:37:47', 0, 1, 1, 'miningAnalysis', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"word\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false}}', 'intermediate', 'mirror', 1, 'mirror:menu:ReportManage');,
  INSERT INTO "t_report_center_report" VALUES ('c1001d868e1f11e8ad150242487600161532312766', '内网安全威胁', '展示内网威胁信息，包括各种威胁的分布，和对目标地址的访问趋势，回连，挖矿，勒索等威胁的目标地址分布等信息', 'admin', '2018-07-23 10:26:09', '2018-07-24 09:31:41', 1, 1, 1, 'intranetThreat', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":true,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":true,\"canEditOnline\":false},\"word\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false}}', 'general', 'mirror', 1, 'mirror:menu:ReportManage');,
  INSERT INTO "t_report_center_report" VALUES ('f407a283c40f11eb86d80242487601161622685836', '平台运营简报', '%s采集全网安全数据，从安全风险事件、安全运营成果、平台运行状态等多个方面，进行超过100项的检测和分析，为客户提供一目了然的综合安全风险态势简报和专家建议指导，帮助客户快速了解网络安全态势。', 'admin', '2021-06-01 00:00:00', '2021-06-01 00:00:00', 0, 1, 1, 'operationBrief', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":true},\"word\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false}}', 'advanced', 'mirror', 1, 'mirror:menu:ReportManage');,
  INSERT INTO "t_report_center_report" VALUES ('fbb5bd28c40a11eb86d80242487601161622683701', '安全分析运营报告', '%s采集全网安全数据，聚焦企业安全风险，对勒索病毒、弱口令、外部入侵等30余项常见重点安全事件进行专项分析，提供详细的安全事件分析溯源取证信息及专家处置建议指导，帮助用户洞察网络安全态势', 'admin', '2021-06-01 00:00:00', '2021-06-01 00:00:00', 0, 1, 1, 'safetyAnalysis', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"word\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false}}', 'advanced', 'mirror', 1, 'mirror:menu:ReportManage');,
  INSERT INTO "t_report_center_report" VALUES ('MINER', '挖矿活动场景分析报告', 'AXDR高级威胁检测与分析系统挖矿活动专项分析报告旨在提供详尽的挖矿活动洞察，帮助识别挖矿主机的漏洞、暴露端口及告警情况，并提供针对性的处置建议', 'admin', '2026-01-13 10:37:49', '2026-01-13 10:37:49', 0, 1, 1, 'miner', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"word\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false}}', 'intermediate', 'mirror', 1, 'mirror:menu:ThreatScene');,
  INSERT INTO "t_report_center_report" VALUES ('RANSOMWARE', '勒索病毒场景分析报告', 'AXDR高级威胁检测与分析系统勒索病毒专项分析报告旨在提供详尽的病毒勒索洞察，帮助识别风险主机及风险主机的漏洞、暴露端口及其他告警情况，并提供针对性的处置建议', 'admin', '2026-01-13 10:37:49', '2026-01-13 10:37:49', 0, 1, 1, 'ransomware', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"word\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false}}', 'intermediate', 'mirror', 1, 'mirror:menu:ThreatScene');,
  INSERT INTO "t_report_center_report" VALUES ('RISK', '安全事件分析报告', '对当日的安全事件进行专项分析，内容涵盖安全事件解读，安全事件场景详情描述；关注IP的告警关联分析以及安全事件关联分析；最后给出安全事件的具象化处置建议以及最终总结评价。', 'admin', '2026-01-13 10:37:50', '2026-01-13 10:37:50', 0, 1, 1, 'risk', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"word\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false}}', 'intermediate', 'mirror', 1, 'xdr:menu:RiskList-Edit');,
  INSERT INTO "t_report_center_report" VALUES ('SQL_INJECTION', 'SQL注入场景分析报告', 'AXDR高级威胁检测与分析系统SQL注入专项分析报告旨在提供详尽的SQL注入攻击洞察，帮助识别潜在威胁、评估漏洞利用情况，并提供针对性的处置建议', 'admin', '2026-01-13 10:37:48', '2026-01-13 10:37:49', 0, 1, 1, 'sqlInjection', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"word\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false}}', 'intermediate', 'mirror', 1, 'mirror:menu:ThreatScene');,
  INSERT INTO "t_report_center_report" VALUES ('UNAUTHORIZED_ACCESS', '未授权访问场景分析报告', 'AXDR高级威胁检测与分析系统未授权访问专项分析报告旨在提供详尽的未授权访问资产，帮助识别未授权访问入口、访问者详情及其他告警情况', 'admin', '2026-01-13 10:37:49', '2026-01-13 10:37:49', 0, 1, 1, 'unauthAccess', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"word\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false}}', 'intermediate', 'mirror', 1, 'mirror:menu:ThreatScene');,
  INSERT INTO "t_report_center_report" VALUES ('WEAK_PASSWORD', '弱口令场景分析报告', 'AXDR高级威胁检测与分析系统弱口令专项分析报告旨在提供详尽的弱口令资产，帮助识别脆弱认证点、登录者详情及其他告警情况', 'admin', '2026-01-13 10:37:49', '2026-01-13 10:37:49', 0, 1, 1, 'weakPassword', '{\"excel\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"pdf\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"html\":{\"isDefault\":false,\"isSupport\":false,\"canEditOnline\":false},\"word\":{\"isDefault\":true,\"isSupport\":true,\"canEditOnline\":false}}', 'intermediate', 'mirror', 1, 'mirror:menu:ThreatScene');

-- Indexes
CREATE UNIQUE INDEX "index_report_center_name_uni" ON "t_report_center_report" ("report_name");

-- Column comments
COMMENT ON COLUMN "t_report_center_report"."report_name" IS '报告名称';
COMMENT ON COLUMN "t_report_center_report"."description" IS '报告描述';
COMMENT ON COLUMN "t_report_center_report"."create_user" IS '创建人';
COMMENT ON COLUMN "t_report_center_report"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_report_center_report"."last_modified_time" IS '最后更新时间';
COMMENT ON COLUMN "t_report_center_report"."is_factory_setting" IS '是否出厂后报告';
COMMENT ON COLUMN "t_report_center_report"."is_show_desc" IS '是否显示描述';
COMMENT ON COLUMN "t_report_center_report"."is_show_form" IS '是否显示报表数据';
COMMENT ON COLUMN "t_report_center_report"."code" IS '报告类型code：平台运营简报operationBrief；安全分析运营报告safetyAnalysis；深度威胁分析报告deepThreat；风险资产报告riskyAssets；内网安全威胁intranetThreat；自定义报告customReport';
COMMENT ON COLUMN "t_report_center_report"."support_file_type" IS '支持的报告导出文件类型、默认格式、是否支持在线编辑。（JSON对象）';
COMMENT ON COLUMN "t_report_center_report"."configuration_level" IS '可配置等级，分别为无配置、普通配置、中级配置、高级配置，分别对应none、general、intermediate、advanced';
COMMENT ON COLUMN "t_report_center_report"."ext_code" IS '报告所属拓展code';
COMMENT ON COLUMN "t_report_center_report"."is_enable" IS '是否生效';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_report_center_report_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."last_modified_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_report_center_report_update_timestamp
BEFORE UPDATE ON "t_report_center_report"
FOR EACH ROW
EXECUTE FUNCTION update_t_report_center_report_timestamp();


DROP TABLE IF EXISTS "t_report_form";
CREATE TABLE "t_report_form"  (
  "id" VARCHAR(36)   NOT NULL,
  "name" VARCHAR(1000)   NULL DEFAULT NULL,
  "describe_msg" VARCHAR(10000)   NULL DEFAULT NULL,
  "target_name" VARCHAR(1000)   NULL DEFAULT NULL,
  "chart_type" VARCHAR(45)   NULL DEFAULT NULL,
  "metric_id" VARCHAR(45)   NULL DEFAULT NULL,
  "group_by" VARCHAR(1000)   NULL DEFAULT NULL,
  "top_size" VARCHAR(20)   NULL DEFAULT NULL,
  "order_by" VARCHAR(20)   NULL DEFAULT NULL,
  "create_time" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_report_form" VALUES ('07d3663e-748e-11ea-9d6c-024248760016', '互联网攻击源清单_关注互联网攻击者和攻击手段', '互联网攻击源清单_关注互联网攻击者和攻击手段', 'hw报告', '2_distri_list', 'outSrcAddressAttackCount', 'srcAddress,alarmName', '20,5', 'desc,desc', '2020-04-02 02:59:55');,
  INSERT INTO "t_report_form" VALUES ('09f82a23-8e1f-11e8-ad15-024248760016', '回连目标地址分布趋势', '回连地址访问次数随时间变化关系图\n', '内网安全威胁', '2_time_line', 'innerReconDestAddressCount', 'destAddress', '10', 'desc', '2018-07-22 18:20:59');,
  INSERT INTO "t_report_form" VALUES ('0af41832-74af-11ea-9d6c-024248760016', '流量协议分布', '原始流量中的协议占比', '安全数据质量', '1_distri_pie', 'sumAppProtocol', 'appProtocol', '20', 'desc', '2020-04-02 06:56:14');,
  INSERT INTO "t_report_form" VALUES ('22f2e651-8e1e-11e8-ad15-024248760016', '告警类型趋势', '不同告警类型随时间变化\n', '内网安全威胁', '2_time_line', 'innerAlertTypeCount', 'name', '10', 'desc', '2018-07-22 18:14:32');,
  INSERT INTO "t_report_form" VALUES ('24579617-74af-11ea-9d6c-024248760016', '安全数据来源分布', '安全数据来源分布', '安全数据质量', '1_distri_bar', 'logGroupByDeviceType', 'deviceProductType', '20', 'desc', '2020-04-02 06:56:56');,
  INSERT INTO "t_report_form" VALUES ('2bbdbbac-74ac-11ea-9d6c-024248760016', '远控行为分析_关注资产和被控制行为', '远控行为分析_关注资产和被控制行为', 'hw报告', '2_distri_list', 'remoteControlSrcAddressCount', 'srcAddress,alarmName', '20,5', 'desc,desc', '2020-04-02 06:35:40');,
  INSERT INTO "t_report_form" VALUES ('2e158070-8e1f-11e8-ad15-024248760016', '挖矿目标地址分布趋势', '挖矿目标地址访问次数随时间变化关系图\n', '内网安全威胁', '2_time_line', 'innerCoinDestAddressCount', 'destAddress', '10', 'desc', '2018-07-22 18:22:00');,
  INSERT INTO "t_report_form" VALUES ('41b681e6-748b-11ea-9d6c-024248760016', '互联网威胁占比', '互联网威胁占比', 'hw报告', '2_distri_ring', 'outCategoryCount', 'category,subCategory', '10,50', 'desc,desc', '2020-04-02 02:40:03');,
  INSERT INTO "t_report_form" VALUES ('4a4f3fc4-7575-11ea-9d6c-024248760016', '原始日志趋势', '原始日志趋势', '安全数据质量', '1_time_line', 'countLog', '', '', '', '2020-04-03 06:35:20');,
  INSERT INTO "t_report_form" VALUES ('52427d82-8e1f-11e8-ad15-024248760016', '勒索目标地址分布趋势', '勒索目标地址访问次数随时间变化关系图\n', '内网安全威胁', '2_time_line', 'innerRansomDestAddressCount', 'destAddress', '10', 'desc', '2018-07-22 18:23:01');,
  INSERT INTO "t_report_form" VALUES ('6b379605-8e1e-11e8-ad15-024248760016', '告警类型来源地址分布', '不同告警类型数占总告警数的比例和相同告警类型中不同来源地址的告警数所占比例\n', '内网安全威胁', '2_distri_horizBar', 'innerAlertTypeSrcAddressCount', 'name,srcAddress', '10,10', 'desc,desc', '2018-07-22 18:16:33');,
  INSERT INTO "t_report_form" VALUES ('7f1d2176-740e-11ea-9d6c-024248760016', '原始告警趋势', '原始告警趋势', 'hw报告,安全数据质量', '2_time_bar', 'securityAlarmSeverityCount', 'threatSeverity', '5', 'desc', '2020-04-01 11:46:59');,
  INSERT INTO "t_report_form" VALUES ('963cb774-740e-11ea-9d6c-024248760016', '告警总数', '告警总数', 'hw报告', '1_bigWord_bigWord', 'securiityAlarmCount', '', '', '', '2020-04-01 11:47:38');,
  INSERT INTO "t_report_form" VALUES ('acae5fcc-740e-11ea-9d6c-024248760016', '攻击拦截趋势', '攻击拦截趋势', 'hw报告', '1_time_line', 'deviceBlockLogCount', '', '', '', '2020-04-01 11:48:16');,
  INSERT INTO "t_report_form" VALUES ('af3bf562-7579-11ea-9d6c-024248760016', '流量发起方向分布', '流量发起方向分布', '内网安全威胁', '1_distri_pie', 'logGroupByDirection', 'direction', '5', 'desc', '2020-04-03 07:06:47');,
  INSERT INTO "t_report_form" VALUES ('b41d420f-8e1e-11e8-ad15-024248760016', '告警类型目标地址分布', '不同告警类型数占总告警数的比例和相同告警类型中不同目标地址的告警数所占比例\n', '内网安全威胁', '2_distri_horizBar', 'innerAlertTypeDestAddressCount', 'name,destAddress', '10,10', 'desc,desc', '2018-07-22 18:18:35');,
  INSERT INTO "t_report_form" VALUES ('c222db48-740e-11ea-9d6c-024248760016', '阻断总数', '阻断总数', 'hw报告', '1_bigWord_bigWord', 'deviceBlockLogCount', '', '', '', '2020-04-01 11:48:52');,
  INSERT INTO "t_report_form" VALUES ('c507b8bc-7579-11ea-9d6c-024248760016', 'HTTP 状态码分布', 'HTTP 状态码分布', '内网安全威胁', '1_distri_ring', 'responseCodeCount', 'responseCode', '20', 'desc', '2020-04-03 07:07:24');,
  INSERT INTO "t_report_form" VALUES ('c7643c7a-8e1d-11e8-ad15-024248760016', '告警类型分布', '不同告警类型分布图\n', '内网安全威胁', '1_distri_pie', 'innerAlertTypeCount', 'name', '10', 'desc', '2018-07-22 18:11:58');,
  INSERT INTO "t_report_form" VALUES ('caf2158f-74ad-11ea-9d6c-024248760016', '内部威胁占比', '内部威胁占比', 'hw报告', '2_distri_ring', 'inCategoryCount', 'category,subCategory', '10,50', 'desc,desc', '2020-04-02 06:47:17');,
  INSERT INTO "t_report_form" VALUES ('d94e7e21-78af-11ea-9d6c-024248760016', '邮件钓鱼行为分析_关注邮件主题和收件人', '邮件钓鱼行为分析_关注邮件主题和收件人', 'hw报告', '2_distri_list', 'maliciousMailCount', 'mailTitle,srcUserName', '10,5', 'desc,desc', '2020-04-07 09:12:04');,
  INSERT INTO "t_report_form" VALUES ('e5dbb68b-78a1-11ea-9d6c-024248760016', '重点场景分析_关注内网攻击者和攻击手段', '重点场景分析_关注内网攻击者和攻击手段', 'hw报告', '2_distri_list', 'keyModelCount', 'srcAddress,alarmName', '20,5', 'desc,desc', '2020-04-07 07:32:12');,
  INSERT INTO "t_report_form" VALUES ('e8f9301e-8e1e-11e8-ad15-024248760016', '告警目标来源地址分布', '来源地址与目标地址的关系\n', '内网安全威胁', '2_distri_bar', 'innerAlertDestAddressSrcAddressCount', 'srcAddress,destAddress', '10,10', 'desc,desc', '2018-07-22 18:20:04');,
  INSERT INTO "t_report_form" VALUES ('f21bd775-7579-11ea-9d6c-024248760016', '异地访问来源分布', '异地访问来源分布', '内网安全威胁', '1_distri_bar', 'logSrcGeoCityCount', 'srcGeoCity', '10', 'desc', '2020-04-03 07:08:40');,
  INSERT INTO "t_report_form" VALUES ('f47a59fb-8e1d-11e8-ad15-024248760016', '告警数量趋势', '不同时间段内告警数量总数变化情况\n', '内网安全威胁', '1_time_line', 'innerAlertCount', '', '', '', '2018-07-22 18:13:14');

-- Column comments
COMMENT ON COLUMN "t_report_form"."id" IS 'uuid,确保全局唯一性';
COMMENT ON COLUMN "t_report_form"."name" IS '表单名称';
COMMENT ON COLUMN "t_report_form"."describe_msg" IS '描述';
COMMENT ON COLUMN "t_report_form"."target_name" IS '标签名称，多个逗号分隔';
COMMENT ON COLUMN "t_report_form"."chart_type" IS '图表类型';
COMMENT ON COLUMN "t_report_form"."metric_id" IS '关联的统计指标id';
COMMENT ON COLUMN "t_report_form"."group_by" IS '分组统计字段，逗号分隔';
COMMENT ON COLUMN "t_report_form"."top_size" IS 'groupBy字段取topN,多个分组字段逗号分隔';
COMMENT ON COLUMN "t_report_form"."order_by" IS '逆序desc、正序asc，多个字段逗号分隔';


DROP TABLE IF EXISTS "t_report_history";
CREATE TABLE "t_report_history"  (
  "id" BIGSERIAL,
  "report_job_id" BIGINT NOT NULL,
  "report_name" VARCHAR(100)   NOT NULL,
  "report_data" TEXT   NULL,
  "file_uuid" VARCHAR(100)   NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_report_history"."id" IS '主键id';
COMMENT ON COLUMN "t_report_history"."report_job_id" IS '报告任务id';
COMMENT ON COLUMN "t_report_history"."report_name" IS '报告名称';
COMMENT ON COLUMN "t_report_history"."report_data" IS '报告数据，用于预览编辑，json存储';
COMMENT ON COLUMN "t_report_history"."file_uuid" IS '导出报告文件uuid';
COMMENT ON COLUMN "t_report_history"."create_time" IS '创建时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_report_history_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."create_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_report_history_update_timestamp
BEFORE UPDATE ON "t_report_history"
FOR EACH ROW
EXECUTE FUNCTION update_t_report_history_timestamp();


DROP TABLE IF EXISTS "t_report_job";
CREATE TABLE "t_report_job"  (
  "id" BIGSERIAL,
  "report_id" VARCHAR(50)   NOT NULL,
  "report_name" VARCHAR(500)   NULL DEFAULT NULL,
  "start_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "end_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "top" INTEGER NOT NULL DEFAULT 0,
  "file_type" VARCHAR(20)   NOT NULL,
  "is_report_name_default" BOOLEAN NOT NULL DEFAULT 0,
  "data_scope" VARCHAR(20)   NULL DEFAULT NULL,
  "scope_config" text   NULL,
  "threat_severity" VARCHAR(100)   NULL DEFAULT NULL,
  "alarm_status" VARCHAR(100)   NULL DEFAULT NULL,
  "attack_result" VARCHAR(100)   NULL DEFAULT NULL,
  "query_ql" text   NULL,
  "chapter_config" text   NULL,
  "file_uuid" VARCHAR(100)   NULL DEFAULT NULL,
  "user_id" BIGINT NOT NULL,
  "report_source" VARCHAR(20)   NOT NULL,
  "generate_cycle" VARCHAR(20)   NOT NULL,
  "report_content" VARCHAR(150)   NULL DEFAULT NULL,
  "status" VARCHAR(20)   NOT NULL,
  "progress" INTEGER UNSIGNED NOT NULL DEFAULT 0,
  "last_history_id" BIGINT NULL DEFAULT NULL,
  "can_edit_online" BOOLEAN NOT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "other_params" text   NULL,
  "is_enable" BOOLEAN NOT NULL DEFAULT 1,
  "with_ai" SMALLINT NULL DEFAULT 0,
  "event_code" VARCHAR(500)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  "SET" FOREIGN_KEY_CHECKS = 1;

-- Indexes
CREATE INDEX "t_report_job_report_id_IDX" ON "t_report_job" ("report_id");

-- Column comments
COMMENT ON COLUMN "t_report_job"."id" IS '主键id';
COMMENT ON COLUMN "t_report_job"."report_id" IS '报告id';
COMMENT ON COLUMN "t_report_job"."start_time" IS '开始时间';
COMMENT ON COLUMN "t_report_job"."end_time" IS '结束时间';
COMMENT ON COLUMN "t_report_job"."top" IS '显示TOP';
COMMENT ON COLUMN "t_report_job"."file_type" IS '导出文件类型';
COMMENT ON COLUMN "t_report_job"."is_report_name_default" IS '是否默认报告名称';
COMMENT ON COLUMN "t_report_job"."data_scope" IS '业务范围';
COMMENT ON COLUMN "t_report_job"."scope_config" IS '业务范围配置';
COMMENT ON COLUMN "t_report_job"."threat_severity" IS '风险级别';
COMMENT ON COLUMN "t_report_job"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_report_job"."attack_result" IS '攻击结果';
COMMENT ON COLUMN "t_report_job"."query_ql" IS 'AiQL，其他查询条件';
COMMENT ON COLUMN "t_report_job"."chapter_config" IS '章节配置，json存储';
COMMENT ON COLUMN "t_report_job"."file_uuid" IS '报告文件uuid';
COMMENT ON COLUMN "t_report_job"."user_id" IS '创建用户';
COMMENT ON COLUMN "t_report_job"."report_source" IS '报告来源，manual：手动，subscribe：订阅';
COMMENT ON COLUMN "t_report_job"."generate_cycle" IS '统计周期，day，week，month';
COMMENT ON COLUMN "t_report_job"."report_content" IS '报告数据内容';
COMMENT ON COLUMN "t_report_job"."status" IS '报告状态，waiting：等待生成，generating：生成中，success：生成成功，failure：生成失败';
COMMENT ON COLUMN "t_report_job"."progress" IS '报告生成进度';
COMMENT ON COLUMN "t_report_job"."last_history_id" IS '最新报告历史id';
COMMENT ON COLUMN "t_report_job"."can_edit_online" IS '是否可在线编辑';
COMMENT ON COLUMN "t_report_job"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_report_job"."other_params" IS '其他参数，用于兼容所有非正常报告类型参数。使用json保存';
COMMENT ON COLUMN "t_report_job"."is_enable" IS '是否失效';
COMMENT ON COLUMN "t_report_job"."with_ai" IS '是否ai参与';


-- Enable foreign key checks
SET session_replication_role = 'origin';

-- Update sequences
-- Run after data import:
-- SELECT setval(pg_get_serial_sequence('table_name', 'id_column'), (SELECT MAX(id_column) FROM table_name));
