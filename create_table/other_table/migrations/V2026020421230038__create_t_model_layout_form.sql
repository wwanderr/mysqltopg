/*
 * Table: t_model_layout_form
 * Generated: 2026-02-09 13:48:09
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_model_layout_form";

CREATE TABLE "t_model_layout_form" (
                                       "id" int8 NOT NULL DEFAULT nextval('t_model_layout_form_id_seq'::regclass),
                                       "detailjsonstr" text COLLATE "pg_catalog"."default",
                                       "layout_id" varchar(255) COLLATE "pg_catalog"."default",
                                       "model_id" varchar(20) COLLATE "pg_catalog"."default",
                                       "isneedsearch" int2
)
;

ALTER TABLE "t_model_layout_form" OWNER TO "dbapp";

COMMENT ON COLUMN "t_model_layout_form"."detailjsonstr" IS '任务详情';

COMMENT ON COLUMN "t_model_layout_form"."layout_id" IS '剧本Id';

COMMENT ON COLUMN "t_model_layout_form"."model_id" IS '模型Id';

COMMENT ON COLUMN "t_model_layout_form"."isneedsearch" IS '是否需要模型溯源';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_model_layout_form_id_seq";
CREATE SEQUENCE "t_model_layout_form_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_model_layout_form_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_model_layout_form" ADD CONSTRAINT "idx_92565_primary" PRIMARY KEY ("id");
