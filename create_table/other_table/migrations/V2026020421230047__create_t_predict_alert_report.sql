/*
 * Table: t_predict_alert_report
 * Generated: 2026-02-09 13:48:09
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_predict_alert_report";

CREATE TABLE "t_predict_alert_report" (
                                          "id" int8 NOT NULL DEFAULT nextval('t_predict_alert_report_id_seq'::regclass),
                                          "serial_id" char(14) COLLATE "pg_catalog"."default" NOT NULL,
                                          "subject" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                          "tags" text COLLATE "pg_catalog"."default",
                                          "level" "t_predict_alert_report_level",
                                          "security_object" varchar(255) COLLATE "pg_catalog"."default",
                                          "security_detail" text COLLATE "pg_catalog"."default",
                                          "security_detail_text" text COLLATE "pg_catalog"."default",
                                          "security_info" text COLLATE "pg_catalog"."default",
                                          "author" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                          "author_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                          "type" "t_predict_alert_report_type" NOT NULL DEFAULT '0'::t_predict_alert_report_type,
                                          "publisher" varchar(255) COLLATE "pg_catalog"."default",
                                          "publisher_id" varchar(255) COLLATE "pg_catalog"."default",
                                          "report_created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                          "report_status" "t_predict_alert_report_report_status" NOT NULL DEFAULT '0'::t_predict_alert_report_report_status,
                                          "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                          "updated_at" timestamp,
                                          "attach_files" text COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_predict_alert_report" OWNER TO "dbapp";

COMMENT ON COLUMN "t_predict_alert_report"."id" IS '表的自增序列';

COMMENT ON COLUMN "t_predict_alert_report"."serial_id" IS '通报预警编号, 14个字符的定长序列, YYMMDDHHMM + 四位数字(0001 - 9999), 如 19011112120001';

COMMENT ON COLUMN "t_predict_alert_report"."subject" IS '预警通报主题';

COMMENT ON COLUMN "t_predict_alert_report"."tags" IS '标签名称, 逗号分隔';

COMMENT ON COLUMN "t_predict_alert_report"."level" IS '预警通报级别, 紧急:0, 警告:1, 一般:2';

COMMENT ON COLUMN "t_predict_alert_report"."security_object" IS '安全对象, 如: IP, 主机名, 服务器, 部门等';

COMMENT ON COLUMN "t_predict_alert_report"."security_detail" IS '安全的详细描述';

COMMENT ON COLUMN "t_predict_alert_report"."security_detail_text" IS '安全的详细描述';

COMMENT ON COLUMN "t_predict_alert_report"."security_info" IS '安全的举证信息: 告警事件ID, 资产IP, 域名/URL, 攻击IP';

COMMENT ON COLUMN "t_predict_alert_report"."author" IS '预警创建人';

COMMENT ON COLUMN "t_predict_alert_report"."author_id" IS '预警创建人在t_user表中的id';

COMMENT ON COLUMN "t_predict_alert_report"."type" IS '记录所属类别:预警 0, 通报 1';

COMMENT ON COLUMN "t_predict_alert_report"."publisher" IS '通报发布人';

COMMENT ON COLUMN "t_predict_alert_report"."publisher_id" IS '通报发布人在t_user表中的id';

COMMENT ON COLUMN "t_predict_alert_report"."report_created_at" IS '通报创建时间';

COMMENT ON COLUMN "t_predict_alert_report"."report_status" IS '通报是否被关闭: 0未关闭, 1关闭';

COMMENT ON COLUMN "t_predict_alert_report"."created_at" IS '记录创建时间';

COMMENT ON COLUMN "t_predict_alert_report"."updated_at" IS '记录更新时间';

COMMENT ON COLUMN "t_predict_alert_report"."attach_files" IS '工单附件';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_predict_alert_report_id_seq";
CREATE SEQUENCE "t_predict_alert_report_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_predict_alert_report_id_seq" OWNER TO "dbapp";

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_predict_alert_report"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_predict_alert_report"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.updated_at = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_predict_alert_report"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_predict_alert_report"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_predict_alert_report"();

ALTER TABLE "t_predict_alert_report" ADD CONSTRAINT "idx_92711_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_92711_table.hash.unique.key.serial_id" ON "t_predict_alert_report" USING btree (
    "serial_id" COLLATE "pg_catalog"."default" "pg_catalog"."bpchar_ops" ASC NULLS LAST
    );
