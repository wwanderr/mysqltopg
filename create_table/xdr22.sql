/*
 Navicat Premium Data Transfer

 Source Server         : 10.20.183.170
 Source Server Type    : PostgreSQL
 Source Server Version : 160003 (160003)
 Source Host           : 10.20.183.170:5432
 Source Catalog        : xdr
 Source Schema         : xdr22

 Target Server Type    : PostgreSQL
 Target Server Version : 160003 (160003)
 File Encoding         : 65001

 Date: 16/01/2026 09:48:30
*/


-- ----------------------------
-- Type structure for t_isolation_history_action
-- ----------------------------
DROP TYPE IF EXISTS "t_isolation_history_action";
CREATE TYPE "t_isolation_history_action" AS ENUM (
  '主机一键隔离',
  '主机取消隔离',
  '未知'
);
ALTER TYPE "t_isolation_history_action" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_log_correlation_job_status
-- ----------------------------
DROP TYPE IF EXISTS "t_log_correlation_job_status";
CREATE TYPE "t_log_correlation_job_status" AS ENUM (
  'Todo',
  'Waiting'
);
ALTER TYPE "t_log_correlation_job_status" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_notice_history_contact_type
-- ----------------------------
DROP TYPE IF EXISTS "t_notice_history_contact_type";
CREATE TYPE "t_notice_history_contact_type" AS ENUM (
  'sms',
  'email',
  'dingtalk',
  'predict',
  'order',
  'firewall',
  'wechat'
);
ALTER TYPE "t_notice_history_contact_type" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_process_kill_history_action
-- ----------------------------
DROP TYPE IF EXISTS "t_process_kill_history_action";
CREATE TYPE "t_process_kill_history_action" AS ENUM (
  '病毒查杀',
  '未知'
);
ALTER TYPE "t_process_kill_history_action" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_detail_scan_scope
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_detail_scan_scope";
CREATE TYPE "t_scan_history_detail_scan_scope" AS ENUM (
  'full',
  'custom'
);
ALTER TYPE "t_scan_history_detail_scan_scope" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_detail_scan_type
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_detail_scan_type";
CREATE TYPE "t_scan_history_detail_scan_type" AS ENUM (
  'virus',
  'site',
  'vulnerability'
);
ALTER TYPE "t_scan_history_detail_scan_type" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_detail_status
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_detail_status";
CREATE TYPE "t_scan_history_detail_status" AS ENUM (
  '正在扫描',
  '扫描完成',
  '扫描失败'
);
ALTER TYPE "t_scan_history_detail_status" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_node_os
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_node_os";
CREATE TYPE "t_scan_history_node_os" AS ENUM (
  'Windows',
  'Linux'
);
ALTER TYPE "t_scan_history_node_os" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_site_status
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_site_status";
CREATE TYPE "t_scan_history_site_status" AS ENUM (
  '无下发记录',
  '正在扫描',
  '扫描完成',
  '扫描失败'
);
ALTER TYPE "t_scan_history_site_status" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_virus_status
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_virus_status";
CREATE TYPE "t_scan_history_virus_status" AS ENUM (
  '无下发记录',
  '正在扫描',
  '扫描完成',
  '扫描失败'
);
ALTER TYPE "t_scan_history_virus_status" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_history_vulnerability_status
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_history_vulnerability_status";
CREATE TYPE "t_scan_history_vulnerability_status" AS ENUM (
  '无下发记录',
  '正在扫描',
  '扫描完成',
  '扫描失败'
);
ALTER TYPE "t_scan_history_vulnerability_status" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_scan_job_scan_scope
-- ----------------------------
DROP TYPE IF EXISTS "t_scan_job_scan_scope";
CREATE TYPE "t_scan_job_scan_scope" AS ENUM (
  'full',
  'custom'
);
ALTER TYPE "t_scan_job_scan_scope" OWNER TO "dbapp";

-- ----------------------------
-- Type structure for t_virus_kill_history_action
-- ----------------------------
DROP TYPE IF EXISTS "t_virus_kill_history_action";
CREATE TYPE "t_virus_kill_history_action" AS ENUM (
  '病毒查杀',
  '未知'
);
ALTER TYPE "t_virus_kill_history_action" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_alarm_out_going_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_alarm_out_going_config_id_seq";
CREATE SEQUENCE "t_alarm_out_going_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_alarm_out_going_config_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_alarm_status_timing_task_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_alarm_status_timing_task_id_seq";
CREATE SEQUENCE "t_alarm_status_timing_task_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_alarm_status_timing_task_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_atip_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_atip_config_id_seq";
CREATE SEQUENCE "t_atip_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_atip_config_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_attack_knowledge_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_attack_knowledge_id_seq";
CREATE SEQUENCE "t_attack_knowledge_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_attack_knowledge_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_attacker_traffic_task_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_attacker_traffic_task_id_seq";
CREATE SEQUENCE "t_attacker_traffic_task_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_attacker_traffic_task_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_block_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_block_history_id_seq";
CREATE SEQUENCE "t_block_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_block_history_id_seq" OWNER TO "dbapp";

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
-- Sequence structure for t_common_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_common_config_id_seq";
CREATE SEQUENCE "t_common_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_common_config_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_event_out_going_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_event_out_going_config_id_seq";
CREATE SEQUENCE "t_event_out_going_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_event_out_going_config_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_event_out_going_data_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_event_out_going_data_id_seq";
CREATE SEQUENCE "t_event_out_going_data_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_event_out_going_data_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_event_scenario_data_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_event_scenario_data_id_seq";
CREATE SEQUENCE "t_event_scenario_data_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_event_scenario_data_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_event_scenario_template_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_event_scenario_template_id_seq";
CREATE SEQUENCE "t_event_scenario_template_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_event_scenario_template_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_event_template_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_event_template_id_seq";
CREATE SEQUENCE "t_event_template_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_event_template_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_intelligence_sub_asset_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_intelligence_sub_asset_id_seq";
CREATE SEQUENCE "t_intelligence_sub_asset_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_intelligence_sub_asset_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_intelligence_sub_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_intelligence_sub_id_seq";
CREATE SEQUENCE "t_intelligence_sub_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_intelligence_sub_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_isolation_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_isolation_history_id_seq";
CREATE SEQUENCE "t_isolation_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_isolation_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_linkage_strategy_validtime_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_linkage_strategy_validtime_id_seq";
CREATE SEQUENCE "t_linkage_strategy_validtime_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_linkage_strategy_validtime_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_linked_strategy_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_linked_strategy_id_seq";
CREATE SEQUENCE "t_linked_strategy_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_linked_strategy_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_linked_strategy_template_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_linked_strategy_template_id_seq";
CREATE SEQUENCE "t_linked_strategy_template_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_linked_strategy_template_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_log_correlation_job_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_log_correlation_job_id_seq";
CREATE SEQUENCE "t_log_correlation_job_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_log_correlation_job_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_notice_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_notice_history_id_seq";
CREATE SEQUENCE "t_notice_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_notice_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_out_going_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_out_going_config_id_seq";
CREATE SEQUENCE "t_out_going_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_out_going_config_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_process_chain_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_process_chain_history_id_seq";
CREATE SEQUENCE "t_process_chain_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_process_chain_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_process_chain_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_process_chain_id_seq";
CREATE SEQUENCE "t_process_chain_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_process_chain_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_process_kill_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_process_kill_history_id_seq";
CREATE SEQUENCE "t_process_kill_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_process_kill_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_prohibit_domain_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_prohibit_domain_history_id_seq";
CREATE SEQUENCE "t_prohibit_domain_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_prohibit_domain_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_prohibit_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_prohibit_history_id_seq";
CREATE SEQUENCE "t_prohibit_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_prohibit_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_query_template_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_query_template_id_seq";
CREATE SEQUENCE "t_query_template_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_query_template_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_risk_incidents_analysis_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_risk_incidents_analysis_id_seq";
CREATE SEQUENCE "t_risk_incidents_analysis_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_risk_incidents_analysis_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_risk_incidents_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_risk_incidents_history_id_seq";
CREATE SEQUENCE "t_risk_incidents_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_risk_incidents_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_risk_incidents_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_risk_incidents_id_seq";
CREATE SEQUENCE "t_risk_incidents_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_risk_incidents_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_risk_incidents_out_going_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_risk_incidents_out_going_history_id_seq";
CREATE SEQUENCE "t_risk_incidents_out_going_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_risk_incidents_out_going_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_risk_incidents_out_going_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_risk_incidents_out_going_id_seq";
CREATE SEQUENCE "t_risk_incidents_out_going_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_risk_incidents_out_going_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_risk_out_going_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_risk_out_going_config_id_seq";
CREATE SEQUENCE "t_risk_out_going_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_risk_out_going_config_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_scan_history_detail_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_scan_history_detail_id_seq";
CREATE SEQUENCE "t_scan_history_detail_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_scan_history_detail_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_scan_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_scan_history_id_seq";
CREATE SEQUENCE "t_scan_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_scan_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_scan_job_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_scan_job_id_seq";
CREATE SEQUENCE "t_scan_job_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_scan_job_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_scene_rule_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_scene_rule_config_id_seq";
CREATE SEQUENCE "t_scene_rule_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_scene_rule_config_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_scene_rule_info_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_scene_rule_info_id_seq";
CREATE SEQUENCE "t_scene_rule_info_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_scene_rule_info_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_security_alarm_handle_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_security_alarm_handle_id_seq";
CREATE SEQUENCE "t_security_alarm_handle_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_security_alarm_handle_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_security_incidents_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_security_incidents_id_seq";
CREATE SEQUENCE "t_security_incidents_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_security_incidents_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_security_types_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_security_types_id_seq";
CREATE SEQUENCE "t_security_types_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_security_types_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_strategy_device_rel_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_strategy_device_rel_id_seq";
CREATE SEQUENCE "t_strategy_device_rel_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_strategy_device_rel_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_tag_search_list_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_tag_search_list_id_seq";
CREATE SEQUENCE "t_tag_search_list_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_tag_search_list_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_virus_kill_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_virus_kill_history_id_seq";
CREATE SEQUENCE "t_virus_kill_history_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_virus_kill_history_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Sequence structure for t_vul_analysis_sub_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_vul_analysis_sub_id_seq";
CREATE SEQUENCE "t_vul_analysis_sub_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_vul_analysis_sub_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_alarm_out_going_config
-- ----------------------------
DROP TABLE IF EXISTS "t_alarm_out_going_config";
CREATE TABLE "t_alarm_out_going_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_alarm_out_going_config_id_seq'::regclass),
  "alarm_source" text COLLATE "pg_catalog"."default",
  "sub_category" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(50) COLLATE "pg_catalog"."default",
  "alarm_results" varchar(50) COLLATE "pg_catalog"."default",
  "enable" int4 NOT NULL DEFAULT 1,
  "mapping_config_path" varchar(100) COLLATE "pg_catalog"."default",
  "is_del" int4 NOT NULL DEFAULT 0,
  "last_send_result" varchar(10) COLLATE "pg_catalog"."default",
  "cause_of_failure" text COLLATE "pg_catalog"."default",
  "last_send_time" timestamptz(6),
  "send_count" int8 DEFAULT '0'::bigint,
  "succeed_count" int8 DEFAULT '0'::bigint,
  "create_time" timestamptz(6),
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_alarm_out_going_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_alarm_out_going_config"."id" IS '主键自增id';
COMMENT ON COLUMN "t_alarm_out_going_config"."alarm_source" IS '告警来源（数组）';
COMMENT ON COLUMN "t_alarm_out_going_config"."sub_category" IS '告警子类型（数组）';
COMMENT ON COLUMN "t_alarm_out_going_config"."threat_severity" IS '威胁等级（数组）';
COMMENT ON COLUMN "t_alarm_out_going_config"."alarm_results" IS '告警结果（数组）';
COMMENT ON COLUMN "t_alarm_out_going_config"."enable" IS '是否开启（1是，0否）';
COMMENT ON COLUMN "t_alarm_out_going_config"."mapping_config_path" IS '映射文件路径';
COMMENT ON COLUMN "t_alarm_out_going_config"."is_del" IS '是否已删除（1是，0否）';
COMMENT ON COLUMN "t_alarm_out_going_config"."last_send_result" IS '上次发送结果';
COMMENT ON COLUMN "t_alarm_out_going_config"."cause_of_failure" IS '发送失败的原因';
COMMENT ON COLUMN "t_alarm_out_going_config"."last_send_time" IS '上次发送时间';
COMMENT ON COLUMN "t_alarm_out_going_config"."send_count" IS '发送总次数';
COMMENT ON COLUMN "t_alarm_out_going_config"."succeed_count" IS '成功发送次数';
COMMENT ON COLUMN "t_alarm_out_going_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_alarm_out_going_config"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_alarm_out_going_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_alarm_status_timing_task
-- ----------------------------
DROP TABLE IF EXISTS "t_alarm_status_timing_task";
CREATE TABLE "t_alarm_status_timing_task" (
  "id" int8 NOT NULL DEFAULT nextval('t_alarm_status_timing_task_id_seq'::regclass),
  "task_type" varchar(50) COLLATE "pg_catalog"."default",
  "alarm_status" varchar(20) COLLATE "pg_catalog"."default",
  "remarks" text COLLATE "pg_catalog"."default",
  "operator" varchar(150) COLLATE "pg_catalog"."default",
  "condition" text COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6),
  "task_end_time" timestamptz(6),
  "associated_field" varchar(100) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_alarm_status_timing_task" OWNER TO "dbapp";
COMMENT ON COLUMN "t_alarm_status_timing_task"."id" IS '主键自增id';
COMMENT ON COLUMN "t_alarm_status_timing_task"."task_type" IS '任务类型（区分不同模块）';
COMMENT ON COLUMN "t_alarm_status_timing_task"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_alarm_status_timing_task"."remarks" IS '备注';
COMMENT ON COLUMN "t_alarm_status_timing_task"."operator" IS '责任人';
COMMENT ON COLUMN "t_alarm_status_timing_task"."condition" IS '处置条件（以JSON格式存储）';
COMMENT ON COLUMN "t_alarm_status_timing_task"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_alarm_status_timing_task"."task_end_time" IS '任务结束时间';
COMMENT ON COLUMN "t_alarm_status_timing_task"."associated_field" IS '关联字段';

-- ----------------------------
-- Records of t_alarm_status_timing_task
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_atip_config
-- ----------------------------
DROP TABLE IF EXISTS "t_atip_config";
CREATE TABLE "t_atip_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_atip_config_id_seq'::regclass),
  "host" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "port" varchar(255) COLLATE "pg_catalog"."default",
  "is_ssl" int2 NOT NULL DEFAULT '0'::smallint,
  "is_report" int2 NOT NULL DEFAULT '0'::smallint,
  "user" varchar(255) COLLATE "pg_catalog"."default",
  "token" varchar(255) COLLATE "pg_catalog"."default",
  "device_id" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_atip_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_atip_config"."id" IS '主键ID';
COMMENT ON COLUMN "t_atip_config"."host" IS 'host';
COMMENT ON COLUMN "t_atip_config"."port" IS '端口';
COMMENT ON COLUMN "t_atip_config"."is_ssl" IS '是否http';
COMMENT ON COLUMN "t_atip_config"."is_report" IS '是否上报';
COMMENT ON COLUMN "t_atip_config"."user" IS '账号';
COMMENT ON COLUMN "t_atip_config"."token" IS '密码';
COMMENT ON COLUMN "t_atip_config"."device_id" IS '联动设备id';
COMMENT ON COLUMN "t_atip_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_atip_config"."update_time" IS '更新时间';
COMMENT ON TABLE "t_atip_config" IS 'atip配置表';

-- ----------------------------
-- Records of t_atip_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_attack_knowledge
-- ----------------------------
DROP TABLE IF EXISTS "t_attack_knowledge";
CREATE TABLE "t_attack_knowledge" (
  "id" int8 NOT NULL DEFAULT nextval('t_attack_knowledge_id_seq'::regclass),
  "technique_code" varchar(200) COLLATE "pg_catalog"."default",
  "technique_name" varchar(200) COLLATE "pg_catalog"."default",
  "technique_name_ch" varchar(200) COLLATE "pg_catalog"."default",
  "parent_code" varchar(200) COLLATE "pg_catalog"."default",
  "level" varchar(50) COLLATE "pg_catalog"."default",
  "os" varchar(100) COLLATE "pg_catalog"."default",
  "perspective" varchar(100) COLLATE "pg_catalog"."default",
  "device_type" varchar(100) COLLATE "pg_catalog"."default",
  "sort" int8
)
;
ALTER TABLE "t_attack_knowledge" OWNER TO "dbapp";
COMMENT ON COLUMN "t_attack_knowledge"."id" IS '主键id';
COMMENT ON COLUMN "t_attack_knowledge"."technique_code" IS '技术code';
COMMENT ON COLUMN "t_attack_knowledge"."technique_name" IS '技术名称';
COMMENT ON COLUMN "t_attack_knowledge"."technique_name_ch" IS '技术中文名称';
COMMENT ON COLUMN "t_attack_knowledge"."parent_code" IS '父技术code';
COMMENT ON COLUMN "t_attack_knowledge"."level" IS '技术类型等级';
COMMENT ON COLUMN "t_attack_knowledge"."os" IS '操作系统';
COMMENT ON COLUMN "t_attack_knowledge"."perspective" IS '视角';
COMMENT ON COLUMN "t_attack_knowledge"."device_type" IS '类型';
COMMENT ON COLUMN "t_attack_knowledge"."sort" IS '排序';

