-- Mirror Test: XdrDevice
-- 依赖视图：
-- - t_sev_agent_view（基础视图，需要创建）
-- - t_sev_agent_detail_view（详细视图，需要创建）
--
-- 依赖表：
-- - t_sev_agent_info（主表）
-- - t_sev_agent_type（探针类型）
-- - t_sev_agent_license（许可信息）
-- - t_sev_agent_monitor（监控信息，可选）
-- - t_org（组织信息，可选，用于 orgName；若不存在则本脚本创建最小表）
--
-- 注意：这些视图在 DDL 中可能不存在，需要根据基础表创建视图
-- 或者直接使用基础表的数据进行测试

-- ============================================
-- 1) 清理旧数据
-- ============================================
DELETE FROM t_sev_agent_license
WHERE agent_code IN ('XDR_DEVICE_1', 'XDR_DEVICE_2', 'XDR_DEVICE_3');

DELETE FROM t_sev_agent_monitor
WHERE agent_code IN ('XDR_DEVICE_1', 'XDR_DEVICE_2', 'XDR_DEVICE_3');

DELETE FROM t_sev_agent_info
WHERE agent_code IN ('XDR_DEVICE_1', 'XDR_DEVICE_2', 'XDR_DEVICE_3');

-- 注意：t_sev_agent_type 如果已存在 'APT' 类型，则不需要删除

-- 如果 t_org 不存在，创建最小结构
CREATE TABLE IF NOT EXISTS t_org (
    org_id   varchar(100) PRIMARY KEY,
    org_name varchar(255)
);

-- ============================================
-- 2) 准备 t_sev_agent_type（外键依赖）
-- ============================================
INSERT INTO t_sev_agent_type (agent_type, agent_type_name, description)
VALUES
  ('APT', 'APT探针', '高级持续性威胁探针')
ON CONFLICT (agent_type) DO NOTHING;

-- ============================================
-- 3) 准备 t_sev_agent_info（主表）
-- ============================================
INSERT INTO t_sev_agent_info (
  agent_code, agent_name, agent_ip, agent_ip_num, agent_type,
  soft_version, rule_version, status, org_id, regist_time
) VALUES
  ('XDR_DEVICE_1', 'XDR设备1', '10.0.4.1', '0A000401', 'APT',
   'v1.0.0', 'v1.0.0', 'online', 'ORG-001', CURRENT_TIMESTAMP - INTERVAL '3 day'),
  ('XDR_DEVICE_2', 'XDR设备2', '10.0.4.2', '0A000402', 'APT',
   'v1.0.0', 'v1.0.0', 'online', 'ORG-001', CURRENT_TIMESTAMP - INTERVAL '2 day'),
  ('XDR_DEVICE_3', 'XDR设备3', '10.0.4.3', '0A000403', 'APT',
   'v1.0.0', 'v1.0.0', 'offline', 'ORG-002', CURRENT_TIMESTAMP - INTERVAL '1 day');

-- 组织信息（视图用到，可选）
INSERT INTO t_org (org_id, org_name)
VALUES
  ('ORG-001', '测试组织-001'),
  ('ORG-002', '测试组织-002')
ON CONFLICT (org_id) DO NOTHING;

-- ============================================
-- 4) 准备 t_sev_agent_license（许可信息）
-- ============================================
-- 目标：测试不同的许可状态
-- - XDR_DEVICE_1: NORMAL（正常，过期时间 > now() + 10天）
-- - XDR_DEVICE_2: ABOUT_TO_EXPIRE（即将过期，过期时间 < now() + 10天 且 > now()）
-- - XDR_DEVICE_3: EXPIRED（已过期，过期时间 < now()）
INSERT INTO t_sev_agent_license (
  agent_code, expire_time, license_type
) VALUES
  ('XDR_DEVICE_1', CURRENT_TIMESTAMP + INTERVAL '20 day', 0),  -- NORMAL
  ('XDR_DEVICE_2', CURRENT_TIMESTAMP + INTERVAL '5 day', 0),   -- ABOUT_TO_EXPIRE
  ('XDR_DEVICE_3', CURRENT_TIMESTAMP - INTERVAL '1 day', 0);   -- EXPIRED

-- ============================================
-- 5) 准备 t_sev_agent_monitor（监控信息，可选）
-- ============================================
-- 注意：如果视图需要监控信息，则插入这些数据
INSERT INTO t_sev_agent_monitor (
  agent_code, agent_type, cpu_usage, memory_total, memory_use,
  disk_total, disk_use, metric1, metric2, metric3, create_time
) VALUES
  ('XDR_DEVICE_1', 'APT', 25.5, 16384, 4096, 102400, 25600, NULL, NULL, NULL, CURRENT_TIMESTAMP),
  ('XDR_DEVICE_2', 'APT', 30.0, 16384, 5120, 102400, 30720, NULL, NULL, NULL, CURRENT_TIMESTAMP),
  ('XDR_DEVICE_3', 'APT', 0.0,  16384, 0,    102400, 0,     NULL, NULL, NULL, CURRENT_TIMESTAMP - INTERVAL '1 day');

