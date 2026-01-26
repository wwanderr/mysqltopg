-- ============================================
-- 测试数据：RiskIncident（风险事件）
-- 表：t_risk_incidents
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_risk_incidents" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_risk_incidents" (
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
    "threat_level",
    "description",
    "suggestion",
    "alarm_results",
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
    "is_scenario",
    "judge_result",
    "kill_chain"
) VALUES 

-- ==========================================
-- 场景1：高危APT攻击链（已研判-成功攻击）
-- ==========================================
(
    1001,
    1001,
    '高级持续性威胁(APT)攻击',
    '203.0.113.88',  -- APT攻击源
    '192.168.10.50',  -- 重要服务器
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days 12 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    15,  -- 多阶段攻击
    'confirmed',  -- 已确认
    'critical',
    '检测到完整的APT攻击链：侦查→武器化→投递→利用→安装→C&C→目标达成',
    '建议：1.立即隔离受感染主机；2.全网排查类似攻击；3.加固防护措施',
    '{"attack_chain_complete": true, "data_exfiltration": "5.2GB", "persistence": true}',
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days 12 hours',
    'target_ip',
    'APT攻击',
    '高级威胁',
    '持续性威胁',
    10,
    'attack_stages >= 5 AND persistence_found = true',
    'APT攻击成功，已造成数据泄露',
    '{"tags": ["APT", "数据泄露", "持续威胁", "已确认"]}',
    1,  -- 符合追溯条件
    1,  -- 研判结果：成功
    '侦查→武器化→投递→利用→安装→C&C→目标达成'
),

-- ==========================================
-- 场景2：勒索软件传播（尝试攻击-已拦截）
-- ==========================================
(
    1002,
    1002,
    '勒索软件传播尝试',
    '198.51.100.150',
    '192.168.50.0/24',  -- 目标网段
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '11 hours 30 minutes',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    3,  -- 3台主机被尝试感染
    'blocked',  -- 已拦截
    'critical',
    '检测到勒索软件通过SMB漏洞尝试横向传播，已被EDR拦截',
    '建议：1.确认漏洞已修复；2.全网扫描勒索软件；3.更新EDR规则',
    '{"malware_type": "ransomware", "variant": "WannaCry2.0", "blocked_count": 3}',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '11 hours 30 minutes',
    'target_network',
    '恶意软件',
    '勒索软件',
    '横向传播',
    9,
    'smb_exploit_detected AND file_encryption_attempt',
    '勒索软件传播尝试，已成功拦截',
    '{"tags": ["勒索软件", "WannaCry", "已拦截", "SMB漏洞"]}',
    1,
    2,  -- 研判结果：尝试（未成功）
    '初始访问→横向移动→防御规避（已拦截）'
),

-- ==========================================
-- 场景3：内网横向渗透（正在进行）
-- ==========================================
(
    1003,
    1003,
    '内网横向移动攻击',
    '192.168.20.88',  -- 已被控制的跳板机
    '192.168.30.0/24',  -- 核心网段
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    NULL,  -- 正在进行
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    8,  -- 已尝试8台主机
    'in_progress',  -- 进行中
    'high',
    '检测到攻击者从被控主机192.168.20.88向核心网段进行横向移动',
    '建议：1.立即隔离跳板机；2.监控核心网段；3.检查域控安全',
    '{"lateral_movement_method": "pass_the_hash", "target_count": 8, "success_count": 2}',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '5 minutes',
    'src_ip',
    '横向移动',
    '内网渗透',
    'Pass-the-Hash',
    8,
    'lateral_movement_detected AND target_is_critical',
    '攻击正在进行，已成功渗透2台主机',
    '{"tags": ["横向移动", "Pass-the-Hash", "进行中", "紧急"]}',
    1,
    NULL,  -- 尚未研判
    '初始访问→权限提升→横向移动（进行中）'
),

