/*
 * Table: t_tag_search_list
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Sequence Definitions
-- ----------------------------
-- ----------------------------
-- Sequence structure for t_tag_search_list_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "t_tag_search_list_id_seq";
CREATE SEQUENCE "t_tag_search_list_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_tag_search_list_id_seq" OWNER TO "dbapp";

-- ----------------------------
-- Table structure for t_tag_search_list
-- ----------------------------
DROP TABLE IF EXISTS "t_tag_search_list";
CREATE TABLE "t_tag_search_list" (
  "id" int8 NOT NULL DEFAULT nextval('t_tag_search_list_id_seq'::regclass),
  "tag_search" varchar(255) COLLATE "pg_catalog"."default",
  "name" varchar(255) COLLATE "pg_catalog"."default",
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_tag_search_list" OWNER TO "dbapp";
COMMENT ON COLUMN "t_tag_search_list"."id" IS '主键id';
COMMENT ON COLUMN "t_tag_search_list"."tag_search" IS '标记名称';
COMMENT ON COLUMN "t_tag_search_list"."name" IS '中文名';
COMMENT ON COLUMN "t_tag_search_list"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_tag_search_list
-- ----------------------------
BEGIN;
COMMIT;