/*
 * Table: t_intelligence_source_metadata
 * Generated: 2026-02-09 13:48:08
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_intelligence_source_metadata";

CREATE TABLE "t_intelligence_source_metadata" (
                                                  "id" int8 NOT NULL DEFAULT nextval('t_intelligence_source_metadata_id_seq'::regclass),
                                                  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                                  "code" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                                  "icon" varchar(50) COLLATE "pg_catalog"."default",
                                                  "type" "t_intelligence_source_metadata_type" NOT NULL,
                                                  "subtype" "t_intelligence_source_metadata_subtype" NOT NULL,
                                                  "knowledge" int2 DEFAULT '0'::smallint,
                                                  "flag" int2 DEFAULT '1'::smallint,
                                                  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                                  "update_time" timestamp,
                                                  "app_id" varchar(255) COLLATE "pg_catalog"."default",
                                                  "dasca_device_id" varchar(50) COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_intelligence_source_metadata" OWNER TO "dbapp";

COMMENT ON COLUMN "t_intelligence_source_metadata"."id" IS '情报源ID';

COMMENT ON COLUMN "t_intelligence_source_metadata"."name" IS '情报源名称';

COMMENT ON COLUMN "t_intelligence_source_metadata"."code" IS '情报源英文标识（用以关联操作）';

COMMENT ON COLUMN "t_intelligence_source_metadata"."icon" IS '情报源图标';

COMMENT ON COLUMN "t_intelligence_source_metadata"."type" IS '情报源类型：local-本地情报源；API-API情报源';

COMMENT ON COLUMN "t_intelligence_source_metadata"."subtype" IS '情报源子类型：custom-自定义情报源；build-in-内置情报源';

COMMENT ON COLUMN "t_intelligence_source_metadata"."knowledge" IS '情报源是否包含知识库：0-不包含知识库；1-包含只是库，当前仅威胁情报中心具有知识库';

COMMENT ON COLUMN "t_intelligence_source_metadata"."flag" IS '情报源标记，1-显示（所有正常工作的情报源），0-不显示（内置情报源但默认未添加状态，如微步、绿盟、天际友盟）';

COMMENT ON COLUMN "t_intelligence_source_metadata"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_intelligence_source_metadata"."update_time" IS '更新时间';

COMMENT ON COLUMN "t_intelligence_source_metadata"."app_id" IS 'app标识';

COMMENT ON COLUMN "t_intelligence_source_metadata"."dasca_device_id" IS 'dasca_device_id';

COMMENT ON TABLE "t_intelligence_source_metadata" IS '情报源，存储所有情报源数据';

DROP SEQUENCE IF EXISTS "t_intelligence_source_metadata_id_seq";
CREATE SEQUENCE "t_intelligence_source_metadata_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_intelligence_source_metadata_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_intelligence_source_metadata"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_intelligence_source_metadata"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_intelligence_source_metadata"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_default_intelligence_source_metadata"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_default_intelligence_source_metad"();

ALTER TABLE "t_intelligence_source_metadata" ADD CONSTRAINT "idx_92401_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_92401_code" ON "t_intelligence_source_metadata" USING btree (
    "code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE UNIQUE INDEX "idx_92259_code" ON "t_default_intelligence_source_metadata" USING btree (
    "code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE UNIQUE INDEX "idx_92259_name" ON "t_default_intelligence_source_metadata" USING btree (
    "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE UNIQUE INDEX "idx_92401_name" ON "t_intelligence_source_metadata" USING btree (
    "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
