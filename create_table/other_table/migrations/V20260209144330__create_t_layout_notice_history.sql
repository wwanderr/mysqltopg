/*
 * Table: t_layout_notice_history
 * Generated: 2026-02-09 14:43:06
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_layout_notice_history_id_seq";
CREATE SEQUENCE "t_layout_notice_history_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_layout_notice_history_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_layout_notice_history";

CREATE TABLE "t_layout_notice_history" (
                                           "id" int8 NOT NULL DEFAULT nextval('t_layout_notice_history_id_seq'::regclass),
                                           "layout_task_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                           "assignee_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                           "assignee_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                           "notice_way" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
                                           "content" text COLLATE "pg_catalog"."default" NOT NULL,
                                           "status" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'success'::character varying,
                                           "failure_msg" text COLLATE "pg_catalog"."default",
                                           "serial_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '-'::character varying,
                                           "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_layout_notice_history" OWNER TO "dbapp";

COMMENT ON COLUMN "t_layout_notice_history"."id" IS '自增主键';

COMMENT ON COLUMN "t_layout_notice_history"."layout_task_id" IS '剧本编排的唯一主键';

COMMENT ON COLUMN "t_layout_notice_history"."assignee_id" IS '通知人的id';

COMMENT ON COLUMN "t_layout_notice_history"."assignee_name" IS '通知人的name';

COMMENT ON COLUMN "t_layout_notice_history"."notice_way" IS '通知方式';

COMMENT ON COLUMN "t_layout_notice_history"."content" IS '通知内容';

COMMENT ON COLUMN "t_layout_notice_history"."status" IS '状态';

COMMENT ON COLUMN "t_layout_notice_history"."failure_msg" IS '失败原因';

COMMENT ON COLUMN "t_layout_notice_history"."serial_id" IS '编号';

COMMENT ON COLUMN "t_layout_notice_history"."created_at" IS '记录创建时间';

BEGIN;
COMMIT;

ALTER TABLE "t_layout_notice_history" ADD CONSTRAINT "idx_92431_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_92431_table.hash.key.layout_task_id" ON "t_layout_notice_history" USING btree (
    "layout_task_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
