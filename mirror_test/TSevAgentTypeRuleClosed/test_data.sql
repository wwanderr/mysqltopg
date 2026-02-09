-- Mirror Test: TSevAgentTypeRuleClosed
-- 依赖表：
-- - t_sev_agent_type_rule_closed（主表）
-- - t_sev_agent_type（外键依赖：agent_type）
-- - t_sev_agent_rule_closed（关联表，用于多表查询）
-- - t_sev_agent_info（关联表，用于多表查询）
--
-- 外键约束：
-- - t_sev_agent_type_rule_closed.agent_type → t_sev_agent_type(agent_type) (ON DELETE CASCADE)
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
WHERE rule_closed_id IN (6001, 6002, 6003, 6004, 6005)
   OR agent_code IN ('TRC_AGENT_1', 'TRC_AGENT_2', 'TRC_AGENT_3', 'TRC_AGENT_4', 'TRC_AGENT_NEW');

DELETE FROM t_sev_agent_type_rule_closed
WHERE id IN (6001, 6002, 6003, 6004, 6005);

DELETE FROM t_sev_agent_info
WHERE agent_code IN ('TRC_AGENT_1', 'TRC_AGENT_2', 'TRC_AGENT_3', 'TRC_AGENT_4');

-- 注意：t_sev_agent_type 如果已存在 'APT' 类型，则不需要删除

-- ============================================
-- 2) 准备 t_sev_agent_type（外键依赖）
-- ============================================
INSERT INTO t_sev_agent_type (agent_type, agent_type_name, description)
VALUES
  ('APT', 'APT探针', '高级持续性威胁探针')
ON CONFLICT (agent_type) DO NOTHING;

-- ============================================
-- 3) 准备 t_sev_agent_info（关联表，用于多表查询）
-- ============================================
-- 目标：为 t_sev_agent_rule_closed 提供 agent_code 外键引用
INSERT INTO t_sev_agent_info (
  agent_code, agent_name, agent_ip, agent_ip_num, agent_type,
  soft_version, status, org_id, regist_time
) VALUES
  ('TRC_AGENT_1', '规则关闭探针1', '10.0.3.1', '0A000301', 'APT',
   'v1.0.0', 'online', 'ORG-001', CURRENT_TIMESTAMP - INTERVAL '3 day'),
  ('TRC_AGENT_2', '规则关闭探针2', '10.0.3.2', '0A000302', 'APT',
   'v1.0.0', 'online', 'ORG-001', CURRENT_TIMESTAMP - INTERVAL '2 day'),
  ('TRC_AGENT_3', '规则关闭探针3', '10.0.3.3', '0A000303', 'APT',
   'v1.0.0', 'offline', 'ORG-002', CURRENT_TIMESTAMP - INTERVAL '1 day'),
  ('TRC_AGENT_4', '规则关闭探针4', '10.0.3.4', '0A000304', 'APT',
   'v1.0.0', 'online', 'ORG-001', CURRENT_TIMESTAMP);

-- ============================================
-- 4) 准备 t_sev_agent_type_rule_closed（主表）
-- ============================================
-- 目标：
-- - selectByPrimaryKey(6001) 返回一条记录
-- - selectByAgentTypeAndRuleId('APT', 'RULE-TRC-1') 返回一条记录
-- - selectQueryInfoByAgentTypeAndRuleId('APT', 'RULE-TRC-1') 返回一条记录
-- - selectIdByRuleIdAndAgentType('RULE-TRC', 'APT') 返回多条记录（LIKE 查询）
-- - selectIdByRuleIdAndAgentTypePrecisely('RULE-TRC-1', 'APT') 返回一条记录（精确匹配）
INSERT INTO t_sev_agent_type_rule_closed (
  id, agent_type, rule_id, remarks, update_history_alarm, data, create_time, update_time, is_delete
) VALUES
  -- id=6001: 用于测试 selectByPrimaryKey, selectRemarksById, selectAgentNameByPrimaryKey, selectAgentCodeById, getAllAgentById, selectUpdateHistoryAlarmById
  (6001, 'APT', 'RULE-TRC-1', '测试规则关闭1', false, NULL, CURRENT_TIMESTAMP - INTERVAL '3 day', CURRENT_TIMESTAMP - INTERVAL '2 day', false),
  
  -- id=6002: 用于测试 updateByPrimaryKeySelective
  (6002, 'APT', 'RULE-TRC-2', '测试规则关闭2', true, NULL, CURRENT_TIMESTAMP - INTERVAL '2 day', CURRENT_TIMESTAMP - INTERVAL '1 day', false),
  
  -- id=6003: 用于测试 updateByPrimaryKey
  (6003, 'APT', 'RULE-TRC-3', '测试规则关闭3', false, NULL, CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP, false),
  
  -- id=6004: 用于测试 updateRuleIdAndAgentTypeAndRemarksAndUpdateHistoryAlarmById
  (6004, 'APT', 'RULE-TRC-4', '测试规则关闭4', false, NULL, CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP, false),
  
  -- id=6005: 用于测试 deleteByPrimaryKey
  (6005, 'APT', 'RULE-TRC-5', '测试规则关闭5', false, NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false);

-- ============================================
-- 5) 准备 t_sev_agent_rule_closed（关联表）
-- ============================================
-- 目标：
-- - selectByAgentCode('TRC_AGENT_1') 返回 rule_closed_id=6001 的记录
-- - selectAgentNameByPrimaryKey(6001) 返回关联的 agent_name
-- - selectAgentCodeById(6001) 返回关联的 agent_code
-- - getAllAgentById(6001) 返回 ValueName 列表
INSERT INTO t_sev_agent_rule_closed (
  id, rule_closed_id, agent_code, is_delete, config_version
) VALUES
  -- rule_closed_id=6001 的记录（多条，用于测试多表查询）
  (8001, 6001, 'TRC_AGENT_1', false, 2000001),
  (8002, 6001, 'TRC_AGENT_2', false, 2000002),
  (8003, 6001, 'TRC_AGENT_3', false, 2000003),
  (8004, 6001, NULL,           false, 2000004),  -- agent_code 为 NULL，用于测试 getAllAgentById 中的 COALESCE
  
  -- rule_closed_id=6002 的记录
  (8005, 6002, 'TRC_AGENT_1', false, 2000005),
  
  -- rule_closed_id=6003 的记录
  (8006, 6003, 'TRC_AGENT_2', false, 2000006),
  
  -- rule_closed_id=6004 的记录
  (8007, 6004, 'TRC_AGENT_3', false, 2000007),
  
  -- rule_closed_id=6005 的记录（用于测试 deleteByPrimaryKey，会级联删除）
  (8008, 6005, 'TRC_AGENT_4', false, 2000008);

-- ============================================
-- 6) 校验（可选）
-- ============================================
SELECT 'type_rule_closed' AS tag, id, agent_type, rule_id, remarks, is_delete
FROM t_sev_agent_type_rule_closed
WHERE id IN (6001, 6002, 6003, 6004, 6005)
ORDER BY id;

SELECT 'agent_rule_closed' AS tag, id, rule_closed_id, agent_code, is_delete
FROM t_sev_agent_rule_closed
WHERE rule_closed_id IN (6001, 6002, 6003, 6004, 6005)
ORDER BY id;

SELECT 'agent_info' AS tag, agent_code, agent_name, agent_type, status
FROM t_sev_agent_info
WHERE agent_code IN ('TRC_AGENT_1', 'TRC_AGENT_2', 'TRC_AGENT_3', 'TRC_AGENT_4')
ORDER BY agent_code;
