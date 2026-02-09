/*
 * Table: t_role_role_type
 * Generated: 2026-02-09 13:48:09
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_role_role_type";

CREATE TABLE "t_role_role_type" (
                                    "id" int8 NOT NULL DEFAULT nextval('t_role_role_type_id_seq'::regclass),
                                    "role_id" int8 NOT NULL,
                                    "role_type_id" int8 NOT NULL,
                                    "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    "default" varchar(150) COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_role_role_type" OWNER TO "dbapp";

DROP SEQUENCE IF EXISTS "t_role_role_type_id_seq";
CREATE SEQUENCE "t_role_role_type_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_role_role_type_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_role_role_type" ADD CONSTRAINT "idx_92850_primary" PRIMARY KEY ("id");
