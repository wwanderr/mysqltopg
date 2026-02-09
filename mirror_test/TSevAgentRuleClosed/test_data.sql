-- Mirror Test: TSevAgentRuleClosed
-- 依赖表：
-- - t_sev_agent_rule_closed（主表）
-- - t_sev_agent_type_rule_closed（外键依赖：rule_closed_id）
-- - t_sev_agent_info（外键依赖：agent_code，可为 NULL）
-- - t_sev_agent_type（外键依赖：t_sev_agent_type_rule_closed.agent_type）
--
-- 外键约束：
-- - t_sev_agent_rule_closed.rule_closed_id → t_sev_agent_type_rule_closed(id) (ON DELETE CASCADE)
-- - t_sev_agent_rule_closed.agent_code → t_sev_agent_info(agent_code) (ON DELETE CASCADE，可为 NULL)
--
-- DDL 参考：
-- - V20260130110517370__create_t_sev_agent_info.sql
-- - V20260130110517373__create_t_sev_agent_type_rule_closed.sql
-- - mirror22.sql 中的 t_sev_agent_type 表

-- ============================================
-- 1) 清理旧数据（按依赖顺序反向删除）
-- ============================================
DELETE FROM t_sev_agent_rule_closed
WHERE id IN (7501, 7502, 7503, 7504, 7505, 7506, 7507, 7508)
   OR agent_code IN ('RCL_AGENT_1', 'RCL_AGENT_2', 'RCL_AGENT_3', 'RCL_AGENT_4', 'TEST_AGENT_NEW', 'TEST_AGENT_BATCH_1', 'TEST_AGENT_BATCH_2', 'TEST_AGENT_UPDATED', 'TEST_AGENT_FULL_UPDATE', 'TEST_AGENT_UPDATED_BY_RULE');

DELETE FROM t_sev_agent_type_rule_closed
WHERE id IN (5001, 5002, 5003);

DELETE FROM t_sev_agent_info
WHERE agent_code IN ('RCL_AGENT_1', 'RCL_AGENT_2', 'RCL_AGENT_3', 'RCL_AGENT_4');

-- 注意：t_sev_agent_type 如果已存在 'APT' 类型，则不需要删除

-- ============================================
-- 2) 准备 t_sev_agent_type（外键依赖）
-- ============================================
INSERT INTO t_sev_agent_type (agent_type, agent_type_name, description)
VALUES
  ('APT', 'APT探针', '高级持续性威胁探针')
ON CONFLICT (agent_type) DO NOTHING;

-- ============================================
-- 3) 准备 t_sev_agent_info（外键依赖）
-- ============================================
-- 目标：为 t_sev_agent_rule_closed 提供 agent_code 外键引用
INSERT INTO t_sev_agent_info (
  agent_code, agent_name, agent_ip, agent_ip_num, agent_type,
  soft_version, status, org_id, regist_time
) VALUES
  ('RCL_AGENT_1', '规则关闭探针1', '10.0.2.1', '0A000201', 'APT',
   'v1.0.0', 'online', 'ORG-001', CURRENT_TIMESTAMP - INTERVAL '3 day'),
  ('RCL_AGENT_2', '规则关闭探针2', '10.0.2.2', '0A000202', 'APT',
   'v1.0.0', 'online', 'ORG-001', CURRENT_TIMESTAMP - INTERVAL '2 day'),
  ('RCL_AGENT_3', '规则关闭探针3', '10.0.2.3', '0A000203', 'APT',
   'v1.0.0', 'offline', 'ORG-002', CURRENT_TIMESTAMP - INTERVAL '1 day'),
  ('RCL_AGENT_4', '规则关闭探针4', '10.0.2.4', '0A000204', 'APT',
   'v1.0.0', 'online', 'ORG-001', CURRENT_TIMESTAMP),
  -- 下面这些用于覆盖测试过程中动态更新/插入的 agent_code，避免外键报错
  ('TEST_AGENT_NEW', '测试探针-新增', '10.0.9.1', '0A000901', 'APT',
   'v1.0.0', 'online', 'ORG-TEST', CURRENT_TIMESTAMP - INTERVAL '1 day'),
  ('TEST_AGENT_BATCH_1', '测试探针-批量1', '10.0.9.2', '0A000902', 'APT',
   'v1.0.0', 'online', 'ORG-TEST', CURRENT_TIMESTAMP - INTERVAL '1 day'),
  ('TEST_AGENT_BATCH_2', '测试探针-批量2', '10.0.9.3', '0A000903', 'APT',
   'v1.0.0', 'online', 'ORG-TEST', CURRENT_TIMESTAMP - INTERVAL '1 day'),
  ('TEST_AGENT_UPDATED', '测试探针-更新', '10.0.9.4', '0A000904', 'APT',
   'v1.0.0', 'online', 'ORG-TEST', CURRENT_TIMESTAMP - INTERVAL '1 day'),
  ('TEST_AGENT_FULL_UPDATE', '测试探针-全量更新', '10.0.9.5', '0A000905', 'APT',
   'v1.0.0', 'online', 'ORG-TEST', CURRENT_TIMESTAMP - INTERVAL '1 day'),
  ('TEST_AGENT_UPDATED_BY_RULE', '测试探针-规则更新', '10.0.9.6', '0A000906', 'APT',
   'v1.0.0', 'online', 'ORG-TEST', CURRENT_TIMESTAMP - INTERVAL '1 day');

