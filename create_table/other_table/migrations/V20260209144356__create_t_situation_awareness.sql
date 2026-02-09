/*
 * Table: t_situation_awareness
 * Generated: 2026-02-09 14:43:08
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_situation_awareness";

CREATE TABLE "t_situation_awareness" (
                                         "id" int8 NOT NULL,
                                         "awareness_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                         "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                         "brief" text COLLATE "pg_catalog"."default" NOT NULL,
                                         "create_time" timestamp,
                                         "update_time" timestamp
)
;

ALTER TABLE "t_situation_awareness" OWNER TO "dbapp";

ALTER TABLE "t_situation_awareness" ADD CONSTRAINT "idx_93070_primary" PRIMARY KEY ("id");
