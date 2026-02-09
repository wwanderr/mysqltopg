/*
 * Table: t_autosend_history
 * Generated: 2026-02-09 13:48:07
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_autosend_history";

CREATE TABLE "t_autosend_history" (
                                      "id" int8 NOT NULL DEFAULT nextval('t_autosend_history_id_seq'::regclass),
                                      "report_name" varchar(1024) COLLATE "pg_catalog"."default",
                                      "send_time" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                      "time_range" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                      "begin_time" timestamp NOT NULL,
                                      "end_time" timestamp NOT NULL,
                                      "send_format" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                      "mail" varchar(1024) COLLATE "pg_catalog"."default",
                                      "result" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
                                      "idbylist" int8 NOT NULL
)
;

ALTER TABLE "t_autosend_history" OWNER TO "dbapp";

COMMENT ON COLUMN "t_autosend_history"."id" IS '主键Id';

COMMENT ON COLUMN "t_autosend_history"."send_time" IS '发送时间';

COMMENT ON COLUMN "t_autosend_history"."time_range" IS '统计时间范围';

COMMENT ON COLUMN "t_autosend_history"."begin_time" IS '统计开始时间';

COMMENT ON COLUMN "t_autosend_history"."end_time" IS '统计结束时间';

COMMENT ON COLUMN "t_autosend_history"."send_format" IS '发送格式';

COMMENT ON COLUMN "t_autosend_history"."result" IS '发送结果';

COMMENT ON COLUMN "t_autosend_history"."idbylist" IS '对应List的ID';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_autosend_history_id_seq";
CREATE SEQUENCE "t_autosend_history_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_autosend_history_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_autosend_history" ADD CONSTRAINT "idx_92091_primary" PRIMARY KEY ("id");
