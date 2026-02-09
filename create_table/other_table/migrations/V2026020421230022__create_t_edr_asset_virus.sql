/*
 * Table: t_edr_asset_virus
 * Generated: 2026-02-09 13:48:08
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_edr_asset_virus";

CREATE TABLE "t_edr_asset_virus" (
                                     "id" int8 NOT NULL DEFAULT nextval('t_edr_asset_virus_id_seq'::regclass),
                                     "ip" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                     "scan_batch_no" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                     "file" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                     "time" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                     "name" varchar(255) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                     "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     "updated_at" timestamp
)
;

ALTER TABLE "t_edr_asset_virus" OWNER TO "dbapp";

COMMENT ON COLUMN "t_edr_asset_virus"."id" IS '自增主键';

COMMENT ON COLUMN "t_edr_asset_virus"."ip" IS '资产ip';

COMMENT ON COLUMN "t_edr_asset_virus"."scan_batch_no" IS '批次编号';

COMMENT ON COLUMN "t_edr_asset_virus"."file" IS '网站后门文件';

COMMENT ON COLUMN "t_edr_asset_virus"."time" IS '发现时间';

COMMENT ON COLUMN "t_edr_asset_virus"."name" IS '病毒木马名称';

COMMENT ON COLUMN "t_edr_asset_virus"."created_at" IS '记录创建时间';

COMMENT ON COLUMN "t_edr_asset_virus"."updated_at" IS '记录更新时间';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_edr_asset_virus_id_seq";
CREATE SEQUENCE "t_edr_asset_virus_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_edr_asset_virus_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_edr_asset_virus"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_edr_asset_virus"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.updated_at = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_edr_asset_virus"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_edr_asset_virus"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_edr_asset_virus"();

ALTER TABLE "t_edr_asset_virus" ADD CONSTRAINT "idx_92326_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_92326_table.hash.key.ip" ON "t_edr_asset_virus" USING btree (
    "ip" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
