/*
 * Table: t_model_layout_task_record
 * Generated: 2026-02-09 14:05:59
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_model_layout_task_record";

CREATE TABLE "t_model_layout_task_record" (
                                              "id" int8 NOT NULL DEFAULT nextval('t_model_layout_task_record_id_seq'::regclass),
                                              "formid" int8,
                                              "eventid" varchar(255) COLLATE "pg_catalog"."default",
                                              "taskid" int8,
                                              "starttime" timestamp,
                                              "endtime" timestamp,
                                              "schedule" varchar(255) COLLATE "pg_catalog"."default",
                                              "schedulech" varchar(255) COLLATE "pg_catalog"."default",
                                              "message" text COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_model_layout_task_record" OWNER TO "dbapp";

COMMENT ON COLUMN "t_model_layout_task_record"."formid" IS '模块Id';

COMMENT ON COLUMN "t_model_layout_task_record"."eventid" IS '事件Id';

COMMENT ON COLUMN "t_model_layout_task_record"."taskid" IS '任务Id';

COMMENT ON COLUMN "t_model_layout_task_record"."starttime" IS '起始时间';

COMMENT ON COLUMN "t_model_layout_task_record"."endtime" IS '结束时间';

COMMENT ON COLUMN "t_model_layout_task_record"."schedule" IS '任务处置进度';

COMMENT ON COLUMN "t_model_layout_task_record"."schedulech" IS '任务状态';

COMMENT ON COLUMN "t_model_layout_task_record"."message" IS '告警信息';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_model_layout_task_record_id_seq";
CREATE SEQUENCE "t_model_layout_task_record_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_model_layout_task_record_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_model_layout_task_record"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_model_layout_task_record"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.starttime = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_model_layout_task_record"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_model_layout_task_record"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_model_layout_task_record"();

ALTER TABLE "t_model_layout_task_record" ADD CONSTRAINT "idx_92589_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_92589_idx_eventid" ON "t_model_layout_task_record" USING btree (
    "eventid" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_92589_idx_starttime" ON "t_model_layout_task_record" USING btree (
    "starttime" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
    "schedulech" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_92589_idx_taskid" ON "t_model_layout_task_record" USING btree (
    "taskid" "pg_catalog"."int8_ops" ASC NULLS LAST
    );
