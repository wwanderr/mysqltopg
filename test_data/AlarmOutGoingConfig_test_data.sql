-- ============================================
-- 测试数据：AlarmOutGoingConfigMapper
-- 表：t_alarm_out_going_config
-- 生成时间：2026-01-22
-- ============================================

-- 插入测试数据
INSERT INTO "t_alarm_out_going_config" (
    "id",
    "alarm_source",
    "sub_category",
    "threat_severity",
    "alarm_results",
    "enable",
    "mapping_config_path",
    "is_del",
    "last_send_result",
    "cause_of_failure",
    "last_send_time",
    "send_count",
    "succeed_count",
    "create_time",
    "update_time"
) VALUES 
-- 测试记录1：正常启用的告警配置
(
    1001,
    '["防火墙", "IDS"]',
    '["恶意软件", "入侵检测"]',
    '["高", "中"]',
    '["已拦截", "已处理"]',
    1,
    '/config/alarm_mapping_001.json',
    0,
    '成功',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    10,
    8,
    CURRENT_TIMESTAMP - INTERVAL '7 days',
    CURRENT_TIMESTAMP - INTERVAL '1 hour'
),
-- 测试记录2：发送失败的配置
(
    1002,
    '["Web应用防火墙"]',
    '["SQL注入"]',
    '["高"]',
    '["已拦截"]',
    1,
    '/config/alarm_mapping_002.json',
    0,
    '失败',
    '目标服务器连接超时',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    5,
    3,
    CURRENT_TIMESTAMP - INTERVAL '3 days',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes'
),
-- 测试记录3：已禁用的配置
(
    1003,
    '["邮件网关"]',
    '["钓鱼邮件"]',
    '["中"]',
    '["已隔离"]',
    0,
    '/config/alarm_mapping_003.json',
    0,
    '成功',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    20,
    20,
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days'
),
-- 测试记录4：待删除的配置
(
    1004,
    '["终端检测"]',
    '["病毒"]',
    '["低"]',
    '["已清除"]',
    1,
    '/config/alarm_mapping_004.json',
    0,
    '成功',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    100,
    95,
    CURRENT_TIMESTAMP - INTERVAL '60 days',
    CURRENT_TIMESTAMP - INTERVAL '5 hours'
);

-- 重置序列（如果需要）
SELECT setval('"t_alarm_out_going_config_id_seq"', 1004, true);

-- 验证插入
SELECT 
    id,
    alarm_source,
    sub_category,
    enable,
    is_del,
    last_send_result,
    send_count,
    succeed_count
FROM "t_alarm_out_going_config"
WHERE id >= 1001
ORDER BY id;
