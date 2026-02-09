/*
 * Table: t_waf
 * Generated: 2026-02-09 14:43:09
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_waf_id_seq";
CREATE SEQUENCE "t_waf_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_waf_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_waf";

CREATE TABLE "t_waf" (
                         "id" int8 NOT NULL DEFAULT nextval('t_waf_id_seq'::regclass),
                         "ip" varchar(45) COLLATE "pg_catalog"."default",
                         "port" varchar(45) COLLATE "pg_catalog"."default",
                         "status" varchar(45) COLLATE "pg_catalog"."default",
                         "create_time" timestamp,
                         "update_time" timestamp
)
;

ALTER TABLE "t_waf" OWNER TO "dbapp";

COMMENT ON COLUMN "t_waf"."ip" IS 'waf地址';

COMMENT ON COLUMN "t_waf"."port" IS '接口开放端口';

COMMENT ON COLUMN "t_waf"."status" IS '状态';

COMMENT ON COLUMN "t_waf"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_waf"."update_time" IS '更新时间';

BEGIN;
COMMIT;

ALTER TABLE "t_waf" ADD CONSTRAINT "idx_93302_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_93302_unique_ip_port" ON "t_waf" USING btree (
    "ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "port" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
