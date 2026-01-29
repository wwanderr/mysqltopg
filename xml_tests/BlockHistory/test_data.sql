-- ============================================
-- 测试数据：BlockHistory（封堵历史）
-- 表：t_block_history
-- 生成时间：2026-01-26
-- ============================================

-- 清理旧测试数据
DELETE FROM "t_block_history" WHERE id >= 1001 AND id <= 1010;

-- 插入测试数据
INSERT INTO "t_block_history" (
    "id",
    "strategy_id",
    "link_device_ip",
    "link_device_type",
    "device_id",
    "src_address",
    "dest_address",
    "content",
    "create_type",
    "launch_times",
    "nta_name",
    "create_time",
    "update_time"
) VALUES 

-- ==========================================
-- 场景1：策略5001 - 防火墙封堵DDoS攻击源（设备IP: 192.168.1.10）
-- ==========================================
(
    1001,
    5001,
    '192.168.1.10',
    'firewall',
    'FW-001',
    '203.0.113.100',
    '192.168.10.50',
    '高流量DDoS攻击，峰值5Gbps',
    'auto',
    3,
    'Firewall-01',
    CURRENT_TIMESTAMP - INTERVAL '2 hours',
    CURRENT_TIMESTAMP - INTERVAL '2 hours'
),

-- ==========================================
-- 场景2：策略5001 - 同一设备的另一个封堵（设备IP: 192.168.1.10）
-- ==========================================
(
    1002,
    5001,
    '192.168.1.10',
    'firewall',
    'FW-001',
    '198.51.100.50',
    '192.168.10.50',
    'APT攻击检测，多次横向移动尝试',
    'manual',
    1,
    'Firewall-01',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
),

-- ==========================================
-- 场景3：策略5002 - ACL封堵恶意IP段（设备IP: 192.168.1.20）
-- ==========================================
(
    1003,
    5002,
    '192.168.1.20',
    'switch',
    'SW-001',
    '185.220.101.0',
    '192.168.10.0',
    '大规模端口扫描活动，扫描全网22端口',
    'auto',
    2,
    'CoreSwitch-01',
    CURRENT_TIMESTAMP - INTERVAL '12 hours',
    CURRENT_TIMESTAMP - INTERVAL '10 hours'
),

-- ==========================================
-- 场景4：策略5003 - IPS联动封堵（设备IP: 192.168.1.30）
-- ==========================================
(
    1004,
    5003,
    '192.168.1.30',
    'ips',
    'IPS-001',
    '192.0.2.88',
    '192.168.20.100',
    '勒索软件横向传播，SMB协议异常',
    'auto',
    5,
    'IPS-Gateway',
    CURRENT_TIMESTAMP - INTERVAL '3 hours',
    CURRENT_TIMESTAMP - INTERVAL '3 hours'
),

-- ==========================================
-- 场景5：策略5001 - 双向封堵（src和dest互换）
-- ==========================================
(
    1005,
    5001,
    '192.168.1.10',
    'firewall',
    'FW-001',
    '192.168.10.50',
    '203.0.113.100',
    '反向流量封堵，防止数据外泄',
    'manual',
    1,
    'Firewall-01',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes',
    CURRENT_TIMESTAMP - INTERVAL '30 minutes'
),

-- ==========================================
-- 场景6：策略5002 - 多次下发（launch_times = 8）
-- ==========================================
(
    1006,
    5002,
    '192.168.1.20',
    'switch',
    'SW-001',
    '203.0.113.200',
    '192.168.30.50',
    '持续性攻击，策略多次下发确保生效',
    'auto',
    8,
    'CoreSwitch-01',
    CURRENT_TIMESTAMP - INTERVAL '6 hours',
    CURRENT_TIMESTAMP - INTERVAL '5 hours'
),

-- ==========================================
-- 场景7：策略5003 - DNS恶意域名封堵
-- ==========================================
(
    1007,
    5003,
    '192.168.1.100',
    'dns_firewall',
    'DNS-FW-001',
    'malware-c2.evil.com',
    '0.0.0.0',
    '恶意软件C&C通信域名，DNS黑洞',
    'auto',
    1,
    'DNS-Firewall-01',
    CURRENT_TIMESTAMP - INTERVAL '1 day',
    CURRENT_TIMESTAMP - INTERVAL '1 day'
),

