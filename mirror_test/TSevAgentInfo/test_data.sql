-- Mirror Test: TSevAgentInfo
-- 依赖表：
-- - t_sev_agent_info
-- - t_sev_agent_monitor
-- - updateinfo（可为空，左连接）
--
-- DDL 参考：
-- - V20260130110517370__create_t_sev_agent_info.sql
-- - V20260130110517370__create_t_sev_agent_monitor.sql
-- - mirror22.sql 中的 updateinfo 表

-- 1) 清理旧数据
DELETE FROM t_sev_agent_info
WHERE agent_code IN ('AGENT_INFO_1', 'AGENT_INFO_2', 'AGENT_INFO_3', 'AGENT_INFO_4');

DELETE FROM t_sev_agent_monitor
WHERE id IN (9001, 9002, 9003);

-- 2) 准备 t_sev_agent_monitor
-- metric2 用于 selectOneByMetric2Mix 排序
INSERT INTO t_sev_agent_monitor (
  id, agent_code, agent_type, cpu_usage, memory_total, memory_use, disk_total, disk_use,
  metric1, metric2, metric3, create_time
) VALUES
  (9001, 'AGENT_INFO_1', 'APT_SandBox', 10, 100, 20, 1000, 100, 1, 50,  5, CURRENT_TIMESTAMP - INTERVAL '10 minute'),
  (9002, 'AGENT_INFO_2', 'APT_SandBox', 20, 100, 30, 1000, 200, 2, 10, 10, CURRENT_TIMESTAMP - INTERVAL '5 minute'),
  (9003, 'AGENT_INFO_3', 'APT',         30, 100, 40, 1000, 300, 3, 80, 15, CURRENT_TIMESTAMP - INTERVAL '1 minute');

-- 3) 准备 t_sev_agent_info
-- 说明：
-- - AGENT_INFO_1 / 2：APT_SandBox + online，用于 selectOneByMetric2Mix / getAllHeartBeatTimeOnline
-- - AGENT_INFO_3：APT + upgrading，用于 getAllUpgrading / selectStatusByAgentCode
-- - AGENT_INFO_4：EDR + offline，用于对比
INSERT INTO t_sev_agent_info (
  id, agent_code, agent_name, agent_ip, agent_ip_num, agent_type,
  machine_code, device_model, soft_version, rule_version, intelligence_version,
  config_version, single_login_uri, status, org_id,
  regist_time, update_time, monitor_id, upgrade_log_id
) VALUES
  (1, 'AGENT_INFO_1', 'Agent 1', '10.0.0.1', '0A000001', 'APT_SandBox',
   'MC-001', 'Model-A', '1.0', 'R1', 'INT1',
   1001, 'http://single-login-1', 'online', 'ORG-A',
   CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '1 hour', 9001, NULL),

  (2, 'AGENT_INFO_2', 'Agent 2', '10.0.0.2', '0A000002', 'APT_SandBox',
   'MC-002', 'Model-B', '1.1', 'R2', 'INT2',
   1002, 'http://single-login-2', 'online', 'ORG-B',
   CURRENT_TIMESTAMP - INTERVAL '2 day', CURRENT_TIMESTAMP - INTERVAL '2 hour', 9002, NULL),

  (3, 'AGENT_INFO_3', 'Agent 3', '10.0.0.3', '0A000003', 'APT',
   'MC-003', 'Model-C', '1.2', 'R3', 'INT3',
   1003, 'http://single-login-3', 'upgrading', 'ORG-C',
   CURRENT_TIMESTAMP - INTERVAL '3 day', CURRENT_TIMESTAMP - INTERVAL '3 hour', 9003, NULL),

  (4, 'AGENT_INFO_4', 'Agent 4', '10.0.0.4', '0A000004', 'EDR',
   'MC-004', 'Model-D', '1.3', 'R4', 'INT4',
   1004, 'http://single-login-4', 'offline', 'ORG-D',
   CURRENT_TIMESTAMP - INTERVAL '4 day', CURRENT_TIMESTAMP - INTERVAL '4 hour', NULL, NULL);

-- 4) 可选检查
SELECT 'info_before' AS tag, agent_code, agent_type, status, org_id, monitor_id
FROM t_sev_agent_info
WHERE agent_code LIKE 'AGENT_INFO_%'
ORDER BY id;

SELECT 'monitor_before' AS tag, id, agent_code, metric2
FROM t_sev_agent_monitor
WHERE id IN (9001, 9002, 9003)
ORDER BY id;

