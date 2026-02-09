/*
 * Table: t_model_layout_action_time
 * Generated: 2026-02-09 14:05:59
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_model_layout_action_time";

CREATE TABLE "t_model_layout_action_time" (
                                              "id" int8 NOT NULL DEFAULT nextval('t_model_layout_action_time_id_seq'::regclass),
                                              "actiontime" varchar(255) COLLATE "pg_catalog"."default",
                                              "type" varchar(255) COLLATE "pg_catalog"."default",
                                              "mineventid" int8,
                                              "maxeventid" int8,
                                              "formid" int8,
                                              "orderid" int2
)
;

ALTER TABLE "t_model_layout_action_time" OWNER TO "dbapp";

COMMENT ON COLUMN "t_model_layout_action_time"."actiontime" IS '操作时间';

COMMENT ON COLUMN "t_model_layout_action_time"."type" IS '操作状态';

COMMENT ON COLUMN "t_model_layout_action_time"."mineventid" IS '批量处理最小任务Id';

COMMENT ON COLUMN "t_model_layout_action_time"."maxeventid" IS '批量处理最大任务Id';

COMMENT ON COLUMN "t_model_layout_action_time"."formid" IS '模块id';

COMMENT ON COLUMN "t_model_layout_action_time"."orderid" IS '模块内编号';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_model_layout_action_time_id_seq";
CREATE SEQUENCE "t_model_layout_action_time_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_model_layout_action_time_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_model_layout_action_time" ADD CONSTRAINT "idx_92558_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_92558_idx_orderid_formid" ON "t_model_layout_action_time" USING btree (
    "orderid" "pg_catalog"."int2_ops" ASC NULLS LAST,
    "formid" "pg_catalog"."int8_ops" ASC NULLS LAST
    );
