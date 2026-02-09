/*
 * Table: t_topology_configuration
 * Generated: 2026-02-09 14:43:08
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_topology_configuration_id_seq";
CREATE SEQUENCE "t_topology_configuration_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_topology_configuration_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_topology_configuration";

CREATE TABLE "t_topology_configuration" (
                                            "id" int8 NOT NULL DEFAULT nextval('t_topology_configuration_id_seq'::regclass),
                                            "businessid" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                            "topo" text COLLATE "pg_catalog"."default",
                                            "img" text COLLATE "pg_catalog"."default",
                                            "assets" text COLLATE "pg_catalog"."default",
                                            "relationship" text COLLATE "pg_catalog"."default",
                                            "relateddata" text COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_topology_configuration" OWNER TO "dbapp";

COMMENT ON COLUMN "t_topology_configuration"."id" IS 'id';

COMMENT ON COLUMN "t_topology_configuration"."businessid" IS '业务id';

COMMENT ON COLUMN "t_topology_configuration"."topo" IS '拓扑配置';

COMMENT ON COLUMN "t_topology_configuration"."img" IS '拓扑缩略图';

COMMENT ON COLUMN "t_topology_configuration"."assets" IS '业务资产组';

COMMENT ON COLUMN "t_topology_configuration"."relationship" IS '资产连接关系';

COMMENT ON COLUMN "t_topology_configuration"."relateddata" IS '拓扑图相安全域、web业务系统、安全设备等id集合';

ALTER TABLE "t_topology_configuration" ADD CONSTRAINT "idx_93194_primary" PRIMARY KEY ("id");
