/*
 * Table: t_work_order_user_org_relation
 * Generated: 2026-02-09 14:06:01
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_work_order_user_org_relation";

CREATE TABLE "t_work_order_user_org_relation" (
                                                  "id" int8 NOT NULL DEFAULT nextval('t_work_order_user_org_relation_id_seq'::regclass),
                                                  "user_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                                  "org_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
                                                  "serial_id" char(14) COLLATE "pg_catalog"."default" NOT NULL,
                                                  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                                  "updated_at" timestamp
)
;

ALTER TABLE "t_work_order_user_org_relation" OWNER TO "dbapp";

COMMENT ON COLUMN "t_work_order_user_org_relation"."id" IS '自增主键';

COMMENT ON COLUMN "t_work_order_user_org_relation"."user_id" IS 'user的id';

COMMENT ON COLUMN "t_work_order_user_org_relation"."org_id" IS 'org的id';

COMMENT ON COLUMN "t_work_order_user_org_relation"."serial_id" IS '获取工单编号, 15个字符的定长序列, YYMMDD + 八位数字(00000001 - 99999999), 如 19011112120001';

COMMENT ON COLUMN "t_work_order_user_org_relation"."created_at" IS '记录创建时间';

COMMENT ON COLUMN "t_work_order_user_org_relation"."updated_at" IS '记录更新时间';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_work_order_user_org_relation_id_seq";
CREATE SEQUENCE "t_work_order_user_org_relation_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_work_order_user_org_relation_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_work_order_user_org_relation"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_work_order_user_org_relation"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.updated_at = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_work_order_user_org_relation"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_work_order_user_org_relation"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_work_order_user_org_relation"();

ALTER TABLE "t_work_order_user_org_relation" ADD CONSTRAINT "idx_93426_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_93426_table.hash.unique.key.org_id.serial_id" ON "t_work_order_user_org_relation" USING btree (
    "org_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "serial_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_93426_table.hash.unique.key.serial_id" ON "t_work_order_user_org_relation" USING btree (
    "serial_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
    );

CREATE UNIQUE INDEX "idx_93426_table.hash.unique.key.user_id.serial_id" ON "t_work_order_user_org_relation" USING btree (
    "user_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "serial_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
    );
