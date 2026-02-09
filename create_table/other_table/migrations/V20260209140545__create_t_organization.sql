/*
 * Table: t_organization
 * Generated: 2026-02-09 14:05:59
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_organization";

CREATE TABLE "t_organization" (
                                  "id" int8 NOT NULL DEFAULT nextval('t_organization_id_seq'::regclass),
                                  "orgname" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                  "abbreviation" varchar(256) COLLATE "pg_catalog"."default",
                                  "orgid" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
                                  "parentorgid" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
                                  "orgidentifier" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                  "orgaddress" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                  "orgarea" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                  "createtime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  "updatetime" timestamp
)
;

ALTER TABLE "t_organization" OWNER TO "dbapp";

COMMENT ON COLUMN "t_organization"."orgname" IS '组织名称';

COMMENT ON COLUMN "t_organization"."abbreviation" IS '简称';

COMMENT ON COLUMN "t_organization"."orgid" IS '组织标识';

COMMENT ON COLUMN "t_organization"."parentorgid" IS '父组织标识';

COMMENT ON COLUMN "t_organization"."orgidentifier" IS '组织编号';

COMMENT ON COLUMN "t_organization"."orgaddress" IS '地址';

COMMENT ON COLUMN "t_organization"."orgarea" IS '地区';

COMMENT ON COLUMN "t_organization"."createtime" IS '创建时间';

COMMENT ON COLUMN "t_organization"."updatetime" IS '修改时间';

DROP SEQUENCE IF EXISTS "t_organization_id_seq";
CREATE SEQUENCE "t_organization_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_organization_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_organization"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_organization"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.updatetime = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_organization"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_organization"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_organization"();

ALTER TABLE "t_organization" ADD CONSTRAINT "idx_92679_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_92679_index_orgid" ON "t_organization" USING btree (
    "orgid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_92679_index_orgname" ON "t_organization" USING btree (
    "orgname" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_92679_index_parentorgid" ON "t_organization" USING btree (
    "parentorgid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE UNIQUE INDEX "idx_92679_orgid" ON "t_organization" USING btree (
    "orgid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
