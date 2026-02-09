/*
 * Table: t_sev_agent_package
 * Generated: 2026-02-09 14:43:08
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_sev_agent_package_id_seq";
CREATE SEQUENCE "t_sev_agent_package_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_sev_agent_package_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_sev_agent_package";

CREATE TABLE "t_sev_agent_package" (
                                       "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_package_id_seq'::regclass),
                                       "agent_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
                                       "package_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
                                       "package_version" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                       "depend_software" varchar(100) COLLATE "pg_catalog"."default",
                                       "file_uuid" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                       "file_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                       "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                       "update_time" timestamp,
                                       "upload_type" varchar(32) COLLATE "pg_catalog"."default",
                                       "file_size" int8 NOT NULL
)
;

ALTER TABLE "t_sev_agent_package" OWNER TO "dbapp";

COMMENT ON COLUMN "t_sev_agent_package"."id" IS '主键';

COMMENT ON COLUMN "t_sev_agent_package"."agent_type" IS 'agent类型（AiNTA、APT、SOC）';

COMMENT ON COLUMN "t_sev_agent_package"."package_type" IS '升级包类型（software、rule、intelligence）';

COMMENT ON COLUMN "t_sev_agent_package"."package_version" IS '版本号';

COMMENT ON COLUMN "t_sev_agent_package"."depend_software" IS '依赖软件版本';

COMMENT ON COLUMN "t_sev_agent_package"."file_uuid" IS '升级包文件uuid';

COMMENT ON COLUMN "t_sev_agent_package"."file_name" IS '升级包文件名';

COMMENT ON COLUMN "t_sev_agent_package"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_sev_agent_package"."update_time" IS '更新时间';

COMMENT ON COLUMN "t_sev_agent_package"."upload_type" IS '上传方式';

COMMENT ON COLUMN "t_sev_agent_package"."file_size" IS '文件大小';

COMMENT ON TABLE "t_sev_agent_package" IS '探针升级包信息表';

BEGIN;
COMMIT;

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_sev_agent_package"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_sev_agent_package"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_sev_agent_package"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_sev_agent_package"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_sev_agent_package"();

ALTER TABLE "t_sev_agent_package" ADD CONSTRAINT "idx_93025_primary" PRIMARY KEY ("id");

ALTER TABLE "t_sev_agent_package" ADD CONSTRAINT "t_agent_package_fk" FOREIGN KEY ("agent_type") REFERENCES "t_sev_agent_type" ("agent_type") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "t_sev_agent_package" ADD CONSTRAINT "t_agent_package_fk_1" FOREIGN KEY ("file_uuid") REFERENCES "t_bs_files" ("uuid") ON DELETE RESTRICT ON UPDATE RESTRICT;

CREATE INDEX "idx_93025_t_agent_package_fk" ON "t_sev_agent_package" USING btree (
    "agent_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_93025_t_agent_package_fk_1" ON "t_sev_agent_package" USING btree (
    "file_uuid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
