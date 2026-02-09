-- Mirror Test: TSevAgentMonitor
-- 依赖表：
-- - t_sev_agent_monitor（主表）
-- - t_sev_agent_info（外键依赖：agent_code）
-- - t_sev_agent_type（外键依赖：t_sev_agent_info.agent_type）
--
-- 外键约束：
-- - t_sev_agent_monitor.agent_code → t_sev_agent_info.agent_code (ON DELETE CASCADE ON UPDATE CASCADE)
-- - t_sev_agent_info.agent_type → t_sev_agent_type.agent_type (ON DELETE RESTRICT ON UPDATE CASCADE)
--
-- DDL 参考：
-- - V20260130110517376__create_t_sev_agent_monitor.sql
-- - V20260130110517370__create_t_sev_agent_info.sql
-- - mirror22.sql 中的 t_sev_agent_type 表

-- ============================================
-- 1) 清理旧数据（按依赖顺序反向删除）
-- ============================================
DELETE FROM t_sev_agent_monitor
WHERE agent_code IN ('MON_AGENT_1', 'MON_AGENT_2', 'MON_AGENT_3');

DELETE FROM t_sev_agent_info
WHERE agent_code IN ('MON_AGENT_1', 'MON_AGENT_2', 'MON_AGENT_3');

-- 注意：t_sev_agent_type 如果已存在 'APT', 'EDR' 类型，则不需要删除
-- 如果不存在，下面会插入

-- ============================================
-- 2) 准备 t_sev_agent_type（外键依赖）
-- ============================================
-- 如果已存在则忽略（使用 INSERT ... ON CONFLICT DO NOTHING）
INSERT INTO t_sev_agent_type (agent_type, agent_type_name, description)
VALUES
  ('APT', 'APT探针', '高级持续性威胁探针')
ON CONFLICT (agent_type) DO NOTHING;

INSERT INTO t_sev_agent_type (agent_type, agent_type_name, description)
VALUES
  ('EDR', 'EDR探针', '终端检测与响应探针')
ON CONFLICT (agent_type) DO NOTHING;

-- ============================================
-- 3) 准备 t_sev_agent_info（外键依赖）
-- ============================================
-- 目标：为 t_sev_agent_monitor 提供 agent_code 外键引用
INSERT INTO t_sev_agent_info (
  agent_code, agent_name, agent_ip, agent_ip_num, agent_type,
  soft_version, status, org_id, regist_time
) VALUES
  ('MON_AGENT_1', '监控探针1', '10.0.1.1', '0A000101', 'APT',
   'v1.0.0', 'online', 'ORG-001', CURRENT_TIMESTAMP - INTERVAL '3 day'),
  ('MON_AGENT_2', '监控探针2', '10.0.1.2', '0A000102', 'APT',
   'v1.0.0', 'online', 'ORG-001', CURRENT_TIMESTAMP - INTERVAL '2 day'),
  ('MON_AGENT_3', '监控探针3', '10.0.1.3', '0A000103', 'EDR',
   'v2.0.0', 'offline', 'ORG-002', CURRENT_TIMESTAMP - INTERVAL '1 day');

-- ============================================
-- 4) 准备 t_sev_agent_monitor（主表）
-- ============================================
-- 目标：
-- - deleteByAgentCodeIn(['MON_AGENT_1','MON_AGENT_2']) 删除前两条
-- - MON_AGENT_3 保留，用于验证 deleteByAgentCodeIn 不会误删
INSERT INTO t_sev_agent_monitor (
  id, agent_code, agent_type, cpu_usage, memory_total, memory_use,
  disk_total, disk_use, metric1, metric2, metric3, create_time
) VALUES
  -- MON_AGENT_1：用于 deleteByAgentCodeIn 测试
  (8001, 'MON_AGENT_1', 'APT', 25.5, 8192000000, 2048000000,
   107374182400, 53687091200, 1000, 2000, 500, CURRENT_TIMESTAMP - INTERVAL '10 minute'),
  -- MON_AGENT_2：用于 deleteByAgentCodeIn 测试
  (8002, 'MON_AGENT_2', 'APT', 30.0, 16384000000, 4096000000,
   214748364800, 107374182400, 2000, 4000, 1000, CURRENT_TIMESTAMP - INTERVAL '5 minute'),
  -- MON_AGENT_3：保留，用于验证 deleteByAgentCodeIn 不会误删
  (8003, 'MON_AGENT_3', 'EDR', 15.0, 4096000000, 1024000000,
   53687091200, 26843545600, 500, 1000, 250, CURRENT_TIMESTAMP - INTERVAL '1 minute');

-- ============================================
-- 5) 校验（可选）
-- ============================================
SELECT 'monitor' AS tag, agent_code, agent_type, cpu_usage, metric1, metric2
FROM t_sev_agent_monitor
WHERE agent_code IN ('MON_AGENT_1', 'MON_AGENT_2', 'MON_AGENT_3')
ORDER BY agent_code;

SELECT 'agent_info' AS tag, agent_code, agent_name, agent_type, status
FROM t_sev_agent_info
WHERE agent_code IN ('MON_AGENT_1', 'MON_AGENT_2', 'MON_AGENT_3')
ORDER BY agent_code;
