/*
 * Table: t_sev_agent_config
 * Generated: 2026-02-09 14:43:08
 * Source: V20260204212300__init_table.sql
 */

DROP SEQUENCE IF EXISTS "t_sev_agent_config_id_seq";
CREATE SEQUENCE "t_sev_agent_config_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_sev_agent_config_id_seq" OWNER TO "dbapp";

DROP TABLE IF EXISTS "t_sev_agent_config";

CREATE TABLE "t_sev_agent_config" (
                                      "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_config_id_seq'::regclass),
                                      "agent_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
                                      "config_version" int8 NOT NULL,
                                      "config_key" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
                                      "config_content" text COLLATE "pg_catalog"."default",
                                      "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                      "update_time" timestamp
)
;

ALTER TABLE "t_sev_agent_config" OWNER TO "dbapp";

COMMENT ON COLUMN "t_sev_agent_config"."id" IS '主键';

COMMENT ON COLUMN "t_sev_agent_config"."agent_type" IS 'agent类型（AiNTA、APT、SOC）';

COMMENT ON COLUMN "t_sev_agent_config"."config_version" IS '版本号，时间戳';

COMMENT ON COLUMN "t_sev_agent_config"."config_key" IS '配置项标识，英文名';

COMMENT ON COLUMN "t_sev_agent_config"."config_content" IS '配置内容';

COMMENT ON COLUMN "t_sev_agent_config"."create_time" IS '创建时间';

COMMENT ON COLUMN "t_sev_agent_config"."update_time" IS '更新时间';

COMMENT ON TABLE "t_sev_agent_config" IS '探针配置表';

DROP FUNCTION IF EXISTS "on_update_current_timestamp_t_sev_agent_config"();
CREATE OR REPLACE FUNCTION "on_update_current_timestamp_t_sev_agent_config"()
  RETURNS "pg_catalog"."trigger" AS $BODY$
BEGIN
   NEW.update_time = now();
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION "on_update_current_timestamp_t_sev_agent_config"() OWNER TO "dbapp";

CREATE TRIGGER "on_update_current_timestamp" BEFORE UPDATE ON "t_sev_agent_config"
    FOR EACH ROW
    EXECUTE PROCEDURE "on_update_current_timestamp_t_sev_agent_config"();

ALTER TABLE "t_sev_agent_config" ADD CONSTRAINT "idx_92987_primary" PRIMARY KEY ("id");

ALTER TABLE "t_sev_agent_config" ADD CONSTRAINT "t_agent_config_fk" FOREIGN KEY ("agent_type") REFERENCES "t_sev_agent_type" ("agent_type") ON DELETE CASCADE ON UPDATE CASCADE;

CREATE INDEX "idx_92987_t_agent_config_fk" ON "t_sev_agent_config" USING btree (
    "agent_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
