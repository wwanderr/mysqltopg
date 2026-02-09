/*
 * Table: t_venustech_task
 * Generated: 2026-02-09 14:43:09
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_venustech_task";

CREATE TABLE "t_venustech_task" (
                                    "taskid" int8 NOT NULL,
                                    "deviceid" int8 NOT NULL,
                                    "author" varchar(255) COLLATE "pg_catalog"."default",
                                    "description" varchar(255) COLLATE "pg_catalog"."default",
                                    "sessionname" varchar(255) COLLATE "pg_catalog"."default",
                                    "taskname" varchar(255) COLLATE "pg_catalog"."default",
                                    "tasksessionid" int8,
                                    "hostfoundnums" varchar(255) COLLATE "pg_catalog"."default",
                                    "vulnfoundnums" varchar(255) COLLATE "pg_catalog"."default",
                                    "taskstatus" varchar(255) COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_venustech_task" OWNER TO "dbapp";

BEGIN;
COMMIT;

ALTER TABLE "t_venustech_task" ADD CONSTRAINT "idx_93286_primary" PRIMARY KEY ("taskid", "deviceid");

CREATE INDEX "idx_93286_taskstatus" ON "t_venustech_task" USING btree (
    "taskstatus" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
