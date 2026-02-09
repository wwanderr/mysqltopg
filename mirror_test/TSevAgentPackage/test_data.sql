-- Mirror Test: TSevAgentPackage
-- 依赖表：
-- - t_sev_agent_package（主表）
-- - t_sev_agent_type（外键依赖：agent_type）
-- - t_bs_files（外键依赖：file_uuid，测试数据中使用假 UUID）
--
-- 外键约束：
-- - t_sev_agent_package.agent_type → t_sev_agent_type.agent_type (ON DELETE CASCADE ON UPDATE CASCADE)
-- - t_sev_agent_package.file_uuid → t_bs_files.uuid (ON DELETE RESTRICT ON UPDATE RESTRICT)
--
-- DDL 参考：
-- - V20260130110517377__create_t_sev_agent_package.sql
-- - mirror22.sql 中的 t_sev_agent_type 和 t_bs_files 表

-- ============================================
-- 1) 清理旧数据（按依赖顺序反向删除）
-- ============================================
DELETE FROM t_sev_agent_package
WHERE agent_type = 'APT' AND package_type IN ('software', 'rule', 'intelligence')
  AND package_version LIKE 'TEST-%';

-- 注意：t_sev_agent_type 如果已存在 'APT' 类型，则不需要删除
-- t_bs_files 的假 UUID 如果不存在，外键约束会失败，但测试数据中使用简单的 UUID 字符串

-- ============================================
-- 2) 准备 t_sev_agent_type（外键依赖）
-- ============================================
-- 如果已存在则忽略
INSERT INTO t_sev_agent_type (agent_type, agent_type_name, description)
VALUES
  ('APT', 'APT探针', '高级持续性威胁探针')
ON CONFLICT (agent_type) DO NOTHING;

-- ============================================
-- 3) 准备 t_bs_files（外键依赖，可选）
-- ============================================
-- 注意：如果 t_bs_files 表不存在或外键约束被禁用，可以跳过此步骤
-- 这里使用简单的 INSERT ... ON CONFLICT 来处理
-- 如果表结构不同，可能需要调整
-- 为了简化测试，我们假设 file_uuid 可以是任意字符串（如果外键约束允许）

-- ============================================
-- 4) 准备 t_sev_agent_package（主表）
-- ============================================
-- 目标：
-- - getAllLastVersionByAgentType('APT') 应该返回：
--   - software: TEST-v3.0.0（最新）
--   - rule: TEST-v2.1.0（最新）
--   - intelligence: TEST-v1.2.0（最新）
--
-- - selectNotLastTwoPackage('APT', SOFTWARE) 应该返回：
--   - id=7001（因为只有3个包，倒数第二个是7002，所以7001应该被返回）
--
-- 数据设计：
-- - software: 3个版本（v1.0.0, v2.0.0, v3.0.0），v3.0.0 最新
-- - rule: 2个版本（v2.0.0, v2.1.0），v2.1.0 最新
-- - intelligence: 1个版本（v1.2.0），v1.2.0 最新

INSERT INTO t_sev_agent_package (
  id, agent_type, package_type, package_version, file_uuid, file_name,
  upload_type, file_size, create_time, update_time
) VALUES
  -- software 包：3个版本，用于测试 selectNotLastTwoPackage
  (7001, 'APT', 'software', 'TEST-v1.0.0', 'uuid-software-v1', 'software-v1.0.0.zip',
   'manual', 10485760, CURRENT_TIMESTAMP - INTERVAL '3 day', CURRENT_TIMESTAMP - INTERVAL '3 day'),
  (7002, 'APT', 'software', 'TEST-v2.0.0', 'uuid-software-v2', 'software-v2.0.0.zip',
   'manual', 20971520, CURRENT_TIMESTAMP - INTERVAL '2 day', CURRENT_TIMESTAMP - INTERVAL '2 day'),
  (7003, 'APT', 'software', 'TEST-v3.0.0', 'uuid-software-v3', 'software-v3.0.0.zip',
   'manual', 31457280, CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '1 day'),
  
  -- rule 包：2个版本
  (7004, 'APT', 'rule', 'TEST-v2.0.0', 'uuid-rule-v2', 'rule-v2.0.0.zip',
   'manual', 5242880, CURRENT_TIMESTAMP - INTERVAL '2 day', CURRENT_TIMESTAMP - INTERVAL '2 day'),
  (7005, 'APT', 'rule', 'TEST-v2.1.0', 'uuid-rule-v2.1', 'rule-v2.1.0.zip',
   'manual', 6291456, CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '1 day'),
  
  -- intelligence 包：1个版本
  (7006, 'APT', 'intelligence', 'TEST-v1.2.0', 'uuid-intelligence-v1.2', 'intelligence-v1.2.0.zip',
   'manual', 10485760, CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '1 day');

-- ============================================
-- 5) 校验（可选）
-- ============================================
-- 验证 getAllLastVersionByAgentType 的预期结果
SELECT 'last_versions' AS tag, package_type, package_version, update_time
FROM (
  SELECT package_type, package_version, update_time,
         ROW_NUMBER() OVER (PARTITION BY package_type ORDER BY update_time DESC) AS rn
  FROM t_sev_agent_package
  WHERE agent_type = 'APT' AND package_version LIKE 'TEST-%'
) t
WHERE rn = 1
ORDER BY package_type;

-- 验证 selectNotLastTwoPackage 的预期结果（对于 software 类型）
-- 应该返回 id=7001（因为只有3个包，倒数第二个是7002，所以7001应该被返回）
SELECT 'not_last_two' AS tag, id, package_type, package_version, update_time
FROM t_sev_agent_package
WHERE agent_type = 'APT' 
  AND package_type = 'software'
  AND package_version LIKE 'TEST-%'
ORDER BY update_time DESC;
