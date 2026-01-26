-- ============================================
-- EventTemplate 表的Boolean转换演示
-- 模拟Java传入Integer(0/1)到PostgreSQL bool字段
-- ============================================

-- 1. 查看表结构中的bool字段
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 't_event_template'
  AND data_type = 'boolean';

-- 预期结果：
-- incident_type | boolean
-- enable        | boolean

-- ============================================
-- 2. 模拟batchInsert - Java传入Integer值
-- ============================================

-- 场景1: Java对象的值为Integer(1, 1)
INSERT INTO t_event_template
(incident_name, incident_rule_type, incident_class_type, incident_sub_class_type, 
 incident_type, enable, uniq_code)
VALUES
('测试事件_1', '规则类型1', '一级类型', '二级类型',
 (1::int)::boolean,  -- Java传入: incidentType = 1
 (1::int)::boolean,  -- Java传入: enable = 1
 999001);

-- 场景2: Java对象的值为Integer(0, 1)
INSERT INTO t_event_template
(incident_name, incident_rule_type, incident_class_type, incident_sub_class_type, 
 incident_type, enable, uniq_code)
VALUES
('测试事件_2', '规则类型2', '一级类型', '二级类型',
 (0::int)::boolean,  -- Java传入: incidentType = 0
 (1::int)::boolean,  -- Java传入: enable = 1
 999002);

-- 场景3: Java对象的值为Integer(1, 0)
INSERT INTO t_event_template
(incident_name, incident_rule_type, incident_class_type, incident_sub_class_type, 
 incident_type, enable, uniq_code)
VALUES
('测试事件_3', '规则类型3', '一级类型', '二级类型',
 (1::int)::boolean,  -- Java传入: incidentType = 1
 (0::int)::boolean,  -- Java传入: enable = 0
 999003);

-- ============================================
-- 3. 查询验证插入结果
-- ============================================

SELECT 
    incident_name,
    incident_type,
    enable,
    CASE 
        WHEN incident_type = true THEN 'TRUE (从Integer 1转换)'
        WHEN incident_type = false THEN 'FALSE (从Integer 0转换)'
    END as incident_type_display,
    CASE 
        WHEN enable = true THEN 'TRUE (从Integer 1转换)'
        WHEN enable = false THEN 'FALSE (从Integer 0转换)'
    END as enable_display
FROM t_event_template
WHERE uniq_code >= 999001
ORDER BY uniq_code;

-- 预期结果：
-- 测试事件_1: incident_type=true, enable=true
-- 测试事件_2: incident_type=false, enable=true
-- 测试事件_3: incident_type=true, enable=false

-- ============================================
-- 4. 模拟selectAllTemplate - WHERE查询
-- ============================================

-- XML原始错误写法: WHERE (ENABLE = 1)  ❌
-- 修复后正确写法: WHERE (ENABLE = true) ✓

SELECT 
    incident_name,
    incident_type,
    enable
FROM t_event_template
WHERE enable = true  -- 修复后：使用boolean比较
  AND uniq_code >= 999001;

-- 预期结果：测试事件_1 和 测试事件_2（enable=true的记录）

-- ============================================
-- 5. 模拟updateByIncidentName - UPDATE操作
-- ============================================

-- Java传入: enable = 0 (Integer)
UPDATE t_event_template 
SET 
    enable = (0::int)::boolean,          -- Java传入Integer(0)
    incident_type = (1::int)::boolean    -- Java传入Integer(1)
WHERE incident_name = '测试事件_1';

-- 验证更新结果
SELECT 
    incident_name,
    incident_type,
    enable,
    'UPDATE后: enable应为false, incident_type应为true' as note
FROM t_event_template
WHERE incident_name = '测试事件_1';

-- ============================================
-- 6. 模拟updateByUniqCode - ON CONFLICT场景
-- ============================================

-- 第一次插入
INSERT INTO t_event_template
(incident_name, uniq_code, incident_type, enable)
VALUES
('ON_CONFLICT测试', 999999, (1::int)::boolean, (1::int)::boolean)
ON CONFLICT (uniq_code) DO UPDATE SET
    incident_type = EXCLUDED.incident_type,
    enable = EXCLUDED.enable;

-- 第二次插入（会触发ON CONFLICT）
INSERT INTO t_event_template
(incident_name, uniq_code, incident_type, enable)
VALUES
('ON_CONFLICT测试_更新', 999999, (0::int)::boolean, (0::int)::boolean)
ON CONFLICT (uniq_code) DO UPDATE SET
    incident_name = EXCLUDED.incident_name,
    incident_type = EXCLUDED.incident_type,
    enable = EXCLUDED.enable;

-- 验证ON CONFLICT结果
SELECT 
    incident_name,
    uniq_code,
    incident_type,
    enable,
    'ON CONFLICT后: 两个字段都应为false' as note
FROM t_event_template
WHERE uniq_code = 999999;

-- ============================================
-- 7. 清理测试数据
-- ============================================

-- 删除测试数据
DELETE FROM t_event_template WHERE uniq_code >= 999001;

-- ============================================
-- 测试结论
-- ============================================

SELECT 
    '✓ Java传入Integer(1)可以正确转换为boolean(true)' as conclusion_1,
    '✓ Java传入Integer(0)可以正确转换为boolean(false)' as conclusion_2,
    '✓ WHERE条件使用true/false可以正确查询' as conclusion_3,
    '✓ UPDATE操作中的类型转换正常工作' as conclusion_4,
    '✓ ON CONFLICT场景中类型转换正常工作' as conclusion_5;

-- ============================================
-- 完整的MyBatis XML转换对照
-- ============================================

/*
Java代码:
----------
EventTemplate template = new EventTemplate();
template.setIncidentType(1);  // Integer类型
template.setEnable(1);         // Integer类型

XML修复前（错误）:
------------------
#{incidentType,jdbcType=VARCHAR}  ❌ 类型不匹配
#{enable,jdbcType=INTEGER}        ❌ 类型不匹配

实际执行的SQL:
INSERT INTO t_event_template (incident_type, enable)
VALUES ('1', 1)  ❌ 错误！字符串和整数不能赋值给boolean

XML修复后（正确）:
------------------
(#{incidentType,jdbcType=INTEGER}::int)::boolean  ✓
(#{enable,jdbcType=INTEGER}::int)::boolean        ✓

实际执行的SQL:
INSERT INTO t_event_template (incident_type, enable)
VALUES ((1::int)::boolean, (1::int)::boolean)  ✓ 正确！
-- PostgreSQL结果: incident_type=true, enable=true

完整流程:
---------
1. Java: Integer(1)
2. MyBatis: 绑定参数为整数1
3. PostgreSQL: (1::int)::boolean
4. 数据库存储: true
*/
