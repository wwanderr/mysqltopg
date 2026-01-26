/*
 * Table: t_linked_strategy
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
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