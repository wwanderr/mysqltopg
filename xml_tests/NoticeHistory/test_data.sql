-- ============================================
-- 测试数据：NoticeHistory（通知历史）
-- 表：t_notice_history
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_notice_history" WHERE id >= 1001 AND id <= 1005;

-- 插入测试数据
INSERT INTO "t_notice_history" (
    "id",
    "notice_type",
    "notice_title",
    "notice_content",
    "notice_level",
    "receiver",
    "receiver_type",
    "send_time",
    "send_status",
    "send_result",
    "retry_count",
    "create_time",
    "update_time",
    "relate_id",
    "relate_type",
    "channel"
) VALUES 

-- ==========================================
-- 场景1：高危告警邮件通知（已成功）
-- ==========================================
(
    1001,
    'alarm',
    '【严重】检测到APT攻击',
    '尊敬的安全管理员：\n\n系统于 2026-01-26 10:30 检测到APT攻击，攻击源：203.0.113.88，目标：192.168.10.50。\n\n请立即处理！',
    'critical',
    'security@company.com',
    'email',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    'success',
    '邮件发送成功，已送达',
    0,
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    '1001',
    'security_incident',
    'email'
),

-- ==========================================
-- 场景2：短信告警通知（已成功）
-- ==========================================
(
    1002,
    'alarm',
    '【紧急】勒索软件传播',
    '紧急告警：检测到勒索软件传播尝试，已自动拦截。详情请登录查看。',
    'high',
    '13800138000',
    'sms',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    'success',
    '短信发送成功',
    0,
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    '1002',
    'security_incident',
    'sms'
),

-- ==========================================
-- 场景3：钉钉群机器人通知（发送失败，已重试2次）
-- ==========================================
(
    1003,
    'notice',
    '安全事件：端口扫描检测',
    '【安全通知】\n时间：2026-01-26 05:30\n事件：端口扫描\n来源：185.220.101.30\n状态：已确认\n\n查看详情 >>',
    'medium',
    'webhook_xxx',
    'webhook',
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    'failed',
    '发送失败：webhook超时，错误码：ETIMEDOUT',
    2,
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    CURRENT_TIMESTAMP - INTERVAL '4 hours 50 minutes',
    '1003',
    'security_incident',
    'dingtalk'
),

-- ==========================================
-- 场景4：系统报表定时推送（已成功）
-- ==========================================
(
    1004,
    'report',
    '每日安全态势报告 - 2026-01-26',
    '今日安全概况：\n- 告警事件：25起\n- 已处理：22起\n- 处理中：3起\n- 封禁IP：15个\n- 安全评分：85分\n\n详细报告见附件。',
    'info',
    'admin@company.com,security@company.com',
    'email',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    'success',
    '邮件发送成功',
    0,
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    '20260126',
    'daily_report',
    'email'
),

-- ==========================================
-- 场景5：企业微信通知（待发送）
-- ==========================================
(
    1005,
    'notice',
    '【提醒】SSL证书即将过期',
    '安全提醒：域名 example.com 的SSL证书将于3天后（2026-01-29）过期，请及时续期。',
    'low',
    'wechat_group_001',
    'webhook',
    CURRENT_TIMESTAMP + INTERVAL '5 minutes',  -- 定时发送
    'pending',
    '等待发送',
    0,
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    CURRENT_TIMESTAMP - INTERVAL '1 hour',
    'cert_monitor',
    'system_notice',
    'wechat_work'
);

-- 重置序列
SELECT setval('"t_notice_history_id_seq"', 1005, true);

-- 验证插入结果
SELECT 
    id,
    notice_title,
    notice_level,
    channel,
    receiver_type,
    send_status,
    CASE 
        WHEN send_time > CURRENT_TIMESTAMP THEN '待发送'
        ELSE '已发送'
    END AS send_time_status,
    retry_count
FROM "t_notice_history"
WHERE id >= 1001 AND id <= 1005
ORDER BY send_time DESC;

-- 按发送状态统计
SELECT 
    send_status AS "发送状态",
    COUNT(*) AS "数量",
    STRING_AGG(DISTINCT channel, ',') AS "使用渠道"
FROM "t_notice_history"
WHERE id >= 1001 AND id <= 1005
GROUP BY send_status
ORDER BY "数量" DESC;

-- 按通知级别统计
SELECT 
    notice_level AS "通知级别",
    notice_type AS "通知类型",
    COUNT(*) AS "数量"
FROM "t_notice_history"
WHERE id >= 1001 AND id <= 1005
GROUP BY notice_level, notice_type
ORDER BY 
    CASE notice_level
        WHEN 'critical' THEN 1
        WHEN 'high' THEN 2
        WHEN 'medium' THEN 3
        WHEN 'low' THEN 4
        ELSE 5
    END;

-- 按渠道统计成功率
SELECT 
    channel AS "通知渠道",
    COUNT(*) AS "总数",
    SUM(CASE WHEN send_status = 'success' THEN 1 ELSE 0 END) AS "成功",
    SUM(CASE WHEN send_status = 'failed' THEN 1 ELSE 0 END) AS "失败",
    ROUND(SUM(CASE WHEN send_status = 'success' THEN 1 ELSE 0 END)::numeric / NULLIF(COUNT(*), 0) * 100, 2) AS "成功率%"
FROM "t_notice_history"
WHERE id >= 1001 AND id <= 1005
GROUP BY channel
ORDER BY "成功率%" DESC;