-- ----------------------------
-- Records of t_attack_knowledge
-- ----------------------------
BEGIN;
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (1, 'T1548', 'Abuse Elevation Control Mechanism', '滥用提升控制机制', 'TA0004', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (2, 'T1548.002', 'Abuse Elevation Control Mechanism: Bypass User Account Control', '滥用权限控制机制：绕过用户帐户控制', 'T1548', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (3, 'T1548.001', 'Abuse Elevation Control Mechanism: Setuid and Setgid', '滥用提权控制机制：Setuid和Setgid', 'T1548', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (4, 'T1548.003', 'Abuse Elevation Control Mechanism: Sudo and Sudo Caching', '滥用提升控制机制：Sudo 和 Sudo 缓存', 'T1548', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (5, 'T1134', 'Access Token Manipulation', '访问令牌操作', 'TA0004', 'technique', 'windows', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (6, 'T1134.002', 'Access Token Manipulation: Create Process with Token', '访问令牌操作：使用令牌创建进程', 'T1134', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (7, 'T1134.003', 'Access Token Manipulation: Make and Impersonate Token', '访问令牌操作：制作和模拟令牌', 'T1134', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (8, 'T1134.004', 'Access Token Manipulation: Parent PID Spoofing', '访问令牌操纵：父 PID 欺骗', 'T1134', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (9, 'T1134.001', 'Access Token Manipulation: Token Impersonation/Theft', '访问令牌操纵：令牌模拟/盗窃', 'T1134', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (10, 'T1531', 'Account Access Removal', '删除帐户访问权限', 'TA0040', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (11, 'T1087', 'Account Discovery', '帐户发现', 'TA0007', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (12, 'T1087.002', 'Account Discovery: Domain Account', '帐户发现：域帐户', 'T1087', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (13, 'T1087.003', 'Account Discovery: Email Account', '帐户发现：电子邮件帐户', 'T1087', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (14, 'T1087.001', 'Account Discovery: Local Account', '帐户发现：本地帐户', 'T1087', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (15, 'T1098', 'Account Manipulation', '账户操纵', 'TA0003', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (16, 'T1098.004', 'Account Manipulation: SSH Authorized Keys', '帐户操作：SSH 授权密钥', 'T1098', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (17, 'T1595', 'Active Scanning', '主动扫描', 'TA0043', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (18, 'T1595.001', 'Active Scanning: Scanning IP Blocks', '主动扫描：扫描 IP 块', 'T1595', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (19, 'T1595.002', 'Active Scanning: Vulnerability Scanning', '主动扫描：漏洞扫描', 'T1595', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (20, 'T1557', 'Adversary-in-the-Middle', '中间对手', 'TA0006', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (21, 'T1557.002', 'Adversary-in-the-Middle: ARP Cache Poisoning', '中间人：ARP 缓存中毒', 'T1557', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (22, 'T1557.001', 'Adversary-in-the-Middle: LLMNR/NBT-NS Poisoning and SMB Relay', '中间对手：LLMNR/NBT-NS 中毒和 SMB 中继', 'T1557', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (23, 'T1071', 'Application Layer Protocol', '应用层协议', 'TA0011', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (24, 'T1071.004', 'Application Layer Protocol: DNS', '应用层协议：DNS', 'T1071', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (25, 'T1071.002', 'Application Layer Protocol: File Transfer Protocols', '应用层协议：文件传输协议', 'T1071', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (26, 'T1071.001', 'Application Layer Protocol: Web Protocols', '应用层协议：Web 协议', 'T1071', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (27, 'T1010', 'Application Window Discovery', '应用程序窗口发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (28, 'T1560', 'Archive Collected Data', '存档收集的数据', 'TA0009', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (29, 'T1560.002', 'Archive Collected Data: Archive via Library', '存档收集的数据：通过图书馆存档', 'T1560', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (30, 'T1560.001', 'Archive Collected Data: Archive via Utility', '存档收集的数据：通过实用程序存档', 'T1560', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (31, 'T1123', 'Audio Capture', '音频采集', 'TA0009', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (32, 'T1119', 'Automated Collection', '自动收集', 'TA0009', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (33, 'T1020', 'Automated Exfiltration', '自动渗漏', 'TA0010', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (34, 'T1197', 'BITS Jobs', 'BITS Jobs', 'TA0003', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (35, 'T1547', 'Boot or Logon Autostart Execution', '引导或登录自动启动执行', 'TA0003', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (36, 'T1547.002', 'Boot or Logon Autostart Execution: Authentication Package', '引导或登录自动启动执行：身份验证包', 'T1547', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (37, 'T1547.006', 'Boot or Logon Autostart Execution: Kernel Modules and Extensions', '引导或登录自动启动执行：内核模块和扩展', 'T1547', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (38, 'T1547.010', 'Boot or Logon Autostart Execution: Port Monitors', '引导或登录自动启动执行：端口监视器', 'T1547', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (39, 'T1547.001', 'Boot or Logon Autostart Execution: Registry Run Keys / Startup Folder', '引导或登录自动启动执行：注册表运行键/启动文件夹', 'T1547', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (40, 'T1547.005', 'Boot or Logon Autostart Execution: Security Support Provider', '引导或登录自动启动执行：安全支持提供程序', 'T1547', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (41, 'T1547.004', 'Boot or Logon Autostart Execution: Winlogon Helper DLL', '引导或登录自动启动执行：Winlogon Helper DLL', 'T1547', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (42, 'T1547.013', 'Boot or Logon Autostart Execution: XDG Autostart Entries', '引导或登录自动启动执行：XDG 自动启动条目', 'T1547', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (43, 'T1037', 'Boot or Logon Initialization Scripts', '引导或登录初始化脚本', 'TA0003', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (44, 'T1037.001', 'Boot or Logon Initialization Scripts: Logon Script (Windows)', '引导或登录初始化脚本：登录脚本 (Windows)', 'T1037', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (45, 'T1217', 'Browser Bookmark Discovery', '浏览器书签发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (46, 'T1176', 'Browser Extensions', '浏览器扩展', 'TA0003', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (47, 'T1110', 'Brute Force', '暴力破解', 'TA0006', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (48, 'T1110.002', 'Brute Force: Password Cracking', '暴力破解：密码破解', 'T1110', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (49, 'T1110.001', 'Brute Force: Password Guessing', '暴力破解：密码猜测', 'T1110', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (50, 'T1115', 'Clipboard Data', '剪贴板数据', 'TA0009', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (51, 'T1059', 'Command and Scripting Interpreter', '命令和脚本解释器', 'TA0002', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (52, 'T1059.007', 'Command and Scripting Interpreter: JavaScript', '命令和脚本解释器：JavaScript', 'T1059', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (53, 'T1059.001', 'Command and Scripting Interpreter: PowerShell', '命令和脚本解释器：PowerShell', 'T1059', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (54, 'T1059.006', 'Command and Scripting Interpreter: Python', '命令和脚本解释器：Python', 'T1059', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (55, 'T1059.004', 'Command and Scripting Interpreter: Unix Shell', '命令和脚本解释器：Unix Shell', 'T1059', 'technique', 'linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (56, 'T1059.005', 'Command and Scripting Interpreter: Visual Basic', '命令和脚本解释器：Visual Basic', 'T1059', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (57, 'T1059.003', 'Command and Scripting Interpreter: Windows Command Shell', '命令和脚本解释器：Windows Command Shell', 'T1059', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (58, 'T1136', 'Create Account', '创建账户', 'TA0003', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (59, 'T1136.002', 'Create Account: Domain Account', '创建账户：域账户', 'T1136', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (60, 'T1136.001', 'Create Account: Local Account', '创建账户：本地账户', 'T1136', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (61, 'T1543', 'Create or Modify System Process', '创建或修改系统进程', 'TA0003', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (62, 'T1543.002', 'Create or Modify System Process: Systemd Service', '创建或修改系统进程：Systemd Service', 'T1543', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (63, 'T1543.003', 'Create or Modify System Process: Windows Service', '创建或修改系统进程：Windows 服务', 'T1543', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (64, 'T1555', 'Credentials from Password Stores', '来自密码存储的凭据', 'TA0006', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (65, 'T1555.003', 'Credentials from Password Stores: Credentials from Web Browsers', '来自密码存储的凭据：来自 Web 浏览器的凭据', 'T1555', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (66, 'T1555.005', 'Credentials from Password Stores: Password Managers', '来自密码存储的凭据：密码管理器', 'T1555', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (67, 'T1555.002', 'Credentials from Password Stores: Securityd Memory', '来自密码存储的凭据：安全内存', 'T1555', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (68, 'T1485', 'Data Destruction', '数据销毁', 'TA0040', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (69, 'T1132', 'Data Encoding', '数据编码', 'TA0011', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (70, 'T1132.001', 'Data Encoding: Standard Encoding', '数据编码：标准编码', 'T1132', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (71, 'T1486', 'Data Encrypted for Impact', '为影响而加密的数据', 'TA0040', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (72, 'T1565', 'Data Manipulation', '数据操作', 'TA0040', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (73, 'T1565.001', 'Data Manipulation: Stored Data Manipulation', '数据操作：存储数据操作', 'T1565', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (74, 'T1001', 'Data Obfuscation', '数据混淆', 'TA0011', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (75, 'T1001.001', 'Data Obfuscation: Junk Data', '数据混淆：垃圾数据', 'T1001', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (76, 'T1074', 'Data Staged', '数据暂存', 'TA0009', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (77, 'T1074.001', 'Data Staged: Local Data Staging', '数据暂存：本地数据暂存', 'T1074', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (78, 'T1074.002', 'Data Staged: Remote Data Staging', '数据暂存：远程数据暂存', 'T1074', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (79, 'T1030', 'Data Transfer Size Limits', '数据传输大小限制', 'TA0010', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (80, 'T1213', 'Data from Information Repositories', '来自信息库的数据', 'TA0009', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (81, 'T1005', 'Data from Local System', '来自本地系统的数据', 'TA0009', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (82, 'T1491', 'Defacement', '污损', 'TA0040', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (83, 'T1140', 'Deobfuscate/Decode Files or Information', '去混淆/解码文件或信息', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (84, 'T1561', 'Disk Wipe', '磁盘擦除', 'TA0040', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (85, 'T1561.001', 'Disk Wipe: Disk Content Wipe', '磁盘擦除：磁盘内容擦除', 'T1561', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (86, 'T1484', 'Domain Policy Modification', '域策略修改', 'TA0004', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (87, 'T1484.001', 'Domain Policy Modification: Group Policy Modification', '域策略修改：组策略修改', 'T1484', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (88, 'T1482', 'Domain Trust Discovery', '域信任发现', 'TA0007', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (89, 'T1189', 'Drive-by Compromise', '偷渡式妥协', 'TA0001', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (90, 'T1568', 'Dynamic Resolution', '动态分辨率', 'TA0011', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (91, 'T1568.003', 'Dynamic Resolution: DNS Calculation', '动态解析：DNS计算', 'T1568', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (92, 'T1114', 'Email Collection', '电子邮件收集', 'TA0009', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (93, 'T1114.001', 'Email Collection: Local Email Collection', '邮件收集：本地邮件收集', 'T1114', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (94, 'T1573', 'Encrypted Channel', '加密频道', 'TA0011', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (95, 'T1573.002', 'Encrypted Channel: Asymmetric Cryptography', '加密通道：非对称密码学', 'T1573', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (96, 'T1499', 'Endpoint Denial of Service', '端点拒绝服务', 'TA0040', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (97, 'T1499.002', 'Endpoint Denial of Service: Service Exhaustion Flood', '端点拒绝服务：服务耗尽泛滥', 'T1499', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (98, 'T1546', 'Event Triggered Execution', '事件触发执行', 'TA0003', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (99, 'T1546.008', 'Event Triggered Execution: Accessibility Features', '事件触发执行：辅助功能', 'T1546', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (100, 'T1546.009', 'Event Triggered Execution: AppCert DLLs', '事件触发执行：AppCert DLL', 'T1546', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (101, 'T1546.010', 'Event Triggered Execution: AppInit DLLs', '事件触发执行：AppInit DLL', 'T1546', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (102, 'T1546.011', 'Event Triggered Execution: Application Shimming', '事件触发执行：应用程序填充', 'T1546', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (103, 'T1546.001', 'Event Triggered Execution: Change Default File Association', '事件触发执行：更改默认文件关联', 'T1546', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (104, 'T1546.015', 'Event Triggered Execution: Component Object Model Hijacking', '事件触发执行：组件对象模型劫持', 'T1546', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (105, 'T1546.012', 'Event Triggered Execution: Image File Execution Options Injection', '事件触发执行：图像文件执行选项注入', 'T1546', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (106, 'T1546.007', 'Event Triggered Execution: Netsh Helper DLL', '事件触发执行：Netsh Helper DLL', 'T1546', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (107, 'T1546.013', 'Event Triggered Execution: PowerShell Profile', '事件触发执行：PowerShell 配置文件', 'T1546', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (108, 'T1546.002', 'Event Triggered Execution: Screensaver', '事件触发执行：屏幕保护程序', 'T1546', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (109, 'T1546.005', 'Event Triggered Execution: Trap', '事件触发执行：陷阱', 'T1546', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (110, 'T1546.004', 'Event Triggered Execution: Unix Shell Configuration Modification', '事件触发执行：Unix Shell 配置修改', 'T1546', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (111, 'T1048', 'Exfiltration Over Alternative Protocol', '通过替代协议进行渗漏', 'TA0010', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (112, 'T1048.003', 'Exfiltration Over Alternative Protocol: Exfiltration Over Unencrypted Non-C2 Protocol', '通过替代协议进行渗漏：通过未加密的非 C2 协议进行渗漏', 'T1048', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (113, 'T1041', 'Exfiltration Over C2 Channel', '通过 C2 通道渗透', 'TA0010', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (114, 'T1011', 'Exfiltration Over Other Network Medium', '通过其他网络介质渗出', 'TA0010', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (115, 'T1052', 'Exfiltration Over Physical Medium', '通过物理介质渗出', 'TA0010', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (116, 'T1052.001', 'Exfiltration Over Physical Medium: Exfiltration over USB', '通过物理介质渗出：通过 USB 渗出', 'T1052', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (117, 'T1567', 'Exfiltration Over Web Service', '通过 Web 服务进行渗漏', 'TA0010', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (118, 'T1190', 'Exploit Public-Facing Application', '利用面向公众的应用程序', 'TA0001', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (119, 'T1203', 'Exploitation for Client Execution', '利用客户端执行', 'TA0002', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (120, 'T1212', 'Exploitation for Credential Access', '利用凭证访问', 'TA0006', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (121, 'T1211', 'Exploitation for Defense Evasion', '利用防御规避', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (122, 'T1068', 'Exploitation for Privilege Escalation', '利用特权升级', 'TA0004', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (123, 'T1210', 'Exploitation of Remote Services', '远程服务的利用', 'TA0008', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (124, 'T1133', 'External Remote Services', '外部远程服务', 'TA0001', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (125, 'T1083', 'File and Directory Discovery', '文件和目录发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (126, 'T1222', 'File and Directory Permissions Modification', '文件和目录权限修改', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (127, 'T1222.002', 'File and Directory Permissions Modification: Linux and Mac File and Directory Permissions Modification', '文件和目录权限修改：Linux和Mac文件和目录权限修改', 'T1222', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (128, 'T1222.001', 'File and Directory Permissions Modification: Windows File and Directory Permissions Modification', '文件和目录权限修改：Windows文件和目录权限修改', 'T1222', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (129, 'T1606', 'Forge Web Credentials', '伪造网络凭证', 'TA0006', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (130, 'T1606.002', 'Forge Web Credentials: SAML Tokens', '伪造 Web 凭证：SAML 令牌', 'T1606', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (131, 'T1606.001', 'Forge Web Credentials: Web Cookies', '伪造 Web 凭据：Web Cookie', 'T1606', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (132, 'T1592', 'Gather Victim Host Information', '收集受害者主机信息', 'TA0043', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (133, 'T1592.004', 'Gather Victim Host Information: Client Configurations', '收集受害者主机信息：客户端配置', 'T1592', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (134, 'T1589', 'Gather Victim Identity Information', '收集受害者身份信息', 'TA0043', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (135, 'T1591', 'Gather Victim Org Information', '收集受害者组织信息', 'TA0043', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (136, 'T1200', 'Hardware Additions', '硬件添加', 'TA0001', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (137, 'T1564', 'Hide Artifacts', '隐藏文物', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (138, 'T1564.005', 'Hide Artifacts: Hidden File System', '隐藏神器：隐藏文件系统', 'T1564', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (139, 'T1564.001', 'Hide Artifacts: Hidden Files and Directories', '隐藏工件：隐藏文件和目录', 'T1564', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (140, 'T1564.002', 'Hide Artifacts: Hidden Users', '隐藏工件：隐藏用户', 'T1564', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (141, 'T1564.003', 'Hide Artifacts: Hidden Window', '隐藏工件：隐藏窗口', 'T1564', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (142, 'T1564.004', 'Hide Artifacts: NTFS File Attributes', '隐藏工件：NTFS 文件属性', 'T1564', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (143, 'T1564.007', 'Hide Artifacts: VBA Stomping', '隐藏工件：VBA 踩踏', 'T1564', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (144, 'T1574', 'Hijack Execution Flow', '劫持执行流程', 'TA0003', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (145, 'T1574.012', 'Hijack Execution Flow: COR_PROFILER', '劫持执行流程：COR_PROFILER', 'T1574', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (146, 'T1574.001', 'Hijack Execution Flow: DLL Search Order Hijacking', '劫持执行流程：DLL搜索顺序劫持', 'T1574', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (147, 'T1574.002', 'Hijack Execution Flow: DLL Side-Loading', '劫持执行流程：DLL 侧加载', 'T1574', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (148, 'T1574.006', 'Hijack Execution Flow: Dynamic Linker Hijacking', '劫持执行流程：动态链接器劫持', 'T1574', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (149, 'T1574.005', 'Hijack Execution Flow: Executable Installer File Permissions Weakness', '劫持执行流程：可执行安装程序文件权限弱点', 'T1574', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (150, 'T1574.008', 'Hijack Execution Flow: Path Interception by Search Order Hijacking', '劫持执行流程：通过搜索顺序劫持进行路径拦截', 'T1574', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (151, 'T1574.011', 'Hijack Execution Flow: Services Registry Permissions Weakness', '劫持执行流程：服务注册权限弱点', 'T1574', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (152, 'T1562', 'Impair Defenses', '削弱防御', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (153, 'T1562.002', 'Impair Defenses: Disable Windows Event Logging', '削弱防御：禁用 Windows 事件日志记录', 'T1562', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (154, 'T1562.004', 'Impair Defenses: Disable or Modify System Firewall', '削弱防御：禁用或修改系统防火墙', 'T1562', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (155, 'T1562.001', 'Impair Defenses: Disable or Modify Tools', '削弱防御：禁用或修改工具', 'T1562', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (156, 'T1562.003', 'Impair Defenses: Impair Command History Logging', '削弱防御：削弱命令历史记录', 'T1562', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (157, 'T1562.006', 'Impair Defenses: Indicator Blocking', '削弱防御：指示器阻塞', 'T1562', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (158, 'T1070', 'Indicator Removal', '指标删除', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (159, 'T1070.003', 'Indicator Removal: Clear Command History', '指示器删除：清除命令历史记录', 'T1070', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (160, 'T1070.002', 'Indicator Removal: Clear Linux or Mac System Logs', '指标删除：清除 Linux 或 Mac 系统日志', 'T1070', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (161, 'T1070.001', 'Indicator Removal: Clear Windows Event Logs', '指标删除：清除 Windows 事件日志', 'T1070', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (162, 'T1070.004', 'Indicator Removal: File Deletion', '指标删除：文件删除', 'T1070', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (163, 'T1070.005', 'Indicator Removal: Network Share Connection Removal', '指标删除：网络共享连接删除', 'T1070', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (164, 'T1070.006', 'Indicator Removal: Timestomp', '指标移除：Timestomp', 'T1070', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (165, 'T1202', 'Indirect Command Execution', '间接命令执行', 'TA0005', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (166, 'T1105', 'Ingress Tool Transfer', '入口工具传输', 'TA0011', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (167, 'T1490', 'Inhibit System Recovery', '禁止系统恢复', 'TA0040', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (168, 'T1056', 'Input Capture', '输入捕捉', 'TA0006', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (169, 'T1056.002', 'Input Capture: GUI Input Capture', '输入捕获：GUI 输入捕获', 'T1056', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (170, 'T1559', 'Inter-Process Communication', '进程间通信', 'TA0002', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (171, 'T1559.002', 'Inter-Process Communication: Dynamic Data Exchange', '进程间通信：动态数据交换', 'T1559', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (172, 'T1570', 'Lateral Tool Transfer', '横向工具转移', 'TA0008', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (173, 'T1036', 'Masquerading', '伪装', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (174, 'T1036.001', 'Masquerading: Invalid Code Signature', '伪装：无效的代码签名', 'T1036', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (175, 'T1036.004', 'Masquerading: Masquerade Task or Service', '伪装：伪装任务或服务', 'T1036', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (176, 'T1036.005', 'Masquerading: Match Legitimate Name or Location', '伪装：匹配合法名称或位置', 'T1036', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (177, 'T1036.003', 'Masquerading: Rename System Utilities', '伪装：重命名系统实用程序', 'T1036', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (178, 'T1036.006', 'Masquerading: Space after Filename', '伪装：文件名后的空格', 'T1036', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (179, 'T1556', 'Modify Authentication Process', '修改认证流程', 'TA0003', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (180, 'T1556.001', 'Modify Authentication Process: Domain Controller Authentication', '修改认证流程：域控制器认证', 'T1556', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (181, 'T1556.003', 'Modify Authentication Process: Pluggable Authentication Modules', '修改身份验证过程：可插入身份验证模块', 'T1556', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (182, 'T1112', 'Modify Registry', '修改注册表', 'TA0005', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (183, 'T1106', 'Native API', '原生API', 'TA0002', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (184, 'T1498', 'Network Denial of Service', '网络拒绝服务', 'TA0040', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (185, 'T1046', 'Network Service Discovery', '网络服务发现', 'TA0007', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (186, 'T1135', 'Network Share Discovery', '网络共享发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (187, 'T1040', 'Network Sniffing', '网络嗅探', 'TA0006', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (188, 'T1095', 'Non-Application Layer Protocol', '非应用层协议', 'TA0011', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (189, 'T1571', 'Non-Standard Port', '非标准端口', 'TA0011', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (190, 'T1003', 'OS Credential Dumping', '操作系统凭据转储', 'TA0006', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (191, 'T1003.008', 'OS Credential Dumping: /etc/passwd and /etc/shadow', '操作系统凭据转储：/etc/passwd 和 /etc/shadow', 'T1003', 'technique', 'linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (192, 'T1003.005', 'OS Credential Dumping: Cached Domain Credentials', '操作系统凭据转储：缓存的域凭据', 'T1003', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (193, 'T1003.006', 'OS Credential Dumping: DCSync', '操作系统凭据转储：DCSync', 'T1003', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (194, 'T1003.004', 'OS Credential Dumping: LSA Secrets', '操作系统凭据转储：LSA 秘密', 'T1003', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (195, 'T1003.001', 'OS Credential Dumping: LSASS Memory', '操作系统凭据转储：LSASS 内存', 'T1003', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (196, 'T1003.003', 'OS Credential Dumping: NTDS', '操作系统凭据转储：NTDS', 'T1003', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (197, 'T1003.007', 'OS Credential Dumping: Proc Filesystem', '操作系统凭据转储：Proc 文件系统', 'T1003', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (198, 'T1003.002', 'OS Credential Dumping: Security Account Manager', '操作系统凭据转储：安全帐户管理器', 'T1003', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (199, 'T1027', 'Obfuscated Files or Information', '混淆文件或信息', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (200, 'T1027.001', 'Obfuscated Files or Information: Binary Padding', '混淆文件或信息：二进制填充', 'T1027', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (201, 'T1027.004', 'Obfuscated Files or Information: Compile After Delivery', '混淆文件或信息：交付后编译', 'T1027', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (202, 'T1027.005', 'Obfuscated Files or Information: Indicator Removal from Tools', '混淆文件或信息：从工具中删除指示器', 'T1027', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (203, 'T1027.002', 'Obfuscated Files or Information: Software Packing', '混淆文件或信息：软件打包', 'T1027', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (204, 'T1027.003', 'Obfuscated Files or Information: Steganography', '混淆文件或信息：隐写术', 'T1027', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (205, 'T1588', 'Obtain Capabilities', '获得能力', 'TA0042', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (206, 'T1588.001', 'Obtain Capabilities: Malware', '获得能力：恶意软件', 'T1588', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (207, 'T1588.002', 'Obtain Capabilities: Tool', '获得能力：工具', 'T1588', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (208, 'T1137', 'Office Application Startup', '办公应用启动', 'TA0003', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (209, 'T1137.001', 'Office Application Startup: Office Template Macros', 'Office 应用程序启动：Office 模板宏', 'T1137', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (210, 'T1137.002', 'Office Application Startup: Office Test', 'Office 应用程序启动：Office 测试', 'T1137', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (211, 'T1201', 'Password Policy Discovery', '密码策略发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (212, 'T1120', 'Peripheral Device Discovery', '外围设备发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (213, 'T1069', 'Permission Groups Discovery', '权限组发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (214, 'T1069.002', 'Permission Groups Discovery: Domain Groups', '权限组发现：域组', 'T1069', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (215, 'T1069.001', 'Permission Groups Discovery: Local Groups', '权限组发现：本地组', 'T1069', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (216, 'T1566', 'Phishing', '网络钓鱼', 'TA0001', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (217, 'T1598', 'Phishing for Information', '信息网络钓鱼', 'TA0043', 'technique', 'other', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (218, 'T1598.003', 'Phishing for Information: Spearphishing Link', '信息钓鱼：鱼叉式钓鱼链接', 'T1598', 'technique', 'other', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (219, 'T1566.001', 'Phishing: Spearphishing Attachment', '网络钓鱼：鱼叉式网络钓鱼附件', 'T1566', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (220, 'T1542', 'Pre-OS Boot', '预操作系统引导', 'TA0003', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (221, 'T1542.003', 'Pre-OS Boot: Bootkit', '预操作系统启动：Bootkit', 'T1542', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (222, 'T1057', 'Process Discovery', '流程发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (223, 'T1055', 'Process Injection', '进程注入', 'TA0004', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (224, 'T1055.001', 'Process Injection: Dynamic-link Library Injection', '进程注入：动态链接库注入', 'T1055', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (225, 'T1055.002', 'Process Injection: Portable Executable Injection', '进程注入：可移植可执行注入', 'T1055', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (226, 'T1055.012', 'Process Injection: Process Hollowing', '进程注入：工艺镂空', 'T1055', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (227, 'T1055.003', 'Process Injection: Thread Execution Hijacking', '进程注入：线程执行劫持', 'T1055', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (228, 'T1572', 'Protocol Tunneling', '协议隧道', 'TA0011', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (229, 'T1090', 'Proxy', '代理', 'TA0011', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (230, 'T1090.002', 'Proxy: External Proxy', '代理：外部代理', 'T1090', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (231, 'T1090.001', 'Proxy: Internal Proxy', '代理：内部代理', 'T1090', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (232, 'T1090.003', 'Proxy: Multi-hop Proxy', '代理：多跳代理', 'T1090', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (233, 'T1012', 'Query Registry', '查询注册表', 'TA0007', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (234, 'T1219', 'Remote Access Software', '远程访问软件', 'TA0011', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (235, 'T1563', 'Remote Service Session Hijacking', '远程服务会话劫持', 'TA0008', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (236, 'T1563.002', 'Remote Service Session Hijacking: RDP Hijacking', '远程服务会话劫持：RDP 劫持', 'T1563', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (237, 'T1021', 'Remote Services', '远程服务', 'TA0008', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (238, 'T1021.003', 'Remote Services: Distributed Component Object Model', '远程服务：分布式组件对象模型', 'T1021', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (239, 'T1021.001', 'Remote Services: Remote Desktop Protocol', '远程服务：远程桌面协议', 'T1021', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (240, 'T1021.002', 'Remote Services: SMB/Windows Admin Shares', '远程服务：SMB/Windows 管理员共享', 'T1021', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (241, 'T1021.004', 'Remote Services: SSH', '远程服务：SSH', 'T1021', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (242, 'T1021.005', 'Remote Services: VNC', '远程服务：VNC', 'T1021', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (243, 'T1021.006', 'Remote Services: Windows Remote Management', '远程服务：Windows 远程管理', 'T1021', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (244, 'T1018', 'Remote System Discovery', '远程系统发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (245, 'T1496', 'Resource Hijacking', '资源劫持', 'TA0040', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (246, 'T1014', 'Rootkit', 'Rootkit', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (247, 'T1053', 'Scheduled Task/Job', '计划任务/工作', 'TA0002', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (248, 'T1053.002', 'Scheduled Task/Job: At', '计划任务/工作：at', 'T1053', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (249, 'T1053.003', 'Scheduled Task/Job: Cron', '计划任务/工作：Cron', 'T1053', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (250, 'T1053.005', 'Scheduled Task/Job: Scheduled Task', '计划任务/工作：计划任务', 'T1053', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (251, 'T1053.006', 'Scheduled Task/Job: Systemd Timers', '计划任务/工作：Systemd 计时器', 'T1053', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (252, 'T1113', 'Screen Capture', '屏幕截图', 'TA0009', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (253, 'T1593', 'Search Open Websites/Domains', '搜索打开的网站/域', 'TA0043', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (254, 'T1505', 'Server Software Component', '服务器软件组件', 'TA0003', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (255, 'T1505.001', 'Server Software Component: SQL Stored Procedures', '服务器软件组件：SQL 存储过程', 'T1505', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (256, 'T1505.002', 'Server Software Component: Transport Agent', '服务器软件组件：传输代理', 'T1505', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (257, 'T1505.003', 'Server Software Component: Web Shell', '服务器软件组件：Web Shell', 'T1505', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (258, 'T1489', 'Service Stop', '服务停止', 'TA0040', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (259, 'T1072', 'Software Deployment Tools', '软件部署工具', 'TA0002', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (260, 'T1518', 'Software Discovery', '软件发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (261, 'T1518.001', 'Software Discovery: Security Software Discovery', '软件发现：安全软件发现', 'T1518', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (262, 'T1608', 'Stage Capabilities', '平台能力', 'TA0042', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (263, 'T1608.001', 'Stage Capabilities: Upload Malware', '平台能力：上传恶意软件', 'T1608', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (264, 'T1608.002', 'Stage Capabilities: Upload Tool', '平台功能：上传工具', 'T1608', 'technique', 'other', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (265, 'T1539', 'Steal Web Session Cookie', '窃取网络会话 Cookie', 'TA0006', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (266, 'T1558', 'Steal or Forge Kerberos Tickets', '窃取或伪造 Kerberos 票证', 'TA0006', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (267, 'T1558.001', 'Steal or Forge Kerberos Tickets: Golden Ticket', '窃取或伪造 Kerberos 门票：Golden Ticket', 'T1558', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (268, 'T1558.003', 'Steal or Forge Kerberos Tickets: Kerberoasting', '窃取或伪造 Kerberos 票证：Kerberoasting', 'T1558', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (269, 'T1553', 'Subvert Trust Controls', '颠覆信任控制', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (270, 'T1553.004', 'Subvert Trust Controls: Install Root Certificate', '颠覆信任控制：安装根证书', 'T1553', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (271, 'T1553.003', 'Subvert Trust Controls: SIP and Trust Provider Hijacking', '颠覆信任控制：SIP 和信任提供者劫持', 'T1553', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (272, 'T1195', 'Supply Chain Compromise', '供应链妥协', 'TA0001', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (273, 'T1195.002', 'Supply Chain Compromise: Compromise Software Supply Chain', '供应链妥协：妥协软件供应链', 'T1195', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (274, 'T1218', 'System Binary Proxy Execution', '系统二进制代理执行', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (275, 'T1218.003', 'System Binary Proxy Execution: CMSTP', '系统二进制代理执行：CMSTP', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (276, 'T1218.001', 'System Binary Proxy Execution: Compiled HTML File', '系统二进制代理执行：已编译的 HTML 文件', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (277, 'T1218.002', 'System Binary Proxy Execution: Control Panel', '系统二进制代理执行：控制面板', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (278, 'T1218.004', 'System Binary Proxy Execution: InstallUtil', '系统二进制代理执行：InstallUtil', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (279, 'T1218.005', 'System Binary Proxy Execution: Mshta', '系统二进制代理执行：Mshta', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (280, 'T1218.007', 'System Binary Proxy Execution: Msiexec', '系统二进制代理执行：Msiexec', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (281, 'T1218.008', 'System Binary Proxy Execution: Odbcconf', '系统二进制代理执行：Odbcconf', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (282, 'T1218.009', 'System Binary Proxy Execution: Regsvcs/Regasm', '系统二进制代理执行：Regsvcs/Regasm', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (283, 'T1218.010', 'System Binary Proxy Execution: Regsvr32', '系统二进制代理执行：Regsvr32', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (284, 'T1218.011', 'System Binary Proxy Execution: Rundll32', '系统二进制代理执行：Rundll32', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (285, 'T1218.012', 'System Binary Proxy Execution: Verclsid', '系统二进制代理执行：Verclsid', 'T1218', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (286, 'T1082', 'System Information Discovery', '系统信息发现', 'TA0007', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (287, 'T1614', 'System Location Discovery', '系统位置发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (288, 'T1016', 'System Network Configuration Discovery', '系统网络配置发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (289, 'T1016.001', 'System Network Configuration Discovery: Internet Connection Discovery', '系统网络配置发现：Internet 连接发现', 'T1016', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (290, 'T1049', 'System Network Connections Discovery', '系统网络连接发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (291, 'T1033', 'System Owner/User Discovery', '系统所有者/用户发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (292, 'T1216', 'System Script Proxy Execution', '系统脚本代理执行', 'TA0005', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (293, 'T1216.001', 'System Script Proxy Execution: PubPrn', '系统脚本代理执行：PubPrn', 'T1216', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (294, 'T1007', 'System Service Discovery', '系统服务发现', 'TA0007', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (295, 'T1569', 'System Services', '系统服务', 'TA0002', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (296, 'T1569.002', 'System Services: Service Execution', '系统服务：服务执行', 'T1569', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (297, 'T1529', 'System Shutdown/Reboot', '系统关闭/重启', 'TA0040', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (298, 'T1124', 'System Time Discovery', '系统时间发现', 'TA0007', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (299, 'T1080', 'Taint Shared Content', '污染共享内容', 'TA0008', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (300, 'T1127', 'Trusted Developer Utilities Proxy Execution', '受信任的开发人员实用程序代理执行', 'TA0005', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (301, 'T1127.001', 'Trusted Developer Utilities Proxy Execution: MSBuild', '受信任的开发人员实用程序代理执行：MSBuild', 'T1127', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (302, 'T1552', 'Unsecured Credentials', '不安全的凭证', 'TA0006', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (303, 'T1552.003', 'Unsecured Credentials: Bash History', '不安全的凭证：Bash 历史', 'T1552', 'technique', 'linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (304, 'T1552.001', 'Unsecured Credentials: Credentials In Files', '不安全的凭据：文件中的凭据', 'T1552', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (305, 'T1552.002', 'Unsecured Credentials: Credentials in Registry', '不安全的凭据：注册表中的凭据', 'T1552', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (306, 'T1552.006', 'Unsecured Credentials: Group Policy Preferences', '不安全的凭据：组策略首选项', 'T1552', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (307, 'T1552.004', 'Unsecured Credentials: Private Keys', '不安全的凭证：私钥', 'T1552', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (308, 'T1550', 'Use Alternate Authentication Material', '使用备用身份验证材料', 'TA0005', 'technique', 'windows', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (309, 'T1550.002', 'Use Alternate Authentication Material: Pass the Hash', '使用备用身份验证材料：传递哈希', 'T1550', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (310, 'T1550.003', 'Use Alternate Authentication Material: Pass the Ticket', '使用备用身份验证材料：通过票证', 'T1550', 'technique', 'windows', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (311, 'T1204', 'User Execution', '用户执行', 'TA0002', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (312, 'T1204.002', 'User Execution: Malicious File', '用户执行：恶意文件', 'T1204', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (313, 'T1078', 'Valid Accounts', '有效账户', 'TA0001', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (314, 'T1078.001', 'Valid Accounts: Default Accounts', '有效账户：默认账户', 'T1078', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (315, 'T1078.002', 'Valid Accounts: Domain Accounts', '有效帐户：域帐户', 'T1078', 'technique', 'windows,linux', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (316, 'T1078.003', 'Valid Accounts: Local Accounts', '有效帐户：本地帐户', 'T1078', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (317, 'T1497', 'Virtualization/Sandbox Evasion', '虚拟化/沙箱规避', 'TA0005', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (318, 'T1497.001', 'Virtualization/Sandbox Evasion: System Checks', '虚拟化/沙箱规避：系统检查', 'T1497', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (319, 'T1497.003', 'Virtualization/Sandbox Evasion: Time Based Evasion', '虚拟化/沙盒规避：基于时间的规避', 'T1497', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (320, 'T1497.002', 'Virtualization/Sandbox Evasion: User Activity Based Checks', '虚拟化/沙盒规避：基于用户活动的检查', 'T1497', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (321, 'T1102', 'Web Service', '网络服务', 'TA0011', 'technique', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (322, 'T1102.002', 'Web Service: Bidirectional Communication', 'Web 服务：双向通信', 'T1102', 'technique', 'windows,linux', 'terminal', 'aigent', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (323, 'T1047', 'Windows Management Instrumentation', 'Windows 管理工具', 'TA0002', 'technique', 'windows', 'network', 'ainta,apt', NULL);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (324, 'T1220', 'XSL Script Processing', 'XSL 脚本处理', 'TA0005', 'technique', 'windows', 'terminal', 'aigent', 0);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (325, 'TA0006', 'Credential Access', '凭证访问', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 6);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (326, 'TA0001', 'Initial Access', '初始访问', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 1);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (327, 'TA0002', 'Execution', '执行', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 2);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (328, 'TA0009', 'Collection', '采集', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 9);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (329, 'TA0011', 'Command and Control', '命令与控制', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 10);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (330, 'TA0004', 'Privilege Escalation', '权限提升', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 4);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (331, 'TA0007', 'Discovery', '发现', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 7);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (332, 'TA0008', 'Lateral Movement', '横向移动', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 8);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (333, 'TA0010', 'Exfiltration', '数据渗出', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 11);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (334, 'TA0003', 'Persistence', '持久化', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 3);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (335, 'TA0040', 'Impact', '影响', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 12);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (336, 'TA0005', 'Defense Evasion', '防御逃逸', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', 5);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (337, 'TA0043', 'Reconnaissance', '侦察', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', -2);
INSERT INTO "t_attack_knowledge" ("id", "technique_code", "technique_name", "technique_name_ch", "parent_code", "level", "os", "perspective", "device_type", "sort") VALUES (338, 'TA0042', 'Resource Development', '资源开发', 'root', 'tactic', 'windows,linux', 'network,terminal', 'ainta,apt,aigent', -1);
COMMIT;

-- ----------------------------
-- Table structure for t_attacker_traffic_task
-- ----------------------------
DROP TABLE IF EXISTS "t_attacker_traffic_task";
CREATE TABLE "t_attacker_traffic_task" (
  "id" int8 NOT NULL DEFAULT nextval('t_attacker_traffic_task_id_seq'::regclass),
  "ip" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "date_part" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "start_time" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "time_offset" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "history_time_offset" varchar(40) COLLATE "pg_catalog"."default" NOT NULL,
  "is_init" bool NOT NULL DEFAULT false,
  "create_time" timestamptz(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_attacker_traffic_task" OWNER TO "dbapp";
COMMENT ON COLUMN "t_attacker_traffic_task"."id" IS '主键id';
COMMENT ON COLUMN "t_attacker_traffic_task"."ip" IS '攻击者ip';
COMMENT ON COLUMN "t_attacker_traffic_task"."date_part" IS '日期分区';
COMMENT ON COLUMN "t_attacker_traffic_task"."start_time" IS '首次计算时间';
COMMENT ON COLUMN "t_attacker_traffic_task"."time_offset" IS '当前计算时间';
COMMENT ON COLUMN "t_attacker_traffic_task"."is_init" IS '是否计算当天开始时间前数据';
COMMENT ON COLUMN "t_attacker_traffic_task"."create_time" IS '创建时间';

-- ----------------------------
-- Records of t_attacker_traffic_task
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_block_history
-- ----------------------------
DROP TABLE IF EXISTS "t_block_history";
CREATE TABLE "t_block_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_block_history_id_seq'::regclass),
  "link_device_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_type" varchar(16) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "src_address" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "dest_address" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "content" text COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "strategy_id" int8 NOT NULL,
  "create_type" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'none'::character varying,
  "launch_times" int4 NOT NULL DEFAULT 1,
  "nta_name" varchar(100) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_block_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_block_history"."link_device_ip" IS '联动设备ip';
COMMENT ON COLUMN "t_block_history"."link_device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_block_history"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_block_history"."src_address" IS '来源IP';
COMMENT ON COLUMN "t_block_history"."dest_address" IS '目的IP';
COMMENT ON COLUMN "t_block_history"."content" IS '命中内容';
COMMENT ON COLUMN "t_block_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_block_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_block_history"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_block_history"."create_type" IS '添加方式';
COMMENT ON COLUMN "t_block_history"."launch_times" IS '下发次数';

-- ----------------------------
-- Records of t_block_history
-- ----------------------------
BEGIN;
COMMIT;

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

-- ----------------------------
-- Table structure for t_common_config
-- ----------------------------
DROP TABLE IF EXISTS "t_common_config";
CREATE TABLE "t_common_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_common_config_id_seq'::regclass),
  "prefix" varchar(45) COLLATE "pg_catalog"."default" NOT NULL,
  "configkey" varchar(45) COLLATE "pg_catalog"."default" NOT NULL,
  "configvalue" varchar(20000) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_common_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_common_config"."id" IS '主键Id';
COMMENT ON COLUMN "t_common_config"."prefix" IS '分类';
COMMENT ON COLUMN "t_common_config"."configkey" IS '名称';
COMMENT ON TABLE "t_common_config" IS '通用配置';

-- ----------------------------
-- Records of t_common_config
-- ----------------------------
BEGIN;
INSERT INTO "t_common_config" ("id", "prefix", "configkey", "configvalue") VALUES (1, 'dasca-dbappsecurity-ainta', 'accessKey', '1cf2bb1de1024a94140a9d7f8597c0ba');
INSERT INTO "t_common_config" ("id", "prefix", "configkey", "configvalue") VALUES (2, 'dasca-dbappsecurity-ainta', 'accessKeySecret', 'birlovoidv9S+iu45cuhfPo0g3p1J3fI3gYDGgywz6uPZRqpDW4+nspxGN8UGw6INulCihseo+Iro2xCRwnU7klt6yFY0fWTeuRQmwhPbJSdB65UHWYchjC1iQwjuv1u/ZAYqO96SJpkJhC+e0eP9A46jCo0pInQn626cOqYQzCutcbNTd7eHxUpxnC0FgsM8+TeNXB4yzaohrcg+sRcxzpW+Ugo9GptLUJfZTLkMUyNI+5GcqWJajFVozKD14L4iYUpVTEStANcf7RbPx0mOkxcsOIrCQkrJFE2NC3OWPD6L0LwPJKUQQyXfE6x4GNMCmuwv6GIvq36Xl1pmrX/fQ==');
INSERT INTO "t_common_config" ("id", "prefix", "configkey", "configvalue") VALUES (3, 'baas', 'baas.admin.password', 'b!o3jraZ4a');
INSERT INTO "t_common_config" ("id", "prefix", "configkey", "configvalue") VALUES (4, 'baas', 'baas.admin.username', 'admin');
INSERT INTO "t_common_config" ("id", "prefix", "configkey", "configvalue") VALUES (5, 'attacker_traffic', 'history_init', '2026-01-15 00:00:00--2026-01-12 19:00:00');
COMMIT;

-- ----------------------------
-- Table structure for t_event_out_going_config
-- ----------------------------
DROP TABLE IF EXISTS "t_event_out_going_config";
CREATE TABLE "t_event_out_going_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_event_out_going_config_id_seq'::regclass),
  "sub_category" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(50) COLLATE "pg_catalog"."default",
  "alarm_results" varchar(50) COLLATE "pg_catalog"."default",
  "enable" int4 NOT NULL DEFAULT 1,
  "mapping_config_path" text COLLATE "pg_catalog"."default",
  "last_send_time" timestamptz(6),
  "last_send_result" varchar(10) COLLATE "pg_catalog"."default",
  "cause_of_failure" text COLLATE "pg_catalog"."default",
  "is_del" int4 NOT NULL DEFAULT 0,
  "send_count" int8 DEFAULT '0'::bigint,
  "succeed_count" int8 DEFAULT '0'::bigint,
  "create_time" timestamptz(6),
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_event_out_going_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_out_going_config"."id" IS '主键自增id';
COMMENT ON COLUMN "t_event_out_going_config"."sub_category" IS '安全事件类型（数组）';
COMMENT ON COLUMN "t_event_out_going_config"."threat_severity" IS '威胁等级（数组）';
COMMENT ON COLUMN "t_event_out_going_config"."alarm_results" IS '事件结果（数组）';
COMMENT ON COLUMN "t_event_out_going_config"."enable" IS '是否开启（1是，0否）';
COMMENT ON COLUMN "t_event_out_going_config"."mapping_config_path" IS '映射文件路径';
COMMENT ON COLUMN "t_event_out_going_config"."last_send_time" IS '上次发送时间';
COMMENT ON COLUMN "t_event_out_going_config"."last_send_result" IS '上次发送结果';
COMMENT ON COLUMN "t_event_out_going_config"."cause_of_failure" IS '发送失败的原因';
COMMENT ON COLUMN "t_event_out_going_config"."is_del" IS '是否已删除（1是，0否）';
COMMENT ON COLUMN "t_event_out_going_config"."send_count" IS '发送总次数';
COMMENT ON COLUMN "t_event_out_going_config"."succeed_count" IS '成功发送次数';
COMMENT ON COLUMN "t_event_out_going_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_event_out_going_config"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_event_out_going_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_event_out_going_data
-- ----------------------------
DROP TABLE IF EXISTS "t_event_out_going_data";
CREATE TABLE "t_event_out_going_data" (
  "id" int8 NOT NULL DEFAULT nextval('t_event_out_going_data_id_seq'::regclass),
  "event_code" varchar(100) COLLATE "pg_catalog"."default",
  "category" varchar(50) COLLATE "pg_catalog"."default",
  "sub_category" varchar(50) COLLATE "pg_catalog"."default",
  "threat_severity" varchar(10) COLLATE "pg_catalog"."default",
  "incident_name" varchar(100) COLLATE "pg_catalog"."default",
  "event_description" text COLLATE "pg_catalog"."default",
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "attacker" text COLLATE "pg_catalog"."default",
  "victim" text COLLATE "pg_catalog"."default",
  "dest_address" text COLLATE "pg_catalog"."default",
  "src_address" text COLLATE "pg_catalog"."default",
  "request_url" text COLLATE "pg_catalog"."default",
  "request_domain" text COLLATE "pg_catalog"."default",
  "dest_port" int8,
  "dest_geo_region" varchar(100) COLLATE "pg_catalog"."default",
  "dest_geo_city" varchar(100) COLLATE "pg_catalog"."default",
  "dest_geo_county" varchar(100) COLLATE "pg_catalog"."default",
  "src_port" int8,
  "src_geo_region" varchar(100) COLLATE "pg_catalog"."default",
  "src_geo_city" varchar(100) COLLATE "pg_catalog"."default",
  "src_geo_county" varchar(100) COLLATE "pg_catalog"."default",
  "alarm_result" varchar(50) COLLATE "pg_catalog"."default",
  "event_count" int8,
  "kill_chain" text COLLATE "pg_catalog"."default",
  "mirror_category" varchar(100) COLLATE "pg_catalog"."default",
  "focus" varchar(10) COLLATE "pg_catalog"."default",
  "focus_ip" text COLLATE "pg_catalog"."default",
  "tag_search" varchar(255) COLLATE "pg_catalog"."default",
  "alarm" text COLLATE "pg_catalog"."default",
  "time_part" date,
  "create_time" timestamptz(6),
  "update_time" timestamptz(6),
  "incident_description" text COLLATE "pg_catalog"."default",
  "incident_suggestion" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_event_out_going_data" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_out_going_data"."id" IS '事件自增ID';
COMMENT ON COLUMN "t_event_out_going_data"."event_code" IS '事件唯一键值';
COMMENT ON COLUMN "t_event_out_going_data"."category" IS '事件类型';
COMMENT ON COLUMN "t_event_out_going_data"."sub_category" IS '事件子类型';
COMMENT ON COLUMN "t_event_out_going_data"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_event_out_going_data"."incident_name" IS '安全事件名称';
COMMENT ON COLUMN "t_event_out_going_data"."event_description" IS '安全事件详细描述';
COMMENT ON COLUMN "t_event_out_going_data"."start_time" IS '事件发生时间';
COMMENT ON COLUMN "t_event_out_going_data"."end_time" IS '事件结束时间';
COMMENT ON COLUMN "t_event_out_going_data"."attacker" IS '攻击者ip';
COMMENT ON COLUMN "t_event_out_going_data"."victim" IS '受害者ip';
COMMENT ON COLUMN "t_event_out_going_data"."dest_address" IS '目的ip';
COMMENT ON COLUMN "t_event_out_going_data"."src_address" IS '来源ip';
COMMENT ON COLUMN "t_event_out_going_data"."request_url" IS '目标对象URL';
COMMENT ON COLUMN "t_event_out_going_data"."request_domain" IS '目标对象域名';
COMMENT ON COLUMN "t_event_out_going_data"."dest_port" IS '目标对象端口';
COMMENT ON COLUMN "t_event_out_going_data"."dest_geo_region" IS '目的省会';
COMMENT ON COLUMN "t_event_out_going_data"."dest_geo_city" IS '目的城市';
COMMENT ON COLUMN "t_event_out_going_data"."dest_geo_county" IS '目的国家';
COMMENT ON COLUMN "t_event_out_going_data"."src_port" IS '来源端口';
COMMENT ON COLUMN "t_event_out_going_data"."src_geo_region" IS '来源省会';
COMMENT ON COLUMN "t_event_out_going_data"."src_geo_city" IS '来源城市';
COMMENT ON COLUMN "t_event_out_going_data"."src_geo_county" IS '来源国家';
COMMENT ON COLUMN "t_event_out_going_data"."alarm_result" IS '攻击结果';
COMMENT ON COLUMN "t_event_out_going_data"."event_count" IS '攻击次数';
COMMENT ON COLUMN "t_event_out_going_data"."kill_chain" IS '攻击链';
COMMENT ON COLUMN "t_event_out_going_data"."mirror_category" IS 'mirror告警类型';
COMMENT ON COLUMN "t_event_out_going_data"."focus" IS '关注对象';
COMMENT ON COLUMN "t_event_out_going_data"."focus_ip" IS '关注Ip';
COMMENT ON COLUMN "t_event_out_going_data"."tag_search" IS '标签';
COMMENT ON COLUMN "t_event_out_going_data"."alarm" IS '原始告警';
COMMENT ON COLUMN "t_event_out_going_data"."time_part" IS '时间分区';
COMMENT ON COLUMN "t_event_out_going_data"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_event_out_going_data"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_event_out_going_data"."incident_description" IS '事件描述';
COMMENT ON COLUMN "t_event_out_going_data"."incident_suggestion" IS '安全建议';

-- ----------------------------
-- Records of t_event_out_going_data
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_event_scenario_data
-- ----------------------------
DROP TABLE IF EXISTS "t_event_scenario_data";
CREATE TABLE "t_event_scenario_data" (
  "id" int8 NOT NULL DEFAULT nextval('t_event_scenario_data_id_seq'::regclass),
  "result" text COLLATE "pg_catalog"."default",
  "log_session_id" varchar(200) COLLATE "pg_catalog"."default",
  "incident_id" int8,
  "scenario_id" int8,
  "event_time" date,
  "update_time" timestamptz(6),
  "focus_ip" varchar(100) COLLATE "pg_catalog"."default",
  "target_ip" varchar(100) COLLATE "pg_catalog"."default",
  "conclusion" text COLLATE "pg_catalog"."default",
  "trace_graph_version" varchar(100) COLLATE "pg_catalog"."default",
  "trace_graph" text COLLATE "pg_catalog"."default",
  "risk_id" int8
)
;
ALTER TABLE "t_event_scenario_data" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_scenario_data"."id" IS '主键id';
COMMENT ON COLUMN "t_event_scenario_data"."result" IS '返回值';
COMMENT ON COLUMN "t_event_scenario_data"."log_session_id" IS '溯源id';
COMMENT ON COLUMN "t_event_scenario_data"."incident_id" IS '关联安全事件id';
COMMENT ON COLUMN "t_event_scenario_data"."scenario_id" IS '关联场景id';
COMMENT ON COLUMN "t_event_scenario_data"."event_time" IS '创建年日';
COMMENT ON COLUMN "t_event_scenario_data"."update_time" IS '更新日期';
COMMENT ON COLUMN "t_event_scenario_data"."focus_ip" IS '关注ip';
COMMENT ON COLUMN "t_event_scenario_data"."target_ip" IS '目标ip';
COMMENT ON COLUMN "t_event_scenario_data"."conclusion" IS '总结';
COMMENT ON COLUMN "t_event_scenario_data"."trace_graph_version" IS '溯源树解析版本';
COMMENT ON COLUMN "t_event_scenario_data"."trace_graph" IS '简化后溯源图';
COMMENT ON COLUMN "t_event_scenario_data"."risk_id" IS '聚合事件的id';

-- ----------------------------
-- Records of t_event_scenario_data
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_event_scenario_queue
-- ----------------------------
DROP TABLE IF EXISTS "t_event_scenario_queue";
CREATE TABLE "t_event_scenario_queue" (
  "focus_ip" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "target_ip" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "event_code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "scenario_template_id" int8 NOT NULL,
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "alarm_info" text COLLATE "pg_catalog"."default",
  "src_address" varchar(50) COLLATE "pg_catalog"."default",
  "dest_address" varchar(50) COLLATE "pg_catalog"."default",
  "time_part" varchar(10) COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "is_job_commit" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "t_event_scenario_queue" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_scenario_queue"."focus_ip" IS '关注ip';
COMMENT ON COLUMN "t_event_scenario_queue"."target_ip" IS '目的IP';
COMMENT ON COLUMN "t_event_scenario_queue"."event_code" IS '安全事件唯一标识code';
COMMENT ON COLUMN "t_event_scenario_queue"."scenario_template_id" IS '安全事件场景模板id';
COMMENT ON COLUMN "t_event_scenario_queue"."start_time" IS '开始时间';
COMMENT ON COLUMN "t_event_scenario_queue"."end_time" IS '结束时间';
COMMENT ON COLUMN "t_event_scenario_queue"."alarm_info" IS '告警列表信息，windowId，aggCondition，eventId，endTime';
COMMENT ON COLUMN "t_event_scenario_queue"."src_address" IS '来源IP';
COMMENT ON COLUMN "t_event_scenario_queue"."dest_address" IS '目的IP';
COMMENT ON COLUMN "t_event_scenario_queue"."time_part" IS '时间分区';
COMMENT ON COLUMN "t_event_scenario_queue"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_event_scenario_queue"."is_job_commit" IS '溯源任务是否已提交';
COMMENT ON TABLE "t_event_scenario_queue" IS '安全事件场景缓冲队列';

-- ----------------------------
-- Records of t_event_scenario_queue
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_event_scenario_template
-- ----------------------------
DROP TABLE IF EXISTS "t_event_scenario_template";
CREATE TABLE "t_event_scenario_template" (
  "id" int8 NOT NULL DEFAULT nextval('t_event_scenario_template_id_seq'::regclass),
  "scenario_name" varchar(50) COLLATE "pg_catalog"."default",
  "scenario_code" varchar(50) COLLATE "pg_catalog"."default",
  "source" varchar(20) COLLATE "pg_catalog"."default",
  "request_url" varchar(100) COLLATE "pg_catalog"."default",
  "condition" text COLLATE "pg_catalog"."default",
  "event_name" text COLLATE "pg_catalog"."default",
  "parameter" text COLLATE "pg_catalog"."default",
  "result" text COLLATE "pg_catalog"."default",
  "executor_class_name" text COLLATE "pg_catalog"."default",
  "drill_down" int4,
  "update_time" timestamptz(6),
  "conclusion" text COLLATE "pg_catalog"."default",
  "log_aiql" varchar(255) COLLATE "pg_catalog"."default",
  "alarm_aiql" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_event_scenario_template" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_scenario_template"."id" IS '主键id';
COMMENT ON COLUMN "t_event_scenario_template"."scenario_name" IS '场景名称';
COMMENT ON COLUMN "t_event_scenario_template"."scenario_code" IS '场景英文名';
COMMENT ON COLUMN "t_event_scenario_template"."source" IS '数据源';
COMMENT ON COLUMN "t_event_scenario_template"."request_url" IS '请求地址';
COMMENT ON COLUMN "t_event_scenario_template"."condition" IS '筛选条件';
COMMENT ON COLUMN "t_event_scenario_template"."event_name" IS '关联安全事件名称';
COMMENT ON COLUMN "t_event_scenario_template"."parameter" IS '传入参数';
COMMENT ON COLUMN "t_event_scenario_template"."result" IS '返回值';
COMMENT ON COLUMN "t_event_scenario_template"."executor_class_name" IS '执行器类名';
COMMENT ON COLUMN "t_event_scenario_template"."drill_down" IS '是否可下钻';
COMMENT ON COLUMN "t_event_scenario_template"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_event_scenario_template"."conclusion" IS '总结';
COMMENT ON COLUMN "t_event_scenario_template"."log_aiql" IS '日志查询AiQL';
COMMENT ON COLUMN "t_event_scenario_template"."alarm_aiql" IS '告警查询AiQL';

-- ----------------------------
-- Records of t_event_scenario_template
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_event_template
-- ----------------------------
DROP TABLE IF EXISTS "t_event_template";
CREATE TABLE "t_event_template" (
  "id" int8 NOT NULL DEFAULT nextval('t_event_template_id_seq'::regclass),
  "incident_name" varchar(100) COLLATE "pg_catalog"."default",
  "incident_rule_type" varchar(100) COLLATE "pg_catalog"."default",
  "incident_class_type" varchar(100) COLLATE "pg_catalog"."default",
  "incident_sub_class_type" varchar(100) COLLATE "pg_catalog"."default",
  "incident_type" bool,
  "incident_cond" varchar(100) COLLATE "pg_catalog"."default",
  "incident_description" text COLLATE "pg_catalog"."default",
  "incident_suggestion" text COLLATE "pg_catalog"."default",
  "conclusion" text COLLATE "pg_catalog"."default",
  "focus" varchar(10) COLLATE "pg_catalog"."default",
  "display_filed" text COLLATE "pg_catalog"."default",
  "enable" bool,
  "update_time" timestamptz(6),
  "last_execute_time" timestamptz(6),
  "uniq_code" int8,
  "incident_children" text COLLATE "pg_catalog"."default",
  "priority" int8,
  "netflow_log_field" varchar(1000) COLLATE "pg_catalog"."default",
  "host_log_field" varchar(1000) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_event_template" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_template"."id" IS '主键id';
COMMENT ON COLUMN "t_event_template"."incident_name" IS '事件名称';
COMMENT ON COLUMN "t_event_template"."incident_rule_type" IS '告警类型';
COMMENT ON COLUMN "t_event_template"."incident_class_type" IS '一级事件类型';
COMMENT ON COLUMN "t_event_template"."incident_sub_class_type" IS '二级事件类型';
COMMENT ON COLUMN "t_event_template"."incident_type" IS '事件线头';
COMMENT ON COLUMN "t_event_template"."incident_cond" IS '事件条件';
COMMENT ON COLUMN "t_event_template"."incident_description" IS '危险描述';
COMMENT ON COLUMN "t_event_template"."incident_suggestion" IS '安全建议';
COMMENT ON COLUMN "t_event_template"."conclusion" IS '攻击总结';
COMMENT ON COLUMN "t_event_template"."focus" IS '关注对象';
COMMENT ON COLUMN "t_event_template"."display_filed" IS '攻击记录/展示字段';
COMMENT ON COLUMN "t_event_template"."enable" IS '是否启用（0不启用，1启用）';
COMMENT ON COLUMN "t_event_template"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_event_template"."last_execute_time" IS '上次执行时间';
COMMENT ON COLUMN "t_event_template"."uniq_code" IS '唯一code';
COMMENT ON COLUMN "t_event_template"."incident_children" IS '安全事件外发总结字段';
COMMENT ON COLUMN "t_event_template"."priority" IS '安全事件优先级（数字越小优先级越高）';
COMMENT ON COLUMN "t_event_template"."netflow_log_field" IS '关联网侧日志展示字段';
COMMENT ON COLUMN "t_event_template"."host_log_field" IS '关联终端日志展示字段';

-- ----------------------------
-- Records of t_event_template
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_event_thread
-- ----------------------------
DROP TABLE IF EXISTS "t_event_thread";
CREATE TABLE "t_event_thread" (
  "template_id" int8 NOT NULL,
  "incident_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "focus" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "focus_ip" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "time_part" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "event_code" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "attacker" varchar(20) COLLATE "pg_catalog"."default",
  "victim" varchar(20) COLLATE "pg_catalog"."default",
  "end_time" timestamptz(6),
  "is_delete" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "t_event_thread" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_thread"."template_id" IS '安全事件模板id';
COMMENT ON COLUMN "t_event_thread"."incident_name" IS '安全事件名称';
COMMENT ON COLUMN "t_event_thread"."focus" IS '关注类型，attacker、victim';
COMMENT ON COLUMN "t_event_thread"."focus_ip" IS '关注ip';
COMMENT ON COLUMN "t_event_thread"."time_part" IS '时间分区，按天分区';
COMMENT ON COLUMN "t_event_thread"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_event_thread"."event_code" IS '安全事件唯一code';
COMMENT ON COLUMN "t_event_thread"."attacker" IS '攻击者';
COMMENT ON COLUMN "t_event_thread"."victim" IS '受害者';
COMMENT ON COLUMN "t_event_thread"."is_delete" IS '是否已删除';
COMMENT ON TABLE "t_event_thread" IS '保存安全事件线头';

-- ----------------------------
-- Records of t_event_thread
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_event_update_ck_alarm_queue
-- ----------------------------
DROP TABLE IF EXISTS "t_event_update_ck_alarm_queue";
CREATE TABLE "t_event_update_ck_alarm_queue" (
  "window_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "agg_condition" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "time_part" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "event_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "end_time" timestamptz(6),
  "is_ck_sync" bool NOT NULL DEFAULT false,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_event_update_ck_alarm_queue" OWNER TO "dbapp";
COMMENT ON COLUMN "t_event_update_ck_alarm_queue"."time_part" IS '事件分区，按天分区';
COMMENT ON COLUMN "t_event_update_ck_alarm_queue"."event_id" IS '原始告警eventId';
COMMENT ON COLUMN "t_event_update_ck_alarm_queue"."end_time" IS '原始告警endTime';
COMMENT ON COLUMN "t_event_update_ck_alarm_queue"."is_ck_sync" IS 'ck是否已同步';
COMMENT ON COLUMN "t_event_update_ck_alarm_queue"."create_time" IS '创建时间';
COMMENT ON TABLE "t_event_update_ck_alarm_queue" IS '告警列表添加关联安全事件标签缓冲队列';

-- ----------------------------
-- Records of t_event_update_ck_alarm_queue
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_intelligence_sub
-- ----------------------------
DROP TABLE IF EXISTS "t_intelligence_sub";
CREATE TABLE "t_intelligence_sub" (
  "id" int8 NOT NULL DEFAULT nextval('t_intelligence_sub_id_seq'::regclass),
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "update_time" timestamptz(6),
  "ioc" varchar(200) COLLATE "pg_catalog"."default",
  "sub_category" varchar(30) COLLATE "pg_catalog"."default",
  "alarm_name" varchar(255) COLLATE "pg_catalog"."default",
  "threat_severity" int4,
  "counts" int8,
  "tag" varchar(20) COLLATE "pg_catalog"."default",
  "alarm_status" int4,
  "event_time" date,
  "asset_count" int8
)
;
ALTER TABLE "t_intelligence_sub" OWNER TO "dbapp";
COMMENT ON COLUMN "t_intelligence_sub"."id" IS '主键id';
COMMENT ON COLUMN "t_intelligence_sub"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_intelligence_sub"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_intelligence_sub"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_intelligence_sub"."ioc" IS 'ioC编号';
COMMENT ON COLUMN "t_intelligence_sub"."sub_category" IS '告警子类型';
COMMENT ON COLUMN "t_intelligence_sub"."alarm_name" IS '告警名称';
COMMENT ON COLUMN "t_intelligence_sub"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_intelligence_sub"."counts" IS '攻击次数';
COMMENT ON COLUMN "t_intelligence_sub"."tag" IS '标签';
COMMENT ON COLUMN "t_intelligence_sub"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_intelligence_sub"."event_time" IS '创建年日';
COMMENT ON COLUMN "t_intelligence_sub"."asset_count" IS '受影响资产数量';

-- ----------------------------
-- Records of t_intelligence_sub
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_intelligence_sub_asset
-- ----------------------------
DROP TABLE IF EXISTS "t_intelligence_sub_asset";
CREATE TABLE "t_intelligence_sub_asset" (
  "id" int8 NOT NULL DEFAULT nextval('t_intelligence_sub_asset_id_seq'::regclass),
  "ioc" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "asset_ip" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "event_time" date NOT NULL,
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "response_address" text COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "alarm_status" int4,
  "counts" int8,
  "tag" varchar(20) COLLATE "pg_catalog"."default",
  "security_zone" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;
ALTER TABLE "t_intelligence_sub_asset" OWNER TO "dbapp";
COMMENT ON COLUMN "t_intelligence_sub_asset"."id" IS '主键';
COMMENT ON COLUMN "t_intelligence_sub_asset"."ioc" IS '威胁情报IoC';
COMMENT ON COLUMN "t_intelligence_sub_asset"."asset_ip" IS '资产IP';
COMMENT ON COLUMN "t_intelligence_sub_asset"."event_time" IS '创建年月日';
COMMENT ON COLUMN "t_intelligence_sub_asset"."start_time" IS '起始时间';
COMMENT ON COLUMN "t_intelligence_sub_asset"."end_time" IS '结束时间';
COMMENT ON COLUMN "t_intelligence_sub_asset"."response_address" IS 'A记录溯源ip';
COMMENT ON COLUMN "t_intelligence_sub_asset"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_intelligence_sub_asset"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_intelligence_sub_asset"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_intelligence_sub_asset"."counts" IS '告警次数';
COMMENT ON COLUMN "t_intelligence_sub_asset"."tag" IS '标签';
COMMENT ON COLUMN "t_intelligence_sub_asset"."security_zone" IS '安全域id';

-- ----------------------------
-- Records of t_intelligence_sub_asset
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_isolation_history
-- ----------------------------
DROP TABLE IF EXISTS "t_isolation_history";
CREATE TABLE "t_isolation_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_isolation_history_id_seq'::regclass),
  "strategy_id" int8 NOT NULL,
  "strategy_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "node_ip" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "node_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "os_str" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "device_ip" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "device_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "device_type" varchar(255) COLLATE "pg_catalog"."default",
  "action" "t_isolation_history_action" NOT NULL DEFAULT '未知'::xdr22.t_isolation_history_action,
  "last_occur_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "source" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'manual'::character varying
)
;
ALTER TABLE "t_isolation_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_isolation_history"."id" IS '主键ID';
COMMENT ON COLUMN "t_isolation_history"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_isolation_history"."strategy_name" IS '策略名称';
COMMENT ON COLUMN "t_isolation_history"."node_ip" IS '终端操作系统IP';
COMMENT ON COLUMN "t_isolation_history"."node_id" IS '联动设备ID';
COMMENT ON COLUMN "t_isolation_history"."os_str" IS '终端操作系统类型';
COMMENT ON COLUMN "t_isolation_history"."device_ip" IS '联动设备IP';
COMMENT ON COLUMN "t_isolation_history"."device_id" IS '联动设备id';
COMMENT ON COLUMN "t_isolation_history"."device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_isolation_history"."action" IS '下发的主机动作';
COMMENT ON COLUMN "t_isolation_history"."last_occur_time" IS '最后一次时间';
COMMENT ON COLUMN "t_isolation_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_isolation_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_isolation_history"."source" IS '策略来源';
COMMENT ON TABLE "t_isolation_history" IS '主机隔离下发记录表';

-- ----------------------------
-- Records of t_isolation_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_linkage_strategy_validtime
-- ----------------------------
DROP TABLE IF EXISTS "t_linkage_strategy_validtime";
CREATE TABLE "t_linkage_strategy_validtime" (
  "id" int8 NOT NULL DEFAULT nextval('t_linkage_strategy_validtime_id_seq'::regclass),
  "block_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "block_domain" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "end_time" int8,
  "node_id" varchar(255) COLLATE "pg_catalog"."default",
  "direction" int8 NOT NULL DEFAULT '3'::bigint,
  "effect_time" varchar(255) COLLATE "pg_catalog"."default" DEFAULT '0'::character varying
)
;
ALTER TABLE "t_linkage_strategy_validtime" OWNER TO "dbapp";
COMMENT ON COLUMN "t_linkage_strategy_validtime"."block_ip" IS '阻断ip';
COMMENT ON COLUMN "t_linkage_strategy_validtime"."block_domain" IS '封禁域名';
COMMENT ON COLUMN "t_linkage_strategy_validtime"."link_device_ip" IS '联动设备ip';
COMMENT ON COLUMN "t_linkage_strategy_validtime"."end_time" IS '结束时间';
COMMENT ON COLUMN "t_linkage_strategy_validtime"."node_id" IS '终端id';
COMMENT ON COLUMN "t_linkage_strategy_validtime"."effect_time" IS '生效时长，0-永久';

-- ----------------------------
-- Records of t_linkage_strategy_validtime
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_linked_strategy
-- ----------------------------
DROP TABLE IF EXISTS "t_linked_strategy";
CREATE TABLE "t_linked_strategy" (
  "id" int8 NOT NULL DEFAULT nextval('t_linked_strategy_id_seq'::regclass),
  "strategy_name" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "auto_handle" bool DEFAULT true,
  "threat_type" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "threat_type_config" text COLLATE "pg_catalog"."default",
  "threat_level" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "alarm_results" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" bool DEFAULT true,
  "source" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "template_id" int8,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "link_device_config" text COLLATE "pg_catalog"."default",
  "alarm_names" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_linked_strategy" OWNER TO "dbapp";
COMMENT ON COLUMN "t_linked_strategy"."strategy_name" IS '策略名称';
COMMENT ON COLUMN "t_linked_strategy"."auto_handle" IS '自动处置';
COMMENT ON COLUMN "t_linked_strategy"."threat_type" IS '威胁类型';
COMMENT ON COLUMN "t_linked_strategy"."threat_type_config" IS '威胁类型配置';
COMMENT ON COLUMN "t_linked_strategy"."threat_level" IS '威胁等级';
COMMENT ON COLUMN "t_linked_strategy"."alarm_results" IS '攻击结果（v2.0.4新增需求）';
COMMENT ON COLUMN "t_linked_strategy"."status" IS '策略状态';
COMMENT ON COLUMN "t_linked_strategy"."source" IS '策略来源';
COMMENT ON COLUMN "t_linked_strategy"."template_id" IS '内置模板ID（v2.0.4新增需求）';
COMMENT ON COLUMN "t_linked_strategy"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_linked_strategy"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_linked_strategy"."link_device_config" IS '策略页面配置';
COMMENT ON COLUMN "t_linked_strategy"."alarm_names" IS '告警名称';

-- ----------------------------
-- Records of t_linked_strategy
-- ----------------------------
BEGIN;
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (1, '挖矿活动检测模板', 't', 'alarmType', '/Malware/Miner', 'High,Medium', 'OK', 'f', 'template', 1, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"矿池地址（攻击者）","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (2, '间谍软件检测模板', 't', 'alarmType', '/Malware/Spyware', 'High', 'OK', 'f', 'template', 2, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (3, '蠕虫攻击检测模板', 't', 'alarmType', '/Malware/Worm', 'High', 'OK', 'f', 'template', 3, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (4, '木马病毒检测模板', 't', 'alarmType', '/Malware/Virus,/Malware/PasswordSteal,/Malware/Trojan', 'High', 'OK', 'f', 'template', 4, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (5, '网页挂马检测模板', 't', 'alarmType', '/Malware/WebTrojan', 'High', 'OK', 'f', 'template', 5, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (6, '勒索软件检测模板', 't', 'alarmType', '/Malware/Ransomware', 'High', 'OK', 'f', 'template', 6, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (7, '僵尸网络检测模板', 't', 'alarmType', '/Malware/BotTrojWorm', 'High', 'OK', 'f', 'template', 7, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (8, '黑客工具检测模板', 't', 'alarmType', '/Malware/HackTool', 'High', 'OK', 'f', 'template', 8, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (9, '键盘记录检测模板', 't', 'alarmType', '/Malware/KeyLogger', 'High', 'OK', 'f', 'template', 9, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (10, '流氓软件检测模板', 't', 'alarmType', '/Malware/PUP', 'High', 'OK', 'f', 'template', 10, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (11, '远程控制检测模板', 't', 'alarmType', '/SuspTraffic/RemoteCtrl', 'High', 'OK', 'f', 'template', 11, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (12, '后门攻击检测模板', 't', 'alarmType', '/WebAttack/WebshellRequest,/WebAttack/WebshellUpload,/Malware/BackDoor,/Malware/Webshell', 'High', 'OK', 'f', 'template', 12, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["site"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (13, '漏洞攻击检测模板', 't', 'alarmType', '/Exploit/RDP,/Exploit/Shellcode,/Exploit/DeviceVul,/Exploit/SoftVul,/Exploit/SystemVul,/Exploit/SMB,/WebAttack/SQLInjection,/WebAttack/XXE,/WebAttack/CodeInjection,/WebAttack/XSS,/WebAttack/RFI,/WebAttack/SSRF,/WebAttack/DirTraversal,/WebAttack/FileUpload,/WebAttack/BypassAccCtrl,/WebAttack/CommandExec,/WebAttack/LFI,/LateralMov/RemoteExec', 'High', 'OK', 'f', 'template', 13, '2026-01-15 09:31:18+08', '2026-01-15 09:31:18+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (14, '隐蔽隧道检测模板', 't', 'alarmType', '/SuspTraffic/Tunnel', 'High', 'OK', 'f', 'template', 14, '2026-01-15 09:31:18+08', '2026-01-15 09:31:19+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"action":"block","dayOfWeek":"1,2,3,4,5,6,7","timeOfDay":"0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', NULL);
INSERT INTO "t_linked_strategy" ("id", "strategy_name", "auto_handle", "threat_type", "threat_type_config", "threat_level", "alarm_results", "status", "source", "template_id", "create_time", "update_time", "link_device_config", "alarm_names") VALUES (15, '网络钓鱼检测模板', 't', 'alarmType', '/SuspTraffic/Phishing', 'High', 'OK', 'f', 'template', 15, '2026-01-15 09:31:18+08', '2026-01-15 09:31:18+08', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]}]', NULL);
COMMIT;

-- ----------------------------
-- Table structure for t_linked_strategy_template
-- ----------------------------
DROP TABLE IF EXISTS "t_linked_strategy_template";
CREATE TABLE "t_linked_strategy_template" (
  "id" int8 NOT NULL DEFAULT nextval('t_linked_strategy_template_id_seq'::regclass),
  "template_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "threat_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "threat_type_config" text COLLATE "pg_catalog"."default" NOT NULL,
  "threat_level" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "alarm_results" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "link_device_config" text COLLATE "pg_catalog"."default" NOT NULL,
  "app_protocol" varchar(32) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'default'::character varying,
  "detect_config" text COLLATE "pg_catalog"."default" NOT NULL,
  "detect_content" text COLLATE "pg_catalog"."default" NOT NULL,
  "dispose_advice" text COLLATE "pg_catalog"."default" NOT NULL,
  "comment" text COLLATE "pg_catalog"."default" NOT NULL
)
;
ALTER TABLE "t_linked_strategy_template" OWNER TO "dbapp";
COMMENT ON COLUMN "t_linked_strategy_template"."id" IS '主键ID';
COMMENT ON COLUMN "t_linked_strategy_template"."template_name" IS '模板名称';
COMMENT ON COLUMN "t_linked_strategy_template"."threat_type" IS '威胁类型';
COMMENT ON COLUMN "t_linked_strategy_template"."threat_type_config" IS '威胁类型配置';
COMMENT ON COLUMN "t_linked_strategy_template"."threat_level" IS '威胁等级';
COMMENT ON COLUMN "t_linked_strategy_template"."alarm_results" IS '攻击结果';
COMMENT ON COLUMN "t_linked_strategy_template"."link_device_config" IS '策略页面配置';
COMMENT ON COLUMN "t_linked_strategy_template"."app_protocol" IS '协议类型';
COMMENT ON COLUMN "t_linked_strategy_template"."detect_config" IS '检测配置';
COMMENT ON COLUMN "t_linked_strategy_template"."detect_content" IS '检测内容';
COMMENT ON COLUMN "t_linked_strategy_template"."dispose_advice" IS '处置建议';
COMMENT ON COLUMN "t_linked_strategy_template"."comment" IS '备注';
COMMENT ON TABLE "t_linked_strategy_template" IS '联动策略内置模板表';

-- ----------------------------
-- Records of t_linked_strategy_template
-- ----------------------------
BEGIN;
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (1, '挖矿活动检测模板', 'alarmType', '/Malware/Miner', 'High,Medium', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"矿池地址（攻击者）","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '挖矿木马通讯及相关APT组织或恶意家族活动', '1、建议通过AiNTA设备对DNS协议的挖矿活动事件提取域名信息中的A记录进行封禁；对非DNS协议挖矿活动事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/挖矿木马事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：矿池地址（攻击者）
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (2, '间谍软件检测模板', 'alarmType', '/Malware/Spyware', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '暗网域名访问及相关APT组织或恶意家族活动', '1、建议通过AiNTA设备对DNS协议的间谍软件事件提取域名信息中的A记录进行封禁；对非DNS协议间谍软件事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/间谍软件事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (3, '蠕虫攻击检测模板', 'alarmType', '/Malware/Worm', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '蠕虫病毒攻击及相关APT组织或恶意家族活动', '1、建议通过AiNTA设备对DNS协议的蠕虫攻击事件提取域名信息中的A记录进行封禁；对非DNS协议蠕虫攻击事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/蠕虫事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (4, '木马病毒检测模板', 'alarmType', '/Malware/Virus,/Malware/PasswordSteal,/Malware/Trojan', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '木马、计算机病毒及相关APT组织或恶意家族活动', '1、建议通过AiNTA设备对DNS协议的木马病毒事件提取域名信息中的A记录进行封禁；对非DNS协议木马病毒事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/计算机病毒、特洛伊木马、窃密木马事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (5, '网页挂马检测模板', 'alarmType', '/Malware/WebTrojan', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '挂马网页', '1、建议通过AiNTA设备对DNS协议的网页挂马事件提取域名信息中的A记录进行封禁；对非DNS协议网页挂马事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/网页内嵌恶意代码事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (6, '勒索软件检测模板', 'alarmType', '/Malware/Ransomware', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '勒索软件及相关APT组织或恶意家族活动', '1、建议通过AiNTA设备对DNS协议的勒索软件事件提取域名信息中的A记录进行封禁；对非DNS协议勒索软件事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/勒索软件事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (7, '僵尸网络检测模板', 'alarmType', '/Malware/BotTrojWorm', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '僵尸程序感染', '1、建议通过AiNTA设备对DNS协议的僵尸网络事件提取域名信息中的A记录进行封禁；对非DNS协议僵尸网络事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/僵尸网络事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (8, '黑客工具检测模板', 'alarmType', '/Malware/HackTool', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '黑客工具的使用及相关APT组织或恶意家族活动', '1、建议通过AiNTA设备对DNS协议的黑客工具事件提取域名信息中的A记录进行封禁；对非DNS协议黑客工具事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/黑客工具事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (9, '键盘记录检测模板', 'alarmType', '/Malware/KeyLogger', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '键盘记录回连行为及相关APT组织或恶意家族活动', '1、建议通过AiNTA设备对DNS协议的键盘记录事件提取域名信息中的A记录进行封禁；对非DNS协议键盘记录事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/键盘记录事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (10, '流氓软件检测模板', 'alarmType', '/Malware/PUP', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '流氓软件的使用及相关APT组织或恶意家族活动', '1、建议通过AiNTA设备对DNS协议的流氓软件事件提取域名信息中的A记录进行封禁；对非DNS协议流氓软件事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/流氓软件事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (11, '远程控制检测模板', 'alarmType', '/SuspTraffic/RemoteCtrl', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'dns', '{"dasca-dbappsecurity-ainta":{"dns":"responseAddress","default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '远程控制类可疑通信', '1、建议通过AiNTA设备对DNS协议的远程控制事件提取域名信息中的A记录进行封禁；对非DNS协议远程控制事件的攻击者IP进行封禁
2、建议通过EDR设备对受害主机进行安全扫描，若发现受害者主机已失陷请进行及时隔离', '1、如果产生DNS协议的有害程序事件/混合攻击事件，则提取告警中的responseAddress作为封禁IP下发给AiNTA进行访问封禁，同时对受害者IP下发给EDR设备进行扫描；非DNS协议将攻击者IP作为封禁IP下发给给AiNTA，同时对受害者IP下发给EDR设备进行扫描
2、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
3、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (12, '后门攻击检测模板', 'alarmType', '/WebAttack/WebshellRequest,/WebAttack/WebshellUpload,/Malware/BackDoor,/Malware/Webshell', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["site"]}]}]', 'default', '{"dasca-dbappsecurity-ainta":{"default":"attacker"},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', 'webshell文件利用及相关APT组织或恶意家族活动', '对攻击者进行访问封禁，并对受害者主机进行安全扫描', '1、访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者
2、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：网站后门');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (13, '漏洞攻击检测模板', 'alarmType', '/Exploit/RDP,/Exploit/Shellcode,/Exploit/DeviceVul,/Exploit/SoftVul,/Exploit/SystemVul,/Exploit/SMB,/WebAttack/SQLInjection,/WebAttack/XXE,/WebAttack/CodeInjection,/WebAttack/XSS,/WebAttack/RFI,/WebAttack/SSRF,/WebAttack/DirTraversal,/WebAttack/FileUpload,/WebAttack/BypassAccCtrl,/WebAttack/CommandExec,/WebAttack/LFI,/LateralMov/RemoteExec', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]}]', 'default', '{"dasca-dbappsecurity-ainta":{"default":"attacker"}}', '各类漏洞检测', '对攻击者进行访问封禁', '访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (14, '隐蔽隧道检测模板', 'alarmType', '/SuspTraffic/Tunnel', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"action":"block","dayOfWeek":"1,2,3,4,5,6,7","timeOfDay":"0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","scanCycle":0,"scanTime":"","scanPath":"","action":"scan","scanType":["virus"]}]}]', 'default', '{"dasca-dbappsecurity-ainta":{},"dasca-dbappsecurity-edrv6":{"default":"victim"}}', '隐蔽隧道通信行为', '对隐蔽隧道的会话进行阻断，并对受害者主机进行安全扫描', '1、策略阻断的配置如下
动作执行日：全部
动作执行具体时段：全部
2、扫描策略的配置如下
扫描范围：全盘扫描
扫描周期：仅扫描一次
扫描下发时间：立即下发
扫描对象：病毒木马');
INSERT INTO "t_linked_strategy_template" ("id", "template_name", "threat_type", "threat_type_config", "threat_level", "alarm_results", "link_device_config", "app_protocol", "detect_config", "detect_content", "dispose_advice", "comment") VALUES (15, '网络钓鱼检测模板', 'alarmType', '/SuspTraffic/Phishing', 'High', 'OK', '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]}]', 'default', '{"dasca-dbappsecurity-ainta":{"default":"attacker"}}', '网络钓鱼行为及相关APT组织或恶意家族活动', '对攻击者进行访问封禁', '访问封禁的配置如下
封禁时长：12小时
封禁对象：攻击者');
COMMIT;

-- ----------------------------
-- Table structure for t_log_correlation_job
-- ----------------------------
DROP TABLE IF EXISTS "t_log_correlation_job";
CREATE TABLE "t_log_correlation_job" (
  "id" int8 NOT NULL DEFAULT nextval('t_log_correlation_job_id_seq'::regclass),
  "status" "t_log_correlation_job_status" NOT NULL DEFAULT 'Todo'::xdr22.t_log_correlation_job_status,
  "executor_class_name" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "parameters" text COLLATE "pg_catalog"."default",
  "echo_parameters" text COLLATE "pg_catalog"."default",
  "waiting_parameters" text COLLATE "pg_catalog"."default",
  "start_time" timestamptz(6) NOT NULL,
  "query_start_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "query_end_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_log_correlation_job" OWNER TO "dbapp";
COMMENT ON COLUMN "t_log_correlation_job"."id" IS '主键ID';
COMMENT ON COLUMN "t_log_correlation_job"."status" IS '任务状态（枚举值）：Todo[未处理]、Waiting[等待结果]';
COMMENT ON COLUMN "t_log_correlation_job"."executor_class_name" IS '任务实现类类名完整路径';
COMMENT ON COLUMN "t_log_correlation_job"."parameters" IS '查询日志或查询AiGent的关键参数Json字符串';
COMMENT ON COLUMN "t_log_correlation_job"."echo_parameters" IS '查询完毕后续动作所需Json字符串';
COMMENT ON COLUMN "t_log_correlation_job"."waiting_parameters" IS '任务需要进入"Waiting[等待结果]"的状态时，保留的参数。如：记录调用AiGent异步接口后返回的taskId';
COMMENT ON COLUMN "t_log_correlation_job"."start_time" IS '告警发送时间';
COMMENT ON COLUMN "t_log_correlation_job"."query_start_time" IS '查询起始时间';
COMMENT ON COLUMN "t_log_correlation_job"."query_end_time" IS '查询结束时间（任务触发时间）';
COMMENT ON TABLE "t_log_correlation_job" IS '日志关联任务表';

-- ----------------------------
-- Records of t_log_correlation_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_notice_history
-- ----------------------------
DROP TABLE IF EXISTS "t_notice_history";
CREATE TABLE "t_notice_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_notice_history_id_seq'::regclass),
  "user_id" int8 NOT NULL,
  "contact_type" "t_notice_history_contact_type",
  "contact_at" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "start_time_min" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "count" int8 NOT NULL,
  "alert_content" text COLLATE "pg_catalog"."default" NOT NULL,
  "failure_msg" text COLLATE "pg_catalog"."default",
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "status" bool NOT NULL DEFAULT true,
  "event_ids" text COLLATE "pg_catalog"."default",
  "modify_by" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "strategy_id" int8 NOT NULL
)
;
ALTER TABLE "t_notice_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_notice_history"."user_id" IS '通知人ID';
COMMENT ON COLUMN "t_notice_history"."contact_at" IS '通知用户时间';
COMMENT ON COLUMN "t_notice_history"."start_time_min" IS '告警数据中最小的startTime值';
COMMENT ON COLUMN "t_notice_history"."count" IS '告警总数';
COMMENT ON COLUMN "t_notice_history"."alert_content" IS '告警内容';
COMMENT ON COLUMN "t_notice_history"."failure_msg" IS '告警执行失败原因';
COMMENT ON COLUMN "t_notice_history"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_notice_history"."status" IS '告警执行状态';
COMMENT ON COLUMN "t_notice_history"."event_ids" IS '告警检测的数据Id列表';
COMMENT ON COLUMN "t_notice_history"."modify_by" IS '记录修改人';
COMMENT ON COLUMN "t_notice_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_notice_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_notice_history"."strategy_id" IS '策略ID';

-- ----------------------------
-- Records of t_notice_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_out_going_config
-- ----------------------------
DROP TABLE IF EXISTS "t_out_going_config";
CREATE TABLE "t_out_going_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_out_going_config_id_seq'::regclass),
  "server_name" varchar(255) COLLATE "pg_catalog"."default",
  "server_address" text COLLATE "pg_catalog"."default",
  "auth_tick" text COLLATE "pg_catalog"."default",
  "port" varchar(50) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "protocol" varchar(10) COLLATE "pg_catalog"."default",
  "enable" int4 NOT NULL DEFAULT 1,
  "type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "alarm_config_id" int8,
  "event_config_id" int8,
  "risk_config_id" int8,
  "is_del" int4 NOT NULL DEFAULT 0,
  "create_time" timestamptz(6),
  "update_time" timestamptz(6),
  "kafka_topic" text COLLATE "pg_catalog"."default",
  "encryption_type" varchar(20) COLLATE "pg_catalog"."default",
  "ca_cert_path" text COLLATE "pg_catalog"."default",
  "is_system_ca" bool,
  "compress_mode" varchar(20) COLLATE "pg_catalog"."default",
  "principal" varchar(255) COLLATE "pg_catalog"."default",
  "key_tab_path" varchar(255) COLLATE "pg_catalog"."default",
  "kdc_server_name" varchar(255) COLLATE "pg_catalog"."default",
  "kafka_server_name" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_out_going_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_out_going_config"."id" IS '主键id';
COMMENT ON COLUMN "t_out_going_config"."server_name" IS '服务器名称';
COMMENT ON COLUMN "t_out_going_config"."server_address" IS '服务器地址';
COMMENT ON COLUMN "t_out_going_config"."auth_tick" IS '认证凭证，JSON格式';
COMMENT ON COLUMN "t_out_going_config"."port" IS '端口';
COMMENT ON COLUMN "t_out_going_config"."protocol" IS '传输协议（UDP/TCP）';
COMMENT ON COLUMN "t_out_going_config"."enable" IS '是否开启（1是，0否）';
COMMENT ON COLUMN "t_out_going_config"."type" IS '外发类型（API/SYSLOG）';
COMMENT ON COLUMN "t_out_going_config"."alarm_config_id" IS '告警配置表关联id';
COMMENT ON COLUMN "t_out_going_config"."event_config_id" IS '事件配置表关联id';
COMMENT ON COLUMN "t_out_going_config"."risk_config_id" IS '风险事件配置关联id';
COMMENT ON COLUMN "t_out_going_config"."is_del" IS '是否已删除（1是，0否）';
COMMENT ON COLUMN "t_out_going_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_out_going_config"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_out_going_config"."kafka_topic" IS 'kafka发送主题';
COMMENT ON COLUMN "t_out_going_config"."encryption_type" IS 'kafka加密方式';
COMMENT ON COLUMN "t_out_going_config"."ca_cert_path" IS 'kafka ca证书路径';
COMMENT ON COLUMN "t_out_going_config"."is_system_ca" IS '是否系统默认ca证书';
COMMENT ON COLUMN "t_out_going_config"."compress_mode" IS 'kafka压缩方式';
COMMENT ON COLUMN "t_out_going_config"."principal" IS 'kafka权限校验';
COMMENT ON COLUMN "t_out_going_config"."key_tab_path" IS 'kafka keyTab文件路径';
COMMENT ON COLUMN "t_out_going_config"."kdc_server_name" IS 'kdc主机名';
COMMENT ON COLUMN "t_out_going_config"."kafka_server_name" IS '服务名称';

-- ----------------------------
-- Records of t_out_going_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_process_chain
-- ----------------------------
DROP TABLE IF EXISTS "t_process_chain";
CREATE TABLE "t_process_chain" (
  "id" int8 NOT NULL DEFAULT nextval('t_process_chain_id_seq'::regclass),
  "cache_key" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "chain_data" text COLLATE "pg_catalog"."default" NOT NULL,
  "trace_ids" text COLLATE "pg_catalog"."default",
  "host_addresses" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(50) COLLATE "pg_catalog"."default",
  "node_count" int8,
  "edge_count" int8,
  "create_time" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_process_chain" OWNER TO "dbapp";
COMMENT ON COLUMN "t_process_chain"."id" IS '主键ID';
COMMENT ON COLUMN "t_process_chain"."cache_key" IS '缓存键：eventCode_ip 即子事件 uniq_code';
COMMENT ON COLUMN "t_process_chain"."chain_data" IS '进程链JSON数据';
COMMENT ON COLUMN "t_process_chain"."trace_ids" IS 'traceId列表（逗号分隔）';
COMMENT ON COLUMN "t_process_chain"."host_addresses" IS 'IP地址列表（逗号分隔）';
COMMENT ON COLUMN "t_process_chain"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_process_chain"."node_count" IS '节点数量';
COMMENT ON COLUMN "t_process_chain"."edge_count" IS '边数量';
COMMENT ON COLUMN "t_process_chain"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_process_chain"."update_time" IS '更新时间';
COMMENT ON TABLE "t_process_chain" IS '当天进程链缓存表';

-- ----------------------------
-- Records of t_process_chain
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_process_chain_history
-- ----------------------------
DROP TABLE IF EXISTS "t_process_chain_history";
CREATE TABLE "t_process_chain_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_process_chain_history_id_seq'::regclass),
  "cache_key" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "chain_data" text COLLATE "pg_catalog"."default" NOT NULL,
  "trace_ids" text COLLATE "pg_catalog"."default",
  "host_addresses" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(50) COLLATE "pg_catalog"."default",
  "node_count" int8,
  "edge_count" int8,
  "create_time" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_process_chain_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_process_chain_history"."id" IS '主键ID';
COMMENT ON COLUMN "t_process_chain_history"."cache_key" IS '缓存键：eventCode_ip 即子事件 uniq_code';
COMMENT ON COLUMN "t_process_chain_history"."chain_data" IS '进程链JSON数据';
COMMENT ON COLUMN "t_process_chain_history"."trace_ids" IS 'traceId列表（逗号分隔）';
COMMENT ON COLUMN "t_process_chain_history"."host_addresses" IS 'IP地址列表（逗号分隔）';
COMMENT ON COLUMN "t_process_chain_history"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_process_chain_history"."node_count" IS '节点数量';
COMMENT ON COLUMN "t_process_chain_history"."edge_count" IS '边数量';
COMMENT ON COLUMN "t_process_chain_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_process_chain_history"."update_time" IS '更新时间';
COMMENT ON TABLE "t_process_chain_history" IS '历史进程链缓存表';

-- ----------------------------
-- Records of t_process_chain_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_process_kill_history
-- ----------------------------
DROP TABLE IF EXISTS "t_process_kill_history";
CREATE TABLE "t_process_kill_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_process_kill_history_id_seq'::regclass),
  "strategy_id" int8 NOT NULL,
  "strategy_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "node_ip" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "node_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "os_str" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "device_ip" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "device_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "device_type" varchar(255) COLLATE "pg_catalog"."default",
  "action" "t_process_kill_history_action" NOT NULL DEFAULT '病毒查杀'::xdr22.t_process_kill_history_action,
  "process_id" varchar(255) COLLATE "pg_catalog"."default",
  "image" text COLLATE "pg_catalog"."default",
  "last_occur_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "source" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'manual'::character varying
)
;
ALTER TABLE "t_process_kill_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_process_kill_history"."id" IS '主键ID';
COMMENT ON COLUMN "t_process_kill_history"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_process_kill_history"."strategy_name" IS '策略名称';
COMMENT ON COLUMN "t_process_kill_history"."node_ip" IS '终端操作系统IP';
COMMENT ON COLUMN "t_process_kill_history"."node_id" IS '联动设备ID';
COMMENT ON COLUMN "t_process_kill_history"."os_str" IS '终端操作系统类型';
COMMENT ON COLUMN "t_process_kill_history"."device_ip" IS '联动设备IP';
COMMENT ON COLUMN "t_process_kill_history"."device_id" IS '联动设备id';
COMMENT ON COLUMN "t_process_kill_history"."device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_process_kill_history"."action" IS '下发的主机动作';
COMMENT ON COLUMN "t_process_kill_history"."process_id" IS '进程id';
COMMENT ON COLUMN "t_process_kill_history"."last_occur_time" IS '最后一次时间';
COMMENT ON COLUMN "t_process_kill_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_process_kill_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_process_kill_history"."source" IS '策略来源';
COMMENT ON TABLE "t_process_kill_history" IS '下发记录表';

-- ----------------------------
-- Records of t_process_kill_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_prohibit_domain_history
-- ----------------------------
DROP TABLE IF EXISTS "t_prohibit_domain_history";
CREATE TABLE "t_prohibit_domain_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_prohibit_domain_history_id_seq'::regclass),
  "block_domain" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_type" varchar(16) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" bool DEFAULT true,
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "effect_time" varchar(255) COLLATE "pg_catalog"."default" DEFAULT '0'::character varying,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "source" varchar(255) COLLATE "pg_catalog"."default" DEFAULT 'manual'::character varying,
  "create_type" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'none'::character varying,
  "strategy_id" int8 NOT NULL,
  "file_block" int4,
  "process_block" int4,
  "nta_name" varchar(100) COLLATE "pg_catalog"."default",
  "launch_times" int4 NOT NULL DEFAULT 1,
  "recovery_id" varchar(100) COLLATE "pg_catalog"."default",
  "direction" int8 NOT NULL DEFAULT '1'::bigint,
  "node_ip" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "node_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_prohibit_domain_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_prohibit_domain_history"."block_domain" IS '封禁域名';
COMMENT ON COLUMN "t_prohibit_domain_history"."link_device_ip" IS '联动设备ip';
COMMENT ON COLUMN "t_prohibit_domain_history"."link_device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_prohibit_domain_history"."status" IS '生效状态';
COMMENT ON COLUMN "t_prohibit_domain_history"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_prohibit_domain_history"."effect_time" IS '生效时长，0-永久';
COMMENT ON COLUMN "t_prohibit_domain_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_prohibit_domain_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_prohibit_domain_history"."source" IS '来源';
COMMENT ON COLUMN "t_prohibit_domain_history"."create_type" IS '添加方式';
COMMENT ON COLUMN "t_prohibit_domain_history"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_prohibit_domain_history"."file_block" IS '1-文件隔离 2-忽略';
COMMENT ON COLUMN "t_prohibit_domain_history"."process_block" IS '1-禁止联网 2-关闭进程 4-忽略';
COMMENT ON COLUMN "t_prohibit_domain_history"."nta_name" IS 'AiNTA策略名称/agent终端id';
COMMENT ON COLUMN "t_prohibit_domain_history"."launch_times" IS '下发次数';
COMMENT ON COLUMN "t_prohibit_domain_history"."recovery_id" IS 'agent解禁id';
COMMENT ON COLUMN "t_prohibit_domain_history"."direction" IS '1:入站,2:出战,3:出入站';
COMMENT ON COLUMN "t_prohibit_domain_history"."node_ip" IS '主机ip';
COMMENT ON COLUMN "t_prohibit_domain_history"."node_id" IS '主机id';
COMMENT ON TABLE "t_prohibit_domain_history" IS '域名封禁下发记录';

-- ----------------------------
-- Records of t_prohibit_domain_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_prohibit_history
-- ----------------------------
DROP TABLE IF EXISTS "t_prohibit_history";
CREATE TABLE "t_prohibit_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_prohibit_history_id_seq'::regclass),
  "block_ip" varchar(2048) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "second_ip" varchar(2048) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_type" varchar(16) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" bool DEFAULT true,
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "effect_time" varchar(255) COLLATE "pg_catalog"."default" DEFAULT '0'::character varying,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "source" varchar(255) COLLATE "pg_catalog"."default" DEFAULT 'manual'::character varying,
  "create_type" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'none'::character varying,
  "strategy_id" int8 NOT NULL,
  "file_block" int4,
  "process_block" int4,
  "nta_name" varchar(100) COLLATE "pg_catalog"."default",
  "launch_times" int4 NOT NULL DEFAULT 1,
  "recovery_id" varchar(100) COLLATE "pg_catalog"."default",
  "direction" int8 NOT NULL DEFAULT '3'::bigint,
  "node_ip" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "node_id" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_prohibit_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_prohibit_history"."block_ip" IS '阻断ip';
COMMENT ON COLUMN "t_prohibit_history"."second_ip" IS '目的ip';
COMMENT ON COLUMN "t_prohibit_history"."link_device_ip" IS '联动设备ip';
COMMENT ON COLUMN "t_prohibit_history"."link_device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_prohibit_history"."status" IS '生效状态';
COMMENT ON COLUMN "t_prohibit_history"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_prohibit_history"."effect_time" IS '生效时长，0-永久';
COMMENT ON COLUMN "t_prohibit_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_prohibit_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_prohibit_history"."source" IS '来源';
COMMENT ON COLUMN "t_prohibit_history"."create_type" IS '添加方式';
COMMENT ON COLUMN "t_prohibit_history"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_prohibit_history"."file_block" IS '1-文件隔离 2-忽略';
COMMENT ON COLUMN "t_prohibit_history"."process_block" IS '1-禁止联网 2-关闭进程 4-忽略';
COMMENT ON COLUMN "t_prohibit_history"."launch_times" IS '下发次数';
COMMENT ON COLUMN "t_prohibit_history"."recovery_id" IS 'agent解禁id';
COMMENT ON COLUMN "t_prohibit_history"."direction" IS '1:入站,2:出战,3:出入站';
COMMENT ON COLUMN "t_prohibit_history"."node_ip" IS '主机ip';
COMMENT ON COLUMN "t_prohibit_history"."node_id" IS '主机id';

-- ----------------------------
-- Records of t_prohibit_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_query_template
-- ----------------------------
DROP TABLE IF EXISTS "t_query_template";
CREATE TABLE "t_query_template" (
  "id" int8 NOT NULL DEFAULT nextval('t_query_template_id_seq'::regclass),
  "template_name" varchar(50) COLLATE "pg_catalog"."default",
  "template_code" varchar(50) COLLATE "pg_catalog"."default",
  "attack_conclusion" text COLLATE "pg_catalog"."default",
  "ck_query_condition" text COLLATE "pg_catalog"."default",
  "ck_query_field" text COLLATE "pg_catalog"."default",
  "ck_query_agg_field" text COLLATE "pg_catalog"."default",
  "interval_time" int8,
  "description" text COLLATE "pg_catalog"."default",
  "suggestion" text COLLATE "pg_catalog"."default",
  "record_field" text COLLATE "pg_catalog"."default",
  "last_execute_time" timestamptz(6),
  "agg_field" text COLLATE "pg_catalog"."default",
  "inner_query_field" text COLLATE "pg_catalog"."default",
  "outer_query_field" text COLLATE "pg_catalog"."default",
  "enable" int8,
  "is_thread" int8,
  "category" varchar(50) COLLATE "pg_catalog"."default",
  "sub_category" varchar(50) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_query_template" OWNER TO "dbapp";
COMMENT ON COLUMN "t_query_template"."id" IS '唯一id';
COMMENT ON COLUMN "t_query_template"."template_name" IS '模板名称';
COMMENT ON COLUMN "t_query_template"."template_code" IS '模板code';
COMMENT ON COLUMN "t_query_template"."attack_conclusion" IS '攻击总结';
COMMENT ON COLUMN "t_query_template"."ck_query_condition" IS 'ck查询条件';
COMMENT ON COLUMN "t_query_template"."ck_query_field" IS 'ck查询展示字段';
COMMENT ON COLUMN "t_query_template"."ck_query_agg_field" IS 'ck查询聚合字段';
COMMENT ON COLUMN "t_query_template"."interval_time" IS '查询间隔时间';
COMMENT ON COLUMN "t_query_template"."description" IS '描述';
COMMENT ON COLUMN "t_query_template"."suggestion" IS '建议';
COMMENT ON COLUMN "t_query_template"."record_field" IS '攻击记录展示字段';
COMMENT ON COLUMN "t_query_template"."last_execute_time" IS '上次执行成功时间';
COMMENT ON COLUMN "t_query_template"."agg_field" IS '聚合字段';
COMMENT ON COLUMN "t_query_template"."inner_query_field" IS '内查询字段';
COMMENT ON COLUMN "t_query_template"."outer_query_field" IS '外查询字段';
COMMENT ON COLUMN "t_query_template"."enable" IS '是否启用（0不启用，1启用）';
COMMENT ON COLUMN "t_query_template"."is_thread" IS '是否线头（0否，1是）';
COMMENT ON COLUMN "t_query_template"."category" IS '安全事件类型';
COMMENT ON COLUMN "t_query_template"."sub_category" IS '安全事件子类型';

-- ----------------------------
-- Records of t_query_template
-- ----------------------------
BEGIN;
INSERT INTO "t_query_template" ("id", "template_name", "template_code", "attack_conclusion", "ck_query_condition", "ck_query_field", "ck_query_agg_field", "interval_time", "description", "suggestion", "record_field", "last_execute_time", "agg_field", "inner_query_field", "outer_query_field", "enable", "is_thread", "category", "sub_category") VALUES (1, '暴力破解攻击事件', 'Brute_Force_Attack', '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次，攻击失败#{failCount}次，尝试#{tryCount}次。', 'attacker,subCategory', '_victim as victim:受害者,_appProtocol as appProtocol:应用协议,_srcUserName as srcUserName:登录用户名,_passwd as passwd:登录密码,sum(_eventCount) as counts:次数,max(_alarmResults) as alarmResults:告警结果,Max(_endTime) as timeStamp:攻击时间,Min(_endTime) as startTime:开始时间,Max(_endTime) as endTime:结束时间', '_victim,_appProtocol,_srcUserName,_passwd', 20, '暴力破解通过使用枚举方法，一个一个使用用户名和密码字典，尝试登陆各种系统，如：WEB、FTP、邮箱、SMB，直到得到正确结果，是一种攻击手段。为了提高效率，暴力破解一般会使用带有字典的攻击来进行自动化操作。
采用比较弱的认证策略，系统账号肯能会被爆破成功。
', '1、确认暴破来源；
2、当攻击者来源于互联网时，请使用<处置联动>功能进行一键封堵；
3、建议系统完善认证策略，如：1.要求用户设置复杂的密码。2.对尝试登陆行为进行判断及限制。3.采用双因子认证。
', NULL, '2021-11-08 19:36:00+08', '_attacker,_subCategory', 'subCategory =''/AccountRisk/BruteForce''', NULL, 1, 0, '/networkAttackIncident', '/networkAttackIncident/bruteForceIncident');
INSERT INTO "t_query_template" ("id", "template_name", "template_code", "attack_conclusion", "ck_query_condition", "ck_query_field", "ck_query_agg_field", "interval_time", "description", "suggestion", "record_field", "last_execute_time", "agg_field", "inner_query_field", "outer_query_field", "enable", "is_thread", "category", "sub_category") VALUES (2, '漏洞利用事件', 'Exploit_Vulnerability', '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次，攻击失败#{failCount}次，尝试#{tryCount}次。', 'attacker,subCategory', '_victim as victim:被扫描IP,_IoCThreatName as IoCThreatName:漏洞名称,sum(_eventCount) as counts:次数,max(_alarmResults) as alarmResults:告警结果,Max(_endTime) as timeStamp:攻击时间,Min(_endTime) as startTime:开始时间,Max(_endTime) as endTime:结束时间', '_victim,_IoCThreatName', 20, '漏洞利用事件是指攻击者利用公开漏洞利用程序对目标网站或者服务发起的大量漏洞攻击事件。当攻击者利用漏洞攻击成功，可以导致目标网站或服务被接管，从而造成服务停止或者财产损失。', '1、排查发起者是否为内部授信漏洞扫描器所为,则对发起IP添加至白名单；
2、若非内部授信漏洞扫描器所为，请及时封禁相应IP;
3、日常及时修复目标主机所存在的漏洞。', NULL, '2021-11-08 19:36:00+08', '_attacker,_subCategory', '', 'ruleNameCount > 10', 1, 0, '/networkAttackIncident', '/networkAttackIncident/vulExploitIncident');
INSERT INTO "t_query_template" ("id", "template_name", "template_code", "attack_conclusion", "ck_query_condition", "ck_query_field", "ck_query_agg_field", "interval_time", "description", "suggestion", "record_field", "last_execute_time", "agg_field", "inner_query_field", "outer_query_field", "enable", "is_thread", "category", "sub_category") VALUES (3, '端口扫描事件', 'Port_Scan', '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次，攻击失败#{failCount}次，尝试#{tryCount}次。', 'attacker,subCategory', '_victim as victim:被扫描IP,_destPort as destPort:被扫描的端口,sum(_eventCount) as counts:次数,max(_alarmResults) as alarmResults:告警结果,Max(_endTime) as timeStamp:攻击时间,Min(_endTime) as startTime:开始时间,Max(_endTime) as endTime:结束时间', '_victim,_destPort', 20, '端口扫事件是指攻击者利用端口扫描器在一段时间范围内针对目标发起的多端口枚举事件。端口扫描一般发生在攻击阶段的初始阶段，攻击者通常是为了探测更多的端口开放信息。', '1、排查发起者是否为内部授信端口扫描器所为,则对发起IP添加至白名单；
2、若非内部授信端口扫描器所为，请及时封禁相应IP;
3、关闭不必要的端口，防止攻击者进行端口探测以及密码爆破。', NULL, '2021-11-08 19:36:00+08', '_attacker,_subCategory', 'subCategory = ''/Scan/PortScan''', NULL, 1, 0, '/networkAttackIncident', '/networkAttackIncident/networkScanIncident');
INSERT INTO "t_query_template" ("id", "template_name", "template_code", "attack_conclusion", "ck_query_condition", "ck_query_field", "ck_query_agg_field", "interval_time", "description", "suggestion", "record_field", "last_execute_time", "agg_field", "inner_query_field", "outer_query_field", "enable", "is_thread", "category", "sub_category") VALUES (4, '#{organization} APT组织活动事件', 'Activities_Of_APT_Organization', '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次，攻击失败#{failCount}次，尝试#{tryCount}次。', 'victim,subCategory,organizationId', '_requestDomain as requestDomain:外联请求域名,_attacker as attacker:外联IP,MAX(_organizationId) as organization:APT组织名称,info:组织信息,sum(_eventCount) as counts:次数,max(_alarmResults) as alarmResults:告警结果,Min(_endTime) as startTime:开始时间,Max(_endTime) as endTime:结束时间', '_requestDomain,_attacker', 1440, 'APT类恶意域名活动事件是指现网中检测到APT组织所利用的域名等基础信息。APT组织的目标群体通常是大型企事业单位，存在APT域名访问表明现网中存在APT组织所使用的攻击工具运行，存在机密信息泄露的风险。', '1、及时在发起者主机使用主流杀毒软件进行文件查杀；
2、提高安全防范意识，不点击来路不明的邮件。
', NULL, '2021-11-08 19:36:00+08', '_victim,_subCategory,_organizationId', 'ruleId = ''99999999'' and organizationId !='''' AND subCategory in [''/Malware/BotTrojWorm'',''/Malware/Ransomware'',''/Malware/Worm'']', NULL, 1, 0, NULL, NULL);
INSERT INTO "t_query_template" ("id", "template_name", "template_code", "attack_conclusion", "ck_query_condition", "ck_query_field", "ck_query_agg_field", "interval_time", "description", "suggestion", "record_field", "last_execute_time", "agg_field", "inner_query_field", "outer_query_field", "enable", "is_thread", "category", "sub_category") VALUES (5, '#{family} 家族活动事件', 'Activities_Of_Family', '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次，攻击失败#{failCount}次，尝试#{tryCount}次。', 'victim,subCategory,familyId', '_requestDomain as requestDomain:外联请求域名,_attacker as attacker:外联IP,MAX(_familyId) as family:恶意软件家族名称,info:家族信息,sum(_eventCount) as counts:次数,max(_alarmResults) as alarmResults:告警结果,Min(_endTime) as startTime:开始时间,Max(_endTime) as endTime:结束时间', '_requestDomain,_attacker', 1440, '恶意软件类恶意域名活动事件是指当受害者主机被植入恶意软件的情况下，恶意软件会主动发起域名请求以保持与攻击者进来通讯、或者回传敏感信息等。若主机发起恶意域名请求，则说明发起主机存在恶意软件运行。', '1、及时在发起者主机使用主流杀毒软件进行文件查杀；
2、提高安全防范意识，不点击来路不明的邮件、应用程序等。
', NULL, '2021-11-08 19:36:00+08', '_victim,_subCategory,_familyId', 'ruleId = ''99999999'' and familyId != '''' AND subCategory in [''/Malware/BotTrojWorm'',''/Malware/Ransomware'',''/Malware/Worm'']', NULL, 1, 0, NULL, NULL);
INSERT INTO "t_query_template" ("id", "template_name", "template_code", "attack_conclusion", "ck_query_condition", "ck_query_field", "ck_query_agg_field", "interval_time", "description", "suggestion", "record_field", "last_execute_time", "agg_field", "inner_query_field", "outer_query_field", "enable", "is_thread", "category", "sub_category") VALUES (6, '敏感目录或文件探测事件', 'File_Event', '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次，攻击失败#{failCount}次，尝试#{tryCount}次。', 'attacker,subCategory', '_victim as victim:受害者,_requestUrl as requestUrl:敏感信息,sum(_eventCount) as counts:次数,max(_alarmResults) as alarmResults:告警结果,Max(_endTime) as timeStamp:攻击时间,Min(_endTime) as startTime:开始时间,Max(_endTime) as endTime:结束时间', '_victim,_requestUrl', 20, '敏感目录或文件探测事件是指针对目标网站发起的可以泄露敏感信息的文件后缀扫描。攻击者通常是为了获取网站配置以及IP配置信息等。若攻击成功，则可造成敏感信息泄露。', '1、及时封禁攻击者IP；
2、使用安全设备(WAF,IPS)进行防护；
3、删除不必要的敏感文件信息。
', NULL, '2021-11-08 19:38:01+08', '_attacker,_subCategory', 'incidentClue = ''0'' AND incidentName = ''敏感目录或文件探测事件'' ', 'attacker = [''#{attacker}''] AND subCategory = ''#{subCategory}''', 1, 1, '/networkAttackIncident', '/networkAttackIncident/networkScanIncident');
INSERT INTO "t_query_template" ("id", "template_name", "template_code", "attack_conclusion", "ck_query_condition", "ck_query_field", "ck_query_agg_field", "interval_time", "description", "suggestion", "record_field", "last_execute_time", "agg_field", "inner_query_field", "outer_query_field", "enable", "is_thread", "category", "sub_category") VALUES (7, 'Webshell文件探测事件', 'Web_Shell_Event', '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次，攻击失败#{failCount}次，尝试#{tryCount}次。', 'attacker,subCategory', '_victim as victim:受害者,_requestUrl as requestUrl:URL,sum(_eventCount) as counts:次数,max(_alarmResults) as alarmResults:告警结果,Max(_endTime) as timeStamp:攻击时间,Min(_endTime) as startTime:开始时间,Max(_endTime) as endTime:结束时间', '_victim,_requestUrl', 10, '系统站点存在webshell网页木马。
webshell网页木马就是以asp、php、jsp或者cgi脚本木马后门。黑客在入侵了一个网站后，常常会在将这些asp或php木马后门文件放置在网站服务器的web目录中，与正常的网页文件混在一起。然后黑客就可以用web的方式通过asp或php木马后门控制网站服务器，包括上传下载编辑以及篡改网站文件代码、查看数据库、执行任意程序命令拿到服务器权限等。
', '1、在服务器上找到并删除Webshell后门文件；
2、及时修复网站存在的漏洞；
3、使用安全设备(WAF,IPS)进行防护。
', NULL, '2021-11-08 19:38:01+08', '_attacker,_subCategory', 'incidentClue = ''0'' AND incidentName = ''Webshell文件探测事件'' ', 'attacker = [''#{attacker}''] AND incidentName = ''#{incidentName}''', 1, 1, '/networkAttackIncident', '/networkAttackIncident/backdoorIncident');
INSERT INTO "t_query_template" ("id", "template_name", "template_code", "attack_conclusion", "ck_query_condition", "ck_query_field", "ck_query_agg_field", "interval_time", "description", "suggestion", "record_field", "last_execute_time", "agg_field", "inner_query_field", "outer_query_field", "enable", "is_thread", "category", "sub_category") VALUES (8, 'Struts2漏洞利用事件', 'Struts2_Event', '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次，攻击失败#{failCount}次，尝试#{tryCount}次。', 'attacker,subCategory', '_victim as victim:受害者,_requestUrl as requestUrl:漏洞利用URL,sum(_eventCount) as counts:次数,max(_alarmResults) as alarmResults:告警结果,Max(_endTime) as timeStamp:攻击时间,Min(_endTime) as startTime:开始时间,Max(_endTime) as endTime:结束时间', '_victim,_requestUrl', 20, 'Struts2漏洞利用事件是指利用Struts2漏洞利用工对目标网站发起具有针对性的网络攻击，该类攻击通常面向具有JAVA语言编写的Web网站。若攻击成功，攻击者可以接管目标网站，造成财产损失。', '1、使用安全设备(WAF,IPS)进行防护；
2、及时修复网站存在的漏洞。
', NULL, '2021-11-08 19:38:01+08', '_attacker,_subCategory', 'incidentClue = ''0'' AND incidentName = ''Struts2漏洞利用事件'' ', 'attacker = [''#{attacker}''] AND incidentName = ''#{incidentName}''', 1, 1, '/networkAttackIncident', '/networkAttackIncident/vulExploitIncident');
INSERT INTO "t_query_template" ("id", "template_name", "template_code", "attack_conclusion", "ck_query_condition", "ck_query_field", "ck_query_agg_field", "interval_time", "description", "suggestion", "record_field", "last_execute_time", "agg_field", "inner_query_field", "outer_query_field", "enable", "is_thread", "category", "sub_category") VALUES (9, 'Sqlmap注入工具利用事件', 'Sqlmap_Event', '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次，攻击失败#{failCount}次，尝试#{tryCount}次。', 'attacker,subCategory', '_victim as victim:受害者,_requestUrl as requestUrl:攻击URL,sum(_eventCount) as counts:次数,max(_alarmResults) as alarmResults:告警结果,Max(_endTime) as timeStamp:攻击时间,Min(_endTime) as startTime:开始时间,Max(_endTime) as endTime:结束时间', '_victim,_requestUrl', 20, 'Sqlmap注入工具利用事件是指利用Sqlmap注入工具对目标网站发起大量的SQL注入攻击，若攻击成功攻击者可以获取数据库的敏感信息。', '1、使用安全设备(WAF,IPS)进行防护；
2、及时修复网站存在的漏洞。
', NULL, '2021-11-08 19:38:01+08', '_attacker,_subCategory', 'incidentClue = ''1'' AND incidentName = ''Sqlmap注入工具利用事件'' ', 'srcAddress = ''#{attacker}'' AND incidentRuleType = ''WebAttack/SQLInjection'' AND incidentCond = ''sip'' AND subCategory = ''#{subCategory}''', 1, 1, '/networkAttackIncident', '/networkAttackIncident/vulExploitIncident');
INSERT INTO "t_query_template" ("id", "template_name", "template_code", "attack_conclusion", "ck_query_condition", "ck_query_field", "ck_query_agg_field", "interval_time", "description", "suggestion", "record_field", "last_execute_time", "agg_field", "inner_query_field", "outer_query_field", "enable", "is_thread", "category", "sub_category") VALUES (10, 'Nmap扫描事件', 'Nmap_Event', '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次，攻击失败#{failCount}次，尝试#{tryCount}次。', 'attacker,subCategory', '_victim as victim:受害者,_category as category:告警类型,sum(_eventCount) as counts:次数,Max(_endTime) as timeStamp:攻击时间,Min(_endTime) as startTime:开始时间,Max(_endTime) as endTime:结束时间', '_victim,_category', 20, 'Nmap扫描事件是指利用Nmap扫描工具对目标网站发起大量IP或者端口扫描攻击，Nmap扫描一般发生在攻击阶段的初始阶段，攻击者通常是为了探测更多的端口或者IP开放信息。', '1、及时封禁攻击者IP；
2、使用安全设备(WAF,IPS)进行防护。
', NULL, '2021-11-08 19:38:01+08', '_attacker,_subCategory', 'incidentClue = ''1'' AND incidentName = ''Nmap工具扫描事件'' ', 'srcAddress = ''#{attacker}''  AND incidentCond = ''sip'' AND subCategory = ''#{subCategory}''', 1, 1, '/networkAttackIncident', '/networkAttackIncident/networkScanIncident');
COMMIT;

-- ----------------------------
-- Table structure for t_risk_incidents
-- ----------------------------
DROP TABLE IF EXISTS "t_risk_incidents";
CREATE TABLE "t_risk_incidents" (
  "id" int8 NOT NULL DEFAULT nextval('t_risk_incidents_id_seq'::regclass),
  "event_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "template_id" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "threat_severity" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "top_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default",
  "second_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "focus_ip" text COLLATE "pg_catalog"."default",
  "focus_object" varchar(32) COLLATE "pg_catalog"."default",
  "counts" int8,
  "alarm_status" varchar(32) COLLATE "pg_catalog"."default",
  "alarm_results" varchar(32) COLLATE "pg_catalog"."default",
  "filter_content" varchar(512) COLLATE "pg_catalog"."default",
  "event_ids" text COLLATE "pg_catalog"."default",
  "data_source" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6),
  "tag_search" text COLLATE "pg_catalog"."default",
  "is_scenario" int4 NOT NULL DEFAULT 0,
  "filter_content_aiql" varchar(1000) COLLATE "pg_catalog"."default",
  "kill_chain" varchar(255) COLLATE "pg_catalog"."default",
  "judge_result" int4 DEFAULT 0,
  "judge_status" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;
ALTER TABLE "t_risk_incidents" OWNER TO "dbapp";
COMMENT ON COLUMN "t_risk_incidents"."id" IS '唯一id';
COMMENT ON COLUMN "t_risk_incidents"."event_code" IS '事件编号，当前日期+数据源+风险事件名称+程序版本';
COMMENT ON COLUMN "t_risk_incidents"."name" IS '事件名称';
COMMENT ON COLUMN "t_risk_incidents"."template_id" IS '模板code';
COMMENT ON COLUMN "t_risk_incidents"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_risk_incidents"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_risk_incidents"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_risk_incidents"."top_event_type_chinese" IS '一级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents"."second_event_type_chinese" IS '二级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents"."focus_ip" IS '关注IP';
COMMENT ON COLUMN "t_risk_incidents"."focus_object" IS '关注对象';
COMMENT ON COLUMN "t_risk_incidents"."counts" IS '攻击次数';
COMMENT ON COLUMN "t_risk_incidents"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_risk_incidents"."alarm_results" IS '攻击结果';
COMMENT ON COLUMN "t_risk_incidents"."filter_content" IS '告警过滤条件(用于反查告警)';
COMMENT ON COLUMN "t_risk_incidents"."event_ids" IS '安全事件id列表，用于反查安全事件';
COMMENT ON COLUMN "t_risk_incidents"."data_source" IS '数据源类型：alert-告警,incident-安全事件';
COMMENT ON COLUMN "t_risk_incidents"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_risk_incidents"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_risk_incidents"."tag_search" IS '标签（数组）';
COMMENT ON COLUMN "t_risk_incidents"."is_scenario" IS '是否符合追溯条件，符合1，不符合0';
COMMENT ON COLUMN "t_risk_incidents"."filter_content_aiql" IS '事件过滤条件Aiql';
COMMENT ON COLUMN "t_risk_incidents"."judge_result" IS '研判结果：0、不展示，1、成功，2、尝试，3、无害，4、未知';
COMMENT ON COLUMN "t_risk_incidents"."judge_status" IS '研判方式：系统自动研判，威胁情报回连时序研判，主动攻击研判，人工研判';
COMMENT ON TABLE "t_risk_incidents" IS '风险事件表';

-- ----------------------------
-- Records of t_risk_incidents
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_risk_incidents_analysis
-- ----------------------------
DROP TABLE IF EXISTS "t_risk_incidents_analysis";
CREATE TABLE "t_risk_incidents_analysis" (
  "id" int8 NOT NULL DEFAULT nextval('t_risk_incidents_analysis_id_seq'::regclass),
  "risk_incidents_event_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "status" varchar(10) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'todo'::character varying,
  "core_risks" text COLLATE "pg_catalog"."default",
  "popular_interpretation" text COLLATE "pg_catalog"."default",
  "critical_dangerpoint" text COLLATE "pg_catalog"."default",
  "attack_objective" text COLLATE "pg_catalog"."default",
  "attack_disposal_suggestions" text COLLATE "pg_catalog"."default",
  "attack_info" text COLLATE "pg_catalog"."default",
  "run_error" text COLLATE "pg_catalog"."default",
  "last_run_time" timestamptz(6),
  "last_run_time_consuming" int8,
  "incidents_end_time" timestamptz(6),
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_risk_incidents_analysis" OWNER TO "dbapp";
COMMENT ON COLUMN "t_risk_incidents_analysis"."id" IS '主键ID';
COMMENT ON COLUMN "t_risk_incidents_analysis"."risk_incidents_event_code" IS '风险事件编号';
COMMENT ON COLUMN "t_risk_incidents_analysis"."status" IS '解读状态：todo[未处理]、update[有变更]、done[已经处理]';
COMMENT ON COLUMN "t_risk_incidents_analysis"."core_risks" IS '一句话描述';
COMMENT ON COLUMN "t_risk_incidents_analysis"."popular_interpretation" IS '攻击详情';
COMMENT ON COLUMN "t_risk_incidents_analysis"."critical_dangerpoint" IS '事件危害';
COMMENT ON COLUMN "t_risk_incidents_analysis"."attack_objective" IS '攻击意图';
COMMENT ON COLUMN "t_risk_incidents_analysis"."attack_disposal_suggestions" IS '处置建议';
COMMENT ON COLUMN "t_risk_incidents_analysis"."attack_info" IS '攻击信息';
COMMENT ON COLUMN "t_risk_incidents_analysis"."run_error" IS '上次执行异常';
COMMENT ON COLUMN "t_risk_incidents_analysis"."last_run_time" IS '上次执行时间';
COMMENT ON COLUMN "t_risk_incidents_analysis"."last_run_time_consuming" IS '上次执行耗时';
COMMENT ON COLUMN "t_risk_incidents_analysis"."incidents_end_time" IS '事件最近时间';
COMMENT ON COLUMN "t_risk_incidents_analysis"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_risk_incidents_analysis"."update_time" IS '更新时间';
COMMENT ON TABLE "t_risk_incidents_analysis" IS '风险事件解读结果表';

-- ----------------------------
-- Records of t_risk_incidents_analysis
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_risk_incidents_history
-- ----------------------------
DROP TABLE IF EXISTS "t_risk_incidents_history";
CREATE TABLE "t_risk_incidents_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_risk_incidents_history_id_seq'::regclass),
  "event_id" int8 NOT NULL,
  "event_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "template_id" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "threat_severity" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "top_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default",
  "second_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "focus_ip" text COLLATE "pg_catalog"."default",
  "focus_object" varchar(32) COLLATE "pg_catalog"."default",
  "counts" int8,
  "alarm_status" varchar(32) COLLATE "pg_catalog"."default",
  "alarm_results" varchar(32) COLLATE "pg_catalog"."default",
  "filter_content" varchar(512) COLLATE "pg_catalog"."default",
  "event_ids" text COLLATE "pg_catalog"."default",
  "data_source" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_risk_incidents_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_risk_incidents_history"."id" IS '唯一id';
COMMENT ON COLUMN "t_risk_incidents_history"."event_id" IS '风险事件id';
COMMENT ON COLUMN "t_risk_incidents_history"."event_code" IS '事件编号，当前日期+数据源+风险事件名称+程序版本';
COMMENT ON COLUMN "t_risk_incidents_history"."name" IS '事件名称';
COMMENT ON COLUMN "t_risk_incidents_history"."template_id" IS '模板code';
COMMENT ON COLUMN "t_risk_incidents_history"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_risk_incidents_history"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_risk_incidents_history"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_risk_incidents_history"."top_event_type_chinese" IS '一级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents_history"."second_event_type_chinese" IS '二级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents_history"."focus_ip" IS '关注IP';
COMMENT ON COLUMN "t_risk_incidents_history"."focus_object" IS '关注对象';
COMMENT ON COLUMN "t_risk_incidents_history"."counts" IS '攻击次数';
COMMENT ON COLUMN "t_risk_incidents_history"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_risk_incidents_history"."alarm_results" IS '攻击结果';
COMMENT ON COLUMN "t_risk_incidents_history"."filter_content" IS '告警过滤条件(用于反查告警)';
COMMENT ON COLUMN "t_risk_incidents_history"."event_ids" IS '安全事件id列表，用于反查安全事件';
COMMENT ON COLUMN "t_risk_incidents_history"."data_source" IS '数据源类型：alert-告警,incident-安全事件';
COMMENT ON COLUMN "t_risk_incidents_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_risk_incidents_history"."update_time" IS '更新时间';
COMMENT ON TABLE "t_risk_incidents_history" IS '风险事件历史表';

-- ----------------------------
-- Records of t_risk_incidents_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_risk_incidents_out_going
-- ----------------------------
DROP TABLE IF EXISTS "t_risk_incidents_out_going";
CREATE TABLE "t_risk_incidents_out_going" (
  "id" int8 NOT NULL DEFAULT nextval('t_risk_incidents_out_going_id_seq'::regclass),
  "uniq_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "event_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "security_incident_id" int8,
  "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "template_id" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "top_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default",
  "second_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default",
  "src_geo_region" varchar(128) COLLATE "pg_catalog"."default",
  "security_zone" varchar(128) COLLATE "pg_catalog"."default",
  "device_address" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "device_send_product_name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "send_host_address" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "machine_code" varchar(512) COLLATE "pg_catalog"."default" NOT NULL,
  "rule_type" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "focus_ip" text COLLATE "pg_catalog"."default",
  "attacker" text COLLATE "pg_catalog"."default",
  "victim" text COLLATE "pg_catalog"."default",
  "severity" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "cat_outcome" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "payload" text COLLATE "pg_catalog"."default",
  "more_field" text COLLATE "pg_catalog"."default",
  "time_part" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "kill_chain" varchar(255) COLLATE "pg_catalog"."default",
  "is_scenario" int4 DEFAULT 0
)
;
ALTER TABLE "t_risk_incidents_out_going" OWNER TO "dbapp";
COMMENT ON COLUMN "t_risk_incidents_out_going"."id" IS '唯一id';
COMMENT ON COLUMN "t_risk_incidents_out_going"."uniq_code" IS '唯一code，当前日期+数据源+风险事件名称+程序版本+关注ip';
COMMENT ON COLUMN "t_risk_incidents_out_going"."event_code" IS '事件编号，当前日期+数据源+风险事件名称+程序版本';
COMMENT ON COLUMN "t_risk_incidents_out_going"."security_incident_id" IS '关联安全事件id';
COMMENT ON COLUMN "t_risk_incidents_out_going"."name" IS '事件名称';
COMMENT ON COLUMN "t_risk_incidents_out_going"."template_id" IS '模板code';
COMMENT ON COLUMN "t_risk_incidents_out_going"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_risk_incidents_out_going"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_risk_incidents_out_going"."top_event_type_chinese" IS '一级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents_out_going"."second_event_type_chinese" IS '二级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents_out_going"."src_geo_region" IS '来源地区';
COMMENT ON COLUMN "t_risk_incidents_out_going"."security_zone" IS '安全域';
COMMENT ON COLUMN "t_risk_incidents_out_going"."device_address" IS 'XDR地址';
COMMENT ON COLUMN "t_risk_incidents_out_going"."device_send_product_name" IS 'XDR产品名称';
COMMENT ON COLUMN "t_risk_incidents_out_going"."send_host_address" IS '目标地址';
COMMENT ON COLUMN "t_risk_incidents_out_going"."machine_code" IS 'XDR机器码';
COMMENT ON COLUMN "t_risk_incidents_out_going"."rule_type" IS 'XDR的事件一二级类型需要映射成告警类型';
COMMENT ON COLUMN "t_risk_incidents_out_going"."focus_ip" IS '关注IP';
COMMENT ON COLUMN "t_risk_incidents_out_going"."attacker" IS '关注对象，根据关注对象类型进行填充数值';
COMMENT ON COLUMN "t_risk_incidents_out_going"."victim" IS '关注对象，根据关注对象类型进行填充数值';
COMMENT ON COLUMN "t_risk_incidents_out_going"."severity" IS '威胁等级,高-7，中-6，低-3';
COMMENT ON COLUMN "t_risk_incidents_out_going"."cat_outcome" IS '事件结果,尝试-Attempt，失败-FAIL，成功-OK';
COMMENT ON COLUMN "t_risk_incidents_out_going"."payload" IS '子事件描述';
COMMENT ON COLUMN "t_risk_incidents_out_going"."more_field" IS '告警信息其他需要外发的字段，json格式存放';
COMMENT ON COLUMN "t_risk_incidents_out_going"."time_part" IS '时间周期';
COMMENT ON COLUMN "t_risk_incidents_out_going"."kill_chain" IS '攻击链';
COMMENT ON COLUMN "t_risk_incidents_out_going"."is_scenario" IS '是否关联';
COMMENT ON TABLE "t_risk_incidents_out_going" IS '风险子事件外发表';

-- ----------------------------
-- Records of t_risk_incidents_out_going
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_risk_incidents_out_going_history
-- ----------------------------
DROP TABLE IF EXISTS "t_risk_incidents_out_going_history";
CREATE TABLE "t_risk_incidents_out_going_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_risk_incidents_out_going_history_id_seq'::regclass),
  "event_id" int8 NOT NULL,
  "uniq_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "event_code" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "security_incident_id" int8,
  "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "template_id" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "top_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default",
  "second_event_type_chinese" varchar(128) COLLATE "pg_catalog"."default",
  "src_geo_region" varchar(128) COLLATE "pg_catalog"."default",
  "security_zone" varchar(128) COLLATE "pg_catalog"."default",
  "device_address" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "device_send_product_name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "send_host_address" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "machine_code" varchar(512) COLLATE "pg_catalog"."default" NOT NULL,
  "rule_type" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "focus_ip" text COLLATE "pg_catalog"."default",
  "attacker" text COLLATE "pg_catalog"."default",
  "victim" text COLLATE "pg_catalog"."default",
  "severity" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "cat_outcome" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "payload" text COLLATE "pg_catalog"."default",
  "more_field" text COLLATE "pg_catalog"."default",
  "time_part" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_risk_incidents_out_going_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."id" IS '唯一id';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."event_id" IS '风险事件id';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."uniq_code" IS '唯一code，当前日期+数据源+风险事件名称+程序版本+关注ip';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."event_code" IS '事件编号，当前日期+数据源+风险事件名称+程序版本';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."security_incident_id" IS '关联安全事件id';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."name" IS '事件名称';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."template_id" IS '模板code';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."top_event_type_chinese" IS '一级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."second_event_type_chinese" IS '二级事件类型，同模板表中文';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."src_geo_region" IS '来源地区';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."security_zone" IS '安全域';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."device_address" IS 'XDR地址';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."device_send_product_name" IS 'XDR产品名称';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."send_host_address" IS '目标地址';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."machine_code" IS 'XDR机器码';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."rule_type" IS 'XDR的事件一二级类型需要映射成告警类型';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."focus_ip" IS '关注IP';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."attacker" IS '关注对象，根据关注对象类型进行填充数值';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."victim" IS '关注对象，根据关注对象类型进行填充数值';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."severity" IS '威胁等级,高-7，中-6，低-3';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."cat_outcome" IS '事件结果,尝试-Attempt，失败-FAIL，成功-OK';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."payload" IS '子事件描述';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."more_field" IS '告警信息其他需要外发的字段，json格式存放';
COMMENT ON COLUMN "t_risk_incidents_out_going_history"."time_part" IS '时间周期';
COMMENT ON TABLE "t_risk_incidents_out_going_history" IS '风险子事件外发历史表';

-- ----------------------------
-- Records of t_risk_incidents_out_going_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_risk_out_going_config
-- ----------------------------
DROP TABLE IF EXISTS "t_risk_out_going_config";
CREATE TABLE "t_risk_out_going_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_risk_out_going_config_id_seq'::regclass),
  "sub_category" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(50) COLLATE "pg_catalog"."default",
  "alarm_results" varchar(50) COLLATE "pg_catalog"."default",
  "enable" int4 NOT NULL DEFAULT 1,
  "mapping_config_path" text COLLATE "pg_catalog"."default",
  "last_send_time" timestamptz(6),
  "last_send_result" varchar(10) COLLATE "pg_catalog"."default",
  "cause_of_failure" text COLLATE "pg_catalog"."default",
  "is_del" int4 NOT NULL DEFAULT 0,
  "send_count" int8 DEFAULT '0'::bigint,
  "succeed_count" int8 DEFAULT '0'::bigint,
  "create_time" timestamptz(6),
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_risk_out_going_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_risk_out_going_config"."id" IS '主键自增id';
COMMENT ON COLUMN "t_risk_out_going_config"."sub_category" IS '风险事件类型（数组）';
COMMENT ON COLUMN "t_risk_out_going_config"."threat_severity" IS '威胁等级（数组）';
COMMENT ON COLUMN "t_risk_out_going_config"."alarm_results" IS '事件结果（数组）';
COMMENT ON COLUMN "t_risk_out_going_config"."enable" IS '是否开启（1是，0否）';
COMMENT ON COLUMN "t_risk_out_going_config"."mapping_config_path" IS '映射文件路径';
COMMENT ON COLUMN "t_risk_out_going_config"."last_send_time" IS '上次发送时间';
COMMENT ON COLUMN "t_risk_out_going_config"."last_send_result" IS '上次发送结果';
COMMENT ON COLUMN "t_risk_out_going_config"."cause_of_failure" IS '发送失败的原因';
COMMENT ON COLUMN "t_risk_out_going_config"."is_del" IS '是否已删除（1是，0否）';
COMMENT ON COLUMN "t_risk_out_going_config"."send_count" IS '发送总次数';
COMMENT ON COLUMN "t_risk_out_going_config"."succeed_count" IS '成功发送次数';
COMMENT ON COLUMN "t_risk_out_going_config"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_risk_out_going_config"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_risk_out_going_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_scan_history
-- ----------------------------
DROP TABLE IF EXISTS "t_scan_history";
CREATE TABLE "t_scan_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_scan_history_id_seq'::regclass),
  "node_ip" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "node_id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "node_os" "t_scan_history_node_os" NOT NULL,
  "device_id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "device_ip" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "device_type" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "last_scan_time" timestamptz(6) NOT NULL,
  "scan_times" int4 NOT NULL DEFAULT 1,
  "virus_status" "t_scan_history_virus_status" NOT NULL DEFAULT '无下发记录'::xdr22.t_scan_history_virus_status,
  "site_status" "t_scan_history_site_status" NOT NULL DEFAULT '无下发记录'::xdr22.t_scan_history_site_status,
  "vulnerability_status" "t_scan_history_vulnerability_status" NOT NULL DEFAULT '无下发记录'::xdr22.t_scan_history_vulnerability_status,
  "virus_result_num" int4 NOT NULL DEFAULT 0,
  "site_result_num" int4 NOT NULL DEFAULT 0,
  "vulnerability_result_num" int4 NOT NULL DEFAULT 0,
  "total_result_num" int4 DEFAULT 0
)
;
ALTER TABLE "t_scan_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scan_history"."id" IS '主键ID';
COMMENT ON COLUMN "t_scan_history"."node_ip" IS '终端IP，唯一键约束';
COMMENT ON COLUMN "t_scan_history"."node_id" IS '终端ID';
COMMENT ON COLUMN "t_scan_history"."node_os" IS '终端操作系统类型';
COMMENT ON COLUMN "t_scan_history"."device_id" IS '联动设备ID';
COMMENT ON COLUMN "t_scan_history"."device_ip" IS '联动设备IP';
COMMENT ON COLUMN "t_scan_history"."device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_scan_history"."last_scan_time" IS '最近一次扫描时间';
COMMENT ON COLUMN "t_scan_history"."scan_times" IS '下发扫描次数';
COMMENT ON COLUMN "t_scan_history"."virus_status" IS '最近一次病毒木马任务扫描状态';
COMMENT ON COLUMN "t_scan_history"."site_status" IS '最近一次网站后门任务扫描状态';
COMMENT ON COLUMN "t_scan_history"."vulnerability_status" IS '最近一次漏洞补丁任务扫描状态';
COMMENT ON COLUMN "t_scan_history"."virus_result_num" IS '最近一次病毒木马扫描完成结果数';
COMMENT ON COLUMN "t_scan_history"."site_result_num" IS '最近一次网站后门扫描完成结果数';
COMMENT ON COLUMN "t_scan_history"."vulnerability_result_num" IS '最近一次漏洞补丁扫描完成结果数';
COMMENT ON COLUMN "t_scan_history"."total_result_num" IS '三种扫描任务最近一次扫描完成结果数总和';
COMMENT ON TABLE "t_scan_history" IS '扫描历史记录表';

-- ----------------------------
-- Records of t_scan_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_scan_history_detail
-- ----------------------------
DROP TABLE IF EXISTS "t_scan_history_detail";
CREATE TABLE "t_scan_history_detail" (
  "id" int8 NOT NULL DEFAULT nextval('t_scan_history_detail_id_seq'::regclass),
  "strategy_id" numeric NOT NULL,
  "node_ip" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "device_ip" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "scan_time" timestamptz(6) NOT NULL,
  "scan_scope" "t_scan_history_detail_scan_scope" NOT NULL DEFAULT 'full'::xdr22.t_scan_history_detail_scan_scope,
  "scan_path" text COLLATE "pg_catalog"."default",
  "scan_type" "t_scan_history_detail_scan_type" NOT NULL,
  "scan_object_num" int4,
  "scan_result_num" int4,
  "scan_total_num" int4,
  "status" "t_scan_history_detail_status" NOT NULL,
  "start_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "end_time" timestamptz(6),
  "source" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'manual'::character varying,
  "task_id" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_scan_history_detail" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scan_history_detail"."id" IS '主键ID';
COMMENT ON COLUMN "t_scan_history_detail"."strategy_id" IS '联动策略ID（t_linked_strategy）';
COMMENT ON COLUMN "t_scan_history_detail"."node_ip" IS '终端IP';
COMMENT ON COLUMN "t_scan_history_detail"."device_ip" IS '联动设备IP';
COMMENT ON COLUMN "t_scan_history_detail"."scan_time" IS '扫描下发时间';
COMMENT ON COLUMN "t_scan_history_detail"."scan_scope" IS '扫描范围（枚举值）：full[全盘扫描]、custom[自定义扫描]';
COMMENT ON COLUMN "t_scan_history_detail"."scan_path" IS '自定义扫描路径';
COMMENT ON COLUMN "t_scan_history_detail"."scan_type" IS '扫描类型（枚举值）：virus[病毒木马]、site[网站后门]、vulnerability[漏洞补丁]';
COMMENT ON COLUMN "t_scan_history_detail"."scan_object_num" IS '扫描对象数';
COMMENT ON COLUMN "t_scan_history_detail"."scan_result_num" IS '扫描结果数';
COMMENT ON COLUMN "t_scan_history_detail"."scan_total_num" IS '扫描对象总数';
COMMENT ON COLUMN "t_scan_history_detail"."status" IS '扫描任务状态';
COMMENT ON COLUMN "t_scan_history_detail"."start_time" IS '扫描开始时间';
COMMENT ON COLUMN "t_scan_history_detail"."end_time" IS '扫描结束时间';
COMMENT ON COLUMN "t_scan_history_detail"."source" IS '策略来源';
COMMENT ON COLUMN "t_scan_history_detail"."task_id" IS 'edr的任务id';
COMMENT ON TABLE "t_scan_history_detail" IS '扫描历史记录详情表';

-- ----------------------------
-- Records of t_scan_history_detail
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_scan_job
-- ----------------------------
DROP TABLE IF EXISTS "t_scan_job";
CREATE TABLE "t_scan_job" (
  "id" int8 NOT NULL DEFAULT nextval('t_scan_job_id_seq'::regclass),
  "strategy_id" int8 NOT NULL,
  "device_id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "device_ip" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "device_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "scan_scope" "t_scan_job_scan_scope" NOT NULL DEFAULT 'full'::xdr22.t_scan_job_scan_scope,
  "scan_path" text COLLATE "pg_catalog"."default",
  "scan_cycle" int4 NOT NULL DEFAULT 0,
  "scan_type" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "node_list" text COLLATE "pg_catalog"."default" NOT NULL,
  "next_scan_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "action" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'scan'::character varying,
  "source" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'manual'::character varying,
  "hashes" text COLLATE "pg_catalog"."default",
  "process_info_list" text COLLATE "pg_catalog"."default",
  "error_count" int4 NOT NULL DEFAULT 0,
  "error_message" varchar(1000) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_scan_job" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scan_job"."id" IS '主键ID';
COMMENT ON COLUMN "t_scan_job"."strategy_id" IS '联动策略ID';
COMMENT ON COLUMN "t_scan_job"."device_id" IS '联动设备ID';
COMMENT ON COLUMN "t_scan_job"."device_ip" IS '联动设备IP';
COMMENT ON COLUMN "t_scan_job"."device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_scan_job"."scan_scope" IS '扫描范围（枚举值）：full[全盘扫描]、custom[自定义扫描]';
COMMENT ON COLUMN "t_scan_job"."scan_path" IS '自定义扫描路径';
COMMENT ON COLUMN "t_scan_job"."scan_cycle" IS '扫描周期（默认为0，表示仅扫描一次）';
COMMENT ON COLUMN "t_scan_job"."scan_type" IS '扫描类型列表';
COMMENT ON COLUMN "t_scan_job"."node_list" IS '终端信息列表';
COMMENT ON COLUMN "t_scan_job"."next_scan_time" IS '下次扫描时间';
COMMENT ON COLUMN "t_scan_job"."source" IS '策略来源';
COMMENT ON COLUMN "t_scan_job"."hashes" IS '病毒文件的hashes';
COMMENT ON COLUMN "t_scan_job"."process_info_list" IS '进程相关信息';
COMMENT ON COLUMN "t_scan_job"."error_count" IS '错误次数，默认10次，超过就不再执行';
COMMENT ON COLUMN "t_scan_job"."error_message" IS '错误信息';
COMMENT ON TABLE "t_scan_job" IS '扫描任务表';

-- ----------------------------
-- Records of t_scan_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_scene_login_baseline
-- ----------------------------
DROP TABLE IF EXISTS "t_scene_login_baseline";
CREATE TABLE "t_scene_login_baseline" (
  "dest_address" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "src_user_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "last_login_time" timestamptz(6),
  "city_counts" text COLLATE "pg_catalog"."default",
  "city_array" varchar(500) COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6),
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_scene_login_baseline" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scene_login_baseline"."dest_address" IS '目的ip';
COMMENT ON COLUMN "t_scene_login_baseline"."src_user_name" IS '用户名';
COMMENT ON COLUMN "t_scene_login_baseline"."last_login_time" IS '最后登录时间';
COMMENT ON COLUMN "t_scene_login_baseline"."city_counts" IS '此ip和用户名登录城市和次数map。json数据';
COMMENT ON COLUMN "t_scene_login_baseline"."city_array" IS '排名前三的城市数组';

-- ----------------------------
-- Records of t_scene_login_baseline
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_scene_rule_config
-- ----------------------------
DROP TABLE IF EXISTS "t_scene_rule_config";
CREATE TABLE "t_scene_rule_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_scene_rule_config_id_seq'::regclass),
  "rule_id" varchar(255) COLLATE "pg_catalog"."default",
  "config_param" text COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_scene_rule_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scene_rule_config"."id" IS '唯一标识，自增';
COMMENT ON COLUMN "t_scene_rule_config"."rule_id" IS '规则id';
COMMENT ON COLUMN "t_scene_rule_config"."config_param" IS '模型配置json';
COMMENT ON COLUMN "t_scene_rule_config"."create_time" IS '创建时间';

-- ----------------------------
-- Records of t_scene_rule_config
-- ----------------------------
BEGIN;
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (1, 'privilegedAccount', '{"@class":"com.alibaba.fastjson.JSONObject","srcUserName":"admin","appProtocol":["java.util.ArrayList",["http"]]}', '2021-12-06 15:25:13+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (2, 'privilegedAccount', '{"@class":"com.alibaba.fastjson.JSONObject","srcUserName":"administrator","appProtocol":["java.util.ArrayList",["rdp"]]}', '2021-12-06 15:25:27+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (3, 'privilegedAccount', '{"@class":"com.alibaba.fastjson.JSONObject","srcUserName":"root","appProtocol":["java.util.ArrayList",["ssh"]]}', '2021-12-06 15:25:35+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (4, 'suspiciousMail:subject', '{"@class":"com.alibaba.fastjson.JSONObject","subject":"测试链接"}', '2021-12-06 17:14:39+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (5, 'suspiciousMail:subject', '{"@class":"com.alibaba.fastjson.JSONObject","subject":"重置密码"}', '2021-12-06 17:14:54+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (6, 'suspiciousMail:subject', '{"@class":"com.alibaba.fastjson.JSONObject","subject":"登录"}', '2021-12-06 17:14:59+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (7, 'suspiciousMail:subject', '{"@class":"com.alibaba.fastjson.JSONObject","subject":"员工信息"}', '2021-12-06 17:15:05+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (8, 'suspiciousMail:subject', '{"@class":"com.alibaba.fastjson.JSONObject","subject":"密码修改"}', '2021-12-06 17:15:10+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (9, 'suspiciousMail:suffix', '{"@class":"com.alibaba.fastjson.JSONObject","attachmentSuffix":"exe"}', '2021-12-06 17:16:32+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (10, 'suspiciousMail:suffix', '{"@class":"com.alibaba.fastjson.JSONObject","attachmentSuffix":"bin"}', '2021-12-06 17:16:40+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (11, 'suspiciousMail:suffix', '{"@class":"com.alibaba.fastjson.JSONObject","attachmentSuffix":"vbs"}', '2021-12-06 17:16:45+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (12, 'suspiciousMail:suffix', '{"@class":"com.alibaba.fastjson.JSONObject","attachmentSuffix":"cmd"}', '2021-12-06 17:16:51+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (13, 'suspiciousMail:suffix', '{"@class":"com.alibaba.fastjson.JSONObject","attachmentSuffix":"com"}', '2021-12-06 17:16:54+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (14, 'suspiciousWebScan', '{"@class":"com.alibaba.fastjson.JSONObject","urlCount":50}', '2026-01-15 09:31:18+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (15, 'suspiciousPosternAccess', '{"@class":"com.alibaba.fastjson.JSONObject","abnormalUrlCount":10,"normalUrlCount":200,"normalUrlPercent":85}', '2026-01-15 09:31:18+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (16, 'externalSendingMail', '{"@class":"com.alibaba.fastjson.JSONObject","sendEmailCount":100}', '2026-01-15 09:31:18+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (17, 'bruteForce:slow', '{"@class":"com.alibaba.fastjson.JSONObject","window":5,"loginCount":20,"repeatCount":10}', '2026-01-15 09:31:18+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (18, 'bruteForce:oneToMany', '{"@class":"com.alibaba.fastjson.JSONObject","window":5,"loginCount":50}', '2026-01-15 09:31:18+08');
INSERT INTO "t_scene_rule_config" ("id", "rule_id", "config_param", "create_time") VALUES (19, 'abnormalLogin', '{"@class":"com.alibaba.fastjson.JSONObject","startTime":"2330","endTime":"0530"}', '2026-01-15 09:31:18+08');
COMMIT;

-- ----------------------------
-- Table structure for t_scene_rule_info
-- ----------------------------
DROP TABLE IF EXISTS "t_scene_rule_info";
CREATE TABLE "t_scene_rule_info" (
  "id" int8 NOT NULL DEFAULT nextval('t_scene_rule_info_id_seq'::regclass),
  "rule_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "data_source" varchar(100) COLLATE "pg_catalog"."default",
  "scene_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "rule_name" varchar(100) COLLATE "pg_catalog"."default",
  "description" varchar(1000) COLLATE "pg_catalog"."default",
  "suggestion" varchar(1000) COLLATE "pg_catalog"."default",
  "group_by" text COLLATE "pg_catalog"."default",
  "list_param" text COLLATE "pg_catalog"."default",
  "chart_param" text COLLATE "pg_catalog"."default",
  "detail_condition" varchar(1000) COLLATE "pg_catalog"."default",
  "is_open" bool NOT NULL DEFAULT true,
  "default_switch" bool DEFAULT false,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_scene_rule_info" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scene_rule_info"."rule_id" IS '规则id，唯一';
COMMENT ON COLUMN "t_scene_rule_info"."data_source" IS '数据源，原始告警、原始日志';
COMMENT ON COLUMN "t_scene_rule_info"."scene_name" IS '场景名称（与菜单挂钩）';
COMMENT ON COLUMN "t_scene_rule_info"."rule_name" IS '规则中文名';
COMMENT ON COLUMN "t_scene_rule_info"."description" IS '描述及危害';
COMMENT ON COLUMN "t_scene_rule_info"."suggestion" IS '建议';
COMMENT ON COLUMN "t_scene_rule_info"."group_by" IS '聚合字段json配置';
COMMENT ON COLUMN "t_scene_rule_info"."list_param" IS '列表json配置';
COMMENT ON COLUMN "t_scene_rule_info"."chart_param" IS '图表json配置';
COMMENT ON COLUMN "t_scene_rule_info"."detail_condition" IS '列表详情搜索条件';
COMMENT ON COLUMN "t_scene_rule_info"."is_open" IS '是否开启';
COMMENT ON COLUMN "t_scene_rule_info"."default_switch" IS '默认开关状态';

-- ----------------------------
-- Records of t_scene_rule_info
-- ----------------------------
BEGIN;
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (1, 'bruteForce', 'security_alarms', '登陆分析', '暴力破解', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:19:06+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (2, 'weakPassword', 'security_alarms', '登陆分析', '弱口令', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:20:04+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (3, 'clearTextCredit', 'security_alarms', '登陆分析', '明文传输', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:20:26+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (4, 'privilegedAccount', 'security_logs', '登陆分析', '特权账号登陆', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:20:44+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (5, 'externalAccess', 'security_logs', '访问关系', '外部访问', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:21:00+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (6, 'crossAccess', 'security_logs', '访问关系', '横向访问', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:21:14+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (7, 'internalHostConnection', 'security_logs', '访问关系', '内部主机外联行为', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:21:31+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (8, 'suspiciousWebScan', 'security_logs', 'Web服务分析', '可疑Web扫描', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:22:24+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (9, 'posternUsage', 'security_alarms', 'Web服务分析', '后门利用分析', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:23:00+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (10, 'suspiciousPosternAccess', 'security_logs', 'Web服务分析', '可疑后门访问', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:23:24+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (11, 'miningHostAnalysis', 'security_alarms', '挖矿分析', '挖矿主机分析', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:24:35+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (12, 'ransomwareAnalysis', 'security_alarms', '勒索分析', '勒索病毒分析', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:24:57+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (13, 'DNSTunnel', 'security_alarms', '隐蔽隧道', 'DNS隧道', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:25:16+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (14, 'HTTPTunnel', 'security_alarms', '隐蔽隧道', 'HTTP隧道', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:25:32+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (15, 'ICMPTunnel', 'security_alarms', '隐蔽隧道', 'ICMP隧道', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:26:13+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (16, 'virusMail', 'security_alarms', '邮件分析', '病毒邮件威胁', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:26:30+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (17, 'suspiciousMail', 'security_logs', '邮件分析', '可疑邮件威胁', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:26:45+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (18, 'externalSendingMail', 'security_logs', '邮件分析', '外发邮件威胁', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:27:02+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (19, 'dataSecurity', 'security_alarms', '数据安全', '数据安全', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:27:17+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (20, 'DGADomainCheck', 'security_alarms', 'DGA域名检测', 'DGA域名检测', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2021-11-26 15:27:29+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (21, 'phishingMail', 'security_logs', '邮件分析', '钓鱼邮件威胁', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2022-04-19 18:58:47+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (22, 'decryption', 'security_alarms', '加密攻击检测', '已解密', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2022-04-19 19:00:47+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (23, 'encryption', 'security_alarms', '加密攻击检测', '未解密', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2022-04-19 19:01:17+08');
INSERT INTO "t_scene_rule_info" ("id", "rule_id", "data_source", "scene_name", "rule_name", "description", "suggestion", "group_by", "list_param", "chart_param", "detail_condition", "is_open", "default_switch", "create_time") VALUES (24, 'abnormalLogin', 'security_log', '登陆分析', '异常登录', NULL, NULL, NULL, NULL, NULL, NULL, 'f', 'f', '2023-01-05 13:30:00+08');
COMMIT;

-- ----------------------------
-- Table structure for t_scene_web_access_temp
-- ----------------------------
DROP TABLE IF EXISTS "t_scene_web_access_temp";
CREATE TABLE "t_scene_web_access_temp" (
  "id" int8 NOT NULL,
  "src_address" varchar(255) COLLATE "pg_catalog"."default",
  "dest_address" varchar(255) COLLATE "pg_catalog"."default",
  "victim" text COLLATE "pg_catalog"."default",
  "attacker" text COLLATE "pg_catalog"."default",
  "request_url" text COLLATE "pg_catalog"."default",
  "dest_host_name" text COLLATE "pg_catalog"."default",
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "oldest_time" timestamptz(6),
  "latest_time" timestamptz(6),
  "event_count" int8,
  "create_time" timestamptz(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_scene_web_access_temp" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scene_web_access_temp"."src_address" IS '源IP';
COMMENT ON COLUMN "t_scene_web_access_temp"."dest_address" IS '目的IP';
COMMENT ON COLUMN "t_scene_web_access_temp"."victim" IS '受害者';
COMMENT ON COLUMN "t_scene_web_access_temp"."attacker" IS '攻击者';
COMMENT ON COLUMN "t_scene_web_access_temp"."request_url" IS 'url';
COMMENT ON COLUMN "t_scene_web_access_temp"."dest_host_name" IS '目的主机名';
COMMENT ON COLUMN "t_scene_web_access_temp"."oldest_time" IS '首次发生时间';
COMMENT ON COLUMN "t_scene_web_access_temp"."latest_time" IS '最近发生时间';
COMMENT ON TABLE "t_scene_web_access_temp" IS '威胁分析-可疑后门访问临时数据表';

-- ----------------------------
-- Records of t_scene_web_access_temp
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_security_alarm_handle
-- ----------------------------
DROP TABLE IF EXISTS "t_security_alarm_handle";
CREATE TABLE "t_security_alarm_handle" (
  "id" int8 NOT NULL DEFAULT nextval('t_security_alarm_handle_id_seq'::regclass),
  "agg_condition" varchar(50) COLLATE "pg_catalog"."default",
  "window_id" varchar(50) COLLATE "pg_catalog"."default",
  "execute_time" timestamptz(6),
  "handle_status" varchar(50) COLLATE "pg_catalog"."default",
  "result" bool DEFAULT false
)
;
ALTER TABLE "t_security_alarm_handle" OWNER TO "dbapp";
COMMENT ON COLUMN "t_security_alarm_handle"."execute_time" IS '可执行时间';
COMMENT ON COLUMN "t_security_alarm_handle"."handle_status" IS '处置状态';
COMMENT ON COLUMN "t_security_alarm_handle"."result" IS '处置结果：0未处置，1已处置';

-- ----------------------------
-- Records of t_security_alarm_handle
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_security_alarm_temp
-- ----------------------------
DROP TABLE IF EXISTS "t_security_alarm_temp";
CREATE TABLE "t_security_alarm_temp" (
  "event_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "src_address" varchar(100) COLLATE "pg_catalog"."default",
  "dest_address" varchar(100) COLLATE "pg_catalog"."default",
  "attacker" varchar(100) COLLATE "pg_catalog"."default",
  "victim" varchar(100) COLLATE "pg_catalog"."default",
  "sub_category" varchar(100) COLLATE "pg_catalog"."default",
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "alarm_results" varchar(100) COLLATE "pg_catalog"."default",
  "kill_chain" varchar(100) COLLATE "pg_catalog"."default",
  "tag_search" text COLLATE "pg_catalog"."default",
  "time_part" varchar(10) COLLATE "pg_catalog"."default",
  "threat_severity" varchar(10) COLLATE "pg_catalog"."default",
  "window_id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "agg_condition" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "family_id" varchar(255) COLLATE "pg_catalog"."default",
  "organization_id" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_security_alarm_temp" OWNER TO "dbapp";
COMMENT ON COLUMN "t_security_alarm_temp"."src_address" IS '来源IP';
COMMENT ON COLUMN "t_security_alarm_temp"."dest_address" IS '目的IP';
COMMENT ON COLUMN "t_security_alarm_temp"."attacker" IS '攻击者';
COMMENT ON COLUMN "t_security_alarm_temp"."victim" IS '受害者';
COMMENT ON COLUMN "t_security_alarm_temp"."sub_category" IS '告警子类型';
COMMENT ON COLUMN "t_security_alarm_temp"."alarm_results" IS '攻击结果';
COMMENT ON COLUMN "t_security_alarm_temp"."kill_chain" IS '攻击链';
COMMENT ON COLUMN "t_security_alarm_temp"."time_part" IS '时间分区，按天';
COMMENT ON COLUMN "t_security_alarm_temp"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_security_alarm_temp"."family_id" IS '家族ID';
COMMENT ON COLUMN "t_security_alarm_temp"."organization_id" IS '组织ID';
COMMENT ON TABLE "t_security_alarm_temp" IS '缓存最近一小时范围内的原始告警';

-- ----------------------------
-- Records of t_security_alarm_temp
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_security_incidents
-- ----------------------------
DROP TABLE IF EXISTS "t_security_incidents";
CREATE TABLE "t_security_incidents" (
  "id" int8 NOT NULL DEFAULT nextval('t_security_incidents_id_seq'::regclass),
  "template_id" int8,
  "template_code" varchar(50) COLLATE "pg_catalog"."default",
  "attack_conclusion" text COLLATE "pg_catalog"."default",
  "threat_severity" varchar(10) COLLATE "pg_catalog"."default",
  "start_time" timestamptz(6),
  "end_time" timestamptz(6),
  "create_time" timestamptz(6) DEFAULT CURRENT_TIMESTAMP,
  "sub_category" varchar(100) COLLATE "pg_catalog"."default",
  "category" varchar(100) COLLATE "pg_catalog"."default",
  "event_name" varchar(255) COLLATE "pg_catalog"."default",
  "attacker" text COLLATE "pg_catalog"."default",
  "victim" text COLLATE "pg_catalog"."default",
  "counts" int8,
  "alarm_status" varchar(20) COLLATE "pg_catalog"."default",
  "alarm_results" varchar(20) COLLATE "pg_catalog"."default",
  "kill_chain" text COLLATE "pg_catalog"."default",
  "succeed_count" int8,
  "fail_count" int8,
  "event_ids" text COLLATE "pg_catalog"."default",
  "mirror_sub_category" varchar(100) COLLATE "pg_catalog"."default",
  "family_id" text COLLATE "pg_catalog"."default",
  "organization_id" text COLLATE "pg_catalog"."default",
  "focus" varchar(10) COLLATE "pg_catalog"."default",
  "event_code" varchar(200) COLLATE "pg_catalog"."default",
  "focus_ip" text COLLATE "pg_catalog"."default",
  "incident_cond" varchar(20) COLLATE "pg_catalog"."default",
  "tag_search" text COLLATE "pg_catalog"."default",
  "is_scenario" int4,
  "update_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_ip_information" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_security_incidents" OWNER TO "dbapp";
COMMENT ON COLUMN "t_security_incidents"."id" IS '唯一id';
COMMENT ON COLUMN "t_security_incidents"."template_id" IS '模板id';
COMMENT ON COLUMN "t_security_incidents"."template_code" IS '模板code';
COMMENT ON COLUMN "t_security_incidents"."attack_conclusion" IS '攻击总结';
COMMENT ON COLUMN "t_security_incidents"."threat_severity" IS '威胁等级';
COMMENT ON COLUMN "t_security_incidents"."start_time" IS '首次发生时间';
COMMENT ON COLUMN "t_security_incidents"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_security_incidents"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_security_incidents"."sub_category" IS '事件子类型';
COMMENT ON COLUMN "t_security_incidents"."category" IS '事件类型';
COMMENT ON COLUMN "t_security_incidents"."event_name" IS '事件名称';
COMMENT ON COLUMN "t_security_incidents"."attacker" IS '攻击者ip';
COMMENT ON COLUMN "t_security_incidents"."victim" IS '受害者ip';
COMMENT ON COLUMN "t_security_incidents"."counts" IS '攻击次数';
COMMENT ON COLUMN "t_security_incidents"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_security_incidents"."alarm_results" IS '攻击结果';
COMMENT ON COLUMN "t_security_incidents"."kill_chain" IS '攻击链';
COMMENT ON COLUMN "t_security_incidents"."succeed_count" IS '攻击成功次数';
COMMENT ON COLUMN "t_security_incidents"."fail_count" IS '攻击失败次数';
COMMENT ON COLUMN "t_security_incidents"."event_ids" IS '聚合告警id';
COMMENT ON COLUMN "t_security_incidents"."mirror_sub_category" IS 'mirror告警子类型';
COMMENT ON COLUMN "t_security_incidents"."family_id" IS '家族id';
COMMENT ON COLUMN "t_security_incidents"."organization_id" IS '组织id';
COMMENT ON COLUMN "t_security_incidents"."focus" IS '关注对象';
COMMENT ON COLUMN "t_security_incidents"."event_code" IS '事件唯一键值';
COMMENT ON COLUMN "t_security_incidents"."focus_ip" IS '关注IP';
COMMENT ON COLUMN "t_security_incidents"."incident_cond" IS '线头事件条件';
COMMENT ON COLUMN "t_security_incidents"."tag_search" IS '标签（数组）';
COMMENT ON COLUMN "t_security_incidents"."is_scenario" IS '是否符合追溯条件，符合1，不符合null';
COMMENT ON COLUMN "t_security_incidents"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_security_incidents"."update_ip_information" IS '告警子事件更新ip的信息';

-- ----------------------------
-- Records of t_security_incidents
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_security_types
-- ----------------------------
DROP TABLE IF EXISTS "t_security_types";
CREATE TABLE "t_security_types" (
  "id" int8 NOT NULL DEFAULT nextval('t_security_types_id_seq'::regclass),
  "sub_category" varchar(50) COLLATE "pg_catalog"."default",
  "category" varchar(50) COLLATE "pg_catalog"."default",
  "mirror_sub_category" varchar(50) COLLATE "pg_catalog"."default",
  "mirror_category" varchar(50) COLLATE "pg_catalog"."default",
  "sub_category_name" varchar(50) COLLATE "pg_catalog"."default",
  "category_name" varchar(50) COLLATE "pg_catalog"."default",
  "is_enable" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "t_security_types" OWNER TO "dbapp";
COMMENT ON COLUMN "t_security_types"."id" IS '唯一id';
COMMENT ON COLUMN "t_security_types"."sub_category" IS '安全事件子类型';
COMMENT ON COLUMN "t_security_types"."category" IS '安全事件类型';
COMMENT ON COLUMN "t_security_types"."mirror_sub_category" IS 'mirror安全事件子类型';
COMMENT ON COLUMN "t_security_types"."mirror_category" IS 'mirror安全事件类型';
COMMENT ON COLUMN "t_security_types"."sub_category_name" IS '安全事件子类型中文';
COMMENT ON COLUMN "t_security_types"."category_name" IS '安全事件类型中文';
COMMENT ON COLUMN "t_security_types"."is_enable" IS '是否生效';

-- ----------------------------
-- Records of t_security_types
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_strategy_device_rel
-- ----------------------------
DROP TABLE IF EXISTS "t_strategy_device_rel";
CREATE TABLE "t_strategy_device_rel" (
  "id" int8 NOT NULL DEFAULT nextval('t_strategy_device_rel_id_seq'::regclass),
  "strategy_id" int8 NOT NULL,
  "device_id" varchar(50) COLLATE "pg_catalog"."default",
  "link_device_ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "link_device_type" varchar(16) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "area" varchar(50) COLLATE "pg_catalog"."default",
  "area_data" text COLLATE "pg_catalog"."default",
  "agents" text COLLATE "pg_catalog"."default",
  "action" varchar(50) COLLATE "pg_catalog"."default",
  "action_config" text COLLATE "pg_catalog"."default",
  "app_id" varchar(100) COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_strategy_device_rel" OWNER TO "dbapp";
COMMENT ON COLUMN "t_strategy_device_rel"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_strategy_device_rel"."device_id" IS '设备编号';
COMMENT ON COLUMN "t_strategy_device_rel"."link_device_ip" IS '联动设备ip';
COMMENT ON COLUMN "t_strategy_device_rel"."link_device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_strategy_device_rel"."area" IS '防护范围';
COMMENT ON COLUMN "t_strategy_device_rel"."area_data" IS '防护范围配置';
COMMENT ON COLUMN "t_strategy_device_rel"."agents" IS '终端信息列表Json字符串';
COMMENT ON COLUMN "t_strategy_device_rel"."action" IS '动作';
COMMENT ON COLUMN "t_strategy_device_rel"."action_config" IS '配置策略';
COMMENT ON COLUMN "t_strategy_device_rel"."app_id" IS '设备app类型';
COMMENT ON COLUMN "t_strategy_device_rel"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_strategy_device_rel"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_strategy_device_rel
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_tag_search_list
-- ----------------------------
DROP TABLE IF EXISTS "t_tag_search_list";
CREATE TABLE "t_tag_search_list" (
  "id" int8 NOT NULL DEFAULT nextval('t_tag_search_list_id_seq'::regclass),
  "tag_search" varchar(255) COLLATE "pg_catalog"."default",
  "name" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_tag_search_list" OWNER TO "dbapp";
COMMENT ON COLUMN "t_tag_search_list"."id" IS '主键id';
COMMENT ON COLUMN "t_tag_search_list"."tag_search" IS '标记名称';
COMMENT ON COLUMN "t_tag_search_list"."name" IS '中文名';
COMMENT ON COLUMN "t_tag_search_list"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_tag_search_list
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_virus_kill_history
-- ----------------------------
DROP TABLE IF EXISTS "t_virus_kill_history";
CREATE TABLE "t_virus_kill_history" (
  "id" int8 NOT NULL DEFAULT nextval('t_virus_kill_history_id_seq'::regclass),
  "strategy_id" int8 NOT NULL,
  "strategy_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "node_ip" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "node_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "os_str" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "device_ip" varchar(16) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "device_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "device_type" varchar(255) COLLATE "pg_catalog"."default",
  "action" "t_virus_kill_history_action" NOT NULL DEFAULT '病毒查杀'::xdr22.t_virus_kill_history_action,
  "hashes" text COLLATE "pg_catalog"."default",
  "last_occur_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "source" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'manual'::character varying
)
;
ALTER TABLE "t_virus_kill_history" OWNER TO "dbapp";
COMMENT ON COLUMN "t_virus_kill_history"."id" IS '主键ID';
COMMENT ON COLUMN "t_virus_kill_history"."strategy_id" IS '策略ID';
COMMENT ON COLUMN "t_virus_kill_history"."strategy_name" IS '策略名称';
COMMENT ON COLUMN "t_virus_kill_history"."node_ip" IS '终端操作系统IP';
COMMENT ON COLUMN "t_virus_kill_history"."node_id" IS '联动设备ID';
COMMENT ON COLUMN "t_virus_kill_history"."os_str" IS '终端操作系统类型';
COMMENT ON COLUMN "t_virus_kill_history"."device_ip" IS '联动设备IP';
COMMENT ON COLUMN "t_virus_kill_history"."device_id" IS '联动设备id';
COMMENT ON COLUMN "t_virus_kill_history"."device_type" IS '联动设备类型';
COMMENT ON COLUMN "t_virus_kill_history"."action" IS '下发的主机动作';
COMMENT ON COLUMN "t_virus_kill_history"."hashes" IS '下发的hashes,不匹配的时候不允许为空';
COMMENT ON COLUMN "t_virus_kill_history"."last_occur_time" IS '最后一次时间';
COMMENT ON COLUMN "t_virus_kill_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_virus_kill_history"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_virus_kill_history"."source" IS '策略来源';
COMMENT ON TABLE "t_virus_kill_history" IS '病毒查杀下发记录表';

-- ----------------------------
-- Records of t_virus_kill_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_vul_analysis_sub
-- ----------------------------
DROP TABLE IF EXISTS "t_vul_analysis_sub";
CREATE TABLE "t_vul_analysis_sub" (
  "id" int8 NOT NULL DEFAULT nextval('t_vul_analysis_sub_id_seq'::regclass),
  "end_time" timestamptz(6),
  "start_time" timestamptz(6),
  "alarm_result" int4,
  "alarm_status" int4,
  "app_protocol" varchar(30) COLLATE "pg_catalog"."default",
  "source" int8,
  "chart_id" int8,
  "asset_ip" varchar(30) COLLATE "pg_catalog"."default",
  "asset_tags" text COLLATE "pg_catalog"."default",
  "asset_name" varchar(255) COLLATE "pg_catalog"."default",
  "dest_security_zone" text COLLATE "pg_catalog"."default",
  "asset_type" varchar(30) COLLATE "pg_catalog"."default",
  "clear_text" varchar(255) COLLATE "pg_catalog"."default",
  "request_url" varchar(255) COLLATE "pg_catalog"."default",
  "cve" varchar(100) COLLATE "pg_catalog"."default",
  "severity_level" varchar(30) COLLATE "pg_catalog"."default",
  "vulnerability_name" varchar(100) COLLATE "pg_catalog"."default",
  "class_type" varchar(100) COLLATE "pg_catalog"."default",
  "src_user_name" varchar(255) COLLATE "pg_catalog"."default",
  "passwd" varchar(255) COLLATE "pg_catalog"."default",
  "high" int8,
  "medium" int8,
  "low" int8,
  "agg_count" int8,
  "event_code" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_vul_analysis_sub" OWNER TO "dbapp";
COMMENT ON COLUMN "t_vul_analysis_sub"."id" IS '主键id';
COMMENT ON COLUMN "t_vul_analysis_sub"."end_time" IS '最近发生时间';
COMMENT ON COLUMN "t_vul_analysis_sub"."start_time" IS '最先发生时间';
COMMENT ON COLUMN "t_vul_analysis_sub"."alarm_result" IS '告警结果';
COMMENT ON COLUMN "t_vul_analysis_sub"."alarm_status" IS '处置状态';
COMMENT ON COLUMN "t_vul_analysis_sub"."app_protocol" IS '传输协议';
COMMENT ON COLUMN "t_vul_analysis_sub"."source" IS '资产来源';
COMMENT ON COLUMN "t_vul_analysis_sub"."chart_id" IS '模板id';
COMMENT ON COLUMN "t_vul_analysis_sub"."asset_ip" IS '资产ip';
COMMENT ON COLUMN "t_vul_analysis_sub"."asset_tags" IS '资产标签';
COMMENT ON COLUMN "t_vul_analysis_sub"."asset_name" IS '资产名称';
COMMENT ON COLUMN "t_vul_analysis_sub"."dest_security_zone" IS '安全域';
COMMENT ON COLUMN "t_vul_analysis_sub"."asset_type" IS '资产类型';
COMMENT ON COLUMN "t_vul_analysis_sub"."clear_text" IS '明文传输内容';
COMMENT ON COLUMN "t_vul_analysis_sub"."request_url" IS '请求地址';
COMMENT ON COLUMN "t_vul_analysis_sub"."cve" IS 'cve编号';
COMMENT ON COLUMN "t_vul_analysis_sub"."severity_level" IS '漏洞威胁等级';
COMMENT ON COLUMN "t_vul_analysis_sub"."vulnerability_name" IS '漏洞名称';
COMMENT ON COLUMN "t_vul_analysis_sub"."class_type" IS '漏洞类型';
COMMENT ON COLUMN "t_vul_analysis_sub"."src_user_name" IS '登录用户名';
COMMENT ON COLUMN "t_vul_analysis_sub"."passwd" IS '密码';
COMMENT ON COLUMN "t_vul_analysis_sub"."high" IS '高危漏洞数量';
COMMENT ON COLUMN "t_vul_analysis_sub"."medium" IS '中危漏洞数量';
COMMENT ON COLUMN "t_vul_analysis_sub"."low" IS '低危漏洞数量';
COMMENT ON COLUMN "t_vul_analysis_sub"."agg_count" IS '告警聚合数量';
COMMENT ON COLUMN "t_vul_analysis_sub"."event_code" IS '更新键值';
COMMENT ON COLUMN "t_vul_analysis_sub"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_vul_analysis_sub
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for xdr_schema_version
-- ----------------------------
DROP TABLE IF EXISTS "xdr_schema_version";
CREATE TABLE "xdr_schema_version" (
  "installed_rank" int8 NOT NULL,
  "version" varchar(50) COLLATE "pg_catalog"."default",
  "description" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "script" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
  "checksum" int8,
  "installed_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "installed_on" timestamptz(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "execution_time" int8 NOT NULL,
  "success" bool NOT NULL
)
;
ALTER TABLE "xdr_schema_version" OWNER TO "dbapp";

-- ----------------------------
-- Records of xdr_schema_version
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_alarm_out_going_config
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_alarm_out_going_config"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_alarm_out_going_config"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_alarm_out_going_config"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_block_history
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_block_history"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_block_history"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_block_history"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_event_out_going_config
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_event_out_going_config"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_event_out_going_config"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_event_out_going_config"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_event_update_ck_alarm_queue
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_event_update_ck_alarm_queue"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_event_update_ck_alarm_queue"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.end_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_event_update_ck_alarm_queue"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_intelligence_sub_asset
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_intelligence_sub_asset"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_intelligence_sub_asset"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_intelligence_sub_asset"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_linked_strategy
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_linked_strategy"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_linked_strategy"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_linked_strategy"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_notice_history
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_notice_history"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_notice_history"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_notice_history"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_out_going_config
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_out_going_config"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_out_going_config"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_out_going_config"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_process_chain
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_process_chain"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_process_chain"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_process_chain"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_process_chain_history
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_process_chain_history"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_process_chain_history"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_process_chain_history"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_prohibit_domain_history
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_prohibit_domain_history"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_prohibit_domain_history"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_prohibit_domain_history"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_prohibit_history
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_prohibit_history"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_prohibit_history"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_prohibit_history"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_risk_incidents
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_risk_incidents"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_risk_incidents"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_risk_incidents"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_risk_incidents_analysis
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_risk_incidents_analysis"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_risk_incidents_analysis"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_risk_incidents_analysis"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_risk_incidents_history
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_risk_incidents_history"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_risk_incidents_history"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_risk_incidents_history"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_risk_out_going_config
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_risk_out_going_config"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_risk_out_going_config"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_risk_out_going_config"() OWNER TO "dbapp";

-- ----------------------------
-- Function structure for on_update_current_timestamp_t_strategy_device_rel
-- ----------------------------
DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_strategy_device_rel"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_strategy_device_rel"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
   RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_strategy_device_rel"() OWNER TO "dbapp";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_alarm_out_going_config_id_seq"
OWNED BY "t_alarm_out_going_config"."id";
SELECT setval('"t_alarm_out_going_config_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_alarm_status_timing_task_id_seq"
OWNED BY "t_alarm_status_timing_task"."id";
SELECT setval('"t_alarm_status_timing_task_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_atip_config_id_seq"
OWNED BY "t_atip_config"."id";
SELECT setval('"t_atip_config_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_attack_knowledge_id_seq"
OWNED BY "t_attack_knowledge"."id";
SELECT setval('"t_attack_knowledge_id_seq"', 338, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_attacker_traffic_task_id_seq"
OWNED BY "t_attacker_traffic_task"."id";
SELECT setval('"t_attacker_traffic_task_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_block_history_id_seq"
OWNED BY "t_block_history"."id";
SELECT setval('"t_block_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_chart_template_id_seq"
OWNED BY "t_chart_template"."id";
SELECT setval('"t_chart_template_id_seq"', 3, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_common_config_id_seq"
OWNED BY "t_common_config"."id";
SELECT setval('"t_common_config_id_seq"', 5, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_event_out_going_config_id_seq"
OWNED BY "t_event_out_going_config"."id";
SELECT setval('"t_event_out_going_config_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_event_out_going_data_id_seq"
OWNED BY "t_event_out_going_data"."id";
SELECT setval('"t_event_out_going_data_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_event_scenario_data_id_seq"
OWNED BY "t_event_scenario_data"."id";
SELECT setval('"t_event_scenario_data_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_event_scenario_template_id_seq"
OWNED BY "t_event_scenario_template"."id";
SELECT setval('"t_event_scenario_template_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_event_template_id_seq"
OWNED BY "t_event_template"."id";
SELECT setval('"t_event_template_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_intelligence_sub_asset_id_seq"
OWNED BY "t_intelligence_sub_asset"."id";
SELECT setval('"t_intelligence_sub_asset_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_intelligence_sub_id_seq"
OWNED BY "t_intelligence_sub"."id";
SELECT setval('"t_intelligence_sub_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_isolation_history_id_seq"
OWNED BY "t_isolation_history"."id";
SELECT setval('"t_isolation_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_linkage_strategy_validtime_id_seq"
OWNED BY "t_linkage_strategy_validtime"."id";
SELECT setval('"t_linkage_strategy_validtime_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_linked_strategy_id_seq"
OWNED BY "t_linked_strategy"."id";
SELECT setval('"t_linked_strategy_id_seq"', 15, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_linked_strategy_template_id_seq"
OWNED BY "t_linked_strategy_template"."id";
SELECT setval('"t_linked_strategy_template_id_seq"', 15, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_log_correlation_job_id_seq"
OWNED BY "t_log_correlation_job"."id";
SELECT setval('"t_log_correlation_job_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_notice_history_id_seq"
OWNED BY "t_notice_history"."id";
SELECT setval('"t_notice_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_out_going_config_id_seq"
OWNED BY "t_out_going_config"."id";
SELECT setval('"t_out_going_config_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_process_chain_history_id_seq"
OWNED BY "t_process_chain_history"."id";
SELECT setval('"t_process_chain_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_process_chain_id_seq"
OWNED BY "t_process_chain"."id";
SELECT setval('"t_process_chain_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_process_kill_history_id_seq"
OWNED BY "t_process_kill_history"."id";
SELECT setval('"t_process_kill_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_prohibit_domain_history_id_seq"
OWNED BY "t_prohibit_domain_history"."id";
SELECT setval('"t_prohibit_domain_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_prohibit_history_id_seq"
OWNED BY "t_prohibit_history"."id";
SELECT setval('"t_prohibit_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_query_template_id_seq"
OWNED BY "t_query_template"."id";
SELECT setval('"t_query_template_id_seq"', 10, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_risk_incidents_analysis_id_seq"
OWNED BY "t_risk_incidents_analysis"."id";
SELECT setval('"t_risk_incidents_analysis_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_risk_incidents_history_id_seq"
OWNED BY "t_risk_incidents_history"."id";
SELECT setval('"t_risk_incidents_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_risk_incidents_id_seq"
OWNED BY "t_risk_incidents"."id";
SELECT setval('"t_risk_incidents_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_risk_incidents_out_going_history_id_seq"
OWNED BY "t_risk_incidents_out_going_history"."id";
SELECT setval('"t_risk_incidents_out_going_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_risk_incidents_out_going_id_seq"
OWNED BY "t_risk_incidents_out_going"."id";
SELECT setval('"t_risk_incidents_out_going_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_risk_out_going_config_id_seq"
OWNED BY "t_risk_out_going_config"."id";
SELECT setval('"t_risk_out_going_config_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_scan_history_detail_id_seq"
OWNED BY "t_scan_history_detail"."id";
SELECT setval('"t_scan_history_detail_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_scan_history_id_seq"
OWNED BY "t_scan_history"."id";
SELECT setval('"t_scan_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_scan_job_id_seq"
OWNED BY "t_scan_job"."id";
SELECT setval('"t_scan_job_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_scene_rule_config_id_seq"
OWNED BY "t_scene_rule_config"."id";
SELECT setval('"t_scene_rule_config_id_seq"', 19, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_scene_rule_info_id_seq"
OWNED BY "t_scene_rule_info"."id";
SELECT setval('"t_scene_rule_info_id_seq"', 24, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_security_alarm_handle_id_seq"
OWNED BY "t_security_alarm_handle"."id";
SELECT setval('"t_security_alarm_handle_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_security_incidents_id_seq"
OWNED BY "t_security_incidents"."id";
SELECT setval('"t_security_incidents_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_security_types_id_seq"
OWNED BY "t_security_types"."id";
SELECT setval('"t_security_types_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_strategy_device_rel_id_seq"
OWNED BY "t_strategy_device_rel"."id";
SELECT setval('"t_strategy_device_rel_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_tag_search_list_id_seq"
OWNED BY "t_tag_search_list"."id";
SELECT setval('"t_tag_search_list_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_virus_kill_history_id_seq"
OWNED BY "t_virus_kill_history"."id";
SELECT setval('"t_virus_kill_history_id_seq"', 1, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_vul_analysis_sub_id_seq"
OWNED BY "t_vul_analysis_sub"."id";
SELECT setval('"t_vul_analysis_sub_id_seq"', 1, true);

-- ----------------------------
-- Triggers structure for table t_alarm_out_going_config
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_alarm_out_going_config"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_alarm_out_going_config"();

-- ----------------------------
-- Primary Key structure for table t_alarm_out_going_config
-- ----------------------------
ALTER TABLE "t_alarm_out_going_config" ADD CONSTRAINT "idx_94452_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_alarm_status_timing_task
-- ----------------------------
CREATE UNIQUE INDEX "idx_94463_uniqekey" ON "t_alarm_status_timing_task" USING btree (
  "associated_field" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_alarm_status_timing_task
-- ----------------------------
ALTER TABLE "t_alarm_status_timing_task" ADD CONSTRAINT "idx_94463_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_atip_config
-- ----------------------------
ALTER TABLE "t_atip_config" ADD CONSTRAINT "idx_94470_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_attack_knowledge
-- ----------------------------
ALTER TABLE "t_attack_knowledge" ADD CONSTRAINT "idx_94488_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_attacker_traffic_task
-- ----------------------------
CREATE INDEX "idx_94481_t_attacker_traffic_task_history_time_offset_idx" ON "t_attacker_traffic_task" USING btree (
  "history_time_offset" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94481_t_attacker_traffic_task_start_time_idx" ON "t_attacker_traffic_task" USING btree (
  "start_time" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_94481_t_attacker_traffic_task_un" ON "t_attacker_traffic_task" USING btree (
  "date_part" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_attacker_traffic_task
-- ----------------------------
ALTER TABLE "t_attacker_traffic_task" ADD CONSTRAINT "idx_94481_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_block_history
-- ----------------------------
CREATE INDEX "idx_94495_t_link_strategy_link_device_ip_idx" ON "t_block_history" USING btree (
  "link_device_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_block_history
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_block_history"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_block_history"();

-- ----------------------------
-- Primary Key structure for table t_block_history
-- ----------------------------
ALTER TABLE "t_block_history" ADD CONSTRAINT "idx_94495_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_chart_template
-- ----------------------------
ALTER TABLE "t_chart_template" ADD CONSTRAINT "idx_94509_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_common_config
-- ----------------------------
CREATE UNIQUE INDEX "idx_94516_name_uni" ON "t_common_config" USING btree (
  "prefix" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "configkey" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_common_config
-- ----------------------------
ALTER TABLE "t_common_config" ADD CONSTRAINT "idx_94516_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table t_event_out_going_config
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_event_out_going_config"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_event_out_going_config"();

-- ----------------------------
-- Primary Key structure for table t_event_out_going_config
-- ----------------------------
ALTER TABLE "t_event_out_going_config" ADD CONSTRAINT "idx_94523_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_event_out_going_data
-- ----------------------------
CREATE UNIQUE INDEX "idx_94534_eventcode" ON "t_event_out_going_data" USING btree (
  "event_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94534_timepart" ON "t_event_out_going_data" USING btree (
  "time_part" "pg_catalog"."date_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94534_timestamp" ON "t_event_out_going_data" USING btree (
  "start_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST,
  "end_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_event_out_going_data
-- ----------------------------
ALTER TABLE "t_event_out_going_data" ADD CONSTRAINT "idx_94534_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_event_scenario_data
-- ----------------------------
CREATE INDEX "idx_94541_eventid" ON "t_event_scenario_data" USING btree (
  "incident_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_94541_unique" ON "t_event_scenario_data" USING btree (
  "incident_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "scenario_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "focus_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "target_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_event_scenario_data
-- ----------------------------
ALTER TABLE "t_event_scenario_data" ADD CONSTRAINT "idx_94541_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_event_scenario_queue
-- ----------------------------
CREATE INDEX "idx_94547_t_event_scenario_queue_create_time_idx" ON "t_event_scenario_queue" USING btree (
  "create_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94547_t_event_scenario_queue_time_part_idx" ON "t_event_scenario_queue" USING btree (
  "time_part" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_event_scenario_queue
-- ----------------------------
ALTER TABLE "t_event_scenario_queue" ADD CONSTRAINT "idx_94547_primary" PRIMARY KEY ("focus_ip", "target_ip", "event_code", "scenario_template_id");

-- ----------------------------
-- Primary Key structure for table t_event_scenario_template
-- ----------------------------
ALTER TABLE "t_event_scenario_template" ADD CONSTRAINT "idx_94555_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_event_template
-- ----------------------------
CREATE UNIQUE INDEX "idx_94562_uniq_code" ON "t_event_template" USING btree (
  "uniq_code" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_event_template
-- ----------------------------
ALTER TABLE "t_event_template" ADD CONSTRAINT "idx_94562_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_event_thread
-- ----------------------------
CREATE INDEX "idx_94568_t_event_thread_create_time_idx" ON "t_event_thread" USING btree (
  "create_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_event_thread
-- ----------------------------
ALTER TABLE "t_event_thread" ADD CONSTRAINT "idx_94568_primary" PRIMARY KEY ("event_code");

-- ----------------------------
-- Indexes structure for table t_event_update_ck_alarm_queue
-- ----------------------------
CREATE INDEX "idx_94573_t_event_update_ck_alarm_queue_create_time_idx" ON "t_event_update_ck_alarm_queue" USING btree (
  "create_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94573_t_event_update_ck_alarm_queue_time_part_idx" ON "t_event_update_ck_alarm_queue" USING btree (
  "time_part" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_event_update_ck_alarm_queue
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_event_update_ck_alarm_queue"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_event_update_ck_alarm_queue"();

-- ----------------------------
-- Primary Key structure for table t_event_update_ck_alarm_queue
-- ----------------------------
ALTER TABLE "t_event_update_ck_alarm_queue" ADD CONSTRAINT "idx_94573_primary" PRIMARY KEY ("window_id", "agg_condition");

-- ----------------------------
-- Indexes structure for table t_intelligence_sub
-- ----------------------------
CREATE INDEX "idx_94579_t_intelligence_sub_end_time_idx" ON "t_intelligence_sub" USING btree (
  "end_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_94579_t_intelligence_sub_un" ON "t_intelligence_sub" USING btree (
  "event_time" "pg_catalog"."date_ops" ASC NULLS LAST,
  "ioc" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_intelligence_sub
-- ----------------------------
ALTER TABLE "t_intelligence_sub" ADD CONSTRAINT "idx_94579_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_intelligence_sub_asset
-- ----------------------------
CREATE UNIQUE INDEX "idx_94586_t_intelligence_sub_asset_un" ON "t_intelligence_sub_asset" USING btree (
  "event_time" "pg_catalog"."date_ops" ASC NULLS LAST,
  "ioc" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "asset_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_intelligence_sub_asset
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_intelligence_sub_asset"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_intelligence_sub_asset"();

-- ----------------------------
-- Primary Key structure for table t_intelligence_sub_asset
-- ----------------------------
ALTER TABLE "t_intelligence_sub_asset" ADD CONSTRAINT "idx_94586_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_isolation_history
-- ----------------------------
ALTER TABLE "t_isolation_history" ADD CONSTRAINT "idx_94595_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_linkage_strategy_validtime
-- ----------------------------
CREATE UNIQUE INDEX "idx_94609_t_linkage_strategy_validtime_un" ON "t_linkage_strategy_validtime" USING btree (
  "link_device_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "block_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "block_domain" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "node_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_linkage_strategy_validtime
-- ----------------------------
ALTER TABLE "t_linkage_strategy_validtime" ADD CONSTRAINT "idx_94609_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table t_linked_strategy
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_linked_strategy"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_linked_strategy"();

-- ----------------------------
-- Primary Key structure for table t_linked_strategy
-- ----------------------------
ALTER TABLE "t_linked_strategy" ADD CONSTRAINT "idx_94621_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_linked_strategy_template
-- ----------------------------
ALTER TABLE "t_linked_strategy_template" ADD CONSTRAINT "idx_94636_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_log_correlation_job
-- ----------------------------
ALTER TABLE "t_log_correlation_job" ADD CONSTRAINT "idx_94644_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table t_notice_history
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_notice_history"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_notice_history"();

-- ----------------------------
-- Primary Key structure for table t_notice_history
-- ----------------------------
ALTER TABLE "t_notice_history" ADD CONSTRAINT "idx_94654_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table t_out_going_config
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_out_going_config"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_out_going_config"();

-- ----------------------------
-- Primary Key structure for table t_out_going_config
-- ----------------------------
ALTER TABLE "t_out_going_config" ADD CONSTRAINT "idx_94665_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_process_chain
-- ----------------------------
CREATE UNIQUE INDEX "idx_94675_cachekey" ON "t_process_chain" USING btree (
  "cache_key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_process_chain
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_process_chain"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_process_chain"();

-- ----------------------------
-- Primary Key structure for table t_process_chain
-- ----------------------------
ALTER TABLE "t_process_chain" ADD CONSTRAINT "idx_94675_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_process_chain_history
-- ----------------------------
CREATE UNIQUE INDEX "idx_94683_cachekey" ON "t_process_chain_history" USING btree (
  "cache_key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_process_chain_history
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_process_chain_history"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_process_chain_history"();

-- ----------------------------
-- Primary Key structure for table t_process_chain_history
-- ----------------------------
ALTER TABLE "t_process_chain_history" ADD CONSTRAINT "idx_94683_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_process_kill_history
-- ----------------------------
ALTER TABLE "t_process_kill_history" ADD CONSTRAINT "idx_94691_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_prohibit_domain_history
-- ----------------------------
CREATE INDEX "idx_94705_t_link_strategy_block_domain_idx" ON "t_prohibit_domain_history" USING btree (
  "block_domain" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94705_t_link_strategy_effect_time_idx" ON "t_prohibit_domain_history" USING btree (
  "effect_time" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94705_t_link_strategy_link_device_ip_idx" ON "t_prohibit_domain_history" USING btree (
  "link_device_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_prohibit_domain_history
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_prohibit_domain_history"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_prohibit_domain_history"();

-- ----------------------------
-- Primary Key structure for table t_prohibit_domain_history
-- ----------------------------
ALTER TABLE "t_prohibit_domain_history" ADD CONSTRAINT "idx_94705_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_prohibit_history
-- ----------------------------
CREATE INDEX "idx_94723_t_link_strategy_effect_time_idx" ON "t_prohibit_history" USING btree (
  "effect_time" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94723_t_link_strategy_link_device_ip_idx" ON "t_prohibit_history" USING btree (
  "link_device_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_prohibit_history
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_prohibit_history"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_prohibit_history"();

-- ----------------------------
-- Primary Key structure for table t_prohibit_history
-- ----------------------------
ALTER TABLE "t_prohibit_history" ADD CONSTRAINT "idx_94723_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_query_template
-- ----------------------------
ALTER TABLE "t_query_template" ADD CONSTRAINT "idx_94742_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_risk_incidents
-- ----------------------------
CREATE INDEX "idx_94749_create_time" ON "t_risk_incidents" USING btree (
  "create_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94749_end_time" ON "t_risk_incidents" USING btree (
  "end_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_94749_event_code_unique" ON "t_risk_incidents" USING btree (
  "event_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_risk_incidents
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_risk_incidents"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_risk_incidents"();

-- ----------------------------
-- Primary Key structure for table t_risk_incidents
-- ----------------------------
ALTER TABLE "t_risk_incidents" ADD CONSTRAINT "idx_94749_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_risk_incidents_analysis
-- ----------------------------
CREATE UNIQUE INDEX "idx_94760_unique_risk_incidents_event_code" ON "t_risk_incidents_analysis" USING btree (
  "risk_incidents_event_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_risk_incidents_analysis
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_risk_incidents_analysis"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_risk_incidents_analysis"();

-- ----------------------------
-- Primary Key structure for table t_risk_incidents_analysis
-- ----------------------------
ALTER TABLE "t_risk_incidents_analysis" ADD CONSTRAINT "idx_94760_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_risk_incidents_history
-- ----------------------------
CREATE INDEX "idx_94769_create_time" ON "t_risk_incidents_history" USING btree (
  "create_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94769_end_time" ON "t_risk_incidents_history" USING btree (
  "end_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_risk_incidents_history
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_risk_incidents_history"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_risk_incidents_history"();

-- ----------------------------
-- Primary Key structure for table t_risk_incidents_history
-- ----------------------------
ALTER TABLE "t_risk_incidents_history" ADD CONSTRAINT "idx_94769_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_risk_incidents_out_going
-- ----------------------------
CREATE INDEX "idx_94777_end_time" ON "t_risk_incidents_out_going" USING btree (
  "end_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94777_time_part" ON "t_risk_incidents_out_going" USING btree (
  "time_part" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_94777_uniq_code" ON "t_risk_incidents_out_going" USING btree (
  "uniq_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_risk_incidents_out_going
-- ----------------------------
ALTER TABLE "t_risk_incidents_out_going" ADD CONSTRAINT "idx_94777_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_risk_incidents_out_going_history
-- ----------------------------
CREATE INDEX "idx_94786_end_time" ON "t_risk_incidents_out_going_history" USING btree (
  "end_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94786_time_part" ON "t_risk_incidents_out_going_history" USING btree (
  "time_part" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94786_uniq_code" ON "t_risk_incidents_out_going_history" USING btree (
  "uniq_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_risk_incidents_out_going_history
-- ----------------------------
ALTER TABLE "t_risk_incidents_out_going_history" ADD CONSTRAINT "idx_94786_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Triggers structure for table t_risk_out_going_config
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_risk_out_going_config"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_risk_out_going_config"();

-- ----------------------------
-- Primary Key structure for table t_risk_out_going_config
-- ----------------------------
ALTER TABLE "t_risk_out_going_config" ADD CONSTRAINT "idx_94794_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_scan_history
-- ----------------------------
CREATE UNIQUE INDEX "idx_94805_node_ip_unique" ON "t_scan_history" USING btree (
  "node_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_scan_history
-- ----------------------------
ALTER TABLE "t_scan_history" ADD CONSTRAINT "idx_94805_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_scan_history_detail
-- ----------------------------
ALTER TABLE "t_scan_history_detail" ADD CONSTRAINT "idx_94820_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_scan_job
-- ----------------------------
ALTER TABLE "t_scan_job" ADD CONSTRAINT "idx_94831_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_scene_login_baseline
-- ----------------------------
ALTER TABLE "t_scene_login_baseline" ADD CONSTRAINT "idx_94843_primary" PRIMARY KEY ("dest_address", "src_user_name");

-- ----------------------------
-- Primary Key structure for table t_scene_rule_config
-- ----------------------------
ALTER TABLE "t_scene_rule_config" ADD CONSTRAINT "idx_94851_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_scene_rule_info
-- ----------------------------
CREATE UNIQUE INDEX "idx_94859_t_scene_rule_info_rule_id_uindex" ON "t_scene_rule_info" USING btree (
  "rule_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_scene_rule_info
-- ----------------------------
ALTER TABLE "t_scene_rule_info" ADD CONSTRAINT "idx_94859_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_scene_web_access_temp
-- ----------------------------
CREATE UNIQUE INDEX "idx_94868_t_scene_web_access_temp_id_uindex" ON "t_scene_web_access_temp" USING btree (
  "id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_scene_web_access_temp
-- ----------------------------
ALTER TABLE "t_scene_web_access_temp" ADD CONSTRAINT "idx_94868_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_security_alarm_handle
-- ----------------------------
CREATE UNIQUE INDEX "idx_94875_uniq" ON "t_security_alarm_handle" USING btree (
  "agg_condition" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "window_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_security_alarm_handle
-- ----------------------------
ALTER TABLE "t_security_alarm_handle" ADD CONSTRAINT "idx_94875_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_security_alarm_temp
-- ----------------------------
CREATE INDEX "idx_94880_t_security_alarm_temp_attacker_idx" ON "t_security_alarm_temp" USING btree (
  "attacker" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94880_t_security_alarm_temp_end_time_idx" ON "t_security_alarm_temp" USING btree (
  "end_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94880_t_security_alarm_temp_sub_category_idx" ON "t_security_alarm_temp" USING btree (
  "sub_category" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94880_t_security_alarm_temp_victim_idx" ON "t_security_alarm_temp" USING btree (
  "victim" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_security_alarm_temp
-- ----------------------------
ALTER TABLE "t_security_alarm_temp" ADD CONSTRAINT "idx_94880_primary" PRIMARY KEY ("event_id");

-- ----------------------------
-- Indexes structure for table t_security_incidents
-- ----------------------------
CREATE INDEX "idx_94886_create_time" ON "t_security_incidents" USING btree (
  "create_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94886_end_time" ON "t_security_incidents" USING btree (
  "end_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_94886_event_code_unique" ON "t_security_incidents" USING btree (
  "event_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94886_sub_category" ON "t_security_incidents" USING btree (
  "sub_category" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_security_incidents
-- ----------------------------
ALTER TABLE "t_security_incidents" ADD CONSTRAINT "idx_94886_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_security_types
-- ----------------------------
CREATE UNIQUE INDEX "idx_94895_subcategorynameuniqkey" ON "t_security_types" USING btree (
  "sub_category_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "mirror_sub_category" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_security_types
-- ----------------------------
ALTER TABLE "t_security_types" ADD CONSTRAINT "idx_94895_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_strategy_device_rel
-- ----------------------------
CREATE UNIQUE INDEX "idx_94901_t_strategy_device_rel_un" ON "t_strategy_device_rel" USING btree (
  "strategy_id" "pg_catalog"."int8_ops" ASC NULLS LAST,
  "device_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "action" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Triggers structure for table t_strategy_device_rel
-- ----------------------------
CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_strategy_device_rel"
FOR EACH ROW
EXECUTE PROCEDURE "on_update_current_timestamp_t_strategy_device_rel"();

-- ----------------------------
-- Primary Key structure for table t_strategy_device_rel
-- ----------------------------
ALTER TABLE "t_strategy_device_rel" ADD CONSTRAINT "idx_94901_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_tag_search_list
-- ----------------------------
ALTER TABLE "t_tag_search_list" ADD CONSTRAINT "idx_94911_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table t_virus_kill_history
-- ----------------------------
ALTER TABLE "t_virus_kill_history" ADD CONSTRAINT "idx_94918_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_vul_analysis_sub
-- ----------------------------
CREATE INDEX "idx_94932_assetip" ON "t_vul_analysis_sub" USING btree (
  "asset_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94932_chartid" ON "t_vul_analysis_sub" USING btree (
  "chart_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);
CREATE INDEX "idx_94932_time" ON "t_vul_analysis_sub" USING btree (
  "end_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST,
  "start_time" "pg_catalog"."timestamptz_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "idx_94932_uniq" ON "t_vul_analysis_sub" USING btree (
  "event_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "asset_ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_vul_analysis_sub
-- ----------------------------
ALTER TABLE "t_vul_analysis_sub" ADD CONSTRAINT "idx_94932_primary" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table xdr_schema_version
-- ----------------------------
CREATE INDEX "idx_94938_xdr_schema_version_s_idx" ON "xdr_schema_version" USING btree (
  "success" "pg_catalog"."bool_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table xdr_schema_version
-- ----------------------------
ALTER TABLE "xdr_schema_version" ADD CONSTRAINT "idx_94938_primary" PRIMARY KEY ("installed_rank");
