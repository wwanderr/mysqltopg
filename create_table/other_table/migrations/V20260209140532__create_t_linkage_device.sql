/*
 * Table: t_linkage_device
 * Generated: 2026-02-09 14:05:58
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_linkage_device";

CREATE TABLE "t_linkage_device" (
                                    "id" int8 NOT NULL DEFAULT nextval('t_linkage_device_id_seq'::regclass),
                                    "name" varchar(512) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                    "ip" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                    "port" int4 DEFAULT 0,
                                    "status" varchar(10) COLLATE "pg_catalog"."default" DEFAULT 'down'::character varying,
                                    "category_name" varchar(512) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                    "type" varchar(512) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                    "type_name" varchar(512) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                    "bean_name" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                                    "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    "update_time" timestamp,
                                    "other" varchar(2048) COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_linkage_device" OWNER TO "dbapp";

COMMENT ON COLUMN "t_linkage_device"."name" IS '设备名称';

COMMENT ON COLUMN "t_linkage_device"."ip" IS '设备ip';

COMMENT ON COLUMN "t_linkage_device"."port" IS '设备端口号';

COMMENT ON COLUMN "t_linkage_device"."status" IS '设备是否可用up-不可用,down-可用';

COMMENT ON COLUMN "t_linkage_device"."category_name" IS '设备分类来自soc';

COMMENT ON COLUMN "t_linkage_device"."type" IS '设备类型';

COMMENT ON COLUMN "t_linkage_device"."type_name" IS '类型名称和type对应';

COMMENT ON COLUMN "t_linkage_device"."bean_name" IS 'spring beanName';

COMMENT ON COLUMN "t_linkage_device"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_linkage_device"."update_time" IS '更新时间';

COMMENT ON COLUMN "t_linkage_device"."other" IS '其他信息';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_linkage_device_id_seq";
CREATE SEQUENCE "t_linkage_device_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_linkage_device_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_linkage_device"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_linkage_device"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_linkage_device"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_linkage_device"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_linkage_device"();

ALTER TABLE "t_linkage_device" ADD CONSTRAINT "idx_92452_primary" PRIMARY KEY ("id");
