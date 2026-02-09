/*
 * Table: t_component_update_record
 * Generated: 2026-02-09 13:48:07
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_component_update_record";

CREATE TABLE "t_component_update_record" (
                                             "id" int8 NOT NULL DEFAULT nextval('t_component_update_record_id_seq'::regclass),
                                             "version" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                             "package_type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
                                             "file_name" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                             "success" bool NOT NULL,
                                             "error_message" text COLLATE "pg_catalog"."default",
                                             "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                             "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_component_update_record" OWNER TO "dbapp";

COMMENT ON COLUMN "t_component_update_record"."id" IS '主键ID';

COMMENT ON COLUMN "t_component_update_record"."version" IS 'mirror版本信息';

COMMENT ON COLUMN "t_component_update_record"."package_type" IS '升级包类型';

COMMENT ON COLUMN "t_component_update_record"."file_name" IS '升级包文件名';

COMMENT ON COLUMN "t_component_update_record"."success" IS '是否升级成功';

COMMENT ON COLUMN "t_component_update_record"."error_message" IS '错误信息';

COMMENT ON TABLE "t_component_update_record" IS '组件升级记录表';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_component_update_record_id_seq";
CREATE SEQUENCE "t_component_update_record_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_component_update_record_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_component_update_record" ADD CONSTRAINT "idx_92222_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_92222_unique_version_package_type_file_name" ON "t_component_update_record" USING btree (
    "version" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "package_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "file_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
