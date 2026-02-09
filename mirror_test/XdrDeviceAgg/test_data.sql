-- Mirror Test: XdrDeviceAgg（聚合统计逻辑）
-- 主要用于验证 XdrDeviceAggMapper.xml 中的各类统计 / 聚合 SQL 是否能在 PostgreSQL 上正常执行。
--
-- 依赖表（来自业务 DDL，本脚本只做数据准备，不强制创建表结构）：
-- - t_sev_agent_info
-- - t_sev_agent_type
-- - t_sev_agent_license
-- - t_sev_agent_monitor
-- - t_organization（XdrDeviceAggMapper.xml 中使用）
--
-- 注意：
-- - agent_code 选用专门前缀：XDR_AGG_*
-- - 避免与其它 mirror_test 脚本（如 XdrDevice/test_data.sql 中的 XDR_DEVICE_*）冲突

-- ============================================
-- 1) 清理旧数据
-- ============================================
DELETE FROM t_sev_agent_monitor
WHERE agent_code IN ('XDR_AGG_1', 'XDR_AGG_2');

DELETE FROM t_sev_agent_license
WHERE agent_code IN ('XDR_AGG_1', 'XDR_AGG_2');

DELETE FROM t_sev_agent_info
WHERE agent_code IN ('XDR_AGG_1', 'XDR_AGG_2');

-- 2) 组织表（XdrDeviceAggMapper.xml 使用 t_organization）
-- ============================================
-- 如果你已经将列统一改为下划线风格（例如 orgname -> org_name，orgid -> org_id 等），
-- 此处也改为使用下划线列名，以匹配当前数据库实际结构。
INSERT INTO t_organization (org_name, abbreviation, org_id, parent_orgid, org_identifier, org_address, org_area)
VALUES
    ('Mirror测试组织-AGG-001', NULL, 'ORG-AGG-001', '', '', '', ''),
    ('Mirror测试组织-AGG-002', NULL, 'ORG-AGG-002', '', '', '', '');

-- ============================================
-- 3) 准备 t_sev_agent_type（探针类型）
-- ============================================
-- XdrDeviceAggMapper 中会按 agent_type 进行聚合统计
INSERT INTO t_sev_agent_type (agent_type, agent_type_name, description)
VALUES
  ('APT',   'APT探针',   '高级持续性威胁探针'),
  ('EDR',   '终端检测响应', 'EDR 探针'),
  ('AiNTA', '流量探针',   'AiNTA 流量探针')
ON CONFLICT (agent_type) DO NOTHING;

-- ============================================
-- 4) 准备 t_sev_agent_info（基础设备信息）
-- ============================================
INSERT INTO t_sev_agent_info (
  agent_code,
  agent_name,
  agent_ip,
  agent_ip_num,
  agent_type,
  soft_version,
  rule_version,
  status,
  org_id,
  regist_time
) VALUES
  ('XDR_AGG_1', 'XDR聚合设备1', '10.0.5.1', '0A000501', 'APT',
   'v1.0.0', 'v1.0.0', 'online',  'ORG-AGG-001', CURRENT_TIMESTAMP - INTERVAL '2 day'),
  ('XDR_AGG_2', 'XDR聚合设备2', '10.0.5.2', '0A000502', 'EDR',
   'v1.0.0', 'v1.0.0', 'offline', 'ORG-AGG-002', CURRENT_TIMESTAMP - INTERVAL '1 day');

-- ============================================
-- 5) 准备 t_sev_agent_license（许可信息）
-- ============================================
-- 这里设计不同许可状态，配合 queryAllDeviceCount 中的 licenseStatus 过滤逻辑使用
INSERT INTO t_sev_agent_license (
  agent_code,
  expire_time,
  license_type
) VALUES
  -- NORMAL：过期时间远大于 now() + 10 day
  ('XDR_AGG_1', CURRENT_TIMESTAMP + INTERVAL '30 day', 0),
  -- EXPIRED：已过期
  ('XDR_AGG_2', CURRENT_TIMESTAMP - INTERVAL '1 day', 0);

-- ============================================
-- 6) 准备 t_sev_agent_monitor（监控 / 指标数据）
-- ============================================
-- 目标：
-- - 支持 getAgentTypeMetric3Sum / getAgentTypeMetric1AndMetric2Sum / getAgentTypeMetric1Sum
-- - 支持 getAgentTypeCpuCount / getAgentTypeMemCount
-- - 支持 getAgentDataMetric1/2/3（不同时间粒度）
-- - 支持 queryTodayStatistics / queryTodayStatisticsByIp
-- 注意：需要指定 id 以便后续更新 t_sev_agent_info.monitor_id

