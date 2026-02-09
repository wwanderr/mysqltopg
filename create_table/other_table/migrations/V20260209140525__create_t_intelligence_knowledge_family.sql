/*
 * Table: t_intelligence_knowledge_family
 * Generated: 2026-02-09 14:05:58
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_intelligence_knowledge_family";

CREATE TABLE "t_intelligence_knowledge_family" (
                                                   "id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
                                                   "name" varchar(200) COLLATE "pg_catalog"."default",
                                                   "alias" text COLLATE "pg_catalog"."default",
                                                   "organization_ids" text COLLATE "pg_catalog"."default",
                                                   "organization_names" text COLLATE "pg_catalog"."default",
                                                   "description" text COLLATE "pg_catalog"."default",
                                                   "os" text COLLATE "pg_catalog"."default",
                                                   "refs" text COLLATE "pg_catalog"."default",
                                                   "expired" bool,
                                                   "update_time" text COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_intelligence_knowledge_family" OWNER TO "dbapp";

COMMENT ON COLUMN "t_intelligence_knowledge_family"."id" IS '唯一ID编号，可以和情报中family_id做关联';

COMMENT ON COLUMN "t_intelligence_knowledge_family"."name" IS '家族名称';

COMMENT ON COLUMN "t_intelligence_knowledge_family"."alias" IS '别名';

COMMENT ON COLUMN "t_intelligence_knowledge_family"."organization_names" IS '关联组织名称';

COMMENT ON COLUMN "t_intelligence_knowledge_family"."description" IS '详情描述';

COMMENT ON COLUMN "t_intelligence_knowledge_family"."os" IS '该家族影响的平台';

COMMENT ON COLUMN "t_intelligence_knowledge_family"."refs" IS '家族信息参考链接';

COMMENT ON COLUMN "t_intelligence_knowledge_family"."expired" IS '是否失效，false -未失效，true- 已失效';

COMMENT ON COLUMN "t_intelligence_knowledge_family"."update_time" IS '更新时间，毫秒级时间戳';

BEGIN;
COMMIT;

ALTER TABLE "t_intelligence_knowledge_family" ADD CONSTRAINT "idx_92371_primary" PRIMARY KEY ("id");
