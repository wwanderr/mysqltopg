-- ============================================
-- 测试数据：SecurityType（安全类型）
-- 主表：t_security_types (8个字段)
-- 生成时间：2026-01-28（深度修复）
-- ============================================

DELETE FROM "t_security_types" WHERE id >= 6001 AND id <= 6005;

-- 插入测试数据（完整8个字段）
INSERT INTO "t_security_types" (
    "id",
    "sub_category",
    "category",
    "mirror_sub_category",
    "mirror_category",
    "sub_category_name",
    "category_name",
    "is_enable"
) VALUES

-- ==========================================
-- 场景1：恶意软件检测
-- ==========================================
(
    6001,
    '/malwareIncident/trojan',
    '/malwareIncident',
    'malware_detection',
    'malware',
    '恶意软件检测',
    '恶意软件',
    true
),

-- ==========================================
-- 场景2：勒索软件检测
-- ==========================================
(
    6002,
    '/malwareIncident/ransomware',
    '/malwareIncident',
    'ransomware_detection',
    'malware',
    '勒索软件检测',
    '恶意软件',
    true
),

-- ==========================================
-- 场景3：横向移动
-- ==========================================
(
    6003,
    '/networkAttackIncident/lateralMovement',
    '/networkAttackIncident',
    'lateral_movement',
    'intrusion',
    '横向移动',
    '入侵行为',
    true
),

-- ==========================================
-- 场景4：数据外泄
-- ==========================================
(
    6004,
    '/dataExfiltration/abnormalOutbound',
    '/dataExfiltration',
    'data_exfiltration',
    'exfiltration',
    '数据外泄',
    '数据泄露',
    true
),

-- ==========================================
-- 场景5：C&C通信（已禁用）
-- ==========================================
(
    6005,
    '/commandControl/c2Communication',
    '/commandControl',
    'c2_communication',
    'command_control',
    'C&C通信',
    '命令控制',
    false
);

SELECT setval('"t_security_types_id_seq"', 6005, true);

-- ==========================================
-- 验证：按类型统计
-- ==========================================
SELECT 
    category_name AS "类型",
    COUNT(*) AS "子类型数量",
    SUM(CASE WHEN is_enable = true THEN 1 ELSE 0 END) AS "启用数量"
FROM "t_security_types"
WHERE id >= 6001 AND id <= 6005
GROUP BY category_name
ORDER BY category_name;

-- ==========================================
-- 验证：按启用状态统计
-- ==========================================
SELECT 
    CASE is_enable
        WHEN true THEN '已启用'
        ELSE '已禁用'
    END AS "状态",
    COUNT(*) AS "数量"
FROM "t_security_types"
WHERE id >= 6001 AND id <= 6005
GROUP BY is_enable;
