-- ================================================================
-- 测试数据：LinkedStrategy（联动策略）
-- 表: t_linked_strategy
-- 生成时间: 2026-01-28
-- ================================================================

-- 清理测试数据
DELETE FROM "t_linked_strategy" WHERE id >= 1001 AND id <= 1005;

-- ================================================================
-- 插入测试数据
-- ================================================================

INSERT INTO "t_linked_strategy" (
    "id",
    "strategy_name",
    "auto_handle",
    "threat_type",
    "threat_type_config",
    "threat_level",
    "alarm_results",
    "status",
    "source",
    "template_id",
    "link_device_config",
    "alarm_names",
    "create_time",
    "update_time"
) VALUES

-- ==========================================
-- 场景1：自动处置的恶意软件检测策略（已启用）
-- ==========================================
(
    1001,
    '自动封禁挖矿活动',
    true,  -- auto_handle: 自动处置
    'alarmType',
    '/Malware/Miner',  -- 挖矿活动
    'High,Medium',
    'OK',
    true,  -- status: 已启用
    'custom',  -- 自定义策略
    NULL,
    '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"矿池地址（攻击者）","action":"prohibit"}]}]',
    '挖矿活动告警,矿池通信检测',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
),

-- ==========================================
-- 场景2：手动处置的勒索软件检测策略（已启用）
-- ==========================================
(
    1002,
    '勒索软件检测与隔离',
    false,  -- auto_handle: 手动处置
    'alarmType',
    '/Malware/Ransomware',
    'High',
    'OK',
    true,  -- status: 已启用
    'custom',
    NULL,
    '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"full","action":"scan","scanType":["virus"]}]}]',
    '勒索软件检测,文件加密行为',
    CURRENT_TIMESTAMP - INTERVAL '15 days',
    CURRENT_TIMESTAMP - INTERVAL '2 hours'
),

-- ==========================================
-- 场景3：模板策略 - 后门攻击检测（已禁用）
-- ==========================================
(
    1003,
    'Webshell后门检测',
    true,
    'alarmType',
    '/WebAttack/WebshellRequest,/WebAttack/WebshellUpload,/Malware/Webshell',
    'High',
    'OK',
    false,  -- status: 已禁用
    'template',  -- 模板策略
    12,  -- 关联模板ID
    '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"24","prohibitObject":"攻击者","action":"prohibit"}]}]',
    'Webshell上传,Webshell请求,后门访问',
    CURRENT_TIMESTAMP - INTERVAL '60 days',
    CURRENT_TIMESTAMP - INTERVAL '30 days'
),

-- ==========================================
-- 场景4：漏洞攻击联动策略（已启用，多威胁类型）
-- ==========================================
(
    1004,
    'SQL注入攻击自动阻断',
    true,
    'alarmType',
    '/WebAttack/SQLInjection,/WebAttack/XSS,/WebAttack/CommandExec',
    'High',
    'OK,Blocked',
    true,
    'custom',
    NULL,
    '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"12","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-wafv3"}],"linkDeviceType":"Web应用防火墙（WAF）","checked":true,"config":[{"action":"block"}]}]',
    'SQL注入告警,XSS攻击,命令执行',
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    CURRENT_TIMESTAMP - INTERVAL '1 hour'
),

