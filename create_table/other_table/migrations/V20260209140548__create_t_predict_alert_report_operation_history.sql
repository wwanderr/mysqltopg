/*
 * Table: t_predict_alert_report_operation_history
 * Generated: 2026-02-09 14:05:59
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_predict_alert_report_operation_history";

CREATE TABLE "t_predict_alert_report_operation_history" (
                                                            "id" int8 NOT NULL DEFAULT nextval('t_predict_alert_report_operation_history_id_seq'::regclass),
                                                            "serial_id" char(14) COLLATE "pg_catalog"."default" NOT NULL,
                                                            "operater" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                                            "operater_host_address" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                                            "operater_operations" text COLLATE "pg_catalog"."default" NOT NULL,
                                                            "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_predict_alert_report_operation_history" OWNER TO "dbapp";

COMMENT ON COLUMN "t_predict_alert_report_operation_history"."id" IS '表自增序列';

COMMENT ON COLUMN "t_predict_alert_report_operation_history"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';

COMMENT ON COLUMN "t_predict_alert_report_operation_history"."operater" IS '预警通报修改人';

COMMENT ON COLUMN "t_predict_alert_report_operation_history"."operater_host_address" IS '预警通报修改人的主机地址';

COMMENT ON COLUMN "t_predict_alert_report_operation_history"."operater_operations" IS '预警通报修改人的操作';

COMMENT ON COLUMN "t_predict_alert_report_operation_history"."created_at" IS '记录创建时间';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_predict_alert_report_operation_history_id_seq";
CREATE SEQUENCE "t_predict_alert_report_operation_history_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_predict_alert_report_operation_history_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_predict_alert_report_operation_history" ADD CONSTRAINT "idx_92722_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_92722_table.hash.key.serial_id" ON "t_predict_alert_report_operation_history" USING btree (
    "serial_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
    );