-- ============================================
-- 6) 创建视图（如果不存在）
-- ============================================
-- 注意：这些视图的创建语句应该从 DDL 文件中获取
-- 这里提供一个示例视图创建语句（需要根据实际 DDL 调整）

-- 创建 t_sev_agent_view（基础视图）
CREATE OR REPLACE VIEW t_sev_agent_view AS
SELECT 
    tsai.agent_code AS agentCode,
    tsai.single_login_uri AS singleLoginUri,
    tsai.agent_name AS agentName,
    tsat.agent_type_name AS agentTypeName,
    tsai.agent_type AS agentType,
    tsai.agent_ip AS agentIp,
    tsai.machine_code AS machineCode,
    COALESCE(torg.org_name, '') AS orgName,
    COALESCE(tsam.cpu_usage, 0.0) AS cpuUsage,
    COALESCE(tsam.memory_total, 0) AS memoryTotal,
    COALESCE(tsam.memory_use, 0) AS memoryUse,
    CASE WHEN COALESCE(tsam.memory_total,0) > 0 THEN COALESCE(tsam.memory_use,0) / tsam.memory_total ELSE 0 END AS memoryRadio,
    COALESCE(tsam.disk_total, 0) AS diskTotal,
    COALESCE(tsam.disk_use, 0) AS diskUse,
    CASE WHEN COALESCE(tsam.disk_total,0) > 0 THEN COALESCE(tsam.disk_use,0) / tsam.disk_total ELSE 0 END AS diskRadio,
    tsai.status AS status,
    tsai.regist_time AS registTime,
    tsal.expire_time AS expireTime,
    COALESCE(tsal.license_type, 0) AS licenseType,
    COALESCE(tsam.create_time, tsai.regist_time) AS offlineTime
FROM t_sev_agent_info tsai
LEFT JOIN t_sev_agent_type tsat ON tsai.agent_type = tsat.agent_type
LEFT JOIN t_sev_agent_license tsal ON tsai.agent_code = tsal.agent_code
LEFT JOIN t_sev_agent_monitor tsam ON tsai.agent_code = tsam.agent_code
LEFT JOIN t_org torg ON tsai.org_id = torg.org_id;

-- 创建 t_sev_agent_detail_view（详细视图）
CREATE OR REPLACE VIEW t_sev_agent_detail_view AS
SELECT 
    tsai.agent_code AS agentCode,
    tsai.single_login_uri AS singleLoginUri,
    tsai.agent_name AS agentName,
    tsai.agent_type AS agentType,
    tsai.agent_ip AS agentIp,
    tsai.machine_code AS machineCode,
    tsai.org_id AS orgId,
    COALESCE(torg.org_name, '') AS orgName,
    COALESCE(tsam.cpu_usage, 0.0) AS cpuUsage,
    COALESCE(tsam.memory_total, 0) AS memoryTotal,
    COALESCE(tsam.memory_use, 0) AS memoryUse,
    CASE WHEN COALESCE(tsam.memory_total,0) > 0 THEN COALESCE(tsam.memory_use,0) / tsam.memory_total ELSE 0 END AS memoryRadio,
    COALESCE(tsam.disk_total, 0) AS diskTotal,
    COALESCE(tsam.disk_use, 0) AS diskUse,
    CASE WHEN COALESCE(tsam.disk_total,0) > 0 THEN COALESCE(tsam.disk_use,0) / tsam.disk_total ELSE 0 END AS diskRadio,
    tsai.status AS status,
    tsai.regist_time AS registTime,
    tsam.metric3 AS metric3,
    tsai.soft_version AS softVersion,
    tsai.rule_version AS ruleVersion,
    '' AS fileName,  -- 注意：这个字段可能需要从其他表获取
    tsal.expire_time AS expireTime,
    COALESCE(tsal.license_type, 0) AS licenseType,
    COALESCE(tsam.create_time, tsai.regist_time) AS offlineTime
FROM t_sev_agent_info tsai
LEFT JOIN t_sev_agent_type tsat ON tsai.agent_type = tsat.agent_type
LEFT JOIN t_sev_agent_license tsal ON tsai.agent_code = tsal.agent_code
LEFT JOIN t_sev_agent_monitor tsam ON tsai.agent_code = tsam.agent_code
LEFT JOIN t_org torg ON tsai.org_id = torg.org_id;

-- ============================================
-- 7) 校验（可选）
-- ============================================
SELECT 'agent_info' AS tag, agent_code, agent_name, agent_type, status
FROM t_sev_agent_info
WHERE agent_code IN ('XDR_DEVICE_1', 'XDR_DEVICE_2', 'XDR_DEVICE_3')
ORDER BY agent_code;

SELECT 'agent_license' AS tag, agent_code, expire_time, license_type
FROM t_sev_agent_license
WHERE agent_code IN ('XDR_DEVICE_1', 'XDR_DEVICE_2', 'XDR_DEVICE_3')
ORDER BY agent_code;

SELECT 'agent_view' AS tag, agentCode, agentName, agentType, status
FROM t_sev_agent_view
WHERE agentCode IN ('XDR_DEVICE_1', 'XDR_DEVICE_2', 'XDR_DEVICE_3')
ORDER BY agentCode;
