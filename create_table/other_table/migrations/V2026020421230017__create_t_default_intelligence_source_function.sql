/*
 * Table: t_default_intelligence_source_function
 * Generated: 2026-02-09 13:48:07
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_default_intelligence_source_function";

CREATE TABLE "t_default_intelligence_source_function" (
                                                          "id" int8 NOT NULL DEFAULT nextval('t_default_intelligence_source_function_id_seq'::regclass),
                                                          "intelligence_source_code" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                                          "function" "t_default_intelligence_source_function_function" NOT NULL,
                                                          "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                                          "type" "t_default_intelligence_source_function_type" NOT NULL,
                                                          "enable" int2 NOT NULL DEFAULT '1'::smallint,
                                                          "description" varchar(4096) COLLATE "pg_catalog"."default",
                                                          "config" text COLLATE "pg_catalog"."default",
                                                          "operations" text COLLATE "pg_catalog"."default",
                                                          "order" int2 NOT NULL,
                                                          "display" int2 NOT NULL DEFAULT '1'::smallint
)
;

ALTER TABLE "t_default_intelligence_source_function" OWNER TO "dbapp";

COMMENT ON COLUMN "t_default_intelligence_source_function"."id" IS '情报源功能ID';

COMMENT ON COLUMN "t_default_intelligence_source_function"."intelligence_source_code" IS '情报源英文标识';

COMMENT ON COLUMN "t_default_intelligence_source_function"."function" IS '情报源功能';

COMMENT ON COLUMN "t_default_intelligence_source_function"."name" IS '情报源功能名称';

COMMENT ON COLUMN "t_default_intelligence_source_function"."type" IS '情报源功能类型：tab-标签页(情报数据更新、导出等操作需要另起tab页)；button-按钮(情报源自身操作，设置、管理、移除、克隆)；operate-操作(情报操作，增删改查等)';

COMMENT ON COLUMN "t_default_intelligence_source_function"."enable" IS '情报源功能启禁用';

COMMENT ON COLUMN "t_default_intelligence_source_function"."description" IS '情报源功能描述';

COMMENT ON COLUMN "t_default_intelligence_source_function"."config" IS '情报源功能配置，JSONObject格式';

COMMENT ON COLUMN "t_default_intelligence_source_function"."operations" IS '情报源功能包含的操作、按钮等，JSONArray格式';

COMMENT ON COLUMN "t_default_intelligence_source_function"."order" IS '功能顺序';

COMMENT ON COLUMN "t_default_intelligence_source_function"."display" IS '情报源功能是否展示';

COMMENT ON TABLE "t_default_intelligence_source_function" IS '默认情报源功能，用于重置情报源时恢复数据用';

DROP SEQUENCE IF EXISTS "t_default_intelligence_source_function_id_seq";
CREATE SEQUENCE "t_default_intelligence_source_function_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_default_intelligence_source_function_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_default_intelligence_source_function" ADD CONSTRAINT "idx_92250_primary" PRIMARY KEY ("id");

ALTER TABLE "t_default_intelligence_source_function" ADD CONSTRAINT "foreign_key_default_function_to_source" FOREIGN KEY ("intelligence_source_code") REFERENCES "t_default_intelligence_source_metadata" ("code") ON DELETE CASCADE ON UPDATE CASCADE;

CREATE UNIQUE INDEX "idx_92250_unique_intelligencesourcecode_function" ON "t_default_intelligence_source_function" USING btree (
    "intelligence_source_code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "function" "pg_catalog"."enum_ops" ASC NULLS LAST
    );
