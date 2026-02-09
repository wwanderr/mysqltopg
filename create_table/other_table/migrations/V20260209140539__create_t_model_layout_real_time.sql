/*
 * Table: t_model_layout_real_time
 * Generated: 2026-02-09 14:05:59
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_model_layout_real_time";

CREATE TABLE "t_model_layout_real_time" (
                                            "id" int8 NOT NULL DEFAULT nextval('t_model_layout_real_time_id_seq'::regclass),
                                            "username" varchar(255) COLLATE "pg_catalog"."default",
                                            "layoutid" varchar(255) COLLATE "pg_catalog"."default",
                                            "img" text COLLATE "pg_catalog"."default",
                                            "topo" text COLLATE "pg_catalog"."default",
                                            "baseinfojson" text COLLATE "pg_catalog"."default",
                                            "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                            "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                            "relational_map" text COLLATE "pg_catalog"."default"
)
;

ALTER TABLE "t_model_layout_real_time" OWNER TO "dbapp";

COMMENT ON COLUMN "t_model_layout_real_time"."username" IS '用户英文名';

COMMENT ON COLUMN "t_model_layout_real_time"."layoutid" IS '模型编排Id';

COMMENT ON COLUMN "t_model_layout_real_time"."img" IS '结构缩略图';

COMMENT ON COLUMN "t_model_layout_real_time"."topo" IS '前端拓扑结构';

COMMENT ON COLUMN "t_model_layout_real_time"."baseinfojson" IS '基础信息';

COMMENT ON COLUMN "t_model_layout_real_time"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_model_layout_real_time"."update_time" IS '修改时间';

COMMENT ON COLUMN "t_model_layout_real_time"."relational_map" IS '替前端存储的关联关系';

BEGIN;
COMMIT;

DROP SEQUENCE IF EXISTS "t_model_layout_real_time_id_seq";
CREATE SEQUENCE "t_model_layout_real_time_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_model_layout_real_time_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_model_layout_real_time" ADD CONSTRAINT "idx_92572_primary" PRIMARY KEY ("id");
