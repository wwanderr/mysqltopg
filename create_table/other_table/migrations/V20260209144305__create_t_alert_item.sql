/*
 * Table: t_alert_item
 * Generated: 2026-02-09 14:43:05
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_alert_item_id_seq";
CREATE SEQUENCE "t_alert_item_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_alert_item_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_alert_item";

CREATE TABLE "t_alert_item" (
                                "id" int8 NOT NULL DEFAULT nextval('t_alert_item_id_seq'::regclass),
                                "user_id" int8 NOT NULL,
                                "source_ip" varchar(255) COLLATE "pg_catalog"."default" DEFAULT 'ALL'::character varying,
                                "aim_ip" varchar(255) COLLATE "pg_catalog"."default" DEFAULT 'ALL'::character varying,
                                "contact_type" "t_alert_item_contact_type",
                                "filter_rule" text COLLATE "pg_catalog"."default" NOT NULL,
                                "parsed_aviator" text COLLATE "pg_catalog"."default" NOT NULL,
                                "kill_chain" varchar(255) COLLATE "pg_catalog"."default",
                                "modify_by" varchar(255) COLLATE "pg_catalog"."default",
                                "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                "updated_at" timestamp,
                                "author" varchar(255) COLLATE "pg_catalog"."default",
                                "author_id" varchar(255) COLLATE "pg_catalog"."default",
                                "assignee" varchar(255) COLLATE "pg_catalog"."default",
                                "assignee_id" varchar(255) COLLATE "pg_catalog"."default",
                                "blockip" varchar(4096) COLLATE "pg_catalog"."default",
                                "name" varchar(100) COLLATE "pg_catalog"."default",
                                "devicename" varchar(4096) COLLATE "pg_catalog"."default",
                                "deviceid" varchar(1024) COLLATE "pg_catalog"."default",
                                "age" varchar(255) COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_alert_item" OWNER TO "dbapp";

COMMENT ON COLUMN "t_alert_item"."id" IS '自增主键';

COMMENT ON COLUMN "t_alert_item"."user_id" IS '被通知人在t_user表中的id';

COMMENT ON COLUMN "t_alert_item"."source_ip" IS '源头ip';

COMMENT ON COLUMN "t_alert_item"."aim_ip" IS '目标ip';

COMMENT ON COLUMN "t_alert_item"."filter_rule" IS '过滤规则';

COMMENT ON COLUMN "t_alert_item"."parsed_aviator" IS '转换后的表达式';

COMMENT ON COLUMN "t_alert_item"."kill_chain" IS '告警项';

COMMENT ON COLUMN "t_alert_item"."modify_by" IS '记录修改人';

COMMENT ON COLUMN "t_alert_item"."created_at" IS '记录创建时间';

COMMENT ON COLUMN "t_alert_item"."updated_at" IS '记录更新时间';

COMMENT ON COLUMN "t_alert_item"."author" IS '条目创建人';

COMMENT ON COLUMN "t_alert_item"."author_id" IS '条目创建人在t_user表中的id';

COMMENT ON COLUMN "t_alert_item"."assignee" IS '条目受理人';

COMMENT ON COLUMN "t_alert_item"."assignee_id" IS '条目受理人在t_user表中的id';

COMMENT ON COLUMN "t_alert_item"."blockip" IS '阻挡IP';

COMMENT ON COLUMN "t_alert_item"."name" IS '名称';

COMMENT ON COLUMN "t_alert_item"."devicename" IS '设备名称';

COMMENT ON COLUMN "t_alert_item"."deviceid" IS '联动设备id';

COMMENT ON COLUMN "t_alert_item"."age" IS '阻断时长';

BEGIN;
COMMIT;

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_alert_item"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_alert_item"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.updated_at = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_alert_item"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_alert_item"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_alert_item"();

ALTER TABLE "t_alert_item" ADD CONSTRAINT "idx_91891_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_91891_name" ON "t_alert_item" USING btree (
    "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