-- ==========================================
-- 场景5：横向移动检测策略（已启用，低威胁级别）
-- ==========================================
(
    1005,
    '内网横向移动检测',
    true,
    'alarmType',
    '/LateralMov/RemoteExec,/SuspTraffic/RemoteCtrl',
    'Medium,Low',
    'OK',
    true,
    'custom',
    NULL,
    '[{"deviceConfig":[{"appId":"dasca-dbappsecurity-ainta"}],"linkDeviceType":"入侵检测系统（IDS）","checked":true,"config":[{"duration":"6","prohibitObject":"攻击者","action":"prohibit"}]},{"deviceConfig":[{"appId":"dasca-dbappsecurity-edrv6"}],"linkDeviceType":"主机安全管理系统（EDR）","checked":true,"config":[{"scanTiming":"immediately","scanScope":"targeted","action":"scan","scanType":["virus","process"]}]}]',
    '远程执行命令,远程控制,内网扫描',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes'
)
ON CONFLICT (id) DO UPDATE SET
    strategy_name = EXCLUDED.strategy_name,
    auto_handle = EXCLUDED.auto_handle,
    threat_type = EXCLUDED.threat_type,
    threat_type_config = EXCLUDED.threat_type_config,
    threat_level = EXCLUDED.threat_level,
    alarm_results = EXCLUDED.alarm_results,
    status = EXCLUDED.status,
    source = EXCLUDED.source,
    template_id = EXCLUDED.template_id,
    link_device_config = EXCLUDED.link_device_config,
    alarm_names = EXCLUDED.alarm_names,
    update_time = CURRENT_TIMESTAMP;

-- 重置序列
SELECT setval('"t_linked_strategy_id_seq"', 1005, true);

-- ================================================================
-- 关联表：t_strategy_device_rel（策略设备关联）
-- ================================================================
-- 清理测试数据
DELETE FROM "t_strategy_device_rel" WHERE strategy_id >= 1001 AND strategy_id <= 1005;

-- 插入策略-设备关联数据（用于测试 getLinkStrategyList 的关联查询）
INSERT INTO "t_strategy_device_rel" (
    "id",
    "strategy_id",
    "device_id",
    "link_device_ip",
    "link_device_type",
    "area",
    "action",
    "action_config",
    "app_id",
    "create_time"
) VALUES
-- 策略1001: 自动封禁挖矿活动 -> IDS设备
(
    5001,
    1001,  -- strategy_id
    'dev-ids-001',
    '192.168.100.10',  -- link_device_ip
    'IDS',  -- link_device_type: 入侵检测系统
    'DMZ',
    'prohibit',  -- action: 阻断
    '{"duration":"12","prohibitObject":"矿池地址（攻击者）"}',
    'dasca-dbappsecurity-ainta',
    CURRENT_TIMESTAMP - INTERVAL '30 days'
),

-- 策略1002: 勒索软件检测 -> EDR设备
(
    5002,
    1002,
    'dev-edr-001',
    '192.168.100.20',  -- link_device_ip
    'EDR',  -- link_device_type: 主机安全管理
    'Internal',
    'scan',  -- action: 扫描
    '{"scanTiming":"immediately","scanScope":"full","scanType":["virus"]}',
    'dasca-dbappsecurity-edrv6',
    CURRENT_TIMESTAMP - INTERVAL '15 days'
),

-- 策略1003: Webshell后门检测 -> IDS设备
(
    5003,
    1003,
    'dev-ids-002',
    '192.168.100.11',
    'IDS',
    'WebServer',
    'prohibit',
    '{"duration":"24","prohibitObject":"攻击者"}',
    'dasca-dbappsecurity-ainta',
    CURRENT_TIMESTAMP - INTERVAL '60 days'
),

-- 策略1004: SQL注入攻击 -> IDS + WAF设备（多设备）
(
    5004,
    1004,
    'dev-ids-003',
    '192.168.100.12',
    'IDS',
    'WebApp',
    'prohibit',
    '{"duration":"12","prohibitObject":"攻击者"}',
    'dasca-dbappsecurity-ainta',
    CURRENT_TIMESTAMP - INTERVAL '7 days'
),
(
    5005,
    1004,
    'dev-waf-001',
    '192.168.200.10',  -- 不同网段
    'WAF',  -- link_device_type: Web应用防火墙
    'WebApp',
    'block',  -- action: 拦截
    '{"action":"block"}',
    'dasca-dbappsecurity-wafv3',
    CURRENT_TIMESTAMP - INTERVAL '7 days'
),

