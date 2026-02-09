/*
 * Table: t_asset
 * Generated: 2026-02-09 14:43:05
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_asset_id_seq";
CREATE SEQUENCE "t_asset_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_asset_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_asset";

CREATE TABLE "t_asset" (
                           "id" int8 NOT NULL DEFAULT nextval('t_asset_id_seq'::regclass),
                           "asset_name" varchar(100) COLLATE "pg_catalog"."default",
                           "asset_ips" varchar(2000) COLLATE "pg_catalog"."default",
                           "asset_type" varchar(45) COLLATE "pg_catalog"."default",
                           "extra" varchar(2000) COLLATE "pg_catalog"."default",
                           "create_time" timestamp,
                           "update_time" timestamp,
                           "area" varchar(100) COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_asset" OWNER TO "dbapp";

COMMENT ON COLUMN "t_asset"."asset_name" IS '资产名称';

COMMENT ON COLUMN "t_asset"."asset_ips" IS '资产ip，可填多个，逗号分隔';

COMMENT ON COLUMN "t_asset"."area" IS '所属地区';

BEGIN;
COMMIT;

ALTER TABLE "t_asset" ADD CONSTRAINT "idx_91910_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_91910_index_name" ON "t_asset" USING btree (
    "asset_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
