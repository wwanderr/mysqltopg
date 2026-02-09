/*
 * Table: t_security_zone
 * Generated: 2026-02-09 14:43:08
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_security_zone";

CREATE TABLE "t_security_zone" (
                                   "id" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                   "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
                                   "description" text COLLATE "pg_catalog"."default",
                                   "iconpath" varchar(500) COLLATE "pg_catalog"."default",
                                   "ipconfstr" text COLLATE "pg_catalog"."default" NOT NULL,
                                   "uiipconfstr" text COLLATE "pg_catalog"."default",
                                   "createtime" int8,
                                   "tag" varchar(200) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;

ALTER TABLE "t_security_zone" OWNER TO "dbapp";

COMMENT ON COLUMN "t_security_zone"."id" IS 'Id';

COMMENT ON COLUMN "t_security_zone"."name" IS '安全域名称';

COMMENT ON COLUMN "t_security_zone"."description" IS '安全域描述';

COMMENT ON COLUMN "t_security_zone"."iconpath" IS '图标路径';

COMMENT ON COLUMN "t_security_zone"."ipconfstr" IS 'ip、ip区间、子网掩码配置';

COMMENT ON COLUMN "t_security_zone"."uiipconfstr" IS 'Ip、ip区间、子网掩码对应前端位置';

COMMENT ON COLUMN "t_security_zone"."createtime" IS '创建时间';

COMMENT ON COLUMN "t_security_zone"."tag" IS '系统标签';

ALTER TABLE "t_security_zone" ADD CONSTRAINT "idx_92970_primary" PRIMARY KEY ("id");
