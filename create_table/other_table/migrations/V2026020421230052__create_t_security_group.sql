/*
 * Table: t_security_group
 * Generated: 2026-02-09 13:48:10
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_security_group";

CREATE TABLE "t_security_group" (
                                    "id" int8 NOT NULL DEFAULT nextval('t_security_group_id_seq'::regclass),
                                    "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                    "customer_ids" text COLLATE "pg_catalog"."default",
                                    "customer_names" text COLLATE "pg_catalog"."default",
                                    "save_time" timestamp
)
;

ALTER TABLE "t_security_group" OWNER TO "dbapp";

COMMENT ON COLUMN "t_security_group"."id" IS '主键';

COMMENT ON COLUMN "t_security_group"."name" IS '安全域名称';

COMMENT ON COLUMN "t_security_group"."customer_ids" IS '资产组id列表';

COMMENT ON COLUMN "t_security_group"."customer_names" IS '资产组name列表';

COMMENT ON COLUMN "t_security_group"."save_time" IS '保存时间';

DROP SEQUENCE IF EXISTS "t_security_group_id_seq";
CREATE SEQUENCE "t_security_group_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_security_group_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_security_group" ADD CONSTRAINT "idx_92957_primary" PRIMARY KEY ("id");
