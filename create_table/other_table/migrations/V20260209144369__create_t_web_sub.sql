/*
 * Table: t_web_sub
 * Generated: 2026-02-09 14:43:09
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_web_sub_id_seq";
CREATE SEQUENCE "t_web_sub_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_web_sub_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_web_sub";

CREATE TABLE "t_web_sub" (
                             "id" int8 NOT NULL DEFAULT nextval('t_web_sub_id_seq'::regclass),
                             "web" int8 NOT NULL,
                             "subdomain" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                             "createtime" timestamp DEFAULT CURRENT_TIMESTAMP,
                             "updatetime" timestamp DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_web_sub" OWNER TO "dbapp";

COMMENT ON COLUMN "t_web_sub"."web" IS '域名id';

COMMENT ON COLUMN "t_web_sub"."subdomain" IS '子域名';

BEGIN;
COMMIT;

ALTER TABLE "t_web_sub" ADD CONSTRAINT "idx_93383_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_93383_subdomain_unique" ON "t_web_sub" USING btree (
    "subdomain" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
