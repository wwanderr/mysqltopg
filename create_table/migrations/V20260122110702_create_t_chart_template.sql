/*
 * Table: t_chart_template
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_chart_template_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_chart_template_id_seq";
CREATE SEQUENCE "t_chart_template_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_chart_template_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_chart_template
-- ----------------------------
DROP TABLE IF EXISTS "t_chart_template";
CREATE TABLE "t_chart_template" (
  "id" int8 NOT NULL DEFAULT nextval('t_chart_template_id_seq'::regclass),
  "template_code" varchar(100) COLLATE "pg_catalog"."default",
  "template_name" varchar(100) COLLATE "pg_catalog"."default",
  "where_condition" text COLLATE "pg_catalog"."default",
  "agg_field" text COLLATE "pg_catalog"."default",
  "query_field" text COLLATE "pg_catalog"."default",
  "sub_where_condition" text COLLATE "pg_catalog"."default",
  "sub_agg_field" text COLLATE "pg_catalog"."default",
  "sub_query_field" text COLLATE "pg_catalog"."default",
  "export_field" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_chart_template" OWNER TO "dbapp";
COMMENT ON COLUMN "t_chart_template"."id" IS '主键id';
COMMENT ON COLUMN "t_chart_template"."template_code" IS '模板code';
COMMENT ON COLUMN "t_chart_template"."template_name" IS '模板名称';
COMMENT ON COLUMN "t_chart_template"."where_condition" IS '一级筛选条件';
COMMENT ON COLUMN "t_chart_template"."agg_field" IS '一级聚合字段';
COMMENT ON COLUMN "t_chart_template"."query_field" IS '一级查询字段';
COMMENT ON COLUMN "t_chart_template"."sub_where_condition" IS '二级筛选条件';
COMMENT ON COLUMN "t_chart_template"."sub_agg_field" IS '二级聚合字段';
COMMENT ON COLUMN "t_chart_template"."sub_query_field" IS '二级查询字段';
COMMENT ON COLUMN "t_chart_template"."export_field" IS '导出字段';

-- ----------------------------
-- Records of t_chart_template
-- ----------------------------
BEGIN;
INSERT INTO "t_chart_template" ("id", "template_code", "template_name", "where_condition", "agg_field", "query_field", "sub_where_condition", "sub_agg_field", "sub_query_field", "export_field") VALUES (1, 'weakPassword', '弱口令', 'destAddress != '''' AND subCategory = ''/ConfigRisk/WeakPassword'' AND alarmResults = ''OK''', 'assetIp', 'startTime,endTime,assetName,assetIp,securityZone,assetType,alarmStatus,subCategory', 'assetIp', 'srcUserName,passwd,appProtocol', 'srcUserName,passwd,appProtocol,alarmResult,alarmStatus', 'endTime:最近发生时间,assetName:资产名称,assetIp:资产IP,destSecurityZone:安全域,assetType:资产类型,srcUserName:用户名,passwd:密码,appProtocol:应用协议,alarmResults:登录结果,aggCount:次数');
INSERT INTO "t_chart_template" ("id", "template_code", "template_name", "where_condition", "agg_field", "query_field", "sub_where_condition", "sub_agg_field", "sub_query_field", "export_field") VALUES (2, 'exploit', '漏洞利用', 'cve != '''' AND destAddress != '''' AND class_type != '''' AND severity_level != ''Unknown''', 'assetIp', NULL, 'assetIp', 'cve,srcAddress,destAddress', NULL, 'endTime:最近发生时间,assetName:资产名称,assetIp:资产IP,destSecurityZone:安全域,assetType:资产类型,vulnerabilityName:漏洞名称,severityLevel:漏洞等级,cve:CVE编号,aggCount:次数');
INSERT INTO "t_chart_template" ("id", "template_code", "template_name", "where_condition", "agg_field", "query_field", "sub_where_condition", "sub_agg_field", "sub_query_field", "export_field") VALUES (3, 'transmission', '明文传输', 'destAddress != '''' AND subCategory = ''/ConfigRisk/ClearTextCredit''', 'assetIp', NULL, 'assetIp', 'appProtocol,requestUrl', NULL, 'endTime:最近发生时间,assetName:资产名称,assetIp:资产IP,destSecurityZone:安全域,assetType:资产类型,appProtocol:应用协议,requestUrl:请求URL,clearText:明文传输内容,alarmResults:攻击结果,aggCount:次数');
COMMIT;