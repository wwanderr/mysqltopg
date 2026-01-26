/*
 * Table: t_scene_web_access_temp
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for t_scene_web_access_temp
-- ----------------------------
DROP TABLE IF EXISTS "t_scene_web_access_temp";
CREATE TABLE "t_scene_web_access_temp" (
  "id" int8 NOT NULL,
  "src_address" varchar(255) COLLATE "pg_catalog"."default",
  "dest_address" varchar(255) COLLATE "pg_catalog"."default",
  "victim" text COLLATE "pg_catalog"."default",
  "attacker" text COLLATE "pg_catalog"."default",
  "request_url" text COLLATE "pg_catalog"."default",
  "dest_host_name" text COLLATE "pg_catalog"."default",
  "start_time" timestamp(6),
  "end_time" timestamp(6),
  "oldest_time" timestamp(6),
  "latest_time" timestamp(6),
  "event_count" int8,
  "create_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "t_scene_web_access_temp" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scene_web_access_temp"."src_address" IS '源IP';
COMMENT ON COLUMN "t_scene_web_access_temp"."dest_address" IS '目的IP';
COMMENT ON COLUMN "t_scene_web_access_temp"."victim" IS '受害者';
COMMENT ON COLUMN "t_scene_web_access_temp"."attacker" IS '攻击者';
COMMENT ON COLUMN "t_scene_web_access_temp"."request_url" IS 'url';
COMMENT ON COLUMN "t_scene_web_access_temp"."dest_host_name" IS '目的主机名';
COMMENT ON COLUMN "t_scene_web_access_temp"."oldest_time" IS '首次发生时间';
COMMENT ON COLUMN "t_scene_web_access_temp"."latest_time" IS '最近发生时间';
COMMENT ON TABLE "t_scene_web_access_temp" IS '威胁分析-可疑后门访问临时数据表';

-- ----------------------------
-- Records of t_scene_web_access_temp
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table t_scene_web_access_temp
-- ----------------------------
CREATE UNIQUE INDEX "idx_94868_t_scene_web_access_temp_id_uindex" ON "t_scene_web_access_temp" USING btree (
  "id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ============================
-- PRIMARY KEY
-- ============================
-- ----------------------------
-- Primary Keys structure for table t_scene_web_access_temp
-- ----------------------------
ALTER TABLE "t_scene_web_access_temp" ADD CONSTRAINT "idx_94868_primary" PRIMARY KEY ("id");
