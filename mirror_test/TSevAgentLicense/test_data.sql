-- Mirror Test: TSevAgentLicense
-- 依赖表：
-- - t_sev_agent_license
--
-- DDL 参考：
-- - V20260130110517370__create_t_sev_agent_info.sql 中的 t_sev_agent_license

-- 1) 清理
DELETE FROM t_sev_agent_license
WHERE agent_code IN ('LIC_AGENT_1', 'LIC_AGENT_2', 'LIC_AGENT_3');

-- 2) 准备测试数据
-- 目标：
-- - selectOneByAgentCode('LIC_AGENT_1') 命中一条记录
-- - deleteByAgentCodeIn(['LIC_AGENT_1','LIC_AGENT_2']) 只删除对应三条记录

INSERT INTO t_sev_agent_license (
  id, agent_code, license_code, product_sn, file_name,
  license_type, version, expire_time, file_uuid, create_time, update_time
) VALUES
  (8001, 'LIC_AGENT_1', 'LICENSE_CODE_1', 'SN-001', 'file1.lic',
   0, 1, CURRENT_DATE + INTERVAL '30 day', 'UUID-001', CURRENT_TIMESTAMP - INTERVAL '10 day', CURRENT_TIMESTAMP - INTERVAL '5 day'),

  (8002, 'LIC_AGENT_2', 'LICENSE_CODE_2', 'SN-002', 'file2.lic',
   1, 2, CURRENT_DATE + INTERVAL '60 day', 'UUID-002', CURRENT_TIMESTAMP - INTERVAL '20 day', CURRENT_TIMESTAMP - INTERVAL '10 day'),

  (8003, 'LIC_AGENT_3', 'LICENSE_CODE_3', 'SN-003', 'file3.lic',
   1, 3, CURRENT_DATE + INTERVAL '90 day', 'UUID-003', CURRENT_TIMESTAMP - INTERVAL '30 day', CURRENT_TIMESTAMP - INTERVAL '15 day');

-- 3) 可选检查
SELECT 'license_before' AS tag, id, agent_code, license_type, version, expire_time
FROM t_sev_agent_license
WHERE agent_code IN ('LIC_AGENT_1', 'LIC_AGENT_2', 'LIC_AGENT_3')
ORDER BY id;

