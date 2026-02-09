/*
 * Table: service_version
 * Generated: 2026-02-09 14:43:04
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "service_version_id_seq";
CREATE SEQUENCE "service_version_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "service_version_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "service_version";

CREATE TABLE "service_version" (
                                   "id" int8 NOT NULL DEFAULT nextval('service_version_id_seq'::regclass),
                                   "service" varchar(45) COLLATE "pg_catalog"."default" NOT NULL,
                                   "version" varchar(45) COLLATE "pg_catalog"."default" NOT NULL
)
;

ALTER TABLE "service_version" OWNER TO "dbapp";

COMMENT ON TABLE "service_version" IS '服务版本注册';

BEGIN;
COMMIT;

ALTER TABLE "service_version" ADD CONSTRAINT "idx_91830_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_91830_service_unique" ON "service_version" USING btree (
    "service" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
