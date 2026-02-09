/*
 * Table: t_dispose_event_history
 * Generated: 2026-02-09 14:05:57
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_dispose_event_history";

CREATE TABLE "t_dispose_event_history" (
                                           "id" int8 NOT NULL DEFAULT nextval('t_dispose_event_history_id_seq'::regclass),
                                           "eventid" int8 NOT NULL,
                                           "operatorid" int8 NOT NULL,
                                           "address" varchar(23) COLLATE "pg_catalog"."default" NOT NULL,
                                           "operations" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                           "action" varchar(20) COLLATE "pg_catalog"."default",
                                           "createtime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_dispose_event_history" OWNER TO "dbapp";

COMMENT ON COLUMN "t_dispose_event_history"."eventid" IS '处置事件ID';

COMMENT ON COLUMN "t_dispose_event_history"."operatorid" IS '操作人ID';

COMMENT ON COLUMN "t_dispose_event_history"."address" IS '操作人主机地址';

COMMENT ON COLUMN "t_dispose_event_history"."operations" IS '操作记录';

COMMENT ON COLUMN "t_dispose_event_history"."action" IS '处置动作';

COMMENT ON COLUMN "t_dispose_event_history"."createtime" IS '创建时间';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_dispose_event_history_id_seq";
CREATE SEQUENCE "t_dispose_event_history_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_dispose_event_history_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_dispose_event_history" ADD CONSTRAINT "idx_92298_primary" PRIMARY KEY ("id");

ALTER TABLE "t_dispose_event_history" ADD CONSTRAINT "fk_eventid" FOREIGN KEY ("eventid") REFERENCES "t_dispose_event" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE "t_dispose_event_history" ADD CONSTRAINT "fk_operatorid" FOREIGN KEY ("operatorid") REFERENCES "t_user" ("id") ON DELETE RESTRICT ON UPDATE RESTRICT;

CREATE INDEX "idx_92298_fk_eventid" ON "t_dispose_event_history" USING btree (
    "eventid" "pg_catalog"."int8_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_92298_fk_operatorid" ON "t_dispose_event_history" USING btree (
    "operatorid" "pg_catalog"."int8_ops" ASC NULLS LAST
    );
