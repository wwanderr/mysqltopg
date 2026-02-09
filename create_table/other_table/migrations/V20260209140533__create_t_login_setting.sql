/*
 * Table: t_login_setting
 * Generated: 2026-02-09 14:05:58
 * Source: V20260204212300__init_table.sql
 */

DROP TABLE IF EXISTS "t_login_setting";

CREATE TABLE "t_login_setting" (
                                   "id" int8 NOT NULL DEFAULT nextval('t_login_setting_id_seq'::regclass),
                                   "lock_time" int8 NOT NULL DEFAULT '3'::bigint,
                                   "lock_times" int8 NOT NULL DEFAULT '2'::bigint,
                                   "unlock_time" int8 NOT NULL DEFAULT '1'::bigint,
                                   "timeout" int8 NOT NULL DEFAULT '3'::bigint,
                                   "pwd_min_len" int8 NOT NULL DEFAULT '6'::bigint,
                                   "pwd_max_len" int8 NOT NULL DEFAULT '15'::bigint,
                                   "pwd_expire_day" int8 NOT NULL DEFAULT '0'::bigint,
                                   "pwd_uppercase" int8 NOT NULL DEFAULT '1'::bigint,
                                   "pwd_lowercase" int8 NOT NULL DEFAULT '1'::bigint,
                                   "pwd_num" int8 NOT NULL DEFAULT '1'::bigint,
                                   "pwd_special" int8 NOT NULL DEFAULT '1'::bigint,
                                   "warning_before_day" int8 NOT NULL DEFAULT '0'::bigint,
                                   "watermarking" int8 NOT NULL DEFAULT '0'::bigint,
                                   "watermarking_ip" int8 NOT NULL DEFAULT '1'::bigint,
                                   "watermarking_user" int8 NOT NULL DEFAULT '1'::bigint,
                                   "watermarking_system_name" int8 NOT NULL DEFAULT '1'::bigint,
                                   "pwd_pre_method" int8 NOT NULL DEFAULT '0'::bigint,
                                   "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                   "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

ALTER TABLE "t_login_setting" OWNER TO "dbapp";

COMMENT ON COLUMN "t_login_setting"."lock_time" IS '锁定时间区间。1:10s;

COMMENT ON COLUMN "t_login_setting"."lock_times" IS '时间内登陆失败次数。1:3；2:5；3:10；默认5';

COMMENT ON COLUMN "t_login_setting"."unlock_time" IS '禁止登陆时间：1:10m1220m;

COMMENT ON COLUMN "t_login_setting"."timeout" IS '登录超时时间：1:10m;

COMMENT ON COLUMN "t_login_setting"."pwd_min_len" IS '密码最小长度：默认为6，取值范围6～30';

COMMENT ON COLUMN "t_login_setting"."pwd_max_len" IS '密码最大长度：默认为15，取值范围6～30';

COMMENT ON COLUMN "t_login_setting"."pwd_expire_day" IS '密码有效期可以选择：永不过期0或者1~365天，默认0
';

COMMENT ON COLUMN "t_login_setting"."pwd_uppercase" IS '密码复杂度:必须包含大写字母。1:是，0否';

COMMENT ON COLUMN "t_login_setting"."pwd_lowercase" IS '必须包含小写字母：1是，0否';

COMMENT ON COLUMN "t_login_setting"."pwd_num" IS '必须包含数字：1.是，0否';

COMMENT ON COLUMN "t_login_setting"."pwd_special" IS '必须包含特殊字符：1是，0否';

COMMENT ON COLUMN "t_login_setting"."warning_before_day" IS '密码修改提醒时间：不提醒或者1～30天。用户登录后进行提醒。“您的密码将于2019年4月26日自动过期，请及时修改，修改位置是右上角-个人中心”。用户密码已过期登录，登录失败，提示“您的密码已过期，请修改。”';

COMMENT ON COLUMN "t_login_setting"."watermarking" IS '是否启用水印显示，默认为禁用.1:启用；0:禁用
';

COMMENT ON COLUMN "t_login_setting"."watermarking_ip" IS '水印模式：IP。0无IP，1有IP';

COMMENT ON COLUMN "t_login_setting"."watermarking_user" IS '水印模式：用户名。0无用户名，1有用户名';

COMMENT ON COLUMN "t_login_setting"."watermarking_system_name" IS '水印模式：系统名称。0无系统名称，1有系统名称';

COMMENT ON COLUMN "t_login_setting"."pwd_pre_method" IS '新建用户首次登录修改密码：0:强制修改、1:禁用。（已有用户走密码过期流程。默认强制修改';

DROP SEQUENCE IF EXISTS "t_login_setting_id_seq";
CREATE SEQUENCE "t_login_setting_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "t_login_setting_id_seq" OWNER TO "dbapp";

ALTER TABLE "t_login_setting" ADD CONSTRAINT "idx_92491_primary" PRIMARY KEY ("id");
