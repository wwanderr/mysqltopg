-- 测试数据：AttackKnowledge（攻击知识库）
DELETE FROM "t_attack_knowledge" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_attack_knowledge" ("id", "attack_name", "attack_type", "attack_desc", "attack_indicators", "defense_suggestions", "severity", "reference_links", "create_time", "update_time") VALUES 
(1001, 'Log4Shell远程代码执行', 'RCE', 'Apache Log4j2 JNDI注入漏洞，可导致远程代码执行', '{"indicators": ["${jndi:", "ldap://", "rmi://"]}', '升级Log4j至2.17.1或更高版本，或禁用JNDI lookup功能', 'critical', '["https://nvd.nist.gov/vuln/detail/CVE-2021-44228"]', CURRENT_TIMESTAMP - INTERVAL '120 days', CURRENT_TIMESTAMP - INTERVAL '30 days'),
(1002, 'WannaCry勒索软件', 'Ransomware', '利用EternalBlue漏洞传播的勒索软件', '{"indicators": ["ms17-010", ".WNCRY", "@WanaDecryptor@.exe"]}', '安装MS17-010补丁，关闭445端口，定期备份', 'critical', '["https://en.wikipedia.org/wiki/WannaCry_ransomware_attack"]', CURRENT_TIMESTAMP - INTERVAL '365 days', CURRENT_TIMESTAMP - INTERVAL '180 days'),
(1003, 'SQL注入攻击', 'Injection', '通过SQL语句注入恶意代码', '{"indicators": ["union select", "or 1=1", "drop table"]}', '使用参数化查询，输入验证，最小权限原则', 'high', '["https://owasp.org/www-community/attacks/SQL_Injection"]', CURRENT_TIMESTAMP - INTERVAL '200 days', CURRENT_TIMESTAMP - INTERVAL '60 days');

SELECT setval('"t_attack_knowledge_id_seq"', 1003, true);
