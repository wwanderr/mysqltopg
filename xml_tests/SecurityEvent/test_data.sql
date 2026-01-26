-- ============================================
-- 测试数据：SecurityEvent（安全事件）
-- 表：t_security_incidents
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_security_incidents" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_security_incidents" (
    "id",
    "template_id",
    "incident_name",
    "focus_ip",
    "target_ip",
    "start_time",
    "end_time",
    "time_part",
    "count",
    "status",
    "level",
    "description",
    "suggestion",
    "alarm_results",
    "threat_level",
    "create_time",
    "update_time",
    "focus",
    "incident_rule_type",
    "incident_class_type",
    "incident_sub_class_type",
    "priority",
    "incident_cond",
    "conclusion",
    "tag_search",
    "update_ip_information"
) VALUES 

-- ==========================================
-- 场景1：SSH暴力破解攻击事件（正在进行）
-- ==========================================
(
    1001,
    1001,  -- 对应 EventTemplate ID
    'SSH暴力破解攻击',
    '203.0.113.100',  -- 攻击源IP
    '192.168.1.50',  -- 目标服务器IP
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    NULL,  -- 尚未结束
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    25,  -- 已尝试25次
    'open',  -- 正在处理中
    'high',
    '检测到来自203.0.113.100的SSH暴力破解尝试，已失败25次',
    '建议立即封禁攻击源IP，检查服务器SSH配置',
    '{"action": "monitoring", "auto_block": false}',
    'high',
    CURRENT_TIMESTAMP - INTERVAL '15 minutes',
    CURRENT_TIMESTAMP - INTERVAL '1 minute',
    'src_ip',
    '异常登录',
    '入侵检测',
    '暴力破解',
    9,
    'login_fail_count > 5',
    '正在监控中，建议封禁',
    '{"tags": ["暴力破解", "SSH", "入侵检测"]}',
    NULL
),

-- ==========================================
-- 场景2：SQL注入攻击事件（已处理）
-- ==========================================
(
    1002,
    1002,
    'SQL注入攻击检测',
    '198.51.100.25',
    '192.168.10.100',  -- Web服务器
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '1 hour 50 minutes',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    3,  -- 攻击3次
    'closed',  -- 已关闭
    'critical',
    'Web应用遭受SQL注入攻击，攻击者尝试获取数据库信息',
    '已拦截，建议修复Web应用漏洞，使用参数化查询',
    '{"action": "blocked", "waf_rule": "SQL_INJECTION_001"}',
    'critical',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '1 hour 50 minutes',
    'url',
    'Web攻击',
    '应用层攻击',
    'SQL注入',
    10,
    'url LIKE ''%union%select%''',
    '已成功拦截，攻击未得逞',
    '{"tags": ["SQL注入", "Web安全", "已拦截"]}',
    '{"updated_ips": ["198.51.100.25"], "reason": "blocked"}'
),

-- ==========================================
-- 场景3：端口扫描行为（已确认）
-- ==========================================
(
    1003,
    1003,
    '端口扫描行为',
    '185.220.101.30',  -- 扫描源
    '192.168.1.0/24',  -- 被扫描网段
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours 55 minutes',
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    152,  -- 扫描152个端口
    'confirmed',  -- 已确认
    'medium',
    '检测到来自185.220.101.30的大规模端口扫描，扫描了152个端口',
    '建议封禁扫描源IP，检查防火墙规则',
    '{"action": "logged", "scan_type": "SYN_SCAN"}',
    'medium',
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours 55 minutes',
    'src_ip',
    '扫描探测',
    '侦查行为',
    '端口扫描',
    5,
    'unique_ports > 20',
    '已确认为恶意扫描行为',
    '{"tags": ["端口扫描", "侦查", "SYN扫描"]}',
    NULL
),

-- ==========================================
-- 场景4：恶意文件下载（已隔离）
-- ==========================================
(
    1004,
    1004,
    '恶意文件下载行为',
    '192.168.50.120',  -- 内网主机
    '203.0.113.200',  -- 恶意文件服务器
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '23 hours 50 minutes',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    1,
    'resolved',  -- 已解决
    'critical',
    '内网主机192.168.50.120下载了已知恶意软件，MD5: a1b2c3d4e5f6...',
    '已隔离文件，建议对主机进行全盘扫描',
    '{"action": "quarantined", "file_hash": "a1b2c3d4e5f6", "threat_type": "trojan"}',
    'critical',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '23 hours 50 minutes',
    'file_hash',
    '恶意软件',
    '恶意代码传播',
    '木马下载',
    8,
    'file_md5 IN (malware_hash_list)',
    '恶意文件已隔离，威胁已消除',
    '{"tags": ["恶意软件", "木马", "已隔离"]}',
    '{"updated_ips": ["192.168.50.120"], "reason": "infected_host"}'
),

-- ==========================================
-- 场景5：异常外连（正在调查）
-- ==========================================
(
    1005,
    1005,
    '内网主机异常外连',
    '192.168.100.88',  -- 可疑内网主机
    '45.xxx.xxx.xxx',  -- 可疑外部IP（C&C服务器）
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    NULL,  -- 持续中
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    1250,  -- 大量连接
    'investigating',  -- 正在调查
    'high',
    '内网主机异常向外部IP建立大量连接，疑似C&C通信或数据外泄',
    '建议立即隔离主机，分析流量内容，检查进程',
    '{"action": "monitoring", "connection_count": 1250, "data_volume": "5.2GB"}',
    'high',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    CURRENT_TIMESTAMP,
    'src_ip',
    '异常流量',
    '横向移动',
    '外连行为',
    6,
    'connection_count > 100',
    '正在深入调查中',
    '{"tags": ["异常外连", "C&C通信", "调查中"]}',
    NULL
);

-- 重置序列
SELECT setval('"t_security_incidents_id_seq"', 1005, true);

-- 验证插入结果
SELECT 
    id,
    incident_name,
    focus_ip,
    target_ip,
    status,
    level,
    count AS event_count,
    CASE 
        WHEN end_time IS NULL THEN '进行中'
        ELSE '已结束'
    END AS incident_status,
    priority
FROM "t_security_incidents"
WHERE id >= 1001 AND id <= 1005
ORDER BY priority DESC, start_time DESC;

-- 按状态统计
SELECT 
    status AS "状态",
    level AS "威胁级别",
    COUNT(*) AS "数量"
FROM "t_security_incidents"
WHERE id >= 1001 AND id <= 1005
GROUP BY status, level
ORDER BY "数量" DESC;

-- 按事件类型统计
SELECT 
    incident_rule_type AS "事件类型",
    incident_sub_class_type AS "子类型",
    AVG(count) AS "平均事件数"
FROM "t_security_incidents"
WHERE id >= 1001 AND id <= 1005
GROUP BY incident_rule_type, incident_sub_class_type
ORDER BY "平均事件数" DESC;
