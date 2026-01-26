-- ============================================
-- 测试数据：AlarmOutGoingConfigMapper
-- 表：t_alarm_out_going_config
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_alarm_out_going_config" WHERE id >= 1001 AND id <= 1005;

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

-- 测试数据1：正常启用的告警配置（用于测试成功发送）
(
    1001,
    '["防火墙", "IDS", "IPS"]',
    '["恶意软件", "入侵检测", "暴力破解"]',
    '["高", "中"]',
    '["已拦截", "已处理", "已记录"]',
    1,
    '/config/alarm_mapping_001.json',
    0,
    '成功',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    50,
    45,
    CURRENT_TIMESTAMP - INTERVAL '30 days',
    CURRENT_TIMESTAMP - INTERVAL '1 hour'
),

-- 测试数据2：发送失败的配置（用于测试失败更新）
(
    1002,
    '["Web应用防火墙", "API网关"]',
    '["SQL注入", "XSS攻击", "CSRF"]',
    '["高", "严重"]',
    '["已拦截", "已记录"]',
    1,
    '/config/alarm_mapping_002.json',
    0,
    '失败',
    '目标服务器连接超时：192.168.1.100:8080 timeout after 30s',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    20,
    15,
    CURRENT_TIMESTAMP - INTERVAL '15 days',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes'
),

-- 测试数据3：已禁用的配置
(
    1003,
    '["邮件网关", "邮件过滤系统"]',
    '["钓鱼邮件", "垃圾邮件", "病毒附件"]',
    '["中", "低"]',
    '["已隔离", "已删除", "已清除"]',
    0,
    '/config/alarm_mapping_003.json',
    0,
    '成功',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    100,
    95,
    CURRENT_TIMESTAMP - INTERVAL '60 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days'
),

-- 测试数据4：待删除的配置（用于测试 delById）
(
    1004,
    '["终端检测", "EDR", "防病毒"]',
    '["病毒", "木马", "勒索软件"]',
    '["低", "中", "高"]',
    '["已清除", "已隔离", "已拦截"]',
    1,
    '/config/alarm_mapping_004.json',
    0,
    '成功',
    NULL,
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    200,
    190,
    CURRENT_TIMESTAMP - INTERVAL '90 days',
    CURRENT_TIMESTAMP - INTERVAL '5 hours'
),

-- 测试数据5：全新的配置（从未发送过）
(
    1005,
    '["云安全", "容器安全", "SIEM"]',
    '["配置错误", "权限滥用", "异常行为"]',
    '["中", "高"]',
    '["已发现", "待处理"]',
    1,
    '/config/alarm_mapping_005.json',
    0,
    NULL,
    NULL,
    NULL,
    0,
    0,
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
);

-- 重置序列
SELECT setval('"t_alarm_out_going_config_id_seq"', 1005, true);

-- 验证插入结果
SELECT 
    id,
    alarm_source,
    enable,
    is_del,
    last_send_result,
    send_count,
    succeed_count,
    CASE 
        WHEN send_count > 0 THEN ROUND(succeed_count::numeric / send_count * 100, 2)
        ELSE 0 
    END AS success_rate
FROM "t_alarm_out_going_config"
WHERE id >= 1001 AND id <= 1005
ORDER BY id;
