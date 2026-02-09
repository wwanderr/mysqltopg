/*
 * Table: t_ui_license
 * Generated: 2026-02-09 15:04:39
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_ui_license";

CREATE TABLE "t_ui_license" (
                                "license" varchar(96) COLLATE "pg_catalog"."default" NOT NULL,
                                "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                "valid" int2 NOT NULL DEFAULT '1'::smallint
)
;

ALTER TABLE "t_ui_license" OWNER TO "dbapp";

COMMENT ON COLUMN "t_ui_license"."valid" IS '1有效，0失效';

BEGIN;
COMMIT;

ALTER TABLE "t_ui_license" ADD CONSTRAINT "idx_93216_primary" PRIMARY KEY ("license");

CREATE UNIQUE INDEX "idx_93216_id_unique" ON "t_ui_license" USING btree (
    "license" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
