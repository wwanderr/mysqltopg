/*
 * Table: t_bs_extension_info
 * Generated: 2026-02-09 14:05:57
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_bs_extension_info";

CREATE TABLE "t_bs_extension_info" (
                                       "id" int8 NOT NULL DEFAULT nextval('t_bs_extension_info_id_seq'::regclass),
                                       "code" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                       "name" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                       "description" varchar(4096) COLLATE "pg_catalog"."default",
                                       "install_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                       "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                       "version" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                       "docker_id" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                       "deploy_path" varchar(1024) COLLATE "pg_catalog"."default" NOT NULL,
                                       "main_class" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                       "status" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                       "meta_info" text COLLATE "pg_catalog"."default",
                                       "is_success" bool NOT NULL,
                                       "result" text COLLATE "pg_catalog"."default",
                                       "preinstall" bool NOT NULL,
                                       "port" int8 NOT NULL,
                                       "authorization" int8 DEFAULT '1'::bigint,
                                       "modify_time" timestamp
)
;

ALTER TABLE "t_bs_extension_info" OWNER TO "dbapp";

COMMENT ON COLUMN "t_bs_extension_info"."id" IS '主键';

COMMENT ON COLUMN "t_bs_extension_info"."code" IS 'Extension英文名';

COMMENT ON COLUMN "t_bs_extension_info"."name" IS 'Extension中文名';

COMMENT ON COLUMN "t_bs_extension_info"."description" IS 'Extension描述';

COMMENT ON COLUMN "t_bs_extension_info"."install_time" IS '首次安装时间';

COMMENT ON COLUMN "t_bs_extension_info"."update_time" IS '最近一次更新时间';

COMMENT ON COLUMN "t_bs_extension_info"."version" IS '当前版本';

COMMENT ON COLUMN "t_bs_extension_info"."docker_id" IS '部署容器id';

COMMENT ON COLUMN "t_bs_extension_info"."deploy_path" IS '部署路径';

COMMENT ON COLUMN "t_bs_extension_info"."main_class" IS '启动类';

COMMENT ON COLUMN "t_bs_extension_info"."status" IS '状态，running:运行中，stopped:已停用，installing:安装中，restarting:重启中，uninstalling:卸载中，starting:启动中，stopping:停用中，failure:操作失败';

COMMENT ON COLUMN "t_bs_extension_info"."meta_info" IS '其他元数据，json格式存储';

COMMENT ON COLUMN "t_bs_extension_info"."is_success" IS '最后一次操作结果';

COMMENT ON COLUMN "t_bs_extension_info"."result" IS '最后一次操作结果描述';

COMMENT ON COLUMN "t_bs_extension_info"."preinstall" IS '是否为内置拓展';

COMMENT ON COLUMN "t_bs_extension_info"."port" IS '拓展程序服务端口号';

COMMENT ON COLUMN "t_bs_extension_info"."authorization" IS '授权：默认全授权1，未授权0';

COMMENT ON COLUMN "t_bs_extension_info"."modify_time" IS '数据更新时间';

COMMENT ON TABLE "t_bs_extension_info" IS 'Extension基本信息';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_bs_extension_info_id_seq";
CREATE SEQUENCE "t_bs_extension_info_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_bs_extension_info_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_bs_extension_info"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_bs_extension_info"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.modify_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_bs_extension_info"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_bs_extension_info"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_bs_extension_info"();

ALTER TABLE "t_bs_extension_info" ADD CONSTRAINT "idx_92148_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_92148_t_bs_extension_info_un" ON "t_bs_extension_info" USING btree (
    "code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
