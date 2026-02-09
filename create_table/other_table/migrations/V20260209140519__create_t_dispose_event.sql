/*
 * Table: t_dispose_event
 * Generated: 2026-02-09 14:05:57
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_dispose_event";

CREATE TABLE "t_dispose_event" (
                                   "id" int8 NOT NULL DEFAULT nextval('t_dispose_event_id_seq'::regclass),
                                   "title" varchar(127) COLLATE "pg_catalog"."default" NOT NULL,
                                   "assigneeid" int8 NOT NULL,
                                   "creatorid" int8 NOT NULL,
                                   "disposeaction" varchar(23) COLLATE "pg_catalog"."default" NOT NULL,
                                   "status" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
                                   "domain" varchar(63) COLLATE "pg_catalog"."default",
                                   "ip" varchar(63) COLLATE "pg_catalog"."default",
                                   "comment" varchar(255) COLLATE "pg_catalog"."default",
                                   "createtime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                   "updatetime" timestamp
)
;

ALTER TABLE "t_dispose_event" OWNER TO "dbapp";

COMMENT ON COLUMN "t_dispose_event"."title" IS '用户ID';

COMMENT ON COLUMN "t_dispose_event"."assigneeid" IS '受理人ID';

COMMENT ON COLUMN "t_dispose_event"."creatorid" IS '创建人ID';

COMMENT ON COLUMN "t_dispose_event"."disposeaction" IS '处置动作';

COMMENT ON COLUMN "t_dispose_event"."status" IS '状态';

COMMENT ON COLUMN "t_dispose_event"."domain" IS '域名';

COMMENT ON COLUMN "t_dispose_event"."ip" IS 'IP';

COMMENT ON COLUMN "t_dispose_event"."comment" IS '备注';

COMMENT ON COLUMN "t_dispose_event"."createtime" IS '创建时间';

COMMENT ON COLUMN "t_dispose_event"."updatetime" IS '修改时间';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_dispose_event_id_seq";
CREATE SEQUENCE "t_dispose_event_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_dispose_event_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_dispose_event"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_dispose_event"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.updatetime = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_dispose_event"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_dispose_event"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_dispose_event"();

ALTER TABLE "t_dispose_event" ADD CONSTRAINT "idx_92290_primary" PRIMARY KEY ("id");

ALTER TABLE "t_dispose_event" ADD CONSTRAINT "fk_assigneedid" FOREIGN KEY ("assigneeid") REFERENCES "t_user" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "t_dispose_event" ADD CONSTRAINT "fk_creatorid" FOREIGN KEY ("creatorid") REFERENCES "t_user" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

CREATE INDEX "idx_92290_index_assignee" ON "t_dispose_event" USING btree (
    "assigneeid" "pg_catalog"."int8_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_92290_index_creator" ON "t_dispose_event" USING btree (
    "creatorid" "pg_catalog"."int8_ops" ASC NULLS LAST
    );
