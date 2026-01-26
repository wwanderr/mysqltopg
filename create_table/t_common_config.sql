/*
 * Table: t_common_config
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_common_config_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_common_config_id_seq";
CREATE SEQUENCE "t_common_config_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_common_config_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_common_config
-- ----------------------------
DROP TABLE IF EXISTS "t_common_config";
CREATE TABLE "t_common_config" (
  "id" int8 NOT NULL DEFAULT nextval('t_common_config_id_seq'::regclass),
  "prefix" varchar(45) COLLATE "pg_catalog"."default" NOT NULL,
  "configkey" varchar(45) COLLATE "pg_catalog"."default" NOT NULL,
  "configvalue" varchar(20000) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_common_config" OWNER TO "dbapp";
COMMENT ON COLUMN "t_common_config"."id" IS '主键Id';
COMMENT ON COLUMN "t_common_config"."prefix" IS '分类';
COMMENT ON COLUMN "t_common_config"."configkey" IS '名称';
COMMENT ON TABLE "t_common_config" IS '通用配置';

-- ----------------------------
-- Records of t_common_config
-- ----------------------------
BEGIN;
INSERT INTO "t_common_config" ("id", "prefix", "configkey", "configvalue") VALUES (1, 'dasca-dbappsecurity-ainta', 'accessKey', '1cf2bb1de1024a94140a9d7f8597c0ba');
INSERT INTO "t_common_config" ("id", "prefix", "configkey", "configvalue") VALUES (2, 'dasca-dbappsecurity-ainta', 'accessKeySecret', 'birlovoidv9S+iu45cuhfPo0g3p1J3fI3gYDGgywz6uPZRqpDW4+nspxGN8UGw6INulCihseo+Iro2xCRwnU7klt6yFY0fWTeuRQmwhPbJSdB65UHWYchjC1iQwjuv1u/ZAYqO96SJpkJhC+e0eP9A46jCo0pInQn626cOqYQzCutcbNTd7eHxUpxnC0FgsM8+TeNXB4yzaohrcg+sRcxzpW+Ugo9GptLUJfZTLkMUyNI+5GcqWJajFVozKD14L4iYUpVTEStANcf7RbPx0mOkxcsOIrCQkrJFE2NC3OWPD6L0LwPJKUQQyXfE6x4GNMCmuwv6GIvq36Xl1pmrX/fQ==');
INSERT INTO "t_common_config" ("id", "prefix", "configkey", "configvalue") VALUES (3, 'baas', 'baas.admin.password', 'b!o3jraZ4a');
INSERT INTO "t_common_config" ("id", "prefix", "configkey", "configvalue") VALUES (4, 'baas', 'baas.admin.username', 'admin');
INSERT INTO "t_common_config" ("id", "prefix", "configkey", "configvalue") VALUES (5, 'attacker_traffic', 'history_init', '2026-01-15 00:00:00--2026-01-12 19:00:00');
COMMIT;

-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "t_common_config_id_seq"
OWNED BY "t_common_config"."id";
SELECT setval('"t_common_config_id_seq"', 5, true);


-- ----------------------------
-- Indexes structure for table t_common_config
-- ----------------------------
CREATE UNIQUE INDEX "idx_94516_name_uni" ON "t_common_config" USING btree (
  "prefix" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "configkey" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_common_config
-- ----------------------------
ALTER TABLE "t_common_config" ADD CONSTRAINT "idx_94516_primary" PRIMARY KEY ("id");

-- ---------