INSERT INTO t_sev_agent_monitor (
  id,
  agent_code,
  agent_type,
  cpu_usage,
  memory_total,
  memory_use,
  disk_total,
  disk_use,
  metric1,
  metric2,
  metric3,
  create_time
) VALUES
  -- XDR_AGG_1：最近2分钟内有多条记录
  -- 用于 getAgentTypeCpuCount(threshold=20.0, minutes=1)：需要至少1条在 now()-2分钟 范围内且 CPU>20.0
  -- 用于 getAgentTypeMemCount(threshold=0.5, minutes=1)：需要至少1条在 now()-2分钟 范围内且 memory_use/memory_total > 0.5
  -- 用于 getAgentTypeMetric1AndMetric2Sum：通过 monitor_id 关联
  (8001, 'XDR_AGG_1', 'APT', 35.0, 16000, 8500, 100000, 50000, 100, 200, 300, CURRENT_TIMESTAMP - INTERVAL '1 minute 30 second'),  -- 内存使用率 0.53125 > 0.5
  (8002, 'XDR_AGG_1', 'APT', 40.0, 16000, 9000, 100000, 60000, 120, 220, 320, CURRENT_TIMESTAMP - INTERVAL '1 minute'),           -- 内存使用率 0.5625 > 0.5
  (8003, 'XDR_AGG_1', 'APT', 45.0, 16000, 9500, 100000, 65000, 150, 250, 350, CURRENT_TIMESTAMP - INTERVAL '30 second'),        -- 内存使用率 0.59375 > 0.5

  -- XDR_AGG_1：今天的数据，用于 queryTodayStatistics
  (8004, 'XDR_AGG_1', 'APT', 20.0, 16000, 6000, 100000, 40000, 80,  160, 260, CURRENT_DATE + INTERVAL '2 hour'),
  (8009, 'XDR_AGG_1', 'APT', 25.0, 16000, 7000, 100000, 45000, 90,  170, 270, CURRENT_DATE + INTERVAL '4 hour'),
  
  -- XDR_AGG_1：24 小时内更早的记录，用于 hour24 / week1 统计
  (8005, 'XDR_AGG_1', 'APT', 15.0, 16000, 5000, 100000, 30000, 60,  140, 240, CURRENT_TIMESTAMP - INTERVAL '1 day'),

  -- XDR_AGG_2：CPU/MEM 较低，用于对比（CPU < 20.0，不应该被统计）
  (8006, 'XDR_AGG_2', 'EDR', 5.0,  8000, 1000, 50000,  5000,  30,  60,  90, CURRENT_TIMESTAMP - INTERVAL '1 minute'),
  (8007, 'XDR_AGG_2', 'EDR', 10.0, 8000, 2000, 50000, 10000, 40,  80, 120, CURRENT_TIMESTAMP - INTERVAL '2 hour'),
  (8008, 'XDR_AGG_2', 'EDR', 0.0,  8000,  500, 50000,  2000, 10,  20,  30, CURRENT_TIMESTAMP - INTERVAL '2 day');

-- ============================================
-- 7) 更新 t_sev_agent_info 的 monitor_id（用于 getAgentTypeMetric1AndMetric2Sum 和 queryTodayStatistics）
-- ============================================
-- 将 XDR_AGG_1 的 monitor_id 设置为第一条监控记录的 id（今天的数据）
UPDATE t_sev_agent_info
SET monitor_id = 8004
WHERE agent_code = 'XDR_AGG_1' AND status = 'online';

-- ============================================
-- 8) 简单校验（可选）
-- ============================================
SELECT 'agg_agent_info' AS tag, agent_code, agent_name, agent_type, status, monitor_id
FROM t_sev_agent_info
WHERE agent_code IN ('XDR_AGG_1', 'XDR_AGG_2')
ORDER BY agent_code;

SELECT 'agg_agent_monitor' AS tag, id, agent_code, agent_type, cpu_usage, memory_total, memory_use, metric1, metric2, metric3, create_time
FROM t_sev_agent_monitor
WHERE agent_code IN ('XDR_AGG_1', 'XDR_AGG_2')
ORDER BY agent_code, create_time;

