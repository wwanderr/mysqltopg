/*
 * Table: t_topology_business
 * Generated: 2026-02-09 14:43:08
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_topology_business";

CREATE TABLE "t_topology_business" (
                                       "id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                       "businessname" varchar(25) COLLATE "pg_catalog"."default" NOT NULL,
                                       "description" varchar(500) COLLATE "pg_catalog"."default",
                                       "publish" int4 DEFAULT 1
)
;

ALTER TABLE "t_topology_business" OWNER TO "dbapp";

COMMENT ON COLUMN "t_topology_business"."id" IS '业务id';

COMMENT ON COLUMN "t_topology_business"."businessname" IS '业务名称';

COMMENT ON COLUMN "t_topology_business"."description" IS '业务描述';

COMMENT ON COLUMN "t_topology_business"."publish" IS '是否发布(1-发布;

ALTER TABLE "t_topology_business" ADD CONSTRAINT "idx_93187_primary" PRIMARY KEY ("id");
