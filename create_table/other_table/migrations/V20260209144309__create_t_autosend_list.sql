/*
 * Table: t_autosend_list
 * Generated: 2026-02-09 14:43:05
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_autosend_list_id_seq";
CREATE SEQUENCE "t_autosend_list_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_autosend_list_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_autosend_list";

CREATE TABLE "t_autosend_list" (
                                   "id" int8 NOT NULL DEFAULT nextval('t_autosend_list_id_seq'::regclass),
                                   "report_name" varchar(1024) COLLATE "pg_catalog"."default",
                                   "is_enable" varchar(20) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '0'::character varying,
                                   "period" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
                                   "create_time" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                   "statistics_time" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                   "time_range" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                   "send_format" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                   "begin_time" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                   "end_time" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                   "mail" varchar(1024) COLLATE "pg_catalog"."default",
                                   "milli" varchar(50) COLLATE "pg_catalog"."default" NOT NULL
)
;

ALTER TABLE "t_autosend_list" OWNER TO "dbapp";

COMMENT ON COLUMN "t_autosend_list"."id" IS '主键Id';

COMMENT ON COLUMN "t_autosend_list"."is_enable" IS '是否启用';

COMMENT ON COLUMN "t_autosend_list"."period" IS '发送周期,day,week,month';

COMMENT ON COLUMN "t_autosend_list"."create_time" IS '生成时间';

COMMENT ON COLUMN "t_autosend_list"."statistics_time" IS '统计时间';

COMMENT ON COLUMN "t_autosend_list"."time_range" IS '时间范围';

COMMENT ON COLUMN "t_autosend_list"."send_format" IS '发送格式';

COMMENT ON COLUMN "t_autosend_list"."milli" IS '最后更新时间';

BEGIN;
COMMIT;

ALTER TABLE "t_autosend_list" ADD CONSTRAINT "idx_92098_primary" PRIMARY KEY ("id");
