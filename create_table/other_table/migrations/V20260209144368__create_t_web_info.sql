/*
 * Table: t_web_info
 * Generated: 2026-02-09 14:43:09
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_web_info_id_seq";
CREATE SEQUENCE "t_web_info_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_web_info_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_web_info";

CREATE TABLE "t_web_info" (
                              "id" int8 NOT NULL DEFAULT nextval('t_web_info_id_seq'::regclass),
                              "desthostname" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                              "webname" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "type" varchar(45) COLLATE "pg_catalog"."default" DEFAULT 'Web业务系统'::character varying,
                              "importance" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "tag" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "personincharge" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "developer" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "visitaddress" int8 DEFAULT '1'::bigint,
                              "visitaddressvalue" varchar(1000) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "osversion" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "technologyarc" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "servercomponentversion" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "webcontainnername" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "webcontainnerversion" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "systemno" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "systemstats" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "organisation" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "webuser" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "confidentiality" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "integrity" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "availability" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "ishierarchyprotection" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "description" varchar(500) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "netrafficmonitor" int8 DEFAULT '1'::bigint,
                              "accessmonitor" int8 DEFAULT '0'::bigint,
                              "accessrate" int8 DEFAULT '80'::bigint,
                              "location" varchar(45) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
                              "accessratevalue" varchar(45) COLLATE "pg_catalog"."default" DEFAULT '0,0,0,0,0,0,0'::character varying,
                              "visitcount" varchar(256) COLLATE "pg_catalog"."default" DEFAULT '0,0,0,0,0,0,0'::character varying,
                              "source" varchar(45) COLLATE "pg_catalog"."default" DEFAULT '0'::character varying,
                              "shigh" int8,
                              "smiddle" int8,
                              "slow" int8,
                              "request" varchar(45) COLLATE "pg_catalog"."default",
                              "response" varchar(45) COLLATE "pg_catalog"."default",
                              "createtime" timestamp DEFAULT CURRENT_TIMESTAMP,
                              "updatetime" timestamp DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_web_info" OWNER TO "dbapp";

COMMENT ON COLUMN "t_web_info"."desthostname" IS '域名';

COMMENT ON COLUMN "t_web_info"."webname" IS '系统名称';

COMMENT ON COLUMN "t_web_info"."type" IS '系统类型';

COMMENT ON COLUMN "t_web_info"."importance" IS '系统重要性';

COMMENT ON COLUMN "t_web_info"."tag" IS '系统标签';

COMMENT ON COLUMN "t_web_info"."personincharge" IS '责任人';

COMMENT ON COLUMN "t_web_info"."developer" IS '开发商';

COMMENT ON COLUMN "t_web_info"."visitaddress" IS '访问地址状态：0关闭，1开启。';

COMMENT ON COLUMN "t_web_info"."visitaddressvalue" IS '访问地址';

COMMENT ON COLUMN "t_web_info"."osversion" IS '系统版本';

COMMENT ON COLUMN "t_web_info"."technologyarc" IS '技术架构';

COMMENT ON COLUMN "t_web_info"."servercomponentversion" IS '服务组件版本';

COMMENT ON COLUMN "t_web_info"."webcontainnername" IS 'Web容器名称';

COMMENT ON COLUMN "t_web_info"."webcontainnerversion" IS 'Web容器版本';

COMMENT ON COLUMN "t_web_info"."systemno" IS '系统编号';

COMMENT ON COLUMN "t_web_info"."systemstats" IS '系统状态';

COMMENT ON COLUMN "t_web_info"."organisation" IS '组织架构';

COMMENT ON COLUMN "t_web_info"."webuser" IS '使用人';

COMMENT ON COLUMN "t_web_info"."confidentiality" IS 'C-机密性';

COMMENT ON COLUMN "t_web_info"."integrity" IS 'I-完整性';

COMMENT ON COLUMN "t_web_info"."availability" IS 'A-可用性';

COMMENT ON COLUMN "t_web_info"."ishierarchyprotection" IS '是否等保';

COMMENT ON COLUMN "t_web_info"."description" IS '描述';

COMMENT ON COLUMN "t_web_info"."netrafficmonitor" IS '流量监控；0关闭，1开启（默认）';

COMMENT ON COLUMN "t_web_info"."accessmonitor" IS '访问成功率监控：0关闭，1开启';

COMMENT ON COLUMN "t_web_info"."accessrate" IS '访问成功率';

COMMENT ON COLUMN "t_web_info"."location" IS '地理位置';

COMMENT ON COLUMN "t_web_info"."accessratevalue" IS '访问成功率7个点';

COMMENT ON COLUMN "t_web_info"."visitcount" IS '访问次数7个点';

COMMENT ON COLUMN "t_web_info"."source" IS '来源:0-人工录入，1-Web自动发现';

COMMENT ON COLUMN "t_web_info"."request" IS '请求';

COMMENT ON COLUMN "t_web_info"."response" IS '响应';

BEGIN;
COMMIT;

ALTER TABLE "t_web_info" ADD CONSTRAINT "idx_93345_primary" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "idx_93345_desthostname_unique" ON "t_web_info" USING btree (
    "desthostname" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
