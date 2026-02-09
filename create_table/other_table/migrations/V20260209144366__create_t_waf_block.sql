/*
 * Table: t_waf_block
 * Generated: 2026-02-09 14:43:09
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_waf_block_id_seq";
CREATE SEQUENCE "t_waf_block_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_waf_block_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_waf_block";

CREATE TABLE "t_waf_block" (
                               "id" int8 NOT NULL DEFAULT nextval('t_waf_block_id_seq'::regclass),
                               "srcaddress" varchar(45) COLLATE "pg_catalog"."default",
                               "waf_ips" varchar(10000) COLLATE "pg_catalog"."default",
                               "uuids" varchar(10000) COLLATE "pg_catalog"."default",
                               "status" int4,
                               "create_time" timestamp,
                               "update_time" timestamp
)
;

ALTER TABLE "t_waf_block" OWNER TO "dbapp";

COMMENT ON COLUMN "t_waf_block"."waf_ips" IS '同步到waf的设备ip';

BEGIN;
COMMIT;

ALTER TABLE "t_waf_block" ADD CONSTRAINT "idx_93307_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_93307_src_address_unique" ON "t_waf_block" USING btree (
    "srcaddress" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
