/*
 * Table: t_work_order_tags_relation
 * Generated: 2026-02-09 14:06:01
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_work_order_tags_relation";

CREATE TABLE "t_work_order_tags_relation" (
                                              "id" int8 NOT NULL DEFAULT nextval('t_work_order_tags_relation_id_seq'::regclass),
                                              "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                              "serial_id" char(14) COLLATE "pg_catalog"."default" NOT NULL,
                                              "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                              "updated_at" timestamp
)
;

ALTER TABLE "t_work_order_tags_relation" OWNER TO "dbapp";

COMMENT ON COLUMN "t_work_order_tags_relation"."id" IS '自增主键';

COMMENT ON COLUMN "t_work_order_tags_relation"."name" IS 'tag 的名字';

COMMENT ON COLUMN "t_work_order_tags_relation"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';

COMMENT ON COLUMN "t_work_order_tags_relation"."created_at" IS '记录创建时间';

COMMENT ON COLUMN "t_work_order_tags_relation"."updated_at" IS '记录更新时间';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_work_order_tags_relation_id_seq";
CREATE SEQUENCE "t_work_order_tags_relation_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_work_order_tags_relation_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_work_order_tags_relation"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_work_order_tags_relation"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.updated_at = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_work_order_tags_relation"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_work_order_tags_relation"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_work_order_tags_relation"();

ALTER TABLE "t_work_order_tags_relation" ADD CONSTRAINT "idx_93420_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_93420_table.hash.unique.key.name.serial_id" ON "t_work_order_tags_relation" USING btree (
    "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "serial_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_93420_table.hash.unique.key.serial_id" ON "t_work_order_tags_relation" USING btree (
    "serial_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
    );
