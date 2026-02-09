/*
 * Table: t_model_layout_task
 * Generated: 2026-02-09 14:43:07
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_model_layout_task_id_seq";
CREATE SEQUENCE "t_model_layout_task_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_model_layout_task_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_model_layout_task";

CREATE TABLE "t_model_layout_task" (
                                       "id" int8 NOT NULL DEFAULT nextval('t_model_layout_task_id_seq'::regclass),
                                       "model_id" varchar(255) COLLATE "pg_catalog"."default",
                                       "model_name" varchar(255) COLLATE "pg_catalog"."default",
                                       "task_id" varchar(255) COLLATE "pg_catalog"."default",
                                       "starttime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                       "endtime" varchar(255) COLLATE "pg_catalog"."default",
                                       "schedulech" varchar(255) COLLATE "pg_catalog"."default",
                                       "detailjson" text COLLATE "pg_catalog"."default",
                                       "message" text COLLATE "pg_catalog"."default",
                                       "layout_id" varchar(255) COLLATE "pg_catalog"."default",
                                       "layout_name" varchar(255) COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_model_layout_task" OWNER TO "dbapp";

COMMENT ON COLUMN "t_model_layout_task"."model_id" IS '模型名称';

COMMENT ON COLUMN "t_model_layout_task"."model_name" IS '模型中文名';

COMMENT ON COLUMN "t_model_layout_task"."task_id" IS '任务id';

COMMENT ON COLUMN "t_model_layout_task"."starttime" IS '记录创建时间';

COMMENT ON COLUMN "t_model_layout_task"."endtime" IS '结束时间';

COMMENT ON COLUMN "t_model_layout_task"."schedulech" IS '当前状态';

COMMENT ON COLUMN "t_model_layout_task"."detailjson" IS '详情';

COMMENT ON COLUMN "t_model_layout_task"."message" IS '告警信息';

COMMENT ON COLUMN "t_model_layout_task"."layout_id" IS '剧本ID';

COMMENT ON COLUMN "t_model_layout_task"."layout_name" IS '剧本中文名';

BEGIN;
COMMIT;

ALTER TABLE "t_model_layout_task" ADD CONSTRAINT "idx_92581_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_92581_index_id_name" ON "t_model_layout_task" USING btree (
    "layout_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "layout_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_92581_index_id_time_schedulech" ON "t_model_layout_task" USING btree (
    "layout_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "starttime" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
    "schedulech" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_92581_index_name_id_time_schedulech" ON "t_model_layout_task" USING btree (
    "layout_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "layout_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "starttime" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
    "schedulech" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_92581_index_name_time_schedulech" ON "t_model_layout_task" USING btree (
    "layout_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "starttime" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
    "schedulech" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE UNIQUE INDEX "idx_92581_index_task_id" ON "t_model_layout_task" USING btree (
    "task_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_92581_index_time_schedulech" ON "t_model_layout_task" USING btree (
    "starttime" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
    "schedulech" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
