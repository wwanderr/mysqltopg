/*
 * Table: sequence
 * Generated: 2026-02-09 15:04:32
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "sequence";

CREATE TABLE "sequence" (
                            "seq" int8 NOT NULL
)
;

ALTER TABLE "sequence" OWNER TO "dbapp";

COMMENT ON COLUMN "sequence"."seq" IS '序号';

COMMENT ON TABLE "sequence" IS '序号辅助表';

ALTER TABLE "sequence" ADD CONSTRAINT "idx_91826_primary" PRIMARY KEY ("seq");
