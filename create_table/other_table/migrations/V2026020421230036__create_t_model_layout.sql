/*
 * Table: t_model_layout
 * Generated: 2026-02-09 13:48:09
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_model_layout";

CREATE TABLE "t_model_layout" (
                                  "id" int8 NOT NULL DEFAULT nextval('t_model_layout_id_seq'::regclass),
                                  "model_id" varchar(255) COLLATE "pg_catalog"."default",
                                  "model_layout" text COLLATE "pg_catalog"."default",
                                  "img" text COLLATE "pg_catalog"."default",
                                  "topo" text COLLATE "pg_catalog"."default",
                                  "related_models" text COLLATE "pg_catalog"."default",
                                  "related_models_num" int8,
                                  "related_metrics" text COLLATE "pg_catalog"."default",
                                  "related_metrics_num" int8,
                                  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                  "filterstr" text COLLATE "pg_catalog"."default",
                                  "isquoted" int2,
                                  "layout_id" varchar(255) COLLATE "pg_catalog"."default",
                                  "layout_name" varchar(255) COLLATE "pg_catalog"."default",
                                  "model_name" varchar(255) COLLATE "pg_catalog"."default",
                                  "state" int2,
                                  "description" varchar(255) COLLATE "pg_catalog"."default",
                                  "suggest" varchar(255) COLLATE "pg_catalog"."default",
                                  "killchain" varchar(255) COLLATE "pg_catalog"."default",
                                  "severity" varchar(255) COLLATE "pg_catalog"."default",
                                  "attackintent" varchar(255) COLLATE "pg_catalog"."default",
                                  "attackmethod" varchar(255) COLLATE "pg_catalog"."default",
                                  "attackstrategy" varchar(255) COLLATE "pg_catalog"."default",
                                  "tags" varchar(255) COLLATE "pg_catalog"."default",
                                  "relational_map" text COLLATE "pg_catalog"."default",
                                  "isfactory" int2 DEFAULT '0'::smallint
)
;

ALTER TABLE "t_model_layout" OWNER TO "dbapp";

COMMENT ON COLUMN "t_model_layout"."model_id" IS '模型英文名';

COMMENT ON COLUMN "t_model_layout"."model_layout" IS '模型结构';

COMMENT ON COLUMN "t_model_layout"."img" IS '结构缩略图';

COMMENT ON COLUMN "t_model_layout"."topo" IS '前端拓扑结构';

COMMENT ON COLUMN "t_model_layout"."related_models" IS '相关联模型';

COMMENT ON COLUMN "t_model_layout"."related_models_num" IS '相关联模型数目';

COMMENT ON COLUMN "t_model_layout"."related_metrics" IS '相关联模型';

COMMENT ON COLUMN "t_model_layout"."related_metrics_num" IS '相关联指标数目';

COMMENT ON COLUMN "t_model_layout"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_model_layout"."update_time" IS '修改时间';

COMMENT ON COLUMN "t_model_layout"."filterstr" IS '模型过滤条件';

COMMENT ON COLUMN "t_model_layout"."isquoted" IS '模型是否被引用';

COMMENT ON COLUMN "t_model_layout"."layout_id" IS '剧本编排英文名';

COMMENT ON COLUMN "t_model_layout"."layout_name" IS '剧本编排中文名';

COMMENT ON COLUMN "t_model_layout"."model_name" IS '模型中文名';

COMMENT ON COLUMN "t_model_layout"."state" IS '编排启用禁用状态';

COMMENT ON COLUMN "t_model_layout"."description" IS '剧本描述';

COMMENT ON COLUMN "t_model_layout"."suggest" IS '剧本建议';

COMMENT ON COLUMN "t_model_layout"."killchain" IS '剧本攻击链';

COMMENT ON COLUMN "t_model_layout"."severity" IS '剧本等级';

COMMENT ON COLUMN "t_model_layout"."attackintent" IS '剧本攻击意图';

COMMENT ON COLUMN "t_model_layout"."attackmethod" IS '剧本攻击方法';

COMMENT ON COLUMN "t_model_layout"."attackstrategy" IS '剧本攻击策略';

COMMENT ON COLUMN "t_model_layout"."tags" IS '剧本标签';

COMMENT ON COLUMN "t_model_layout"."relational_map" IS '替前端存储的关联关系';

COMMENT ON COLUMN "t_model_layout"."isfactory" IS '是否为出厂剧本编排';

DROP SEQUENCE IF EXISTS "t_model_layout_id_seq";
CREATE SEQUENCE "t_model_layout_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_model_layout_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_model_layout" ADD CONSTRAINT "idx_92548_primary" PRIMARY KEY ("id");
