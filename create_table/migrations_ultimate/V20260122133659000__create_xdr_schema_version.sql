/*
 * Table: xdr_schema_version
 * Generated: 2026-01-22 13:36:59
 * Source: sql
 */

-- ============================
-- TABLE DEFINITION
-- ============================
-- ----------------------------
-- Table structure for xdr_schema_version
-- ----------------------------
DROP TABLE IF EXISTS "xdr_schema_version";
CREATE TABLE "xdr_schema_version" (
  "installed_rank" int8 NOT NULL,
  "version" varchar(50) COLLATE "pg_catalog"."default",
  "description" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "script" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
  "checksum" int8,
  "installed_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "installed_on" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "execution_time" int8 NOT NULL,
  "success" bool NOT NULL
)
;
ALTER TABLE "xdr_schema_version" OWNER TO "dbapp";

-- ----------------------------
-- Records of xdr_schema_version
-- ----------------------------
BEGIN;
COMMIT;

-- ============================
-- INDEXES
-- ============================
-- ----------------------------
-- Indexes structure for table xdr_schema_version
-- ----------------------------
CREATE INDEX "idx_94938_xdr_schema_version_s_idx" ON "xdr_schema_version" USING btree (
  "success" "pg_catalog"."bool_ops" ASC NULLS LAST
);
