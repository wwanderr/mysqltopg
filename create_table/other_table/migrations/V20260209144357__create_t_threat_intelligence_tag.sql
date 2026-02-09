/*
 * Table: t_threat_intelligence_tag
 * Generated: 2026-02-09 14:43:08
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_threat_intelligence_tag_id_seq";
CREATE SEQUENCE "t_threat_intelligence_tag_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_threat_intelligence_tag_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_threat_intelligence_tag";

CREATE TABLE "t_threat_intelligence_tag" (
                                             "id" int8 NOT NULL DEFAULT nextval('t_threat_intelligence_tag_id_seq'::regclass),
                                             "name" varchar(18) COLLATE "pg_catalog"."default" NOT NULL,
                                             "is_malice" "t_threat_intelligence_tag_is_malice" NOT NULL DEFAULT 'undefined'::t_threat_intelligence_tag_is_malice,
                                             "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                             "update_time" timestamp
)
;

ALTER TABLE "t_threat_intelligence_tag" OWNER TO "dbapp";

COMMENT ON COLUMN "t_threat_intelligence_tag"."id" IS '标签ID';

COMMENT ON COLUMN "t_threat_intelligence_tag"."name" IS '标签名称';

COMMENT ON COLUMN "t_threat_intelligence_tag"."is_malice" IS 'truefalse恶意';

COMMENT ON COLUMN "t_threat_intelligence_tag"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_threat_intelligence_tag"."update_time" IS '更新时间';

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_threat_intelligence_tag"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_threat_intelligence_tag"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_threat_intelligence_tag"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_threat_intelligence_tag"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_threat_intelligence_tag"();

ALTER TABLE "t_threat_intelligence_tag" ADD CONSTRAINT "idx_93181_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_93181_name" ON "t_threat_intelligence_tag" USING btree (
    "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