-- ============================================
-- 4) 准备 t_sev_agent_type_rule_closed（外键依赖）
-- ============================================
-- 目标：为 t_sev_agent_rule_closed 提供 rule_closed_id 外键引用
INSERT INTO t_sev_agent_type_rule_closed (
  id, agent_type, rule_id, remarks, update_history_alarm, data, create_time, update_time, is_delete
) VALUES
  (5001, 'APT', 'RULE-RCL-1', '测试规则关闭1', false, NULL, CURRENT_TIMESTAMP - INTERVAL '3 day', CURRENT_TIMESTAMP - INTERVAL '2 day', false),
  (5002, 'APT', 'RULE-RCL-2', '测试规则关闭2', true,  NULL, CURRENT_TIMESTAMP - INTERVAL '2 day', CURRENT_TIMESTAMP - INTERVAL '1 day', false),
  (5003, 'APT', 'RULE-RCL-3', '测试规则关闭3', false, NULL, CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP, false);

-- ============================================
-- 5) 准备 t_sev_agent_rule_closed（主表）
-- ============================================
-- 目标：
-- - selectByPrimaryKey(7501) 返回一条记录
-- - selectAgentCodeByRuleClosedId(5001) 返回多条记录
-- - selectCountNullByRuleClosedId(5001) 返回 agent_code IS NULL 的记录数
-- - deleteByAgentCodesNotIn(5001, ['RCL_AGENT_1','RCL_AGENT_2']) 删除不在列表中的记录
INSERT INTO t_sev_agent_rule_closed (
  id, rule_closed_id, agent_code, is_delete, config_version
) VALUES
  -- rule_closed_id=5001 的记录（多条，用于测试 selectAgentCodeByRuleClosedId）
  (7501, 5001, 'RCL_AGENT_1', false, 1000001),
  (7502, 5001, 'RCL_AGENT_2', false, 1000002),
  (7503, 5001, 'RCL_AGENT_3', false, 1000003),
  (7504, 5001, NULL,           false, 1000004),  -- agent_code 为 NULL，用于测试 selectCountNullByRuleClosedId
  (7505, 5001, 'RCL_AGENT_4', false, 1000005),
  
  -- rule_closed_id=5002 的记录（用于测试 deleteByRuleClosedId）
  (7506, 5002, 'RCL_AGENT_1', false, 1000006),
  (7507, 5002, 'RCL_AGENT_2', false, 1000007),
  
  -- rule_closed_id=5003 的记录（用于测试 deleteByPrimaryKey）
  (7508, 5003, 'RCL_AGENT_1', false, 1000008);

-- ============================================
-- 6) 校验（可选）
-- ============================================
SELECT 'rule_closed' AS tag, id, rule_closed_id, agent_code, is_delete, config_version
FROM t_sev_agent_rule_closed
WHERE id IN (7501, 7502, 7503, 7504, 7505, 7506, 7507, 7508)
ORDER BY id;

SELECT 'type_rule_closed' AS tag, id, agent_type, rule_id, is_delete
FROM t_sev_agent_type_rule_closed
WHERE id IN (5001, 5002, 5003)
ORDER BY id;

SELECT 'agent_info' AS tag, agent_code, agent_name, agent_type, status
FROM t_sev_agent_info
WHERE agent_code IN ('RCL_AGENT_1', 'RCL_AGENT_2', 'RCL_AGENT_3', 'RCL_AGENT_4')
ORDER BY agent_code;
