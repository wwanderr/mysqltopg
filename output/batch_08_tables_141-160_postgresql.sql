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


DROP TABLE IF EXISTS "t_report_tags";
CREATE TABLE "t_report_tags"  (
  "id" VARCHAR(50)   NOT NULL,
  "tag_name" VARCHAR(100)   NOT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "index_report_tag_name_uni" ON "t_report_tags" ("tag_name");

-- Column comments
COMMENT ON COLUMN "t_report_tags"."tag_name" IS '标签名称';


DROP TABLE IF EXISTS "t_risk_template";
CREATE TABLE "t_risk_template"  (
  "id" SERIAL,
  "mode" VARCHAR(32)   NOT NULL,
  "data_source" VARCHAR(32)   NOT NULL,
  "rule_type" VARCHAR(32)   NULL DEFAULT NULL,
  "code" INTEGER NULL DEFAULT NULL,
  "uniq_code" VARCHAR(128)   NOT NULL,
  "name" VARCHAR(128)   NOT NULL,
  "event_type" VARCHAR(128)   NULL DEFAULT NULL,
  "top_event_type" VARCHAR(128)   NULL DEFAULT NULL,
  "top_event_type_chinese" VARCHAR(128)   NULL DEFAULT NULL,
  "second_event_type" VARCHAR(128)   NULL DEFAULT NULL,
  "second_event_type_chinese" VARCHAR(128)   NULL DEFAULT NULL,
  "filter_ip" VARCHAR(32)   NULL DEFAULT NULL,
  "filter_content" VARCHAR(512)   NULL DEFAULT NULL,
  "desc" TEXT   NULL,
  "suggest" TEXT   NULL,
  "child_desc" TEXT   NULL,
  "priority" SMALLINT NULL DEFAULT NULL,
  "threat_severity" VARCHAR(512)   NULL DEFAULT NULL,
  "alarm_results" VARCHAR(512)   NULL DEFAULT NULL,
  "enable" BOOLEAN NULL DEFAULT NULL,
  "update_time" TIMESTAMP NULL DEFAULT NULL,
  "filter_content_aiql" VARCHAR(1000)   NULL DEFAULT NULL,
  "netflow_log_field" VARCHAR(1000)   NULL DEFAULT NULL,
  "host_log_field" VARCHAR(1000)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "t_risk_template_UN" ON "t_risk_template" ("uniq_code");

-- Column comments
COMMENT ON COLUMN "t_risk_template"."id" IS '主键id';
COMMENT ON COLUMN "t_risk_template"."mode" IS '生成模式：simple-简单,balance-平衡,enhance-增强';
COMMENT ON COLUMN "t_risk_template"."data_source" IS '数据源：alert-告警,incident-安全事件';
COMMENT ON COLUMN "t_risk_template"."rule_type" IS '告警规则类型：specific-具体,base-基本';
COMMENT ON COLUMN "t_risk_template"."code" IS '事件编号';
COMMENT ON COLUMN "t_risk_template"."uniq_code" IS '唯一编号，mode+data_source+rule_type+code';
COMMENT ON COLUMN "t_risk_template"."name" IS '事件名称';
COMMENT ON COLUMN "t_risk_template"."event_type" IS '事件类型';
COMMENT ON COLUMN "t_risk_template"."top_event_type" IS '一级事件类型,英文code';
COMMENT ON COLUMN "t_risk_template"."top_event_type_chinese" IS '一级事件类型中文';
COMMENT ON COLUMN "t_risk_template"."second_event_type" IS '二级事件类型,英文code';
COMMENT ON COLUMN "t_risk_template"."second_event_type_chinese" IS '二级事件类型中文';
COMMENT ON COLUMN "t_risk_template"."filter_ip" IS '关注IP类型';
COMMENT ON COLUMN "t_risk_template"."filter_content" IS '事件过滤条件';
COMMENT ON COLUMN "t_risk_template"."desc" IS '事件的描述信息';
COMMENT ON COLUMN "t_risk_template"."suggest" IS '事件的解决措施';
COMMENT ON COLUMN "t_risk_template"."child_desc" IS '子事件的描述,展示关注对象的具体信息';
COMMENT ON COLUMN "t_risk_template"."priority" IS '优先级（数字越小优先级越高）';
COMMENT ON COLUMN "t_risk_template"."threat_severity" IS '事件威胁等级';
COMMENT ON COLUMN "t_risk_template"."alarm_results" IS '事件告警结果';
COMMENT ON COLUMN "t_risk_template"."enable" IS '是否启用（0不启用，1启用）';
COMMENT ON COLUMN "t_risk_template"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_risk_template"."filter_content_aiql" IS '事件过滤条件Aiql';
COMMENT ON COLUMN "t_risk_template"."netflow_log_field" IS '关联网侧日志展示字段';
COMMENT ON COLUMN "t_risk_template"."host_log_field" IS '关联终端日志展示字段';


DROP TABLE IF EXISTS "t_role";
CREATE TABLE "t_role"  (
  "id" BIGSERIAL,
  "name" VARCHAR(150)   NOT NULL,
  "description" VARCHAR(4096)   NULL DEFAULT NULL,
  "createuser" BIGINT NOT NULL,
  "createtime" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updateuser" BIGINT NOT NULL,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_switch" INTEGER NOT NULL DEFAULT 1,
  "order" INTEGER NOT NULL DEFAULT 0,
  "delete_switch" INTEGER NOT NULL DEFAULT 1,
  "role_type_id" INTEGER NOT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_role" VALUES (1, '系统管理员', '系统管理员，拥有系统最高权限', 1, '2016-01-01 00:00:00', 1, '2016-01-01 00:00:00', 0, 6, 0, 1);,
  INSERT INTO "t_role" VALUES (2, '用户管理员', '仅有用户管理权限', 1, '2026-01-13 10:37:38', 1, '2026-01-13 10:37:38', 0, 0, 0, 7);,
  INSERT INTO "t_role" VALUES (3, '操作审计员', '仅有操作日志查看权限', 1, '2026-01-13 10:37:38', 1, '2026-01-13 10:37:38', 0, 0, 0, 6);,
  INSERT INTO "t_role" VALUES (5, '总部安服人员', NULL, 1, '2018-12-13 15:39:54', 1, '2026-01-13 10:37:40', 0, 4, 0, 3);,
  INSERT INTO "t_role" VALUES (6, '分部安全管理员', NULL, 1, '2018-12-13 15:39:54', 1, '2018-12-13 15:39:54', 0, 3, 0, 5);,
  INSERT INTO "t_role" VALUES (7, '总部安全管理员', NULL, 1, '2018-12-13 15:39:54', 1, '2018-12-13 15:39:54', 0, 5, 0, 2);,
  INSERT INTO "t_role" VALUES (8, '分部安服人员', NULL, 1, '2018-12-13 15:39:54', 1, '2018-12-13 15:39:54', 0, 2, 0, 4);,
  INSERT INTO "t_role" VALUES (9, '运维管理员', NULL, 1, '2018-12-13 15:39:54', 1, '2026-01-13 10:37:46', 0, 0, 0, 8);

-- Indexes
CREATE UNIQUE INDEX "i_role_name" ON "t_role" ("name");

-- Column comments
COMMENT ON COLUMN "t_role"."name" IS '角色名';
COMMENT ON COLUMN "t_role"."description" IS '角色描述';
COMMENT ON COLUMN "t_role"."createuser" IS '创建人';
COMMENT ON COLUMN "t_role"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_role"."updateuser" IS '修改人';
COMMENT ON COLUMN "t_role"."updatetime" IS '修改时间';
COMMENT ON COLUMN "t_role"."update_switch" IS '列表展示是否可以更新：0不可以，1可以';
COMMENT ON COLUMN "t_role"."order" IS '列表排序：0不参与排序，非0可以';
COMMENT ON COLUMN "t_role"."delete_switch" IS '是否可以删除，0不可，1可以。';
COMMENT ON COLUMN "t_role"."role_type_id" IS '角色类型id';


DROP TABLE IF EXISTS "t_role_permission";
CREATE TABLE "t_role_permission"  (
  "id" SERIAL,
  "role" BIGINT NOT NULL,
  "permission" VARCHAR(150)   NOT NULL,
  "createtime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
  CONSTRAINT "t_role_permission_FK" FOREIGN KEY ("permission") REFERENCES "t_permission" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
  INSERT INTO "t_role_permission" VALUES (1, 1, 'mirror:menu:Kpi', '2019-05-08 18:50:22', '2019-05-08 18:50:22');,
  INSERT INTO "t_role_permission" VALUES (6, 5, 'mirror:menu:Kpi', '2019-05-08 15:50:16', '2019-05-08 15:50:16');,
  INSERT INTO "t_role_permission" VALUES (7, 7, 'mirror:menu:Kpi', '2019-05-08 15:50:16', '2019-05-08 15:50:16');

-- Indexes
CREATE UNIQUE INDEX "t_role_permission_UN" ON "t_role_permission" ("role", "permission");
CREATE INDEX "idx_role" ON "t_role_permission" ("role");
CREATE INDEX "t_role_permission_FK" ON "t_role_permission" ("permission");

-- Column comments
COMMENT ON COLUMN "t_role_permission"."id" IS '主键';
COMMENT ON COLUMN "t_role_permission"."role" IS '角色ID';
COMMENT ON COLUMN "t_role_permission"."permission" IS '权限表ID';
COMMENT ON COLUMN "t_role_permission"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_role_permission"."updatetime" IS '修改时间';


DROP TABLE IF EXISTS "t_role_role_type";
CREATE TABLE "t_role_role_type"  (
  "id" SERIAL,
  "role_id" INTEGER NOT NULL,
  "role_type_id" INTEGER NOT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "default" VARCHAR(150)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_role_role_type" VALUES (1, 6, 5, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);,
  INSERT INTO "t_role_role_type" VALUES (2, 8, 4, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);,
  INSERT INTO "t_role_role_type" VALUES (3, 7, 2, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);,
  INSERT INTO "t_role_role_type" VALUES (4, 5, 3, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);,
  INSERT INTO "t_role_role_type" VALUES (5, 3, 6, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);,
  INSERT INTO "t_role_role_type" VALUES (6, 2, 7, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);,
  INSERT INTO "t_role_role_type" VALUES (7, 1, 1, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);,
  INSERT INTO "t_role_role_type" VALUES (8, 4, 1, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL);,
  INSERT INTO "t_role_role_type" VALUES (9, 9, 8, '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL);

DROP TABLE IF EXISTS "t_role_type";
CREATE TABLE "t_role_type"  (
  "id" SERIAL,
  "name" VARCHAR(150)   NOT NULL,
  "describe" VARCHAR(4096)   NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "default" VARCHAR(150)   NULL DEFAULT NULL,
  "delete_switch" INTEGER NOT NULL DEFAULT 1,
  "update_switch" INTEGER NOT NULL DEFAULT 1,
  "add_switch" INTEGER NOT NULL DEFAULT 1,
  "import_switch" INTEGER NOT NULL DEFAULT 1,
  "export_switch" INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_role_type" VALUES (1, '系统管理员', '拥有系统最大数据权限和操作权限，主要负责整个系的正常运行及维护。只有组织架构为根节点（总部）的用户账号才能选择“系统管理员”类型的角色。系统已内置一个系统管理员：admin。', '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 1, 1, 1, 1, 1);,
  INSERT INTO "t_role_type" VALUES (2, '总部安全管理员', '负责组织安全管理、组织内部安全问题的审批、处置、审核等工作。总部安全管理员拥有查看整个组织数据权限及大部分操作权限。', '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 1, 1, 1, 1, 1);,
  INSERT INTO "t_role_type" VALUES (3, '总部安服人员', '负责组织内部安全测试、问题单提交，回归测试等工作。总部安服人员提交问题单给总部安全管理员审批，总部安全管理员下发问题单给总部安服人员处理。总部安服人员拥有查看整个组织的数据权限。', '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 1, 1, 1, 1, 1);,
  INSERT INTO "t_role_type" VALUES (4, '分部安服人员', '负责组织内部安全测试、问题单提交，回归测试等工作。分部安服人员提交问题单给本组织安全管理员审批，分部安全管理员下发问题单给本组织安服人员处理。分部安服人员拥有查看本组织及下级组织的数据权限。', '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 0, 0, 0, 0, 0);,
  INSERT INTO "t_role_type" VALUES (5, '分部安全管理员', '负责分部组织安全管理、组织内部安全问题的审批、处置、审核等工作。分部安全管理员拥有查看本组织及下级组织的数据，还支持查看上级组织通报的数据，拥有部分操作权限。', '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 0, 0, 0, 0, 0);,
  INSERT INTO "t_role_type" VALUES (6, '操作审计员', NULL, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 1, 1, 1, 1, 1);,
  INSERT INTO "t_role_type" VALUES (7, '用户管理员', NULL, '2026-01-13 10:37:40', '2026-01-13 10:37:40', NULL, 1, 1, 1, 1, 1);,
  INSERT INTO "t_role_type" VALUES (8, '运维管理员', NULL, '2026-01-13 10:37:46', '2026-01-13 10:37:46', NULL, 1, 1, 1, 1, 1);

-- Indexes
CREATE UNIQUE INDEX "name_UNIQUE" ON "t_role_type" ("name");

-- Column comments
COMMENT ON COLUMN "t_role_type"."describe" IS '角色类型的描述信息';
COMMENT ON COLUMN "t_role_type"."delete_switch" IS '是否支持删除：0不支持；1支持';
COMMENT ON COLUMN "t_role_type"."update_switch" IS '是否支持更新：0不支持；1支持';
COMMENT ON COLUMN "t_role_type"."add_switch" IS '是否支持新增：0不支持；1支持';
COMMENT ON COLUMN "t_role_type"."import_switch" IS '是否支持导入：0不支持；1支持';
COMMENT ON COLUMN "t_role_type"."export_switch" IS '是否支持导出；0不支持，1支持。';


DROP TABLE IF EXISTS "t_role_type_permission";
CREATE TABLE "t_role_type_permission"  (
  "id" SERIAL,
  "permission" VARCHAR(150)   NOT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "default" VARCHAR(150)   NULL DEFAULT NULL,
  "role_type_id" INTEGER NOT NULL,
  PRIMARY KEY ("id")
  CONSTRAINT "t_role_type_permission_FK" FOREIGN KEY ("permission") REFERENCES "t_permission" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- Indexes
CREATE UNIQUE INDEX "t_role_type_permission_UN" ON "t_role_type_permission" ("role_type_id", "permission");
CREATE INDEX "t_role_type_permission_FK" ON "t_role_type_permission" ("permission");

-- Column comments
COMMENT ON COLUMN "t_role_type_permission"."permission" IS '菜单id';
COMMENT ON COLUMN "t_role_type_permission"."role_type_id" IS '角色类型名称默认7个';


DROP TABLE IF EXISTS "t_scan_strategy";
CREATE TABLE "t_scan_strategy"  (
  "id" SERIAL,
  "task_name" VARCHAR(255)   NOT NULL DEFAULT '',
  "host_id" VARCHAR(150)   NOT NULL DEFAULT '',
  "device_id" VARCHAR(50)   NOT NULL DEFAULT '',
  "scan_device_ip" VARCHAR(128)   NOT NULL DEFAULT '',
  "security_device_name" VARCHAR(200)   NOT NULL DEFAULT '',
  "strategy_type" BOOLEAN NOT NULL DEFAULT 0,
  "strategy_source" BOOLEAN NOT NULL DEFAULT 0,
  "scan_object" VARCHAR(100)   NOT NULL DEFAULT '',
  "scan_object_num" INTEGER NULL DEFAULT 0,
  "scan_result_num" INTEGER NULL DEFAULT 0,
  "create_time" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "end_time" timestamp NULL DEFAULT NULL,
  "task_status" BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_scan_strategy"."id" IS '序号';
COMMENT ON COLUMN "t_scan_strategy"."task_name" IS '任务名称';
COMMENT ON COLUMN "t_scan_strategy"."host_id" IS 'EDR主机唯一标识';
COMMENT ON COLUMN "t_scan_strategy"."device_id" IS 'dasca联动设备deviceId';
COMMENT ON COLUMN "t_scan_strategy"."scan_device_ip" IS '扫描设备IP';
COMMENT ON COLUMN "t_scan_strategy"."security_device_name" IS '安全设备名称';
COMMENT ON COLUMN "t_scan_strategy"."strategy_type" IS '策略类型,1--漏洞扫描，2--病毒木马，3--网站后门';
COMMENT ON COLUMN "t_scan_strategy"."strategy_source" IS '策略来源,1--自建，2--SOAR';
COMMENT ON COLUMN "t_scan_strategy"."scan_object" IS '扫描对象';
COMMENT ON COLUMN "t_scan_strategy"."scan_object_num" IS '扫描对象数';
COMMENT ON COLUMN "t_scan_strategy"."scan_result_num" IS '扫描结果数';
COMMENT ON COLUMN "t_scan_strategy"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_scan_strategy"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_scan_strategy"."end_time" IS '结束时间';
COMMENT ON COLUMN "t_scan_strategy"."task_status" IS '任务状态,0--未扫描，1--扫描中，2--扫描完成，3--扫描失败';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_scan_strategy_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_scan_strategy_update_timestamp
BEFORE UPDATE ON "t_scan_strategy"
FOR EACH ROW
EXECUTE FUNCTION update_t_scan_strategy_timestamp();


DROP TABLE IF EXISTS "t_scene";
CREATE TABLE "t_scene"  (
  "id" VARCHAR(50)   NOT NULL,
  "name" VARCHAR(100)   NOT NULL,
  "icon" text   NULL,
  "type" VARCHAR(50)   NOT NULL,
  "description" text   NULL,
  "tags" VARCHAR(255)   NULL DEFAULT NULL,
  "config" text   NULL,
  "activated" BOOLEAN NULL DEFAULT 0,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "title" VARCHAR(100)   NOT NULL,
  "market_desc" text   NULL,
  "sort" BIGINT NULL DEFAULT NULL,
  "template_type" VARCHAR(50)   NULL DEFAULT NULL,
  "cycle" VARCHAR(20)   NULL DEFAULT NULL,
  "show_export_report" INTEGER NULL DEFAULT 1,
  "is_default" INTEGER NULL DEFAULT 1,
  "market_sort" BIGINT NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_scene" VALUES ('MINER', '挖矿活动', 'MINER', '恶意程序通信', '挖矿活动是指攻击者利用系统漏洞、钓鱼邮件、弱密码爆破等方式渗透目标主机植入木马，并在受控设备中部署挖矿木马，此类程序占用主机算力资源导致计算机硬件过载，引发服务中断和业务连续性问题。这些挖矿木马通常具有横向渗透能力，它们可以从单点感染迅速扩散至整个网络，增加内部风险。', '矿池,币种,挖矿阶段', '{\"stats\": [{\"name\": \"failedHost\", \"title\": \"失陷主机\", \"icon\": \"failedHost\"}]}', 1, '2026-01-13 10:37:49', '2026-01-13 10:37:50', '挖矿活动专项分析与处置中心', '通过分析挖矿活动行为，以及终端上进程网络访问行为，判定当前网络中资产是否存在挖矿活动情况，给出对应的修复建议，可以一键联动以及一键生成报告。', 5, NULL, NULL, 1, 1, 5);,
  INSERT INTO "t_scene" VALUES ('RANSOMWARE', '勒索病毒', 'RANSOMWARE', '恶意程序通信', '勒索病毒是一种特殊的恶意软件，它通过加密受害者的文件或锁定访问系统的方式，对用户的数据进行劫持，并要求支付赎金以换取数据的恢复或系统的访问权限。勒索病毒通常采用高强度的加密算法，使得受害者在没有攻击者提供的解密密钥的情况下几乎不可能自行恢复数据。', '勒索阶段,恶意程序,可疑通信', '{\"stats\": [{\"name\": \"failedHost\", \"title\": \"失陷主机\", \"icon\": \"failedHost\"}]}', 1, '2026-01-13 10:37:49', '2026-01-13 10:37:50', '勒索病毒专项分析与处置中心', '通过分析勒索病毒活动行为，以及终端上进程行为、文件操作日志等，判定当前网络中资产是否存在勒索病毒活动情况，给出对应的修复建议，可以一键联动以及一键生成报告。', 4, NULL, NULL, 1, 1, 4);,
  INSERT INTO "t_scene" VALUES ('SQL_INJECTION', 'SQL注入', 'SQL_INJECTION', 'Web攻击', 'SQL注入攻击是一种针对数据库驱动应用程序的安全漏洞利用方式，它允许攻击者通过在应用程序的输入字段中插入或\"注入\"恶意构造的SQL代码片段，从而执行未经授权的SQL命令。这种攻击能够导致数据泄露、数据丢失、数据损坏、拒绝服务以及完全控制数据库服务器等严重后果。', '注入事件,资产漏洞', '{\"stats\": [{\"name\": \"externalAttacker\", \"title\": \"外部攻击者\", \"icon\": \"externalAttacker\"}, {\"name\": \"internalAttacker\", \"title\": \"内部攻击者\", \"icon\": \"internalAttacker\"}]}', 1, '2026-01-13 10:37:48', '2026-01-13 10:37:50', 'SQL注入攻击专项分析与处置中心', '通过分析SQL注入漏洞攻击行为，判定当前网络中资产是否存在SQL注入漏洞以及针对该漏洞的攻击情况，给出对应的修复建议，可以一键联动以及一键生成报告。', 1, NULL, NULL, 1, 1, 1);,
  INSERT INTO "t_scene" VALUES ('UNAUTHORIZED_ACCESS', '未授权访问', 'UNAUTHORIZED_ACCESS', 'Web攻击', '未授权访问是指攻击者通过绕过身份认证机制、利用系统配置缺陷（如开放端口、默认权限）或漏洞，非法获取对系统、服务、数据的访问权限。此类行为通常利用缺乏访问控制策略、权限配置错误或暴露在公网的敏感接口，直接突破安全边界，形成隐蔽的入侵通道。', '越权访问', '{\"stats\": [{\"name\": \"unAuthorizedAccessAsset\", \"title\": \"未授权访问资产\", \"icon\": \"unAuthorizedAccessAsset\"}]}', 1, '2026-01-13 10:37:49', '2026-01-13 10:37:50', '未授权访问专项分析中心', '通过分析未授权漏洞攻击行为，判定当前网络中资产是否存在未授权访问漏洞，以及针对该漏洞的攻击情况，给出对应的修复建议，可以一键联动以及一键生成报告。', 2, NULL, NULL, 1, 1, 2);,
  INSERT INTO "t_scene" VALUES ('WEAK_PASSWORD', '弱口令', 'WEAK_PASSWORD', '账号安全', '弱口令是指系统或设备中存在的简单密码、默认密码、规律性字符组合等易被猜测或破解的凭证（如 admin/123456、空口令、生日格式等）。攻击者利用自动化工具（暴力破解、字典攻击）或社工手段，通过弱口令直接获取目标系统的控制权限。', 'HTTP,FTP,邮件,数据库', '{\"stats\": [{\"name\": \"weakPasswordAsset\", \"title\": \"弱口令资产\", \"icon\": \"weakPasswordAsset\"}]}', 1, '2026-01-13 10:37:49', '2026-01-13 10:37:50', '弱口令专项分析中心', '通过分析弱口令访问行为，以及终端上登录行为，判定当前网络中资产是否存在弱口令以及针对弱口令的访问情况，给出对应的修复建议，可以一键联动以及一键生成报告。', 3, NULL, NULL, 1, 1, 3);

-- Indexes
CREATE UNIQUE INDEX "uk_name" ON "t_scene" ("name");

-- Column comments
COMMENT ON COLUMN "t_scene"."id" IS '场景ID';
COMMENT ON COLUMN "t_scene"."name" IS '场景名称';
COMMENT ON COLUMN "t_scene"."type" IS '场景类型';
COMMENT ON COLUMN "t_scene"."description" IS '场景描述';
COMMENT ON COLUMN "t_scene"."tags" IS '场景标签';
COMMENT ON COLUMN "t_scene"."config" IS '场景配置';
COMMENT ON COLUMN "t_scene"."activated" IS '是否激活';
COMMENT ON COLUMN "t_scene"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_scene"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_scene"."title" IS '场景标题';
COMMENT ON COLUMN "t_scene"."market_desc" IS '场景市场描述';
COMMENT ON COLUMN "t_scene"."sort" IS '场景排序';
COMMENT ON COLUMN "t_scene"."template_type" IS '场景模版类型';
COMMENT ON COLUMN "t_scene"."cycle" IS '场景检索周期';
COMMENT ON COLUMN "t_scene"."show_export_report" IS '是否展示导出报告按钮 0:不展示 1:展示';
COMMENT ON COLUMN "t_scene"."is_default" IS '是否是默认场景 1:默认 0:自定义';
COMMENT ON COLUMN "t_scene"."market_sort" IS '场景市场排序';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_scene_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_scene_update_timestamp
BEFORE UPDATE ON "t_scene"
FOR EACH ROW
EXECUTE FUNCTION update_t_scene_timestamp();


DROP TABLE IF EXISTS "t_scene_component";
CREATE TABLE "t_scene_component"  (
  "id" VARCHAR(50)   NOT NULL,
  "name" VARCHAR(100)   NOT NULL,
  "create_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "type" VARCHAR(50)   NULL DEFAULT NULL,
  "description" text   NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_scene_component" VALUES ('ALARM_LIST', '告警列表', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('ATTACK_DETAIL', '攻击详情', '2026-01-13 10:37:48', '2026-01-13 10:37:48', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('DISPOSAL_RECORD', '处置记录', '2026-01-13 10:37:48', '2026-01-13 10:37:48', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('EMERGENCY_ALARM', '紧急安全报警', '2026-01-13 10:37:48', '2026-01-13 10:37:48', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('EMERGENCY_FORECAST', '紧急安全警报', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('HANDLE_RECORD', '处置记录', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('MINER_EMERGENCY_FORECAST', '紧急安全警报', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('MINER_HANDLE_RECORD', '处置记录', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('MINER_RISK_HOST', '挖矿主机', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('RISK_HOST', '风险主机', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('UNAUTHORIZED_ALARM_LIST', '告警列表', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('UNAUTHORIZED_ANALYSIS', '未授权访问分析', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('UNAUTHORIZED_ASSET', '未授权访问资产', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('VULNERABILITY', '漏洞利用', '2026-01-13 10:37:48', '2026-01-13 10:37:48', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('WEAK_PASSWORD_ANALYSIS', '弱口令分析', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);,
  INSERT INTO "t_scene_component" VALUES ('WEAK_PASSWORD_ASSET', '弱口令资产', '2026-01-13 10:37:49', '2026-01-13 10:37:49', NULL, NULL);

-- Column comments
COMMENT ON COLUMN "t_scene_component"."id" IS '组件ID';
COMMENT ON COLUMN "t_scene_component"."name" IS '组件名称';
COMMENT ON COLUMN "t_scene_component"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_scene_component"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_scene_component"."type" IS '组件类型';
COMMENT ON COLUMN "t_scene_component"."description" IS '组件描述';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_scene_component_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_scene_component_update_timestamp
BEFORE UPDATE ON "t_scene_component"
FOR EACH ROW
EXECUTE FUNCTION update_t_scene_component_timestamp();


DROP TABLE IF EXISTS "t_scene_component_rel";
CREATE TABLE "t_scene_component_rel"  (
  "id" BIGSERIAL,
  "scene_id" VARCHAR(50)   NOT NULL,
  "component_id" VARCHAR(50)   NOT NULL,
  "config" text   NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_scene_component_rel" VALUES (1, 'SQL_INJECTION', 'EMERGENCY_ALARM', '{\r\n    \"filter\": {\r\n        \"external\": \"direction == \\\"10\\\" AND (((alarmName contains \\\"TheMole\\\" OR alarmName contains \\\"SQLNinja\\\" OR alarmName contains \\\"AutoGetColumn\\\" OR alarmName contains \\\"SQLBrute\\\" OR alarmName contains \\\"SQLMAP\\\" OR alarmName contains \\\"bsqlbf\\\" OR alarmName contains \\\"pangolin\\\" OR alarmName contains \\\"漏扫工具\\\" OR alarmName contains \\\"注入工具\\\" OR alarmName contains \\\"扫描工具\\\") AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (judgeResult in [\\\"attackSuccess\\\",\\\"attackFailure\\\",\\\"attackAttempt\\\",\\\"vulnerabilityExploitationSuccess\\\",\\\"vulnerabilityExploitationFailure\\\",\\\"vulnerabilityRisk\\\"] AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (confidence == \\\"High\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (attackerTags contains \\\"SQL注入研判\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\"))\",\r\n        \"internal\": \"direction == \\\"00\\\" AND (((alarmName contains \\\"TheMole\\\" OR alarmName contains \\\"SQLNinja\\\" OR alarmName contains \\\"AutoGetColumn\\\" OR alarmName contains \\\"SQLBrute\\\" OR alarmName contains \\\"SQLMAP\\\" OR alarmName contains \\\"bsqlbf\\\" OR alarmName contains \\\"pangolin\\\" OR alarmName contains \\\"漏扫工具\\\" OR alarmName contains \\\"注入工具\\\" OR alarmName contains \\\"扫描工具\\\") AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (judgeResult in [\\\"attackSuccess\\\",\\\"attackFailure\\\",\\\"attackAttempt\\\",\\\"vulnerabilityExploitationSuccess\\\",\\\"vulnerabilityExploitationFailure\\\",\\\"vulnerabilityRisk\\\"] AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (confidence == \\\"High\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (attackerTags contains \\\"SQL注入研判\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\"))\"\r\n    }\r\n}', '2026-01-13 10:37:48', '2026-01-13 10:37:50');,
  INSERT INTO "t_scene_component_rel" VALUES (2, 'SQL_INJECTION', 'VULNERABILITY', '{\r\n    \"filter\": \"direction in [\\\"00\\\",\\\"10\\\"] AND (((alarmName contains \\\"TheMole\\\" OR alarmName contains \\\"SQLNinja\\\" OR alarmName contains \\\"AutoGetColumn\\\" OR alarmName contains \\\"SQLBrute\\\" OR alarmName contains \\\"SQLMAP\\\" OR alarmName contains \\\"bsqlbf\\\" OR alarmName contains \\\"pangolin\\\" OR alarmName contains \\\"漏扫工具\\\" OR alarmName contains \\\"注入工具\\\" OR alarmName contains \\\"扫描工具\\\") AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (judgeResult in [\\\"attackSuccess\\\",\\\"attackFailure\\\",\\\"attackAttempt\\\",\\\"vulnerabilityExploitationSuccess\\\",\\\"vulnerabilityExploitationFailure\\\",\\\"vulnerabilityRisk\\\"] AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (confidence == \\\"High\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (attackerTags contains \\\"SQL注入研判\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\"))\"\r\n}', '2026-01-13 10:37:48', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (3, 'SQL_INJECTION', 'ATTACK_DETAIL', '{\r\n    \"filter\": \"direction in [\\\"00\\\",\\\"10\\\"] AND (((alarmName contains \\\"TheMole\\\" OR alarmName contains \\\"SQLNinja\\\" OR alarmName contains \\\"AutoGetColumn\\\" OR alarmName contains \\\"SQLBrute\\\" OR alarmName contains \\\"SQLMAP\\\" OR alarmName contains \\\"bsqlbf\\\" OR alarmName contains \\\"pangolin\\\" OR alarmName contains \\\"漏扫工具\\\" OR alarmName contains \\\"注入工具\\\" OR alarmName contains \\\"扫描工具\\\") AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (judgeResult in [\\\"attackSuccess\\\",\\\"attackFailure\\\",\\\"attackAttempt\\\",\\\"vulnerabilityExploitationSuccess\\\",\\\"vulnerabilityExploitationFailure\\\",\\\"vulnerabilityRisk\\\"] AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (confidence == \\\"High\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\") OR (attackerTags contains \\\"SQL注入研判\\\" AND subCategory == \\\"/WebAttack/SQLInjection\\\"))\"\r\n}', '2026-01-13 10:37:48', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (4, 'SQL_INJECTION', 'DISPOSAL_RECORD', '{\r\n    \"source\": \"SQL_INJECTION\",\r\n    \"action\": \"prohibit\"\r\n}', '2026-01-13 10:37:48', '2026-01-13 10:37:48');,
  INSERT INTO "t_scene_component_rel" VALUES (5, 'WEAK_PASSWORD', 'WEAK_PASSWORD_ASSET', '{\r\n    \"filter\": {\r\n        \"web\": \"subCategory == \\\"/ConfigRisk/WeakPassword\\\" AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND loginType != \\\"Basic认证\\\" AND appProtocol in [\\\"http\\\"]\",   \r\n        \"other\": \"subCategory == \\\"/ConfigRisk/WeakPassword\\\" AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND loginType != \\\"Basic认证\\\" AND appProtocol notin [\\\"http\\\"]\"\r\n    }\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (6, 'WEAK_PASSWORD', 'WEAK_PASSWORD_ANALYSIS', '{\r\n    \"filter\": {\r\n        \"web\": \"subCategory == \\\"/ConfigRisk/WeakPassword\\\" AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND loginType != \\\"Basic认证\\\" AND appProtocol in [\\\"http\\\"]\",   \r\n        \"other\": \"subCategory == \\\"/ConfigRisk/WeakPassword\\\" AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND loginType != \\\"Basic认证\\\" AND appProtocol notin [\\\"http\\\"]\"\r\n    }\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (7, 'WEAK_PASSWORD', 'ALARM_LIST', '{\"filter\":\"\"}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (8, 'UNAUTHORIZED_ACCESS', 'UNAUTHORIZED_ASSET', '{\r\n    \"filter\": {\r\n        \"web\": \"(subCategory == \\\"/DataSteal/UnauthorizedAccess\\\"  OR alarmName contains \\\"未授权\\\") AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND appProtocol in [\\\"http\\\"]\",\r\n        \"other\": \"(subCategory == \\\"/DataSteal/UnauthorizedAccess\\\"  OR alarmName contains \\\"未授权\\\") AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND appProtocol notin [\\\"http\\\"]\"\r\n    }\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (9, 'UNAUTHORIZED_ACCESS', 'UNAUTHORIZED_ANALYSIS', '{\r\n    \"filter\": {\r\n        \"web\": \"(subCategory == \\\"/DataSteal/UnauthorizedAccess\\\" OR alarmName contains \\\"未授权\\\") AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND appProtocol in [\\\"http\\\"]\",\r\n        \"other\": \"(subCategory == \\\"/DataSteal/UnauthorizedAccess\\\" OR alarmName contains \\\"未授权\\\") AND alarmResults == \\\"OK\\\" AND direction in [\\\"00\\\",\\\"10\\\"] AND appProtocol notin [\\\"http\\\"]\"\r\n    }\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (10, 'UNAUTHORIZED_ACCESS', 'UNAUTHORIZED_ALARM_LIST', '{\"filter\":\"\"}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (11, 'RANSOMWARE', 'EMERGENCY_FORECAST', '{\r\n    \"filter\": \"(subCategory == \\\"/Malware/Ransomware\\\" OR ruleType == \\\"/Malware/Ransomware\\\") AND alarmResults == \\\"OK\\\" AND ((alarmSource == \\\"安恒EDR\\\" AND dvcAction in [\\\"pass\\\",\\\"failed\\\"]) OR alarmSource != \\\"安恒EDR\\\")\"\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (12, 'RANSOMWARE', 'RISK_HOST', '{\r\n    \"filter\": \"(subCategory == \\\"/Malware/Ransomware\\\" OR ruleType == \\\"/Malware/Ransomware\\\")\"\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (13, 'RANSOMWARE', 'HANDLE_RECORD', '{\"filter\":\"\"}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (14, 'MINER', 'MINER_EMERGENCY_FORECAST', '{\r\n    \"filter\": \"(subCategory == \\\"/Malware/Miner\\\" OR ruleType == \\\"/Malware/Miner\\\") AND alarmResults == \\\"OK\\\" AND ((alarmSource == \\\"安恒EDR\\\" AND dvcAction in [\\\"pass\\\",\\\"failed\\\"]) OR alarmSource != \\\"安恒EDR\\\")\"\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (15, 'MINER', 'MINER_RISK_HOST', '{\r\n    \"filter\": \"(subCategory == \\\"/Malware/Miner\\\" OR ruleType == \\\"/Malware/Miner\\\")\"\r\n}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');,
  INSERT INTO "t_scene_component_rel" VALUES (16, 'MINER', 'MINER_HANDLE_RECORD', '{\"filter\":\"\"}', '2026-01-13 10:37:49', '2026-01-13 10:37:49');

-- Indexes
CREATE UNIQUE INDEX "idx_unique_rel" ON "t_scene_component_rel" ("scene_id", "component_id");

-- Column comments
COMMENT ON COLUMN "t_scene_component_rel"."id" IS '关联ID';
COMMENT ON COLUMN "t_scene_component_rel"."scene_id" IS '场景ID';
COMMENT ON COLUMN "t_scene_component_rel"."component_id" IS '组件ID';
COMMENT ON COLUMN "t_scene_component_rel"."config" IS '关联配置';
COMMENT ON COLUMN "t_scene_component_rel"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_scene_component_rel"."update_time" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_scene_component_rel_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_scene_component_rel_update_timestamp
BEFORE UPDATE ON "t_scene_component_rel"
FOR EACH ROW
EXECUTE FUNCTION update_t_scene_component_rel_timestamp();


DROP TABLE IF EXISTS "t_screen_rotation_config";
CREATE TABLE "t_screen_rotation_config"  (
  "uuid" SERIAL,
  "id" VARCHAR(100)   NOT NULL DEFAULT '',
  "system" VARCHAR(11)   NOT NULL DEFAULT 'bigdata-web',
  "source" VARCHAR(150)   NOT NULL,
  "name" VARCHAR(50)   NOT NULL,
  "url" VARCHAR(50)   NOT NULL,
  "router" VARCHAR(50)   NULL DEFAULT NULL,
  "param" TEXT   NULL,
  "order" INTEGER NOT NULL DEFAULT 0,
  "createTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updateTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("uuid")
);

-- Column comments
COMMENT ON COLUMN "t_screen_rotation_config"."uuid" IS '主键id';
COMMENT ON COLUMN "t_screen_rotation_config"."id" IS '大屏本身id，来源不同可能导致id重复';
COMMENT ON COLUMN "t_screen_rotation_config"."system" IS '大屏所在系统，微服务中会用到，默认主产品';
COMMENT ON COLUMN "t_screen_rotation_config"."source" IS '大屏所在程序中的来源';
COMMENT ON COLUMN "t_screen_rotation_config"."name" IS '大屏名称';
COMMENT ON COLUMN "t_screen_rotation_config"."url" IS '大屏地址，部分为全路径，部分为路由';
COMMENT ON COLUMN "t_screen_rotation_config"."router" IS '路由(预留字段)';
COMMENT ON COLUMN "t_screen_rotation_config"."param" IS '参数';
COMMENT ON COLUMN "t_screen_rotation_config"."order" IS '排序';
COMMENT ON COLUMN "t_screen_rotation_config"."createTime" IS '创建时间';
COMMENT ON COLUMN "t_screen_rotation_config"."updateTime" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_screen_rotation_config_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."updateTime" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_screen_rotation_config_update_timestamp
BEFORE UPDATE ON "t_screen_rotation_config"
FOR EACH ROW
EXECUTE FUNCTION update_t_screen_rotation_config_timestamp();


DROP TABLE IF EXISTS "t_search_save";
CREATE TABLE "t_search_save"  (
  "id" SERIAL,
  "name" VARCHAR(255)   NOT NULL,
  "groupId" VARCHAR(255)   NOT NULL,
  "conditionStr" text   NULL,
  "queryStr" text   NULL,
  "hasChart" BOOLEAN NULL DEFAULT NULL,
  "chartStr" text   NULL,
  "hasAggregation" BOOLEAN NULL DEFAULT NULL,
  "aggregationStr" text   NULL,
  "basicQuery" text   NULL,
  "createTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updateTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_search_save" VALUES (1, '流量会话', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"flow\"}}}}}', 'logType == \"flow\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:07:22.242Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"目的端口\",\"en\":\"destPort\",\"type\":\"int\",\"key\":\"目的端口(destPort)\"},{\"en\":\"transProtocol\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"传输协议\",\"key\":\"传输协议(transProtocol)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"bytesIn\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"请求流量\",\"key\":\"请求流量(bytesIn)\"},{\"en\":\"bytesOut\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"响应流量\",\"key\":\"响应流量(bytesOut)\"},{\"en\":\"srcSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"en\":\"destSecurityZone\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\"},{\"en\":\"direction\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"数据流方向\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 10:15:40', '2020-05-14 10:15:40');,
  INSERT INTO "t_search_save" VALUES (2, 'RDP连接', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"rdp\"}}}}}', 'logType == \"rdp\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 10:25:30', '2020-05-14 10:25:30');,
  INSERT INTO "t_search_save" VALUES (3, 'TELNET请求', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"telnet\"}}}}}', 'logType == \"telnet\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"srcUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源用户名\",\"key\":\"来源用户名(srcUserName)\"},{\"ch\":\"请求方法\",\"en\":\"requestMethod\",\"type\":\"string\",\"key\":\"请求方法(requestMethod)\"},{\"ch\":\"响应内容\",\"en\":\"responseMsg\",\"type\":\"string\",\"key\":\"响应内容(responseMsg)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 10:36:21', '2020-05-14 10:36:21');,
  INSERT INTO "t_search_save" VALUES (4, 'SMB通信', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"smb\"}}}}}', 'logType == \"smb\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"来源用户名\",\"en\":\"srcUserName\",\"type\":\"string\",\"key\":\"来源用户名(srcUserName)\"},{\"en\":\"destHostName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"目的主机名\",\"key\":\"目的主机名(destHostName)\"},{\"en\":\"cmdContent\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"命令行\",\"key\":\"命令行(cmdContent)\"},{\"en\":\"status\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"状态\",\"key\":\"状态(status)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 11:15:40', '2020-05-14 11:15:40');,
  INSERT INTO "t_search_save" VALUES (5, '邮件通信', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"smtp\"}}}}}', 'logType == \"smtp\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"来源用户名\",\"en\":\"srcUserName\",\"type\":\"string\",\"key\":\"来源用户名(srcUserName)\"},{\"en\":\"destUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"目的用户名\",\"key\":\"目的用户名(destUserName)\"},{\"en\":\"ccUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"抄送人\",\"key\":\"抄送人(ccUserName)\"},{\"en\":\"mailTitle\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"邮件标题\",\"key\":\"邮件标题(mailTitle)\"},{\"en\":\"srcGeoCountry\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源国家\",\"key\":\"来源国家(srcGeoCountry)\"},{\"en\":\"srcGeoRegion\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源地区\",\"key\":\"来源地区(srcGeoRegion)\"},{\"en\":\"srcGeoCity\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源城市\",\"key\":\"来源城市(srcGeoCity)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 11:20:26', '2020-05-14 11:20:26');,
  INSERT INTO "t_search_save" VALUES (6, 'TFTP访问', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"tftp\"}}}}}', 'logType == \"tftp\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"opType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"操作类型\",\"key\":\"操作类型(opType)\"},{\"en\":\"fileName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件名\",\"key\":\"文件名(fileName)\"},{\"en\":\"transMode\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"传输模式\",\"key\":\"传输模式(transMode)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 13:55:55', '2020-05-14 13:55:55');,
  INSERT INTO "t_search_save" VALUES (7, 'FTP命令执行', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"ftp\"}}}}}', 'logType == \"ftp\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"requestMethod\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求方法\",\"key\":\"请求方法(requestMethod)\"},{\"en\":\"requestParameters\",\"isQuery\":true,\"isAgg\":false,\"type\":\"string\",\"ch\":\"请求参数\",\"key\":\"请求参数(requestParameters)\"},{\"en\":\"responseCode\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求响应码\",\"key\":\"请求响应码(responseCode)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 13:58:35', '2020-05-14 13:58:35');,
  INSERT INTO "t_search_save" VALUES (8, 'DNS查询', '1', '{\"query\":{\"bool\":{\"filter\":[{\"term\":{\"logType\":\"dns\"}},{\"term\":{\"dnsType\":\"answer\"}}]}}}', 'logType == \"dns\" AND dnsType == \"answer\" ', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"查询类型\",\"en\":\"queryType\",\"type\":\"string\",\"key\":\"查询类型(queryType)\"},{\"ch\":\"dns请求域名\",\"en\":\"requestDomain\",\"type\":\"string\",\"key\":\"dns请求域名(requestDomain)\"},{\"ch\":\"返回的IP地址\",\"en\":\"responseAddress\",\"type\":\"string\",\"key\":\"返回的IP地址(responseAddress)\"},{\"ch\":\"请求响应码\",\"en\":\"responseCode\",\"type\":\"string\",\"key\":\"请求响应码(responseCode)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 14:06:57', '2020-05-14 14:06:57');,
  INSERT INTO "t_search_save" VALUES (9, 'WEB访问', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"http\"}}}}}', 'logType == \"http\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"requestMethod\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"请求方法\",\"key\":\"请求方法(requestMethod)\"},{\"en\":\"destHostName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"目的主机名\",\"key\":\"目的主机名(destHostName)\"},{\"en\":\"requestUrl\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"URL\",\"key\":\"URL(requestUrl)\"},{\"ch\":\"请求响应码\",\"en\":\"responseCode\",\"type\":\"string\",\"key\":\"请求响应码(responseCode)\"},{\"en\":\"bytesIn\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"请求流量\",\"key\":\"请求流量(bytesIn)\"},{\"en\":\"bytesOut\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"响应流量\",\"key\":\"响应流量(bytesOut)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 14:11:47', '2020-05-14 14:11:47');,
  INSERT INTO "t_search_save" VALUES (10, '文件传输', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"fileinfo\"}}}}}', 'logType == \"fileinfo\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"opType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"操作类型\",\"key\":\"操作类型(opType)\"},{\"en\":\"fileName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件名\",\"key\":\"文件名(fileName)\"},{\"en\":\"fileType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件类型\",\"key\":\"文件类型(fileType)\"},{\"en\":\"fileMd5\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"文件MD5\",\"key\":\"文件MD5(fileMd5)\"},{\"en\":\"fileSize\",\"isQuery\":true,\"isAgg\":true,\"type\":\"long\",\"ch\":\"文件大小\",\"key\":\"文件大小(fileSize)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 14:29:31', '2020-05-14 14:29:31');,
  INSERT INTO "t_search_save" VALUES (11, '用户登录行为', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"login\"}}}}}', 'logType == \"login\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"en\":\"srcUserName\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"来源用户名\",\"key\":\"来源用户名(srcUserName)\"},{\"en\":\"catOutcome\",\"isQuery\":true,\"isAgg\":true,\"type\":\"enum\",\"ch\":\"事件结果分类\",\"key\":\"事件结果分类(catOutcome)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 14:33:33', '2020-05-14 14:33:33');,
  INSERT INTO "t_search_save" VALUES (12, '探针告警', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"logType\":\"alert\"}}}}}', 'logType == \"alert\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-13T16:00:00.000Z\",\"2020-05-14T02:25:05.520Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"en\":\"severity\",\"isQuery\":true,\"isAgg\":true,\"type\":\"int\",\"ch\":\"安全日志威胁等级\",\"key\":\"安全日志威胁等级(severity)\"},{\"en\":\"ruleType\",\"isQuery\":true,\"isAgg\":true,\"type\":\"string\",\"ch\":\"探针设备告警类型\",\"key\":\"探针设备告警类型(ruleType)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-14 14:37:46', '2020-05-14 14:37:46');,
  INSERT INTO "t_search_save" VALUES (13, '配置风险', '3', '{\"query\":{\"bool\":{\"filter\":{\"terms\":{\"subCategory\":[\"/ConfigRisk/HTTPServer\",\"/ConfigRisk/MidWare\",\"/ConfigRisk/Database\",\"/ConfigRisk/Service\",\"/ConfigRisk/DeviceConf\",\"/ConfigRisk/Others\"]}}}}}', 'subCategory in [\"/ConfigRisk/HTTPServer\",\"/ConfigRisk/MidWare\",\"/ConfigRisk/Database\",\"/ConfigRisk/Service\",\"/ConfigRisk/DeviceConf\",\"/ConfigRisk/Others\"]', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"目的端口\",\"key\":\"目的端口(destPort)\",\"value\":\"destPort\",\"index\":1},{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":2},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":3},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":4}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:01:05.652Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:01:18', '2020-05-15 10:01:18');,
  INSERT INTO "t_search_save" VALUES (14, '企业形象不良影响', '3', '{\"query\":{\"bool\":{\"filter\":{\"terms\":{\"subCategory\":[\"/SuspEndpoint/Attack\",\"/SuspEndpoint/ExternalScan\",\"/WebAttack/WebTempering\"]}}}}}', 'subCategory in [\"/SuspEndpoint/Attack\",\"/SuspEndpoint/ExternalScan\",\"/WebAttack/WebTempering\"]', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":1},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":2}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:01:22.872Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:01:35', '2020-05-15 10:01:35');,
  INSERT INTO "t_search_save" VALUES (15, '信息明文传输风险', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"subCategory\":\"/ConfigRisk/ClearTextCredit\"}}}}}', 'subCategory == \"/ConfigRisk/ClearTextCredit\" ', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"目的主机名\",\"key\":\"目的主机名(destHostName)\",\"value\":\"destHostName\",\"index\":0}],\"unSelected\":[{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":1},{\"name\":\"URL\",\"key\":\"URL(requestUrl)\",\"value\":\"requestUrl\",\"index\":2},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":3}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:01:45.204Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:01:54', '2020-05-15 10:01:54');,
  INSERT INTO "t_search_save" VALUES (16, '弱口令', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"subCategory\":\"/ConfigRisk/WeakPassword\"}}}}}', 'subCategory == \"/ConfigRisk/WeakPassword\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"目的端口\",\"key\":\"目的端口(destPort)\",\"value\":\"destPort\",\"index\":1},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":2},{\"name\":\"应用协议\",\"key\":\"应用协议(appProtocol)\",\"value\":\"appProtocol\",\"index\":3},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":4}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:02:12.477Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:02:18', '2020-05-15 10:02:18');,
  INSERT INTO "t_search_save" VALUES (17, '高危事件', '3', '{\"query\":{\"bool\":{\"filter\":[{\"terms\":{\"threatSeverity\":[\"High\"]}},{\"term\":{\"alarmStatus\":\"unprocessed\"}}]}}}', 'threatSeverity in [\"High\"] AND alarmStatus == \"unprocessed\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"攻击者\",\"key\":\"攻击者(attacker)\",\"value\":\"attacker\",\"index\":0},{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":1}],\"unSelected\":[{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":2},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":3},{\"name\":\"目的端口\",\"key\":\"目的端口(destPort)\",\"value\":\"destPort\",\"index\":4},{\"name\":\"应用协议\",\"key\":\"应用协议(appProtocol)\",\"value\":\"appProtocol\",\"index\":5},{\"name\":\"告警标签\",\"key\":\"告警标签(alarmTag)\",\"value\":\"alarmTag\",\"index\":6},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":7}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:02:25.922Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:02:33', '2020-05-15 10:02:33');,
  INSERT INTO "t_search_save" VALUES (18, '钓鱼邮件', '3', '{\"query\":{\"bool\":{\"filter\":[{\"term\":{\"name\":\"恶意文件攻击\"}},{\"term\":{\"catOutcome\":\"OK\"}},{\"terms\":{\"appProtocol\":[\"pop2\",\"pop3\",\"smtp\",\"imap\"]}}]}}}', 'name == \"恶意文件攻击\" and catOutcome == \"OK\" and appProtocol in [\"pop2\",\"pop3\",\"smtp\",\"imap\"]', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"目的用户名\",\"key\":\"目的用户名(destUserName)\",\"value\":\"destUserName\",\"index\":2}],\"unSelected\":[{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":0},{\"name\":\"来源用户名\",\"key\":\"来源用户名(srcUserName)\",\"value\":\"srcUserName\",\"index\":1},{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":3},{\"name\":\"来源IP\",\"key\":\"来源IP(srcAddress)\",\"value\":\"srcAddress\",\"index\":4},{\"name\":\"目的IP\",\"key\":\"目的IP(destAddress)\",\"value\":\"destAddress\",\"index\":5},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":6}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-14T16:00:00.000Z\",\"2020-05-15T02:02:47.341Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:02:52', '2020-05-15 10:02:52');,
  INSERT INTO "t_search_save" VALUES (19, '站点存在webshell后门', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"subCategory\":\"/Malware/Webshell\"}}}}}', 'subCategory == \"/Malware/Webshell\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0},{\"name\":\"URL\",\"key\":\"URL(requestUrl)\",\"value\":\"requestUrl\",\"index\":1}],\"unSelected\":[{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":2},{\"name\":\"目的主机名\",\"key\":\"目的主机名(destHostName)\",\"value\":\"destHostName\",\"index\":3},{\"name\":\"攻击者\",\"key\":\"攻击者(attacker)\",\"value\":\"attacker\",\"index\":4},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":5}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-04-30T16:00:00.000Z\",\"2020-05-15T02:02:58.238Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本月\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-15 10:03:06', '2020-05-15 10:03:06');,
  INSERT INTO "t_search_save" VALUES (20, '搜索', '1', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"appProtocol\":\"discard\"}}}}}', 'appProtocol == \"discard\"', 0, '{}', 0, '{}', '{\"timeRange\":[\"2020-05-01 00:00:00\",\"2020-05-18 00:00:00\"],\"isShortcutObj\":{\"isShortcut\":false,\"timeValue\":\"2020-05-01 00:00:00 ~ 2020-05-18 00:00:00\"},\"tableLabel\":[{\"ch\":\"采集器接收时间\",\"en\":\"collectorReceiptTime\",\"type\":\"timestamp\",\"key\":\"采集器接收时间(collectorReceiptTime)\"},{\"ch\":\"事件名称\",\"en\":\"name\",\"type\":\"string\",\"key\":\"事件名称(name)\"},{\"ch\":\"来源IP\",\"en\":\"srcAddress\",\"type\":\"ip\",\"key\":\"来源IP(srcAddress)\"},{\"ch\":\"目的IP\",\"en\":\"destAddress\",\"type\":\"ip\",\"key\":\"目的IP(destAddress)\"},{\"ch\":\"应用协议\",\"en\":\"appProtocol\",\"type\":\"enum\",\"key\":\"应用协议(appProtocol)\"},{\"ch\":\"查询类型\",\"en\":\"queryType\",\"type\":\"string\",\"key\":\"查询类型(queryType)\"},{\"ch\":\"dns请求域名\",\"en\":\"requestDomain\",\"type\":\"string\",\"key\":\"dns请求域名(requestDomain)\"},{\"ch\":\"返回的IP地址\",\"en\":\"responseAddress\",\"type\":\"string\",\"key\":\"返回的IP地址(responseAddress)\"},{\"ch\":\"请求响应码\",\"en\":\"responseCode\",\"type\":\"string\",\"key\":\"请求响应码(responseCode)\"},{\"ch\":\"来源安全域\",\"en\":\"srcSecurityZone\",\"type\":\"enum\",\"key\":\"来源安全域(srcSecurityZone)\"},{\"ch\":\"目的安全域\",\"en\":\"destSecurityZone\",\"type\":\"enum\",\"key\":\"目的安全域(destSecurityZone)\"},{\"ch\":\"数据流方向\",\"en\":\"direction\",\"type\":\"enum\",\"key\":\"数据流方向(direction)\"}],\"moreOptions\":{\"logType\":[{\"name\":\"日志\",\"value\":false,\"key\":\"log\"},{\"name\":\"流量\",\"value\":false,\"key\":\"flow\"}],\"threatSeverity\":[{\"name\":\"高\",\"value\":false,\"key\":\"High\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"低\",\"value\":false,\"key\":\"Low\"}],\"killChain\":[],\"dataSource\":\"原始日志\"}}', '2020-05-19 14:03:13', '2020-05-19 14:03:13');,
  INSERT INTO "t_search_save" VALUES (21, '威胁情报', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"modelType\":\"intelligence\"}}}}}', 'modelType == \"intelligence\" ', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":1},{\"name\":\"情报IoC\",\"key\":\"情报IoC(IoC)\",\"value\":\"IoC\",\"index\":2},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":3}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-22T16:00:00.000Z\",\"2020-05-23T05:17:22.423Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-23 13:24:31', '2020-05-23 13:24:31');,
  INSERT INTO "t_search_save" VALUES (22, '挖矿活动', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"subCategory\":\"/Malware/Miner\"}}}}}', 'subCategory == \"/Malware/Miner\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":1},{\"name\":\"攻击者\",\"key\":\"攻击者(attacker)\",\"value\":\"attacker\",\"index\":2},{\"name\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\",\"value\":\"srcSecurityZone\",\"index\":3},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":4}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-22T16:00:00.000Z\",\"2020-05-23T05:46:48.004Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-23 13:47:14', '2020-05-23 13:47:14');,
  INSERT INTO "t_search_save" VALUES (23, '勒索病毒', '3', '{\"query\":{\"bool\":{\"filter\":{\"term\":{\"subCategory\":\"/Malware/Ransomware\"}}}}}', 'subCategory == \"/Malware/Ransomware\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":1}],\"unSelected\":[{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":0},{\"name\":\"来源安全域\",\"key\":\"来源安全域(srcSecurityZone)\",\"value\":\"srcSecurityZone\",\"index\":2}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-22T16:00:00.000Z\",\"2020-05-23T05:47:21.276Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-23 13:47:44', '2020-05-23 13:47:44');,
  INSERT INTO "t_search_save" VALUES (24, 'CVE漏洞利用成功', '3', '{\"query\":{\"bool\":{\"filter\":{\"bool\":{\"must_not\":[{\"term\":{\"direction\":\"01\"}}],\"must\":[{\"exists\":{\"field\":\"cve\"}},{\"bool\":{\"should\":[{\"query_string\":{\"query\":\"name:*成功*\"}},{\"term\":{\"alarmResults\":\"OK\"}}],\"minimum_should_match\":1,\"boost\":1}}]}}}}}', 'cve exist AND (name contains \"成功\" OR alarmResults == \"OK\") AND direction != \"01\"', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":0}],\"unSelected\":[{\"name\":\"目的端口\",\"key\":\"目的端口(destPort)\",\"value\":\"destPort\",\"index\":1},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":2},{\"name\":\"cve编号\",\"key\":\"cve编号(cve)\",\"value\":\"cve\",\"index\":3},{\"name\":\"应用协议\",\"key\":\"应用协议(appProtocol)\",\"value\":\"appProtocol\",\"index\":4},{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":5},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":6}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-22T16:00:00.000Z\",\"2020-05-23T05:48:23.364Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-23 13:48:45', '2020-05-23 13:48:45');,
  INSERT INTO "t_search_save" VALUES (25, '外部攻击者', '3', '{\"query\":{\"bool\":{\"filter\":[{\"term\":{\"direction\":\"10\"}},{\"terms\":{\"threatSeverity\":[\"High\",\"Medium\"]}}]}}}', 'direction == \"10\" AND (threatSeverity in [\"High\",\"Medium\"])', 0, '{}', 1, '{\"aggVar\":{\"selected\":[{\"name\":\"攻击者\",\"key\":\"攻击者(attacker)\",\"value\":\"attacker\",\"index\":0}],\"unSelected\":[{\"name\":\"告警子类型\",\"key\":\"告警子类型(subCategory)\",\"value\":\"subCategory\",\"index\":1},{\"name\":\"来源国家\",\"key\":\"来源国家(srcGeoCountry)\",\"value\":\"srcGeoCountry\",\"index\":2},{\"name\":\"来源地区\",\"key\":\"来源地区(srcGeoRegion)\",\"value\":\"srcGeoRegion\",\"index\":3},{\"name\":\"事件名称\",\"key\":\"事件名称(name)\",\"value\":\"name\",\"index\":4},{\"name\":\"受害者\",\"key\":\"受害者(victim)\",\"value\":\"victim\",\"index\":5},{\"name\":\"目的端口\",\"key\":\"目的端口(destPort)\",\"value\":\"destPort\",\"index\":6},{\"name\":\"目的安全域\",\"key\":\"目的安全域(destSecurityZone)\",\"value\":\"destSecurityZone\",\"index\":7},{\"name\":\"安全告警威胁等级\",\"key\":\"安全告警威胁等级(threatSeverity)\",\"value\":\"threatSeverity\",\"index\":8}]},\"scene\":\"normal\"}', '{\"timeRange\":[\"2020-05-22T16:00:00.000Z\",\"2020-05-23T05:48:53.434Z\"],\"isShortcutObj\":{\"isShortcut\":true,\"timeValue\":\"本日\"},\"tableLabel\":[],\"scene\":\"normal\",\"moreOptions\":{\"alarmStatus\":[{\"name\":\"未处理\",\"value\":false,\"key\":\"unprocessed\"},{\"name\":\"处理中\",\"value\":false,\"key\":\"processing\"},{\"name\":\"处理完成\",\"value\":false,\"key\":\"processed\"},{\"name\":\"误报\",\"value\":false,\"key\":\"falsePositives\"}],\"killChain\":[{\"name\":\"侦查\",\"value\":false,\"key\":\"KC_Reconnaissance\"},{\"name\":\"投递\",\"value\":false,\"key\":\"KC_Delivery\"},{\"name\":\"利用\",\"value\":false,\"key\":\"KC_Exploitation\"},{\"name\":\"命令控制\",\"value\":false,\"key\":\"KC_CommandControl\"},{\"name\":\"内部侦查\",\"value\":false,\"key\":\"KC_InternalRecon\"},{\"name\":\"横向渗透\",\"value\":false,\"key\":\"KC_LateralMov\"},{\"name\":\"获利\",\"value\":false,\"key\":\"KC_Profit\"},{\"name\":\"无\",\"value\":false,\"key\":\"KC_Others\"}],\"threatSeverity\":[{\"name\":\"低\",\"value\":false,\"key\":\"Low\"},{\"name\":\"中\",\"value\":false,\"key\":\"Medium\"},{\"name\":\"高\",\"value\":false,\"key\":\"High\"}],\"attackIntent\":[{\"name\":\"利用型攻击\",\"value\":false,\"key\":\"exploitAttack\"},{\"name\":\"恶意文件\",\"value\":false,\"key\":\"maliciousFile\"},{\"name\":\"拒绝服务\",\"value\":false,\"key\":\"DoS\"},{\"name\":\"扫描探测\",\"value\":false,\"key\":\"scanProbe\"},{\"name\":\"异常事件\",\"value\":false,\"key\":\"anomalyEvent\"},{\"name\":\"系统管理\",\"value\":false,\"key\":\"systemManagement\"},{\"name\":\"其他\",\"value\":false,\"key\":\"others\"}]}}', '2020-05-23 13:49:11', '2020-05-23 13:49:11');

-- Indexes
CREATE UNIQUE INDEX "t_search_save_UN" ON "t_search_save" ("name", "groupId");

-- Column comments
COMMENT ON COLUMN "t_search_save"."name" IS '名称';
COMMENT ON COLUMN "t_search_save"."groupId" IS '分组id';
COMMENT ON COLUMN "t_search_save"."conditionStr" IS '树状结构';
COMMENT ON COLUMN "t_search_save"."queryStr" IS '查询语句';
COMMENT ON COLUMN "t_search_save"."hasChart" IS '是否包含图表语句';
COMMENT ON COLUMN "t_search_save"."chartStr" IS '图表语句';
COMMENT ON COLUMN "t_search_save"."hasAggregation" IS '是否包含聚合语句';
COMMENT ON COLUMN "t_search_save"."aggregationStr" IS '聚合语句';
COMMENT ON COLUMN "t_search_save"."basicQuery" IS '基本查询条件';
COMMENT ON COLUMN "t_search_save"."createTime" IS '元素创建时间';
COMMENT ON COLUMN "t_search_save"."updateTime" IS '元素更新时间';


DROP TABLE IF EXISTS "t_search_save_group";
CREATE TABLE "t_search_save_group"  (
  "id" BIGSERIAL,
  "groupName" VARCHAR(255)   NOT NULL,
  "isFactory" SMALLINT NOT NULL,
  "searchTypeNum" SMALLINT NOT NULL,
  "userId" BIGINT NOT NULL,
  "createTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updateTime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_search_save_group" VALUES (1, '默认', 1, 1, 1, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_search_save_group" VALUES (2, '默认', 1, 2, 1, '2026-01-13 10:37:43', '2026-01-13 10:37:43');,
  INSERT INTO "t_search_save_group" VALUES (3, '默认', 1, 3, 1, '2026-01-13 10:37:43', '2026-01-13 10:37:43');

-- Indexes
CREATE UNIQUE INDEX "t_search_save_group_UN" ON "t_search_save_group" ("groupName", "searchTypeNum", "userId");

-- Column comments
COMMENT ON COLUMN "t_search_save_group"."groupName" IS '分组名称';
COMMENT ON COLUMN "t_search_save_group"."isFactory" IS '是否出厂';
COMMENT ON COLUMN "t_search_save_group"."searchTypeNum" IS '检索分类';
COMMENT ON COLUMN "t_search_save_group"."userId" IS '用户id';


DROP TABLE IF EXISTS "t_security_device";
CREATE TABLE "t_security_device"  (
  "id" SERIAL,
  "name" VARCHAR(200)   NOT NULL,
  "geo" VARCHAR(200)   NULL DEFAULT NULL,
  "type" VARCHAR(100)   NULL DEFAULT NULL,
  "manufacturer" VARCHAR(100)   NULL DEFAULT NULL,
  "icon" VARCHAR(100)   NULL DEFAULT NULL,
  "description" TEXT   NULL,
  "related_assets" TEXT   NULL,
  "related_assets_num" INTEGER NULL DEFAULT NULL,
  "add_screen" INTEGER NULL DEFAULT 0,
  "create_time" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_security_device" VALUES (112, '安恒全流量综合探针', '北京市/市辖区/西城区', '48,14', '安恒(DBAPPSecurity)', 'flm', '安恒全流量综合探针具备高性能抓包、协议解析、文件还原、杀毒引擎等高级威胁检测能力。是一个面向全流量安全分析、业务分析、审计分析的产品，可广泛适用于银行、公安、政府、运营商、电子商务、能源、企业等各行业的流量深度威胁监控与分析。', '', 0, 0, '2026-01-13 10:37:40', '2026-01-13 10:37:40');,
  INSERT INTO "t_security_device" VALUES (113, '安恒日志标准化引擎', '北京市/市辖区/西城区', '48,28', '安恒(DBAPPSecurity)', 'las', '安恒日志标准化引擎通过对客户网络设备、安全设备、主机和应用系统日志进行全面的标准化处理，及时发现各种安全威胁、异常行为事件，为管理人员提供全局的视角，确保客户业务的不间断运营安全。', '', 0, 0, '2026-01-13 10:37:40', '2026-01-13 10:37:40');,
  INSERT INTO "t_security_device" VALUES (114, '安恒WAF', '北京市/市辖区/西城区', '48,13', '安恒(DBAPPSecurity)', 'waf', '应用防火墙专注于网站及Web应用系统的应用层专业安全防护。可以快速地应对恶意攻击者对Web业务带来的冲击；可以智能锁定攻击者并通知管理员对网站代码进行合理的加固。', '', 0, 0, '2026-01-13 10:37:40', '2026-01-13 10:37:40');,
  INSERT INTO "t_security_device" VALUES (115, '安恒EDR', '北京市/市辖区/西城区', '48,56', '安恒(DBAPPSecurity)', 'edr', '主机安全及管理系统是一款集成了丰富的系统防护与加固、网络防护与加固等功能的主机安全产品。通过自主研发的文件诱饵引擎，有着业界领先的勒索专防专杀能力；通过内核级东西向流量隔离技术，实现网络隔离与防护；通过流量画像，实现全网流量可视化且支持一键阻断；拥有补丁修复、外设管控、文件审计、违规外联检测与阻断等主机安全能力。目前产品广泛应用在服务器、桌面PC、虚拟机、工控系统、国产操作系统、容器安全等各个场景。', '', 0, 0, '2026-01-13 10:37:40', '2026-01-13 10:37:40');

-- Indexes
CREATE UNIQUE INDEX "name" ON "t_security_device" ("name");

-- Column comments
COMMENT ON COLUMN "t_security_device"."id" IS '安全设备ID';
COMMENT ON COLUMN "t_security_device"."name" IS '安全设备名称';
COMMENT ON COLUMN "t_security_device"."geo" IS '地理位置';
COMMENT ON COLUMN "t_security_device"."type" IS '设备类型';
COMMENT ON COLUMN "t_security_device"."manufacturer" IS '设备厂商';
COMMENT ON COLUMN "t_security_device"."icon" IS '设备图标';
COMMENT ON COLUMN "t_security_device"."description" IS '描述信息';
COMMENT ON COLUMN "t_security_device"."related_assets" IS '关联资产';
COMMENT ON COLUMN "t_security_device"."related_assets_num" IS '关联资产数';
COMMENT ON COLUMN "t_security_device"."add_screen" IS '是否投屏, 1是，0否';


DROP TABLE IF EXISTS "t_security_group";
CREATE TABLE "t_security_group"  (
  "id" BIGSERIAL,
  "name" VARCHAR(100)   NOT NULL,
  "customer_ids" text   NULL,
  "customer_names" text   NULL,
  "save_time" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "t_security_group" VALUES (1, '核心网络区', '', '', '2026-01-13 10:37:38');,
  INSERT INTO "t_security_group" VALUES (2, '业务核心区', '', '', '2026-01-13 10:37:38');,
  INSERT INTO "t_security_group" VALUES (3, '模拟监控区', '', '', '2026-01-13 10:37:38');,
  INSERT INTO "t_security_group" VALUES (4, '终端接入区', '', '', '2026-01-13 10:37:38');

-- Column comments
COMMENT ON COLUMN "t_security_group"."id" IS '主键';
COMMENT ON COLUMN "t_security_group"."name" IS '安全域名称';
COMMENT ON COLUMN "t_security_group"."customer_ids" IS '资产组id列表';
COMMENT ON COLUMN "t_security_group"."customer_names" IS '资产组name列表';
COMMENT ON COLUMN "t_security_group"."save_time" IS '保存时间';


DROP TABLE IF EXISTS "t_security_incidents";
CREATE TABLE "t_security_incidents"  (
  "id" SERIAL,
  "source" VARCHAR(100)   NULL DEFAULT NULL,
  "incidentModelId" VARCHAR(100)   NULL DEFAULT NULL,
  "incidentModelName" VARCHAR(200)   NULL DEFAULT NULL,
  "incidentName" VARCHAR(200)   NULL DEFAULT NULL,
  "threatSeverity" VARCHAR(10)   NULL DEFAULT NULL,
  "describe" TEXT   NULL,
  "incidentTag" TEXT   NULL,
  "startTime" timestamp NULL DEFAULT NULL,
  "endTime" timestamp NULL DEFAULT NULL,
  "lastUpdateTime" timestamp NULL DEFAULT NULL,
  "evidence" TEXT   NULL,
  "attacker" VARCHAR(1000)   NULL DEFAULT NULL,
  "victim" VARCHAR(1000)   NULL DEFAULT NULL,
  "retrievalTemplate" TEXT   NULL,
  "createTime" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_security_incidents"."source" IS '安全事件来源';
COMMENT ON COLUMN "t_security_incidents"."incidentModelId" IS '事件模型ID';
COMMENT ON COLUMN "t_security_incidents"."incidentModelName" IS '事件模型名称';
COMMENT ON COLUMN "t_security_incidents"."incidentName" IS '事件名称';
COMMENT ON COLUMN "t_security_incidents"."threatSeverity" IS '事件等级';
COMMENT ON COLUMN "t_security_incidents"."describe" IS '描述';
COMMENT ON COLUMN "t_security_incidents"."incidentTag" IS '标签';
COMMENT ON COLUMN "t_security_incidents"."startTime" IS '首次发生时间';
COMMENT ON COLUMN "t_security_incidents"."endTime" IS '最近发生时间';
COMMENT ON COLUMN "t_security_incidents"."lastUpdateTime" IS '最后更新时间';
COMMENT ON COLUMN "t_security_incidents"."evidence" IS '举证';
COMMENT ON COLUMN "t_security_incidents"."attacker" IS '攻击者';
COMMENT ON COLUMN "t_security_incidents"."victim" IS '受害者';
COMMENT ON COLUMN "t_security_incidents"."retrievalTemplate" IS '查询模板';
COMMENT ON COLUMN "t_security_incidents"."createTime" IS '创建时间';


DROP TABLE IF EXISTS "t_security_zone";
CREATE TABLE "t_security_zone"  (
  "id" VARCHAR(100)   NOT NULL,
  "name" VARCHAR(100)   NOT NULL,
  "description" TEXT   NULL,
  "iconPath" VARCHAR(500)   NULL DEFAULT NULL,
  "ipConfStr" TEXT   NOT NULL,
  "uiIpConfStr" TEXT   NULL,
  "createTime" BIGINT NULL DEFAULT NULL,
  "tag" VARCHAR(200)   NULL DEFAULT '',
  PRIMARY KEY ("id")
);
  INSERT INTO "t_security_zone" VALUES ('inner_886da035-c033-46b8-8ce8-b31e03db7ab2_1537173568979', '局域网', '企业局域网。未配置情况下，默认以下区间IP为局域网IP：\n1.     Class A 127.0.0.1\n2.     Class B 10.0.0.0-10.255.255.255，默认子网掩码:255.0.0.0\n3.     Class C 172.16.0.0-172.31.255.255，默认子网掩码:255.240.0.0\n4.     Class D 192.168.0.0-192.168.255.255，默认子网掩码:255.255.0.0', 'internet', '{\"ipInterval\":[[\"10.0.0.0\",\"10.255.255.255\"],[\"172.16.0.0\",\"172.31.255.255\"],[\"192.168.0.0\",\"192.168.255.255\"]],\"ip\":[\"127.0.0.1\"],\"subnetMask\":[]}', '{\"ipInterval\":[1,2,3],\"ip\":[0],\"subnetMask\":[]}', 1537173568979, '');

-- Column comments
COMMENT ON COLUMN "t_security_zone"."id" IS 'Id';
COMMENT ON COLUMN "t_security_zone"."name" IS '安全域名称';
COMMENT ON COLUMN "t_security_zone"."description" IS '安全域描述';
COMMENT ON COLUMN "t_security_zone"."iconPath" IS '图标路径';
COMMENT ON COLUMN "t_security_zone"."ipConfStr" IS 'ip、ip区间、子网掩码配置';
COMMENT ON COLUMN "t_security_zone"."uiIpConfStr" IS 'Ip、ip区间、子网掩码对应前端位置';
COMMENT ON COLUMN "t_security_zone"."createTime" IS '创建时间';
COMMENT ON COLUMN "t_security_zone"."tag" IS '系统标签';


DROP TABLE IF EXISTS "t_serv_report";
CREATE TABLE "t_serv_report"  (
  "id" BIGSERIAL,
  "report_name" VARCHAR(150)   NOT NULL,
  "begin_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "end_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "file_type" VARCHAR(8)   NOT NULL,
  "template_id" VARCHAR(50)   NOT NULL,
  "status" VARCHAR(32)   NOT NULL,
  "fail_message" VARCHAR(512)   NULL DEFAULT NULL,
  "file_uuid" VARCHAR(100)   NULL DEFAULT NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "t_serv_report"."id" IS '主键';
COMMENT ON COLUMN "t_serv_report"."report_name" IS '报告名称';
COMMENT ON COLUMN "t_serv_report"."begin_time" IS '导出数据开始时间';
COMMENT ON COLUMN "t_serv_report"."end_time" IS '导出数据结束时间';
COMMENT ON COLUMN "t_serv_report"."file_type" IS '文件类型，doc、pdf';
COMMENT ON COLUMN "t_serv_report"."template_id" IS '主键，报告模板id';
COMMENT ON COLUMN "t_serv_report"."status" IS '状态，generating：生成中；generated：已生成；failure：生成失败';
COMMENT ON COLUMN "t_serv_report"."fail_message" IS '失败原因';
COMMENT ON COLUMN "t_serv_report"."file_uuid" IS '报告文件uuid，存储下临时目录/tmp/report下';
COMMENT ON COLUMN "t_serv_report"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_serv_report"."update_time" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_serv_report_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_serv_report_update_timestamp
BEFORE UPDATE ON "t_serv_report"
FOR EACH ROW
EXECUTE FUNCTION update_t_serv_report_timestamp();


DROP TABLE IF EXISTS "t_sev_agent_config";
CREATE TABLE "t_sev_agent_config"  (
  "id" BIGSERIAL,
  "agent_type" VARCHAR(32)   NOT NULL,
  "config_version" BIGINT NOT NULL,
  "config_key" VARCHAR(128)   NOT NULL,
  "config_content" text   NULL,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
  CONSTRAINT "t_agent_config_FK" FOREIGN KEY ("agent_type") REFERENCES "t_sev_agent_type" ("agent_type") ON DELETE CASCADE ON UPDATE CASCADE
);
  "SET" FOREIGN_KEY_CHECKS = 1;

-- Indexes
CREATE INDEX "t_agent_config_FK" ON "t_sev_agent_config" ("agent_type");

-- Column comments
COMMENT ON COLUMN "t_sev_agent_config"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_config"."agent_type" IS 'agent类型（AiNTA、APT、SOC）';
COMMENT ON COLUMN "t_sev_agent_config"."config_version" IS '版本号，时间戳';
COMMENT ON COLUMN "t_sev_agent_config"."config_key" IS '配置项标识，英文名';
COMMENT ON COLUMN "t_sev_agent_config"."config_content" IS '配置内容';
COMMENT ON COLUMN "t_sev_agent_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_sev_agent_config"."update_time" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_t_sev_agent_config_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_t_sev_agent_config_update_timestamp
BEFORE UPDATE ON "t_sev_agent_config"
FOR EACH ROW
EXECUTE FUNCTION update_t_sev_agent_config_timestamp();


-- Enable foreign key checks
SET session_replication_role = 'origin';

-- Update sequences
-- Run after data import:
-- SELECT setval(pg_get_serial_sequence('table_name', 'id_column'), (SELECT MAX(id_column) FROM table_name));
