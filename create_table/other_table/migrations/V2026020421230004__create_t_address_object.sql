/*
 * Table: t_address_object
 * Generated: 2026-02-09 13:48:06
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_address_object";

CREATE TABLE "t_address_object" (
                                    "id" int8 NOT NULL DEFAULT nextval('t_address_object_id_seq'::regclass),
                                    "ip_object_id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                                    "protect_type" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
                                    "address_type" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
                                    "address_value" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                                    "address_start" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
                                    "address_end" varchar(32) COLLATE "pg_catalog"."default" NOT NULL
)
;

ALTER TABLE "t_address_object" OWNER TO "dbapp";

COMMENT ON COLUMN "t_address_object"."id" IS '主键ID';

COMMENT ON COLUMN "t_address_object"."ip_object_id" IS 'IP对象ID，外键';

COMMENT ON COLUMN "t_address_object"."protect_type" IS '防护类型，protect：防护对象；except：除外对象';

COMMENT ON COLUMN "t_address_object"."address_type" IS '地址类型：network, range, host';

COMMENT ON COLUMN "t_address_object"."address_value" IS '对象具体值，根据address_type区分';

COMMENT ON COLUMN "t_address_object"."address_start" IS '地址范围起始';

COMMENT ON COLUMN "t_address_object"."address_end" IS '地址范围终止';

COMMENT ON TABLE "t_address_object" IS 'STY电信接口规范IP地址表';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_address_object_id_seq";
CREATE SEQUENCE "t_address_object_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_address_object_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_address_object" ADD CONSTRAINT "idx_91840_primary" PRIMARY KEY ("id");
