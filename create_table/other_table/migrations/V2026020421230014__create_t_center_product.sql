/*
 * Table: t_center_product
 * Generated: 2026-02-09 13:48:07
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_center_product";

CREATE TABLE "t_center_product" (
                                    "id" int8 NOT NULL DEFAULT nextval('t_center_product_id_seq'::regclass),
                                    "name" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
                                    "type" int8 NOT NULL DEFAULT '1'::bigint,
                                    "describe" varchar(500) COLLATE "pg_catalog"."default",
                                    "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    "stats" int8 NOT NULL DEFAULT '0'::bigint
)
;

ALTER TABLE "t_center_product" OWNER TO "dbapp";

COMMENT ON COLUMN "t_center_product"."name" IS '产品名称';

COMMENT ON COLUMN "t_center_product"."type" IS '产品类型:平台0，APP1';

COMMENT ON COLUMN "t_center_product"."stats" IS '状态：1可用；0不可用';

DROP SEQUENCE IF EXISTS "t_center_product_id_seq";
CREATE SEQUENCE "t_center_product_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_center_product_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_center_product" ADD CONSTRAINT "idx_92204_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_92204_name_unique" ON "t_center_product" USING btree (
    "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
