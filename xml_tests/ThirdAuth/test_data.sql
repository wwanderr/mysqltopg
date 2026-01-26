-- 测试数据：ThirdAuth（第三方认证）
DELETE FROM "t_third_auth" WHERE id >= 1001 AND id <= 1003;

INSERT INTO "t_third_auth" (
    "id", "auth_type", "auth_name", "auth_url", "app_id", "app_secret", "is_enable", "config", "create_time"
) VALUES 
(1001, 'ldap', '企业LDAP认证', 'ldap://192.168.1.100:389', 'dc=company,dc=com', 'encrypted_secret', true, '{"base_dn": "ou=users,dc=company,dc=com"}', CURRENT_TIMESTAMP - INTERVAL '180 days'),
(1002, 'cas', 'CAS单点登录', 'https://cas.company.com', 'xdr_app', 'encrypted_secret', true, '{"callback_url": "https://xdr.company.com/cas/callback"}', CURRENT_TIMESTAMP - INTERVAL '90 days'),
(1003, 'oauth2', 'OAuth2认证（测试）', 'https://oauth.test.com', 'test_client_id', 'test_secret', false, '{"redirect_uri": "https://xdr.test.com/oauth/callback"}', CURRENT_TIMESTAMP - INTERVAL '30 days');

SELECT setval('"t_third_auth_id_seq"', 1003, true);
