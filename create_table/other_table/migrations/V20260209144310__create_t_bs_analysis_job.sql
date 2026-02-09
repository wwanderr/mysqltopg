/*
 * Table: t_bs_analysis_job
 * Generated: 2026-02-09 14:43:05
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_bs_analysis_job_id_seq";
CREATE SEQUENCE "t_bs_analysis_job_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_bs_analysis_job_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_bs_analysis_job";

CREATE TABLE "t_bs_analysis_job" (
                                     "id" int8 NOT NULL DEFAULT nextval('t_bs_analysis_job_id_seq'::regclass),
                                     "code" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                     "name" varchar(255) COLLATE "pg_catalog"."default",
                                     "description" varchar(1000) COLLATE "pg_catalog"."default",
                                     "prefix" varchar(100) COLLATE "pg_catalog"."default",
                                     "script_type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                     "script_path" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
                                     "job_config" text COLLATE "pg_catalog"."default",
                                     "status" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
                                     "result" text COLLATE "pg_catalog"."default",
                                     "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                     "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_bs_analysis_job" OWNER TO "dbapp";

COMMENT ON COLUMN "t_bs_analysis_job"."id" IS '主键ID';

COMMENT ON COLUMN "t_bs_analysis_job"."code" IS '任务唯一标识';

COMMENT ON COLUMN "t_bs_analysis_job"."name" IS '任务中文名';

COMMENT ON COLUMN "t_bs_analysis_job"."description" IS '任务描述';

COMMENT ON COLUMN "t_bs_analysis_job"."prefix" IS 'RedisKey前缀';

COMMENT ON COLUMN "t_bs_analysis_job"."script_type" IS '脚本类型';

COMMENT ON COLUMN "t_bs_analysis_job"."script_path" IS '脚本文件路径';

COMMENT ON COLUMN "t_bs_analysis_job"."job_config" IS '任务配置参数（JSON字符串）';

COMMENT ON COLUMN "t_bs_analysis_job"."status" IS '任务状态[running, stopped, failure]';

COMMENT ON COLUMN "t_bs_analysis_job"."result" IS '最后一次操作结果';

COMMENT ON COLUMN "t_bs_analysis_job"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_bs_analysis_job"."update_time" IS '更新时间';

COMMENT ON TABLE "t_bs_analysis_job" IS '离线计算任务管理表';

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_bs_analysis_job"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_bs_analysis_job"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_bs_analysis_job"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_bs_analysis_job"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_bs_analysis_job"();

ALTER TABLE "t_bs_analysis_job" ADD CONSTRAINT "idx_92115_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_92115_code" ON "t_bs_analysis_job" USING btree (
    "code" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
