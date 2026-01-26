/*
 * Table: t_scene_login_baseline
 * Generated: 2026-01-22 11:07:02
 * Source: xdr22.sql
 */

-- ----------------------------
-- Table structure for t_scene_login_baseline
-- ----------------------------
DROP TABLE IF EXISTS "t_scene_login_baseline";
CREATE TABLE "t_scene_login_baseline" (
  "dest_address" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "src_user_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "last_login_time" timestamptz(6),
  "city_counts" text COLLATE "pg_catalog"."default",
  "city_array" varchar(500) COLLATE "pg_catalog"."default",
  "create_time" timestamptz(6),
  "update_time" timestamptz(6)
)
;
ALTER TABLE "t_scene_login_baseline" OWNER TO "dbapp";
COMMENT ON COLUMN "t_scene_login_baseline"."dest_address" IS '目的ip';
COMMENT ON COLUMN "t_scene_login_baseline"."src_user_name" IS '用户名';
COMMENT ON COLUMN "t_scene_login_baseline"."last_login_time" IS '最后登录时间';
COMMENT ON COLUMN "t_scene_login_baseline"."city_counts" IS '此ip和用户名登录城市和次数map。json数据';
COMMENT ON COLUMN "t_scene_login_baseline"."city_array" IS '排名前三的城市数组';

-- ----------------------------
-- Records of t_scene_login_baseline
-- ----------------------------
BEGIN;
COMMIT;