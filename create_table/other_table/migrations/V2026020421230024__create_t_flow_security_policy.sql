/*
 * Table: t_flow_security_policy
 * Generated: 2026-02-09 13:48:08
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_flow_security_policy";

CREATE TABLE "t_flow_security_policy" (
                                          "security_policy_id" bytea NOT NULL,
                                          "tenant_id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                                          "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                          "description" text COLLATE "pg_catalog"."default",
                                          "priority" bool,
                                          "src_zone" varchar(64) COLLATE "pg_catalog"."default",
                                          "dst_zone" varchar(64) COLLATE "pg_catalog"."default",
                                          "protocol" bool,
                                          "src_address" text COLLATE "pg_catalog"."default" NOT NULL,
                                          "dst_address" text COLLATE "pg_catalog"."default" NOT NULL,
                                          "service_items" text COLLATE "pg_catalog"."default",
                                          "time_items" text COLLATE "pg_catalog"."default" NOT NULL,
                                          "app_items" text COLLATE "pg_catalog"."default",
                                          "url_items" text COLLATE "pg_catalog"."default",
                                          "action" bool NOT NULL,
                                          "logging" bool NOT NULL,
                                          "enable" bool NOT NULL
)
;

ALTER TABLE "t_flow_security_policy" OWNER TO "dbapp";

COMMENT ON COLUMN "t_flow_security_policy"."security_policy_id" IS '安全策略id';

COMMENT ON COLUMN "t_flow_security_policy"."tenant_id" IS '租户ID';

COMMENT ON COLUMN "t_flow_security_policy"."name" IS '策略名称';

COMMENT ON COLUMN "t_flow_security_policy"."description" IS '策略描述';

COMMENT ON COLUMN "t_flow_security_policy"."priority" IS '安全策略优先级序号（租户级），1为最上/优先策略（AXDR目前没有策略优先级，仅存储）';

COMMENT ON COLUMN "t_flow_security_policy"."src_zone" IS '源区域（AXDR仅存储）';

COMMENT ON COLUMN "t_flow_security_policy"."dst_zone" IS '目的区域（AXDR仅存储）';

COMMENT ON COLUMN "t_flow_security_policy"."protocol" IS '协议类型，0: ipv4, 1: ipv6（AXDR目前仅支持IPv4）';

COMMENT ON COLUMN "t_flow_security_policy"."src_address" IS '源地址对象，支持ip_object_id或ip_group_object_id，上限为1000个';

COMMENT ON COLUMN "t_flow_security_policy"."dst_address" IS '目的地址，支持ip_object_id或ip_group_object_id，上限为1000个';

COMMENT ON COLUMN "t_flow_security_policy"."service_items" IS '服务对象，service_object_id或service_group_object_id（AXDR仅存储）';

COMMENT ON COLUMN "t_flow_security_policy"."time_items" IS '时间对象，time_object_id，默认为[”any”]（AXDR仅支持”any”--永久策略）';

COMMENT ON COLUMN "t_flow_security_policy"."app_items" IS '应用对象，app_object_id（AXDR仅存储）';

COMMENT ON COLUMN "t_flow_security_policy"."url_items" IS 'URL对象，url_object_id（AXDR仅存储）';

COMMENT ON COLUMN "t_flow_security_policy"."action" IS '动作，0:deny,1:allow（AXDR仅支持"deny"--封禁）';

COMMENT ON COLUMN "t_flow_security_policy"."logging" IS '是否开启日志记录，0:不启用，1:启用（AXDR不支持，仅存储）';

COMMENT ON COLUMN "t_flow_security_policy"."enable" IS '是否启用，0:不启用，1:启用（AXDR仅存储）';

COMMENT ON TABLE "t_flow_security_policy" IS 'STY电信接口规范安全策略表';

BEGIN;
COMMIT;

ALTER TABLE "t_flow_security_policy" ADD CONSTRAINT "idx_92356_primary" PRIMARY KEY ("security_policy_id");
