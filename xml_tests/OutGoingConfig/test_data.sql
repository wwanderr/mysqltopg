-- ================================================================
-- 深度测试数据：OutGoingConfig（外发配置）+ 3个关联表
-- 主表: t_out_going_config
-- 关联表: t_alarm_out_going_config, t_event_out_going_config, t_risk_out_going_config
-- 生成时间: 2026-01-28
-- ================================================================

-- ================================================================
-- 关联表1：t_alarm_out_going_config（告警外发配置）
-- ================================================================
DELETE FROM "t_alarm_out_going_config" WHERE id >= 2001 AND id <= 2003;

INSERT INTO "t_alarm_out_going_config" (
    "id", "alarm_source", "sub_category", "threat_severity", "alarm_results",
    "enable", "mapping_config_path", "is_del",
    "last_send_result", "cause_of_failure", "last_send_time",
    "send_count", "succeed_count", "create_time", "update_time"
) VALUES
(2001, '["IDS", "WAF"]', '["SQL注入", "XSS攻击"]', 'High,Medium', 'OK,FAIL',
 1, '/config/alarm_mapping.json', 0,
 '成功', NULL, CURRENT_TIMESTAMP - INTERVAL '1 hour',
 100, 95, CURRENT_TIMESTAMP - INTERVAL '180 days', CURRENT_TIMESTAMP - INTERVAL '1 hour'),

(2002, '["EDR"]', '["病毒查杀", "进程隔离"]', 'High', 'OK',
 1, '/config/edr_mapping.json', 0,
 '成功', NULL, CURRENT_TIMESTAMP - INTERVAL '30 minutes',
 50, 48, CURRENT_TIMESTAMP - INTERVAL '90 days', CURRENT_TIMESTAMP - INTERVAL '30 minutes'),

(2003, '["防火墙"]', '["端口扫描"]', 'Low', 'UNKNOWN',
 0, '/config/firewall_mapping.json', 0,
 '失败', '连接超时', CURRENT_TIMESTAMP - INTERVAL '2 hours',
 20, 10, CURRENT_TIMESTAMP - INTERVAL '60 days', CURRENT_TIMESTAMP - INTERVAL '2 hours');

SELECT setval('"t_alarm_out_going_config_id_seq"', 2003, true);

-- ================================================================
-- 关联表2：t_event_out_going_config（事件外发配置）
-- ================================================================
DELETE FROM "t_event_out_going_config" WHERE id >= 3001 AND id <= 3002;

INSERT INTO "t_event_out_going_config" (
    "id", "sub_category", "threat_severity", "alarm_results",
    "enable", "mapping_config_path",
    "last_send_time", "last_send_result", "cause_of_failure", "is_del",
    "send_count", "succeed_count", "create_time", "update_time"
) VALUES
(3001, '["横向移动", "数据外泄"]', 'High,Medium', 'OK',
 1, '/config/event_mapping_v2.json',
 CURRENT_TIMESTAMP - INTERVAL '10 minutes', '成功', NULL, 0,
 200, 198, CURRENT_TIMESTAMP - INTERVAL '120 days', CURRENT_TIMESTAMP - INTERVAL '10 minutes'),

(3002, '["暴力破解"]', 'Medium,Low', 'FAIL',
 1, '/config/bruteforce_mapping.json',
 CURRENT_TIMESTAMP - INTERVAL '1 day', '失败', '目标服务器拒绝连接', 0,
 80, 60, CURRENT_TIMESTAMP - INTERVAL '45 days', CURRENT_TIMESTAMP - INTERVAL '1 day');

SELECT setval('"t_event_out_going_config_id_seq"', 3002, true);

-- ================================================================
-- 关联表3：t_risk_out_going_config（风险外发配置）
-- ================================================================
DELETE FROM "t_risk_out_going_config" WHERE id >= 4001 AND id <= 4002;

INSERT INTO "t_risk_out_going_config" (
    "id", "sub_category", "threat_severity", "alarm_results",
    "enable", "mapping_config_path",
    "last_send_time", "last_send_result", "cause_of_failure", "is_del",
    "send_count", "succeed_count", "create_time", "update_time"
) VALUES
(4001, '["APT攻击", "C&C通信"]', 'High', 'OK',
 1, '/config/risk_apt_mapping.json',
 CURRENT_TIMESTAMP - INTERVAL '5 minutes', '成功', NULL, 0,
 50, 50, CURRENT_TIMESTAMP - INTERVAL '200 days', CURRENT_TIMESTAMP - INTERVAL '5 minutes'),

