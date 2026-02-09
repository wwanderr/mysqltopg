/*
 * Table: t_security_device
 * Generated: 2026-02-09 14:43:08
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_security_device_id_seq";
CREATE SEQUENCE "t_security_device_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_security_device_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_security_device";

CREATE TABLE "t_security_device" (
                                     "id" int8 NOT NULL DEFAULT nextval('t_security_device_id_seq'::regclass),
                                     "name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
                                     "geo" varchar(200) COLLATE "pg_catalog"."default",
                                     "type" varchar(100) COLLATE "pg_catalog"."default",
                                     "manufacturer" varchar(100) COLLATE "pg_catalog"."default",
                                     "icon" varchar(100) COLLATE "pg_catalog"."default",
                                     "description" text COLLATE "pg_catalog"."default",
                                     "related_assets" text COLLATE "pg_catalog"."default",
                                     "related_assets_num" int8,
                                     "add_screen" int8 DEFAULT '0'::bigint,
                                     "create_time" timestamp DEFAULT CURRENT_TIMESTAMP,
                                     "update_time" timestamp DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_security_device" OWNER TO "dbapp";

COMMENT ON COLUMN "t_security_device"."id" IS '安全设备ID';

COMMENT ON COLUMN "t_security_device"."name" IS '安全设备名称';

COMMENT ON COLUMN "t_security_device"."geo" IS '地理位置';

COMMENT ON COLUMN "t_security_device"."type" IS '设备类型';

COMMENT ON COLUMN "t_security_device"."manufacturer" IS '设备厂商';

COMMENT ON COLUMN "t_security_device"."icon" IS '设备图标';

COMMENT ON COLUMN "t_security_device"."description" IS '描述信息';

COMMENT ON COLUMN "t_security_device"."related_assets" IS '关联资产';

COMMENT ON COLUMN "t_security_device"."related_assets_num" IS '关联资产数';

COMMENT ON COLUMN "t_security_device"."add_screen" IS '是否投屏, 1是，0否';

ALTER TABLE "t_security_device" ADD CONSTRAINT "idx_92947_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_92947_name" ON "t_security_device" USING btree (
    "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
