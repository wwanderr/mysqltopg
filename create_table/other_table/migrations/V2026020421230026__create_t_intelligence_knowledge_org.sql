/*
 * Table: t_intelligence_knowledge_org
 * Generated: 2026-02-09 13:48:08
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_intelligence_knowledge_org";

CREATE TABLE "t_intelligence_knowledge_org" (
                                                "id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
                                                "name" varchar(200) COLLATE "pg_catalog"."default",
                                                "attack_method" text COLLATE "pg_catalog"."default",
                                                "regions" text COLLATE "pg_catalog"."default",
                                                "industries" text COLLATE "pg_catalog"."default",
                                                "description" text COLLATE "pg_catalog"."default",
                                                "os" text COLLATE "pg_catalog"."default",
                                                "refs" text COLLATE "pg_catalog"."default",
                                                "expired" bool,
                                                "update_time" text COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_intelligence_knowledge_org" OWNER TO "dbapp";

COMMENT ON COLUMN "t_intelligence_knowledge_org"."id" IS '唯一ID编号，可以和情报中organization_id做关联';

COMMENT ON COLUMN "t_intelligence_knowledge_org"."name" IS '组织名称';

COMMENT ON COLUMN "t_intelligence_knowledge_org"."attack_method" IS '攻击方法';

COMMENT ON COLUMN "t_intelligence_knowledge_org"."regions" IS '团伙所在国家/地区';

COMMENT ON COLUMN "t_intelligence_knowledge_org"."industries" IS '受影响的行业';

COMMENT ON COLUMN "t_intelligence_knowledge_org"."description" IS '详情描述';

COMMENT ON COLUMN "t_intelligence_knowledge_org"."os" IS '该家族影响的系统';

COMMENT ON COLUMN "t_intelligence_knowledge_org"."refs" IS '报告链接';

COMMENT ON COLUMN "t_intelligence_knowledge_org"."expired" IS '是否失效，false -未失效，true- 已失效';

COMMENT ON COLUMN "t_intelligence_knowledge_org"."update_time" IS '更新时间，毫秒级时间戳';

BEGIN;
COMMIT;

ALTER TABLE "t_intelligence_knowledge_org" ADD CONSTRAINT "idx_92377_primary" PRIMARY KEY ("id");
