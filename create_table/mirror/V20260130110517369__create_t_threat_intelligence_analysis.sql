CREATE SEQUENCE "t_threat_intelligence_analysis_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for t_threat_intelligence_analysis
-- ----------------------------
DROP TABLE IF EXISTS "t_threat_intelligence_analysis";
CREATE TABLE "t_threat_intelligence_analysis" (
  "id" int8 NOT NULL DEFAULT nextval('t_threat_intelligence_analysis_id_seq'::regclass),
  "agent_code" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
  "file_name" varchar(512) COLLATE "pg_catalog"."default" NOT NULL,
  "file_type" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "uuid" varchar(64) COLLATE "pg_catalog"."default",
  "server_id" int8,
  "md5" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "grade" varchar(30) COLLATE "pg_catalog"."default",
  "result" varchar(2048) COLLATE "pg_catalog"."default",
  "score" int8,
  "deal_status" varchar(32) COLLATE "pg_catalog"."default" NOT NULL DEFAULT 'analysising'::character varying,
  "upload_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "finish_time" timestamp,
  "original" text COLLATE "pg_catalog"."default",
  "has_report" bool NOT NULL DEFAULT false
)
;
ALTER TABLE "t_threat_intelligence_analysis" OWNER TO "dbapp";
COMMENT ON COLUMN "t_threat_intelligence_analysis"."id" IS '主键';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."file_name" IS '文件名称';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."file_type" IS '文件类型';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."uuid" IS 'uuid';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."server_id" IS 'apt的id';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."md5" IS 'md5值';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."grade" IS '评级';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."result" IS '检测结果';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."score" IS '评分';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."deal_status" IS '处理状态';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."upload_time" IS '上传时间';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."finish_time" IS '检测完成时间';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."original" IS '原始检查结果';
COMMENT ON COLUMN "t_threat_intelligence_analysis"."has_report" IS '是否有报告';

-- ----------------------------
-- Records of t_threat_intelligence_analysis
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_threat_intelligence_tag
-- ----------------------------
DROP TABLE IF EXISTS "t_threat_intelligence_tag";
CREATE TABLE "t_threat_intelligence_tag" (
  "id" int8 NOT NULL DEFAULT nextval('t_threat_intelligence_tag_id_seq'::regclass),
  "name" varchar(18) COLLATE "pg_catalog"."default" NOT NULL,
  "is_malice" "t_threat_intelligence_tag_is_malice" NOT NULL DEFAULT 'undefined'::t_threat_intelligence_tag_is_malice,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "update_time" timestamp
)
;
ALTER TABLE "t_threat_intelligence_tag" OWNER TO "dbapp";
COMMENT ON COLUMN "t_threat_intelligence_tag"."id" IS '标签ID';
COMMENT ON COLUMN "t_threat_intelligence_tag"."name" IS '标签名称';
COMMENT ON COLUMN "t_threat_intelligence_tag"."is_malice" IS 'truefalse恶意';
COMMENT ON COLUMN "t_threat_intelligence_tag"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_threat_intelligence_tag"."update_time" IS '更新时间';

-- ----------------------------
-- Records of t_threat_intelligence_tag
-- ----------------------------
BEGIN;
INSERT INTO "t_threat_intelligence_tag" ("id", "name", "is_malice", "create_time", "update_time") VALUES (1, '勒索软件', 'true', '2026-01-13 10:37:46+08', '2026-01-13 10:37:46+08');

-- ----------------------------
-- Records of t_threat_intelligence_analysis
-- ----------------------------
BEGIN;
COMMIT;