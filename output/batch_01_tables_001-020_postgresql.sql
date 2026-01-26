-- ====================================================================================================
-- PostgreSQL Migration Script
-- Converted from MySQL using automated migration tool
-- Source: bigdata-web-data.sql
-- Target Database: PostgreSQL 16.x
-- Generated: 2026-01-14 19:13:24
-- ====================================================================================================

-- Set client encoding
SET client_encoding = 'UTF8';

-- Disable foreign key checks during migration
SET session_replication_role = 'replica';


DROP TABLE IF EXISTS "ailpha_aiAnalysis_algorithm";
CREATE TABLE "ailpha_aiAnalysis_algorithm"  (
  "algorithmId" VARCHAR(100)   NOT NULL,
  "algorithmName" VARCHAR(100)   NOT NULL,
  "description" text   NOT NULL,
  "other" text   NULL,
  "paper" text   NULL,
  "patent" text   NULL,
  PRIMARY KEY ("algorithmId")
);
  INSERT INTO "ailpha_aiAnalysis_algorithm" VALUES ('ARIMA', 'ARIMA', '自回归积分滑动平均模型，将非平稳时间序列转化为平稳时间序列，然后将因变量仅对它的滞后值以及随机误差项的现值和滞后值进行回归所建立的模型。 AR是自回归, MA为移动平均。\n算法简称：ARIMA\n算法补充描述：\nAuto Regressive Integrated Moving Average\nARIMA（p，d，q），AR是自回归, p为自回归项; MA为移动平均，q为移动平均项数，d为时间序列成为平稳时所做的差分次数。\n优点： 模型十分简单，只需要内生变量而不需要借助其他外生变量。\n缺点：要求时序数据是稳定的（stationary），或者是通过差分化(differencing)后是稳定的。\n对预测值的作用，增加近期观察值的权重，同时可控制权重的变化速率。', '残差置信水平:\n    将真实序列和拟合序列作差之后得到残差序列，并假设残差序列为正态分布。根据此正态分布的均值和方差估计出残差置信水平。若某个点对应的残差置信水平越高，表示该点越异常。', '', '');,
  INSERT INTO "ailpha_aiAnalysis_algorithm" VALUES ('ExponentialSmoothing', 'Exponential Smoothing', '指数平滑法常用于中短期趋势预测。是一种加权移动平均法。其特点是可加强观察期近期观察值对预测值的作用，增加近期观察值的权重，同时可控制权重的变化速率。\n算法简称：ES', '残差置信水平:\n    将真实序列和拟合序列作差之后得到残差序列，并假设残差序列为正态分布。根据此正态分布的均值和方差估计出残差置信水平。若某个点对应的残差置信水平越高，表示该点越异常。', '', '');,
  INSERT INTO "ailpha_aiAnalysis_algorithm" VALUES ('RPCASST', 'RPCA-SST', '日常观测数据往往包含噪声干扰，该算法将时序数据片段转化为矩阵结构，利用RPCA重构矩阵剔除大幅值噪声，提高突变程度略低的异常点检测性能，发现掩盖在噪声下的异常信息。\n算法简称：RPCA-SST\n算法补充描述：\nRobust Principle Component Analysis based Singular Spectrum Transform\n优势\n1. 针对于序列当中广泛存在的稀疏大噪声情况，该方法较为鲁棒，即能在免除噪声干扰的同时对突变点进行检测；\n2. 该方法能抑制模型对高程度突变的过度反应，从侧面可以提高对突变程度略低的突变点的检测性能。\n对预测值的作用，增加近期观察值的权重，同时可控制权重的变化速率。', '突变点得分:\n    利用本算法检测出的异常点会给出对应的评分来量化异常的程度，若某个异常点对应的突变得分越高，表示该点越异常。', '[{\"content\":\"A Robust Change-point Detection Method by Eliminating Sparse Noises\",\"info\":\"\"}]', '');,
  INSERT INTO "ailpha_aiAnalysis_algorithm" VALUES ('WeeklyGaussianEstimation', 'Weekly Gaussian Estimation', '训练以一周时间为一个周期的呈规律性分布的时间序列数据，网站访问量、车流量等数据均满足该规律。任意时刻的数据与之前几周同时刻数据应该符合高斯分布，利用 3-sigma 准则进行异常检测。\n算法简称：WGE', '标准差偏离\n    根据拟合出的高斯分布的均值和方差，可计算出某个点相对于均值偏离的方差的倍数，此方差倍数即为标准差偏离。若某个点对应的标准差偏离越大，表示该点越异常。', '', '[{\"content\": \"一种基于行为触发的防御链路耗尽型CC攻击的方法\",\"info\": \"201610369623.5\"},{\"content\": \"一种网络流量异常检测方法及系统\",\"info\": \"201710803213.1\"}]');

-- Column comments
COMMENT ON COLUMN "ailpha_aiAnalysis_algorithm"."algorithmId" IS '算法id';
COMMENT ON COLUMN "ailpha_aiAnalysis_algorithm"."algorithmName" IS '算法名称';
COMMENT ON COLUMN "ailpha_aiAnalysis_algorithm"."other" IS '误差描述';
COMMENT ON COLUMN "ailpha_aiAnalysis_algorithm"."paper" IS '论文(格式[{\"content\":\"论文描述\",\"info\":\"\"}])';
COMMENT ON COLUMN "ailpha_aiAnalysis_algorithm"."patent" IS '专利(格式[{\"content\":\"专利描述\",\"info\":\"专利号\"}])';


