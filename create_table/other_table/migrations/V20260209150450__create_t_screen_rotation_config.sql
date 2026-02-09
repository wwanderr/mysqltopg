/*
 * Table: t_screen_rotation_config
 * Generated: 2026-02-09 15:04:38
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_screen_rotation_config";

CREATE TABLE "t_screen_rotation_config" (
                                            "uuid" int8 NOT NULL DEFAULT nextval('t_screen_rotation_config_uuid_seq'::regclass),
                                            "id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
                                            "system" varchar(11) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'bigdata-web'::character varying,
                                            "source" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                            "name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                            "url" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                            "router" varchar(50) COLLATE "pg_catalog"."default",
                                            "param" text COLLATE "pg_catalog"."default",
                                            "order" int8 NOT NULL DEFAULT '0'::bigint,
                                            "createtime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                            "updatetime" timestamp
)
;

ALTER TABLE "t_screen_rotation_config" OWNER TO "dbapp";

COMMENT ON COLUMN "t_screen_rotation_config"."uuid" IS '主键id';

COMMENT ON COLUMN "t_screen_rotation_config"."id" IS '大屏本身id，来源不同可能导致id重复';

COMMENT ON COLUMN "t_screen_rotation_config"."system" IS '大屏所在系统，微服务中会用到，默认主产品';

COMMENT ON COLUMN "t_screen_rotation_config"."source" IS '大屏所在程序中的来源';

COMMENT ON COLUMN "t_screen_rotation_config"."name" IS '大屏名称';

COMMENT ON COLUMN "t_screen_rotation_config"."url" IS '大屏地址，部分为全路径，部分为路由';

COMMENT ON COLUMN "t_screen_rotation_config"."router" IS '路由(预留字段)';

COMMENT ON COLUMN "t_screen_rotation_config"."param" IS '参数';

COMMENT ON COLUMN "t_screen_rotation_config"."order" IS '排序';

COMMENT ON COLUMN "t_screen_rotation_config"."createtime" IS '创建时间';

COMMENT ON COLUMN "t_screen_rotation_config"."updatetime" IS '更新时间';

COMMENT ON TABLE "t_screen_rotation_config" IS '大屏轮播配置';

BEGIN;
COMMIT;

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_screen_rotation_config"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_screen_rotation_config"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.updatetime = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_screen_rotation_config"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_screen_rotation_config"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_screen_rotation_config"();

ALTER TABLE "t_screen_rotation_config" ADD CONSTRAINT "idx_92920_primary" PRIMARY KEY ("uuid");
