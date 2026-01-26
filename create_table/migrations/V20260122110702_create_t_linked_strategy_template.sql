/*
 * Table: t_linked_strategy_template
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
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