-- 策略1005: 横向移动检测 -> IDS + EDR设备
(
    5006,
    1005,
    'dev-ids-004',
    '192.168.100.13',
    'IDS',
    'Internal',
    'prohibit',
    '{"duration":"6","prohibitObject":"攻击者"}',
    'dasca-dbappsecurity-ainta',
    CURRENT_TIMESTAMP - INTERVAL '3 days'
),
(
    5007,
    1005,
    'dev-edr-002',
    '192.168.100.21',
    'EDR',
    'Internal',
    'scan',
    '{"scanTiming":"immediately","scanScope":"targeted"}',
    'dasca-dbappsecurity-edrv6',
    CURRENT_TIMESTAMP - INTERVAL '3 days'
)
ON CONFLICT (id) DO UPDATE SET
    device_id = EXCLUDED.device_id,
    link_device_ip = EXCLUDED.link_device_ip,
    link_device_type = EXCLUDED.link_device_type,
    area = EXCLUDED.area,
    action = EXCLUDED.action,
    action_config = EXCLUDED.action_config,
    app_id = EXCLUDED.app_id;

-- 重置关联表序列
SELECT setval('"t_strategy_device_rel_id_seq"', 5007, true);

-- ================================================================
-- 说明
-- ================================================================
-- 字段说明 (t_linked_strategy):
--   strategy_name: 策略名称
--   auto_handle: 是否自动处置（true/false）
--   threat_type: 威胁类型（固定为'alarmType'）
--   threat_type_config: 威胁类型配置（如 /Malware/Miner）
--   threat_level: 威胁等级（High, Medium, Low，可多选用逗号分隔）
--   alarm_results: 攻击结果（OK, Blocked等）
--   status: 策略状态（true=启用, false=禁用）
--   source: 策略来源（custom=自定义, template=模板）
--   template_id: 关联的模板ID（模板策略时使用）
--   link_device_config: 联动设备配置（JSON）
--   alarm_names: 告警名称（逗号分隔）
--
-- 字段说明 (t_strategy_device_rel):
--   strategy_id: 关联的策略ID
--   device_id: 设备编号
--   link_device_ip: 联动设备IP
--   link_device_type: 联动设备类型（IDS, EDR, WAF等）
--   action: 动作（prohibit=阻断, scan=扫描, block=拦截）
--
-- ================================================================
-- 验证数据
-- ================================================================
-- 基础查询
SELECT 
    id,
    strategy_name,
    CASE WHEN auto_handle THEN '自动' ELSE '手动' END AS "处置方式",
    threat_level AS "威胁等级",
    CASE WHEN status THEN '已启用' ELSE '已禁用' END AS "状态",
    source AS "来源",
    template_id AS "模板ID"
FROM "t_linked_strategy"
WHERE id >= 1001 AND id <= 1005
ORDER BY id;

-- 按来源统计
SELECT 
    source AS "策略来源",
    COUNT(*) AS "策略数量",
    SUM(CASE WHEN status THEN 1 ELSE 0 END) AS "已启用",
    SUM(CASE WHEN auto_handle THEN 1 ELSE 0 END) AS "自动处置"
FROM "t_linked_strategy"
WHERE id >= 1001 AND id <= 1005
GROUP BY source
ORDER BY "策略数量" DESC;

-- 按威胁等级统计
SELECT 
    threat_level AS "威胁等级",
    COUNT(*) AS "策略数量",
    STRING_AGG(strategy_name, '; ' ORDER BY id) AS "策略列表"
FROM "t_linked_strategy"
WHERE id >= 1001 AND id <= 1005
GROUP BY threat_level
ORDER BY 
    CASE 
        WHEN threat_level LIKE '%High%' THEN 1
        WHEN threat_level LIKE '%Medium%' THEN 2
        WHEN threat_level LIKE '%Low%' THEN 3
        ELSE 4
    END;
