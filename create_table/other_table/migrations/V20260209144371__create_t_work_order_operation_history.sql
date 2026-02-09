/*
 * Table: t_work_order_operation_history
 * Generated: 2026-02-09 14:43:09
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_work_order_operation_history_id_seq";
CREATE SEQUENCE "t_work_order_operation_history_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_work_order_operation_history_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_work_order_operation_history";

CREATE TABLE "t_work_order_operation_history" (
                                                  "id" int8 NOT NULL DEFAULT nextval('t_work_order_operation_history_id_seq'::regclass),
                                                  "serial_id" char(14) COLLATE "pg_catalog"."default" NOT NULL,
                                                  "operater" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                                  "operater_host_address" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                                  "operater_operations" text COLLATE "pg_catalog"."default" NOT NULL,
                                                  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                                  "action" "t_work_order_operation_history_action" NOT NULL DEFAULT '-1'::t_work_order_operation_history_action
)
;

ALTER TABLE "t_work_order_operation_history" OWNER TO "dbapp";

COMMENT ON COLUMN "t_work_order_operation_history"."id" IS '表自增序列';

COMMENT ON COLUMN "t_work_order_operation_history"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';

COMMENT ON COLUMN "t_work_order_operation_history"."operater" IS '工单修改人';

COMMENT ON COLUMN "t_work_order_operation_history"."operater_host_address" IS '工单修改人的主机地址';

COMMENT ON COLUMN "t_work_order_operation_history"."operater_operations" IS '工单修改人的操作';

COMMENT ON COLUMN "t_work_order_operation_history"."created_at" IS '记录创建时间';

COMMENT ON COLUMN "t_work_order_operation_history"."action" IS '处置动作, 未知动作: -1, 请处理: 0, 请审批: 1, 请审核: 2, 请修补: 3, 请查杀: 4, 请验证: 5, 请测试: 6';

BEGIN;
COMMIT;

ALTER TABLE "t_work_order_operation_history" ADD CONSTRAINT "idx_93404_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_93404_table.hash.key.serial_id" ON "t_work_order_operation_history" USING btree (
    "serial_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
    );