(4002, '["勒索软件"]', 'High', 'UNKNOWN',
 0, '/config/ransomware_mapping.json',
 CURRENT_TIMESTAMP - INTERVAL '3 days', '尝试中', '等待响应', 0,
 10, 5, CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_TIMESTAMP - INTERVAL '3 days');

SELECT setval('"t_risk_out_going_config_id_seq"', 4002, true);

-- ================================================================
-- 主表：t_out_going_config（外发配置）
-- ================================================================
DELETE FROM "t_out_going_config" WHERE id >= 1001 AND id <= 1005;

INSERT INTO "t_out_going_config" (
    "id", "server_name", "server_address", "auth_tick", "port", "protocol",
    "enable", "type",
    "alarm_config_id", "event_config_id", "risk_config_id",
    "is_del", "create_time", "update_time",
    "kafka_topic", "encryption_type", "ca_cert_path", "is_system_ca",
    "compress_mode", "principal", "key_tab_path", "kdc_server_name", "kafka_server_name"
) VALUES
-- ==========================================
-- 场景1：SYSLOG外发（已启用）- 关联alarm_config
-- ==========================================
(1001, 'SIEM日志服务器', '192.168.100.50', NULL, '514', 'UDP',
 1, 'SYSLOG',
 2001, NULL, NULL,
 0, CURRENT_TIMESTAMP - INTERVAL '365 days', CURRENT_TIMESTAMP - INTERVAL '1 hour',
 NULL, NULL, NULL, NULL,
 NULL, NULL, NULL, NULL, NULL),

-- ==========================================
-- 场景2：API外发（已启用）- 关联event_config
-- ==========================================
(1002, '威胁情报平台API', 'https://threat-intel.company.com/api', 
 '{"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9", "api_key": "sk-abc123"}', '443', 'TCP',
 1, 'API',
 NULL, 3001, NULL,
 0, CURRENT_TIMESTAMP - INTERVAL '120 days', CURRENT_TIMESTAMP - INTERVAL '10 minutes',
 NULL, 'https', NULL, false,
 NULL, NULL, NULL, NULL, NULL),

-- ==========================================
-- 场景3：KAFKA外发（Kerberos认证，已启用）- 关联risk_config
-- ==========================================
(1003, 'Kafka集群-主节点', '192.168.1.10,192.168.1.11,192.168.1.12', 
 NULL, '9092', 'TCP',
 1, 'KAFKA',
 NULL, NULL, 4001,
 0, CURRENT_TIMESTAMP - INTERVAL '200 days', CURRENT_TIMESTAMP - INTERVAL '5 minutes',
 'security-events', 'kerberos', '/opt/kafka/ca/server.pem', false,
 'gzip', 'kafka-producer@COMPANY.COM', '/opt/kafka/keytabs/producer.keytab',
 'KDC-主节点', 'kafka-service-1'),

-- ==========================================
-- 场景4：KAFKA外发（已禁用，测试）- 无关联配置
-- ==========================================
(1004, 'Kafka测试环境', '192.168.2.20', 
 NULL, '9092', 'TCP',
 0, 'KAFKA',
 NULL, NULL, NULL,
 0, CURRENT_TIMESTAMP - INTERVAL '60 days', CURRENT_TIMESTAMP - INTERVAL '60 days',
 'test-topic', 'none', NULL, true,
 'snappy', NULL, NULL, NULL, 'kafka-test'),

-- ==========================================
-- 场景5：SYSLOG外发（已启用，关联所有配置）
-- ==========================================
(1005, '综合日志平台', '192.168.100.100', 
 NULL, '6514', 'TCP',
 1, 'SYSLOG',
 2002, 3002, 4002,
 0, CURRENT_TIMESTAMP - INTERVAL '300 days', CURRENT_TIMESTAMP - INTERVAL '1 day',
 NULL, 'tls', '/opt/syslog/ca.crt', true,
 NULL, NULL, NULL, NULL, NULL);

SELECT setval('"t_out_going_config_id_seq"', 1005, true);

-- ================================================================
-- 验证数据完整性
-- ================================================================
SELECT 
    tc.id,
    tc.server_name,
    tc.type,
    tc.enable AS "主配置启用",
    ta.id AS "告警配置ID",
    te.id AS "事件配置ID",
    tr.id AS "风险配置ID"
FROM t_out_going_config tc
LEFT JOIN t_alarm_out_going_config ta ON tc.alarm_config_id = ta.id
LEFT JOIN t_event_out_going_config te ON tc.event_config_id = te.id
LEFT JOIN t_risk_out_going_config tr ON tc.risk_config_id = tr.id
WHERE tc.id >= 1001 AND tc.id <= 1005
ORDER BY tc.id;
