/*
 * Table: t_data_dict
 * Generated: 2026-02-09 13:48:07
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_data_dict";

CREATE TABLE "t_data_dict" (
                               "id" int8 NOT NULL DEFAULT nextval('t_data_dict_id_seq'::regclass),
                               "type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
                               "label" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
                               "isdel" int2 NOT NULL DEFAULT '1'::smallint,
                               "createuser" int8 NOT NULL,
                               "createtime" timestamp NOT NULL,
                               "updateuser" int8 NOT NULL,
                               "updatetime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_data_dict" OWNER TO "dbapp";

COMMENT ON COLUMN "t_data_dict"."type" IS '类型';

COMMENT ON COLUMN "t_data_dict"."label" IS '显示值';

COMMENT ON COLUMN "t_data_dict"."isdel" IS '0:删除；1:正常';

COMMENT ON COLUMN "t_data_dict"."createuser" IS '创建人';

COMMENT ON COLUMN "t_data_dict"."createtime" IS '创建时间';

COMMENT ON COLUMN "t_data_dict"."updateuser" IS '修改人';

COMMENT ON COLUMN "t_data_dict"."updatetime" IS '修改时间';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_data_dict_id_seq";
CREATE SEQUENCE "t_data_dict_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_data_dict_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_data_dict" ADD CONSTRAINT "idx_92243_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_92243_idx_dict_type" ON "t_data_dict" USING btree (
    "type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
