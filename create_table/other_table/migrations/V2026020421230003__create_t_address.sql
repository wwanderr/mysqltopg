/*
 * Table: t_address
 * Generated: 2026-02-09 13:48:06
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_address";

CREATE TABLE "t_address" (
                             "ip_object_id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                             "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                             "description" text COLLATE "pg_catalog"."default",
                             "tenant_id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                             "ip_type" varchar(4) COLLATE "pg_catalog"."default" NOT NULL
)
;

ALTER TABLE "t_address" OWNER TO "dbapp";

COMMENT ON COLUMN "t_address"."ip_object_id" IS 'IP对象ID，主键';

COMMENT ON COLUMN "t_address"."name" IS '对象名称';

COMMENT ON COLUMN "t_address"."description" IS '对象描述';

COMMENT ON COLUMN "t_address"."tenant_id" IS '租户对象ID';

COMMENT ON COLUMN "t_address"."ip_type" IS 'IPv4/IPv6';

COMMENT ON TABLE "t_address" IS 'STY电信接口规范IP地址对象表';

BEGIN;
COMMIT;

ALTER TABLE "t_address" ADD CONSTRAINT "idx_91834_primary" PRIMARY KEY ("ip_object_id");
