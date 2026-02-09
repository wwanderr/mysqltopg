/*
 * Table: t_venustech_device
 * Generated: 2026-02-09 13:48:10
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_venustech_device";

CREATE TABLE "t_venustech_device" (
                                      "id" int8 NOT NULL DEFAULT nextval('t_venustech_device_id_seq'::regclass),
                                      "name" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                      "ip" varchar(16) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                      "port" varchar(16) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                      "user" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                      "pwd" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                      "state" int8
)
;

ALTER TABLE "t_venustech_device" OWNER TO "dbapp";

COMMENT ON COLUMN "t_venustech_device"."id" IS 'id';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_venustech_device_id_seq";
CREATE SEQUENCE "t_venustech_device_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_venustech_device_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_venustech_device" ADD CONSTRAINT "idx_93277_primary" PRIMARY KEY ("id");
