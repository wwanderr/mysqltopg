-- ============================================
-- PostgreSQL Boolean类型转换测试
-- 验证：Integer(0/1) -> Boolean(false/true)
-- ============================================

-- 测试1: 直接类型转换测试
SELECT 
    '直接类型转换' as test_name,
    (0::int)::boolean as zero_to_bool,      -- 预期: false
    (1::int)::boolean as one_to_bool;       -- 预期: true

-- 测试2: 在表中实际插入测试
-- 创建临时测试表
DROP TABLE IF EXISTS test_bool_conversion;
CREATE TABLE test_bool_conversion (
    id SERIAL PRIMARY KEY,
    field_name VARCHAR(50),
    bool_value bool,
    description VARCHAR(100)
);

-- 插入测试数据（使用类型转换）
INSERT INTO test_bool_conversion (field_name, bool_value, description)
VALUES 
    ('test_1', (1::int)::boolean, 'Java传入Integer(1)，转换为boolean'),
    ('test_2', (0::int)::boolean, 'Java传入Integer(0)，转换为boolean'),
    ('test_3', true, '直接使用boolean(true)'),
    ('test_4', false, '直接使用boolean(false)');

-- 查询验证结果
SELECT 
    id,
    field_name,
    bool_value,
    CASE 
        WHEN bool_value = true THEN 'TRUE'
        WHEN bool_value = false THEN 'FALSE'
    END as bool_display,
    description
FROM test_bool_conversion
ORDER BY id;

-- 测试3: 验证查询条件
SELECT '测试WHERE条件' as test_name;

-- 查询 bool_value = true 的记录
SELECT field_name, bool_value 
FROM test_bool_conversion 
WHERE bool_value = true;
-- 预期结果: test_1 和 test_3

-- 查询 bool_value = false 的记录  
SELECT field_name, bool_value 
FROM test_bool_conversion 
WHERE bool_value = false;
-- 预期结果: test_2 和 test_4

-- 测试4: 模拟MyBatis参数绑定场景
-- 假设Java传入的参数值是1
DO $$
DECLARE
    java_param_1 INTEGER := 1;
    java_param_0 INTEGER := 0;
BEGIN
    -- 插入使用类型转换
    INSERT INTO test_bool_conversion (field_name, bool_value, description)
    VALUES 
        ('myBatis_simulation_1', (java_param_1::int)::boolean, 'MyBatis模拟：Java传入1'),
        ('myBatis_simulation_0', (java_param_0::int)::boolean, 'MyBatis模拟：Java传入0');
    
    RAISE NOTICE 'MyBatis模拟插入成功！';
END $$;

-- 验证MyBatis模拟的结果
SELECT field_name, bool_value, description
FROM test_bool_conversion
WHERE field_name LIKE 'myBatis%'
ORDER BY id;

-- 测试5: 验证UPDATE操作
UPDATE test_bool_conversion 
SET bool_value = (1::int)::boolean
WHERE field_name = 'test_2';

SELECT field_name, bool_value, 'UPDATE后应该是true' as note
FROM test_bool_conversion
WHERE field_name = 'test_2';

-- 清理测试表
-- DROP TABLE IF EXISTS test_bool_conversion;

-- ============================================
-- 测试总结
-- ============================================
SELECT 
    'Boolean类型转换测试总结' as summary,
    'Integer(1) -> boolean(true) ✓' as conversion_1,
    'Integer(0) -> boolean(false) ✓' as conversion_0,
    'WHERE bool_field = true ✓' as query_true,
    'WHERE bool_field = false ✓' as query_false,
    'UPDATE使用类型转换 ✓' as update_conversion;
