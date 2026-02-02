CREATE SEQUENCE "t_organization_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Table structure for t_organization
-- ----------------------------
DROP TABLE IF EXISTS "t_organization";
CREATE TABLE "t_organization" (
  "id" int8 NOT NULL DEFAULT nextval('t_organization_id_seq'::regclass),
  "orgname" varchar(150) COLLATE "pg_catalog"."default" NOT NULL,
  "abbreviation" varchar(256) COLLATE "pg_catalog"."default",
  "orgid" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "parentorgid" varchar(128) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "orgidentifier" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "orgaddress" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "orgarea" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "createtime" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatetime" timestamp
)
;
ALTER TABLE "t_organization" OWNER TO "dbapp";
COMMENT ON COLUMN "t_organization"."orgname" IS '组织名称';
COMMENT ON COLUMN "t_organization"."abbreviation" IS '简称';
COMMENT ON COLUMN "t_organization"."orgid" IS '组织标识';
COMMENT ON COLUMN "t_organization"."parentorgid" IS '父组织标识';
COMMENT ON COLUMN "t_organization"."orgidentifier" IS '组织编号';
COMMENT ON COLUMN "t_organization"."orgaddress" IS '地址';
COMMENT ON COLUMN "t_organization"."orgarea" IS '地区';
COMMENT ON COLUMN "t_organization"."createtime" IS '创建时间';
COMMENT ON COLUMN "t_organization"."updatetime" IS '修改时间';

-- ----------------------------
-- Records of t_organization
-- ----------------------------
BEGIN;
INSERT INTO "t_organization" ("id", "orgname", "abbreviation", "orgid", "parentorgid", "orgidentifier", "orgaddress", "orgarea", "createtime", "updatetime") VALUES (1, '总部', NULL, '7effcbb7-0c7a-4da9-bde1-32d06166acae', '', '', '', '', '2026-01-13 10:37:40+08', '2026-01-13 10:37:40+08');

-- ----------------------------
-- Records of t_organization
-- ----------------------------
BEGIN;
COMMIT;