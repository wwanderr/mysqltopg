/*
 * Table: t_major_safeguard
 * Generated: 2026-02-09 14:05:58
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_major_safeguard";

CREATE TABLE "t_major_safeguard" (
                                     "id" int8 NOT NULL DEFAULT nextval('t_major_safeguard_id_seq'::regclass),
                                     "name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
                                     "description" text COLLATE "pg_catalog"."default" NOT NULL,
                                     "activity_start_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     "activity_end_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     "prepare_time" int8 NOT NULL,
                                     "reopen_time" int8 NOT NULL,
                                     "create_time" timestamp DEFAULT CURRENT_TIMESTAMP,
                                     "update_time" timestamp,
                                     "leader" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
                                     "deputy_leader" varchar(150) COLLATE "pg_catalog"."default",
                                     "teammates" text COLLATE "pg_catalog"."default",
                                     "web_system" text COLLATE "pg_catalog"."default",
                                     "business_topology" text COLLATE "pg_catalog"."default",
                                     "area" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                     "stage" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                     "release" int4 NOT NULL DEFAULT 0
)
;

ALTER TABLE "t_major_safeguard" OWNER TO "dbapp";

COMMENT ON COLUMN "t_major_safeguard"."id" IS '重大保障ID';

COMMENT ON COLUMN "t_major_safeguard"."name" IS '重大保障任务名称';

COMMENT ON COLUMN "t_major_safeguard"."description" IS '重大保障任务描述';

COMMENT ON COLUMN "t_major_safeguard"."activity_start_time" IS '活动开始时间';

COMMENT ON COLUMN "t_major_safeguard"."activity_end_time" IS '活动结束时间';

COMMENT ON COLUMN "t_major_safeguard"."prepare_time" IS '准备时间';

COMMENT ON COLUMN "t_major_safeguard"."reopen_time" IS '复盘时间';

COMMENT ON COLUMN "t_major_safeguard"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_major_safeguard"."update_time" IS '修改时间';

COMMENT ON COLUMN "t_major_safeguard"."leader" IS '组长';

COMMENT ON COLUMN "t_major_safeguard"."deputy_leader" IS '副组长';

COMMENT ON COLUMN "t_major_safeguard"."teammates" IS '组员';

COMMENT ON COLUMN "t_major_safeguard"."web_system" IS '保障应用';

COMMENT ON COLUMN "t_major_safeguard"."business_topology" IS '业务拓扑';

COMMENT ON COLUMN "t_major_safeguard"."area" IS '保障地区';

COMMENT ON COLUMN "t_major_safeguard"."stage" IS '保障阶段，备战、临战、实战、战后复盘、结束';

COMMENT ON COLUMN "t_major_safeguard"."release" IS '发布大屏，0-不发布，1-发布大屏';

DROP SEQUENCE IF EXISTS "t_major_safeguard_id_seq";
CREATE SEQUENCE "t_major_safeguard_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_major_safeguard_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_major_safeguard"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_major_safeguard"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_major_safeguard"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_major_safeguard"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_major_safeguard"();

ALTER TABLE "t_major_safeguard" ADD CONSTRAINT "idx_92515_primary" PRIMARY KEY ("id");
