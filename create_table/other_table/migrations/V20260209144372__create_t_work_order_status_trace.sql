/*
 * Table: t_work_order_status_trace
 * Generated: 2026-02-09 14:43:09
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_work_order_status_trace_id_seq";
CREATE SEQUENCE "t_work_order_status_trace_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_work_order_status_trace_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_work_order_status_trace";

CREATE TABLE "t_work_order_status_trace" (
                                             "id" int8 NOT NULL DEFAULT nextval('t_work_order_status_trace_id_seq'::regclass),
                                             "org_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                             "serial_id" char(14) COLLATE "pg_catalog"."default" NOT NULL,
                                             "status" "t_work_order_status_trace_status" NOT NULL DEFAULT '0'::t_work_order_status_trace_status,
                                             "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_work_order_status_trace" OWNER TO "dbapp";

COMMENT ON COLUMN "t_work_order_status_trace"."id" IS '数据库自增id';

COMMENT ON COLUMN "t_work_order_status_trace"."org_id" IS '工单所属组织id';

COMMENT ON COLUMN "t_work_order_status_trace"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';

COMMENT ON COLUMN "t_work_order_status_trace"."status" IS '订单状态, 未处理:0 ,处理中:1,已解决:2,已关闭:3,已删除:4';

COMMENT ON COLUMN "t_work_order_status_trace"."created_at" IS '记录创建时间';

BEGIN;
COMMIT;

ALTER TABLE "t_work_order_status_trace" ADD CONSTRAINT "idx_93413_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_93413_table.btree.key.org_id" ON "t_work_order_status_trace" USING btree (
    "org_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

CREATE INDEX "idx_93413_table.btree.key.serial_id" ON "t_work_order_status_trace" USING btree (
    "serial_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
    );
