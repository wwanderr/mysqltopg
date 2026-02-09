/*
 * Table: t_web_asset
 * Generated: 2026-02-09 14:06:01
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_web_asset";

CREATE TABLE "t_web_asset" (
                               "id" int8 NOT NULL DEFAULT nextval('t_web_asset_id_seq'::regclass),
                               "web" int8,
                               "asset" int8,
                               "type" varchar(45) COLLATE "pg_catalog"."default",
                               "createtime" timestamp DEFAULT CURRENT_TIMESTAMP,
                               "updatetime" timestamp DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_web_asset" OWNER TO "dbapp";

COMMENT ON COLUMN "t_web_asset"."type" IS '资产关联类型';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_web_asset_id_seq";
CREATE SEQUENCE "t_web_asset_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_web_asset_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_web_asset" ADD CONSTRAINT "idx_93338_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_93338_idx_asset" ON "t_web_asset" USING btree (
    "asset" "pg_catalog"."int8_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_93338_idx_web" ON "t_web_asset" USING btree (
    "web" "pg_catalog"."int8_ops" ASC NULLS LAST
    );
