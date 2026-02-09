/*
 * Table: t_user_ip
 * Generated: 2026-02-09 14:06:00
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_user_ip";

CREATE TABLE "t_user_ip" (
                             "id" int8 NOT NULL DEFAULT nextval('t_user_ip_id_seq'::regclass),
                             "user_id" int8 NOT NULL,
                             "ip" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                             "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             "default" varchar(150) COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_user_ip" OWNER TO "dbapp";

COMMENT ON COLUMN "t_user_ip"."user_id" IS '用户id';

COMMENT ON COLUMN "t_user_ip"."ip" IS '登陆ip';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_user_ip_id_seq";
CREATE SEQUENCE "t_user_ip_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_user_ip_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_user_ip" ADD CONSTRAINT "idx_93246_primary" PRIMARY KEY ("id");
