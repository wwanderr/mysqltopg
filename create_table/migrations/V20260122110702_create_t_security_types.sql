/*
 * Table: t_security_types
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_security_types_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_security_types_id_seq";
CREATE SEQUENCE "t_security_types_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_security_types_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_security_types
-- ----------------------------
DROP TABLE IF EXISTS "t_security_types";
CREATE TABLE "t_security_types" (
  "id" int8 NOT NULL DEFAULT nextval('t_security_types_id_seq'::regclass),
  "sub_category" varchar(50) COLLATE "pg_catalog"."default",
  "category" varchar(50) COLLATE "pg_catalog"."default",
  "mirror_sub_category" varchar(50) COLLATE "pg_catalog"."default",
  "mirror_category" varchar(50) COLLATE "pg_catalog"."default",
  "sub_category_name" varchar(50) COLLATE "pg_catalog"."default",
  "category_name" varchar(50) COLLATE "pg_catalog"."default",
  "is_enable" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "t_security_types" OWNER TO "dbapp";
COMMENT ON COLUMN "t_security_types"."id" IS '唯一id';
COMMENT ON COLUMN "t_security_types"."sub_category" IS '安全事件子类型';
COMMENT ON COLUMN "t_security_types"."category" IS '安全事件类型';
COMMENT ON COLUMN "t_security_types"."mirror_sub_category" IS 'mirror安全事件子类型';
COMMENT ON COLUMN "t_security_types"."mirror_category" IS 'mirror安全事件类型';
COMMENT ON COLUMN "t_security_types"."sub_category_name" IS '安全事件子类型中文';
COMMENT ON COLUMN "t_security_types"."category_name" IS '安全事件类型中文';
COMMENT ON COLUMN "t_security_types"."is_enable" IS '是否生效';

-- ----------------------------
-- Records of t_security_types
-- ----------------------------
BEGIN;
COMMIT;