-- ==========================================
-- 场景8：策略5001 - 已更新的记录
-- ==========================================
(
    1008,
    5001,
    '192.168.1.10',
    'firewall',
    'FW-001',
    '198.51.100.100',
    '192.168.40.50',
    'Web应用攻击，SQL注入尝试',
    'manual',
    2,
    'Firewall-01',
    CURRENT_TIMESTAMP - INTERVAL '5 hours',
    CURRENT_TIMESTAMP - INTERVAL '1 hour'  -- update_time不同
),

-- ==========================================
-- 场景9：策略5004 - 新策略测试
-- ==========================================
(
    1009,
    5004,
    '192.168.1.40',
    'waf',
    'WAF-001',
    '203.0.113.250',
    '192.168.50.100',
    'OWASP Top10攻击检测：XSS尝试',
    'auto',
    1,
    'WebFirewall-01',
    CURRENT_TIMESTAMP - INTERVAL '45 minutes',
    CURRENT_TIMESTAMP - INTERVAL '45 minutes'
),

-- ==========================================
-- 场景10：策略5005 - 设备迁移测试数据
-- ==========================================
(
    1010,
    5005,
    '192.168.1.50',
    'firewall',
    'old-device-001',  -- 用于测试 updateDeviceIpAndId
    '192.0.2.150',
    '192.168.60.50',
    '设备迁移前的封堵记录',
    'manual',
    1,
    'Firewall-02',
    CURRENT_TIMESTAMP - INTERVAL '2 days',
    CURRENT_TIMESTAMP - INTERVAL '2 days'
);

-- 重置序列
SELECT setval('"t_block_history_id_seq"', 1010, true);

-- ==========================================
-- 验证：按策略ID统计
-- ==========================================
SELECT 
    strategy_id AS "策略ID",
    COUNT(*) AS "记录数",
    SUM(launch_times) AS "总下发次数"
FROM "t_block_history"
WHERE id >= 1001 AND id <= 1010
GROUP BY strategy_id
ORDER BY strategy_id;

-- ==========================================
-- 验证：查看所有测试数据
-- ==========================================
SELECT 
    id AS "ID",
    strategy_id AS "策略ID",
    link_device_ip AS "设备IP",
    link_device_type AS "设备类型",
    src_address AS "源地址",
    dest_address AS "目标地址",
    launch_times AS "下发次数",
    create_type AS "创建方式",
    LEFT(content, 30) AS "内容摘要"
FROM "t_block_history"
WHERE id >= 1001 AND id <= 1010
ORDER BY id;

-- ==========================================
-- 测试查询：模拟 Controller 中的查询
-- ==========================================

-- 测试1：按策略ID汇总（应该返回5个策略的统计）
SELECT '测试1：按策略ID汇总' AS test;
SELECT strategy_id, SUM(launch_times) as total_launch_times
FROM t_block_history
WHERE strategy_id IN (5001, 5002, 5003, 5004, 5005)
GROUP BY strategy_id;

-- 测试5：按IP查询（应该返回多条）
SELECT '测试5：按IP查询' AS test;
SELECT id, link_device_ip, src_address, dest_address
FROM t_block_history
WHERE link_device_ip = '192.168.1.10'
  AND src_address = '203.0.113.100'
  AND dest_address = '192.168.10.50';

-- 测试6：按条件查询（应该返回策略5001的所有记录）
SELECT '测试6：按条件查询' AS test;
SELECT COUNT(*) as count
FROM t_block_history
WHERE strategy_id = 5001 AND link_device_ip = '192.168.1.10';

-- 测试7：按策略ID查询（应该返回策略5001的所有记录）
SELECT '测试7：按策略ID查询' AS test;
SELECT id, src_address, dest_address, launch_times
FROM t_block_history
WHERE strategy_id = 5001;

-- 测试8：按ID列表查询
SELECT '测试8：按ID列表查询' AS test;
SELECT id, strategy_id, link_device_ip
FROM t_block_history
WHERE id IN (1001, 1002, 1003);

-- 测试11：按策略ID查询ID列表
SELECT '测试11：按策略ID查询ID列表' AS test;
SELECT id FROM t_block_history WHERE strategy_id = 5001;

-- ==========================================
-- 数据说明
-- ==========================================
-- 策略5001：4条记录（1001, 1002, 1005, 1008），设备IP主要是 192.168.1.10
-- 策略5002：2条记录（1003, 1006），设备IP是 192.168.1.20
-- 策略5003：2条记录（1004, 1007），设备IP分别是 192.168.1.30 和 192.168.1.100
-- 策略5004：1条记录（1009），设备IP是 192.168.1.40
-- 策略5005：1条记录（1010），设备IP是 192.168.1.50，device_id='old-device-001'用于测试更新
