/*
 * Table: t_query_template
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- SEQUENCE DEFINITIONS
-- ============================
-- ----------------------------
-- Sequence structure for t_query_template_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_query_template_id_seq" CASCADE;
CREATE SEQUENCE "t_query_template_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_query_template_id_seq" OWNER TO "dbapp";

-- ============================
-- TABLE DEFINITION
-- ============================
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
  "last_execute_time" timestamp(6),
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

-- ============================
-- SEQUENCE OWNERSHIP
-- ============================
-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_query_template_id_seq"
OWNED BY "t_query_template"."id";
SELECT setval('"t_query_template_id_seq"', 10, true);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_query_template
-- ----------------------------
ALTER TABLE "t_query_template" ADD CONSTRAINT "idx_94742_primary" PRIMARY KEY ("id");