DROP TABLE IF EXISTS "ailpha_aiAnalysis_data";
CREATE TABLE "ailpha_aiAnalysis_data"  (
  "id" VARCHAR(100)   NOT NULL,
  "originalData" TEXT   NOT NULL,
  "uiData" TEXT   NOT NULL,
  "createTime" BIGINT NULL DEFAULT NULL,
  "modelId" VARCHAR(100)   NOT NULL,
  "algorithmId" VARCHAR(100)   NOT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "ailpha_aiAnalysis_data"."id" IS '模型数据id';
COMMENT ON COLUMN "ailpha_aiAnalysis_data"."originalData" IS '分析结果原始数据';
COMMENT ON COLUMN "ailpha_aiAnalysis_data"."uiData" IS '前端展示结果数据';
COMMENT ON COLUMN "ailpha_aiAnalysis_data"."modelId" IS '模型id';
COMMENT ON COLUMN "ailpha_aiAnalysis_data"."algorithmId" IS '算法id';


DROP TABLE IF EXISTS "ailpha_aiAnalysis_scene";
CREATE TABLE "ailpha_aiAnalysis_scene"  (
  "sceneId" VARCHAR(100)   NOT NULL,
  "sceneNo" INTEGER NOT NULL,
  "modelId" VARCHAR(100)   NOT NULL,
  "algorithmId" VARCHAR(100)   NULL DEFAULT NULL,
  "isenable" VARCHAR(10)   NULL DEFAULT 'true',
  "other" text   NULL,
  PRIMARY KEY ("sceneId")
);
  INSERT INTO "ailpha_aiAnalysis_scene" VALUES ('场景1_create_or_update_time:1536652861860', 1, 'sessionNumAnomaly', 'ARIMA', 'true', NULL);,
  INSERT INTO "ailpha_aiAnalysis_scene" VALUES ('场景2_create_or_update_time:1536296864525', 2, 'bytesInAnomaly', 'RPCASST', 'true', NULL);,
  INSERT INTO "ailpha_aiAnalysis_scene" VALUES ('场景3_create_or_update_time:1536647527710', 3, 'requestDomainNumAnomaly', 'ARIMA', 'true', NULL);,
  INSERT INTO "ailpha_aiAnalysis_scene" VALUES ('场景4_create_or_update_time:1536651875599', 4, 'websiteAccessUnsuccessNumAnomaly', 'ExponentialSmoothing', 'true', NULL);

-- Column comments
COMMENT ON COLUMN "ailpha_aiAnalysis_scene"."sceneId" IS '场景id';
COMMENT ON COLUMN "ailpha_aiAnalysis_scene"."sceneNo" IS '场景号';
COMMENT ON COLUMN "ailpha_aiAnalysis_scene"."modelId" IS '模型id';
COMMENT ON COLUMN "ailpha_aiAnalysis_scene"."algorithmId" IS '算法id';
COMMENT ON COLUMN "ailpha_aiAnalysis_scene"."isenable" IS '是否启用';
COMMENT ON COLUMN "ailpha_aiAnalysis_scene"."other" IS '其他';


DROP TABLE IF EXISTS "ailpha_metric";
CREATE TABLE "ailpha_metric"  (
  "id" VARCHAR(255)   NOT NULL,
  "metricKey" text   NOT NULL,
  "source" VARCHAR(30)   NOT NULL,
  "filterStrategyStr" text   NULL,
  "filterStrategy" text   NULL,
  "groupBy" VARCHAR(255)   NULL DEFAULT NULL,
  "toAlarm" INTEGER NULL DEFAULT NULL,
  "uiJson" text   NULL,
  "siddhiJson" text   NULL,
  "createTime" BIGINT NULL DEFAULT NULL,
  "updateTime" BIGINT NULL DEFAULT NULL,
  "window" BIGINT NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "ailpha_model";
CREATE TABLE "ailpha_model"  (
  "id" SERIAL,
  "uuid" VARCHAR(100)   NOT NULL,
  "type" VARCHAR(100)   NOT NULL,
  "modelName" VARCHAR(100)   NOT NULL,
  "chineseName" VARCHAR(1024)   NOT NULL,
  "killChain" VARCHAR(100)   NOT NULL,
  "attackIntent" VARCHAR(100)   NOT NULL,
  "attackMethod" VARCHAR(100)   NOT NULL,
  "attackStrategy" VARCHAR(100)   NOT NULL,
  "severity" VARCHAR(20)   NOT NULL,
  "source" VARCHAR(100)   NOT NULL,
  "toAlarm" SMALLINT NOT NULL,
  "description" text   NOT NULL,
  "suggest" text   NOT NULL,
  "isCustom" SMALLINT NOT NULL,
  "state" SMALLINT NOT NULL,
  "uiJson" text   NOT NULL,
  "isWafRule" smallint(2) NULL DEFAULT NULL,
  "usedKeyStr" text   NULL,
  "createTime" BIGINT NULL DEFAULT NULL,
  "updateTime" BIGINT NULL DEFAULT NULL,
  "tags" text   NULL,
  "filterStr" text   NULL,
  "isQuoted" smallint(2) NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Indexes
CREATE UNIQUE INDEX "modelName" ON "ailpha_model" ("modelName");

-- Column comments
COMMENT ON COLUMN "ailpha_model"."uuid" IS 'uid';
COMMENT ON COLUMN "ailpha_model"."type" IS '模型类型';
COMMENT ON COLUMN "ailpha_model"."modelName" IS '英文短名';
COMMENT ON COLUMN "ailpha_model"."chineseName" IS '中文名';
COMMENT ON COLUMN "ailpha_model"."killChain" IS '攻击链';
COMMENT ON COLUMN "ailpha_model"."attackIntent" IS '攻击意图';
COMMENT ON COLUMN "ailpha_model"."attackMethod" IS '攻击方法';
COMMENT ON COLUMN "ailpha_model"."attackStrategy" IS '攻击策略';
COMMENT ON COLUMN "ailpha_model"."severity" IS '告警级别';
COMMENT ON COLUMN "ailpha_model"."source" IS '数据源';
COMMENT ON COLUMN "ailpha_model"."toAlarm" IS '是否输出到安全告警，0:不输出，1:输出';
COMMENT ON COLUMN "ailpha_model"."description" IS '描述';
COMMENT ON COLUMN "ailpha_model"."suggest" IS '建议';
COMMENT ON COLUMN "ailpha_model"."isCustom" IS '定制类型：0:非定制 1:定制';
COMMENT ON COLUMN "ailpha_model"."state" IS '状态，0:禁用，1:启用';
COMMENT ON COLUMN "ailpha_model"."uiJson" IS 'UI对接的json';
COMMENT ON COLUMN "ailpha_model"."tags" IS '标签';
COMMENT ON COLUMN "ailpha_model"."filterStr" IS '模型过滤条件';
COMMENT ON COLUMN "ailpha_model"."isQuoted" IS '模型是否被引用';


DROP TABLE IF EXISTS "ailpha_model_change";
CREATE TABLE "ailpha_model_change"  (
  "id" BIGSERIAL,
  "uuid" VARCHAR(255)   NOT NULL,
  "enable" SMALLINT NOT NULL DEFAULT -1,
  "toAlarm" SMALLINT NOT NULL DEFAULT -1,
  "addOrUpdate" SMALLINT NOT NULL DEFAULT -1,
  "del" SMALLINT NOT NULL DEFAULT -1,
  "addOrUpdateTime" BIGINT NOT NULL DEFAULT 0,
  "delTime" BIGINT NOT NULL DEFAULT 0,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "ailpha_model_change"."id" IS '主键';
COMMENT ON COLUMN "ailpha_model_change"."uuid" IS '名称';


DROP TABLE IF EXISTS "ailpha_model_factory";
CREATE TABLE "ailpha_model_factory"  (
  "id" BIGSERIAL,
  "uuid" VARCHAR(255)   NOT NULL,
  "type" VARCHAR(255)   NOT NULL,
  "enable" SMALLINT NULL DEFAULT NULL,
  "toAlarm" SMALLINT NULL DEFAULT NULL,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "ailpha_model_factory"."update_time" IS '更新时间';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_ailpha_model_factory_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_ailpha_model_factory_update_timestamp
BEFORE UPDATE ON "ailpha_model_factory"
FOR EACH ROW
EXECUTE FUNCTION update_ailpha_model_factory_timestamp();


DROP TABLE IF EXISTS "ailpha_model_user_status";
CREATE TABLE "ailpha_model_user_status"  (
  "id" VARCHAR(255)   NOT NULL DEFAULT '',
  "type" VARCHAR(20)   NOT NULL DEFAULT '',
  "enable" SMALLINT NULL DEFAULT NULL,
  "to_alarm" SMALLINT NULL DEFAULT NULL,
  "update_time" timestamp NULL DEFAULT NULL,
  PRIMARY KEY ("id", "type")
);

-- Column comments
COMMENT ON COLUMN "ailpha_model_user_status"."id" IS 'model:uuid, metric:metricId';
COMMENT ON COLUMN "ailpha_model_user_status"."type" IS 'model / metric';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_ailpha_model_user_status_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_ailpha_model_user_status_update_timestamp
BEFORE UPDATE ON "ailpha_model_user_status"
FOR EACH ROW
EXECUTE FUNCTION update_ailpha_model_user_status_timestamp();


DROP TABLE IF EXISTS "ailpha_sub_metric";
CREATE TABLE "ailpha_sub_metric"  (
  "metricId" VARCHAR(255)   NOT NULL,
  "metricName" VARCHAR(255)   NULL DEFAULT NULL,
  "action" VARCHAR(30)   NULL DEFAULT NULL,
  "field" VARCHAR(128)   NULL DEFAULT NULL,
  "description" text   NULL,
  "metricKey" text   NULL,
  "metricJson" text   NULL,
  "groupId" VARCHAR(255)   NULL DEFAULT NULL,
  "customized" INTEGER NULL DEFAULT NULL,
  "active" INTEGER NULL DEFAULT NULL,
  "canConfig" INTEGER NULL DEFAULT NULL,
  "createTime" BIGINT NULL DEFAULT NULL,
  "updateTime" BIGINT NULL DEFAULT NULL,
  "usedKeyStr" text   NULL,
  PRIMARY KEY ("metricId")
);

-- Indexes
CREATE UNIQUE INDEX "INDEX_METRIC_ID" ON "ailpha_sub_metric" ("metricId");

DROP TABLE IF EXISTS "ailpha_topology";
CREATE TABLE "ailpha_topology"  (
  "id" BIGSERIAL,
  "uuid" VARCHAR(255)   NOT NULL,
  "dataStr" TEXT   NOT NULL,
  "startTime" VARCHAR(255)   NOT NULL,
  "endTime" VARCHAR(255)   NOT NULL,
  "srcAddressSize" smallint(12) NULL DEFAULT NULL,
  "destAddressSize" smallint(12) NULL DEFAULT NULL,
  "isError" SMALLINT NOT NULL,
  "costTime" VARCHAR(300)   NULL DEFAULT '',
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "ailpha_topology"."id" IS '主键';
COMMENT ON COLUMN "ailpha_topology"."uuid" IS '名称';
COMMENT ON COLUMN "ailpha_topology"."dataStr" IS '数据';
COMMENT ON COLUMN "ailpha_topology"."startTime" IS '起始时间';
COMMENT ON COLUMN "ailpha_topology"."endTime" IS '结束时间';
COMMENT ON COLUMN "ailpha_topology"."isError" IS '是否错误';
COMMENT ON COLUMN "ailpha_topology"."costTime" IS '花费时间';


DROP TABLE IF EXISTS "dictionary_file_md5";
CREATE TABLE "dictionary_file_md5"  (
  "id" BIGSERIAL,
  "tablename" VARCHAR(255)   NULL DEFAULT NULL,
  "md5" VARCHAR(255)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);
  INSERT INTO "dictionary_file_md5" VALUES (1, 'LOG_FIELD_DEPLOY_STATUS', 'deployed');

-- Indexes
CREATE UNIQUE INDEX "tablename" ON "dictionary_file_md5" ("tablename");

-- Column comments
COMMENT ON COLUMN "dictionary_file_md5"."id" IS '主键';
COMMENT ON COLUMN "dictionary_file_md5"."tablename" IS '表名';
COMMENT ON COLUMN "dictionary_file_md5"."md5" IS 'MD5值';


DROP TABLE IF EXISTS "engine_change";
CREATE TABLE "engine_change"  (
  "id" BIGSERIAL,
  "uuid" VARCHAR(255)   NOT NULL,
  "enable" SMALLINT NOT NULL DEFAULT -1,
  PRIMARY KEY ("id")
);
  INSERT INTO "engine_change" VALUES (1, 'cdps', 0);,
  INSERT INTO "engine_change" VALUES (2, 'cep', 0);,
  INSERT INTO "engine_change" VALUES (3, 'custom', 0);,
  INSERT INTO "engine_change" VALUES (4, 'cdps_rule', 0);,
  INSERT INTO "engine_change" VALUES (5, 'custom_ioc', 0);,
  INSERT INTO "engine_change" VALUES (6, 'dic_log', 0);,
  INSERT INTO "engine_change" VALUES (7, 'dic_event', 0);,
  INSERT INTO "engine_change" VALUES (8, 'update', 0);

-- Column comments
COMMENT ON COLUMN "engine_change"."id" IS '主键';
COMMENT ON COLUMN "engine_change"."uuid" IS '名称';


DROP TABLE IF EXISTS "ice_attack";
CREATE TABLE "ice_attack"  (
  "id" BIGSERIAL,
  "intent" VARCHAR(255)   NOT NULL,
  "strategy" VARCHAR(255)   NOT NULL,
  "method" VARCHAR(255)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "ice_attack"."id" IS '主键';
COMMENT ON COLUMN "ice_attack"."intent" IS '攻击类型';
COMMENT ON COLUMN "ice_attack"."strategy" IS '攻击策略';
COMMENT ON COLUMN "ice_attack"."method" IS '攻击方法';


DROP TABLE IF EXISTS "ice_label";
CREATE TABLE "ice_label"  (
  "id" BIGSERIAL,
  "username" VARCHAR(255)   NOT NULL,
  "fields" text   NULL,
  "num" BIGINT NOT NULL,
  "scene" VARCHAR(32)   NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "ice_label"."id" IS '主键';
COMMENT ON COLUMN "ice_label"."username" IS '用户名';
COMMENT ON COLUMN "ice_label"."fields" IS '展示字段';
COMMENT ON COLUMN "ice_label"."num" IS '字典表代号';
COMMENT ON COLUMN "ice_label"."scene" IS '分析场景';


DROP TABLE IF EXISTS "ice_tag";
CREATE TABLE "ice_tag"  (
  "id" BIGSERIAL,
  "username" VARCHAR(255)   NOT NULL,
  "tagname" text   NULL,
  "input" text   NULL,
  "isFactory" BIGINT NULL DEFAULT NULL,
  "indexStr" VARCHAR(255)   NOT NULL DEFAULT '',
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "ice_tag"."id" IS '主键';
COMMENT ON COLUMN "ice_tag"."username" IS '用户名';
COMMENT ON COLUMN "ice_tag"."tagname" IS '标签名称';
COMMENT ON COLUMN "ice_tag"."input" IS '输入的搜索条件';
COMMENT ON COLUMN "ice_tag"."isFactory" IS '是否出厂';
COMMENT ON COLUMN "ice_tag"."indexStr" IS '检索分析快速查询标签默认索引';


DROP TABLE IF EXISTS "ice_tag_order";
CREATE TABLE "ice_tag_order"  (
  "id" BIGSERIAL,
  "username" VARCHAR(255)   NOT NULL,
  "tag_order" text   NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "ice_tag_order"."id" IS '主键';
COMMENT ON COLUMN "ice_tag_order"."username" IS '用户名';
COMMENT ON COLUMN "ice_tag_order"."tag_order" IS '展示顺序';


DROP TABLE IF EXISTS "oauth_client_details";
CREATE TABLE "oauth_client_details"  (
  "client_id" VARCHAR(128)   NOT NULL,
  "resource_ids" VARCHAR(256)   NULL DEFAULT NULL,
  "client_secret" VARCHAR(256)   NULL DEFAULT NULL,
  "scope" VARCHAR(256)   NULL DEFAULT NULL,
  "authorized_grant_types" VARCHAR(256)   NULL DEFAULT NULL,
  "web_server_redirect_uri" VARCHAR(256)   NULL DEFAULT NULL,
  "authorities" VARCHAR(256)   NULL DEFAULT NULL,
  "access_token_validity" INTEGER NULL DEFAULT NULL,
  "refresh_token_validity" INTEGER NULL DEFAULT NULL,
  "additional_information" VARCHAR(4096)   NULL DEFAULT NULL,
  "autoapprove" VARCHAR(256)   NULL DEFAULT NULL,
  PRIMARY KEY ("client_id")
);
  INSERT INTO "oauth_client_details" VALUES ('aiview', NULL, '$2a$10$/XR86Y/GDJgKXpB1RWWmAO02wWki7/acHWQzAilcUQ.sst2MPPpDu', 'trust', 'authorization_code,implicit', 'https://10.11.36.70:9998', NULL, NULL, NULL, '{}', 'trust');

DROP TABLE IF EXISTS "patrol_comp_alert";
CREATE TABLE "patrol_comp_alert"  (
  "id" SERIAL,
  "type" VARCHAR(30)   NOT NULL,
  "title" VARCHAR(50)   NOT NULL,
  "alert_level" SMALLINT NOT NULL,
  "module_name" VARCHAR(30)   NOT NULL,
  "detail" VARCHAR(200)   NOT NULL,
  "alert_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "valid_flag" BOOLEAN NULL DEFAULT 1,
  "update_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "create_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "del_flag" BOOLEAN NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- Column comments
COMMENT ON COLUMN "patrol_comp_alert"."id" IS '唯一ID';
COMMENT ON COLUMN "patrol_comp_alert"."type" IS '类型:logstash/es_cluster_simple/baas_job/webapp/hadoop/zookeeper/kafka/es_node/host_info';
COMMENT ON COLUMN "patrol_comp_alert"."title" IS '告警名称，关联core_dict表patrol_alert_title类型';
COMMENT ON COLUMN "patrol_comp_alert"."alert_level" IS '告警级别,1-低，2-中，3高';
COMMENT ON COLUMN "patrol_comp_alert"."module_name" IS '模块分类，关联core_dict表patrol_alert_module类型';
COMMENT ON COLUMN "patrol_comp_alert"."detail" IS '告警详情';
COMMENT ON COLUMN "patrol_comp_alert"."alert_time" IS '告警时间';
COMMENT ON COLUMN "patrol_comp_alert"."valid_flag" IS '是否有效，1-有效，0-无效';
COMMENT ON COLUMN "patrol_comp_alert"."update_time" IS '更新时间';
COMMENT ON COLUMN "patrol_comp_alert"."create_time" IS '创建时间';
COMMENT ON COLUMN "patrol_comp_alert"."del_flag" IS '是否删除，0-未删除，1-已删除';


-- Update timestamp trigger
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_patrol_comp_alert_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW."update_time" = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trigger_patrol_comp_alert_update_timestamp
BEFORE UPDATE ON "patrol_comp_alert"
FOR EACH ROW
EXECUTE FUNCTION update_patrol_comp_alert_timestamp();


DROP TABLE IF EXISTS "reputation";
CREATE TABLE "reputation"  (
  "dateip" VARCHAR(50)   NOT NULL,
  "repu" DOUBLE PRECISION NULL DEFAULT NULL,
  "detail" TEXT   NULL,
  PRIMARY KEY ("dateip")
);

DROP TABLE IF EXISTS "schema_version";
CREATE TABLE "schema_version"  (
  "installed_rank" INTEGER NOT NULL,
  "version" VARCHAR(50)   NULL DEFAULT NULL,
  "description" VARCHAR(200)   NOT NULL,
  "type" VARCHAR(20)   NOT NULL,
  "script" VARCHAR(1000)   NOT NULL,
  "checksum" INTEGER NULL DEFAULT NULL,
  "installed_by" VARCHAR(100)   NOT NULL,
  "installed_on" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "execution_time" INTEGER NOT NULL,
  "success" BOOLEAN NOT NULL,
  PRIMARY KEY ("installed_rank")
);
  INSERT INTO "schema_version" VALUES (1, '1', '<< Flyway Baseline >>', 'BASELINE', '<< Flyway Baseline >>', NULL, 'dbapp', '2026-01-13 10:37:34', 0, 1);,
  INSERT INTO "schema_version" VALUES (2, '3', 'init create', 'SQL', 'V3__init_create.sql', -827529859, 'dbapp', '2026-01-13 10:37:38', 4061, 1);,
  INSERT INTO "schema_version" VALUES (3, '20181008175134', 'alert insert', 'SQL', 'V3_2/V20181008175134__alert_insert.sql', -1255858237, 'dbapp', '2026-01-13 10:37:38', 122, 1);,
  INSERT INTO "schema_version" VALUES (4, '20181009173434', 'alter t asset info', 'SQL', 'V3_2/V20181009173434__alter_t_asset_info.sql', 176449121, 'dbapp', '2026-01-13 10:37:39', 34, 1);,
  INSERT INTO "schema_version" VALUES (5, '20181010144545', 'alter t asset info', 'SQL', 'V3_2/V20181010144545__alter_t_asset_info.sql', -48730291, 'dbapp', '2026-01-13 10:37:39', 18, 1);,
  INSERT INTO "schema_version" VALUES (6, '20181012134343', 'import inner solution', 'SQL', 'V3_2/V20181012134343__import_inner_solution.sql', 1984460073, 'dbapp', '2026-01-13 10:37:39', 8, 1);,
  INSERT INTO "schema_version" VALUES (7, '20181016192335', 'alert ailpha model', 'SQL', 'V3_2/V20181016192335__alert_ailpha_model.sql', -1634004766, 'dbapp', '2026-01-13 10:37:39', 11, 1);,
  INSERT INTO "schema_version" VALUES (8, '20181017102810', 'alert t waf', 'SQL', 'V3_2/V20181017102810__alert_t_waf.sql', 375289326, 'dbapp', '2026-01-13 10:37:39', 9, 1);,
  INSERT INTO "schema_version" VALUES (9, '20181109153322', 'alert t asset', 'SQL', 'V3_2/V20181109153322__alert_t_asset.sql', -780593511, 'dbapp', '2026-01-13 10:37:39', 2, 1);,
  INSERT INTO "schema_version" VALUES (10, '20181119092556', 'alert ailpha topology', 'SQL', 'V3_2/V20181119092556__alert_ailpha_topology.sql', -336135214, 'dbapp', '2026-01-13 10:37:39', 18, 1);,
  INSERT INTO "schema_version" VALUES (11, '20181119160811', 'create table t linkage device', 'SQL', 'V3_2/V20181119160811__create_table_t_linkage_device.sql', -663413597, 'dbapp', '2026-01-13 10:37:39', 11, 1);,
  INSERT INTO "schema_version" VALUES (12, '20181119160922', 'create table t linkage strategy', 'SQL', 'V3_2/V20181119160922__create_table_t_linkage_strategy.sql', -864162333, 'dbapp', '2026-01-13 10:37:39', 12, 1);,
  INSERT INTO "schema_version" VALUES (13, '20181120161923', 'create table ailpha model factory', 'SQL', 'V3_2/V20181120161923__create_table_ailpha_model_factory.sql', 895752490, 'dbapp', '2026-01-13 10:37:39', 7, 1);,
  INSERT INTO "schema_version" VALUES (14, '20181120195412', 'create table t threat intelligence metadata', 'SQL', 'V3_2/V20181120195412__create_table_t_threat_intelligence_metadata.sql', 285011021, 'dbapp', '2026-01-13 10:37:39', 10, 1);,
  INSERT INTO "schema_version" VALUES (15, '20181121111233', 'insert table t report', 'SQL', 'V3_2/V20181121111233__insert_table_t_report.sql', 1704816541, 'dbapp', '2026-01-13 10:37:39', 1, 1);,
  INSERT INTO "schema_version" VALUES (16, '20181204161005', 'alert table dictionary', 'SQL', 'V3_2/V20181204161005__alert_table_dictionary.sql', -1892119125, 'dbapp', '2026-01-13 10:37:39', 41, 1);,
  INSERT INTO "schema_version" VALUES (17, '20190111164700', 'alert table dictionary', 'SQL', 'V3_3/V20190111164700__alert_table_dictionary.sql', -530203975, 'dbapp', '2026-01-13 10:37:39', 84, 1);,
  INSERT INTO "schema_version" VALUES (18, '20190114094200', 'alert table model', 'SQL', 'V3_3/V20190114094200__alert_table_model.sql', -726788593, 'dbapp', '2026-01-13 10:37:39', 52, 1);,
  INSERT INTO "schema_version" VALUES (19, '20190128153400', 'create role maintain admin', 'SQL', 'V3_3/V20190128153400__create_role_maintain_admin.sql', 1336857383, 'dbapp', '2026-01-13 10:37:39', 3, 1);,
  INSERT INTO "schema_version" VALUES (20, '20190128153500', 'create table t predict alert report', 'SQL', 'V3_3/V20190128153500__create_table_t_predict_alert_report.sql', 1918795699, 'dbapp', '2026-01-13 10:37:39', 9, 1);,
  INSERT INTO "schema_version" VALUES (21, '20190128153600', 'create table t predict alert report operation history', 'SQL', 'V3_3/V20190128153600__create_table_t_predict_alert_report_operation_history.sql', -432618950, 'dbapp', '2026-01-13 10:37:39', 11, 1);,
  INSERT INTO "schema_version" VALUES (22, '20190128153700', 'create table t predict alert report tags relation', 'SQL', 'V3_3/V20190128153700__create_table_t_predict_alert_report_tags_relation.sql', 1353060127, 'dbapp', '2026-01-13 10:37:39', 14, 1);,
  INSERT INTO "schema_version" VALUES (23, '20190128153800', 'create table t work order', 'SQL', 'V3_3/V20190128153800__create_table_t_work_order.sql', 1473011892, 'dbapp', '2026-01-13 10:37:39', 13, 1);,
  INSERT INTO "schema_version" VALUES (24, '20190128153900', 'create table t work order operation history', 'SQL', 'V3_3/V20190128153900__create_table_t_work_order_operation_history.sql', 2094668162, 'dbapp', '2026-01-13 10:37:39', 46, 1);,
  INSERT INTO "schema_version" VALUES (25, '20190128154000', 'create table t work order tags relation', 'SQL', 'V3_3/V20190128154000__create_table_t_work_order_tags_relation.sql', 608439915, 'dbapp', '2026-01-13 10:37:39', 15, 1);,
  INSERT INTO "schema_version" VALUES (26, '20190128154100', 'alert table t alert item', 'SQL', 'V3_3/V20190128154100__alert_table_t_alert_item.sql', 49919730, 'dbapp', '2026-01-13 10:37:39', 86, 1);,
  INSERT INTO "schema_version" VALUES (27, '20190214153800', 'create table t asset discover', 'SQL', 'V3_3/V20190214153800__create_table_t_asset_discover.sql', -151287256, 'dbapp', '2026-01-13 10:37:39', 11, 1);,
  INSERT INTO "schema_version" VALUES (28, '20190216091600', 'alert table t alert history', 'SQL', 'V3_3/V20190216091600__alert_table_t_alert_history.sql', 1980617584, 'dbapp', '2026-01-13 10:37:39', 11, 1);,
  INSERT INTO "schema_version" VALUES (29, '20190221091600', 'alert table security logs', 'SQL', 'V3_3/V20190221091600__alert_table_security_logs.sql', -1211872803, 'dbapp', '2026-01-13 10:37:39', 17, 1);,
  INSERT INTO "schema_version" VALUES (30, '20190223112900', 'create table t asset manage', 'SQL', 'V3_3/V20190223112900__create_table_t_asset_manage.sql', -810861933, 'dbapp', '2026-01-13 10:37:39', 11, 1);,
  INSERT INTO "schema_version" VALUES (31, '20190228163000', 'create table t security device', 'SQL', 'V3_3/V20190228163000__create_table_t_security_device.sql', -1142636054, 'dbapp', '2026-01-13 10:37:40', 161, 1);,
  INSERT INTO "schema_version" VALUES (32, '20190304182100', 'create table t web info', 'SQL', 'V3_3/V20190304182100__create_table_t_web_info.sql', 108845308, 'dbapp', '2026-01-13 10:37:40', 87, 1);,
  INSERT INTO "schema_version" VALUES (33, '20190306134200', 'alert table ice tag', 'SQL', 'V3_3/V20190306134200__alert_table_ice_tag.sql', 1358087721, 'dbapp', '2026-01-13 10:37:40', 26, 1);,
  INSERT INTO "schema_version" VALUES (34, '20190307145000', 'update t common config', 'SQL', 'V3_3/V20190307145000__update_t_common_config.sql', 0, 'dbapp', '2026-01-13 10:37:40', 1, 1);,
  INSERT INTO "schema_version" VALUES (35, '20190308094100', 'alert table t linkage strategy', 'SQL', 'V3_3/V20190308094100__alert_table_t_linkage_strategy.sql', -254462425, 'dbapp', '2026-01-13 10:37:40', 13, 1);,
  INSERT INTO "schema_version" VALUES (36, '20190312194100', 'alert table t linkage strategy', 'SQL', 'V3_3/V20190312194100__alert_table_t_linkage_strategy.sql', -1294660622, 'dbapp', '2026-01-13 10:37:40', 13, 1);,
  INSERT INTO "schema_version" VALUES (37, '20190325165000', 'alert table t topology configuration', 'SQL', 'V3_3/V20190325165000__alert_table_t_topology_configuration.sql', 72396397, 'dbapp', '2026-01-13 10:37:40', 185, 1);,
  INSERT INTO "schema_version" VALUES (38, '20190326135300', 'alert table ailpha model', 'SQL', 'V3_3/V20190326135300__alert_table_ailpha_model.sql', 2142422373, 'dbapp', '2026-01-13 10:37:40', 40, 1);,
  INSERT INTO "schema_version" VALUES (39, '20190326135400', 'create table t model layout', 'SQL', 'V3_3/V20190326135400__create_table_t_model_layout.sql', 145543977, 'dbapp', '2026-01-13 10:37:40', 10, 1);,
  INSERT INTO "schema_version" VALUES (40, '20190401193500', 'insert into t security device', 'SQL', 'V3_3/V20190401193500__insert_into_t_security_device.sql', 1119749168, 'dbapp', '2026-01-13 10:37:40', 4, 1);,
  INSERT INTO "schema_version" VALUES (41, '20190409100711', 'create t organization', 'SQL', 'V3_4/V20190409100711__create_t_organization.sql', -235756091, 'dbapp', '2026-01-13 10:37:40', 15, 1);,
  INSERT INTO "schema_version" VALUES (42, '20190409140777', 'insert t organization', 'SQL', 'V3_4/V20190409140777__insert_t_organization.sql', -247195792, 'dbapp', '2026-01-13 10:37:40', 1, 1);,
  INSERT INTO "schema_version" VALUES (43, '20190410210300', 'operate user', 'SQL', 'V3_4/V20190410210300__operate_user.sql', -898871123, 'dbapp', '2026-01-13 10:37:40', 336, 1);,
  INSERT INTO "schema_version" VALUES (44, '20190412091600', 'alert table t work order', 'SQL', 'V3_4/V20190412091600__alert_table_t_work_order.sql', -471311583, 'dbapp', '2026-01-13 10:37:40', 69, 1);,
  INSERT INTO "schema_version" VALUES (45, '20190415131500', 'alter t security zone', 'SQL', 'V3_4/V20190415131500__alter_t_security_zone.sql', 852811045, 'dbapp', '2026-01-13 10:37:41', 41, 1);,
  INSERT INTO "schema_version" VALUES (46, '20190415193500', 'insert into dictionary file md5', 'SQL', 'V3_3/V20190415193500__insert_into_dictionary_file_md5.sql', -1848589347, 'dbapp', '2026-01-13 10:37:41', 1, 1);,
  INSERT INTO "schema_version" VALUES (47, '20190416131500', 'create t work order user relation', 'SQL', 'V3_4/V20190416131500__create_t_work_order_user_relation.sql', -1618485439, 'dbapp', '2026-01-13 10:37:41', 15, 1);,
  INSERT INTO "schema_version" VALUES (48, '20190422091600', 'alert table t predict alert report', 'SQL', 'V3_4/V20190422091600__alert_table_t_predict_alert_report.sql', 998246335, 'dbapp', '2026-01-13 10:37:41', 34, 1);,
  INSERT INTO "schema_version" VALUES (49, '20190424091600', 'create table t kpi statistic', 'SQL', 'V3_4/V20190424091600__create_table_t_kpi_statistic.sql', -1569323610, 'dbapp', '2026-01-13 10:37:41', 13, 1);,
  INSERT INTO "schema_version" VALUES (50, '20190424193600', 'create table t situation awareness', 'SQL', 'V3_4/V20190424193600__create_table_t_situation_awareness.sql', 275908202, 'dbapp', '2026-01-13 10:37:41', 53, 1);,
  INSERT INTO "schema_version" VALUES (51, '20190426091600', 'create table t work order status trace', 'SQL', 'V3_4/V20190426091600__create_table_t_work_order_status_trace.sql', -1608181157, 'dbapp', '2026-01-13 10:37:41', 16, 1);,
  INSERT INTO "schema_version" VALUES (52, '20190426193700', 'create table t portal screen', 'SQL', 'V3_4/V20190426193700__create_table_t_portal_screen.sql', -1108478476, 'dbapp', '2026-01-13 10:37:41', 26, 1);,
  INSERT INTO "schema_version" VALUES (53, '20190429104200', 'create table t model layout real time', 'SQL', 'V3_3/V20190429104200__create_table_t_model_layout_real_time.sql', -280274573, 'dbapp', '2026-01-13 10:37:41', 16, 1);,
  INSERT INTO "schema_version" VALUES (54, '20190505155888', 'operate login setting', 'SQL', 'V3_4/V20190505155888__operate_login_setting.sql', 1946796579, 'dbapp', '2026-01-13 10:37:41', 59, 1);,
  INSERT INTO "schema_version" VALUES (55, '20190507162900', 'create t major safeguard', 'SQL', 'V3_4/V20190507162900__create_t_major_safeguard.sql', 1171682788, 'dbapp', '2026-01-13 10:37:41', 12, 1);,
  INSERT INTO "schema_version" VALUES (56, '20190508153400', 'incr role kpi permission', 'SQL', 'V3_4/V20190508153400__incr_role_kpi_permission.sql', 1854158588, 'dbapp', '2026-01-13 10:37:41', 1, 1);,
  INSERT INTO "schema_version" VALUES (57, '20190508201800', 'create table t user portal screen', 'SQL', 'V3_4/V20190508201800__create_table_t_user_portal_screen.sql', 738830205, 'dbapp', '2026-01-13 10:37:41', 14, 1);,
  INSERT INTO "schema_version" VALUES (58, '20190509201900', 'create table t user portal screen title', 'SQL', 'V3_4/V20190509201900__create_table_t_user_portal_screen_title.sql', 1157754053, 'dbapp', '2026-01-13 10:37:41', 27, 1);,
  INSERT INTO "schema_version" VALUES (59, '20190515094351', 'create t venustech task', 'SQL', 'V3_4/V20190515094351__create_t_venustech_task.sql', -126814440, 'dbapp', '2026-01-13 10:37:41', 14, 1);,
  INSERT INTO "schema_version" VALUES (60, '20190515141939', 'create t venustech device', 'SQL', 'V3_4/V20190515141939__create_t_venustech_device.sql', 369078150, 'dbapp', '2026-01-13 10:37:41', 11, 1);,
  INSERT INTO "schema_version" VALUES (61, '20190515144924', 'create t nsfocusWeb device', 'SQL', 'V3_4/V20190515144924__create_t_nsfocusWeb_device.sql', -2142381641, 'dbapp', '2026-01-13 10:37:41', 9, 1);,
  INSERT INTO "schema_version" VALUES (62, '20190515211305', 'create t venustech task state', 'SQL', 'V3_4/V20190515211305__create_t_venustech_task_state.sql', -791179893, 'dbapp', '2026-01-13 10:37:41', 10, 1);,
  INSERT INTO "schema_version" VALUES (63, '20190524091600', 'alert table t work order status trace', 'SQL', 'V3_4/V20190524091600__alert_table_t_work_order_status_trace.sql', -2141398031, 'dbapp', '2026-01-13 10:37:41', 5, 1);,
  INSERT INTO "schema_version" VALUES (64, '20190527095900', 'operate edr', 'SQL', 'V3_4/V20190527095900__operate_edr.sql', -676911390, 'dbapp', '2026-01-13 10:37:41', 59, 1);,
  INSERT INTO "schema_version" VALUES (65, '20190529091601', 'create table t edr asset bug', 'SQL', 'V3_4/V20190529091601__create_table_t_edr_asset_bug.sql', 764435845, 'dbapp', '2026-01-13 10:37:41', 10, 1);,
  INSERT INTO "schema_version" VALUES (66, '20190529091602', 'create table t edr asset site', 'SQL', 'V3_4/V20190529091602__create_table_t_edr_asset_site.sql', -801775816, 'dbapp', '2026-01-13 10:37:41', 12, 1);,
  INSERT INTO "schema_version" VALUES (67, '20190529091603', 'create table t edr asset virus', 'SQL', 'V3_4/V20190529091603__create_table_t_edr_asset_virus.sql', -1543065816, 'dbapp', '2026-01-13 10:37:41', 13, 1);,
  INSERT INTO "schema_version" VALUES (68, '20190531085500', 'create table t quartz job', 'SQL', 'V3_4/V20190531085500__create_table_t_quartz_job.sql', -1889905150, 'dbapp', '2026-01-13 10:37:41', 11, 1);,
  INSERT INTO "schema_version" VALUES (69, '20190603085500', 'insert table t quartz job', 'SQL', 'V3_4/V20190603085500__insert_table_t_quartz_job.sql', -1183091477, 'dbapp', '2026-01-13 10:37:41', 22, 1);,
  INSERT INTO "schema_version" VALUES (70, '20190606170100', 'operate edr', 'SQL', 'V3_4/V20190606170100__operate_edr.sql', 744385538, 'dbapp', '2026-01-13 10:37:41', 5, 1);,
  INSERT INTO "schema_version" VALUES (71, '20190612102300', 'update table t user', 'SQL', 'V3_4/V20190612102300__update_table_t_user.sql', 1461952239, 'dbapp', '2026-01-13 10:37:41', 6, 1);,
  INSERT INTO "schema_version" VALUES (72, '20190613091600', 'alert table t security device name', 'SQL', 'V3_4/V20190613091600__alert_table_t_security_device_name.sql', -1717632670, 'dbapp', '2026-01-13 10:37:41', 23, 1);,
  INSERT INTO "schema_version" VALUES (73, '20190617195900', 'create table oauth client details', 'SQL', 'V3_4/V20190617195900__create_table_oauth_client_details.sql', 226212287, 'dbapp', '2026-01-13 10:37:41', 11, 1);,
  INSERT INTO "schema_version" VALUES (74, '20190618085500', 'update table t threat intelligence metadata', 'SQL', 'V3_4/V20190618085500__update_table_t_threat_intelligence_metadata.sql', -785817512, 'dbapp', '2026-01-13 10:37:41', 2, 1);,
  INSERT INTO "schema_version" VALUES (75, '20190625142500', 'alert table t web asset add idx', 'SQL', 'V3_4/V20190625142500__alert_table_t_web_asset_add_idx.sql', 475508321, 'dbapp', '2026-01-13 10:37:41', 14, 1);,
  INSERT INTO "schema_version" VALUES (76, '20190627173100', 'insert t filter', 'SQL', 'V3_4/V20190627173100__insert_t_filter.sql', 614316361, 'dbapp', '2026-01-13 10:37:41', 3, 1);,
  INSERT INTO "schema_version" VALUES (77, '20190628160900', 'create t license', 'SQL', 'V3_4/V20190628160900__create_t_license.sql', -1633912023, 'dbapp', '2026-01-13 10:37:41', 10, 1);,
  INSERT INTO "schema_version" VALUES (78, '20190708112300', 'alert table t work order operation history', 'SQL', 'V3_4/V20190708112300__alert_table_t_work_order_operation_history.sql', -506165815, 'dbapp', '2026-01-13 10:37:41', 14, 1);,
  INSERT INTO "schema_version" VALUES (79, '20190708135000', 'alert table t linkage strategy', 'SQL', 'V3_4/V20190708135000__alert_table_t_linkage_strategy.sql', -735876092, 'dbapp', '2026-01-13 10:37:42', 46, 1);,
  INSERT INTO "schema_version" VALUES (80, '20190708135100', 'create table t linkage strategy validtime', 'SQL', 'V3_4/V20190708135100__create_table_t_linkage_strategy_validtime.sql', -1848575644, 'dbapp', '2026-01-13 10:37:42', 11, 1);,
  INSERT INTO "schema_version" VALUES (81, '20190708145500', 'insert table t quartz job linkageStrategy', 'SQL', 'V3_4/V20190708145500__insert_table_t_quartz_job_linkageStrategy.sql', -1675944873, 'dbapp', '2026-01-13 10:37:42', 1, 1);,
  INSERT INTO "schema_version" VALUES (82, '20190708170300', 'alter table t license', 'SQL', 'V3_4/V20190708170300__alter_table_t_license.sql', -1351174747, 'dbapp', '2026-01-13 10:37:42', 25, 1);,
  INSERT INTO "schema_version" VALUES (83, '20190715132400', 'alert table t model layout', 'SQL', 'V3_4/V20190715132400__alert_table_t_model_layout.sql', 904184846, 'dbapp', '2026-01-13 10:37:42', 179, 1);,
  INSERT INTO "schema_version" VALUES (84, '20190715142700', 'create t model layout task', 'SQL', 'V3_4/V20190715142700__create_t_model_layout_task.sql', -68181390, 'dbapp', '2026-01-13 10:37:42', 12, 1);,
  INSERT INTO "schema_version" VALUES (85, '20190716145500', 'insert table t quartz job', 'SQL', 'V3_4/V20190716145500__insert_table_t_quartz_job.sql', -1794422674, 'dbapp', '2026-01-13 10:37:42', 1, 1);,
  INSERT INTO "schema_version" VALUES (86, '20190716152200', 'create t license center', 'SQL', 'V3_4/V20190716152200__create_t_license_center.sql', 64969367, 'dbapp', '2026-01-13 10:37:42', 135, 1);,
  INSERT INTO "schema_version" VALUES (87, '20190723094000', 'update table t license', 'SQL', 'V3_4/V20190723094000__update_table_t_license.sql', 935361178, 'dbapp', '2026-01-13 10:37:42', 8, 1);,
  INSERT INTO "schema_version" VALUES (88, '20190725142700', 'update t security zone and t security device', 'SQL', 'V3_4/V20190725142700__update_t_security_zone_and_t_security_device.sql', 1477135172, 'dbapp', '2026-01-13 10:37:42', 2, 1);,
  INSERT INTO "schema_version" VALUES (89, '20190726142100', 'alert table t model layout', 'SQL', 'V3_4/V20190726142100__alert_table_t_model_layout.sql', 235769545, 'dbapp', '2026-01-13 10:37:42', 13, 1);,
  INSERT INTO "schema_version" VALUES (90, '20190730145900', 'alert table t model layout real time', 'SQL', 'V3_4/V20190730145900__alert_table_t_model_layout_real_time.sql', -770368039, 'dbapp', '2026-01-13 10:37:42', 13, 1);,
  INSERT INTO "schema_version" VALUES (91, '20190802141100', 'create t layout notice history', 'SQL', 'V3_4/V20190802141100__create_t_layout_notice_history.sql', 527173152, 'dbapp', '2026-01-13 10:37:42', 13, 1);,
  INSERT INTO "schema_version" VALUES (92, '20190807132355', 'alert security group', 'SQL', 'V3_4/V20190807132355__alert_security_group.sql', -1822435928, 'dbapp', '2026-01-13 10:37:42', 20, 1);,
  INSERT INTO "schema_version" VALUES (93, '20190808092355', 'alert index', 'SQL', 'V3_4/V20190808092355__alert_index.sql', 1291806241, 'dbapp', '2026-01-13 10:37:42', 6, 1);,
  INSERT INTO "schema_version" VALUES (94, '20190809092455', 'alert t model layout', 'SQL', 'V3_4/V20190809092455__alert_t_model_layout.sql', -1258911878, 'dbapp', '2026-01-13 10:37:42', 31, 1);,
  INSERT INTO "schema_version" VALUES (95, '20190817151755', 'alert table security value', 'SQL', 'V3_4/V20190817151755__alert_table_security_value.sql', 1685669472, 'dbapp', '2026-01-13 10:37:42', 96, 1);,
  INSERT INTO "schema_version" VALUES (96, '20190817181755', 'alert t model layout', 'SQL', 'V3_4/V20190817181755__alert_t_model_layout.sql', -1955305849, 'dbapp', '2026-01-13 10:37:42', 11, 1);,
  INSERT INTO "schema_version" VALUES (97, '20190819153700', 'insert t model layout', 'SQL', 'V3_4/V20190819153700__insert_t_model_layout.sql', 2124983697, 'dbapp', '2026-01-13 10:37:42', 39, 1);,
  INSERT INTO "schema_version" VALUES (98, '20190820141100', 'create t model metric', 'SQL', 'V3_5/V20190820141100__create_t_model_metric.sql', 310170706, 'dbapp', '2026-01-13 10:37:42', 10, 1);,
  INSERT INTO "schema_version" VALUES (99, '20190823100000', 'update table t portal screen', 'SQL', 'V3_4/V20190823100000__update_table_t_portal_screen.sql', -1647555655, 'dbapp', '2026-01-13 10:37:42', 2, 1);,
  INSERT INTO "schema_version" VALUES (100, '20190823152255', 'update ailpha sub metric', 'SQL', 'V3_4/V20190823152255__update_ailpha_sub_metric.sql', -1585664003, 'dbapp', '2026-01-13 10:37:42', 1, 1);,
  INSERT INTO "schema_version" VALUES (101, '20190906160755', 'alert dictionary file md5', 'SQL', 'V3_4/V20190906160755__alert_dictionary_file_md5.sql', 1336994951, 'dbapp', '2026-01-13 10:37:42', 15, 1);,
  INSERT INTO "schema_version" VALUES (102, '20190906161755', 'alert ailpha model user status', 'SQL', 'V3_4/V20190906161755__alert_ailpha_model_user_status.sql', -157747596, 'dbapp', '2026-01-13 10:37:42', 1, 1);,
  INSERT INTO "schema_version" VALUES (103, '20190906161855', 'alert ailpha model user status', 'SQL', 'V3_4/V20190906161855__alert_ailpha_model_user_status.sql', -1041624133, 'dbapp', '2026-01-13 10:37:42', 1, 1);,
  INSERT INTO "schema_version" VALUES (104, '20190911105255', 'alert ailpha model change', 'SQL', 'V3_4/V20190911105255__alert_ailpha_model_change.sql', 1422023557, 'dbapp', '2026-01-13 10:37:42', 1, 1);,
  INSERT INTO "schema_version" VALUES (105, '20191022131000', 'create t search save group', 'SQL', 'V3_5/V20191022131000__create_t_search_save_group.sql', -475307475, 'dbapp', '2026-01-13 10:37:42', 9, 1);,
  INSERT INTO "schema_version" VALUES (106, '20191022131100', 'create t search save', 'SQL', 'V3_5/V20191022131100__create_t_search_save.sql', -1920627681, 'dbapp', '2026-01-13 10:37:43', 11, 1);,
  INSERT INTO "schema_version" VALUES (107, '20191101163900', 'delete index job', 'SQL', 'V3_5/V20191101163900__delete_index_job.sql', -240441677, 'dbapp', '2026-01-13 10:37:43', 2, 1);,
  INSERT INTO "schema_version" VALUES (108, '20191113134200', 'create t model layout form', 'SQL', 'V3_5/V20191113134200__create_t_model_layout_form.sql', 1411492350, 'dbapp', '2026-01-13 10:37:43', 10, 1);,
  INSERT INTO "schema_version" VALUES (109, '20191113134500', 'create t model layout task record', 'SQL', 'V3_5/V20191113134500__create_t_model_layout_task_record.sql', 576222056, 'dbapp', '2026-01-13 10:37:43', 17, 1);,
  INSERT INTO "schema_version" VALUES (110, '20191113134700', 'create t model layout action time', 'SQL', 'V3_5/V20191113134700__create_t_model_layout_action_time.sql', -95276816, 'dbapp', '2026-01-13 10:37:43', 13, 1);,
  INSERT INTO "schema_version" VALUES (111, '20191118181800', 'alter t quartz job', 'SQL', 'V3_5/V20191118181800__alter_t_quartz_job.sql', 154997036, 'dbapp', '2026-01-13 10:37:43', 17, 1);,
  INSERT INTO "schema_version" VALUES (112, '20191118181900', 'update t quartz job', 'SQL', 'V3_5/V20191118181900__update_t_quartz_job.sql', 339092411, 'dbapp', '2026-01-13 10:37:43', 22, 1);,
  INSERT INTO "schema_version" VALUES (113, '20191203142200', 'create t threat intelligence modify', 'SQL', 'V3_5/V20191203142200__create_t_threat_intelligence_modify.sql', 1752164210, 'dbapp', '2026-01-13 10:37:43', 8, 1);,
  INSERT INTO "schema_version" VALUES (114, '20191209191000', 'insert t common config update', 'SQL', 'V3_5/V20191209191000__insert_t_common_config_update.sql', -1082776411, 'dbapp', '2026-01-13 10:37:43', 1, 1);,
  INSERT INTO "schema_version" VALUES (115, '20191218142300', 'create t bs knowledge', 'SQL', 'V3_5/V20191218142300__create_t_bs_knowledge.sql', -959933283, 'dbapp', '2026-01-13 10:37:43', 14, 1);,
  INSERT INTO "schema_version" VALUES (116, '20191223100200', 'insert t common config', 'SQL', 'V3_5/V20191223100200__insert_t_common_config.sql', -1051024884, 'dbapp', '2026-01-13 10:37:43', 12, 1);,
  INSERT INTO "schema_version" VALUES (117, '20200107142300', 'alter alert item add rule', 'SQL', 'V3_5/V20200107142300__alter_alert_item_add_rule.sql', 542722829, 'dbapp', '2026-01-13 10:37:43', 14, 1);,
  INSERT INTO "schema_version" VALUES (118, '20200212191100', 'update ailpha aiAnalysis', 'SQL', 'V3_5/V20200212191100__update_ailpha_aiAnalysis.sql', 1260447529, 'dbapp', '2026-01-13 10:37:43', 2, 1);,
  INSERT INTO "schema_version" VALUES (119, '20200225175500', 'alter ice label add scene', 'SQL', 'V3_5/V20200225175500__alter_ice_label_add_scene.sql', 1695862115, 'dbapp', '2026-01-13 10:37:43', 13, 1);,
  INSERT INTO "schema_version" VALUES (120, '20200330130000', 'create t alarm aggregation fields table', 'SQL', 'V3_5/V20200330130000__create_t_alarm_aggregation_fields_table.sql', 1804379834, 'dbapp', '2026-01-13 10:37:43', 10, 1);,
  INSERT INTO "schema_version" VALUES (121, '20200415193000', 'import inner solution', 'SQL', 'V3_5/V20200415193000__import_inner_solution.sql', 1107181471, 'dbapp', '2026-01-13 10:37:43', 5, 1);,
  INSERT INTO "schema_version" VALUES (122, '20200422151900', 'add alert column back', 'SQL', 'V3_5/V20200422151900__add_alert_column_back.sql', 701790511, 'dbapp', '2026-01-13 10:37:43', 3, 1);,
  INSERT INTO "schema_version" VALUES (123, '20200423151900', 'alter alert item', 'SQL', 'V3_5/V20200423151900__alter_alert_item.sql', -410868663, 'dbapp', '2026-01-13 10:37:43', 19, 1);,
  INSERT INTO "schema_version" VALUES (124, '20200424152700', 'create t attack update', 'SQL', 'V3_5/V20200424152700__create_t_attack_update.sql', -448238178, 'dbapp', '2026-01-13 10:37:43', 23, 1);,
  INSERT INTO "schema_version" VALUES (125, '20200424165100', 'update t role type', 'SQL', 'V3_5/V20200424165100__update_t_role_type.sql', 1096694271, 'dbapp', '2026-01-13 10:37:43', 1, 1);,
  INSERT INTO "schema_version" VALUES (126, '20200428130000', 'update t alarm aggregation fields table', 'SQL', 'V3_5/V20200428130000__update_t_alarm_aggregation_fields_table.sql', -1904567865, 'dbapp', '2026-01-13 10:37:43', 1, 1);,
  INSERT INTO "schema_version" VALUES (127, '20200509161800', 'update t quartz job', 'SQL', 'V3_5/V20200509161800__update_t_quartz_job.sql', -1807248270, 'dbapp', '2026-01-13 10:37:43', 1, 1);,
  INSERT INTO "schema_version" VALUES (128, '20200513130000', 'update t alarm aggregation fields table', 'SQL', 'V3_5/V20200513130000__update_t_alarm_aggregation_fields_table.sql', -32098175, 'dbapp', '2026-01-13 10:37:43', 3, 1);,
  INSERT INTO "schema_version" VALUES (129, '20200514190800', 'update t portal screen', 'SQL', 'V3_5/V20200514190800__update_t_portal_screen.sql', -1604678020, 'dbapp', '2026-01-13 10:37:43', 2, 1);,
  INSERT INTO "schema_version" VALUES (130, '20200515104100', 'insert t search save', 'SQL', 'V3_5/V20200515104100__insert_t_search_save.sql', -1947845120, 'dbapp', '2026-01-13 10:37:43', 28, 1);,
  INSERT INTO "schema_version" VALUES (131, '20200523132000', 'create t query template group', 'SQL', 'V3_5_1/V20200523132000__create_t_query_template_group.sql', -181190556, 'dbapp', '2026-01-13 10:37:43', 15, 1);,
  INSERT INTO "schema_version" VALUES (132, '20200523133000', 'create t query template', 'SQL', 'V3_5_1/V20200523133000__create_t_query_template.sql', -1904451490, 'dbapp', '2026-01-13 10:37:43', 13, 1);,
  INSERT INTO "schema_version" VALUES (133, '20200523141500', 'update t center model', 'SQL', 'V3_5/V20200523141500__update_t_center_model.sql', 573000883, 'dbapp', '2026-01-13 10:37:43', 6, 1);,
  INSERT INTO "schema_version" VALUES (134, '20200526211000', 'update t linkage strategy', 'SQL', 'V3_5/V20200526211000__update_t_linkage_strategy.sql', 945029543, 'dbapp', '2026-01-13 10:37:43', 56, 1);,
  INSERT INTO "schema_version" VALUES (135, '20200604110500', 'insert table t quartz job', 'SQL', 'V3_5_1/V20200604110500__insert_table_t_quartz_job.sql', -1979829905, 'dbapp', '2026-01-13 10:37:43', 2, 1);,
  INSERT INTO "schema_version" VALUES (136, '20200604133000', 'insert t query template', 'SQL', 'V3_5_1/V20200604133000__insert_t_query_template.sql', -587301025, 'dbapp', '2026-01-13 10:37:43', 19, 1);,
  INSERT INTO "schema_version" VALUES (137, '20200609102100', 'create t soar tables', 'SQL', 'V3_5_1/V20200609102100__create_t_soar_tables.sql', -2057777526, 'dbapp', '2026-01-13 10:37:43', 75, 1);,
  INSERT INTO "schema_version" VALUES (138, '20200612103311', 'alter table t asset port', 'SQL', 'V3_5_1/V20200612103311__alter_table_t_asset_port.sql', 1904343223, 'dbapp', '2026-01-13 10:37:43', 14, 1);,
  INSERT INTO "schema_version" VALUES (139, '20200612110111', 'create table t dispose event', 'SQL', 'V3_5_1/V20200612110111__create_table_t_dispose_event.sql', -646306745, 'dbapp', '2026-01-13 10:37:43', 29, 1);,
  INSERT INTO "schema_version" VALUES (140, '20200612131611', 'alert table t asset manage', 'SQL', 'V3_5_1/V20200612131611__alert_table_t_asset_manage.sql', -1399045266, 'dbapp', '2026-01-13 10:37:43', 18, 1);,
  INSERT INTO "schema_version" VALUES (141, '20200612142911', 'create table t asset find', 'SQL', 'V3_5_1/V20200612142911__create_table_t_asset_find.sql', -72606242, 'dbapp', '2026-01-13 10:37:43', 26, 1);,
  INSERT INTO "schema_version" VALUES (142, '20200612144811', 'alter table t webscan issuetype', 'SQL', 'V3_5_1/V20200612144811__alter_table_t_webscan_issuetype.sql', -2035570273, 'dbapp', '2026-01-13 10:37:43', 12, 1);,
  INSERT INTO "schema_version" VALUES (143, '20200612154311', 'insert into t common config', 'SQL', 'V3_5_1/V20200612154311__insert_into_t_common_config.sql', -360942952, 'dbapp', '2026-01-13 10:37:43', 1, 1);,
  INSERT INTO "schema_version" VALUES (144, '20200713150000', 'create t security incidents', 'SQL', 'V3_5_1/V20200713150000__create_t_security_incidents.sql', 1140974341, 'dbapp', '2026-01-13 10:37:43', 7, 1);,
  INSERT INTO "schema_version" VALUES (145, '20200714150000', 'insert into t quartz job', 'SQL', 'V3_5_1/V20200714150000__insert_into_t_quartz_job.sql', 652116007, 'dbapp', '2026-01-13 10:37:43', 1, 1);,
  INSERT INTO "schema_version" VALUES (146, '20200720184600', 'update t webscan issuetype', 'SQL', 'V3_5_1/V20200720184600__update_t_webscan_issuetype.sql', -311548268, 'dbapp', '2026-01-13 10:37:44', 2, 1);,
  INSERT INTO "schema_version" VALUES (147, '20200811170003', 'alter t alert item', 'SQL', 'V3_5_1/V20200811170003__alter_t_alert_item.sql', -1056758396, 'dbapp', '2026-01-13 10:37:44', 78, 1);,
  INSERT INTO "schema_version" VALUES (148, '20200820160003', 'insert t alert history', 'SQL', 'V3_5_1/V20200820160003__insert_t_alert_history.sql', 2000207231, 'dbapp', '2026-01-13 10:37:44', 25, 1);,
  INSERT INTO "schema_version" VALUES (149, '20200901133100', 'insert into t soar layout', 'SQL', 'V3_5_1/V20200901133100__insert_into_t_soar_layout.sql', 1950152455, 'dbapp', '2026-01-13 10:37:44', 100, 1);,
  INSERT INTO "schema_version" VALUES (150, '20200915100800', 'alert table t soar layout', 'SQL', 'V3_5_2/V20200915100800__alert_table_t_soar_layout.sql', -860800158, 'dbapp', '2026-01-13 10:37:44', 24, 1);,
  INSERT INTO "schema_version" VALUES (151, '20201109150000', 'insert into t quartz job', 'SQL', 'V3_5_3/V20201109150000__insert_into_t_quartz_job.sql', 2133176691, 'dbapp', '2026-01-13 10:37:44', 1, 1);,
  INSERT INTO "schema_version" VALUES (152, '20201118153000', 'insert t query template', 'SQL', 'V3_5_3/V20201118153000__insert_t_query_template.sql', -355721071, 'dbapp', '2026-01-13 10:37:44', 4, 1);,
  INSERT INTO "schema_version" VALUES (153, '20201126202300', 'create table t dilatation history', 'SQL', 'V3_5_3/V20201126202300__create_table_t_dilatation_history.sql', 1761851768, 'dbapp', '2026-01-13 10:37:44', 10, 1);,
  INSERT INTO "schema_version" VALUES (154, '20201201133000', 'create t screen rotation config', 'SQL', 'V3_5_3/V20201201133000__create_t_screen_rotation_config.sql', -2080657277, 'dbapp', '2026-01-13 10:37:44', 11, 1);,
  INSERT INTO "schema_version" VALUES (155, '20201214153000', 'alter table t license', 'SQL', 'V3_5_3/V20201214153000__alter_table_t_license.sql', -93062749, 'dbapp', '2026-01-13 10:37:44', 14, 1);,
  INSERT INTO "schema_version" VALUES (156, '20201229143000', 'create table t ailpha security zone', 'SQL', 'V3_5_5/V20201229143000__create_table_t_ailpha_security_zone.sql', 989179059, 'dbapp', '2026-01-13 10:37:44', 11, 1);,
  INSERT INTO "schema_version" VALUES (157, '20201229153000', 'create table t ailpha network segment', 'SQL', 'V3_5_5/V20201229153000__create_table_t_ailpha_network_segment.sql', -1944328763, 'dbapp', '2026-01-13 10:37:44', 10, 1);,
  INSERT INTO "schema_version" VALUES (158, '20210106093000', 'alert table t alert way', 'SQL', 'V3_5_1/V20210106093000__alert_table_t_alert_way.sql', -372406056, 'dbapp', '2026-01-13 10:37:44', 13, 1);,
  INSERT INTO "schema_version" VALUES (159, '20210108000000', 'alert t asset info', 'SQL', 'V3_5_5/V20210108000000__alert_t_asset_info.sql', -1217933893, 'dbapp', '2026-01-13 10:37:44', 24, 1);,
  INSERT INTO "schema_version" VALUES (160, '20210111130800', 'create table t es index', 'SQL', 'V3_5_5/V20210111130800__create_table_t_es_index.sql', -593025279, 'dbapp', '2026-01-13 10:37:44', 9, 1);,
  INSERT INTO "schema_version" VALUES (161, '20210115143000', 'create table t ailpha inner ip config', 'SQL', 'V3_5_5/V20210115143000__create_table_t_ailpha_inner_ip_config.sql', 83244016, 'dbapp', '2026-01-13 10:37:44', 9, 1);,
  INSERT INTO "schema_version" VALUES (162, '20210116143000', 'delete table t quartz job', 'SQL', 'V3_5_5/V20210116143000__delete_table_t_quartz_job.sql', 1464045273, 'dbapp', '2026-01-13 10:37:44', 1, 1);,
  INSERT INTO "schema_version" VALUES (163, '20210118092400', 'create table t auth version', 'SQL', 'V3_5_5/V20210118092400__create_table_t_auth_version.sql', -991841812, 'dbapp', '2026-01-13 10:37:44', 8, 1);,
  INSERT INTO "schema_version" VALUES (164, '20210118092800', 'alert table t permission', 'SQL', 'V3_5_5/V20210118092800__alert_table_t_permission.sql', 781684936, 'dbapp', '2026-01-13 10:37:44', 397, 1);,
  INSERT INTO "schema_version" VALUES (165, '20210118161600', 'create table t bs extension', 'SQL', 'V3_5_5/V20210118161600__create_table_t_bs_extension.sql', -1048408998, 'dbapp', '2026-01-13 10:37:44', 20, 1);,
  INSERT INTO "schema_version" VALUES (166, '20210119163000', 'update table t user', 'SQL', 'V3_5_3/V20210119163000__update_table_t_user.sql', -1325875313, 'dbapp', '2026-01-13 10:37:45', 1, 1);,
  INSERT INTO "schema_version" VALUES (167, '20210120143000', 'create table sequence', 'SQL', 'V3_5_5/V20210120143000__create_table_sequence.sql', -685721916, 'dbapp', '2026-01-13 10:37:45', 334, 1);,
  INSERT INTO "schema_version" VALUES (168, '20210203000000', 'alert t asset info', 'SQL', 'V3_5_5/V20210203000000__alert_t_asset_info.sql', 495619834, 'dbapp', '2026-01-13 10:37:45', 12, 1);,
  INSERT INTO "schema_version" VALUES (169, '20210301095500', 'create table t serv report', 'SQL', 'V3_5_4/V20210301095500__create_table_t_serv_report.sql', 1232999961, 'dbapp', '2026-01-13 10:37:45', 7, 1);,
  INSERT INTO "schema_version" VALUES (170, '20210303092000', 'create table t merge alarm read status', 'SQL', 'V3_5_4/V20210303092000__create_table_t_merge_alarm_read_status.sql', -639490826, 'dbapp', '2026-01-13 10:37:45', 6, 1);,
  INSERT INTO "schema_version" VALUES (171, '20210303093000', 'create table t merge alarm user preference', 'SQL', 'V3_5_4/V20210303093000__create_table_t_merge_alarm_user_preference.sql', -1747422913, 'dbapp', '2026-01-13 10:37:45', 12, 1);,
  INSERT INTO "schema_version" VALUES (172, '20210306160000', 'insert into t quartz job', 'SQL', 'V3_5_4/V20210306160000__insert_into_t_quartz_job.sql', 1838721354, 'dbapp', '2026-01-13 10:37:45', 2, 1);,
  INSERT INTO "schema_version" VALUES (173, '20210311154400', 'insert into t user', 'SQL', 'V3_5_4/V20210311154400__insert_into_t_user.sql', -2108989009, 'dbapp', '2026-01-13 10:37:45', 2, 1);,
  INSERT INTO "schema_version" VALUES (174, '20210312181000', 'update t webscan issuetype', 'SQL', 'V3_5_1/V20210312181000__update_t_webscan_issuetype.sql', -311548268, 'dbapp', '2026-01-13 10:37:45', 2, 1);,
  INSERT INTO "schema_version" VALUES (175, '20210323140000', 'create table t merge rule desc', 'SQL', 'V3_5_5/V20210323140000__create_table_t_merge_rule_desc.sql', 814457224, 'dbapp', '2026-01-13 10:37:45', 9, 1);,
  INSERT INTO "schema_version" VALUES (176, '20210406191000', 'update security alarm', 'SQL', 'V3_5_5/V20210406191000__update_security_alarm.sql', -1782091650, 'dbapp', '2026-01-13 10:37:45', 2, 1);,
  INSERT INTO "schema_version" VALUES (177, '20210406195300', 'update security alarm', 'SQL', 'V3_5_5/V20210406195300__update_security_alarm.sql', 1262832462, 'dbapp', '2026-01-13 10:37:45', 3, 1);,
  INSERT INTO "schema_version" VALUES (178, '20210407100500', 'alert t permission', 'SQL', 'V3_5_5/V20210407100500__alert_t_permission.sql', -1411291057, 'dbapp', '2026-01-13 10:37:45', 72, 1);,
  INSERT INTO "schema_version" VALUES (179, '20210407131000', 'create t device', 'SQL', 'V3_5_5/V20210407131000__create_t_device.sql', 1271768587, 'dbapp', '2026-01-13 10:37:45', 41, 1);,
  INSERT INTO "schema_version" VALUES (180, '20210413095500', 'create table t bs apikey', 'SQL', 'V3_5_5/V20210413095500__create_table_t_bs_apikey.sql', -1813612540, 'dbapp', '2026-01-13 10:37:45', 11, 1);,
  INSERT INTO "schema_version" VALUES (181, '20210413102200', 'create table t bs files', 'SQL', 'V3_5_5/V20210413102200__create_table_t_bs_files.sql', -208824221, 'dbapp', '2026-01-13 10:37:45', 9, 1);,
  INSERT INTO "schema_version" VALUES (182, '20210413102300', 'create table t sev agent', 'SQL', 'V3_5_5/V20210413102300__create_table_t_sev_agent.sql', 37413198, 'dbapp', '2026-01-13 10:37:45', 88, 1);,
  INSERT INTO "schema_version" VALUES (183, '20210413141400', 'alter updatelog', 'SQL', 'V3_5_5/V20210413141400__alter_updatelog.sql', -2050217574, 'dbapp', '2026-01-13 10:37:45', 61, 1);,
  INSERT INTO "schema_version" VALUES (184, '20210413141600', 'insert t quartz job', 'SQL', 'V3_5_5/V20210413141600__insert_t_quartz_job.sql', 339405397, 'dbapp', '2026-01-13 10:37:45', 1, 1);,
  INSERT INTO "schema_version" VALUES (185, '20210413161000', 'alert table t alert item', 'SQL', 'V3_5_5/V20210413161000__alert_table_t_alert_item.sql', -190529389, 'dbapp', '2026-01-13 10:37:45', 12, 1);,
  INSERT INTO "schema_version" VALUES (186, '20210416170500', 'insert t quartz', 'SQL', 'V3_5_5/V20210416170500__insert_t_quartz.sql', 2104377285, 'dbapp', '2026-01-13 10:37:45', 1, 1);,
  INSERT INTO "schema_version" VALUES (187, '20210421200000', 'create t scan strategy', 'SQL', 'V3_5_5/V20210421200000__create_t_scan_strategy.sql', 1631763883, 'dbapp', '2026-01-13 10:37:45', 9, 1);,
  INSERT INTO "schema_version" VALUES (188, '20210429171000', 'alert table t linkage strategy', 'SQL', 'V3_5_5/V20210429171000__alert_table_t_linkage_strategy.sql', 1544667467, 'dbapp', '2026-01-13 10:37:45', 16, 1);,
  INSERT INTO "schema_version" VALUES (189, '20210506153300', 'init patrol', 'SQL', 'V3_5_5/V20210506153300__init_patrol.sql', 151049468, 'dbapp', '2026-01-13 10:37:45', 8, 1);,
  INSERT INTO "schema_version" VALUES (190, '20210510144700', 'create table t bs message type', 'SQL', 'V3_5_5/V20210510144700__create_table_t_bs_message_type.sql', -860735027, 'dbapp', '2026-01-13 10:37:46', 8, 1);,
  INSERT INTO "schema_version" VALUES (191, '20210510155000', 'create table t bs user subscribe config', 'SQL', 'V3_5_5/V20210510155000__create_table_t_bs_user_subscribe_config.sql', 1896296856, 'dbapp', '2026-01-13 10:37:46', 13, 1);,
  INSERT INTO "schema_version" VALUES (192, '20210511122500', 'add job', 'SQL', 'V3_5_5/V20210511122500__add_job.sql', 2039769582, 'dbapp', '2026-01-13 10:37:46', 1, 1);,
  INSERT INTO "schema_version" VALUES (193, '20210511163000', 'insert t vendor model', 'SQL', 'V3_5_5/V20210511163000__insert_t_vendor_model.sql', 1130242902, 'dbapp', '2026-01-13 10:37:46', 1, 1);,
  INSERT INTO "schema_version" VALUES (194, '20210517100000', 'alert table t device', 'SQL', 'V3_5_5/V20210517100000__alert_table_t_device.sql', -972638857, 'dbapp', '2026-01-13 10:37:46', 15, 1);,
  INSERT INTO "schema_version" VALUES (195, '20210518091100', 'add job', 'SQL', 'V3_5_5/V20210518091100__add_job.sql', -622734093, 'dbapp', '2026-01-13 10:37:46', 1, 1);,
  INSERT INTO "schema_version" VALUES (196, '20210520090010', 'alter t alert item', 'SQL', 'V3_5_5/V20210520090010__alter_t_alert_item.sql', 530805454, 'dbapp', '2026-01-13 10:37:46', 21, 1);,
  INSERT INTO "schema_version" VALUES (197, '20210520203800', 'add job', 'SQL', 'V3_5_5/V20210520203800__add_job.sql', 1678125896, 'dbapp', '2026-01-13 10:37:46', 1, 1);,
  INSERT INTO "schema_version" VALUES (198, '20210521093537', 'insert t vendor model', 'SQL', 'V3_5_5/V20210521093537__insert_t_vendor_model.sql', -1308942718, 'dbapp', '2026-01-13 10:37:46', 8, 1);,
  INSERT INTO "schema_version" VALUES (199, '20210521155700', 'create agent view', 'SQL', 'V3_5_5/V20210521155700__create_agent_view.sql', 1337201534, 'dbapp', '2026-01-13 10:37:46', 15, 1);,
  INSERT INTO "schema_version" VALUES (200, '20210524140000', 'create t intelligence source metadata', 'SQL', 'V3_5_5/V20210524140000__create_t_intelligence_source_metadata.sql', 21236622, 'dbapp', '2026-01-13 10:37:46', 23, 1);,
  INSERT INTO "schema_version" VALUES (201, '20210524150000', 'create t intelligence source function', 'SQL', 'V3_5_5/V20210524150000__create_t_intelligence_source_function.sql', -741095781, 'dbapp', '2026-01-13 10:37:46', 22, 1);,
  INSERT INTO "schema_version" VALUES (202, '20210524163000', 'create t intelligence source log', 'SQL', 'V3_5_5/V20210524163000__create_t_intelligence_source_log.sql', 2018292866, 'dbapp', '2026-01-13 10:37:46', 8, 1);,
  INSERT INTO "schema_version" VALUES (203, '20210524173000', 'create t threat intelligence tag', 'SQL', 'V3_5_5/V20210524173000__create_t_threat_intelligence_tag.sql', 368453894, 'dbapp', '2026-01-13 10:37:46', 10, 1);,
  INSERT INTO "schema_version" VALUES (204, '20210524193000', 'insert t quartz', 'SQL', 'V3_5_5/V20210524193000__insert_t_quartz.sql', -768734101, 'dbapp', '2026-01-13 10:37:46', 2, 1);,
  INSERT INTO "schema_version" VALUES (205, '20210524203000', 'drop t threat intelligence', 'SQL', 'V3_5_5/V20210524203000__drop_t_threat_intelligence.sql', -1262997160, 'dbapp', '2026-01-13 10:37:46', 12, 1);,
  INSERT INTO "schema_version" VALUES (206, '20210605155900', 'alert history type', 'SQL', 'V3_5_5/V20210605155900__alert_history_type.sql', 914952673, 'dbapp', '2026-01-13 10:37:46', 32, 1);,
  INSERT INTO "schema_version" VALUES (207, '20210608180500', 'alter t report center report', 'SQL', 'V3_5_5/V20210608180500__alter_t_report_center_report.sql', -1321978646, 'dbapp', '2026-01-13 10:37:46', 40, 1);,
  INSERT INTO "schema_version" VALUES (208, '20210608180600', 'create table t report job', 'SQL', 'V3_5_5/V20210608180600__create_table_t_report_job.sql', 1059775904, 'dbapp', '2026-01-13 10:37:46', 10, 1);,
  INSERT INTO "schema_version" VALUES (209, '20210608180700', 'create table t report history', 'SQL', 'V3_5_5/V20210608180700__create_table_t_report_history.sql', -554532872, 'dbapp', '2026-01-13 10:37:46', 13, 1);,
  INSERT INTO "schema_version" VALUES (210, '20210610192500', 'alert table t bs message type', 'SQL', 'V3_5_5/V20210610192500__alert_table_t_bs_message_type.sql', 911889088, 'dbapp', '2026-01-13 10:37:46', 15, 1);,
  INSERT INTO "schema_version" VALUES (211, '20210610222800', 'alter table t scan strategy', 'SQL', 'V3_5_5/V20210610222800__alter_table_t_scan_strategy.sql', -721894688, 'dbapp', '2026-01-13 10:37:46', 11, 1);,
  INSERT INTO "schema_version" VALUES (212, '20210616140500', 'altert t alert item', 'SQL', 'V3_5_5/V20210616140500__altert_t_alert_item.sql', -5396057, 'dbapp', '2026-01-13 10:37:46', 12, 1);,
  INSERT INTO "schema_version" VALUES (213, '20210619151200', 'alter t report center report', 'SQL', 'V3_5_5/V20210619151200__alter_t_report_center_report.sql', 192858050, 'dbapp', '2026-01-13 10:37:46', 12, 1);,
  INSERT INTO "schema_version" VALUES (214, '20210702164900', 'update t user', 'SQL', 'V3_5_5/V20210702164900__update_t_user.sql', 348896402, 'dbapp', '2026-01-13 10:37:46', 1, 1);,
  INSERT INTO "schema_version" VALUES (215, '20210703094900', 'update t common config', 'SQL', 'V3_5_5/V20210703094900__update_t_common_config.sql', -619247009, 'dbapp', '2026-01-13 10:37:46', 6, 1);,
  INSERT INTO "schema_version" VALUES (216, '20210708194900', 'update t alert item', 'SQL', 'V3_5_5/V20210708194900__update_t_alert_item.sql', 453306879, 'dbapp', '2026-01-13 10:37:46', 20, 1);,
  INSERT INTO "schema_version" VALUES (217, '20210709233000', 'update t portal screen', 'SQL', 'V3_5_5/V20210709233000__update_t_portal_screen.sql', -2055359896, 'dbapp', '2026-01-13 10:37:46', 1, 1);,
  INSERT INTO "schema_version" VALUES (218, '20210715192100', 'insert into t role type', 'SQL', 'V3_5_5/V20210715192100__insert_into_t_role_type.sql', -1353154803, 'dbapp', '2026-01-13 10:37:46', 5, 1);,
  INSERT INTO "schema_version" VALUES (219, '20210720145600', 'alter table agent info', 'SQL', 'V3_5_5/V20210720145600__alter_table_agent_info.sql', 764017109, 'dbapp', '2026-01-13 10:37:46', 24, 1);,
  INSERT INTO "schema_version" VALUES (220, '20210722192500', 'alter table t bs message type', 'SQL', 'V3_5_5/V20210722192500__alter_table_t_bs_message_type.sql', 154603941, 'dbapp', '2026-01-13 10:37:46', 11, 1);,
  INSERT INTO "schema_version" VALUES (221, '20210727072700', 'update t report center report', 'SQL', 'V3_5_5/V20210727072700__update_t_report_center_report.sql', 331524887, 'dbapp', '2026-01-13 10:37:46', 1, 1);,
  INSERT INTO "schema_version" VALUES (222, '20210729140000', 'alter table t bs message type', 'SQL', 'V3_5_5/V20210729140000__alter_table_t_bs_message_type.sql', 548072816, 'dbapp', '2026-01-13 10:37:46', 10, 1);,
  INSERT INTO "schema_version" VALUES (223, '20210805151100', 'alter table agent view', 'SQL', 'V3_5_5/V20210805151100__alter_table_agent_view.sql', 1841246709, 'dbapp', '2026-01-13 10:37:46', 5, 1);,
  INSERT INTO "schema_version" VALUES (224, '20210923131400', 'create table t asset level history', 'SQL', 'V3_5_5/V20210923131400__create_table_t_asset_level_history.sql', -1303473926, 'dbapp', '2026-01-13 10:37:46', 7, 1);,
  INSERT INTO "schema_version" VALUES (225, '20210927193900', 'create table t agent rule info version', 'SQL', 'V3_5_5/V20210927193900__create_table_t_agent_rule_info_version.sql', 1327877902, 'dbapp', '2026-01-13 10:37:46', 8, 1);,
  INSERT INTO "schema_version" VALUES (226, '20210928110800', 'after table t merge rule desc', 'SQL', 'V3_5_5/V20210928110800__after_table_t_merge_rule_desc.sql', -1139168384, 'dbapp', '2026-01-13 10:37:46', 99, 1);,
  INSERT INTO "schema_version" VALUES (227, '20210928193300', 'create table t intelligence knowledge', 'SQL', 'V3_5_5/V20210928193300__create_table_t_intelligence_knowledge.sql', -1776738749, 'dbapp', '2026-01-13 10:37:46', 14, 1);,
  INSERT INTO "schema_version" VALUES (228, '20210929195900', 'after table t merge rule desc UNIQUE', 'SQL', 'V3_5_5/V20210929195900__after_table_t_merge_rule_desc_UNIQUE.sql', -1108961852, 'dbapp', '2026-01-13 10:37:46', 15, 1);,
  INSERT INTO "schema_version" VALUES (229, '20210930133700', 'insert into t quartz job', 'SQL', 'V3_5_6/V20210930133700__insert_into_t_quartz_job.sql', -1358994376, 'dbapp', '2026-01-13 10:37:46', 2, 1);,
  INSERT INTO "schema_version" VALUES (230, '20211026151500', 'create table t vulnerability info', 'SQL', 'V3_5_5_XDR/V20211026151500__create_table_t_vulnerability_info.sql', -1777439659, 'dbapp', '2026-01-13 10:37:46', 9, 1);,
  INSERT INTO "schema_version" VALUES (231, '20211026170000', 'alter t asset info', 'SQL', 'V3_5_5/V20211026170000__alter_t_asset_info.sql', -220395448, 'dbapp', '2026-01-13 10:37:47', 33, 1);,
  INSERT INTO "schema_version" VALUES (232, '20211026180200', 'update t quartz job', 'SQL', 'V3_5_6/V20211026180200__update_t_quartz_job.sql', 1895143273, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (233, '20211027170000', 'create t asset risk evaluation history', 'SQL', 'V3_5_5_XDR/V20211027170000__create_t_asset_risk_evaluation_history.sql', -1181410859, 'dbapp', '2026-01-13 10:37:47', 7, 1);,
  INSERT INTO "schema_version" VALUES (234, '20211027173000', 'alert t asset info', 'SQL', 'V3_5_5_XDR/V20211027173000__alert_t_asset_info.sql', -384609565, 'dbapp', '2026-01-13 10:37:47', 16, 1);,
  INSERT INTO "schema_version" VALUES (235, '20211027180000', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V20211027180000__insert_into_t_quartz_job.sql', 659161756, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (236, '20211119171500', 'create table t address', 'SQL', 'V3_5_5_XDR/V20211119171500__create_table_t_address.sql', 1368732037, 'dbapp', '2026-01-13 10:37:47', 8, 1);,
  INSERT INTO "schema_version" VALUES (237, '20211119171501', 'create table t address object', 'SQL', 'V3_5_5_XDR/V20211119171501__create_table_t_address_object.sql', -840426583, 'dbapp', '2026-01-13 10:37:47', 7, 1);,
  INSERT INTO "schema_version" VALUES (238, '20211119171502', 'create table t flow security policy', 'SQL', 'V3_5_5_XDR/V20211119171502__create_table_t_flow_security_policy.sql', -1043239609, 'dbapp', '2026-01-13 10:37:47', 10, 1);,
  INSERT INTO "schema_version" VALUES (239, '20211119171503', 'create table t flow ids policy', 'SQL', 'V3_5_5_XDR/V20211119171503__create_table_t_flow_ids_policy.sql', -1898662796, 'dbapp', '2026-01-13 10:37:47', 7, 1);,
  INSERT INTO "schema_version" VALUES (240, '20211208110000', 'update t common config', 'SQL', 'V3_5_5/V20211208110000__update_t_common_config.sql', 1297390287, 'dbapp', '2026-01-13 10:37:47', 7, 1);,
  INSERT INTO "schema_version" VALUES (241, '20211221131100', 'insert into t table header', 'SQL', 'V3_5_5_XDR/V2_0_3/V20211221131100__insert_into_t_table_header.sql', 209898930, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (242, '20220104170000', 'delete table t bs user receive message', 'SQL', 'V3_5_5/V20220104170000__delete_table_t_bs_user_receive_message.sql', -1012378960, 'dbapp', '2026-01-13 10:37:47', 5, 1);,
  INSERT INTO "schema_version" VALUES (243, '20220105145000', 'update t report center report', 'SQL', 'V3_5_5_XDR/V2_0_3/V20220105145000__update_t_report_center_report.sql', 331524887, 'dbapp', '2026-01-13 10:37:47', 2, 1);,
  INSERT INTO "schema_version" VALUES (244, '20220110101700', 'alert t merge rule desc', 'SQL', 'V3_5_5/V20220110101700__alert_t_merge_rule_desc.sql', 1258473598, 'dbapp', '2026-01-13 10:37:47', 26, 1);,
  INSERT INTO "schema_version" VALUES (245, '20220214150500', 'update t query template', 'SQL', 'V3_5_5_XDR/V2_0_3/V20220214150500__update_t_query_template.sql', 1214291107, 'dbapp', '2026-01-13 10:37:47', 2, 1);,
  INSERT INTO "schema_version" VALUES (246, '20220218110600', 'insert t common config', 'SQL', 'V3_5_5/V20220218110600__insert_t_common_config.sql', 38892063, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (247, '20220221105100', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V2_0_3/V20220221105100__insert_into_t_common_config.sql', 1859103701, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (248, '20220228160200', 'delete from t user portal screen ', 'SQL', 'V3_5_5_XDR/V2_0_3/V20220228160200__delete_from_t_user_portal_screen_.sql', -591124939, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (249, '20220301142200', 'alert t center product', 'SQL', 'V3_5_5/V20220301142200__alert_t_center_product.sql', -417127011, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (250, '20220302152200', 'create t online judge', 'SQL', 'V3_5_6/V20220302152200__create_t_online_judge.sql', 227694846, 'dbapp', '2026-01-13 10:37:47', 11, 1);,
  INSERT INTO "schema_version" VALUES (251, '20220317142800', 'update t quartz job', 'SQL', 'V3_5_6/V20220317142800__update_t_quartz_job.sql', 431932983, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (252, '20220329140000', 'insert t common config', 'SQL', 'V3_5_5_XDR/V2_0_4/V20220329140000__insert_t_common_config.sql', -1705226151, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (253, '20220425152400', 'delete from t bs apikey', 'SQL', 'V3_5_5/V20220425152400__delete_from_t_bs_apikey.sql', -1636288216, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (254, '20220426183700', 'insert into t table header', 'SQL', 'V3_5_5_XDR/V2_0_4/V20220426183700__insert_into_t_table_header.sql', 179631635, 'dbapp', '2026-01-13 10:37:47', 2, 1);,
  INSERT INTO "schema_version" VALUES (255, '20220427104600', 'create table t third auth', 'SQL', 'V3_5_5/V20220427104600__create_table_t_third_auth.sql', 985282837, 'dbapp', '2026-01-13 10:37:47', 9, 1);,
  INSERT INTO "schema_version" VALUES (256, '20220506171500', 'alter table t asset port', 'SQL', 'V3_5_5_XDR/V2_0_3/V20220506171500__alter_table_t_asset_port.sql', -929416334, 'dbapp', '2026-01-13 10:37:47', 7, 1);,
  INSERT INTO "schema_version" VALUES (257, '20220509200000', 'create t asset fingerprint', 'SQL', 'V3_5_5_XDR/V2_0_4/V20220509200000__create_t_asset_fingerprint.sql', -835275176, 'dbapp', '2026-01-13 10:37:47', 7, 1);,
  INSERT INTO "schema_version" VALUES (258, '20220510165600', 'alert t merge alarm user preference', 'SQL', 'V3_5_5_XDR/V2_0_4/V20220510165600__alert_t_merge_alarm_user_preference.sql', -854554079, 'dbapp', '2026-01-13 10:37:47', 77, 1);,
  INSERT INTO "schema_version" VALUES (259, '20220511131500', 'insert into t merge alarm user preference', 'SQL', 'V3_5_5_XDR/V2_0_4/V20220511131500__insert_into_t_merge_alarm_user_preference.sql', -430883096, 'dbapp', '2026-01-13 10:37:47', 2, 1);,
  INSERT INTO "schema_version" VALUES (260, '20220608162500', 'insert t common config', 'SQL', 'V3_5_5_XDR/V2_0_4/V20220608162500__insert_t_common_config.sql', 740241875, 'dbapp', '2026-01-13 10:37:47', 11, 1);,
  INSERT INTO "schema_version" VALUES (261, '20220614142800', 'update t quartz job', 'SQL', 'V3_5_5_XDR/V2_0_4/V20220614142800__update_t_quartz_job.sql', -862500218, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (262, '20220713185000', 'insert into t report center report', 'SQL', 'V3_5_5_XDR/V2_0_4_2/V20220713185000__insert_into_t_report_center_report.sql', -939955092, 'dbapp', '2026-01-13 10:37:47', 4, 1);,
  INSERT INTO "schema_version" VALUES (263, '20220715171400', 'insert t common config', 'SQL', 'V3_5_5_XDR/V2_0_4/V20220715171400__insert_t_common_config.sql', -1849410687, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (264, '20220715172500', 'insert t common config', 'SQL', 'V3_5_5_XDR/V2_0_4/V20220715172500__insert_t_common_config.sql', 1045515356, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (265, '20220728110600', 'insert t common config', 'SQL', 'V3_5_5/V20220728110600__insert_t_common_config.sql', -1032539686, 'dbapp', '2026-01-13 10:37:47', 2, 1);,
  INSERT INTO "schema_version" VALUES (266, '20220808154200', 'create t bs analysis job', 'SQL', 'V3_5_5_XDR/V2_0_4_2/V20220808154200__create_t_bs_analysis_job.sql', -1673859633, 'dbapp', '2026-01-13 10:37:47', 12, 1);,
  INSERT INTO "schema_version" VALUES (267, '20220826101300', 'insert t common config', 'SQL', 'V3_5_5_XDR/V2_0_4_2/V20220826101300__insert_t_common_config.sql', -1112499032, 'dbapp', '2026-01-13 10:37:47', 2, 1);,
  INSERT INTO "schema_version" VALUES (268, '20221010131900', 'update t default intelligence source function', 'SQL', 'V3_5_5_XDR/V2_0_4_2/V20221010131900__update_t_default_intelligence_source_function.sql', 524676441, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (269, '20221013142000', 'create t asset attack surface', 'SQL', 'V3_5_5_XDR/V2_0_5/V20221013142000__create_t_asset_attack_surface.sql', 1358670912, 'dbapp', '2026-01-13 10:37:47', 15, 1);,
  INSERT INTO "schema_version" VALUES (270, '20221013143000', 'insert t quartz job', 'SQL', 'V3_5_5_XDR/V2_0_5/V20221013143000__insert_t_quartz_job.sql', 1221394657, 'dbapp', '2026-01-13 10:37:47', 2, 1);,
  INSERT INTO "schema_version" VALUES (271, '20221017143800', 'create t asset evaluation', 'SQL', 'V3_5_5_XDR/V2_0_5/V20221017143800__create_t_asset_evaluation.sql', 745220170, 'dbapp', '2026-01-13 10:37:47', 8, 1);,
  INSERT INTO "schema_version" VALUES (272, '20221017143900', 'remove asset level score', 'SQL', 'V3_5_5_XDR/V2_0_5/V20221017143900__remove_asset_level_score.sql', -921479868, 'dbapp', '2026-01-13 10:37:47', 59, 1);,
  INSERT INTO "schema_version" VALUES (273, '20221111111800', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V2_0_5/V20221111111800__insert_into_t_quartz_job.sql', -469178327, 'dbapp', '2026-01-13 10:37:47', 2, 1);,
  INSERT INTO "schema_version" VALUES (274, '20221128095900', 'create t alarm status record', 'SQL', 'V3_5_5_XDR/V2_0_5/V20221128095900__create_t_alarm_status_record.sql', -2071610613, 'dbapp', '2026-01-13 10:37:47', 9, 1);,
  INSERT INTO "schema_version" VALUES (275, '20221213162800', 'insert into t table header', 'SQL', 'V3_5_5_XDR/V2_0_5/V20221213162800__insert_into_t_table_header.sql', -1881679022, 'dbapp', '2026-01-13 10:37:47', 3, 1);,
  INSERT INTO "schema_version" VALUES (276, '20221214163000', 'insert t merge alarm user preference', 'SQL', 'V3_5_5_XDR/V2_0_5/V20221214163000__insert_t_merge_alarm_user_preference.sql', 750072089, 'dbapp', '2026-01-13 10:37:47', 1, 1);,
  INSERT INTO "schema_version" VALUES (277, '20221215142000', 'create t asset attack surface url', 'SQL', 'V3_5_5_XDR/V2_0_5/V20221215142000__create_t_asset_attack_surface_url.sql', -705864525, 'dbapp', '2026-01-13 10:37:48', 40, 1);,
  INSERT INTO "schema_version" VALUES (278, '20230202143800', 'alert t model menu', 'SQL', 'V3_5_5_XDR/V2_0_5/V20230202143800__alert_t_model_menu.sql', 680760229, 'dbapp', '2026-01-13 10:37:48', 84, 1);,
  INSERT INTO "schema_version" VALUES (279, '20230202153000', 'insert t query template', 'SQL', 'V3_5_5_XDR/V2_0_5/V20230202153000__insert_t_query_template.sql', 43759882, 'dbapp', '2026-01-13 10:37:48', 2, 1);,
  INSERT INTO "schema_version" VALUES (280, '20230206134500', 'alter t bs extension info', 'SQL', 'V3_5_5_XDR/V2_0_5/V20230206134500__alter_t_bs_extension_info.sql', -302846353, 'dbapp', '2026-01-13 10:37:48', 12, 1);,
  INSERT INTO "schema_version" VALUES (281, '20230216200000', 'update procedure', 'SQL', 'V3_5_5_XDR/V2_0_5/V20230216200000__update_procedure.sql', -2101479097, 'dbapp', '2026-01-13 10:37:48', 4, 1);,
  INSERT INTO "schema_version" VALUES (282, '20230216210000', 'alter t report job', 'SQL', 'V3_5_5_XDR/V2_0_5/V20230216210000__alter_t_report_job.sql', 492142025, 'dbapp', '2026-01-13 10:37:48', 108, 1);,
  INSERT INTO "schema_version" VALUES (283, '20230220150800', 'update t table header', 'SQL', 'V3_5_5_XDR/V2_0_5/V20230220150800__update_t_table_header.sql', 240006357, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (284, '20230223160600', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V2_0_4_3/V20230223160600__insert_into_t_common_config.sql', -1952344019, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (285, '20230223160601', 'create table t node info', 'SQL', 'V3_5_5_XDR/V2_0_4_3/V20230223160601__create_table_t_node_info.sql', 949335660, 'dbapp', '2026-01-13 10:37:48', 12, 1);,
  INSERT INTO "schema_version" VALUES (286, '20230413104200', 'create t component update record', 'SQL', 'V3_5_5_XDR/V2_0_6/V20230413104200__create_t_component_update_record.sql', -264627979, 'dbapp', '2026-01-13 10:37:48', 7, 1);,
  INSERT INTO "schema_version" VALUES (287, '20230428161700', 'alter table t asset evaluation', 'SQL', 'V3_5_5_XDR/V2_0_5_1/V20230428161700__alter_table_t_asset_evaluation.sql', 1248225734, 'dbapp', '2026-01-13 10:37:48', 22, 1);,
  INSERT INTO "schema_version" VALUES (288, '20230505135700', 'upsert into t table header', 'SQL', 'V3_5_5_XDR/V2_0_5_1/V20230505135700__upsert_into_t_table_header.sql', -1000447649, 'dbapp', '2026-01-13 10:37:48', 3, 1);,
  INSERT INTO "schema_version" VALUES (289, '20230506170000', 'create table t query scene', 'SQL', 'V3_5_5_XDR/V2_0_5_1/V20230506170000__create_table_t_query_scene.sql', 1543268688, 'dbapp', '2026-01-13 10:37:48', 7, 1);,
  INSERT INTO "schema_version" VALUES (290, '20230506181000', 'update t merge alarm user preference', 'SQL', 'V3_5_5_XDR/V2_0_5_1/V20230506181000__update_t_merge_alarm_user_preference.sql', 1881672768, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (291, '20230509163000', 'update t query template', 'SQL', 'V3_5_5_XDR/V2_0_5_1/V20230509163000__update_t_query_template.sql', -1420872663, 'dbapp', '2026-01-13 10:37:48', 56, 1);,
  INSERT INTO "schema_version" VALUES (292, '20230601093900', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V2_0_5_1/V20230601093900__insert_into_t_common_config.sql', 1699286778, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (293, '20230629102900', 'alert t asset fingerprint', 'SQL', 'V3_5_5_XDR/V2_0_5/V20230629102900__alert_t_asset_fingerprint.sql', -1655169265, 'dbapp', '2026-01-13 10:37:48', 11, 1);,
  INSERT INTO "schema_version" VALUES (294, '20230704192000', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V2_0_6/V20230704192000__insert_into_t_common_config.sql', 113058916, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (295, '20230719171900', 'update t login setting', 'SQL', 'V3_5_5_XDR/V2_0_6/V20230719171900__update_t_login_setting.sql', 2058059608, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (296, '20230724142500', 'alert t asset info', 'SQL', 'V3_5_5_XDR/V2_0_6/V20230724142500__alert_t_asset_info.sql', -1843565303, 'dbapp', '2026-01-13 10:37:48', 20, 1);,
  INSERT INTO "schema_version" VALUES (297, '20230725141700', 'alter table t asset fingerprint', 'SQL', 'V3_5_5_XDR/V2_0_5_1/V20230725141700__alter_table_t_asset_fingerprint.sql', -1645186431, 'dbapp', '2026-01-13 10:37:48', 10, 1);,
  INSERT INTO "schema_version" VALUES (298, '20230725163600', 'alter table license', 'SQL', 'V3_5_5_XDR/V2_0_6/V20230725163600__alter_table_license.sql', 747101985, 'dbapp', '2026-01-13 10:37:48', 38, 1);,
  INSERT INTO "schema_version" VALUES (299, '20230803095600', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V2_0_6/V20230803095600__insert_into_t_common_config.sql', 1148923820, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (300, '20230804163500', 'create table t risk template', 'SQL', 'V3_5_5_XDR/V2_0_6/V20230804163500__create_table_t_risk_template.sql', -893380425, 'dbapp', '2026-01-13 10:37:48', 8, 1);,
  INSERT INTO "schema_version" VALUES (301, '20230814150700', 'update t quartz job', 'SQL', 'V3_5_5_XDR/V2_0_6/V20230814150700__update_t_quartz_job.sql', -1901296574, 'dbapp', '2026-01-13 10:37:48', 3, 1);,
  INSERT INTO "schema_version" VALUES (302, '20230831162700', 'delete t quartz job', 'SQL', 'V3_5_5_XDR/V2_0_6/V20230831162700__delete_t_quartz_job.sql', 160741913, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (303, '20250225161700', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V30R25C01/V20250225161700__insert_into_t_common_config.sql', 2136315386, 'dbapp', '2026-01-13 10:37:48', 4, 1);,
  INSERT INTO "schema_version" VALUES (304, '20250305191700', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V2_0_6/V20250305191700__insert_into_t_quartz_job.sql', -428004652, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (305, '20250306161700', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V30R25C01/V20250306161700__insert_into_t_common_config.sql', 1434503496, 'dbapp', '2026-01-13 10:37:48', 2, 1);,
  INSERT INTO "schema_version" VALUES (306, '20250306161701', 'update t query template', 'SQL', 'V3_5_5_XDR/V30R25C01/V20250306161701__update_t_query_template.sql', -1521413248, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (307, '20250306161702', 'update t query template', 'SQL', 'V3_5_5_XDR/V30R25C01/V20250306161702__update_t_query_template.sql', -1949641322, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (308, '20250306162600', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V30R25C01/V20250306162600__insert_into_t_quartz_job.sql', -542235011, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (309, '20250324155000', 'create t scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250324155000__create_t_scene.sql', -918110642, 'dbapp', '2026-01-13 10:37:48', 22, 1);,
  INSERT INTO "schema_version" VALUES (310, '20250324155100', 'init sql injection scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250324155100__init_sql_injection_scene.sql', 2123111875, 'dbapp', '2026-01-13 10:37:48', 9, 1);,
  INSERT INTO "schema_version" VALUES (311, '20250327141700', 'alert t asset info', 'SQL', 'V3_5_5_XDR/V30R25C01/V20250327141700__alert_t_asset_info.sql', 555524798, 'dbapp', '2026-01-13 10:37:48', 25, 1);,
  INSERT INTO "schema_version" VALUES (312, '20250403140400', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250403140400__insert_into_t_quartz_job.sql', 1842739557, 'dbapp', '2026-01-13 10:37:48', 1, 1);,
  INSERT INTO "schema_version" VALUES (313, '20250403140500', 'insert into t report', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250403140500__insert_into_t_report.sql', 304690064, 'dbapp', '2026-01-13 10:37:48', 39, 1);,
  INSERT INTO "schema_version" VALUES (314, '20250407101500', 'create t mss agent config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250407101500__create_t_mss_agent_config.sql', 562899321, 'dbapp', '2026-01-13 10:37:49', 13, 1);,
  INSERT INTO "schema_version" VALUES (315, '20250407102000', 'insert into t mss agent config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250407102000__insert_into_t_mss_agent_config.sql', 672290913, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (316, '20250407102500', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250407102500__insert_into_t_quartz_job.sql', -1559893460, 'dbapp', '2026-01-13 10:37:49', 2, 1);,
  INSERT INTO "schema_version" VALUES (317, '20250414160300', 'update t scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250414160300__update_t_scene.sql', 727867232, 'dbapp', '2026-01-13 10:37:49', 78, 1);,
  INSERT INTO "schema_version" VALUES (318, '20250415104100', 'alert t asset info', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250415104100__alert_t_asset_info.sql', 1316147082, 'dbapp', '2026-01-13 10:37:49', 36, 1);,
  INSERT INTO "schema_version" VALUES (319, '20250415181200', 'update t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250415181200__update_t_quartz_job.sql', 535209830, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (320, '20250416150200', 'init weak password scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250416150200__init_weak_password_scene.sql', 504194573, 'dbapp', '2026-01-13 10:37:49', 3, 1);,
  INSERT INTO "schema_version" VALUES (321, '20250417133500', 'alter t report center report', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250417133500__alter_t_report_center_report.sql', 1231297352, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (322, '20250419162400', 'init unauthorized access scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250419162400__init_unauthorized_access_scene.sql', -1653086882, 'dbapp', '2026-01-13 10:37:49', 2, 1);,
  INSERT INTO "schema_version" VALUES (323, '20250422133200', 'update t scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250422133200__update_t_scene.sql', -668836369, 'dbapp', '2026-01-13 10:37:49', 2, 1);,
  INSERT INTO "schema_version" VALUES (324, '20250423153200', 'update t risk template', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250423153200__update_t_risk_template.sql', -495528396, 'dbapp', '2026-01-13 10:37:49', 15, 1);,
  INSERT INTO "schema_version" VALUES (325, '20250423163700', 'insert into t report', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250423163700__insert_into_t_report.sql', 1606759037, 'dbapp', '2026-01-13 10:37:49', 2, 1);,
  INSERT INTO "schema_version" VALUES (326, '20250425164800', 'update t scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250425164800__update_t_scene.sql', -742871444, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (327, '20250427134100', 'alert t webscan issuetype', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250427134100__alert_t_webscan_issuetype.sql', 696927627, 'dbapp', '2026-01-13 10:37:49', 109, 1);,
  INSERT INTO "schema_version" VALUES (328, '20250427170000', 'update t mss agent config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250427170000__update_t_mss_agent_config.sql', 471712187, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (329, '20250427172500', 'insert t common config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250427172500__insert_t_common_config.sql', -1263534675, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (330, '20250428165100', 'create t asset virus', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250428165100__create_t_asset_virus.sql', 295142542, 'dbapp', '2026-01-13 10:37:49', 9, 1);,
  INSERT INTO "schema_version" VALUES (331, '20250508165100', 'insert t common config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250508165100__insert_t_common_config.sql', -1167528250, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (332, '20250509110500', 'alter t report center report', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250509110500__alter_t_report_center_report.sql', -59420890, 'dbapp', '2026-01-13 10:37:49', 3, 1);,
  INSERT INTO "schema_version" VALUES (333, '20250510143100', 'insert into t sev agent type', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250510143100__insert_into_t_sev_agent_type.sql', -646101478, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (334, '20250511132400', 'init ransomware access scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250511132400__init_ransomware_access_scene.sql', 180495364, 'dbapp', '2026-01-13 10:37:49', 2, 1);,
  INSERT INTO "schema_version" VALUES (335, '20250512091700', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250512091700__insert_into_t_common_config.sql', -1453317127, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (336, '20250512131900', 'update t bs message type', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250512131900__update_t_bs_message_type.sql', 1784881353, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (337, '20250514141500', 'update t scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250514141500__update_t_scene.sql', -62422669, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (338, '20250515162400', 'init miner access scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250515162400__init_miner_access_scene.sql', -195087975, 'dbapp', '2026-01-13 10:37:49', 2, 1);,
  INSERT INTO "schema_version" VALUES (339, '20250515201500', 'update t scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250515201500__update_t_scene.sql', -2094942490, 'dbapp', '2026-01-13 10:37:49', 41, 1);,
  INSERT INTO "schema_version" VALUES (340, '20250517133800', 'insert into t report', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250517133800__insert_into_t_report.sql', 1962770230, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (341, '20250519142400', 'update t asset info', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250519142400__update_t_asset_info.sql', 1443276138, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (342, '20250521151200', 'alter t asset cal results', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250521151200__alter_t_asset_cal_results.sql', 757570335, 'dbapp', '2026-01-13 10:37:49', 14, 1);,
  INSERT INTO "schema_version" VALUES (343, '20250522132900', 'alter t report center report', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250522132900__alter_t_report_center_report.sql', 598330447, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (344, '20250526161500', 'alter t asset attack surface url', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250526161500__alter_t_asset_attack_surface_url.sql', -706173170, 'dbapp', '2026-01-13 10:37:49', 38, 1);,
  INSERT INTO "schema_version" VALUES (345, '20250526165900', 'update sql injection scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250526165900__update_sql_injection_scene.sql', 1624250569, 'dbapp', '2026-01-13 10:37:49', 2, 1);,
  INSERT INTO "schema_version" VALUES (346, '20250527150400', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250527150400__insert_into_t_quartz_job.sql', 20216800, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (347, '20250527170000', 'update t mss agent config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250527170000__update_t_mss_agent_config.sql', 251185694, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (348, '20250528170100', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250528170100__insert_into_t_common_config.sql', 149833945, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (349, '20250603110200', 'update t common config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250603110200__update_t_common_config.sql', -1331123097, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (350, '20250603110600', 'update t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250603110600__update_t_quartz_job.sql', 535209830, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (351, '20250606140700', 'update t user portal screen title', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250606140700__update_t_user_portal_screen_title.sql', -1088098860, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (352, '20250607150900', 'update t scene component', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250607150900__update_t_scene_component.sql', 1252796099, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (353, '20250609185000', 'update t asset info', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250609185000__update_t_asset_info.sql', -939590228, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (354, '20250611205000', 'update t scene component rel', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250611205000__update_t_scene_component_rel.sql', 922111546, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (355, '20250612194600', 'update t common config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250612194600__update_t_common_config.sql', -374357825, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (356, '20250612204300', 'update t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250612204300__update_t_quartz_job.sql', 1264219664, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (357, '20250613110900', 'update t common config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250613110900__update_t_common_config.sql', -2102115805, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (358, '20250618181800', 'update t common config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250618181800__update_t_common_config.sql', 275764974, 'dbapp', '2026-01-13 10:37:49', 2, 1);,
  INSERT INTO "schema_version" VALUES (359, '20250626162600', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V30R25C01/V20250626162600__insert_into_t_quartz_job.sql', -76405995, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (360, '20250715151200', 'update t common config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250715151200__update_t_common_config.sql', 649821872, 'dbapp', '2026-01-13 10:37:49', 2, 1);,
  INSERT INTO "schema_version" VALUES (361, '20250716092800', 'update t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250716092800__update_t_quartz_job.sql', 474133717, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (362, '20250723153300', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250723153300__insert_into_t_quartz_job.sql', -1892332520, 'dbapp', '2026-01-13 10:37:49', 1, 1);,
  INSERT INTO "schema_version" VALUES (363, '20250804140800', 'update sql injection scene', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250804140800__update_sql_injection_scene.sql', 560865282, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (364, '20250806172900', 'update t user portal screen title', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250806172900__update_t_user_portal_screen_title.sql', 119660944, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (365, '20250807150800', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250807150800__insert_into_t_quartz_job.sql', -246608154, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (366, '20250807203000', 'alert t device', 'SQL', 'V3_5_5_XDR/V20R25C20/V20250807203000__alert_t_device.sql', -297030828, 'dbapp', '2026-01-13 10:37:50', 16, 1);,
  INSERT INTO "schema_version" VALUES (367, '20250813142500', 'update t node info', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250813142500__update_t_node_info.sql', 122351873, 'dbapp', '2026-01-13 10:37:50', 2, 1);,
  INSERT INTO "schema_version" VALUES (368, '20250819142000', 'insert t common config', 'SQL', 'V3_5_5_XDR/V20R25C10/V20250819142000__insert_t_common_config.sql', -1807132363, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (369, '20250821134600', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V30R25C01/V20250821134600__insert_into_t_quartz_job.sql', -1885126856, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (370, '20250912152000', 'create t sev file chunk', 'SQL', 'V3_5_5_XDR/V20R25C20/V20250912152000__create_t_sev_file_chunk.sql', 703329955, 'dbapp', '2026-01-13 10:37:50', 8, 1);,
  INSERT INTO "schema_version" VALUES (371, '20251010101500', 'update t scene', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251010101500__update_t_scene.sql', 1855379704, 'dbapp', '2026-01-13 10:37:50', 244, 1);,
  INSERT INTO "schema_version" VALUES (372, '20251010103500', 'update t scene component', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251010103500__update_t_scene_component.sql', 1016552188, 'dbapp', '2026-01-13 10:37:50', 70, 1);,
  INSERT INTO "schema_version" VALUES (373, '20251011155000', 'alter t intelligence source metadata', 'SQL', 'V3_5_5_XDR/V20R25C21/V20251011155000__alter_t_intelligence_source_metadata.sql', -1775230030, 'dbapp', '2026-01-13 10:37:50', 137, 1);,
  INSERT INTO "schema_version" VALUES (374, '20251015091700', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V20R25C21/V20251015091700__insert_into_t_common_config.sql', 1073632140, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (375, '20251022102000', 'update t common config', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251022102000__update_t_common_config.sql', 872497272, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (376, '20251023191300', 'insert table t quartz job', 'SQL', 'V3_5_5_XDR/V30R25C01/V20251023191300__insert_table_t_quartz_job.sql', -1892319002, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (377, '20251027202100', 'update t scene', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251027202100__update_t_scene.sql', -81848985, 'dbapp', '2026-01-13 10:37:50', 39, 1);,
  INSERT INTO "schema_version" VALUES (378, '20251028145500', 'insert into t report center report', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251028145500__insert_into_t_report_center_report.sql', 1200034400, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (379, '20251104105100', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251104105100__insert_into_t_common_config.sql', 1586556019, 'dbapp', '2026-01-13 10:37:50', 2, 1);,
  INSERT INTO "schema_version" VALUES (380, '20251105144400', 'alter table t report job', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251105144400__alter_table_t_report_job.sql', -1433524251, 'dbapp', '2026-01-13 10:37:50', 14, 1);,
  INSERT INTO "schema_version" VALUES (381, '20251112102100', 'update t risk template', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251112102100__update_t_risk_template.sql', 406363081, 'dbapp', '2026-01-13 10:37:50', 27, 1);,
  INSERT INTO "schema_version" VALUES (382, '20251114135500', 'update table t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251114135500__update_table_t_quartz_job.sql', -990341252, 'dbapp', '2026-01-13 10:37:50', 2, 1);,
  INSERT INTO "schema_version" VALUES (383, '20251114152100', 'alter table t report job', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251114152100__alter_table_t_report_job.sql', 1996935479, 'dbapp', '2026-01-13 10:37:50', 30, 1);,
  INSERT INTO "schema_version" VALUES (384, '20251127141800', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251127141800__insert_into_t_quartz_job.sql', 104021631, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (385, '20251128100700', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V20R25C31/V20251128100700__insert_into_t_common_config.sql', -240258967, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (386, '20251201161300', 'update t soar layout', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251201161300__update_t_soar_layout.sql', 387898676, 'dbapp', '2026-01-13 10:37:50', 2, 1);,
  INSERT INTO "schema_version" VALUES (387, '20251205111300', 'update t bs extension info', 'SQL', 'V3_5_5_XDR/V20R25C30/V20251205111300__update_t_bs_extension_info.sql', 988873499, 'dbapp', '2026-01-13 10:37:50', 12, 1);,
  INSERT INTO "schema_version" VALUES (388, '20251210094800', 'insert into t bs apikey', 'SQL', 'V3_5_5_XDR/V20R25C31/V20251210094800__insert_into_t_bs_apikey.sql', -1287279574, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (389, '20251210135600', 'insert into t common config', 'SQL', 'V3_5_5_XDR/V20R25C31/V20251210135600__insert_into_t_common_config.sql', 1437069906, 'dbapp', '2026-01-13 10:37:50', 1, 1);,
  INSERT INTO "schema_version" VALUES (390, '20251223091500', 'update t query template', 'SQL', 'V3_5_5_XDR/V20R25C31/V20251223091500__update_t_query_template.sql', -257322343, 'dbapp', '2026-01-13 10:37:50', 4, 1);,
  INSERT INTO "schema_version" VALUES (391, '20260105185800', 'insert into t quartz job', 'SQL', 'V3_5_5_XDR/V20R25C31/V20260105185800__insert_into_t_quartz_job.sql', -1942210869, 'dbapp', '2026-01-13 10:37:51', 2, 1);,
  INSERT INTO "schema_version" VALUES (392, '20260108185800', 'update hengnao filter', 'SQL', 'V3_5_5_XDR/V20R25C31/V20260108185800__update_hengnao_filter.sql', 1409934967, 'dbapp', '2026-01-13 10:37:51', 1, 1);,
  "SET" FOREIGN_KEY_CHECKS = 1;

-- Indexes
CREATE INDEX "schema_version_s_idx" ON "schema_version" ("success");

-- Enable foreign key checks
SET session_replication_role = 'origin';

-- Update sequences
-- Run after data import:
-- SELECT setval(pg_get_serial_sequence('table_name', 'id_column'), (SELECT MAX(id_column) FROM table_name));
