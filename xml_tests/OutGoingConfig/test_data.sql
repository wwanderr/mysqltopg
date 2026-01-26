-- ============================================
-- 测试数据：OutGoingConfig（外发配置）
-- 表：t_out_going_config
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_out_going_config" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_out_going_config" (
    "id",
    "out_going_channel_type",
    "out_going_name",
    "out_going_addr",
    "out_going_port",
    "is_enable",
    "is_auth",
    "username",
    "password",
    "auth_token",
    "create_time",
    "update_time",
    "retry_count",
    "timeout_seconds",
    "extra_config",
    "description"
) VALUES 

-- ==========================================
-- 场景1：邮件外发配置（SMTP，已启用）
-- ==========================================
(
    1001,
    'email',
    '企业邮箱告警通知',
    'smtp.company.com',
    465,
    true,
    true,
    'security-alert@company.com',
    'encrypted_password_001',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '180 days',
    CURRENT_TIMESTAMP - INTERVAL '10 days',
    3,
    30,
    '{"ssl": true, "tls": true, "from_name": "安全监控系统", "cc": ["admin@company.com"], "priority": "high"}',
    '用于发送高危告警邮件通知'
),

-- ==========================================
-- 场景2：Webhook外发配置（钉钉，已启用）
-- ==========================================
(
    1002,
    'webhook',
    '钉钉安全群机器人',
    'https://oapi.dingtalk.com/robot/send',
    443,
    true,
    true,
    NULL,
    NULL,
    'webhook_secret_xxx123456',
    CURRENT_TIMESTAMP - INTERVAL '90 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    5,
    10,
    '{"access_token": "xxx_token_xxx", "sign_type": "hmac_sha256", "at_all": false, "at_mobiles": ["13800138000"]}',
    '安全事件即时推送到钉钉群'
),

-- ==========================================
-- 场景3：Syslog外发配置（SIEM系统，已启用）
-- ==========================================
(
    1003,
    'syslog',
    'SIEM日志收集',
    '192.168.100.50',
    514,
    true,
    false,
    NULL,
    NULL,
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '365 days',
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    0,
    5,
    '{"protocol": "udp", "facility": "local0", "severity": "info", "format": "rfc5424"}',
    '所有安全事件发送到SIEM平台'
),

-- ==========================================
-- 场景4：企业微信配置（已禁用，测试环境）
-- ==========================================
(
    1004,
    'webhook',
    '企业微信测试群',
    'https://qyapi.weixin.qq.com/cgi-bin/webhook/send',
    443,
    false,  -- 已禁用
    true,
    NULL,
    NULL,
    'test_webhook_key_456',
    CURRENT_TIMESTAMP - INTERVAL '60 days',
    CURRENT_TIMESTAMP - INTERVAL '60 days',
    3,
    15,
    '{"key": "test_key_xxx", "msgtype": "markdown", "mentioned_list": ["@all"]}',
    '测试环境配置，暂时停用'
),

-- ==========================================
-- 场景5：Kafka外发配置（大数据平台，已启用）
-- ==========================================
(
    1005,
    'kafka',
    '大数据平台消息队列',
    '192.168.100.60,192.168.100.61,192.168.100.62',
    9092,
    true,
    true,
    'kafka_producer',
    'encrypted_kafka_pwd',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '200 days',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    5,
    20,
    '{"topic": "security_events", "partition": 3, "replication": 2, "compression": "gzip", "acks": "all"}',
    '安全事件推送到Kafka供大数据分析'
);

-- 重置序列
SELECT setval('"t_out_going_config_id_seq"', 1005, true);

-- 验证插入结果
SELECT 
    id,
    out_going_channel_type AS channel,
    out_going_name AS name,
    CASE WHEN is_enable THEN '已启用' ELSE '已禁用' END AS status,
    CASE WHEN is_auth THEN '需要认证' ELSE '无需认证' END AS auth,
    timeout_seconds AS timeout,
    retry_count
FROM "t_out_going_config"
WHERE id >= 1001 AND id <= 1005
ORDER BY is_enable DESC, create_time ASC;

-- 按渠道类型统计
SELECT 
    out_going_channel_type AS "外发渠道",
    COUNT(*) AS "配置数量",
    SUM(CASE WHEN is_enable THEN 1 ELSE 0 END) AS "已启用",
    SUM(CASE WHEN is_auth THEN 1 ELSE 0 END) AS "需要认证"
FROM "t_out_going_config"
WHERE id >= 1001 AND id <= 1005
GROUP BY out_going_channel_type
ORDER BY "配置数量" DESC;

-- 按启用状态统计
SELECT 
    CASE WHEN is_enable THEN '已启用' ELSE '已禁用' END AS "状态",
    COUNT(*) AS "数量",
    STRING_AGG(out_going_name, ', ') AS "配置名称"
FROM "t_out_going_config"
WHERE id >= 1001 AND id <= 1005
GROUP BY is_enable
ORDER BY is_enable DESC;

-- 超时和重试配置统计
SELECT 
    out_going_channel_type AS "渠道类型",
    AVG(timeout_seconds) AS "平均超时(秒)",
    AVG(retry_count) AS "平均重试次数",
    MAX(timeout_seconds) AS "最大超时",
    MAX(retry_count) AS "最大重试"
FROM "t_out_going_config"
WHERE id >= 1001 AND id <= 1005
GROUP BY out_going_channel_type
ORDER BY "平均超时(秒)" DESC;
