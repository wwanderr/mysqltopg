/*
 * Table: t_work_order
 * Generated: 2026-02-09 14:06:01
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_work_order";

CREATE TABLE "t_work_order" (
                                "id" int8 NOT NULL DEFAULT nextval('t_work_order_id_seq'::regclass),
                                "serial_id" char(14) COLLATE "pg_catalog"."default" NOT NULL,
                                "subject" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                "tags" text COLLATE "pg_catalog"."default",
                                "priority" "t_work_order_priority" NOT NULL DEFAULT '2'::t_work_order_priority,
                                "assignee" varchar(255) COLLATE "pg_catalog"."default",
                                "assignee_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                "security_object" varchar(255) COLLATE "pg_catalog"."default",
                                "security_detail" text COLLATE "pg_catalog"."default",
                                "security_info" text COLLATE "pg_catalog"."default",
                                "status" "t_work_order_status" NOT NULL DEFAULT '0'::t_work_order_status,
                                "approach" "t_work_order_approach" NOT NULL DEFAULT '0'::t_work_order_approach,
                                "author" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                "author_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                "assignee_comment" text COLLATE "pg_catalog"."default",
                                "security_alert_id" varchar(255) COLLATE "pg_catalog"."default",
                                "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                "updated_at" timestamp,
                                "action" "t_work_order_action" NOT NULL DEFAULT '2'::t_work_order_action,
                                "attach_files" text COLLATE "pg_catalog"."default",
                                "status_modified_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_work_order" OWNER TO "dbapp";

COMMENT ON COLUMN "t_work_order"."id" IS '自增主键';

COMMENT ON COLUMN "t_work_order"."serial_id" IS '工单编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';

COMMENT ON COLUMN "t_work_order"."subject" IS '工单主题';

COMMENT ON COLUMN "t_work_order"."tags" IS '标签名称, 逗号分隔';

COMMENT ON COLUMN "t_work_order"."priority" IS '订单优先级, 高:0,中:1,低:2';

COMMENT ON COLUMN "t_work_order"."assignee" IS '工单受理人';

COMMENT ON COLUMN "t_work_order"."assignee_id" IS '工单受理人在t_user表中的id';

COMMENT ON COLUMN "t_work_order"."security_object" IS '安全对象, 如: IP, 主机名, 服务器, 部门等';

COMMENT ON COLUMN "t_work_order"."security_detail" IS '安全的详细描述';

COMMENT ON COLUMN "t_work_order"."security_info" IS '安全的举证信息: 告警事件ID, 资产IP, 域名/URL, 攻击IP';

COMMENT ON COLUMN "t_work_order"."status" IS '订单状态, 未处理:0 ,处理中:1,已解决:2,已关闭:3';

COMMENT ON COLUMN "t_work_order"."approach" IS '订单录入方式, 人工创建:0, 自动创建:1';

COMMENT ON COLUMN "t_work_order"."author" IS '工单创建人';

COMMENT ON COLUMN "t_work_order"."author_id" IS '工单创建人在t_user表中的id';

COMMENT ON COLUMN "t_work_order"."assignee_comment" IS '工单代理人的备注描述';

COMMENT ON COLUMN "t_work_order"."security_alert_id" IS '安全告警id';

COMMENT ON COLUMN "t_work_order"."created_at" IS '记录创建时间';

COMMENT ON COLUMN "t_work_order"."updated_at" IS '记录更新时间';

COMMENT ON COLUMN "t_work_order"."action" IS '处置动作, 请处理: 0, 请审批: 1, 请审核: 2, 请修补: 3, 请查杀: 4, 请验证: 5, 请测试: 6';

COMMENT ON COLUMN "t_work_order"."attach_files" IS '工单附件';

COMMENT ON COLUMN "t_work_order"."status_modified_at" IS '工单状态修改的时间点';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_work_order_id_seq";
CREATE SEQUENCE "t_work_order_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_work_order_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_work_order"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_work_order"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.updated_at = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_work_order"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_work_order"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_work_order"();

ALTER TABLE "t_work_order" ADD CONSTRAINT "idx_93391_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_93391_table.btree.key.updated_at.status" ON "t_work_order" USING btree (
    "updated_at" "pg_catalog"."timestamp_ops" ASC NULLS LAST,
    "status" "pg_catalog"."enum_ops" ASC NULLS LAST
    );

CREATE UNIQUE INDEX "idx_93391_table.hash.unique.key.serial_id" ON "t_work_order" USING btree (
    "serial_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
    );
