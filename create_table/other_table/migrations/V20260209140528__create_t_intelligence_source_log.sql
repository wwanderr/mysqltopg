/*
 * Table: t_intelligence_source_log
 * Generated: 2026-02-09 14:05:58
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_intelligence_source_log";

CREATE TABLE "t_intelligence_source_log" (
                                             "id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                             "intelligence_source_code" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                             "update_type" "t_intelligence_source_log_update_type" NOT NULL,
                                             "operator" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
                                             "ip" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                             "update_time" timestamp,
                                             "state" int8,
                                             "progress" varchar(100) COLLATE "pg_catalog"."default",
                                             "log" text COLLATE "pg_catalog"."default",
                                             "effective_rows" int8 NOT NULL DEFAULT '0'::bigint,
                                             "failed_rows" int8 NOT NULL DEFAULT '0'::bigint,
                                             "file" varchar(100) COLLATE "pg_catalog"."default",
                                             "delete" int2 NOT NULL DEFAULT '0'::smallint,
                                             "dasca_device_id" varchar(50) COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_intelligence_source_log" OWNER TO "dbapp";

COMMENT ON COLUMN "t_intelligence_source_log"."id" IS '更新日志ID';

COMMENT ON COLUMN "t_intelligence_source_log"."intelligence_source_code" IS '情报源英文标识';

COMMENT ON COLUMN "t_intelligence_source_log"."update_type" IS '情报操作类型';

COMMENT ON COLUMN "t_intelligence_source_log"."operator" IS '操作人';

COMMENT ON COLUMN "t_intelligence_source_log"."ip" IS '操作者ip';

COMMENT ON COLUMN "t_intelligence_source_log"."update_time" IS '更新时间';

COMMENT ON COLUMN "t_intelligence_source_log"."state" IS '操作状态，0-开始，1-进行中，2-成功，3-失败，4-取消，5-异常，大于1为结束';

COMMENT ON COLUMN "t_intelligence_source_log"."progress" IS '操作进度';

COMMENT ON COLUMN "t_intelligence_source_log"."log" IS '备注，操作日志';

COMMENT ON COLUMN "t_intelligence_source_log"."effective_rows" IS '影响情报数据量';

COMMENT ON COLUMN "t_intelligence_source_log"."failed_rows" IS '失败情报数';

COMMENT ON COLUMN "t_intelligence_source_log"."file" IS '情报导入包名称';

COMMENT ON COLUMN "t_intelligence_source_log"."delete" IS '所属情报库是否被删除，0-false，1-true';

COMMENT ON COLUMN "t_intelligence_source_log"."dasca_device_id" IS 'dasca_device_id';

BEGIN;
COMMIT;

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_intelligence_source_log"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_intelligence_source_log"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_intelligence_source_log"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_intelligence_source_log"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_intelligence_source_log"();

ALTER TABLE "t_intelligence_source_log" ADD CONSTRAINT "idx_92392_primary" PRIMARY KEY ("id");
