/*
 * Table: t_merge_alarm_user_preference
 * Generated: 2026-02-09 13:48:09
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_merge_alarm_user_preference";

CREATE TABLE "t_merge_alarm_user_preference" (
                                                 "id" int8 NOT NULL DEFAULT nextval('t_merge_alarm_user_preference_id_seq'::regclass),
                                                 "userid" int8 NOT NULL,
                                                 "name" varchar(100) COLLATE "pg_catalog"."default",
                                                 "defaultalarmresult" varchar(200) COLLATE "pg_catalog"."default",
                                                 "defaultcategory" text COLLATE "pg_catalog"."default",
                                                 "defaultthreatseverity" varchar(200) COLLATE "pg_catalog"."default",
                                                 "defaultkillchain" varchar(500) COLLATE "pg_catalog"."default",
                                                 "defaultdirection" varchar(200) COLLATE "pg_catalog"."default",
                                                 "defaultalarmstatus" varchar(200) COLLATE "pg_catalog"."default",
                                                 "defaultorgid" text COLLATE "pg_catalog"."default",
                                                 "defaulttimeoption" bool DEFAULT false,
                                                 "defaultalarmsource" varchar(200) COLLATE "pg_catalog"."default",
                                                 "defaulteventstatus" varchar(10) COLLATE "pg_catalog"."default",
                                                 "status" varchar(20) COLLATE "pg_catalog"."default",
                                                 "is_enable" bool
)
;

ALTER TABLE "t_merge_alarm_user_preference" OWNER TO "dbapp";

COMMENT ON COLUMN "t_merge_alarm_user_preference"."id" IS '主键';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."userid" IS '用户id';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."name" IS '场景名称';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."defaultalarmresult" IS '默认选择的告警结果';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."defaultcategory" IS '默认选择的告警类型';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."defaultthreatseverity" IS '默认选择的威胁级别';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."defaultkillchain" IS '默认选择的攻击阶段';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."defaultdirection" IS '默认选择的攻击方向';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."defaultalarmstatus" IS '默认选择的告警状态';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."defaultorgid" IS '默认选择的组织单位id';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."defaulttimeoption" IS '默认选择的时间范围，0--本日，1--本周，2--本月，3--本年，4--最近7天，5--最近30天，6--最近15分钟，7--最近1小时，8--最近24小时';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."defaultalarmsource" IS '告警来源';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."defaulteventstatus" IS '事件关联状态';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."status" IS '状态，facroty：内置场景；custom：自定义场景；factory_del：已删除内置场景';

COMMENT ON COLUMN "t_merge_alarm_user_preference"."is_enable" IS '是否生效';

COMMENT ON TABLE "t_merge_alarm_user_preference" IS '归并告警用户查询偏好设置';

DROP SEQUENCE IF EXISTS "t_merge_alarm_user_preference_id_seq";
CREATE SEQUENCE "t_merge_alarm_user_preference_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_merge_alarm_user_preference_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_merge_alarm_user_preference" ADD CONSTRAINT "idx_92532_primary" PRIMARY KEY ("id");

CREATE INDEX "idx_92532_t_merge_alarm_user_preference_userid_idx" ON "t_merge_alarm_user_preference" USING btree (
    "userid" "pg_catalog"."int8_ops" ASC NULLS LAST
    );
