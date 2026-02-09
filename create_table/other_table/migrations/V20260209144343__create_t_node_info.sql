/*
 * Table: t_node_info
 * Generated: 2026-02-09 14:43:07
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_node_info_id_seq";
CREATE SEQUENCE "t_node_info_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_node_info_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_node_info";

CREATE TABLE "t_node_info" (
                               "id" int8 NOT NULL DEFAULT nextval('t_node_info_id_seq'::regclass),
                               "oid" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
                               "name" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                               "description" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                               "parent_name" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                               "has_sub" bool NOT NULL DEFAULT true,
                               "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               "update_time" timestamp,
                               "deleted" int4 DEFAULT 0
)
;

ALTER TABLE "t_node_info" OWNER TO "dbapp";

COMMENT ON COLUMN "t_node_info"."id" IS '唯一ID';

COMMENT ON COLUMN "t_node_info"."oid" IS 'OID';

COMMENT ON COLUMN "t_node_info"."name" IS '名称';

COMMENT ON COLUMN "t_node_info"."description" IS '描述';

COMMENT ON COLUMN "t_node_info"."parent_name" IS '父名称';

COMMENT ON COLUMN "t_node_info"."has_sub" IS '是否有子节点：0-否、1-是';

COMMENT ON COLUMN "t_node_info"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_node_info"."update_time" IS '修改时间';

COMMENT ON COLUMN "t_node_info"."deleted" IS '是否已删除：0-否，1-是';

COMMENT ON TABLE "t_node_info" IS 'SNMP常用节点信息';

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_node_info"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_node_info"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_node_info"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_node_info"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_node_info"();

ALTER TABLE "t_node_info" ADD CONSTRAINT "idx_92633_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_92633_idx_t_node_info_oid" ON "t_node_info" USING btree (
    "oid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
