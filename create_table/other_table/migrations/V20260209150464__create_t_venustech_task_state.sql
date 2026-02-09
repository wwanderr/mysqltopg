/*
 * Table: t_venustech_task_state
 * Generated: 2026-02-09 15:04:40
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_venustech_task_state";

CREATE TABLE "t_venustech_task_state" (
                                          "taskid" int8 NOT NULL,
                                          "state" int8
)
;

ALTER TABLE "t_venustech_task_state" OWNER TO "dbapp";

BEGIN;
COMMIT;

ALTER TABLE "t_venustech_task_state" ADD CONSTRAINT "idx_93291_primary" PRIMARY KEY ("taskid");
