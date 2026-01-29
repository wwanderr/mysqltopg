-- ============================================
-- 测试数据：QueryTemplate（查询模板）
-- 主表：t_query_template (18个字段)
-- 生成时间：2026-01-28（深度修复）
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_query_template" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据（完整18个字段）
INSERT INTO "t_query_template" (
    "id",
    "template_name",
    "template_code",
    "attack_conclusion",
    "ck_query_condition",
    "ck_query_field",
    "ck_query_agg_field",
    "interval_time",
    "description",
    "suggestion",
    "record_field",
    "last_execute_time",
    "agg_field",
    "inner_query_field",
    "outer_query_field",
    "enable",
    "is_thread",
    "category",
    "sub_category"
) VALUES 

-- ==========================================
-- 场景1：暴力破解攻击（启用，线头）
-- ==========================================
(
    1001,
    'SSH暴力破解攻击模板',
    'SSH_BRUTE_FORCE',
    '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间共对#{victimCount}名受害者发起攻击，其中攻击成功#{succeedCount}次',
    'attacker,subCategory,appProtocol',
    '_victim as victim:受害者,_srcUserName as srcUserName:登录用户名,_passwd as passwd:登录密码,sum(_eventCount) as counts:次数',
    '_victim,_appProtocol,_srcUserName,_passwd',
    20,
    'SSH暴力破解通过使用枚举方法，一个一个使用用户名和密码字典，尝试登陆SSH系统',
    '1、确认暴破来源；2、使用处置联动功能进行一键封堵；3、建议系统完善认证策略',
    'attacker,victim,srcUserName,passwd,appProtocol,counts,alarmResults,startTime,endTime',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    'victim,appProtocol,srcUserName',
    'attacker,victim,srcUserName,passwd,eventCount,alarmResults,endTime',
    'attacker,victim,appProtocol,srcUserName,passwd,counts,alarmResults,startTime,endTime',
    1,  -- 启用
    1,  -- 线头
    '/networkAttackIncident',
    '/networkAttackIncident/bruteForceIncident'
),

-- ==========================================
-- 场景2：SQL注入攻击（启用，非线头）
-- ==========================================
(
    1002,
    'SQL注入攻击模板',
    'SQL_INJECTION',
    '攻击者#{attacker}在 #{starTime} 到 #{endTime} 期间发起SQL注入攻击，共#{attackCount}次',
    'attacker,url,httpMethod',
    '_url as url:请求URL,_httpMethod as httpMethod:请求方法,sum(_eventCount) as counts:次数',
    '_url,_httpMethod',
    10,
    'SQL注入是一种代码注入技术，攻击者通过在用户输入中注入恶意SQL代码来操纵数据库',
    '1、立即拦截攻击源IP；2、修复Web应用漏洞；3、使用参数化查询',
    'attacker,url,httpMethod,counts,alarmResults,startTime,endTime',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    'url,httpMethod',
    'attacker,url,httpMethod,eventCount,alarmResults,endTime',
    'attacker,url,httpMethod,counts,alarmResults,startTime,endTime',
    1,  -- 启用
    0,  -- 非线头
    '/webAttackIncident',
    '/webAttackIncident/sqlInjection'
),

-- ==========================================
-- 场景3：端口扫描（启用，线头）
-- ==========================================
(
    1003,
    '端口扫描攻击模板',
    'PORT_SCAN',
    '攻击者#{attacker}扫描了#{victimCount}个目标，扫描端口#{portCount}个',
    'attacker,victim,destPort',
    '_victim as victim:目标IP,_destPort as destPort:目标端口,count(distinct _destPort) as portCount:端口数',
    '_victim,_destPort',
    30,
    '端口扫描是攻击者对目标主机进行全面的端口探测，以发现可利用的服务',
    '1、封禁扫描源IP；2、加强防火墙规则；3、隐藏不必要的服务端口',
    'attacker,victim,destPort,portCount,startTime,endTime',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    'victim,destPort',
    'attacker,victim,destPort,eventCount,endTime',
    'attacker,victim,destPort,portCount,startTime,endTime',
    1,  -- 启用
    1,  -- 线头
    '/networkAttackIncident',
    '/networkAttackIncident/portScan'
),

-- ==========================================
-- 场景4：恶意文件下载（已禁用）
-- ==========================================
(
    1004,
    '恶意文件下载模板',
    'MALWARE_DOWNLOAD',
    '检测到主机#{victim}下载了#{fileCount}个恶意文件',
    'victim,fileHash,fileName',
    '_victim as victim:受害主机,_fileHash as fileHash:文件哈希,_fileName as fileName:文件名',
    '_victim,_fileHash',
    15,
    '主机下载了已知的恶意文件，可能导致系统被感染',
    '1、隔离受感染主机；2、清除恶意文件；3、全盘扫描',
    'victim,fileHash,fileName,counts,startTime,endTime',
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    'victim,fileHash',
    'victim,fileHash,fileName,eventCount,endTime',
    'victim,fileHash,fileName,counts,startTime,endTime',
    0,  -- 已禁用
    0,  -- 非线头
    '/malwareIncident',
    '/malwareIncident/fileDownload'
),

-- ==========================================
-- 场景5：异常外连（启用，线头）
-- ==========================================
(
    1005,
    '内网异常外连模板',
    'ABNORMAL_OUTBOUND',
    '内网主机#{victim}向#{destIp}发起异常外连，共#{connectionCount}次',
    'victim,destIp,destPort',
    '_victim as victim:内网主机,_destIp as destIp:外连目标,_destPort as destPort:目标端口,sum(_eventCount) as connectionCount:连接次数',
    '_victim,_destIp,_destPort',
    20,
    '内网主机向外部IP建立大量连接，可能存在数据外泄或木马回连',
    '1、立即隔离主机；2、分析流量内容；3、检查主机进程',
    'victim,destIp,destPort,connectionCount,startTime,endTime',
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    'victim,destIp,destPort',
    'victim,destIp,destPort,eventCount,endTime',
    'victim,destIp,destPort,connectionCount,startTime,endTime',
    1,  -- 启用
    1,  -- 线头
    '/abnormalTraffic',
    '/abnormalTraffic/outbound'
);

SELECT setval('"t_query_template_id_seq"', 1005, true);

-- ==========================================
-- 验证：按enable统计
-- ==========================================
SELECT 
    CASE enable 
        WHEN 1 THEN '已启用'
        WHEN 0 THEN '已禁用'
    END AS "状态",
    COUNT(*) AS "数量"
FROM "t_query_template"
WHERE id >= 1001 AND id <= 1005
GROUP BY enable
ORDER BY enable DESC;

-- ==========================================
-- 验证：按is_thread统计
-- ==========================================
SELECT 
    CASE is_thread 
        WHEN 1 THEN '线头模板'
        WHEN 0 THEN '非线头模板'
    END AS "类型",
    COUNT(*) AS "数量"
FROM "t_query_template"
WHERE id >= 1001 AND id <= 1005
GROUP BY is_thread
ORDER BY is_thread DESC;
