/*
 * Table: t_license
 * Generated: 2026-02-09 14:43:06
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_license";

CREATE TABLE "t_license" (
                             "uuid" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
                             "type" varchar(45) COLLATE "pg_catalog"."default" NOT NULL,
                             "machine_code" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                             "version" varchar(64) COLLATE "pg_catalog"."default",
                             "build" varchar(64) COLLATE "pg_catalog"."default",
                             "online" int8 NOT NULL DEFAULT '0'::bigint,
                             "license_filename" varchar(100) COLLATE "pg_catalog"."default",
                             "license_content" varchar(10000) COLLATE "pg_catalog"."default",
                             "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                             "sync" int8 NOT NULL DEFAULT '1'::bigint,
                             "timeout" int8 NOT NULL DEFAULT '1'::bigint,
                             "device_model" varchar(150) COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_license" OWNER TO "dbapp";

COMMENT ON COLUMN "t_license"."type" IS '合同类型：AILPHA、AIVIEW';

COMMENT ON COLUMN "t_license"."version" IS '版本号';

COMMENT ON COLUMN "t_license"."build" IS 'build号，最后一次commit的id';

COMMENT ON COLUMN "t_license"."online" IS '在线状态。0:离线，1在线。';

COMMENT ON COLUMN "t_license"."license_filename" IS '许可证文件名';

COMMENT ON COLUMN "t_license"."license_content" IS '许可内容';

COMMENT ON COLUMN "t_license"."sync" IS '是否要将许可内容同步给AiView.0不需要，1需要。';

COMMENT ON COLUMN "t_license"."timeout" IS '是否过期，程序需要在宿主机执行，由AiView发送过来。0未过期，1过期。';

COMMENT ON COLUMN "t_license"."device_model" IS '设备型号';

BEGIN;
COMMIT;

ALTER TABLE "t_license" ADD CONSTRAINT "idx_92441_primary" PRIMARY KEY ("uuid");
