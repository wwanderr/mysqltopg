/*
 * Table: t_asset_cal_results
 * Generated: 2026-02-09 13:48:07
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_asset_cal_results";

CREATE TABLE "t_asset_cal_results" (
                                       "id" int8 NOT NULL DEFAULT nextval('t_asset_cal_results_id_seq'::regclass),
                                       "assetip" varchar(45) COLLATE "pg_catalog"."default" NOT NULL,
                                       "flawhigh" int8 DEFAULT '0'::bigint,
                                       "flawlow" int8 DEFAULT '0'::bigint,
                                       "flawmiddle" int8 DEFAULT '0'::bigint,
                                       "flawsum" int8 DEFAULT '0'::bigint,
                                       "incidenthigh" int8 DEFAULT '0'::bigint,
                                       "incidentlow" int8 DEFAULT '0'::bigint,
                                       "incidentmiddle" int8 DEFAULT '0'::bigint,
                                       "incidentsum" int8 DEFAULT '0'::bigint,
                                       "score" float8 DEFAULT '-1'::double precision,
                                       "logcount" float8 DEFAULT '0'::double precision,
                                       "assetlevel" int8 DEFAULT '0'::bigint,
                                       "alarm_top" varchar(2000) COLLATE "pg_catalog"."default",
                                       "last_alarm_time" varchar(100) COLLATE "pg_catalog"."default",
                                       "first_fallen_time" varchar(100) COLLATE "pg_catalog"."default",
                                       "update_time" timestamp
)
;

ALTER TABLE "t_asset_cal_results" OWNER TO "dbapp";

COMMENT ON COLUMN "t_asset_cal_results"."id" IS '主键Id';

COMMENT ON COLUMN "t_asset_cal_results"."assetip" IS '资产ip';

COMMENT ON COLUMN "t_asset_cal_results"."score" IS '评分';

COMMENT ON COLUMN "t_asset_cal_results"."assetlevel" IS '资产评级';

COMMENT ON COLUMN "t_asset_cal_results"."alarm_top" IS '告警topN';

COMMENT ON COLUMN "t_asset_cal_results"."last_alarm_time" IS '最近告警发生时间';

COMMENT ON COLUMN "t_asset_cal_results"."first_fallen_time" IS '首次失陷时间';

COMMENT ON COLUMN "t_asset_cal_results"."update_time" IS '数据更新时间';

COMMENT ON TABLE "t_asset_cal_results" IS '资产管理-资产计算结果';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_asset_cal_results_id_seq";
CREATE SEQUENCE "t_asset_cal_results_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_asset_cal_results_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_asset_cal_results"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_asset_cal_results"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_asset_cal_results"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_asset_cal_results"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_asset_cal_results"();

ALTER TABLE "t_asset_cal_results" ADD CONSTRAINT "idx_91939_primary" PRIMARY KEY ("id");
