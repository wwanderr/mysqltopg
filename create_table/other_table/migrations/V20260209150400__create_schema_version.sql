/*
 * Table: schema_version
 * Generated: 2026-02-09 15:04:32
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "schema_version";

CREATE TABLE "schema_version" (
                                  "installed_rank" int8 NOT NULL,
                                  "version" varchar(50) COLLATE "pg_catalog"."default",
                                  "description" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
                                  "type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
                                  "script" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
                                  "checksum" int8,
                                  "installed_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                  "installed_on" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  "execution_time" int8 NOT NULL,
                                  "success" bool NOT NULL
)
;

ALTER TABLE "schema_version" OWNER TO "dbapp";

ALTER TABLE "schema_version" ADD CONSTRAINT "idx_91777_primary" PRIMARY KEY ("installed_rank");

CREATE INDEX "idx_91777_schema_version_s_idx" ON "schema_version" USING btree (
    "success" "pg_catalog"."bool_ops" ASC NULLS LAST
    );
