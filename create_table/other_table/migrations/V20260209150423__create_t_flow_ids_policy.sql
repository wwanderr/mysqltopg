/*
 * Table: t_flow_ids_policy
 * Generated: 2026-02-09 15:04:34
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_flow_ids_policy";

CREATE TABLE "t_flow_ids_policy" (
                                     "ids_policy_id" bytea NOT NULL,
                                     "tenant_id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                                     "security_policy_ids" text COLLATE "pg_catalog"."default" NOT NULL,
                                     "ids_policy_template_id" varchar(1) COLLATE "pg_catalog"."default" NOT NULL,
                                     "ids_policy_template_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                     "enable" bool NOT NULL,
                                     "logging" bool NOT NULL,
                                     "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                     "description" text COLLATE "pg_catalog"."default",
                                     "linked_strategy_id" int8 NOT NULL
)
;

ALTER TABLE "t_flow_ids_policy" OWNER TO "dbapp";

COMMENT ON COLUMN "t_flow_ids_policy"."ids_policy_id" IS 'IDS策略id';

COMMENT ON COLUMN "t_flow_ids_policy"."tenant_id" IS '租户ID';

COMMENT ON COLUMN "t_flow_ids_policy"."security_policy_ids" IS '引用安全策略ID（列表），每个IPS策略对应至少一个安全策略';

COMMENT ON COLUMN "t_flow_ids_policy"."ids_policy_template_id" IS 'IDS策略模板id（1：低级防护模板，2：中级防护模板，3：高级防护模板）（AXDR仅存储）';

COMMENT ON COLUMN "t_flow_ids_policy"."ids_policy_template_name" IS 'IDS策略模板名称（AXDR仅存储）';

COMMENT ON COLUMN "t_flow_ids_policy"."enable" IS '是否启用，0:不启用，1:启用';

COMMENT ON COLUMN "t_flow_ids_policy"."logging" IS '是否开启日志记录，0:不启用，1:启用（AXDR不支持，仅存储）';

COMMENT ON COLUMN "t_flow_ids_policy"."name" IS '策略名称';

COMMENT ON COLUMN "t_flow_ids_policy"."description" IS '策略描述';

COMMENT ON COLUMN "t_flow_ids_policy"."linked_strategy_id" IS '联动策略ID';

COMMENT ON TABLE "t_flow_ids_policy" IS 'STY电信接口规范IDS策略表';

BEGIN;
COMMIT;

ALTER TABLE "t_flow_ids_policy" ADD CONSTRAINT "idx_92351_primary" PRIMARY KEY ("ids_policy_id");
