/*
 * Table: t_bs_extension_history
 * Generated: 2026-02-09 13:48:07
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_bs_extension_history";

CREATE TABLE "t_bs_extension_history" (
                                          "id" int8 NOT NULL DEFAULT nextval('t_bs_extension_history_id_seq'::regclass),
                                          "code" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                          "name" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                          "last_version" varchar(100) COLLATE "pg_catalog"."default",
                                          "version" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                          "operate_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                          "operate_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
                                          "is_success" bool NOT NULL,
                                          "result" text COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_bs_extension_history" OWNER TO "dbapp";

COMMENT ON COLUMN "t_bs_extension_history"."id" IS '主键';

COMMENT ON COLUMN "t_bs_extension_history"."code" IS 'Extension英文名';

COMMENT ON COLUMN "t_bs_extension_history"."name" IS 'Extension中文名';

COMMENT ON COLUMN "t_bs_extension_history"."last_version" IS '历史版本';

COMMENT ON COLUMN "t_bs_extension_history"."version" IS '操作时版本';

COMMENT ON COLUMN "t_bs_extension_history"."operate_time" IS '操作时间';

COMMENT ON COLUMN "t_bs_extension_history"."operate_type" IS '操作类型，install:安装,upgrade:升级,uninstall:卸载';

COMMENT ON COLUMN "t_bs_extension_history"."is_success" IS '操作是否成功';

COMMENT ON COLUMN "t_bs_extension_history"."result" IS '操作结果信息';

COMMENT ON TABLE "t_bs_extension_history" IS 'Extension安装升级历史记录';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_bs_extension_history_id_seq";
CREATE SEQUENCE "t_bs_extension_history_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_bs_extension_history_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_bs_extension_history" ADD CONSTRAINT "idx_92140_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_92140_t_bs_extension_history_fk" ON "t_bs_extension_history" USING btree (
    "code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
