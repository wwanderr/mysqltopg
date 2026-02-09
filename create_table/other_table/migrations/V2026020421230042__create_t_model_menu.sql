/*
 * Table: t_model_menu
 * Generated: 2026-02-09 13:48:09
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_model_menu";

CREATE TABLE "t_model_menu" (
                                "id" int8 NOT NULL DEFAULT nextval('t_model_menu_id_seq'::regclass),
                                "model_id" int8 NOT NULL,
                                "menu_id" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                "default" varchar(45) COLLATE "pg_catalog"."default",
                                "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                "model_type" varchar(100) COLLATE "pg_catalog"."default" DEFAULT 'menu'::character varying,
                                "auth_mode" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'normal'::character varying
)
;

ALTER TABLE "t_model_menu" OWNER TO "dbapp";

COMMENT ON COLUMN "t_model_menu"."model_type" IS '授权类型，menu：菜单，extension：拓展';

COMMENT ON COLUMN "t_model_menu"."auth_mode" IS '授权类型，normal：正常授权，negate：反向授权';

DROP SEQUENCE IF EXISTS "t_model_menu_id_seq";
CREATE SEQUENCE "t_model_menu_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_model_menu_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_model_menu" ADD CONSTRAINT "idx_92596_primary" PRIMARY KEY ("id", "menu_id", "model_id");