-- ==========================================
-- 场景4：钓鱼邮件攻击（无害-已处理）
-- ==========================================
(
    1004,
    1004,
    '钓鱼邮件攻击',
    'phishing@evil-domain.com',
    '192.168.100.25',  -- 收件人
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    1,
    'closed',  -- 已关闭
    'low',
    '检测到钓鱼邮件，但收件人未点击恶意链接，邮件已被隔离',
    '建议：1.加强安全意识培训；2.更新邮件过滤规则',
    '{"email_quarantined": true, "link_clicked": false, "attachment_opened": false}',
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    CURRENT_TIMESTAMP - INTERVAL '5 days',
    'recipient_email',
    '社会工程',
    '钓鱼攻击',
    '邮件钓鱼',
    3,
    'phishing_indicators AND suspicious_sender',
    '钓鱼邮件已拦截，未造成危害',
    '{"tags": ["钓鱼邮件", "已隔离", "无危害"]}',
    0,  -- 不符合追溯条件（危害小）
    3,  -- 研判结果：无害
    '初始访问（已阻断）'
),

-- ==========================================
-- 场景5：异常数据外泄（未知-待分析）
-- ==========================================
(
    1005,
    1005,
    '大规模数据外传',
    '192.168.80.120',  -- 内网主机
    '45.xxx.xxx.xxx',  -- 境外IP
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    NULL,  -- 持续中
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    1,
    'analyzing',  -- 分析中
    'high',
    '检测到内网主机向境外IP传输大量数据（15GB），正在分析数据内容',
    '建议：1.阻断外连；2.分析传输内容；3.检查主机进程',
    '{"data_volume": "15GB", "destination_country": "unknown", "protocol": "HTTPS"}',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP,
    'src_ip',
    '数据外泄',
    '目标达成',
    '数据窃取',
    7,
    'outbound_data_volume > 10GB AND destination_is_foreign',
    '正在分析数据内容和外泄原因',
    '{"tags": ["数据外泄", "境外传输", "分析中", "大数据量"]}',
    1,
    4,  -- 研判结果：未知
    '目标达成？（待确认）'
);

-- 重置序列
SELECT setval('"t_risk_incidents_id_seq"', 1005, true);

-- 验证插入结果
SELECT 
    id,
    incident_name,
    focus_ip,
    status,
    threat_level,
    CASE judge_result
        WHEN 1 THEN '成功'
        WHEN 2 THEN '尝试'
        WHEN 3 THEN '无害'
        WHEN 4 THEN '未知'
        ELSE '待研判'
    END AS judge_result_text,
    is_scenario AS "符合追溯",
    kill_chain AS "攻击链"
FROM "t_risk_incidents"
WHERE id >= 1001 AND id <= 1005
ORDER BY priority DESC, start_time DESC;

-- 按威胁级别统计
SELECT 
    threat_level AS "威胁级别",
    COUNT(*) AS "数量",
    SUM(CASE WHEN status IN ('confirmed', 'in_progress') THEN 1 ELSE 0 END) AS "活跃事件"
FROM "t_risk_incidents"
WHERE id >= 1001 AND id <= 1005
GROUP BY threat_level
ORDER BY "数量" DESC;

-- 按研判结果统计
SELECT 
    CASE judge_result
        WHEN 1 THEN '成功'
        WHEN 2 THEN '尝试'
        WHEN 3 THEN '无害'
        WHEN 4 THEN '未知'
        ELSE '待研判'
    END AS "研判结果",
    COUNT(*) AS "数量"
FROM "t_risk_incidents"
WHERE id >= 1001 AND id <= 1005
GROUP BY judge_result
ORDER BY judge_result;

-- 攻击链分析
SELECT 
    incident_name AS "事件名称",
    kill_chain AS "攻击链阶段",
    CASE 
        WHEN kill_chain LIKE '%目标达成%' THEN '完整攻击链'
        WHEN kill_chain LIKE '%已阻断%' OR kill_chain LIKE '%已拦截%' THEN '已阻断'
        WHEN kill_chain LIKE '%进行中%' THEN '攻击进行中'
        ELSE '初期阶段'
    END AS "攻击进度"
FROM "t_risk_incidents"
WHERE id >= 1001 AND id <= 1005
ORDER BY priority DESC;
