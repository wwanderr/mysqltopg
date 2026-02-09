/*
 * Table: t_portal_screen
 * Generated: 2026-02-09 14:43:07
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_portal_screen_id_seq";
CREATE SEQUENCE "t_portal_screen_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_portal_screen_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_portal_screen";

CREATE TABLE "t_portal_screen" (
                                   "id" int8 NOT NULL DEFAULT nextval('t_portal_screen_id_seq'::regclass),
                                   "name" varchar(100) COLLATE "pg_catalog"."default",
                                   "menu_id" varchar(100) COLLATE "pg_catalog"."default",
                                   "menu_name" varchar(100) COLLATE "pg_catalog"."default",
                                   "url" varchar(255) COLLATE "pg_catalog"."default",
                                   "icon" varchar(50) COLLATE "pg_catalog"."default",
                                   "outlink" bool,
                                   "app" bool,
                                   "app_tip" varchar(100) COLLATE "pg_catalog"."default",
                                   "create_time" timestamp,
                                   "update_time" timestamp
)
;

ALTER TABLE "t_portal_screen" OWNER TO "dbapp";

ALTER TABLE "t_portal_screen" ADD CONSTRAINT "idx_92704_primary" PRIMARY KEY ("id");
