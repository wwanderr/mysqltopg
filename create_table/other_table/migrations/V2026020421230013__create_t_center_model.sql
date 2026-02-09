/*
 * Table: t_center_model
 * Generated: 2026-02-09 13:48:07
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_center_model";

CREATE TABLE "t_center_model" (
                                  "id" int8 NOT NULL DEFAULT nextval('t_center_model_id_seq'::regclass),
                                  "pid" int8 NOT NULL,
                                  "model" varchar(45) COLLATE "pg_catalog"."default" NOT NULL,
                                  "authorization" int8 NOT NULL DEFAULT '1'::bigint,
                                  "describe" varchar(500) COLLATE "pg_catalog"."default",
                                  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  "model_id" varchar(45) COLLATE "pg_catalog"."default" NOT NULL,
                                  "optional" int8 NOT NULL DEFAULT '0'::bigint,
                                  "version" varchar(45) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'v3.4'::character varying
)
;

ALTER TABLE "t_center_model" OWNER TO "dbapp";

COMMENT ON COLUMN "t_center_model"."pid" IS '产品的id';

COMMENT ON COLUMN "t_center_model"."model" IS '最新产品的模块名称';

COMMENT ON COLUMN "t_center_model"."authorization" IS '授权：1包含；0不包含';

COMMENT ON COLUMN "t_center_model"."model_id" IS '模块id和平台保持一致。';

COMMENT ON COLUMN "t_center_model"."optional" IS '是否可选：0不可选，1可选';

DROP SEQUENCE IF EXISTS "t_center_model_id_seq";
CREATE SEQUENCE "t_center_model_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_center_model_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_center_model" ADD CONSTRAINT "idx_92192_primary" PRIMARY KEY ("id", "pid");

CREATE UNIQUE INDEX "idx_92192_name_unique" ON "t_center_model" USING btree (
    "model" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
