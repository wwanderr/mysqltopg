CREATE SEQUENCE "t_sev_agent_type_rule_closed_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for t_sev_agent_type_rule_closed
-- ----------------------------
DROP TABLE IF EXISTS "t_sev_agent_type_rule_closed";
CREATE TABLE "t_sev_agent_type_rule_closed" (
  "id" int8 NOT NULL DEFAULT nextval('t_sev_agent_type_rule_closed_id_seq'::regclass),
  "agent_type" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "rule_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "remarks" text COLLATE "pg_catalog"."default",
  "update_history_alarm" bool,
  "data" text COLLATE "pg_catalog"."default",
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp,
  "is_delete" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "t_sev_agent_type_rule_closed" OWNER TO "dbapp";
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."id" IS '主键';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."agent_type" IS '探针类型';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."rule_id" IS '规则id';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."remarks" IS '备注';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."update_history_alarm" IS '是否将最近7天告警标记为 已处置-误报';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."data" IS '附加信息，回跳告警列表查询字段';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."update_time" IS '更新时间';
COMMENT ON COLUMN "t_sev_agent_type_rule_closed"."is_delete" IS '标记是否删除';
COMMENT ON TABLE "t_sev_agent_type_rule_closed" IS '探针类型与需要关闭规则关联表';

-- ----------------------------
-- Records of t_sev_agent_type_rule_closed
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_sev_file_chunk
-- ----------------------------
DROP TABLE IF EXISTS "t_sev_file_chunk";
CREATE TABLE "t_sev_file_chunk" (
  "id" int8 NOT NULL DEFAULT nextval('t_sev_file_chunk_id_seq'::regclass),
  "file_name" varchar(255) COLLATE "pg_catalog"."default",
  "chunk_number" int8,
  "chunk_size" float8,
  "current_chunk_size" float8,
  "total_size" float8,
  "chunk_end" int8,
  "chunk_start" int8,
  "total_chunk" int8,
  "identifier" varchar(45) COLLATE "pg_catalog"."default",
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "uuid" varchar(255) COLLATE "pg_catalog"."default",
  "save_path" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_sev_file_chunk" OWNER TO "dbapp";
COMMENT ON COLUMN "t_sev_file_chunk"."id" IS '主键id';
COMMENT ON COLUMN "t_sev_file_chunk"."file_name" IS '文件名';
COMMENT ON COLUMN "t_sev_file_chunk"."chunk_number" IS '当前分片，从1开始';
COMMENT ON COLUMN "t_sev_file_chunk"."chunk_size" IS '分片大小';
COMMENT ON COLUMN "t_sev_file_chunk"."current_chunk_size" IS '当前分片大小';
COMMENT ON COLUMN "t_sev_file_chunk"."total_size" IS '文件总大小';
COMMENT ON COLUMN "t_sev_file_chunk"."chunk_end" IS '分片结束位置';
COMMENT ON COLUMN "t_sev_file_chunk"."chunk_start" IS '分片起始位置';
COMMENT ON COLUMN "t_sev_file_chunk"."total_chunk" IS '总分片数';
COMMENT ON COLUMN "t_sev_file_chunk"."identifier" IS 'md5校验码';
COMMENT ON COLUMN "t_sev_file_chunk"."uuid" IS '每一次分段下载，共用一个uuid';
COMMENT ON COLUMN "t_sev_file_chunk"."save_path" IS '本次下载目录';

-- ----------------------------
-- Records of t_sev_file_chunk
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_site
-- ----------------------------
DROP TABLE IF EXISTS "t_site";
CREATE TABLE "t_site" (
  "_id" int8 NOT NULL DEFAULT nextval('t_site__id_seq'::regclass),
  "sitename" varchar(256) COLLATE "pg_catalog"."default",
  "domain" varchar(256) COLLATE "pg_catalog"."default",
  "ip" varchar(45) COLLATE "pg_catalog"."default",
  "port" varchar(45) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "t_site" OWNER TO "dbapp";
COMMENT ON COLUMN "t_site"."sitename" IS '站点名称';
COMMENT ON COLUMN "t_site"."domain" IS '站点域名';
COMMENT ON COLUMN "t_site"."ip" IS 'IP地址';
COMMENT ON COLUMN "t_site"."port" IS '端口号';

-- ----------------------------
-- Records of t_site
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_situation_awareness
-- ----------------------------
DROP TABLE IF EXISTS "t_situation_awareness";
CREATE TABLE "t_situation_awareness" (
  "id" int8 NOT NULL,
  "awareness_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "title" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "brief" text COLLATE "pg_catalog"."default" NOT NULL,
  "create_time" timestamp,
  "update_time" timestamp
)
;
ALTER TABLE "t_situation_awareness" OWNER TO "dbapp";

-- ----------------------------
-- Records of t_situation_awareness
-- ----------------------------
BEGIN;
INSERT INTO "t_situation_awareness" ("id", "awareness_id", "title", "brief", "create_time", "update_time") VALUES (1, 'ExternalAttack', '外部攻击态势', '外部攻击态势主要关注来自全世界不同地区的攻击源对企业内部资产的威胁情况，实时监控境内境外攻击源的地域分布和国家排行，掌握各攻击链阶段的威胁变化趋势和最新外部攻击事件。', '2026-01-13 10:37:41+08', NULL);

-- ----------------------------
-- Records of t_sev_agent_type_rule_closed
-- ----------------------------
BEGIN;
COMMIT;