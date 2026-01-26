# [数据库切换PG方案](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e6%95%b0%e6%8d%ae%e5%ba%93%e5%88%87%e6%8d%a2pg%e6%96%b9%e6%a1%88)

## [一、版本选择](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%80%e3%80%81%e7%89%88%e6%9c%ac%e9%80%89%e6%8b%a9)

### [各版本对比：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%90%84%e7%89%88%e6%9c%ac%e5%af%b9%e6%af%94%ef%bc%9a)

| 版本    | 最新版本   | 最新发布日期     | 停更时间       | 重要变化                                                                                                                                                                                                                 | 官网介绍                                                    |
| ----- | ------ | ---------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| 9.6.X | 9.6.24 | 2021-11-11 | 2021-11-11 | 1.**支持并行查询**<br>2.**允许同步复制**<br>3.**热备份**<br>4.继承式分区                                                                                                                                                                 | [9.6.0](https://www.postgresql.org/docs/release/9.6.0/) |
| 10.X  | 10.23  | 2022-11-10 | 2022-11-10 | 1.内置分区表<br>2.逻辑复制<br>3.**并行功能增强**                                                                                                                                                                                    | [10.0](https://www.postgresql.org/docs/release/10.0/)   |
| 11.X  | 11.22  | 2023-11-09 | 2023-11-09 | 1.新增哈希分区<br>2.基于的分区表创建索引<br>3.支持update分区<br>4.会创建一个默认default分区<br>5.分区支持创建主键，外键，索引，触发器                                                                                                                               | [11.0](https://www.postgresql.org/docs/release/11.0/)   |
| 12.X  | 12.19  | 2024-05-09 | --         | 1.**支持[SQL/JSON路径](https://www.postgresql.org/docs/12/functions-json.html#FUNCTIONS-SQLJSON-PATH)语言**<br>2.一般性能改进<br>3.[使用GSSAPI](https://www.postgresql.org/docs/12/gssapi-auth.html)身份验证时的 TCP/IP 连接加密             | [12.0](https://www.postgresql.org/docs/release/12.0/)   |
| 13.X  | 13.15  | 2024-05-09 | --         | 1.新增gen_random_uuid()函数<br>2.提高了使用聚合或分区表的查询的性能<br>3.从 B 树索引条目的重复数据删除中节省空间并提高性能                                                                                                                                       | [13.0](https://www.postgresql.org/docs/release/13.0/)   |
| 14.X  | 14.12  | 2024-05-09 | --         | 1.对并行查询、高度并发的工作负载、分区表、逻辑复制和清理进行了许多性能改进<br>2.B-tree 索引更新的管理效率更高，从而减少了索引膨胀<br>3.`VACUUM`如果数据库开始接近事务 ID 环绕条件，它会自动变得更加积极，并跳过不必要的清理                                                                                       | [14.0](https://www.postgresql.org/docs/release/14.0/)   |
| 15.X  | 15.7   | 2024-05-09 | --         | 1.添加SQL / JSON查询函数[`json_exists()`](https://www.postgresql.org/docs/15/functions-json.html#FUNCTIONS-SQLJSON-QUERYING), `json_query()`, 和`json_value()`<br>2.**merge sql command**<br>3.在使用distinct 命令的情况下，可以支持并行的查询 | [15.0](https://www.postgresql.org/docs/release/15.0/)   |
| 16.X  | 16.3   | 2024-05-09 | --         | 1.允许并行化FULL和内部右OUTER哈希连接<br>2.允许从备用服务器进行逻辑复制<br>3.允许逻辑复制订阅者并行应用大型事务<br>4.允许使用新视图监控I/O统计信息pg_stat_io<br>5.添加SQL/JSON构造函数和标识函数<br>6.提高真空冷冻性能<br>7.pg_hba.conf添加对中用户和数据库名称以及中用户名的正则表达式匹配的支持pg_ident.conf                | [16.0](https://www.postgresql.org/docs/release/16.0/)   |

### [总结：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e6%80%bb%e7%bb%93%ef%bc%9a)

当前最高版本为v16.3;

当前最高release版本为v16.3，修复了16.2使用的一些问题；

由于12.X版本才支持SQL/JSON path，所以我们最低版本应该选择12.X。

目前大部分公司使用的版本：9.4、10、12、13，推荐使用版本：13.7、12.11、14.4。

版本特性总结连接：https://www.postgresql.org/docs/

## [二、常用数据类型映射](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%ba%8c%e3%80%81%e5%b8%b8%e7%94%a8%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b%e6%98%a0%e5%b0%84)

### [1.数值类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e6%95%b0%e5%80%bc%e7%b1%bb%e5%9e%8b)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql)

| mysql类型    | 范围                                                             | pg类型                                | 范围                                      | 说明                                           |
| ---------- | -------------------------------------------------------------- | ----------------------------------- | --------------------------------------- | -------------------------------------------- |
| BIT[(M)]   | M范围是：[1,64]，默认1                                                | BIT[(n)]                            | ----                                    |                                              |
| TINYINT    | 有符号范围 `-128` - `127`。<br>无符号范围是`0` - `255`                     | smallint<br>int2                    | `-32768` - `32767`                      |                                              |
| TINYINT(1) | true,1<br>false,0                                              | bool                                | true,yes,on,1<br>false,no,off,0         | 布尔值                                          |
| SMALLINT   | 有符号范围 `-32768` - `32767`<br>无符号范围是`0` - `65535`                | smallint<br>int2                    | `-32768` - `32767`                      | **pg不能使用无符号，如果超出范围请使用`integer`类型**           |
| MEDIUMINT  | 有符号范围 `-8388608` - `8388607`<br>无符号范围是`0` - `16777215`         | integer<br>int4                     | `-2147483648` - `2147483647`            | 一个中等大小的整数                                    |
| INT        | 有符号范围 `-2147483648` - `2147483647`<br>无符号范围是`0` - `4294967295` | integer<br>int4                     | `-2147483648` - `2147483647`            | **pg不能使用无符号，如果超出范围请使用`bigint`类型**            |
| BIGINT     | 有符号范围 `-2^63` - `2^63 - 1`<br>无符号范围是`0` - `2^ 64 - 1`          | bigint<br>int8                      | `-2^63` - `2^63 - 1`                    | **pg不能使用无符号，如果超出范围请使用`numeric`或`decimal`类型** |
| DECIMAL    | 最大`DECIMAL(65)`                                                | decimal                             | 小数点前最多 131072 位；小数点后最多 16383 位          | 指定的精度，精确                                     |
| NUMERIC    | 最大`NUMERIC(65)`                                                | numeric                             | 小数点前最多 131072 位；小数点后最多 16383 位          | 指定的精度，精确                                     |
| FLOAT      | 支持无符号，4字节                                                      | real<br>float4                      | 4字节<br>-3.402E+38~3.402E+38，6位十进制数字精度。  | 不精确                                          |
| DOUBLE     | 支持无符号，8字节                                                      | float<br>float8<br>double precision | 8字节<br>-1.79E+308~1.79E+308，15位十进制数字精度。 | 不精确                                          |
| **----**   | **----**                                                       | **smallserial**                     | **1 - 32767<br>自增整数**                   |                                              |
| **----**   | **----**                                                       | **serial**                          | **1 - 2147483647<br>自增整数**              |                                              |
| **----**   | **----**                                                       | **bigserial**                       | **1 - 9223372036854775807<br>自增整数**     |                                              |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss)

| pg类型                                  | 范围   | openGauss类型                                   | 范围                                                                                                           | 说明       |
| ------------------------------------- | ---- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | -------- |
| ----                                  | ---- | TINYINT,<br>int1                              | 0 ~ 255                                                                                                      |          |
| ----                                  | ---- | LARGESERIAL                                   | -170,141,183,460,469,231,731,687,303,715,884,105,728<br>~170,141,183,460,469,231,731,687,303,715,884,105,727 | 十六字节序列整型 |
| float,<br>float8,<br>double precision | ---- | DOUBLE PRECISION,<br>FLOAT8,<br>BINARY_DOUBLE | ----                                                                                                         |          |

### [2.日期和时间类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e6%97%a5%e6%9c%9f%e5%92%8c%e6%97%b6%e9%97%b4%e7%b1%bb%e5%9e%8b)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-1)

| mysql类型   | 范围                                                        | pg类型         | 范围                                     | 说明                          |
| --------- | --------------------------------------------------------- | ------------ | -------------------------------------- | --------------------------- |
| DATE      | 1000-01-01 - 9999-12-31                                   | date         | 4713 BC - 5874897 AD                   | 年月日，精度：一天                   |
| **----**  |                                                           | **time**     | **00:00:00 - 24:00:00**                | **精度：微秒<br>可带时区**           |
| DATETIME  | 1000-01-01 00:00:00 - 9999-12-31 23:59:59                 | timestamp    | 4713 BC - 294276 AD                    | 可以包括一个尾随小数秒部分，可带时区<br>精度：微秒 |
| **----**  | **----**                                                  | **interval** | **-178000000 years - 178000000 years** | **时间间隔**                    |
| TIMESTAMP | `'1970-01-01 00:00:01'` UTC - `'2038-01-19 03:14:07'` UTC | timestamp    | 4713 BC - 294276 AD                    | 可以包括一个尾随小数秒部分，可带时区<br>精度：微秒 |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-1)

| pg类型     | 描述       | openGauss类型       | 描述                                                                                                                |
| -------- | -------- | ----------------- | ----------------------------------------------------------------------------------------------------------------- |
| **date** | **日期**   | **DATE**          | **时间和日期**                                                                                                         |
| **----** | **----** | **SMALLDATETIME** | **日期和时间，不带时区。<br>精确到分钟，秒位大于等于30秒进一位。**                                                                            |
| **----** | **----** | **reltime**       | **相对时间间隔。格式为：<br>X years X mons X days XX:XX:XX。<br>采用儒略历计时，规定一年为365.25天，一个月为30天，计算输入值对应的相对时间间隔，输出采用POSTGRES格式。** |
| **----** | **----** | **abstime**       | **日期和时间。格式为：<br>YYYY-MM-DD hh:mm:ss+timezone<br>取值范围为1901-12-13 20:45:53 GMT~2038-01-18 23:59:59 GMT，精度为秒。**      |

#### [备注：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%a4%87%e6%b3%a8%ef%bc%9a)

​ 推荐使用timestamp

### [3.字符串数据类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%ad%97%e7%ac%a6%e4%b8%b2%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b)

pg和openGauss字符串类型可以指定COLLATE(排序规则)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-2)

| mysql类型    | 范围/说明                                                                 | pg类型                                | 范围/说明                                                                | 说明            |
| ---------- | --------------------------------------------------------------------- | ----------------------------------- | -------------------------------------------------------------------- | ------------- |
| CHAR(n)    | 0-255<br>会用空格右填充到指定的长度                                                | char(n),<br>character(n)            | 最大约1GB，固定长度，空白填充<br>char不指定长度默认1<br>varchar不指定长度，最大约1GB              |               |
| VARCHAR(n) | 0-65535<br>值在存储时不会被填充                                                 | character varying(n),<br>varchar(n) | 最大约1GB，可变长度                                                          |               |
| BINARY     | 0-255<br>使用值0x00右填充到指定的长度                                             | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| VARBINARY  | 0-65535                                                               | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| BLOB       | 二进制字符串                                                                | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| TEXT       | 非二进制字符串                                                               | text                                | 无限制                                                                  |               |
| ENUM       | 最多65535个元素                                                            | ENUM                                | 63字节                                                                 |               |
| SET        | 最多64个不同的成员，自动去重<br>如果将`SET`列设置为不受支持的值，则该值将被忽略并发出警告                    | ----                                | ----                                                                 | pg无对应类型       |
| JSON       | [json函数](https://dev.mysql.com/doc/refman/5.7/en/json-functions.html) | json,<br>jsonb                      | [json函数和运算符](https://www.postgresql.org/docs/13/functions-json.html) | 均支持路径语法，函数不相同 |
| ----       | ----                                                                  | "char"                              | 1字节                                                                  |               |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-2)

| pg类型                                    | 范围/说明                                                                  | openGauss类型                                             | 范围/说明                                                                                                                                   |
| --------------------------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **char(n),<br>character(n)**            | **最大约1GB，固定长度，空白填充<br>char不指定长度默认1<br>varchar不指定长度，最大约1GB<br>n是指字符长度** | **CHAR(n),<br>CHARACTER(n),<br>NCHAR(n)**               | **定长字符串，不足补空格。n是指字节长度，如不带精度n，默认精度为1。<br>最大为10MB。**                                                                                      |
| **character varying(n),<br>varchar(n)** | **最大约1GB，可变长度<br>n是指字符长度**                                             | **character varying(n),<br>varchar(n),<br>varchar2(n)** | **变长字符串。n是指字节长度。<br>最大为10MB。**                                                                                                          |
| **----**                                | **----**                                                               | **NVARCHAR2(n)**                                        | **变长字符串。n是指字符长度。<br>最大为10MB。**                                                                                                          |
| **----**                                | **----**                                                               | **BLOB**                                                | **二进制字符串<br>说明：列存不支持BLOB类型<br>最大为1GB-8203字节（即1073733621字节）。**                                                                           |
| **----**                                | **----**                                                               | **RAW**                                                 | **变长的十六进制类型<br>说明：<br>列存不支持RAW类型**                                                                                                      |
| **----**                                | **----**                                                               | **BYTEAWITHOUTORDERWITHEQUALCOL**                       | **变长的二进制字符串（密态特性新增的类型，如果加密列的加密类型指定为确定性加密，则该列的实际类型为BYTEAWITHOUTORDERWITHEQUALCOL），元命令打印加密表将显示原始数据类型**                                    |
| **----**                                | **----**                                                               | **BYTEAWITHOUTORDERCOL**                                | **变长的二进制字符串（密态特性新增的类型，如果加密列的加密类型指定为随机加密，则该列的实际类型为BYTEAWITHOUTORDERCOL），元命令打印加密表将显示原始数据类型**                                              |
| **----**                                | **----**                                                               | **_BYTEAWITHOUTORDERWITHEQUALCOL**                      | **变长的二进制字符串，密态特性新增的类型**                                                                                                                 |
| **----**                                | **----**                                                               | **_BYTEAWITHOUTORDERCOL**                               | **变长的二进制字符串，密态特性新增的类型**                                                                                                                 |
| json,<br>jsonb                          | [json函数和运算符](https://www.postgresql.org/docs/13/functions-json.html)   | JSON,<br>JSONB                                          | [json函数](https://opengauss.org/zh/docs/3.0.0/docs/Developerguide/JSON-JSONB%E5%87%BD%E6%95%B0%E5%92%8C%E6%93%8D%E4%BD%9C%E7%AC%A6.html) |

#### [备注：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%a4%87%e6%b3%a8%ef%bc%9a-1)

- json和jsonb
  
  json存储效率比jsonb高，但是如果进行json操作时，json类型需要解析。
  
  json存储和查询（作为字符串方式查询出来）效率比较高；
  
  jsonb适合在json字段上做一些操作，比如查询和更新等。

## [三、主键策略与日期更新处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%89%e3%80%81%e4%b8%bb%e9%94%ae%e7%ad%96%e7%95%a5%e4%b8%8e%e6%97%a5%e6%9c%9f%e6%9b%b4%e6%96%b0%e5%a4%84%e7%90%86)

### [1.自增主键](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae)

自增主键改用`smallserial`、`serial`、`bigserial`类型，由于有旧数据，需要在数据迁移完成后更新自增序列：

```
select setval('sequence_name', (select max("col_name") from employee_age));
```

serial自动创建的自增序列命名规则为 `表名_字段名_seq`，重复时会增加数字序号，如：`employee_age_employee_id_seq1`。

#### [使用自增主键同时按照自增主键排序的表：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bd%bf%e7%94%a8%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae%e5%90%8c%e6%97%b6%e6%8c%89%e7%85%a7%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae%e6%8e%92%e5%ba%8f%e7%9a%84%e8%a1%a8%ef%bc%9a)

| 表名                        | 数据量    |
| ------------------------- | ------ |
| t_quartz_job              | 60     |
| t_work_order_status_trace | 431884 |
| t_web_info                | 34941  |
| t_user_site               | 1      |
| t_autosend_history        | 202    |
| t_web_asset               | 35388  |
| t_role_type               | 8      |
| t_role                    | 25     |

### [2.UUID](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2uuid)

- 使用函数生成uuid：`gen_random_uuid()`，结果：`8667eca6-72c1-48fd-840c-34393ffa11b5`
- 创建表时字段使用uuid类型

### [3.日期更新](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e6%97%a5%e6%9c%9f%e6%9b%b4%e6%96%b0)

- 新增数据时默认值
  
  - **业务模块手动设置值（推荐）**
  
  - 根据字段类型在字段定义后添加如下语句

```
DEFAULT CURRENT_DATE;
DEFAULT CURRENT_TIME;
DEFAULT CURRENT_TIMESTAMP;
DEFAULT LOCALTIME;
DEFAULT LOCALTIME;
DEFAULT LOCALTIMESTAMP
```

例如：`"find_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP`

- 更新数据时更新值
  
  - **业务模块手动设置更新值（推荐）**
  
  - 使用触发器更新

```
1.创建函数：
CREATE 
    OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
        NEW.column_name = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$ LANGUAGE plpgsql;

2.创建触发器
CREATE TRIGGER "trigger_name" BEFORE UPDATE ON "table_name" FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
```

## [四、函数、存储过程与运算符](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%9b%9b%e3%80%81%e5%87%bd%e6%95%b0%e3%80%81%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b%e4%b8%8e%e8%bf%90%e7%ae%97%e7%ac%a6)

### [1.常用运算符对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%b8%b8%e7%94%a8%e8%bf%90%e7%ae%97%e7%ac%a6%e5%af%b9%e7%85%a7%e8%a1%a8)

| mysql运算符             | 描述          | 示例                                                        | pg运算符                         | 描述                    | 示例                                                                                                           |
| -------------------- | ----------- | --------------------------------------------------------- | ----------------------------- | --------------------- | ------------------------------------------------------------------------------------------------------------ |
| and,<br>**&&**       | 逻辑与         | 1 and 0 → 0                                               | and                           | 逻辑与                   | 1 and 0 → 0                                                                                                  |
| or,<br>**\|**        | 逻辑或         | 1 or 0 → 1                                                | or                            | 逻辑或                   | 1 or 0 → 1                                                                                                   |
| not,<br>**!**        | 逻辑非         | not 1 → 0                                                 | not                           | 逻辑非                   | not 1 → 0                                                                                                    |
| <                    | 小于          | 1 < 0 → 0                                                 | <                             | 小于                    | 1 < 0 → 0                                                                                                    |
| >                    | 大于          | 1 > 0 → 1                                                 | >                             | 大于                    | 1 > 0 → 1                                                                                                    |
| <=                   | 小于等于        | 1 <= 0 → 0                                                | <=                            | 小于等于                  | 1 <= 0 → 0                                                                                                   |
| >=                   | 小于等于        | 1 >= 0 → 1                                                | >=                            | 小于等于                  | 1 >= 0 → 1                                                                                                   |
| =                    | 等于          | 1 = 0 → 0;<br>1 = NULL → NULL.                            | =                             | 等于                    | 1 = 0 → 0;<br>1 = NULL → NULL.                                                                               |
| !=                   | 不等于         | 1 != 0 → 1                                                | !=                            | 不等于                   | 1 != 0 → 1                                                                                                   |
| <>                   | 不等于         | 1 <> 0 → 1                                                | <>                            | 不等于                   | 1 <> 0 → 1                                                                                                   |
| **<=>**              | **安全等于**    | **1 <=> 1 → 1;<br>1 <=> NULL → 0;<br>NULL <=> NULL → 1.** | **IS NOT DISTINCT FROM**      | **安全等于**              | **1 IS NOT DISTINCT FROM 1 → 1;<br>1 IS NOT DISTINCT FROM NULL → 0;<br>NULL IS NOT DISTINCT FROM NULL → 1.** |
| **not (... <=>...)** | **安全不等于**   | **----**                                                  | **IS DISTINCT FROM**          | **安全不等于**             | **----**                                                                                                     |
| BETWEEN AND          | 之间，包含端点     | 2 BETWEEN 1 AND 3 → 1;<br>2 BETWEEN 3 AND 1 → 0.          | BETWEEN AND                   | 之间，包含端点               | 2 BETWEEN 1 AND 3 → 1;<br>2 BETWEEN 3 AND 1 → 0.                                                             |
| NOT BETWEEN AND      | 不在区间内       | ----                                                      | NOT BETWEEN AND               | 不在区间内                 | ----                                                                                                         |
| **----**             | **----**    | **----**                                                  | **BETWEEN SYMMETRIC AND**     | **之间，端点排序**           | **2 BETWEEN SYMMETRIC 1 AND 3 → 1;<br>2 BETWEEN SYMMETRIC 3 AND 1 → 1.**                                     |
| **----**             | **----**    | **----**                                                  | **NOT BETWEEN SYMMETRIC AND** | **不在区间内，端点排序**        | **----**                                                                                                     |
| **IS NULL**          | **为空**      | **1.5 IS NULL → 0**                                       | **IS NULL,<br>ISNULL**        | **为空**                | **1.5 IS NULL → 0**                                                                                          |
| **IS NOT NULL**      | **不为空**     | **'null' IS NOT NULL → 1**                                | **IS NOT NULL,<br>NOTNULL**   | **不为空**               | **'null' IS NOT NULL → 1**                                                                                   |
| IS TRUE              | 测试布尔表达式是否为真 | 1 IS TRUE → 1;<br>NULL IS TRUE → 0.                       | IS TRUE                       | 测试布尔表达式是否为真           | 1::bool IS TRUE → 1;<br>NULL IS TRUE → 0.                                                                    |
| IS NOT TRUE          | 测试布尔表达式是否为假 | ----                                                      | IS NOT TRUE                   | 测试布尔表达式是否为假           | ----                                                                                                         |
| IS FALSE             | 测试布尔表达式是否为假 | ----                                                      | IS FALSE                      | 测试布尔表达式是否为假           | ----                                                                                                         |
| IS NOT FALSE         | 测试布尔表达式是否为真 | ----                                                      | IS NOT FALSE                  | 测试布尔表达式是否为真           | ----                                                                                                         |
| **----**             | **----**    | **----**                                                  | **IS UNKNOWN**                | **测试布尔表达式是否产生未知值**    | **true IS UNKNOWN → 0;<br>NULL::boolean IS UNKNOWN → t.**                                                    |
| **----**             | **----**    | **----**                                                  | **IS NOT UNKNOWN**            | **测试布尔表达式结果是否是产生布尔值** | **----**                                                                                                     |
| **^**                | **按位异或**    | **1 ^ 2 → 3**                                             | **#**                         | **按位异或**              | **1 # 2 → 3**                                                                                                |
| **----**             | **----**    | **----**                                                  | **^**                         | **求幂**                | **2 ^ 3 → 8**                                                                                                |

### [2.常用函数对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e5%af%b9%e7%85%a7%e8%a1%a8)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-3)

| mysql函数                                                                                                                  | 描述                              | 示例                                                                                                                                                                                          | pg函数                                               | 描述                                                                                                               | 示例                                                                                                                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------ | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CONV()                                                                                                                   | 进制转换                            | CONV('a',16,2) → '1010'                                                                                                                                                                     | ----                                               | 有10转16: to_hex(n)<br>其余自己实现                                                                                      | ----                                                                                                                                                                                        |
| INET_ATON()                                                                                                              | IPv4地址转为数字                      | INET_ATON('192.168.3.1') → 3232236289                                                                                                                                                       | ----                                               | 无对应函数，自己实现<br>pg有[ip](https://www.postgresql.org/docs/13/datatype-net-types.html)类型                              | ----                                                                                                                                                                                        |
| INET_NTOA()                                                                                                              | 数字转IPv4                         | INET_NTOA(3232236289) → 192.168.3.1                                                                                                                                                         | ----                                               | 无对应函数，自己实现<br>pg有ip类型：inet,cidr                                                                                  | ----                                                                                                                                                                                        |
| INET6_ATON()                                                                                                             | IPv6地址转为二进制字符串                  | HEX(inet6_aton('FE80::2DBA:7113:B2BE:2E10')) → FE800000000000002DBA7113B2BE2E10                                                                                                             | ----                                               | ----                                                                                                             | ----                                                                                                                                                                                        |
| HEX()                                                                                                                    | 十进制或字符串值的16进制表示                 | HEX(3232236289) → C0A80301                                                                                                                                                                  | to_hex                                             | 十进制或字符串值的16进制表示                                                                                                  | (3232236289) → c0a80301                                                                                                                                                                     |
| **[CONVERT(expr USING transcoding_name)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=covert_code)** | **编码转换**                        | **CONVERT('test' USING utf8) → test;<br>CONVERT(_latin1 'Müller' USING utf8) → MÃ¼ller;<br>CONVERT('test', CHAR CHARACTER SET utf8) → test.**                                               | **convert(),<br>convert_to(),<br>convert_from().** | **需组合使用，[官方文档](https://www.postgresql.org/docs/13/functions-binarystring.html)**                                 | **----**                                                                                                                                                                                    |
| CONVERT(expr,type)                                                                                                       | 类型转换                            | CONVERT('123', UNSIGNED) → 123                                                                                                                                                              | cast(),<br>expr::type_name                         | 类型转换                                                                                                             | cast('123' AS int4) → 123;<br>'123'::int4 → 123.                                                                                                                                            |
| **[CAST(expr AS type)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=cast)**                          | **类型转换**                        | **CONVERT('123' AS UNSIGNED) → 123**                                                                                                                                                        | **cast(),<br>expr::type_name**                     | **类型转换**                                                                                                         | **cast('123' AS int4) → 123;<br>'123'::int4 → 123.**                                                                                                                                        |
| **[FIND_IN_SET(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_set)**             | **集合查找**                        | **FIND_IN_SET('b','a,b,c,d') → 2**                                                                                                                                                          | **str=any(string_to_array(strlist, ','))**         | **判断strlist中是否含有str**                                                                                            | **'a' = ANY(STRING_TO_ARRAY('a,b,c', ',')) → true**                                                                                                                                         |
| concat(str1,str2,...)                                                                                                    | 字符串拼接                           | CONCAT('a','b','c') → abc                                                                                                                                                                   | \|,<br>concat(str1,str2,...)                       | 字符串拼接                                                                                                            | 'a' \| 'b' \| 'c' → abc;<br>CONCAT('a','b','c') → abc.                                                                                                                                      |
| **[group_concat()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=group_concat)**                      | **分组字符串拼接**                     | **----**                                                                                                                                                                                    | **array_to_string(array_agg(column_name),',')**    | **分组字符串拼接**                                                                                                      | **----**                                                                                                                                                                                    |
| **[DATE_FORMAT(date,format)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=date_format)**             | **日期格式化**                       | **----**                                                                                                                                                                                    | **to_char(date, [pattern](#date pattern))**        | **日期时间格式化**                                                                                                      | **to_char(now(), 'YYYY-MM-DD HH24:MI:SS') → 2022-07-21 17:12:43**                                                                                                                           |
| **[IFNULL(value1,value2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnull)**                     | **空值判断**                        | **IFNULL(NULL, '值为空') → 值为空**                                                                                                                                                               | **----**                                           | **自定义函数实现，见[ifnull(val1,val2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnull_impl)**   | **IFNULL(NULL, '值为空') → 值为空**                                                                                                                                                               |
| CURRENT_TIMESTAMP([precision])                                                                                           | 当前日期,**precision可省略**，范围[0,6]   | ----                                                                                                                                                                                        | CURRENT_TIMESTAMP(precision)                       | 当前日期,**precision不可省略**，范围[0,6]                                                                                   | ----                                                                                                                                                                                        |
| **[CURDATE()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=curdate)**                                | **获取当前日期，不包含时分秒**               | **select CURDATE() → 2022-07-26**                                                                                                                                                           | **CURRENT_DATE**                                   | **获取当前日期，不包含时分秒**                                                                                                | **SELECT CURRENT_DATE → 2022-07-26**                                                                                                                                                        |
| **[SUBSTRING_INDEX(str,delim,count)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)** | **从出现分隔符 *`str`*之前 的字符串返回子字符串** | **SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', 2) → [www.mysql](http://www.mysql/);<br>SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', -2) → mysql.com** | **-----**                                          | **自定义函数实现，见[substring_index](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)** | **substring_index('[www.mysql.com'](http://www.mysql.com'/), '.', 2) → [www.mysql](http://www.mysql/);<br>SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', -2) → mysql.com** |
| **[IF(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if)**                         | **条件判断函数**                      | **SELECT IF(1>2,2,3) → 3**                                                                                                                                                                  | **----**                                           | **自定义函数实现，见[if(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if_impl)**   | **SELECT IF(1>2,2,3) → 3**                                                                                                                                                                  |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-3)

| postgresql函数                                                                                                                                                                          | 描述       | openGauss函数                       | 描述                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | --------------------------------- | ------------------------------------------------------------------------------- |
| **convert( bytes bytea, src_encoding name, dest_encoding name) → bytea;<br>convert_from(bytes bytea, src_encoding name) → text<br>convert_to(string text,dest_encoding name) →bytea** | **编码转换** | **convert_to_nocase(text, text)** | **将字符串转换为指定的编码类型。<br>返回值类型：bytea<br>SELECT convert_to_nocase('12345', 'GBK');** |
| **----**                                                                                                                                                                              | **----** | **nvl(value1,value2)**            | **如果value1为NULL则返回value2，如果value1非NULL，则返回value1。<br>和mysql的ifnull函数功能相同。**     |

### [3.常用函数修改示例（兼容postgresql和openGauss）](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e4%bf%ae%e6%94%b9%e7%a4%ba%e4%be%8b%ef%bc%88%e5%85%bc%e5%ae%b9postgresql%e5%92%8copengauss%ef%bc%89)

#### [CONVERT(expr USING transcoding_name)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=convertexpr-using-transcoding_name)

- 业务场景：查询字典数据厂商信息，按gbk编码排序

- mysql语句：
  
  ```
  SELECT DISTINCT
      vendor 
  FROM
      t_vendor_model 
  ORDER BY
      CONVERT ( vendor USING gbk ) DESC;
  ```

- 修改建议：
  
  1. postgresql和openGauss函数不相同，无法兼容，mirror中共三处均用在排序处；
     
     取消gbk排序或者业务排序。
  
  2. 分别在postgresql和openGauss上实现convert函数。

#### [CAST(expr AS type)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=castexpr-as-type)

- 业务场景：重大保障大屏-应用保障查询，获取最后一个点访问次数

- mysql语句：
  
  ```
  SELECT
      id,
      destHostName,
      webName,
      cast( SUBSTRING_INDEX( visitCount, ',',- 1 ) AS SIGNED ) visit,
      accessRateValue,
      accessMonitor,
      accessRate 
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```

- 修改建议：
  
  示例1：
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      substring_index( "visitCount", ',',- 1 )::int  visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **说明：substring_index是自定义函数。**
  
  示例2：
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      cast(substring_index( "visitCount", ',',- 1 ) AS int4)  visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **说明：substring_index是自定义函数。**
  
  **示例3（建议）：**
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      (string_to_array("visitCount", ','))[array_length(string_to_array("visitCount", ','), 1)]::int4 visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **示例4（建议）：**
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      (string_to_array("visitCount", ','))[7]::int4 visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```

- 说明
  
  有没有发现只有id和visit没有使用双引号？**请不要使用大写字段名！！！**

#### [SUBSTRING_INDEX](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)

- 示例同[cast](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=cast)

#### [FIND_IN_SET(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_setstrstrlist)

- 业务场景：根据资产标签统计在线数量和风险数量

- mysql语句：
  
  ```
  SELECT
      COUNT( CASE WHEN r.assetState = 'online' OR r.assetOnlineMonitor = 0 THEN 1 END ) AS `online`,
      COUNT( CASE WHEN r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ) THEN 1 END ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURDATE() 
      WHERE
          FIND_IN_SET( 'AR网关', ai.asset_label ) 
      ) r;
  ```

- 修改建议：
  
  **示例1，使用any和string_to_array实现（建议）：**
  
  ```
  SELECT 
      COUNT( IF ( r.assetState = 'online' OR r.assetOnlineMonitor = 0, 1, NULL ) ) AS online,
      COUNT( IF ( r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ), 1, NULL ) ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURRENT_DATE 
      WHERE
      'AR网关' = ANY ( string_to_array( ai.asset_label, ',' ) ) 
      ) r;
  ```
  
  示例2，[自定义find_in_set(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_set_impl)函数实现：
  
  ```
  SELECT 
      COUNT( IF ( r.assetState = 'online' OR r.assetOnlineMonitor = 0, 1, NULL ) ) AS online,
      COUNT( IF ( r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ), 1, NULL ) ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURRENT_DATE 
      WHERE
          FIND_IN_SET( 'AR网关', ai.asset_label ) 
      ) r;
  ```

#### [GROUP_CONCAT()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=group_concat)

- 业务场景：查询资产的名称和所有IP标识

- mysql语句：
  
  ```
  SELECT DISTINCT
      CONCAT( tai.asset_name, '(', taid.identification, ')' ) 
  FROM
      t_asset_information tai
      LEFT JOIN 
      ( 
          SELECT 
              GROUP_CONCAT( identification ) AS identification, 
              asset_id FROM t_asset_identification 
          WHERE identification_type IN ( 'private_ip', 'public_ip' )
          GROUP BY asset_id  
      ) taid ON tai.asset_id = taid.asset_id;
  ```

- 修改建议：
  
  示例1，使用array_to_string函数和聚合函数array_agg组合实现：
  
  ```
  SELECT DISTINCT
      CONCAT( tai.asset_name, '(', taid.identification, ')' ) 
  FROM
      t_asset_information tai
      LEFT JOIN 
      ( 
          SELECT 
              array_to_string(array_agg(identification), ',') AS identification, 
              asset_id FROM t_asset_identification 
          WHERE identification_type IN ( 'private_ip', 'public_ip' )
          GROUP BY asset_id
      ) taid ON tai.asset_id = taid.asset_id;
  ```

#### [DATE_FORMAT(date,format)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=date_formatdateformat)

- 业务场景：查询工单创建操作行为记录

- mysql语句：
  
  ```
  SELECT
      serial_id,
      operater,
      operater_host_address AS operaterHostAddress,
      action AS actionCode,
      date_format( created_at, '%Y-%m-%d %H:%i:%s' ) AS operationTime,
      operater_operations AS operaterOperationsContent 
  FROM
      t_work_order_operation_history 
  ORDER BY
      operationTime ASC
  ```

- 修改建议：
  
  示例：
  
  ```
  SELECT
      serial_id,
      operater,
      operater_host_address AS operaterHostAddress,
      "action" AS actionCode,
      to_char(created_at, 'YYYY-MM-DD HH24:MI:SS') AS operationTime,
      operater_operations AS operaterOperationsContent 
  FROM
      t_work_order_operation_history 
  ORDER BY
      operationTime ASC
  ```

#### [IFNULL(value1,value2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnullvalue1value2)

- 业务场景：查询重点关注用户(根据用户表查询, 可能出现用户表里有数据, 但ueba数据信息表里没有)

- mysql语句：
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      ifnull( m.seven_days_score, 0 ) seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```

- 修改建议：
  
  **示例1（建议）：**
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      case when m.seven_days_score is NULL then 0 else m.seven_days_score end seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```
  
  示例2：
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      ifnull( m.seven_days_score, 0 ) seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```

#### [CURDATE()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=curdate)

- 业务场景：查询组织架构下高风险资产的数量

- mysql语句：
  
  ```
  SELECT
      t1.asset_id 
  FROM
      t_asset_information t1
      LEFT JOIN t_asset_rating t2 ON t1.asset_id = t2.asset_id 
  WHERE
      t2.create_time >= CURDATE() 
      AND (
      t2.asset_health_state != 'healthy')
  ```

- 修改建议：
  
  示例：
  
  ```
  SELECT
      t1.asset_id 
  FROM
      t_asset_information t1
      LEFT JOIN t_asset_rating t2 ON t1.asset_id = t2.asset_id 
  WHERE
      t2.create_time >= CURRENT_DATE 
      AND (
      t2.asset_health_state != 'healthy')
  ```

- 说明
  
  **CURRENT_DATE不是函数，不要写括号**

#### [IF(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifexpr1expr2expr3)

- 业务场景：修改资产同步配置开关

- mysql语句：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = IF (#{enable}, 1, 0)
  WHERE
      id = #{configId}
  ```

- 修改建议：
  
  示例1，使用[自定义函数if](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if_impl)实现：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = IF (#{enable}, 1, 0)
  WHERE
      id = #{configId}
  ```
  
  示例2，使用类型转换实现：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = #{enable}::int4
  WHERE
      id = #{configId}
  ```
  
  示例3，sync_asset字段改为bool类型：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = #{enable}
  WHERE
      id = #{configId}
  ```
  
  **示例4，使用case when实现（推荐）：**
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = case #{enable} when 1 then true else false end
  WHERE
      id = #{configId}
  ```

### [4.自定义函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e8%87%aa%e5%ae%9a%e4%b9%89%e5%87%bd%e6%95%b0)

- #### [创建函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%88%9b%e5%bb%ba%e5%87%bd%e6%95%b0)
  
  ##### [语法：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%af%ad%e6%b3%95%ef%bc%9a)
  
  ```
  CREATE FUNCTION somefunc(integer, text) RETURNS integer
  AS 'function body text'
  LANGUAGE plpgsql;
  ```
  
  ##### [示例：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%a4%ba%e4%be%8b%ef%bc%9a)
  
  ```
  CREATE FUNCTION my_add ( n1 INTEGER, n2 INTEGER ) RETURNS INTEGER AS $$ BEGIN
      RETURN n1 + n2;
  END $$ LANGUAGE plpgsql;
  ```

- #### [调用函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%b0%83%e7%94%a8%e5%87%bd%e6%95%b0)
  
  ```
  select my_add(1,2);
  ```

### [4.存储过程](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b)

- #### [创建存储过程](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%88%9b%e5%bb%ba%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b)
  
  ##### [示例：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%a4%ba%e4%be%8b%ef%bc%9a-1)
  
  ```
  CREATE PROCEDURE triple(INOUT x int)
  LANGUAGE plpgsql
  AS $$
  BEGIN
      x := x * 3;
  END;
  $$;
  ```

- #### [调用](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%b0%83%e7%94%a8)
  
  ```
  call triple(3);
  ```

- ### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%ae%98%e6%96%b9%e6%96%87%e6%a1%a3)[官方文档](https://www.postgresql.org/docs/13/plpgsql-control-structures.html#PLPGSQL-STATEMENTS-RETURNING-PROCEDURE)

$$ 不推荐使用存储过程 $$

## [五、触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%ba%94%e3%80%81%e8%a7%a6%e5%8f%91%e5%99%a8)

### [1.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%a7%a6%e5%8f%91%e5%99%a8)[触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%a7%a6%e5%8f%91%e5%99%a8)

### [2.事件触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e4%ba%8b%e4%bb%b6%e8%a7%a6%e5%8f%91%e5%99%a8)

为了补充[第 38 章](https://www.postgresql.org/docs/13/triggers.html)中讨论的触发机制，PostgreSQL还提供了事件触发器。与附加到单个表并仅捕获 DML 事件的常规触发器不同，事件触发器对特定数据库是全局的，并且能够捕获 DDL 事件。

与常规触发器一样，事件触发器可以用任何包括事件触发器支持的过程语言编写，也可以用 C 编写，但不能用普通 SQL 编写。

参见[事件触发器](https://www.postgresql.org/docs/13/event-triggers.html)

## [六、建表语句修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%85%ad%e3%80%81%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)

可以使用navicat帮我们转换成postgresql语句，但是会有一些问题；

### [1.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%bb%ba%e8%a1%a8%e8%af%ad%e6%b3%95)[建表语法](https://www.postgresql.org/docs/13/sql-createtable.html)

```
CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name ( [
  { column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
    | table_constraint
    | LIKE source_table [ like_option ... ] }
    [, ... ]
] )
[ INHERITS ( parent_table [, ... ] ) ]
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]

CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
    OF type_name [ (
  { column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
    | table_constraint }
    [, ... ]
) ]
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]

CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
    PARTITION OF parent_table [ (
  { column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
    | table_constraint }
    [, ... ]
) ] { FOR VALUES partition_bound_spec | DEFAULT }
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]
```

### [2.字段和表的引用修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e5%ad%97%e6%ae%b5%e5%92%8c%e8%a1%a8%e7%9a%84%e5%bc%95%e7%94%a8%e4%bf%ae%e6%94%b9)

```
`table_name` 改为 "table_name"
`column_name` 改为 "column_name"
```

### [3.主键策略修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e4%b8%bb%e9%94%ae%e7%ad%96%e7%95%a5%e4%bf%ae%e6%94%b9)

参见[自增主键](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae)和[UUID](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=uuid)

### [4.字段类型修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e5%ad%97%e6%ae%b5%e7%b1%bb%e5%9e%8b%e4%bf%ae%e6%94%b9)

参见[常用数据类型映射](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b%e6%98%a0%e5%b0%84)

### [5.字符串修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5%e5%ad%97%e7%ac%a6%e4%b8%b2%e4%bf%ae%e6%94%b9)

- 字符串标识由双引号修改为单引号;
  
  例如：
  
  ```
  mysql: SELECT "字符串" str;
  postgresql: SELECT '字符串' str;
  ```

- char(n),varchar(n)类型，存储中文的，n要乘以4兼容openGauss

### [6.字段和表注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6%e5%ad%97%e6%ae%b5%e5%92%8c%e8%a1%a8%e6%b3%a8%e9%87%8a)

- #### [字段注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%ad%97%e6%ae%b5%e6%b3%a8%e9%87%8a)
  
  mysql字段注释紧跟字段后面，pg字段注释是单独的sql语句；
  
  ps语法：`COMMENT ON COLUMN "table_name"."column_name" IS '字段注释';`

- #### [表注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%a1%a8%e6%b3%a8%e9%87%8a)
  
  mysql表注释紧跟在表后面，pg表注释是单独的sql语句；
  
  pg语法：`COMMENT ON TABLE "table_name" IS '表注释';`

### [7.触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_7%e8%a7%a6%e5%8f%91%e5%99%a8)

1. 定义表
   
   创建需要触发器的表，例如：
   
   ```
   CREATE TABLE ttest (
      "id" serial primary key,
        "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
   );
   ```

2. 编写触发函数
   
   - 触发函数支持的语言：`PL/pgSQL`
   
   - 触发函数示例
     
     pgsql示例：
     
     ```
     CREATE 
        OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
            NEW.update_time = CURRENT_TIMESTAMP;
        RETURN NEW;
     END $$ LANGUAGE plpgsql;
     ```

3. 声明触发器
   
   ```
   --操作之前填充更新时间:
   CREATE TRIGGER before_trigger BEFORE UPDATE ON ttest
          FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
   
   --操作之前执行:
   CREATE TRIGGER tbefore BEFORE INSERT OR UPDATE OR DELETE ON ttest
      FOR EACH ROW EXECUTE FUNCTION trigf();
   
   --操作之后执行:
   CREATE TRIGGER tafter AFTER INSERT OR UPDATE OR DELETE ON ttest
      FOR EACH ROW EXECUTE FUNCTION trigf();
   ```

4. [触发器官方文档](https://www.postgresql.org/docs/13/trigger-definition.html)

### [8.索引](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_8%e7%b4%a2%e5%bc%95)

pg创建索引语法：

```
CREATE INDEX name ON table [USING index_type] (column [collation] [asc || desc] [NULLS] [LAST || FIRST]);
```

mysql中的key对应pg中create index，例如：

```
mysql:
CREATE TABLE ttest (
    `id` int(11) PRIMARY KEY,
      `code` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        KEY `idx_code` (`code`) USING BTREE
);

postgresql:
CREATE TABLE ttest (
    "id" int PRIMARY KEY,
      "code" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_code ON ttest USING btree ("code" ASC NULLS FIRST);
```

**注意：mysql创建的索引默认null在最后，pg可以指定，不指定默认为 ASC NULLS LAST。**

### [9.字段、数据库命名](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_9%e5%ad%97%e6%ae%b5%e3%80%81%e6%95%b0%e6%8d%ae%e5%ba%93%e5%91%bd%e5%90%8d)

- 将包含大写的字段修改为下划线命名

- database名字按照标识符命名规则重新命名，openGauss不支持中划线命名
  
  如：bigdata-web→bigdata_web

### [10.完整示例](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_10%e5%ae%8c%e6%95%b4%e7%a4%ba%e4%be%8b)

```
mysql:
CREATE TABLE `t_asset_information` (
  `asset_id` VARCHAR ( 100 ) NOT NULL COMMENT '资产ID-资产唯一标识',
    `asset_name` VARCHAR ( 100 ) NOT NULL COMMENT '资产名称-便于查看及识别',
     PRIMARY KEY ( `asset_id` ) 
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT='资产信息表';

CREATE TABLE `t_asset_monitor_port_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `asset_id` varchar(100) DEFAULT NULL COMMENT '资产ID-资产唯一标识',
  `asset_ip` varchar(45) NOT NULL COMMENT '资产ip',
  `port` varchar(45) NOT NULL COMMENT '端口',
  `protocol` varchar(100) DEFAULT NULL COMMENT '协议',
  `service_name` varchar(500) DEFAULT NULL COMMENT '服务名',
  `server_version` varchar(500) DEFAULT NULL COMMENT '服务版本',
  `status` char(1) NOT NULL COMMENT '端口状态，1：开启，0：关闭',
  `message` varchar(255) DEFAULT NULL COMMENT '描述信息',
  `find_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发现时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `source` varchar(100) DEFAULT NULL COMMENT '端口来源 AiNTA',
  `fingerprint_name` varchar(100) DEFAULT NULL COMMENT '指纹名称',
  `fingerprint_class2` varchar(100) DEFAULT NULL COMMENT '指纹二级类型（指纹类型）',
  `vendor_name` varchar(100) DEFAULT NULL COMMENT '厂商：中文名（英文名）',
  `tag` text COMMENT '产品标签',
  PRIMARY KEY (`id`),
  KEY `idx_asset_ip` (`asset_ip`) USING BTREE,
  UNIQUE KEY `unique_asset_id_asset_ip_port` (`asset_id`,`asset_ip`,`port`),
  CONSTRAINT `foreign_key_monitor_port_info_to_asset_id_4` FOREIGN KEY (`asset_id`) REFERENCES `t_asset_information` (`asset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主机资产-端口';

postgresql:
CREATE TABLE "t_asset_information" (
 "asset_id" VARCHAR ( 100 ) PRIMARY KEY,
    "asset_name" VARCHAR ( 400 )
);
COMMENT ON COLUMN "t_asset_information"."asset_id" IS '资产ID-资产唯一标识';
COMMENT ON COLUMN "t_asset_information"."asset_name" IS '资产名称-便于查看及识别';
COMMENT ON TABLE "t_asset_information" IS '资产信息表';

CREATE TABLE "t_asset_monitor_port_info" (
    "id" bigserial NOT NULL,
    "asset_id" VARCHAR ( 100 ) DEFAULT NULL,
    "asset_ip" VARCHAR ( 45 ) NOT NULL,
    "port" VARCHAR ( 45 ) NOT NULL,
    "protocol" VARCHAR ( 100 ) DEFAULT NULL,
    "service_name" VARCHAR ( 2000 ) DEFAULT NULL,
    "server_version" VARCHAR ( 500 ) DEFAULT NULL,
    "status" "char" NOT NULL,
    "message" VARCHAR ( 1020 ) DEFAULT NULL,
    "find_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "create_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "source" VARCHAR ( 100 ) DEFAULT NULL,
    "fingerprint_name" VARCHAR ( 400 ) DEFAULT NULL,
    "fingerprint_class2" VARCHAR ( 400 ) DEFAULT NULL,
    "vendor_name" VARCHAR ( 400 ) DEFAULT NULL,
    "tag" TEXT,
    PRIMARY KEY ( "id" ),
    CONSTRAINT "unique_asset_id_asset_ip_port" UNIQUE ( "asset_id", "asset_ip", "port" ),
    CONSTRAINT "foreign_key_monitor_port_info_to_asset_id" FOREIGN KEY ( "asset_id" ) REFERENCES "t_asset_information" ( "asset_id" ) ON DELETE CASCADE ON UPDATE CASCADE 
);
CREATE INDEX "idx_asset_ip" ON "t_asset_monitor_port_info" USING btree ("asset_ip" ASC NULLS FIRST);
COMMENT ON COLUMN "t_asset_monitor_port_info"."id" IS '主键Id';
COMMENT ON COLUMN "t_asset_monitor_port_info"."asset_id" IS '资产ID-资产唯一标识';
COMMENT ON COLUMN "t_asset_monitor_port_info"."asset_ip" IS '资产ip';
COMMENT ON COLUMN "t_asset_monitor_port_info"."port" IS '端口';
COMMENT ON COLUMN "t_asset_monitor_port_info"."protocol" IS '协议';
COMMENT ON COLUMN "t_asset_monitor_port_info"."service_name" IS '服务名';
COMMENT ON COLUMN "t_asset_monitor_port_info"."server_version" IS '服务版本';
COMMENT ON COLUMN "t_asset_monitor_port_info"."status" IS '端口状态，1：开启，0：关闭';
COMMENT ON COLUMN "t_asset_monitor_port_info"."message" IS '描述信息';
COMMENT ON COLUMN "t_asset_monitor_port_info"."find_time" IS '发现时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."update_time" IS '修改时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."source" IS '端口来源 AiNTA';
COMMENT ON COLUMN "t_asset_monitor_port_info"."fingerprint_name" IS '指纹名称';
COMMENT ON COLUMN "t_asset_monitor_port_info"."fingerprint_class2" IS '指纹二级类型（指纹类型）';
COMMENT ON COLUMN "t_asset_monitor_port_info"."vendor_name" IS '厂商：中文名（英文名）';
COMMENT ON COLUMN "t_asset_monitor_port_info"."tag" IS '产品标签';
COMMENT ON TABLE "t_asset_monitor_port_info" IS '主机资产-端口';

CREATE 
    OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
        NEW.update_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER "t_asset_monitor_port_info_upd_trigger" BEFORE UPDATE ON "t_asset_monitor_port_info" FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
```

## [七、事件替换](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%83%e3%80%81%e4%ba%8b%e4%bb%b6%e6%9b%bf%e6%8d%a2)

postgresql只有事件触发器，不包含定时触发，mysql事件改为代码实现。

## [八、视图处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%85%ab%e3%80%81%e8%a7%86%e5%9b%be%e5%a4%84%e7%90%86)

### [1.视图语法](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%a7%86%e5%9b%be%e8%af%ad%e6%b3%95)

```
CREATE TABLE myview (same column list as mytab);
ALTER TABLE myview OWNER TO "user_name";
```

### [2.示例](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e7%a4%ba%e4%be%8b)

```
CREATE VIEW "asset_port" AS  SELECT t_asset_monitor_port_info.id,
    t_asset_monitor_port_info.asset_id,
    t_asset_monitor_port_info.asset_ip,
    t_asset_monitor_port_info.port,
    t_asset_monitor_port_info.protocol,
    t_asset_monitor_port_info.status
   FROM test.t_asset_monitor_port_info;

ALTER TABLE "asset_port" OWNER TO "postgres";
```

### [3.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%ae%98%e6%96%b9%e6%96%87%e6%a1%a3)[官方文档](https://www.postgresql.org/docs/13/rules-views.html)

## [九、分表处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b9%9d%e3%80%81%e5%88%86%e8%a1%a8%e5%a4%84%e7%90%86)

使用分区功能实现分表，表分区通过继承实现，可以单独查询分区表数据，也可以查询主分区，主分区包含全部分区数据，可以通过trigger和check来约束分区，同时插入数据时不指定具体分区插入到主分区，由trigger来完成分区。

[详见官网](https://www.postgresql.org/docs/13/ddl-partitioning.html)

**openGauss不支持继承**

## [十、数据迁移](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e3%80%81%e6%95%b0%e6%8d%ae%e8%bf%81%e7%a7%bb)

### [1.简介](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e7%ae%80%e4%bb%8b)

由于mysql导出的导出sql类型的数据，sql中表名和字段名的表示方式不同，不推荐sql文件形式导入。

### [2.csv导入](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2csv%e5%af%bc%e5%85%a5)

- #### [从mysql导出csv文件](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bb%8emysql%e5%af%bc%e5%87%bacsv%e6%96%87%e4%bb%b6)
  
  ```
  select * from t_asset_monitor_port_info into outfile "/var/lib/mysql-files/t_asset_monitor_port_info.csv" character set utf8 fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';
  ```

- #### [导入csv到postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%af%bc%e5%85%a5csv%e5%88%b0postgresql)
  
  ```
  copy t_asset_monitor_port_info 
  from '/var/lib/mysql-files/t_asset_monitor_port_info.csv' 
  DELIMITER ','
  CSV;
  ```

### [3.datax导入](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3datax%e5%af%bc%e5%85%a5)

[datax官网](https://github.com/alibaba/DataX/blob/master/introduction.md)

## [十一、修改项目配置](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%b8%80%e3%80%81%e4%bf%ae%e6%94%b9%e9%a1%b9%e7%9b%ae%e9%85%8d%e7%bd%ae)

### [1.pom.xml](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1pomxml)

新增postgresql驱动依赖

```
<dependency>
  <groupId>org.postgresql</groupId>
  <artifactId>postgresql</artifactId>
</dependency>
```

### [2.application.properties](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2applicationproperties)

修改数据库连接信息和驱动

```
spring.datasource.driver-class-name=org.postgresql.Driver
```

## [十二、SQL修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%ba%8c%e3%80%81sql%e4%bf%ae%e6%94%b9)

### [1.参考](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%8f%82%e8%80%83%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)[建表语句修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)

### [2.insert冲突处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2insert%e5%86%b2%e7%aa%81%e5%a4%84%e7%90%86)

```
mysql:
INSERT INTO t_asset_information ( asset_id, asset_name, org_id, net_id )
VALUES
    ( 'asset_00008519-b728-4b00-857a-9be4e4cf537d_1657273055277', '10.2.51.88', '12bbcbcf-d8e8-4009-a8ba-a043f96f5ae8', '12bbcbcf-d8e8-4009-a8ba-a043f96f5ae8' ) 
    ON DUPLICATE KEY UPDATE asset_name = '10.2.51.88';

postgresql:
INSERT INTO "t_asset_information" ( "asset_id", "asset_name" )
VALUES
    ( 'asset_00008519-b728-4b00-857a-9be4e4cf537d_1657273055277', '10.2.51.88' ) ON CONFLICT ( asset_id ) DO
UPDATE 
    SET asset_name = '10.2.51.65';
```

### [3.schema处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3schema%e5%a4%84%e7%90%86)

**postgresql未指定schema时默认查询public，如果使用的非public，请指定schema。**

- 实体类
  
  ```
  @TableName(value="test.t_asset_monitor_port_info")
  或者
  @TableName(value="t_asset_monitor_port_info", schema="test")
  ```

- sql
  
  ```
  SELECT ID
      ,
      asset_id,
      asset_ip,
      port,
      protocol,
      service_name,
      server_version,
      status,
      message,
      find_time,
      create_time,
      update_time,
      SOURCE,
      fingerprint_name,
      fingerprint_class2,
      vendor_name,
      tag 
  FROM
      test.t_asset_monitor_port_info
  ```

### [4.运算符修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e8%bf%90%e7%ae%97%e7%ac%a6%e4%bf%ae%e6%94%b9)

​ [运算符对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e8%bf%90%e7%ae%97%e7%ac%a6%e5%af%b9%e7%85%a7%e8%a1%a8)

### [5.函数修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5%e5%87%bd%e6%95%b0%e4%bf%ae%e6%94%b9)

​ [常用函数对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e5%af%b9%e7%85%a7%e8%a1%a8)

### [6.group by和order by](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6group-by%e5%92%8corder-by)

​ postgresql的order by字段必须出现在select后面；

​ postgresql的group by语句中select字段必须出现在group by后面或者使用聚合函数。

## [十三、涉及组件](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%b8%89%e3%80%81%e6%b6%89%e5%8f%8a%e7%bb%84%e4%bb%b6)

### [1.flywaydb](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1flywaydb)

[官方文档](https://flywaydb.org/documentation/)显示支持postgresql，但是不支持openGauss，需要测试语法兼容openGauss的情况下能不能正常使用。

### [2.nacos](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2nacos)

nacos不支持postgresql和openGauss；

#### [建议：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%bb%ba%e8%ae%ae%ef%bc%9a)

1. 使用内置数据源
2. 使用java agent，不支持openGauss，地址:https://github.com/siaron/mysql2postgresql-jdbc-agent

## [十四、集群方式](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e5%9b%9b%e3%80%81%e9%9b%86%e7%be%a4%e6%96%b9%e5%bc%8f)

### [1.citus](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1citus)

Citus 是 Postgres 的一个**开源扩展**，它在集群中的多个节点上分布数据和查询。因为 Citus 是 Postgres 的扩展（**不是 fork**），所以当您使用 Citus 时，您也在使用 Postgres。您可以利用最新的 Postgres 功能、工具和生态系统。

Citus 将 Postgres 转换为具有分片、分布式 SQL 引擎、引用表和分布式表等功能的分布式数据库。Citus 将并行性、在内存中保留更多数据和更高的 I/O 带宽相结合，可以显着提高多租户 SaaS 应用程序、面向客户的实时分析仪表板和时间序列工作负载的性能。

- #### [优点](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bc%98%e7%82%b9)
  
  文档丰富；
  
  开源；
  
  只是PostgreSQL的一个extension；
  
  横向扩展方便；
  
  支持常用DDL；
  
  支持实时增删改查；
  
  支持聚合下推；
  
  支持分布式事务；
  
  支持并行查询。

- #### [缺点](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%bc%ba%e7%82%b9)
  
  多语句事务没有防止死锁的安全措施；
  
  没有针对中间查询失败和由此产生的不一致的安全措施；
  
  查询结果缓存在内存中；这些函数不能处理非常大的结果集；
  
  如果无法连接到节点，这些函数会提前出错；
  
  SQL限制。

- #### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=citus%e5%ae%98%e7%bd%91)[citus官网](https://docs.citusdata.com/en/v11.0/?_gl=1*1i2q6bs*_ga*MjcwMDQ1NzI5LjE2NTg3MzI0MjM.*_ga_DS5S1RKEB7*MTY1ODczMjQyMy4xLjEuMTY1ODczMjQ0Ny4w)

- #### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=sql%e5%92%8c%e8%a7%a3%e5%86%b3%e6%96%b9%e6%b3%95)[SQL和解决方法](https://docs.citusdata.com/en/v11.0/develop/reference_workarounds.html#)

### [2.Patroni + Etcd](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2patroni-etcd)

基于 [Patroni](https://patroni.readthedocs.io/en/latest/index.html) + [Etcd](https://etcd.io/docs/v3.4.0/) 的高可用方案，此方案使用Patroni管理本地库，并结合Etcd作为数据存储和主节点选举。

Patroni基于Python开发的模板，结合DCS(例如 ZooKeeper, etcd, Consul )可以定制PostgreSQL高可用方案。 Patroni并不是一套拿来即用的PostgreSQL高可用组件，涉及较多的配置和定制工作，Patroni 本身使用的数据同步方式是postgresql的流复制方式，默认的情况我们还是使用异步的方式，在Patroni 中会有一个参数，Maximum_lag_on_failover ,通过设置，保证从库在与主库超过一定数据不同步的情况下，不会发生相关的主从转移。 Patroni接管PostgreSQL数据库的启停，同时监控本地的PostgreSQL数据库，并将本地的PostgreSQL数据库信息写入DCS。 Patroni的主备端是通过是否能获得 leader key 来控制的，获取到了leader key的Patroni为主节点，其它的为备节点。

Etcd是一款基于Raft算法和协议开发的分布式 key-value 数据库，基于Go语言编写，Patroni监控本地的PostgreSQL状态，并将相关信息写入Etcd，每个Patroni都能读写Etcd上的key，从而获取外地PostgreSQL数据库信息。

- 优点
  
  健壮性: 使用分布式key-value数据库作为数据存储，主节点故障时进行主节点重新选举，具有很强的健壮性；
  
  支持主备延迟设置: 可以设置备库延迟主库WAL的字节数，当备库延迟大于指定值时不做故障切换；
  
  自动化程度高：
  
  1. 支持自动化初始PostgreSQL实例并部署流复制;
  2. 当备库实例关闭后，支持自动拉起;
  3. 当主库实例关闭后，首先会尝试自动拉起;
  4. 支持switchover命令，能自动将老的主库进行角色转换。
  
  避免脑裂: 数据库信息记录到 ETCD 中，通过优化部署策略（多机房部署、增加实例数)可以避免脑裂。

- 缺点
  
  搭建繁琐，需要安装不同的组件，及配置项；
  
  无组合使用的官方文档；
  
  读写需要访问不同的接口。

## [十五、附录](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%ba%94%e3%80%81%e9%99%84%e5%bd%95)

### [1.postgresql类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1postgresql%e7%b1%bb%e5%9e%8b)

| Name                                          | Aliases                      | Description                                                        |
| --------------------------------------------- | ---------------------------- | ------------------------------------------------------------------ |
| `bigint`                                      | `int8`                       | signed eight-byte integer                                          |
| `bigserial`                                   | `serial8`                    | autoincrementing eight-byte integer                                |
| `bit [ (*`n`*) ]`                             |                              | fixed-length bit string                                            |
| `bit varying [ (*`n`*) ]`                     | `varbit [ (*`n`*) ]`         | variable-length bit string                                         |
| `boolean`                                     | `bool`                       | logical Boolean (true/false)                                       |
| `box`                                         |                              | rectangular box on a plane                                         |
| `bytea`                                       |                              | binary data (“byte array”)                                         |
| `character [ (*`n`*) ]`                       | `char [ (*`n`*) ]`           | fixed-length character string                                      |
| `character varying [ (*`n`*) ]`               | `varchar [ (*`n`*) ]`        | variable-length character string                                   |
| `cidr`                                        |                              | IPv4 or IPv6 network address                                       |
| `circle`                                      |                              | circle on a plane                                                  |
| `date`                                        |                              | calendar date (year, month, day)                                   |
| `double precision`                            | `float8`                     | double precision floating-point number (8 bytes)                   |
| `inet`                                        |                              | IPv4 or IPv6 host address                                          |
| `integer`                                     | `int`, `int4`                | signed four-byte integer                                           |
| `interval [ *`fields`* ] [ (*`p`*) ]`         |                              | time span                                                          |
| `json`                                        |                              | textual JSON data                                                  |
| `jsonb`                                       |                              | binary JSON data, decomposed                                       |
| `line`                                        |                              | infinite line on a plane                                           |
| `lseg`                                        |                              | line segment on a plane                                            |
| `macaddr`                                     |                              | MAC (Media Access Control) address                                 |
| `macaddr8`                                    |                              | MAC (Media Access Control) address (EUI-64 format)                 |
| `money`                                       |                              | currency amount                                                    |
| `numeric [ (*`p`*, *`s`*) ]`                  | `decimal [ (*`p`*, *`s`*) ]` | exact numeric of selectable precision                              |
| `path`                                        |                              | geometric path on a plane                                          |
| `pg_lsn`                                      |                              | PostgreSQL Log Sequence Number                                     |
| `pg_snapshot`                                 |                              | user-level transaction ID snapshot                                 |
| `point`                                       |                              | geometric point on a plane                                         |
| `polygon`                                     |                              | closed geometric path on a plane                                   |
| `real`                                        | `float4`                     | single precision floating-point number (4 bytes)                   |
| `smallint`                                    | `int2`                       | signed two-byte integer                                            |
| `smallserial`                                 | `serial2`                    | autoincrementing two-byte integer                                  |
| `serial`                                      | `serial4`                    | autoincrementing four-byte integer                                 |
| `text`                                        |                              | variable-length character string                                   |
| `time [ (*`p`*) ] [ without time zone ]`      |                              | time of day (no time zone)                                         |
| `time [ (*`p`*) ] with time zone`             | `timetz`                     | time of day, including time zone                                   |
| `timestamp [ (*`p`*) ] [ without time zone ]` |                              | date and time (no time zone)                                       |
| `timestamp [ (*`p`*) ] with time zone`        | `timestamptz`                | date and time, including time zone                                 |
| `tsquery`                                     |                              | text search query                                                  |
| `tsvector`                                    |                              | text search document                                               |
| `txid_snapshot`                               |                              | user-level transaction ID snapshot (deprecated; see `pg_snapshot`) |
| `uuid`                                        |                              | universally unique identifier                                      |
| `xml`                                         |                              | XML data                                                           |

### [2.postgresql日期pattern](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2postgresql%e6%97%a5%e6%9c%9fpattern)

| Pattern                          | Description                                                                                                                                               |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `HH`                             | hour of day (01–12)                                                                                                                                       |
| `HH12`                           | hour of day (01–12)                                                                                                                                       |
| `HH24`                           | hour of day (00–23)                                                                                                                                       |
| `MI`                             | minute (00–59)                                                                                                                                            |
| `SS`                             | second (00–59)                                                                                                                                            |
| `MS`                             | millisecond (000–999)                                                                                                                                     |
| `US`                             | microsecond (000000–999999)                                                                                                                               |
| `FF1`                            | tenth of second (0–9)                                                                                                                                     |
| `FF2`                            | hundredth of second (00–99)                                                                                                                               |
| `FF3`                            | millisecond (000–999)                                                                                                                                     |
| `FF4`                            | tenth of a millisecond (0000–9999)                                                                                                                        |
| `FF5`                            | hundredth of a millisecond (00000–99999)                                                                                                                  |
| `FF6`                            | microsecond (000000–999999)                                                                                                                               |
| `SSSS`, `SSSSS`                  | seconds past midnight (0–86399)                                                                                                                           |
| `AM`, `am`, `PM` or `pm`         | meridiem indicator (without periods)                                                                                                                      |
| `A.M.`, `a.m.`, `P.M.` or `p.m.` | meridiem indicator (with periods)                                                                                                                         |
| `Y,YYY`                          | year (4 or more digits) with comma                                                                                                                        |
| `YYYY`                           | year (4 or more digits)                                                                                                                                   |
| `YYY`                            | last 3 digits of year                                                                                                                                     |
| `YY`                             | last 2 digits of year                                                                                                                                     |
| `Y`                              | last digit of year                                                                                                                                        |
| `IYYY`                           | ISO 8601 week-numbering year (4 or more digits)                                                                                                           |
| `IYY`                            | last 3 digits of ISO 8601 week-numbering year                                                                                                             |
| `IY`                             | last 2 digits of ISO 8601 week-numbering year                                                                                                             |
| `I`                              | last digit of ISO 8601 week-numbering year                                                                                                                |
| `BC`, `bc`, `AD` or `ad`         | era indicator (without periods)                                                                                                                           |
| `B.C.`, `b.c.`, `A.D.` or `a.d.` | era indicator (with periods)                                                                                                                              |
| `MONTH`                          | full upper case month name (blank-padded to 9 chars)                                                                                                      |
| `Month`                          | full capitalized month name (blank-padded to 9 chars)                                                                                                     |
| `month`                          | full lower case month name (blank-padded to 9 chars)                                                                                                      |
| `MON`                            | abbreviated upper case month name (3 chars in English, localized lengths vary)                                                                            |
| `Mon`                            | abbreviated capitalized month name (3 chars in English, localized lengths vary)                                                                           |
| `mon`                            | abbreviated lower case month name (3 chars in English, localized lengths vary)                                                                            |
| `MM`                             | month number (01–12)                                                                                                                                      |
| `DAY`                            | full upper case day name (blank-padded to 9 chars)                                                                                                        |
| `Day`                            | full capitalized day name (blank-padded to 9 chars)                                                                                                       |
| `day`                            | full lower case day name (blank-padded to 9 chars)                                                                                                        |
| `DY`                             | abbreviated upper case day name (3 chars in English, localized lengths vary)                                                                              |
| `Dy`                             | abbreviated capitalized day name (3 chars in English, localized lengths vary)                                                                             |
| `dy`                             | abbreviated lower case day name (3 chars in English, localized lengths vary)                                                                              |
| `DDD`                            | day of year (001–366)                                                                                                                                     |
| `IDDD`                           | day of ISO 8601 week-numbering year (001–371; day 1 of the year is Monday of the first ISO week)                                                          |
| `DD`                             | day of month (01–31)                                                                                                                                      |
| `D`                              | day of the week, Sunday (`1`) to Saturday (`7`)                                                                                                           |
| `ID`                             | ISO 8601 day of the week, Monday (`1`) to Sunday (`7`)                                                                                                    |
| `W`                              | week of month (1–5) (the first week starts on the first day of the month)                                                                                 |
| `WW`                             | week number of year (1–53) (the first week starts on the first day of the year)                                                                           |
| `IW`                             | week number of ISO 8601 week-numbering year (01–53; the first Thursday of the year is in week 1)                                                          |
| `CC`                             | century (2 digits) (the twenty-first century starts on 2001-01-01)                                                                                        |
| `J`                              | Julian Date (integer days since November 24, 4714 BC at local midnight; see [Section B.7](https://www.postgresql.org/docs/13/datetime-julian-dates.html)) |
| `Q`                              | quarter                                                                                                                                                   |
| `RM`                             | month in upper case Roman numerals (I–XII; I=January)                                                                                                     |
| `rm`                             | month in lower case Roman numerals (i–xii; i=January)                                                                                                     |
| `TZ`                             | upper case time-zone abbreviation (only supported in `to_char`)                                                                                           |
| `tz`                             | lower case time-zone abbreviation (only supported in `to_char`)                                                                                           |
| `TZH`                            | time-zone hours                                                                                                                                           |
| `TZM`                            | time-zone minutes                                                                                                                                         |
| `OF`                             | time-zone offset from UTC (only supported in `to_char`)                                                                                                   |

### [3.substring_index()实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3substring_index%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION substring_index ( VARCHAR, VARCHAR, INTEGER ) RETURNS VARCHAR AS $$ DECLARE
    tokens VARCHAR [];
len INTEGER;
indexnum INTEGER;
BEGIN
    tokens := string_to_array( $1, $2 );
    len := array_upper( tokens, 1 );
    indexnum := len - ( $3 * - 1 ) + 1;
    IF
        $3 >= 0 THEN
            RETURN array_to_string( tokens [ 1 :$3 ], $2 );
        ELSE RETURN array_to_string( tokens [ indexnum : len ], $2 );
    END IF;
END;
$$ LANGUAGE PLPGSQL;
```

### [4.if(expr1,expr2,expr3)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4ifexpr1expr2expr3%e5%ae%9e%e7%8e%b0)

```
CREATE 
OR REPLACE FUNCTION
IF
    ( expr1 anyelement, expr2 anyelement, expr3 anyelement ) RETURNS anyelement AS $$ BEGIN
    IF
        expr1::BOOLEAN THEN
            RETURN expr2;
        ELSE RETURN expr3;
    END IF;
END;
$$ LANGUAGE plpgsql;
```

### [5.ifnull(val1,val2)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5ifnullval1val2%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION ifnull ( val1 anyelement, val2 anyelement ) RETURNS anyelement AS $$ BEGIN
    IF
        val1 IS NULL THEN
            RETURN val2;
        ELSE RETURN val1;
    END IF;
END;
$$ LANGUAGE plpgsql;
```

### [6.find_in_set(str,strlist)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6find_in_setstrstrlist%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION find_in_set ( str VARCHAR, strlist VARCHAR ) RETURNS BOOLEAN AS $$ BEGIN
        RETURN array_position ( string_to_array( strlist, ',' ), str ) > 0;
END;
$$ LANGUAGE plpgsql;
```

**注意：该函数返回值为boolean类型**# [数据库切换PG方案](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e6%95%b0%e6%8d%ae%e5%ba%93%e5%88%87%e6%8d%a2pg%e6%96%b9%e6%a1%88)

## [一、版本选择](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%80%e3%80%81%e7%89%88%e6%9c%ac%e9%80%89%e6%8b%a9)

### [各版本对比：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%90%84%e7%89%88%e6%9c%ac%e5%af%b9%e6%af%94%ef%bc%9a)

| 版本    | 最新版本   | 最新发布日期     | 停更时间       | 重要变化                                                                                                                                                                                                                 | 官网介绍                                                    |
| ----- | ------ | ---------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| 9.6.X | 9.6.24 | 2021-11-11 | 2021-11-11 | 1.**支持并行查询**<br>2.**允许同步复制**<br>3.**热备份**<br>4.继承式分区                                                                                                                                                                 | [9.6.0](https://www.postgresql.org/docs/release/9.6.0/) |
| 10.X  | 10.23  | 2022-11-10 | 2022-11-10 | 1.内置分区表<br>2.逻辑复制<br>3.**并行功能增强**                                                                                                                                                                                    | [10.0](https://www.postgresql.org/docs/release/10.0/)   |
| 11.X  | 11.22  | 2023-11-09 | 2023-11-09 | 1.新增哈希分区<br>2.基于的分区表创建索引<br>3.支持update分区<br>4.会创建一个默认default分区<br>5.分区支持创建主键，外键，索引，触发器                                                                                                                               | [11.0](https://www.postgresql.org/docs/release/11.0/)   |
| 12.X  | 12.19  | 2024-05-09 | --         | 1.**支持[SQL/JSON路径](https://www.postgresql.org/docs/12/functions-json.html#FUNCTIONS-SQLJSON-PATH)语言**<br>2.一般性能改进<br>3.[使用GSSAPI](https://www.postgresql.org/docs/12/gssapi-auth.html)身份验证时的 TCP/IP 连接加密             | [12.0](https://www.postgresql.org/docs/release/12.0/)   |
| 13.X  | 13.15  | 2024-05-09 | --         | 1.新增gen_random_uuid()函数<br>2.提高了使用聚合或分区表的查询的性能<br>3.从 B 树索引条目的重复数据删除中节省空间并提高性能                                                                                                                                       | [13.0](https://www.postgresql.org/docs/release/13.0/)   |
| 14.X  | 14.12  | 2024-05-09 | --         | 1.对并行查询、高度并发的工作负载、分区表、逻辑复制和清理进行了许多性能改进<br>2.B-tree 索引更新的管理效率更高，从而减少了索引膨胀<br>3.`VACUUM`如果数据库开始接近事务 ID 环绕条件，它会自动变得更加积极，并跳过不必要的清理                                                                                       | [14.0](https://www.postgresql.org/docs/release/14.0/)   |
| 15.X  | 15.7   | 2024-05-09 | --         | 1.添加SQL / JSON查询函数[`json_exists()`](https://www.postgresql.org/docs/15/functions-json.html#FUNCTIONS-SQLJSON-QUERYING), `json_query()`, 和`json_value()`<br>2.**merge sql command**<br>3.在使用distinct 命令的情况下，可以支持并行的查询 | [15.0](https://www.postgresql.org/docs/release/15.0/)   |
| 16.X  | 16.3   | 2024-05-09 | --         | 1.允许并行化FULL和内部右OUTER哈希连接<br>2.允许从备用服务器进行逻辑复制<br>3.允许逻辑复制订阅者并行应用大型事务<br>4.允许使用新视图监控I/O统计信息pg_stat_io<br>5.添加SQL/JSON构造函数和标识函数<br>6.提高真空冷冻性能<br>7.pg_hba.conf添加对中用户和数据库名称以及中用户名的正则表达式匹配的支持pg_ident.conf                | [16.0](https://www.postgresql.org/docs/release/16.0/)   |

### [总结：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e6%80%bb%e7%bb%93%ef%bc%9a)

当前最高版本为v16.3;

当前最高release版本为v16.3，修复了16.2使用的一些问题；

由于12.X版本才支持SQL/JSON path，所以我们最低版本应该选择12.X。

目前大部分公司使用的版本：9.4、10、12、13，推荐使用版本：13.7、12.11、14.4。

版本特性总结连接：[PostgreSQL: Documentation](https://www.postgresql.org/docs/)

## [二、常用数据类型映射](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%ba%8c%e3%80%81%e5%b8%b8%e7%94%a8%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b%e6%98%a0%e5%b0%84)

### [1.数值类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e6%95%b0%e5%80%bc%e7%b1%bb%e5%9e%8b)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql)

| mysql类型    | 范围                                                             | pg类型                                | 范围                                      | 说明                                           |
| ---------- | -------------------------------------------------------------- | ----------------------------------- | --------------------------------------- | -------------------------------------------- |
| BIT[(M)]   | M范围是：[1,64]，默认1                                                | BIT[(n)]                            | ----                                    |                                              |
| TINYINT    | 有符号范围 `-128` - `127`。<br>无符号范围是`0` - `255`                     | smallint<br>int2                    | `-32768` - `32767`                      |                                              |
| TINYINT(1) | true,1<br>false,0                                              | bool                                | true,yes,on,1<br>false,no,off,0         | 布尔值                                          |
| SMALLINT   | 有符号范围 `-32768` - `32767`<br>无符号范围是`0` - `65535`                | smallint<br>int2                    | `-32768` - `32767`                      | **pg不能使用无符号，如果超出范围请使用`integer`类型**           |
| MEDIUMINT  | 有符号范围 `-8388608` - `8388607`<br>无符号范围是`0` - `16777215`         | integer<br>int4                     | `-2147483648` - `2147483647`            | 一个中等大小的整数                                    |
| INT        | 有符号范围 `-2147483648` - `2147483647`<br>无符号范围是`0` - `4294967295` | integer<br>int4                     | `-2147483648` - `2147483647`            | **pg不能使用无符号，如果超出范围请使用`bigint`类型**            |
| BIGINT     | 有符号范围 `-2^63` - `2^63 - 1`<br>无符号范围是`0` - `2^ 64 - 1`          | bigint<br>int8                      | `-2^63` - `2^63 - 1`                    | **pg不能使用无符号，如果超出范围请使用`numeric`或`decimal`类型** |
| DECIMAL    | 最大`DECIMAL(65)`                                                | decimal                             | 小数点前最多 131072 位；小数点后最多 16383 位          | 指定的精度，精确                                     |
| NUMERIC    | 最大`NUMERIC(65)`                                                | numeric                             | 小数点前最多 131072 位；小数点后最多 16383 位          | 指定的精度，精确                                     |
| FLOAT      | 支持无符号，4字节                                                      | real<br>float4                      | 4字节<br>-3.402E+38~3.402E+38，6位十进制数字精度。  | 不精确                                          |
| DOUBLE     | 支持无符号，8字节                                                      | float<br>float8<br>double precision | 8字节<br>-1.79E+308~1.79E+308，15位十进制数字精度。 | 不精确                                          |
| **----**   | **----**                                                       | **smallserial**                     | **1 - 32767<br>自增整数**                   |                                              |
| **----**   | **----**                                                       | **serial**                          | **1 - 2147483647<br>自增整数**              |                                              |
| **----**   | **----**                                                       | **bigserial**                       | **1 - 9223372036854775807<br>自增整数**     |                                              |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss)

| pg类型                                  | 范围   | openGauss类型                                   | 范围                                                                                                           | 说明       |
| ------------------------------------- | ---- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | -------- |
| ----                                  | ---- | TINYINT,<br>int1                              | 0 ~ 255                                                                                                      |          |
| ----                                  | ---- | LARGESERIAL                                   | -170,141,183,460,469,231,731,687,303,715,884,105,728<br>~170,141,183,460,469,231,731,687,303,715,884,105,727 | 十六字节序列整型 |
| float,<br>float8,<br>double precision | ---- | DOUBLE PRECISION,<br>FLOAT8,<br>BINARY_DOUBLE | ----                                                                                                         |          |

### [2.日期和时间类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e6%97%a5%e6%9c%9f%e5%92%8c%e6%97%b6%e9%97%b4%e7%b1%bb%e5%9e%8b)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-1)

| mysql类型   | 范围                                                        | pg类型         | 范围                                     | 说明                          |
| --------- | --------------------------------------------------------- | ------------ | -------------------------------------- | --------------------------- |
| DATE      | 1000-01-01 - 9999-12-31                                   | date         | 4713 BC - 5874897 AD                   | 年月日，精度：一天                   |
| **----**  |                                                           | **time**     | **00:00:00 - 24:00:00**                | **精度：微秒<br>可带时区**           |
| DATETIME  | 1000-01-01 00:00:00 - 9999-12-31 23:59:59                 | timestamp    | 4713 BC - 294276 AD                    | 可以包括一个尾随小数秒部分，可带时区<br>精度：微秒 |
| **----**  | **----**                                                  | **interval** | **-178000000 years - 178000000 years** | **时间间隔**                    |
| TIMESTAMP | `'1970-01-01 00:00:01'` UTC - `'2038-01-19 03:14:07'` UTC | timestamp    | 4713 BC - 294276 AD                    | 可以包括一个尾随小数秒部分，可带时区<br>精度：微秒 |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-1)

| pg类型     | 描述       | openGauss类型       | 描述                                                                                                                |
| -------- | -------- | ----------------- | ----------------------------------------------------------------------------------------------------------------- |
| **date** | **日期**   | **DATE**          | **时间和日期**                                                                                                         |
| **----** | **----** | **SMALLDATETIME** | **日期和时间，不带时区。<br>精确到分钟，秒位大于等于30秒进一位。**                                                                            |
| **----** | **----** | **reltime**       | **相对时间间隔。格式为：<br>X years X mons X days XX:XX:XX。<br>采用儒略历计时，规定一年为365.25天，一个月为30天，计算输入值对应的相对时间间隔，输出采用POSTGRES格式。** |
| **----** | **----** | **abstime**       | **日期和时间。格式为：<br>YYYY-MM-DD hh:mm:ss+timezone<br>取值范围为1901-12-13 20:45:53 GMT~2038-01-18 23:59:59 GMT，精度为秒。**      |

#### [备注：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%a4%87%e6%b3%a8%ef%bc%9a)

​ 推荐使用timestamp

### [3.字符串数据类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%ad%97%e7%ac%a6%e4%b8%b2%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b)

pg和openGauss字符串类型可以指定COLLATE(排序规则)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-2)

| mysql类型    | 范围/说明                                                                 | pg类型                                | 范围/说明                                                                | 说明            |
| ---------- | --------------------------------------------------------------------- | ----------------------------------- | -------------------------------------------------------------------- | ------------- |
| CHAR(n)    | 0-255<br>会用空格右填充到指定的长度                                                | char(n),<br>character(n)            | 最大约1GB，固定长度，空白填充<br>char不指定长度默认1<br>varchar不指定长度，最大约1GB              |               |
| VARCHAR(n) | 0-65535<br>值在存储时不会被填充                                                 | character varying(n),<br>varchar(n) | 最大约1GB，可变长度                                                          |               |
| BINARY     | 0-255<br>使用值0x00右填充到指定的长度                                             | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| VARBINARY  | 0-65535                                                               | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| BLOB       | 二进制字符串                                                                | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| TEXT       | 非二进制字符串                                                               | text                                | 无限制                                                                  |               |
| ENUM       | 最多65535个元素                                                            | ENUM                                | 63字节                                                                 |               |
| SET        | 最多64个不同的成员，自动去重<br>如果将`SET`列设置为不受支持的值，则该值将被忽略并发出警告                    | ----                                | ----                                                                 | pg无对应类型       |
| JSON       | [json函数](https://dev.mysql.com/doc/refman/5.7/en/json-functions.html) | json,<br>jsonb                      | [json函数和运算符](https://www.postgresql.org/docs/13/functions-json.html) | 均支持路径语法，函数不相同 |
| ----       | ----                                                                  | "char"                              | 1字节                                                                  |               |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-2)

| pg类型                                    | 范围/说明                                                                  | openGauss类型                                             | 范围/说明                                                                                                                                   |
| --------------------------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **char(n),<br>character(n)**            | **最大约1GB，固定长度，空白填充<br>char不指定长度默认1<br>varchar不指定长度，最大约1GB<br>n是指字符长度** | **CHAR(n),<br>CHARACTER(n),<br>NCHAR(n)**               | **定长字符串，不足补空格。n是指字节长度，如不带精度n，默认精度为1。<br>最大为10MB。**                                                                                      |
| **character varying(n),<br>varchar(n)** | **最大约1GB，可变长度<br>n是指字符长度**                                             | **character varying(n),<br>varchar(n),<br>varchar2(n)** | **变长字符串。n是指字节长度。<br>最大为10MB。**                                                                                                          |
| **----**                                | **----**                                                               | **NVARCHAR2(n)**                                        | **变长字符串。n是指字符长度。<br>最大为10MB。**                                                                                                          |
| **----**                                | **----**                                                               | **BLOB**                                                | **二进制字符串<br>说明：列存不支持BLOB类型<br>最大为1GB-8203字节（即1073733621字节）。**                                                                           |
| **----**                                | **----**                                                               | **RAW**                                                 | **变长的十六进制类型<br>说明：<br>列存不支持RAW类型**                                                                                                      |
| **----**                                | **----**                                                               | **BYTEAWITHOUTORDERWITHEQUALCOL**                       | **变长的二进制字符串（密态特性新增的类型，如果加密列的加密类型指定为确定性加密，则该列的实际类型为BYTEAWITHOUTORDERWITHEQUALCOL），元命令打印加密表将显示原始数据类型**                                    |
| **----**                                | **----**                                                               | **BYTEAWITHOUTORDERCOL**                                | **变长的二进制字符串（密态特性新增的类型，如果加密列的加密类型指定为随机加密，则该列的实际类型为BYTEAWITHOUTORDERCOL），元命令打印加密表将显示原始数据类型**                                              |
| **----**                                | **----**                                                               | **_BYTEAWITHOUTORDERWITHEQUALCOL**                      | **变长的二进制字符串，密态特性新增的类型**                                                                                                                 |
| **----**                                | **----**                                                               | **_BYTEAWITHOUTORDERCOL**                               | **变长的二进制字符串，密态特性新增的类型**                                                                                                                 |
| json,<br>jsonb                          | [json函数和运算符](https://www.postgresql.org/docs/13/functions-json.html)   | JSON,<br>JSONB                                          | [json函数](https://opengauss.org/zh/docs/3.0.0/docs/Developerguide/JSON-JSONB%E5%87%BD%E6%95%B0%E5%92%8C%E6%93%8D%E4%BD%9C%E7%AC%A6.html) |

#### [备注：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%a4%87%e6%b3%a8%ef%bc%9a-1)

- json和jsonb
  
  json存储效率比jsonb高，但是如果进行json操作时，json类型需要解析。
  
  json存储和查询（作为字符串方式查询出来）效率比较高；
  
  jsonb适合在json字段上做一些操作，比如查询和更新等。

## [三、主键策略与日期更新处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%89%e3%80%81%e4%b8%bb%e9%94%ae%e7%ad%96%e7%95%a5%e4%b8%8e%e6%97%a5%e6%9c%9f%e6%9b%b4%e6%96%b0%e5%a4%84%e7%90%86)

### [1.自增主键](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae)

自增主键改用`smallserial`、`serial`、`bigserial`类型，由于有旧数据，需要在数据迁移完成后更新自增序列：

```
select setval('sequence_name', (select max("col_name") from employee_age));
```

serial自动创建的自增序列命名规则为 `表名_字段名_seq`，重复时会增加数字序号，如：`employee_age_employee_id_seq1`。

#### [使用自增主键同时按照自增主键排序的表：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bd%bf%e7%94%a8%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae%e5%90%8c%e6%97%b6%e6%8c%89%e7%85%a7%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae%e6%8e%92%e5%ba%8f%e7%9a%84%e8%a1%a8%ef%bc%9a)

| 表名                        | 数据量    |
| ------------------------- | ------ |
| t_quartz_job              | 60     |
| t_work_order_status_trace | 431884 |
| t_web_info                | 34941  |
| t_user_site               | 1      |
| t_autosend_history        | 202    |
| t_web_asset               | 35388  |
| t_role_type               | 8      |
| t_role                    | 25     |

### [2.UUID](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2uuid)

- 使用函数生成uuid：`gen_random_uuid()`，结果：`8667eca6-72c1-48fd-840c-34393ffa11b5`
- 创建表时字段使用uuid类型

### [3.日期更新](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e6%97%a5%e6%9c%9f%e6%9b%b4%e6%96%b0)

- 新增数据时默认值
  
  - **业务模块手动设置值（推荐）**
  
  - 根据字段类型在字段定义后添加如下语句

```
DEFAULT CURRENT_DATE;
DEFAULT CURRENT_TIME;
DEFAULT CURRENT_TIMESTAMP;
DEFAULT LOCALTIME;
DEFAULT LOCALTIME;
DEFAULT LOCALTIMESTAMP
```

例如：`"find_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP`

- 更新数据时更新值
  
  - **业务模块手动设置更新值（推荐）**
  
  - 使用触发器更新

```
1.创建函数：
CREATE 
    OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
        NEW.column_name = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$ LANGUAGE plpgsql;

2.创建触发器
CREATE TRIGGER "trigger_name" BEFORE UPDATE ON "table_name" FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
```

## [四、函数、存储过程与运算符](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%9b%9b%e3%80%81%e5%87%bd%e6%95%b0%e3%80%81%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b%e4%b8%8e%e8%bf%90%e7%ae%97%e7%ac%a6)

### [1.常用运算符对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%b8%b8%e7%94%a8%e8%bf%90%e7%ae%97%e7%ac%a6%e5%af%b9%e7%85%a7%e8%a1%a8)

| mysql运算符             | 描述          | 示例                                                        | pg运算符                         | 描述                    | 示例                                                                                                           |
| -------------------- | ----------- | --------------------------------------------------------- | ----------------------------- | --------------------- | ------------------------------------------------------------------------------------------------------------ |
| and,<br>**&&**       | 逻辑与         | 1 and 0 → 0                                               | and                           | 逻辑与                   | 1 and 0 → 0                                                                                                  |
| or,<br>**\|**        | 逻辑或         | 1 or 0 → 1                                                | or                            | 逻辑或                   | 1 or 0 → 1                                                                                                   |
| not,<br>**!**        | 逻辑非         | not 1 → 0                                                 | not                           | 逻辑非                   | not 1 → 0                                                                                                    |
| <                    | 小于          | 1 < 0 → 0                                                 | <                             | 小于                    | 1 < 0 → 0                                                                                                    |
| >                    | 大于          | 1 > 0 → 1                                                 | >                             | 大于                    | 1 > 0 → 1                                                                                                    |
| <=                   | 小于等于        | 1 <= 0 → 0                                                | <=                            | 小于等于                  | 1 <= 0 → 0                                                                                                   |
| >=                   | 小于等于        | 1 >= 0 → 1                                                | >=                            | 小于等于                  | 1 >= 0 → 1                                                                                                   |
| =                    | 等于          | 1 = 0 → 0;<br>1 = NULL → NULL.                            | =                             | 等于                    | 1 = 0 → 0;<br>1 = NULL → NULL.                                                                               |
| !=                   | 不等于         | 1 != 0 → 1                                                | !=                            | 不等于                   | 1 != 0 → 1                                                                                                   |
| <>                   | 不等于         | 1 <> 0 → 1                                                | <>                            | 不等于                   | 1 <> 0 → 1                                                                                                   |
| **<=>**              | **安全等于**    | **1 <=> 1 → 1;<br>1 <=> NULL → 0;<br>NULL <=> NULL → 1.** | **IS NOT DISTINCT FROM**      | **安全等于**              | **1 IS NOT DISTINCT FROM 1 → 1;<br>1 IS NOT DISTINCT FROM NULL → 0;<br>NULL IS NOT DISTINCT FROM NULL → 1.** |
| **not (... <=>...)** | **安全不等于**   | **----**                                                  | **IS DISTINCT FROM**          | **安全不等于**             | **----**                                                                                                     |
| BETWEEN AND          | 之间，包含端点     | 2 BETWEEN 1 AND 3 → 1;<br>2 BETWEEN 3 AND 1 → 0.          | BETWEEN AND                   | 之间，包含端点               | 2 BETWEEN 1 AND 3 → 1;<br>2 BETWEEN 3 AND 1 → 0.                                                             |
| NOT BETWEEN AND      | 不在区间内       | ----                                                      | NOT BETWEEN AND               | 不在区间内                 | ----                                                                                                         |
| **----**             | **----**    | **----**                                                  | **BETWEEN SYMMETRIC AND**     | **之间，端点排序**           | **2 BETWEEN SYMMETRIC 1 AND 3 → 1;<br>2 BETWEEN SYMMETRIC 3 AND 1 → 1.**                                     |
| **----**             | **----**    | **----**                                                  | **NOT BETWEEN SYMMETRIC AND** | **不在区间内，端点排序**        | **----**                                                                                                     |
| **IS NULL**          | **为空**      | **1.5 IS NULL → 0**                                       | **IS NULL,<br>ISNULL**        | **为空**                | **1.5 IS NULL → 0**                                                                                          |
| **IS NOT NULL**      | **不为空**     | **'null' IS NOT NULL → 1**                                | **IS NOT NULL,<br>NOTNULL**   | **不为空**               | **'null' IS NOT NULL → 1**                                                                                   |
| IS TRUE              | 测试布尔表达式是否为真 | 1 IS TRUE → 1;<br>NULL IS TRUE → 0.                       | IS TRUE                       | 测试布尔表达式是否为真           | 1::bool IS TRUE → 1;<br>NULL IS TRUE → 0.                                                                    |
| IS NOT TRUE          | 测试布尔表达式是否为假 | ----                                                      | IS NOT TRUE                   | 测试布尔表达式是否为假           | ----                                                                                                         |
| IS FALSE             | 测试布尔表达式是否为假 | ----                                                      | IS FALSE                      | 测试布尔表达式是否为假           | ----                                                                                                         |
| IS NOT FALSE         | 测试布尔表达式是否为真 | ----                                                      | IS NOT FALSE                  | 测试布尔表达式是否为真           | ----                                                                                                         |
| **----**             | **----**    | **----**                                                  | **IS UNKNOWN**                | **测试布尔表达式是否产生未知值**    | **true IS UNKNOWN → 0;<br>NULL::boolean IS UNKNOWN → t.**                                                    |
| **----**             | **----**    | **----**                                                  | **IS NOT UNKNOWN**            | **测试布尔表达式结果是否是产生布尔值** | **----**                                                                                                     |
| **^**                | **按位异或**    | **1 ^ 2 → 3**                                             | **#**                         | **按位异或**              | **1 # 2 → 3**                                                                                                |
| **----**             | **----**    | **----**                                                  | **^**                         | **求幂**                | **2 ^ 3 → 8**                                                                                                |

### [2.常用函数对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e5%af%b9%e7%85%a7%e8%a1%a8)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-3)

| mysql函数                                                                                                                  | 描述                              | 示例                                                                                                                                                                                          | pg函数                                               | 描述                                                                                                               | 示例                                                                                                                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------ | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CONV()                                                                                                                   | 进制转换                            | CONV('a',16,2) → '1010'                                                                                                                                                                     | ----                                               | 有10转16: to_hex(n)<br>其余自己实现                                                                                      | ----                                                                                                                                                                                        |
| INET_ATON()                                                                                                              | IPv4地址转为数字                      | INET_ATON('192.168.3.1') → 3232236289                                                                                                                                                       | ----                                               | 无对应函数，自己实现<br>pg有[ip](https://www.postgresql.org/docs/13/datatype-net-types.html)类型                              | ----                                                                                                                                                                                        |
| INET_NTOA()                                                                                                              | 数字转IPv4                         | INET_NTOA(3232236289) → 192.168.3.1                                                                                                                                                         | ----                                               | 无对应函数，自己实现<br>pg有ip类型：inet,cidr                                                                                  | ----                                                                                                                                                                                        |
| INET6_ATON()                                                                                                             | IPv6地址转为二进制字符串                  | HEX(inet6_aton('FE80::2DBA:7113:B2BE:2E10')) → FE800000000000002DBA7113B2BE2E10                                                                                                             | ----                                               | ----                                                                                                             | ----                                                                                                                                                                                        |
| HEX()                                                                                                                    | 十进制或字符串值的16进制表示                 | HEX(3232236289) → C0A80301                                                                                                                                                                  | to_hex                                             | 十进制或字符串值的16进制表示                                                                                                  | (3232236289) → c0a80301                                                                                                                                                                     |
| **[CONVERT(expr USING transcoding_name)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=covert_code)** | **编码转换**                        | **CONVERT('test' USING utf8) → test;<br>CONVERT(_latin1 'Müller' USING utf8) → MÃ¼ller;<br>CONVERT('test', CHAR CHARACTER SET utf8) → test.**                                               | **convert(),<br>convert_to(),<br>convert_from().** | **需组合使用，[官方文档](https://www.postgresql.org/docs/13/functions-binarystring.html)**                                 | **----**                                                                                                                                                                                    |
| CONVERT(expr,type)                                                                                                       | 类型转换                            | CONVERT('123', UNSIGNED) → 123                                                                                                                                                              | cast(),<br>expr::type_name                         | 类型转换                                                                                                             | cast('123' AS int4) → 123;<br>'123'::int4 → 123.                                                                                                                                            |
| **[CAST(expr AS type)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=cast)**                          | **类型转换**                        | **CONVERT('123' AS UNSIGNED) → 123**                                                                                                                                                        | **cast(),<br>expr::type_name**                     | **类型转换**                                                                                                         | **cast('123' AS int4) → 123;<br>'123'::int4 → 123.**                                                                                                                                        |
| **[FIND_IN_SET(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_set)**             | **集合查找**                        | **FIND_IN_SET('b','a,b,c,d') → 2**                                                                                                                                                          | **str=any(string_to_array(strlist, ','))**         | **判断strlist中是否含有str**                                                                                            | **'a' = ANY(STRING_TO_ARRAY('a,b,c', ',')) → true**                                                                                                                                         |
| concat(str1,str2,...)                                                                                                    | 字符串拼接                           | CONCAT('a','b','c') → abc                                                                                                                                                                   | \|,<br>concat(str1,str2,...)                       | 字符串拼接                                                                                                            | 'a' \| 'b' \| 'c' → abc;<br>CONCAT('a','b','c') → abc.                                                                                                                                      |
| **[group_concat()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=group_concat)**                      | **分组字符串拼接**                     | **----**                                                                                                                                                                                    | **array_to_string(array_agg(column_name),',')**    | **分组字符串拼接**                                                                                                      | **----**                                                                                                                                                                                    |
| **[DATE_FORMAT(date,format)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=date_format)**             | **日期格式化**                       | **----**                                                                                                                                                                                    | **to_char(date, [pattern](#date pattern))**        | **日期时间格式化**                                                                                                      | **to_char(now(), 'YYYY-MM-DD HH24:MI:SS') → 2022-07-21 17:12:43**                                                                                                                           |
| **[IFNULL(value1,value2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnull)**                     | **空值判断**                        | **IFNULL(NULL, '值为空') → 值为空**                                                                                                                                                               | **----**                                           | **自定义函数实现，见[ifnull(val1,val2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnull_impl)**   | **IFNULL(NULL, '值为空') → 值为空**                                                                                                                                                               |
| CURRENT_TIMESTAMP([precision])                                                                                           | 当前日期,**precision可省略**，范围[0,6]   | ----                                                                                                                                                                                        | CURRENT_TIMESTAMP(precision)                       | 当前日期,**precision不可省略**，范围[0,6]                                                                                   | ----                                                                                                                                                                                        |
| **[CURDATE()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=curdate)**                                | **获取当前日期，不包含时分秒**               | **select CURDATE() → 2022-07-26**                                                                                                                                                           | **CURRENT_DATE**                                   | **获取当前日期，不包含时分秒**                                                                                                | **SELECT CURRENT_DATE → 2022-07-26**                                                                                                                                                        |
| **[SUBSTRING_INDEX(str,delim,count)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)** | **从出现分隔符 *`str`*之前 的字符串返回子字符串** | **SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', 2) → [www.mysql](http://www.mysql/);<br>SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', -2) → mysql.com** | **-----**                                          | **自定义函数实现，见[substring_index](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)** | **substring_index('[www.mysql.com'](http://www.mysql.com'/), '.', 2) → [www.mysql](http://www.mysql/);<br>SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', -2) → mysql.com** |
| **[IF(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if)**                         | **条件判断函数**                      | **SELECT IF(1>2,2,3) → 3**                                                                                                                                                                  | **----**                                           | **自定义函数实现，见[if(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if_impl)**   | **SELECT IF(1>2,2,3) → 3**                                                                                                                                                                  |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-3)

| postgresql函数                                                                                                                                                                          | 描述       | openGauss函数                       | 描述                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | --------------------------------- | ------------------------------------------------------------------------------- |
| **convert( bytes bytea, src_encoding name, dest_encoding name) → bytea;<br>convert_from(bytes bytea, src_encoding name) → text<br>convert_to(string text,dest_encoding name) →bytea** | **编码转换** | **convert_to_nocase(text, text)** | **将字符串转换为指定的编码类型。<br>返回值类型：bytea<br>SELECT convert_to_nocase('12345', 'GBK');** |
| **----**                                                                                                                                                                              | **----** | **nvl(value1,value2)**            | **如果value1为NULL则返回value2，如果value1非NULL，则返回value1。<br>和mysql的ifnull函数功能相同。**     |

### [3.常用函数修改示例（兼容postgresql和openGauss）](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e4%bf%ae%e6%94%b9%e7%a4%ba%e4%be%8b%ef%bc%88%e5%85%bc%e5%ae%b9postgresql%e5%92%8copengauss%ef%bc%89)

#### [CONVERT(expr USING transcoding_name)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=convertexpr-using-transcoding_name)

- 业务场景：查询字典数据厂商信息，按gbk编码排序

- mysql语句：
  
  ```
  SELECT DISTINCT
      vendor 
  FROM
      t_vendor_model 
  ORDER BY
      CONVERT ( vendor USING gbk ) DESC;
  ```

- 修改建议：
  
  1. postgresql和openGauss函数不相同，无法兼容，mirror中共三处均用在排序处；
     
     取消gbk排序或者业务排序。
  
  2. 分别在postgresql和openGauss上实现convert函数。

#### [CAST(expr AS type)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=castexpr-as-type)

- 业务场景：重大保障大屏-应用保障查询，获取最后一个点访问次数

- mysql语句：
  
  ```
  SELECT
      id,
      destHostName,
      webName,
      cast( SUBSTRING_INDEX( visitCount, ',',- 1 ) AS SIGNED ) visit,
      accessRateValue,
      accessMonitor,
      accessRate 
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```

- 修改建议：
  
  示例1：
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      substring_index( "visitCount", ',',- 1 )::int  visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **说明：substring_index是自定义函数。**
  
  示例2：
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      cast(substring_index( "visitCount", ',',- 1 ) AS int4)  visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **说明：substring_index是自定义函数。**
  
  **示例3（建议）：**
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      (string_to_array("visitCount", ','))[array_length(string_to_array("visitCount", ','), 1)]::int4 visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **示例4（建议）：**
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      (string_to_array("visitCount", ','))[7]::int4 visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```

- 说明
  
  有没有发现只有id和visit没有使用双引号？**请不要使用大写字段名！！！**

#### [SUBSTRING_INDEX](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)

- 示例同[cast](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=cast)

#### [FIND_IN_SET(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_setstrstrlist)

- 业务场景：根据资产标签统计在线数量和风险数量

- mysql语句：
  
  ```
  SELECT
      COUNT( CASE WHEN r.assetState = 'online' OR r.assetOnlineMonitor = 0 THEN 1 END ) AS `online`,
      COUNT( CASE WHEN r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ) THEN 1 END ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURDATE() 
      WHERE
          FIND_IN_SET( 'AR网关', ai.asset_label ) 
      ) r;
  ```

- 修改建议：
  
  **示例1，使用any和string_to_array实现（建议）：**
  
  ```
  SELECT 
      COUNT( IF ( r.assetState = 'online' OR r.assetOnlineMonitor = 0, 1, NULL ) ) AS online,
      COUNT( IF ( r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ), 1, NULL ) ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURRENT_DATE 
      WHERE
      'AR网关' = ANY ( string_to_array( ai.asset_label, ',' ) ) 
      ) r;
  ```
  
  示例2，[自定义find_in_set(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_set_impl)函数实现：
  
  ```
  SELECT 
      COUNT( IF ( r.assetState = 'online' OR r.assetOnlineMonitor = 0, 1, NULL ) ) AS online,
      COUNT( IF ( r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ), 1, NULL ) ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURRENT_DATE 
      WHERE
          FIND_IN_SET( 'AR网关', ai.asset_label ) 
      ) r;
  ```

#### [GROUP_CONCAT()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=group_concat)

- 业务场景：查询资产的名称和所有IP标识

- mysql语句：
  
  ```
  SELECT DISTINCT
      CONCAT( tai.asset_name, '(', taid.identification, ')' ) 
  FROM
      t_asset_information tai
      LEFT JOIN 
      ( 
          SELECT 
              GROUP_CONCAT( identification ) AS identification, 
              asset_id FROM t_asset_identification 
          WHERE identification_type IN ( 'private_ip', 'public_ip' )
          GROUP BY asset_id  
      ) taid ON tai.asset_id = taid.asset_id;
  ```

- 修改建议：
  
  示例1，使用array_to_string函数和聚合函数array_agg组合实现：
  
  ```
  SELECT DISTINCT
      CONCAT( tai.asset_name, '(', taid.identification, ')' ) 
  FROM
      t_asset_information tai
      LEFT JOIN 
      ( 
          SELECT 
              array_to_string(array_agg(identification), ',') AS identification, 
              asset_id FROM t_asset_identification 
          WHERE identification_type IN ( 'private_ip', 'public_ip' )
          GROUP BY asset_id
      ) taid ON tai.asset_id = taid.asset_id;
  ```

#### [DATE_FORMAT(date,format)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=date_formatdateformat)

- 业务场景：查询工单创建操作行为记录

- mysql语句：
  
  ```
  SELECT
      serial_id,
      operater,
      operater_host_address AS operaterHostAddress,
      action AS actionCode,
      date_format( created_at, '%Y-%m-%d %H:%i:%s' ) AS operationTime,
      operater_operations AS operaterOperationsContent 
  FROM
      t_work_order_operation_history 
  ORDER BY
      operationTime ASC
  ```

- 修改建议：
  
  示例：
  
  ```
  SELECT
      serial_id,
      operater,
      operater_host_address AS operaterHostAddress,
      "action" AS actionCode,
      to_char(created_at, 'YYYY-MM-DD HH24:MI:SS') AS operationTime,
      operater_operations AS operaterOperationsContent 
  FROM
      t_work_order_operation_history 
  ORDER BY
      operationTime ASC
  ```

#### [IFNULL(value1,value2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnullvalue1value2)

- 业务场景：查询重点关注用户(根据用户表查询, 可能出现用户表里有数据, 但ueba数据信息表里没有)

- mysql语句：
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      ifnull( m.seven_days_score, 0 ) seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```

- 修改建议：
  
  **示例1（建议）：**
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      case when m.seven_days_score is NULL then 0 else m.seven_days_score end seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```
  
  示例2：
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      ifnull( m.seven_days_score, 0 ) seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```

#### [CURDATE()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=curdate)

- 业务场景：查询组织架构下高风险资产的数量

- mysql语句：
  
  ```
  SELECT
      t1.asset_id 
  FROM
      t_asset_information t1
      LEFT JOIN t_asset_rating t2 ON t1.asset_id = t2.asset_id 
  WHERE
      t2.create_time >= CURDATE() 
      AND (
      t2.asset_health_state != 'healthy')
  ```

- 修改建议：
  
  示例：
  
  ```
  SELECT
      t1.asset_id 
  FROM
      t_asset_information t1
      LEFT JOIN t_asset_rating t2 ON t1.asset_id = t2.asset_id 
  WHERE
      t2.create_time >= CURRENT_DATE 
      AND (
      t2.asset_health_state != 'healthy')
  ```

- 说明
  
  **CURRENT_DATE不是函数，不要写括号**

#### [IF(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifexpr1expr2expr3)

- 业务场景：修改资产同步配置开关

- mysql语句：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = IF (#{enable}, 1, 0)
  WHERE
      id = #{configId}
  ```

- 修改建议：
  
  示例1，使用[自定义函数if](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if_impl)实现：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = IF (#{enable}, 1, 0)
  WHERE
      id = #{configId}
  ```
  
  示例2，使用类型转换实现：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = #{enable}::int4
  WHERE
      id = #{configId}
  ```
  
  示例3，sync_asset字段改为bool类型：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = #{enable}
  WHERE
      id = #{configId}
  ```
  
  **示例4，使用case when实现（推荐）：**
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = case #{enable} when 1 then true else false end
  WHERE
      id = #{configId}
  ```

### [4.自定义函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e8%87%aa%e5%ae%9a%e4%b9%89%e5%87%bd%e6%95%b0)

- #### [创建函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%88%9b%e5%bb%ba%e5%87%bd%e6%95%b0)
  
  ##### [语法：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%af%ad%e6%b3%95%ef%bc%9a)
  
  ```
  CREATE FUNCTION somefunc(integer, text) RETURNS integer
  AS 'function body text'
  LANGUAGE plpgsql;
  ```
  
  ##### [示例：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%a4%ba%e4%be%8b%ef%bc%9a)
  
  ```
  CREATE FUNCTION my_add ( n1 INTEGER, n2 INTEGER ) RETURNS INTEGER AS $$ BEGIN
      RETURN n1 + n2;
  END $$ LANGUAGE plpgsql;
  ```

- #### [调用函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%b0%83%e7%94%a8%e5%87%bd%e6%95%b0)
  
  ```
  select my_add(1,2);
  ```

### [4.存储过程](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b)

- #### [创建存储过程](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%88%9b%e5%bb%ba%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b)
  
  ##### [示例：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%a4%ba%e4%be%8b%ef%bc%9a-1)
  
  ```
  CREATE PROCEDURE triple(INOUT x int)
  LANGUAGE plpgsql
  AS $$
  BEGIN
      x := x * 3;
  END;
  $$;
  ```

- #### [调用](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%b0%83%e7%94%a8)
  
  ```
  call triple(3);
  ```

- ### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%ae%98%e6%96%b9%e6%96%87%e6%a1%a3)[官方文档](https://www.postgresql.org/docs/13/plpgsql-control-structures.html#PLPGSQL-STATEMENTS-RETURNING-PROCEDURE)

$$ 不推荐使用存储过程 $$

## [五、触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%ba%94%e3%80%81%e8%a7%a6%e5%8f%91%e5%99%a8)

### [1.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%a7%a6%e5%8f%91%e5%99%a8)[触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%a7%a6%e5%8f%91%e5%99%a8)

### [2.事件触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e4%ba%8b%e4%bb%b6%e8%a7%a6%e5%8f%91%e5%99%a8)

为了补充[第 38 章](https://www.postgresql.org/docs/13/triggers.html)中讨论的触发机制，PostgreSQL还提供了事件触发器。与附加到单个表并仅捕获 DML 事件的常规触发器不同，事件触发器对特定数据库是全局的，并且能够捕获 DDL 事件。

与常规触发器一样，事件触发器可以用任何包括事件触发器支持的过程语言编写，也可以用 C 编写，但不能用普通 SQL 编写。

参见[事件触发器](https://www.postgresql.org/docs/13/event-triggers.html)

## [六、建表语句修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%85%ad%e3%80%81%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)

可以使用navicat帮我们转换成postgresql语句，但是会有一些问题；

### [1.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%bb%ba%e8%a1%a8%e8%af%ad%e6%b3%95)[建表语法](https://www.postgresql.org/docs/13/sql-createtable.html)

```
CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name ( [
  { column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
    | table_constraint
    | LIKE source_table [ like_option ... ] }
    [, ... ]
] )
[ INHERITS ( parent_table [, ... ] ) ]
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]

CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
    OF type_name [ (
  { column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
    | table_constraint }
    [, ... ]
) ]
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]

CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
    PARTITION OF parent_table [ (
  { column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
    | table_constraint }
    [, ... ]
) ] { FOR VALUES partition_bound_spec | DEFAULT }
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]
```

### [2.字段和表的引用修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e5%ad%97%e6%ae%b5%e5%92%8c%e8%a1%a8%e7%9a%84%e5%bc%95%e7%94%a8%e4%bf%ae%e6%94%b9)

```
`table_name` 改为 "table_name"
`column_name` 改为 "column_name"
```

### [3.主键策略修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e4%b8%bb%e9%94%ae%e7%ad%96%e7%95%a5%e4%bf%ae%e6%94%b9)

参见[自增主键](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae)和[UUID](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=uuid)

### [4.字段类型修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e5%ad%97%e6%ae%b5%e7%b1%bb%e5%9e%8b%e4%bf%ae%e6%94%b9)

参见[常用数据类型映射](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b%e6%98%a0%e5%b0%84)

### [5.字符串修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5%e5%ad%97%e7%ac%a6%e4%b8%b2%e4%bf%ae%e6%94%b9)

- 字符串标识由双引号修改为单引号;
  
  例如：
  
  ```
  mysql: SELECT "字符串" str;
  postgresql: SELECT '字符串' str;
  ```

- char(n),varchar(n)类型，存储中文的，n要乘以4兼容openGauss

### [6.字段和表注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6%e5%ad%97%e6%ae%b5%e5%92%8c%e8%a1%a8%e6%b3%a8%e9%87%8a)

- #### [字段注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%ad%97%e6%ae%b5%e6%b3%a8%e9%87%8a)
  
  mysql字段注释紧跟字段后面，pg字段注释是单独的sql语句；
  
  ps语法：`COMMENT ON COLUMN "table_name"."column_name" IS '字段注释';`

- #### [表注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%a1%a8%e6%b3%a8%e9%87%8a)
  
  mysql表注释紧跟在表后面，pg表注释是单独的sql语句；
  
  pg语法：`COMMENT ON TABLE "table_name" IS '表注释';`

### [7.触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_7%e8%a7%a6%e5%8f%91%e5%99%a8)

1. 定义表
   
   创建需要触发器的表，例如：
   
   ```
   CREATE TABLE ttest (
      "id" serial primary key,
        "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
   );
   ```

2. 编写触发函数
   
   - 触发函数支持的语言：`PL/pgSQL`
   
   - 触发函数示例
     
     pgsql示例：
     
     ```
     CREATE 
        OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
            NEW.update_time = CURRENT_TIMESTAMP;
        RETURN NEW;
     END $$ LANGUAGE plpgsql;
     ```

3. 声明触发器
   
   ```
   --操作之前填充更新时间:
   CREATE TRIGGER before_trigger BEFORE UPDATE ON ttest
          FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
   
   --操作之前执行:
   CREATE TRIGGER tbefore BEFORE INSERT OR UPDATE OR DELETE ON ttest
      FOR EACH ROW EXECUTE FUNCTION trigf();
   
   --操作之后执行:
   CREATE TRIGGER tafter AFTER INSERT OR UPDATE OR DELETE ON ttest
      FOR EACH ROW EXECUTE FUNCTION trigf();
   ```

4. [触发器官方文档](https://www.postgresql.org/docs/13/trigger-definition.html)

### [8.索引](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_8%e7%b4%a2%e5%bc%95)

pg创建索引语法：

```
CREATE INDEX name ON table [USING index_type] (column [collation] [asc || desc] [NULLS] [LAST || FIRST]);
```

mysql中的key对应pg中create index，例如：

```
mysql:
CREATE TABLE ttest (
    `id` int(11) PRIMARY KEY,
      `code` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        KEY `idx_code` (`code`) USING BTREE
);

postgresql:
CREATE TABLE ttest (
    "id" int PRIMARY KEY,
      "code" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_code ON ttest USING btree ("code" ASC NULLS FIRST);
```

**注意：mysql创建的索引默认null在最后，pg可以指定，不指定默认为 ASC NULLS LAST。**

### [9.字段、数据库命名](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_9%e5%ad%97%e6%ae%b5%e3%80%81%e6%95%b0%e6%8d%ae%e5%ba%93%e5%91%bd%e5%90%8d)

- 将包含大写的字段修改为下划线命名

- database名字按照标识符命名规则重新命名，openGauss不支持中划线命名
  
  如：bigdata-web→bigdata_web

### [10.完整示例](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_10%e5%ae%8c%e6%95%b4%e7%a4%ba%e4%be%8b)

```
mysql:
CREATE TABLE `t_asset_information` (
  `asset_id` VARCHAR ( 100 ) NOT NULL COMMENT '资产ID-资产唯一标识',
    `asset_name` VARCHAR ( 100 ) NOT NULL COMMENT '资产名称-便于查看及识别',
     PRIMARY KEY ( `asset_id` ) 
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT='资产信息表';

CREATE TABLE `t_asset_monitor_port_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `asset_id` varchar(100) DEFAULT NULL COMMENT '资产ID-资产唯一标识',
  `asset_ip` varchar(45) NOT NULL COMMENT '资产ip',
  `port` varchar(45) NOT NULL COMMENT '端口',
  `protocol` varchar(100) DEFAULT NULL COMMENT '协议',
  `service_name` varchar(500) DEFAULT NULL COMMENT '服务名',
  `server_version` varchar(500) DEFAULT NULL COMMENT '服务版本',
  `status` char(1) NOT NULL COMMENT '端口状态，1：开启，0：关闭',
  `message` varchar(255) DEFAULT NULL COMMENT '描述信息',
  `find_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发现时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `source` varchar(100) DEFAULT NULL COMMENT '端口来源 AiNTA',
  `fingerprint_name` varchar(100) DEFAULT NULL COMMENT '指纹名称',
  `fingerprint_class2` varchar(100) DEFAULT NULL COMMENT '指纹二级类型（指纹类型）',
  `vendor_name` varchar(100) DEFAULT NULL COMMENT '厂商：中文名（英文名）',
  `tag` text COMMENT '产品标签',
  PRIMARY KEY (`id`),
  KEY `idx_asset_ip` (`asset_ip`) USING BTREE,
  UNIQUE KEY `unique_asset_id_asset_ip_port` (`asset_id`,`asset_ip`,`port`),
  CONSTRAINT `foreign_key_monitor_port_info_to_asset_id_4` FOREIGN KEY (`asset_id`) REFERENCES `t_asset_information` (`asset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主机资产-端口';

postgresql:
CREATE TABLE "t_asset_information" (
 "asset_id" VARCHAR ( 100 ) PRIMARY KEY,
    "asset_name" VARCHAR ( 400 )
);
COMMENT ON COLUMN "t_asset_information"."asset_id" IS '资产ID-资产唯一标识';
COMMENT ON COLUMN "t_asset_information"."asset_name" IS '资产名称-便于查看及识别';
COMMENT ON TABLE "t_asset_information" IS '资产信息表';

CREATE TABLE "t_asset_monitor_port_info" (
    "id" bigserial NOT NULL,
    "asset_id" VARCHAR ( 100 ) DEFAULT NULL,
    "asset_ip" VARCHAR ( 45 ) NOT NULL,
    "port" VARCHAR ( 45 ) NOT NULL,
    "protocol" VARCHAR ( 100 ) DEFAULT NULL,
    "service_name" VARCHAR ( 2000 ) DEFAULT NULL,
    "server_version" VARCHAR ( 500 ) DEFAULT NULL,
    "status" "char" NOT NULL,
    "message" VARCHAR ( 1020 ) DEFAULT NULL,
    "find_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "create_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "source" VARCHAR ( 100 ) DEFAULT NULL,
    "fingerprint_name" VARCHAR ( 400 ) DEFAULT NULL,
    "fingerprint_class2" VARCHAR ( 400 ) DEFAULT NULL,
    "vendor_name" VARCHAR ( 400 ) DEFAULT NULL,
    "tag" TEXT,
    PRIMARY KEY ( "id" ),
    CONSTRAINT "unique_asset_id_asset_ip_port" UNIQUE ( "asset_id", "asset_ip", "port" ),
    CONSTRAINT "foreign_key_monitor_port_info_to_asset_id" FOREIGN KEY ( "asset_id" ) REFERENCES "t_asset_information" ( "asset_id" ) ON DELETE CASCADE ON UPDATE CASCADE 
);
CREATE INDEX "idx_asset_ip" ON "t_asset_monitor_port_info" USING btree ("asset_ip" ASC NULLS FIRST);
COMMENT ON COLUMN "t_asset_monitor_port_info"."id" IS '主键Id';
COMMENT ON COLUMN "t_asset_monitor_port_info"."asset_id" IS '资产ID-资产唯一标识';
COMMENT ON COLUMN "t_asset_monitor_port_info"."asset_ip" IS '资产ip';
COMMENT ON COLUMN "t_asset_monitor_port_info"."port" IS '端口';
COMMENT ON COLUMN "t_asset_monitor_port_info"."protocol" IS '协议';
COMMENT ON COLUMN "t_asset_monitor_port_info"."service_name" IS '服务名';
COMMENT ON COLUMN "t_asset_monitor_port_info"."server_version" IS '服务版本';
COMMENT ON COLUMN "t_asset_monitor_port_info"."status" IS '端口状态，1：开启，0：关闭';
COMMENT ON COLUMN "t_asset_monitor_port_info"."message" IS '描述信息';
COMMENT ON COLUMN "t_asset_monitor_port_info"."find_time" IS '发现时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."update_time" IS '修改时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."source" IS '端口来源 AiNTA';
COMMENT ON COLUMN "t_asset_monitor_port_info"."fingerprint_name" IS '指纹名称';
COMMENT ON COLUMN "t_asset_monitor_port_info"."fingerprint_class2" IS '指纹二级类型（指纹类型）';
COMMENT ON COLUMN "t_asset_monitor_port_info"."vendor_name" IS '厂商：中文名（英文名）';
COMMENT ON COLUMN "t_asset_monitor_port_info"."tag" IS '产品标签';
COMMENT ON TABLE "t_asset_monitor_port_info" IS '主机资产-端口';

CREATE 
    OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
        NEW.update_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER "t_asset_monitor_port_info_upd_trigger" BEFORE UPDATE ON "t_asset_monitor_port_info" FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
```

## [七、事件替换](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%83%e3%80%81%e4%ba%8b%e4%bb%b6%e6%9b%bf%e6%8d%a2)

postgresql只有事件触发器，不包含定时触发，mysql事件改为代码实现。

## [八、视图处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%85%ab%e3%80%81%e8%a7%86%e5%9b%be%e5%a4%84%e7%90%86)

### [1.视图语法](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%a7%86%e5%9b%be%e8%af%ad%e6%b3%95)

```
CREATE TABLE myview (same column list as mytab);
ALTER TABLE myview OWNER TO "user_name";
```

### [2.示例](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e7%a4%ba%e4%be%8b)

```
CREATE VIEW "asset_port" AS  SELECT t_asset_monitor_port_info.id,
    t_asset_monitor_port_info.asset_id,
    t_asset_monitor_port_info.asset_ip,
    t_asset_monitor_port_info.port,
    t_asset_monitor_port_info.protocol,
    t_asset_monitor_port_info.status
   FROM test.t_asset_monitor_port_info;

ALTER TABLE "asset_port" OWNER TO "postgres";
```

### [3.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%ae%98%e6%96%b9%e6%96%87%e6%a1%a3)[官方文档](https://www.postgresql.org/docs/13/rules-views.html)

## [九、分表处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b9%9d%e3%80%81%e5%88%86%e8%a1%a8%e5%a4%84%e7%90%86)

使用分区功能实现分表，表分区通过继承实现，可以单独查询分区表数据，也可以查询主分区，主分区包含全部分区数据，可以通过trigger和check来约束分区，同时插入数据时不指定具体分区插入到主分区，由trigger来完成分区。

[详见官网](https://www.postgresql.org/docs/13/ddl-partitioning.html)

**openGauss不支持继承**

## [十、数据迁移](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e3%80%81%e6%95%b0%e6%8d%ae%e8%bf%81%e7%a7%bb)

### [1.简介](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e7%ae%80%e4%bb%8b)

由于mysql导出的导出sql类型的数据，sql中表名和字段名的表示方式不同，不推荐sql文件形式导入。

### [2.csv导入](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2csv%e5%af%bc%e5%85%a5)

- #### [从mysql导出csv文件](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bb%8emysql%e5%af%bc%e5%87%bacsv%e6%96%87%e4%bb%b6)
  
  ```
  select * from t_asset_monitor_port_info into outfile "/var/lib/mysql-files/t_asset_monitor_port_info.csv" character set utf8 fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';
  ```

- #### [导入csv到postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%af%bc%e5%85%a5csv%e5%88%b0postgresql)
  
  ```
  copy t_asset_monitor_port_info 
  from '/var/lib/mysql-files/t_asset_monitor_port_info.csv' 
  DELIMITER ','
  CSV;
  ```

### [3.datax导入](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3datax%e5%af%bc%e5%85%a5)

[datax官网](https://github.com/alibaba/DataX/blob/master/introduction.md)

## [十一、修改项目配置](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%b8%80%e3%80%81%e4%bf%ae%e6%94%b9%e9%a1%b9%e7%9b%ae%e9%85%8d%e7%bd%ae)

### [1.pom.xml](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1pomxml)

新增postgresql驱动依赖

```
<dependency>
  <groupId>org.postgresql</groupId>
  <artifactId>postgresql</artifactId>
</dependency>
```

### [2.application.properties](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2applicationproperties)

修改数据库连接信息和驱动

```
spring.datasource.driver-class-name=org.postgresql.Driver
```

## [十二、SQL修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%ba%8c%e3%80%81sql%e4%bf%ae%e6%94%b9)

### [1.参考](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%8f%82%e8%80%83%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)[建表语句修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)

### [2.insert冲突处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2insert%e5%86%b2%e7%aa%81%e5%a4%84%e7%90%86)

```
mysql:
INSERT INTO t_asset_information ( asset_id, asset_name, org_id, net_id )
VALUES
    ( 'asset_00008519-b728-4b00-857a-9be4e4cf537d_1657273055277', '10.2.51.88', '12bbcbcf-d8e8-4009-a8ba-a043f96f5ae8', '12bbcbcf-d8e8-4009-a8ba-a043f96f5ae8' ) 
    ON DUPLICATE KEY UPDATE asset_name = '10.2.51.88';

postgresql:
INSERT INTO "t_asset_information" ( "asset_id", "asset_name" )
VALUES
    ( 'asset_00008519-b728-4b00-857a-9be4e4cf537d_1657273055277', '10.2.51.88' ) ON CONFLICT ( asset_id ) DO
UPDATE 
    SET asset_name = '10.2.51.65';
```

### [3.schema处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3schema%e5%a4%84%e7%90%86)

**postgresql未指定schema时默认查询public，如果使用的非public，请指定schema。**

- 实体类
  
  ```
  @TableName(value="test.t_asset_monitor_port_info")
  或者
  @TableName(value="t_asset_monitor_port_info", schema="test")
  ```

- sql
  
  ```
  SELECT ID
      ,
      asset_id,
      asset_ip,
      port,
      protocol,
      service_name,
      server_version,
      status,
      message,
      find_time,
      create_time,
      update_time,
      SOURCE,
      fingerprint_name,
      fingerprint_class2,
      vendor_name,
      tag 
  FROM
      test.t_asset_monitor_port_info
  ```

### [4.运算符修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e8%bf%90%e7%ae%97%e7%ac%a6%e4%bf%ae%e6%94%b9)

​ [运算符对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e8%bf%90%e7%ae%97%e7%ac%a6%e5%af%b9%e7%85%a7%e8%a1%a8)

### [5.函数修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5%e5%87%bd%e6%95%b0%e4%bf%ae%e6%94%b9)

​ [常用函数对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e5%af%b9%e7%85%a7%e8%a1%a8)

### [6.group by和order by](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6group-by%e5%92%8corder-by)

​ postgresql的order by字段必须出现在select后面；

​ postgresql的group by语句中select字段必须出现在group by后面或者使用聚合函数。

## [十三、涉及组件](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%b8%89%e3%80%81%e6%b6%89%e5%8f%8a%e7%bb%84%e4%bb%b6)

### [1.flywaydb](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1flywaydb)

[官方文档](https://flywaydb.org/documentation/)显示支持postgresql，但是不支持openGauss，需要测试语法兼容openGauss的情况下能不能正常使用。

### [2.nacos](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2nacos)

nacos不支持postgresql和openGauss；

#### [建议：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%bb%ba%e8%ae%ae%ef%bc%9a)

1. 使用内置数据源
2. 使用java agent，不支持openGauss，地址:https://github.com/siaron/mysql2postgresql-jdbc-agent

## [十四、集群方式](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e5%9b%9b%e3%80%81%e9%9b%86%e7%be%a4%e6%96%b9%e5%bc%8f)

### [1.citus](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1citus)

Citus 是 Postgres 的一个**开源扩展**，它在集群中的多个节点上分布数据和查询。因为 Citus 是 Postgres 的扩展（**不是 fork**），所以当您使用 Citus 时，您也在使用 Postgres。您可以利用最新的 Postgres 功能、工具和生态系统。

Citus 将 Postgres 转换为具有分片、分布式 SQL 引擎、引用表和分布式表等功能的分布式数据库。Citus 将并行性、在内存中保留更多数据和更高的 I/O 带宽相结合，可以显着提高多租户 SaaS 应用程序、面向客户的实时分析仪表板和时间序列工作负载的性能。

- #### [优点](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bc%98%e7%82%b9)
  
  文档丰富；
  
  开源；
  
  只是PostgreSQL的一个extension；
  
  横向扩展方便；
  
  支持常用DDL；
  
  支持实时增删改查；
  
  支持聚合下推；
  
  支持分布式事务；
  
  支持并行查询。

- #### [缺点](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%bc%ba%e7%82%b9)
  
  多语句事务没有防止死锁的安全措施；
  
  没有针对中间查询失败和由此产生的不一致的安全措施；
  
  查询结果缓存在内存中；这些函数不能处理非常大的结果集；
  
  如果无法连接到节点，这些函数会提前出错；
  
  SQL限制。

- #### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=citus%e5%ae%98%e7%bd%91)[citus官网](https://docs.citusdata.com/en/v11.0/?_gl=1*1i2q6bs*_ga*MjcwMDQ1NzI5LjE2NTg3MzI0MjM.*_ga_DS5S1RKEB7*MTY1ODczMjQyMy4xLjEuMTY1ODczMjQ0Ny4w)

- #### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=sql%e5%92%8c%e8%a7%a3%e5%86%b3%e6%96%b9%e6%b3%95)[SQL和解决方法](https://docs.citusdata.com/en/v11.0/develop/reference_workarounds.html#)

### [2.Patroni + Etcd](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2patroni-etcd)

基于 [Patroni](https://patroni.readthedocs.io/en/latest/index.html) + [Etcd](https://etcd.io/docs/v3.4.0/) 的高可用方案，此方案使用Patroni管理本地库，并结合Etcd作为数据存储和主节点选举。

Patroni基于Python开发的模板，结合DCS(例如 ZooKeeper, etcd, Consul )可以定制PostgreSQL高可用方案。 Patroni并不是一套拿来即用的PostgreSQL高可用组件，涉及较多的配置和定制工作，Patroni 本身使用的数据同步方式是postgresql的流复制方式，默认的情况我们还是使用异步的方式，在Patroni 中会有一个参数，Maximum_lag_on_failover ,通过设置，保证从库在与主库超过一定数据不同步的情况下，不会发生相关的主从转移。 Patroni接管PostgreSQL数据库的启停，同时监控本地的PostgreSQL数据库，并将本地的PostgreSQL数据库信息写入DCS。 Patroni的主备端是通过是否能获得 leader key 来控制的，获取到了leader key的Patroni为主节点，其它的为备节点。

Etcd是一款基于Raft算法和协议开发的分布式 key-value 数据库，基于Go语言编写，Patroni监控本地的PostgreSQL状态，并将相关信息写入Etcd，每个Patroni都能读写Etcd上的key，从而获取外地PostgreSQL数据库信息。

- 优点
  
  健壮性: 使用分布式key-value数据库作为数据存储，主节点故障时进行主节点重新选举，具有很强的健壮性；
  
  支持主备延迟设置: 可以设置备库延迟主库WAL的字节数，当备库延迟大于指定值时不做故障切换；
  
  自动化程度高：
  
  1. 支持自动化初始PostgreSQL实例并部署流复制;
  2. 当备库实例关闭后，支持自动拉起;
  3. 当主库实例关闭后，首先会尝试自动拉起;
  4. 支持switchover命令，能自动将老的主库进行角色转换。
  
  避免脑裂: 数据库信息记录到 ETCD 中，通过优化部署策略（多机房部署、增加实例数)可以避免脑裂。

- 缺点
  
  搭建繁琐，需要安装不同的组件，及配置项；
  
  无组合使用的官方文档；
  
  读写需要访问不同的接口。

## [十五、附录](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%ba%94%e3%80%81%e9%99%84%e5%bd%95)

### [1.postgresql类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1postgresql%e7%b1%bb%e5%9e%8b)

| Name                                          | Aliases                      | Description                                                        |
| --------------------------------------------- | ---------------------------- | ------------------------------------------------------------------ |
| `bigint`                                      | `int8`                       | signed eight-byte integer                                          |
| `bigserial`                                   | `serial8`                    | autoincrementing eight-byte integer                                |
| `bit [ (*`n`*) ]`                             |                              | fixed-length bit string                                            |
| `bit varying [ (*`n`*) ]`                     | `varbit [ (*`n`*) ]`         | variable-length bit string                                         |
| `boolean`                                     | `bool`                       | logical Boolean (true/false)                                       |
| `box`                                         |                              | rectangular box on a plane                                         |
| `bytea`                                       |                              | binary data (“byte array”)                                         |
| `character [ (*`n`*) ]`                       | `char [ (*`n`*) ]`           | fixed-length character string                                      |
| `character varying [ (*`n`*) ]`               | `varchar [ (*`n`*) ]`        | variable-length character string                                   |
| `cidr`                                        |                              | IPv4 or IPv6 network address                                       |
| `circle`                                      |                              | circle on a plane                                                  |
| `date`                                        |                              | calendar date (year, month, day)                                   |
| `double precision`                            | `float8`                     | double precision floating-point number (8 bytes)                   |
| `inet`                                        |                              | IPv4 or IPv6 host address                                          |
| `integer`                                     | `int`, `int4`                | signed four-byte integer                                           |
| `interval [ *`fields`* ] [ (*`p`*) ]`         |                              | time span                                                          |
| `json`                                        |                              | textual JSON data                                                  |
| `jsonb`                                       |                              | binary JSON data, decomposed                                       |
| `line`                                        |                              | infinite line on a plane                                           |
| `lseg`                                        |                              | line segment on a plane                                            |
| `macaddr`                                     |                              | MAC (Media Access Control) address                                 |
| `macaddr8`                                    |                              | MAC (Media Access Control) address (EUI-64 format)                 |
| `money`                                       |                              | currency amount                                                    |
| `numeric [ (*`p`*, *`s`*) ]`                  | `decimal [ (*`p`*, *`s`*) ]` | exact numeric of selectable precision                              |
| `path`                                        |                              | geometric path on a plane                                          |
| `pg_lsn`                                      |                              | PostgreSQL Log Sequence Number                                     |
| `pg_snapshot`                                 |                              | user-level transaction ID snapshot                                 |
| `point`                                       |                              | geometric point on a plane                                         |
| `polygon`                                     |                              | closed geometric path on a plane                                   |
| `real`                                        | `float4`                     | single precision floating-point number (4 bytes)                   |
| `smallint`                                    | `int2`                       | signed two-byte integer                                            |
| `smallserial`                                 | `serial2`                    | autoincrementing two-byte integer                                  |
| `serial`                                      | `serial4`                    | autoincrementing four-byte integer                                 |
| `text`                                        |                              | variable-length character string                                   |
| `time [ (*`p`*) ] [ without time zone ]`      |                              | time of day (no time zone)                                         |
| `time [ (*`p`*) ] with time zone`             | `timetz`                     | time of day, including time zone                                   |
| `timestamp [ (*`p`*) ] [ without time zone ]` |                              | date and time (no time zone)                                       |
| `timestamp [ (*`p`*) ] with time zone`        | `timestamptz`                | date and time, including time zone                                 |
| `tsquery`                                     |                              | text search query                                                  |
| `tsvector`                                    |                              | text search document                                               |
| `txid_snapshot`                               |                              | user-level transaction ID snapshot (deprecated; see `pg_snapshot`) |
| `uuid`                                        |                              | universally unique identifier                                      |
| `xml`                                         |                              | XML data                                                           |

### [2.postgresql日期pattern](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2postgresql%e6%97%a5%e6%9c%9fpattern)

| Pattern                          | Description                                                                                                                                               |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `HH`                             | hour of day (01–12)                                                                                                                                       |
| `HH12`                           | hour of day (01–12)                                                                                                                                       |
| `HH24`                           | hour of day (00–23)                                                                                                                                       |
| `MI`                             | minute (00–59)                                                                                                                                            |
| `SS`                             | second (00–59)                                                                                                                                            |
| `MS`                             | millisecond (000–999)                                                                                                                                     |
| `US`                             | microsecond (000000–999999)                                                                                                                               |
| `FF1`                            | tenth of second (0–9)                                                                                                                                     |
| `FF2`                            | hundredth of second (00–99)                                                                                                                               |
| `FF3`                            | millisecond (000–999)                                                                                                                                     |
| `FF4`                            | tenth of a millisecond (0000–9999)                                                                                                                        |
| `FF5`                            | hundredth of a millisecond (00000–99999)                                                                                                                  |
| `FF6`                            | microsecond (000000–999999)                                                                                                                               |
| `SSSS`, `SSSSS`                  | seconds past midnight (0–86399)                                                                                                                           |
| `AM`, `am`, `PM` or `pm`         | meridiem indicator (without periods)                                                                                                                      |
| `A.M.`, `a.m.`, `P.M.` or `p.m.` | meridiem indicator (with periods)                                                                                                                         |
| `Y,YYY`                          | year (4 or more digits) with comma                                                                                                                        |
| `YYYY`                           | year (4 or more digits)                                                                                                                                   |
| `YYY`                            | last 3 digits of year                                                                                                                                     |
| `YY`                             | last 2 digits of year                                                                                                                                     |
| `Y`                              | last digit of year                                                                                                                                        |
| `IYYY`                           | ISO 8601 week-numbering year (4 or more digits)                                                                                                           |
| `IYY`                            | last 3 digits of ISO 8601 week-numbering year                                                                                                             |
| `IY`                             | last 2 digits of ISO 8601 week-numbering year                                                                                                             |
| `I`                              | last digit of ISO 8601 week-numbering year                                                                                                                |
| `BC`, `bc`, `AD` or `ad`         | era indicator (without periods)                                                                                                                           |
| `B.C.`, `b.c.`, `A.D.` or `a.d.` | era indicator (with periods)                                                                                                                              |
| `MONTH`                          | full upper case month name (blank-padded to 9 chars)                                                                                                      |
| `Month`                          | full capitalized month name (blank-padded to 9 chars)                                                                                                     |
| `month`                          | full lower case month name (blank-padded to 9 chars)                                                                                                      |
| `MON`                            | abbreviated upper case month name (3 chars in English, localized lengths vary)                                                                            |
| `Mon`                            | abbreviated capitalized month name (3 chars in English, localized lengths vary)                                                                           |
| `mon`                            | abbreviated lower case month name (3 chars in English, localized lengths vary)                                                                            |
| `MM`                             | month number (01–12)                                                                                                                                      |
| `DAY`                            | full upper case day name (blank-padded to 9 chars)                                                                                                        |
| `Day`                            | full capitalized day name (blank-padded to 9 chars)                                                                                                       |
| `day`                            | full lower case day name (blank-padded to 9 chars)                                                                                                        |
| `DY`                             | abbreviated upper case day name (3 chars in English, localized lengths vary)                                                                              |
| `Dy`                             | abbreviated capitalized day name (3 chars in English, localized lengths vary)                                                                             |
| `dy`                             | abbreviated lower case day name (3 chars in English, localized lengths vary)                                                                              |
| `DDD`                            | day of year (001–366)                                                                                                                                     |
| `IDDD`                           | day of ISO 8601 week-numbering year (001–371; day 1 of the year is Monday of the first ISO week)                                                          |
| `DD`                             | day of month (01–31)                                                                                                                                      |
| `D`                              | day of the week, Sunday (`1`) to Saturday (`7`)                                                                                                           |
| `ID`                             | ISO 8601 day of the week, Monday (`1`) to Sunday (`7`)                                                                                                    |
| `W`                              | week of month (1–5) (the first week starts on the first day of the month)                                                                                 |
| `WW`                             | week number of year (1–53) (the first week starts on the first day of the year)                                                                           |
| `IW`                             | week number of ISO 8601 week-numbering year (01–53; the first Thursday of the year is in week 1)                                                          |
| `CC`                             | century (2 digits) (the twenty-first century starts on 2001-01-01)                                                                                        |
| `J`                              | Julian Date (integer days since November 24, 4714 BC at local midnight; see [Section B.7](https://www.postgresql.org/docs/13/datetime-julian-dates.html)) |
| `Q`                              | quarter                                                                                                                                                   |
| `RM`                             | month in upper case Roman numerals (I–XII; I=January)                                                                                                     |
| `rm`                             | month in lower case Roman numerals (i–xii; i=January)                                                                                                     |
| `TZ`                             | upper case time-zone abbreviation (only supported in `to_char`)                                                                                           |
| `tz`                             | lower case time-zone abbreviation (only supported in `to_char`)                                                                                           |
| `TZH`                            | time-zone hours                                                                                                                                           |
| `TZM`                            | time-zone minutes                                                                                                                                         |
| `OF`                             | time-zone offset from UTC (only supported in `to_char`)                                                                                                   |

### [3.substring_index()实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3substring_index%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION substring_index ( VARCHAR, VARCHAR, INTEGER ) RETURNS VARCHAR AS $$ DECLARE
    tokens VARCHAR [];
len INTEGER;
indexnum INTEGER;
BEGIN
    tokens := string_to_array( $1, $2 );
    len := array_upper( tokens, 1 );
    indexnum := len - ( $3 * - 1 ) + 1;
    IF
        $3 >= 0 THEN
            RETURN array_to_string( tokens [ 1 :$3 ], $2 );
        ELSE RETURN array_to_string( tokens [ indexnum : len ], $2 );
    END IF;
END;
$$ LANGUAGE PLPGSQL;
```

### [4.if(expr1,expr2,expr3)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4ifexpr1expr2expr3%e5%ae%9e%e7%8e%b0)

```
CREATE 
OR REPLACE FUNCTION
IF
    ( expr1 anyelement, expr2 anyelement, expr3 anyelement ) RETURNS anyelement AS $$ BEGIN
    IF
        expr1::BOOLEAN THEN
            RETURN expr2;
        ELSE RETURN expr3;
    END IF;
END;
$$ LANGUAGE plpgsql;
```

### [5.ifnull(val1,val2)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5ifnullval1val2%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION ifnull ( val1 anyelement, val2 anyelement ) RETURNS anyelement AS $$ BEGIN
    IF
        val1 IS NULL THEN
            RETURN val2;
        ELSE RETURN val1;
    END IF;
END;
$$ LANGUAGE plpgsql;
```

### [6.find_in_set(str,strlist)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6find_in_setstrstrlist%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION find_in_set ( str VARCHAR, strlist VARCHAR ) RETURNS BOOLEAN AS $$ BEGIN
        RETURN array_position ( string_to_array( strlist, ',' ), str ) > 0;
END;
$$ LANGUAGE plpgsql;
```

**注意：该函数返回值为boolean类型**# [数据库切换PG方案](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e6%95%b0%e6%8d%ae%e5%ba%93%e5%88%87%e6%8d%a2pg%e6%96%b9%e6%a1%88)

## [一、版本选择](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%80%e3%80%81%e7%89%88%e6%9c%ac%e9%80%89%e6%8b%a9)

### [各版本对比：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%90%84%e7%89%88%e6%9c%ac%e5%af%b9%e6%af%94%ef%bc%9a)

| 版本    | 最新版本   | 最新发布日期     | 停更时间       | 重要变化                                                                                                                                                                                                                 | 官网介绍                                                    |
| ----- | ------ | ---------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| 9.6.X | 9.6.24 | 2021-11-11 | 2021-11-11 | 1.**支持并行查询**<br>2.**允许同步复制**<br>3.**热备份**<br>4.继承式分区                                                                                                                                                                 | [9.6.0](https://www.postgresql.org/docs/release/9.6.0/) |
| 10.X  | 10.23  | 2022-11-10 | 2022-11-10 | 1.内置分区表<br>2.逻辑复制<br>3.**并行功能增强**                                                                                                                                                                                    | [10.0](https://www.postgresql.org/docs/release/10.0/)   |
| 11.X  | 11.22  | 2023-11-09 | 2023-11-09 | 1.新增哈希分区<br>2.基于的分区表创建索引<br>3.支持update分区<br>4.会创建一个默认default分区<br>5.分区支持创建主键，外键，索引，触发器                                                                                                                               | [11.0](https://www.postgresql.org/docs/release/11.0/)   |
| 12.X  | 12.19  | 2024-05-09 | --         | 1.**支持[SQL/JSON路径](https://www.postgresql.org/docs/12/functions-json.html#FUNCTIONS-SQLJSON-PATH)语言**<br>2.一般性能改进<br>3.[使用GSSAPI](https://www.postgresql.org/docs/12/gssapi-auth.html)身份验证时的 TCP/IP 连接加密             | [12.0](https://www.postgresql.org/docs/release/12.0/)   |
| 13.X  | 13.15  | 2024-05-09 | --         | 1.新增gen_random_uuid()函数<br>2.提高了使用聚合或分区表的查询的性能<br>3.从 B 树索引条目的重复数据删除中节省空间并提高性能                                                                                                                                       | [13.0](https://www.postgresql.org/docs/release/13.0/)   |
| 14.X  | 14.12  | 2024-05-09 | --         | 1.对并行查询、高度并发的工作负载、分区表、逻辑复制和清理进行了许多性能改进<br>2.B-tree 索引更新的管理效率更高，从而减少了索引膨胀<br>3.`VACUUM`如果数据库开始接近事务 ID 环绕条件，它会自动变得更加积极，并跳过不必要的清理                                                                                       | [14.0](https://www.postgresql.org/docs/release/14.0/)   |
| 15.X  | 15.7   | 2024-05-09 | --         | 1.添加SQL / JSON查询函数[`json_exists()`](https://www.postgresql.org/docs/15/functions-json.html#FUNCTIONS-SQLJSON-QUERYING), `json_query()`, 和`json_value()`<br>2.**merge sql command**<br>3.在使用distinct 命令的情况下，可以支持并行的查询 | [15.0](https://www.postgresql.org/docs/release/15.0/)   |
| 16.X  | 16.3   | 2024-05-09 | --         | 1.允许并行化FULL和内部右OUTER哈希连接<br>2.允许从备用服务器进行逻辑复制<br>3.允许逻辑复制订阅者并行应用大型事务<br>4.允许使用新视图监控I/O统计信息pg_stat_io<br>5.添加SQL/JSON构造函数和标识函数<br>6.提高真空冷冻性能<br>7.pg_hba.conf添加对中用户和数据库名称以及中用户名的正则表达式匹配的支持pg_ident.conf                | [16.0](https://www.postgresql.org/docs/release/16.0/)   |

### [总结：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e6%80%bb%e7%bb%93%ef%bc%9a)

当前最高版本为v16.3;

当前最高release版本为v16.3，修复了16.2使用的一些问题；

由于12.X版本才支持SQL/JSON path，所以我们最低版本应该选择12.X。

目前大部分公司使用的版本：9.4、10、12、13，推荐使用版本：13.7、12.11、14.4。

版本特性总结连接：[PostgreSQL: Documentation](https://www.postgresql.org/docs/)

## [二、常用数据类型映射](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%ba%8c%e3%80%81%e5%b8%b8%e7%94%a8%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b%e6%98%a0%e5%b0%84)

### [1.数值类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e6%95%b0%e5%80%bc%e7%b1%bb%e5%9e%8b)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql)

| mysql类型    | 范围                                                             | pg类型                                | 范围                                      | 说明                                           |
| ---------- | -------------------------------------------------------------- | ----------------------------------- | --------------------------------------- | -------------------------------------------- |
| BIT[(M)]   | M范围是：[1,64]，默认1                                                | BIT[(n)]                            | ----                                    |                                              |
| TINYINT    | 有符号范围 `-128` - `127`。<br>无符号范围是`0` - `255`                     | smallint<br>int2                    | `-32768` - `32767`                      |                                              |
| TINYINT(1) | true,1<br>false,0                                              | bool                                | true,yes,on,1<br>false,no,off,0         | 布尔值                                          |
| SMALLINT   | 有符号范围 `-32768` - `32767`<br>无符号范围是`0` - `65535`                | smallint<br>int2                    | `-32768` - `32767`                      | **pg不能使用无符号，如果超出范围请使用`integer`类型**           |
| MEDIUMINT  | 有符号范围 `-8388608` - `8388607`<br>无符号范围是`0` - `16777215`         | integer<br>int4                     | `-2147483648` - `2147483647`            | 一个中等大小的整数                                    |
| INT        | 有符号范围 `-2147483648` - `2147483647`<br>无符号范围是`0` - `4294967295` | integer<br>int4                     | `-2147483648` - `2147483647`            | **pg不能使用无符号，如果超出范围请使用`bigint`类型**            |
| BIGINT     | 有符号范围 `-2^63` - `2^63 - 1`<br>无符号范围是`0` - `2^ 64 - 1`          | bigint<br>int8                      | `-2^63` - `2^63 - 1`                    | **pg不能使用无符号，如果超出范围请使用`numeric`或`decimal`类型** |
| DECIMAL    | 最大`DECIMAL(65)`                                                | decimal                             | 小数点前最多 131072 位；小数点后最多 16383 位          | 指定的精度，精确                                     |
| NUMERIC    | 最大`NUMERIC(65)`                                                | numeric                             | 小数点前最多 131072 位；小数点后最多 16383 位          | 指定的精度，精确                                     |
| FLOAT      | 支持无符号，4字节                                                      | real<br>float4                      | 4字节<br>-3.402E+38~3.402E+38，6位十进制数字精度。  | 不精确                                          |
| DOUBLE     | 支持无符号，8字节                                                      | float<br>float8<br>double precision | 8字节<br>-1.79E+308~1.79E+308，15位十进制数字精度。 | 不精确                                          |
| **----**   | **----**                                                       | **smallserial**                     | **1 - 32767<br>自增整数**                   |                                              |
| **----**   | **----**                                                       | **serial**                          | **1 - 2147483647<br>自增整数**              |                                              |
| **----**   | **----**                                                       | **bigserial**                       | **1 - 9223372036854775807<br>自增整数**     |                                              |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss)

| pg类型                                  | 范围   | openGauss类型                                   | 范围                                                                                                           | 说明       |
| ------------------------------------- | ---- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | -------- |
| ----                                  | ---- | TINYINT,<br>int1                              | 0 ~ 255                                                                                                      |          |
| ----                                  | ---- | LARGESERIAL                                   | -170,141,183,460,469,231,731,687,303,715,884,105,728<br>~170,141,183,460,469,231,731,687,303,715,884,105,727 | 十六字节序列整型 |
| float,<br>float8,<br>double precision | ---- | DOUBLE PRECISION,<br>FLOAT8,<br>BINARY_DOUBLE | ----                                                                                                         |          |

### [2.日期和时间类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e6%97%a5%e6%9c%9f%e5%92%8c%e6%97%b6%e9%97%b4%e7%b1%bb%e5%9e%8b)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-1)

| mysql类型   | 范围                                                        | pg类型         | 范围                                     | 说明                          |
| --------- | --------------------------------------------------------- | ------------ | -------------------------------------- | --------------------------- |
| DATE      | 1000-01-01 - 9999-12-31                                   | date         | 4713 BC - 5874897 AD                   | 年月日，精度：一天                   |
| **----**  |                                                           | **time**     | **00:00:00 - 24:00:00**                | **精度：微秒<br>可带时区**           |
| DATETIME  | 1000-01-01 00:00:00 - 9999-12-31 23:59:59                 | timestamp    | 4713 BC - 294276 AD                    | 可以包括一个尾随小数秒部分，可带时区<br>精度：微秒 |
| **----**  | **----**                                                  | **interval** | **-178000000 years - 178000000 years** | **时间间隔**                    |
| TIMESTAMP | `'1970-01-01 00:00:01'` UTC - `'2038-01-19 03:14:07'` UTC | timestamp    | 4713 BC - 294276 AD                    | 可以包括一个尾随小数秒部分，可带时区<br>精度：微秒 |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-1)

| pg类型     | 描述       | openGauss类型       | 描述                                                                                                                |
| -------- | -------- | ----------------- | ----------------------------------------------------------------------------------------------------------------- |
| **date** | **日期**   | **DATE**          | **时间和日期**                                                                                                         |
| **----** | **----** | **SMALLDATETIME** | **日期和时间，不带时区。<br>精确到分钟，秒位大于等于30秒进一位。**                                                                            |
| **----** | **----** | **reltime**       | **相对时间间隔。格式为：<br>X years X mons X days XX:XX:XX。<br>采用儒略历计时，规定一年为365.25天，一个月为30天，计算输入值对应的相对时间间隔，输出采用POSTGRES格式。** |
| **----** | **----** | **abstime**       | **日期和时间。格式为：<br>YYYY-MM-DD hh:mm:ss+timezone<br>取值范围为1901-12-13 20:45:53 GMT~2038-01-18 23:59:59 GMT，精度为秒。**      |

#### [备注：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%a4%87%e6%b3%a8%ef%bc%9a)

​ 推荐使用timestamp

### [3.字符串数据类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%ad%97%e7%ac%a6%e4%b8%b2%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b)

pg和openGauss字符串类型可以指定COLLATE(排序规则)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-2)

| mysql类型    | 范围/说明                                                                 | pg类型                                | 范围/说明                                                                | 说明            |
| ---------- | --------------------------------------------------------------------- | ----------------------------------- | -------------------------------------------------------------------- | ------------- |
| CHAR(n)    | 0-255<br>会用空格右填充到指定的长度                                                | char(n),<br>character(n)            | 最大约1GB，固定长度，空白填充<br>char不指定长度默认1<br>varchar不指定长度，最大约1GB              |               |
| VARCHAR(n) | 0-65535<br>值在存储时不会被填充                                                 | character varying(n),<br>varchar(n) | 最大约1GB，可变长度                                                          |               |
| BINARY     | 0-255<br>使用值0x00右填充到指定的长度                                             | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| VARBINARY  | 0-65535                                                               | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| BLOB       | 二进制字符串                                                                | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| TEXT       | 非二进制字符串                                                               | text                                | 无限制                                                                  |               |
| ENUM       | 最多65535个元素                                                            | ENUM                                | 63字节                                                                 |               |
| SET        | 最多64个不同的成员，自动去重<br>如果将`SET`列设置为不受支持的值，则该值将被忽略并发出警告                    | ----                                | ----                                                                 | pg无对应类型       |
| JSON       | [json函数](https://dev.mysql.com/doc/refman/5.7/en/json-functions.html) | json,<br>jsonb                      | [json函数和运算符](https://www.postgresql.org/docs/13/functions-json.html) | 均支持路径语法，函数不相同 |
| ----       | ----                                                                  | "char"                              | 1字节                                                                  |               |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-2)

| pg类型                                    | 范围/说明                                                                  | openGauss类型                                             | 范围/说明                                                                                                                                   |
| --------------------------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **char(n),<br>character(n)**            | **最大约1GB，固定长度，空白填充<br>char不指定长度默认1<br>varchar不指定长度，最大约1GB<br>n是指字符长度** | **CHAR(n),<br>CHARACTER(n),<br>NCHAR(n)**               | **定长字符串，不足补空格。n是指字节长度，如不带精度n，默认精度为1。<br>最大为10MB。**                                                                                      |
| **character varying(n),<br>varchar(n)** | **最大约1GB，可变长度<br>n是指字符长度**                                             | **character varying(n),<br>varchar(n),<br>varchar2(n)** | **变长字符串。n是指字节长度。<br>最大为10MB。**                                                                                                          |
| **----**                                | **----**                                                               | **NVARCHAR2(n)**                                        | **变长字符串。n是指字符长度。<br>最大为10MB。**                                                                                                          |
| **----**                                | **----**                                                               | **BLOB**                                                | **二进制字符串<br>说明：列存不支持BLOB类型<br>最大为1GB-8203字节（即1073733621字节）。**                                                                           |
| **----**                                | **----**                                                               | **RAW**                                                 | **变长的十六进制类型<br>说明：<br>列存不支持RAW类型**                                                                                                      |
| **----**                                | **----**                                                               | **BYTEAWITHOUTORDERWITHEQUALCOL**                       | **变长的二进制字符串（密态特性新增的类型，如果加密列的加密类型指定为确定性加密，则该列的实际类型为BYTEAWITHOUTORDERWITHEQUALCOL），元命令打印加密表将显示原始数据类型**                                    |
| **----**                                | **----**                                                               | **BYTEAWITHOUTORDERCOL**                                | **变长的二进制字符串（密态特性新增的类型，如果加密列的加密类型指定为随机加密，则该列的实际类型为BYTEAWITHOUTORDERCOL），元命令打印加密表将显示原始数据类型**                                              |
| **----**                                | **----**                                                               | **_BYTEAWITHOUTORDERWITHEQUALCOL**                      | **变长的二进制字符串，密态特性新增的类型**                                                                                                                 |
| **----**                                | **----**                                                               | **_BYTEAWITHOUTORDERCOL**                               | **变长的二进制字符串，密态特性新增的类型**                                                                                                                 |
| json,<br>jsonb                          | [json函数和运算符](https://www.postgresql.org/docs/13/functions-json.html)   | JSON,<br>JSONB                                          | [json函数](https://opengauss.org/zh/docs/3.0.0/docs/Developerguide/JSON-JSONB%E5%87%BD%E6%95%B0%E5%92%8C%E6%93%8D%E4%BD%9C%E7%AC%A6.html) |

#### [备注：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%a4%87%e6%b3%a8%ef%bc%9a-1)

- json和jsonb
  
  json存储效率比jsonb高，但是如果进行json操作时，json类型需要解析。
  
  json存储和查询（作为字符串方式查询出来）效率比较高；
  
  jsonb适合在json字段上做一些操作，比如查询和更新等。

## [三、主键策略与日期更新处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%89%e3%80%81%e4%b8%bb%e9%94%ae%e7%ad%96%e7%95%a5%e4%b8%8e%e6%97%a5%e6%9c%9f%e6%9b%b4%e6%96%b0%e5%a4%84%e7%90%86)

### [1.自增主键](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae)

自增主键改用`smallserial`、`serial`、`bigserial`类型，由于有旧数据，需要在数据迁移完成后更新自增序列：

```
select setval('sequence_name', (select max("col_name") from employee_age));
```

serial自动创建的自增序列命名规则为 `表名_字段名_seq`，重复时会增加数字序号，如：`employee_age_employee_id_seq1`。

#### [使用自增主键同时按照自增主键排序的表：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bd%bf%e7%94%a8%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae%e5%90%8c%e6%97%b6%e6%8c%89%e7%85%a7%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae%e6%8e%92%e5%ba%8f%e7%9a%84%e8%a1%a8%ef%bc%9a)

| 表名                        | 数据量    |
| ------------------------- | ------ |
| t_quartz_job              | 60     |
| t_work_order_status_trace | 431884 |
| t_web_info                | 34941  |
| t_user_site               | 1      |
| t_autosend_history        | 202    |
| t_web_asset               | 35388  |
| t_role_type               | 8      |
| t_role                    | 25     |

### [2.UUID](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2uuid)

- 使用函数生成uuid：`gen_random_uuid()`，结果：`8667eca6-72c1-48fd-840c-34393ffa11b5`
- 创建表时字段使用uuid类型

### [3.日期更新](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e6%97%a5%e6%9c%9f%e6%9b%b4%e6%96%b0)

- 新增数据时默认值
  
  - **业务模块手动设置值（推荐）**
  
  - 根据字段类型在字段定义后添加如下语句

```
DEFAULT CURRENT_DATE;
DEFAULT CURRENT_TIME;
DEFAULT CURRENT_TIMESTAMP;
DEFAULT LOCALTIME;
DEFAULT LOCALTIME;
DEFAULT LOCALTIMESTAMP
```

例如：`"find_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP`

- 更新数据时更新值
  
  - **业务模块手动设置更新值（推荐）**
  
  - 使用触发器更新

```
1.创建函数：
CREATE 
    OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
        NEW.column_name = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$ LANGUAGE plpgsql;

2.创建触发器
CREATE TRIGGER "trigger_name" BEFORE UPDATE ON "table_name" FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
```

## [四、函数、存储过程与运算符](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%9b%9b%e3%80%81%e5%87%bd%e6%95%b0%e3%80%81%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b%e4%b8%8e%e8%bf%90%e7%ae%97%e7%ac%a6)

### [1.常用运算符对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%b8%b8%e7%94%a8%e8%bf%90%e7%ae%97%e7%ac%a6%e5%af%b9%e7%85%a7%e8%a1%a8)

| mysql运算符             | 描述          | 示例                                                        | pg运算符                         | 描述                    | 示例                                                                                                           |
| -------------------- | ----------- | --------------------------------------------------------- | ----------------------------- | --------------------- | ------------------------------------------------------------------------------------------------------------ |
| and,<br>**&&**       | 逻辑与         | 1 and 0 → 0                                               | and                           | 逻辑与                   | 1 and 0 → 0                                                                                                  |
| or,<br>**\|**        | 逻辑或         | 1 or 0 → 1                                                | or                            | 逻辑或                   | 1 or 0 → 1                                                                                                   |
| not,<br>**!**        | 逻辑非         | not 1 → 0                                                 | not                           | 逻辑非                   | not 1 → 0                                                                                                    |
| <                    | 小于          | 1 < 0 → 0                                                 | <                             | 小于                    | 1 < 0 → 0                                                                                                    |
| >                    | 大于          | 1 > 0 → 1                                                 | >                             | 大于                    | 1 > 0 → 1                                                                                                    |
| <=                   | 小于等于        | 1 <= 0 → 0                                                | <=                            | 小于等于                  | 1 <= 0 → 0                                                                                                   |
| >=                   | 小于等于        | 1 >= 0 → 1                                                | >=                            | 小于等于                  | 1 >= 0 → 1                                                                                                   |
| =                    | 等于          | 1 = 0 → 0;<br>1 = NULL → NULL.                            | =                             | 等于                    | 1 = 0 → 0;<br>1 = NULL → NULL.                                                                               |
| !=                   | 不等于         | 1 != 0 → 1                                                | !=                            | 不等于                   | 1 != 0 → 1                                                                                                   |
| <>                   | 不等于         | 1 <> 0 → 1                                                | <>                            | 不等于                   | 1 <> 0 → 1                                                                                                   |
| **<=>**              | **安全等于**    | **1 <=> 1 → 1;<br>1 <=> NULL → 0;<br>NULL <=> NULL → 1.** | **IS NOT DISTINCT FROM**      | **安全等于**              | **1 IS NOT DISTINCT FROM 1 → 1;<br>1 IS NOT DISTINCT FROM NULL → 0;<br>NULL IS NOT DISTINCT FROM NULL → 1.** |
| **not (... <=>...)** | **安全不等于**   | **----**                                                  | **IS DISTINCT FROM**          | **安全不等于**             | **----**                                                                                                     |
| BETWEEN AND          | 之间，包含端点     | 2 BETWEEN 1 AND 3 → 1;<br>2 BETWEEN 3 AND 1 → 0.          | BETWEEN AND                   | 之间，包含端点               | 2 BETWEEN 1 AND 3 → 1;<br>2 BETWEEN 3 AND 1 → 0.                                                             |
| NOT BETWEEN AND      | 不在区间内       | ----                                                      | NOT BETWEEN AND               | 不在区间内                 | ----                                                                                                         |
| **----**             | **----**    | **----**                                                  | **BETWEEN SYMMETRIC AND**     | **之间，端点排序**           | **2 BETWEEN SYMMETRIC 1 AND 3 → 1;<br>2 BETWEEN SYMMETRIC 3 AND 1 → 1.**                                     |
| **----**             | **----**    | **----**                                                  | **NOT BETWEEN SYMMETRIC AND** | **不在区间内，端点排序**        | **----**                                                                                                     |
| **IS NULL**          | **为空**      | **1.5 IS NULL → 0**                                       | **IS NULL,<br>ISNULL**        | **为空**                | **1.5 IS NULL → 0**                                                                                          |
| **IS NOT NULL**      | **不为空**     | **'null' IS NOT NULL → 1**                                | **IS NOT NULL,<br>NOTNULL**   | **不为空**               | **'null' IS NOT NULL → 1**                                                                                   |
| IS TRUE              | 测试布尔表达式是否为真 | 1 IS TRUE → 1;<br>NULL IS TRUE → 0.                       | IS TRUE                       | 测试布尔表达式是否为真           | 1::bool IS TRUE → 1;<br>NULL IS TRUE → 0.                                                                    |
| IS NOT TRUE          | 测试布尔表达式是否为假 | ----                                                      | IS NOT TRUE                   | 测试布尔表达式是否为假           | ----                                                                                                         |
| IS FALSE             | 测试布尔表达式是否为假 | ----                                                      | IS FALSE                      | 测试布尔表达式是否为假           | ----                                                                                                         |
| IS NOT FALSE         | 测试布尔表达式是否为真 | ----                                                      | IS NOT FALSE                  | 测试布尔表达式是否为真           | ----                                                                                                         |
| **----**             | **----**    | **----**                                                  | **IS UNKNOWN**                | **测试布尔表达式是否产生未知值**    | **true IS UNKNOWN → 0;<br>NULL::boolean IS UNKNOWN → t.**                                                    |
| **----**             | **----**    | **----**                                                  | **IS NOT UNKNOWN**            | **测试布尔表达式结果是否是产生布尔值** | **----**                                                                                                     |
| **^**                | **按位异或**    | **1 ^ 2 → 3**                                             | **#**                         | **按位异或**              | **1 # 2 → 3**                                                                                                |
| **----**             | **----**    | **----**                                                  | **^**                         | **求幂**                | **2 ^ 3 → 8**                                                                                                |

### [2.常用函数对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e5%af%b9%e7%85%a7%e8%a1%a8)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-3)

| mysql函数                                                                                                                  | 描述                              | 示例                                                                                                                                                                                          | pg函数                                               | 描述                                                                                                               | 示例                                                                                                                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------ | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CONV()                                                                                                                   | 进制转换                            | CONV('a',16,2) → '1010'                                                                                                                                                                     | ----                                               | 有10转16: to_hex(n)<br>其余自己实现                                                                                      | ----                                                                                                                                                                                        |
| INET_ATON()                                                                                                              | IPv4地址转为数字                      | INET_ATON('192.168.3.1') → 3232236289                                                                                                                                                       | ----                                               | 无对应函数，自己实现<br>pg有[ip](https://www.postgresql.org/docs/13/datatype-net-types.html)类型                              | ----                                                                                                                                                                                        |
| INET_NTOA()                                                                                                              | 数字转IPv4                         | INET_NTOA(3232236289) → 192.168.3.1                                                                                                                                                         | ----                                               | 无对应函数，自己实现<br>pg有ip类型：inet,cidr                                                                                  | ----                                                                                                                                                                                        |
| INET6_ATON()                                                                                                             | IPv6地址转为二进制字符串                  | HEX(inet6_aton('FE80::2DBA:7113:B2BE:2E10')) → FE800000000000002DBA7113B2BE2E10                                                                                                             | ----                                               | ----                                                                                                             | ----                                                                                                                                                                                        |
| HEX()                                                                                                                    | 十进制或字符串值的16进制表示                 | HEX(3232236289) → C0A80301                                                                                                                                                                  | to_hex                                             | 十进制或字符串值的16进制表示                                                                                                  | (3232236289) → c0a80301                                                                                                                                                                     |
| **[CONVERT(expr USING transcoding_name)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=covert_code)** | **编码转换**                        | **CONVERT('test' USING utf8) → test;<br>CONVERT(_latin1 'Müller' USING utf8) → MÃ¼ller;<br>CONVERT('test', CHAR CHARACTER SET utf8) → test.**                                               | **convert(),<br>convert_to(),<br>convert_from().** | **需组合使用，[官方文档](https://www.postgresql.org/docs/13/functions-binarystring.html)**                                 | **----**                                                                                                                                                                                    |
| CONVERT(expr,type)                                                                                                       | 类型转换                            | CONVERT('123', UNSIGNED) → 123                                                                                                                                                              | cast(),<br>expr::type_name                         | 类型转换                                                                                                             | cast('123' AS int4) → 123;<br>'123'::int4 → 123.                                                                                                                                            |
| **[CAST(expr AS type)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=cast)**                          | **类型转换**                        | **CONVERT('123' AS UNSIGNED) → 123**                                                                                                                                                        | **cast(),<br>expr::type_name**                     | **类型转换**                                                                                                         | **cast('123' AS int4) → 123;<br>'123'::int4 → 123.**                                                                                                                                        |
| **[FIND_IN_SET(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_set)**             | **集合查找**                        | **FIND_IN_SET('b','a,b,c,d') → 2**                                                                                                                                                          | **str=any(string_to_array(strlist, ','))**         | **判断strlist中是否含有str**                                                                                            | **'a' = ANY(STRING_TO_ARRAY('a,b,c', ',')) → true**                                                                                                                                         |
| concat(str1,str2,...)                                                                                                    | 字符串拼接                           | CONCAT('a','b','c') → abc                                                                                                                                                                   | \|,<br>concat(str1,str2,...)                       | 字符串拼接                                                                                                            | 'a' \| 'b' \| 'c' → abc;<br>CONCAT('a','b','c') → abc.                                                                                                                                      |
| **[group_concat()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=group_concat)**                      | **分组字符串拼接**                     | **----**                                                                                                                                                                                    | **array_to_string(array_agg(column_name),',')**    | **分组字符串拼接**                                                                                                      | **----**                                                                                                                                                                                    |
| **[DATE_FORMAT(date,format)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=date_format)**             | **日期格式化**                       | **----**                                                                                                                                                                                    | **to_char(date, [pattern](#date pattern))**        | **日期时间格式化**                                                                                                      | **to_char(now(), 'YYYY-MM-DD HH24:MI:SS') → 2022-07-21 17:12:43**                                                                                                                           |
| **[IFNULL(value1,value2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnull)**                     | **空值判断**                        | **IFNULL(NULL, '值为空') → 值为空**                                                                                                                                                               | **----**                                           | **自定义函数实现，见[ifnull(val1,val2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnull_impl)**   | **IFNULL(NULL, '值为空') → 值为空**                                                                                                                                                               |
| CURRENT_TIMESTAMP([precision])                                                                                           | 当前日期,**precision可省略**，范围[0,6]   | ----                                                                                                                                                                                        | CURRENT_TIMESTAMP(precision)                       | 当前日期,**precision不可省略**，范围[0,6]                                                                                   | ----                                                                                                                                                                                        |
| **[CURDATE()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=curdate)**                                | **获取当前日期，不包含时分秒**               | **select CURDATE() → 2022-07-26**                                                                                                                                                           | **CURRENT_DATE**                                   | **获取当前日期，不包含时分秒**                                                                                                | **SELECT CURRENT_DATE → 2022-07-26**                                                                                                                                                        |
| **[SUBSTRING_INDEX(str,delim,count)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)** | **从出现分隔符 *`str`*之前 的字符串返回子字符串** | **SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', 2) → [www.mysql](http://www.mysql/);<br>SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', -2) → mysql.com** | **-----**                                          | **自定义函数实现，见[substring_index](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)** | **substring_index('[www.mysql.com'](http://www.mysql.com'/), '.', 2) → [www.mysql](http://www.mysql/);<br>SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', -2) → mysql.com** |
| **[IF(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if)**                         | **条件判断函数**                      | **SELECT IF(1>2,2,3) → 3**                                                                                                                                                                  | **----**                                           | **自定义函数实现，见[if(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if_impl)**   | **SELECT IF(1>2,2,3) → 3**                                                                                                                                                                  |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-3)

| postgresql函数                                                                                                                                                                          | 描述       | openGauss函数                       | 描述                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | --------------------------------- | ------------------------------------------------------------------------------- |
| **convert( bytes bytea, src_encoding name, dest_encoding name) → bytea;<br>convert_from(bytes bytea, src_encoding name) → text<br>convert_to(string text,dest_encoding name) →bytea** | **编码转换** | **convert_to_nocase(text, text)** | **将字符串转换为指定的编码类型。<br>返回值类型：bytea<br>SELECT convert_to_nocase('12345', 'GBK');** |
| **----**                                                                                                                                                                              | **----** | **nvl(value1,value2)**            | **如果value1为NULL则返回value2，如果value1非NULL，则返回value1。<br>和mysql的ifnull函数功能相同。**     |

### [3.常用函数修改示例（兼容postgresql和openGauss）](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e4%bf%ae%e6%94%b9%e7%a4%ba%e4%be%8b%ef%bc%88%e5%85%bc%e5%ae%b9postgresql%e5%92%8copengauss%ef%bc%89)

#### [CONVERT(expr USING transcoding_name)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=convertexpr-using-transcoding_name)

- 业务场景：查询字典数据厂商信息，按gbk编码排序

- mysql语句：
  
  ```
  SELECT DISTINCT
      vendor 
  FROM
      t_vendor_model 
  ORDER BY
      CONVERT ( vendor USING gbk ) DESC;
  ```

- 修改建议：
  
  1. postgresql和openGauss函数不相同，无法兼容，mirror中共三处均用在排序处；
     
     取消gbk排序或者业务排序。
  
  2. 分别在postgresql和openGauss上实现convert函数。

#### [CAST(expr AS type)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=castexpr-as-type)

- 业务场景：重大保障大屏-应用保障查询，获取最后一个点访问次数

- mysql语句：
  
  ```
  SELECT
      id,
      destHostName,
      webName,
      cast( SUBSTRING_INDEX( visitCount, ',',- 1 ) AS SIGNED ) visit,
      accessRateValue,
      accessMonitor,
      accessRate 
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```

- 修改建议：
  
  示例1：
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      substring_index( "visitCount", ',',- 1 )::int  visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **说明：substring_index是自定义函数。**
  
  示例2：
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      cast(substring_index( "visitCount", ',',- 1 ) AS int4)  visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **说明：substring_index是自定义函数。**
  
  **示例3（建议）：**
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      (string_to_array("visitCount", ','))[array_length(string_to_array("visitCount", ','), 1)]::int4 visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **示例4（建议）：**
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      (string_to_array("visitCount", ','))[7]::int4 visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```

- 说明
  
  有没有发现只有id和visit没有使用双引号？**请不要使用大写字段名！！！**

#### [SUBSTRING_INDEX](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)

- 示例同[cast](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=cast)

#### [FIND_IN_SET(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_setstrstrlist)

- 业务场景：根据资产标签统计在线数量和风险数量

- mysql语句：
  
  ```
  SELECT
      COUNT( CASE WHEN r.assetState = 'online' OR r.assetOnlineMonitor = 0 THEN 1 END ) AS `online`,
      COUNT( CASE WHEN r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ) THEN 1 END ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURDATE() 
      WHERE
          FIND_IN_SET( 'AR网关', ai.asset_label ) 
      ) r;
  ```

- 修改建议：
  
  **示例1，使用any和string_to_array实现（建议）：**
  
  ```
  SELECT 
      COUNT( IF ( r.assetState = 'online' OR r.assetOnlineMonitor = 0, 1, NULL ) ) AS online,
      COUNT( IF ( r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ), 1, NULL ) ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURRENT_DATE 
      WHERE
      'AR网关' = ANY ( string_to_array( ai.asset_label, ',' ) ) 
      ) r;
  ```
  
  示例2，[自定义find_in_set(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_set_impl)函数实现：
  
  ```
  SELECT 
      COUNT( IF ( r.assetState = 'online' OR r.assetOnlineMonitor = 0, 1, NULL ) ) AS online,
      COUNT( IF ( r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ), 1, NULL ) ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURRENT_DATE 
      WHERE
          FIND_IN_SET( 'AR网关', ai.asset_label ) 
      ) r;
  ```

#### [GROUP_CONCAT()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=group_concat)

- 业务场景：查询资产的名称和所有IP标识

- mysql语句：
  
  ```
  SELECT DISTINCT
      CONCAT( tai.asset_name, '(', taid.identification, ')' ) 
  FROM
      t_asset_information tai
      LEFT JOIN 
      ( 
          SELECT 
              GROUP_CONCAT( identification ) AS identification, 
              asset_id FROM t_asset_identification 
          WHERE identification_type IN ( 'private_ip', 'public_ip' )
          GROUP BY asset_id  
      ) taid ON tai.asset_id = taid.asset_id;
  ```

- 修改建议：
  
  示例1，使用array_to_string函数和聚合函数array_agg组合实现：
  
  ```
  SELECT DISTINCT
      CONCAT( tai.asset_name, '(', taid.identification, ')' ) 
  FROM
      t_asset_information tai
      LEFT JOIN 
      ( 
          SELECT 
              array_to_string(array_agg(identification), ',') AS identification, 
              asset_id FROM t_asset_identification 
          WHERE identification_type IN ( 'private_ip', 'public_ip' )
          GROUP BY asset_id
      ) taid ON tai.asset_id = taid.asset_id;
  ```

#### [DATE_FORMAT(date,format)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=date_formatdateformat)

- 业务场景：查询工单创建操作行为记录

- mysql语句：
  
  ```
  SELECT
      serial_id,
      operater,
      operater_host_address AS operaterHostAddress,
      action AS actionCode,
      date_format( created_at, '%Y-%m-%d %H:%i:%s' ) AS operationTime,
      operater_operations AS operaterOperationsContent 
  FROM
      t_work_order_operation_history 
  ORDER BY
      operationTime ASC
  ```

- 修改建议：
  
  示例：
  
  ```
  SELECT
      serial_id,
      operater,
      operater_host_address AS operaterHostAddress,
      "action" AS actionCode,
      to_char(created_at, 'YYYY-MM-DD HH24:MI:SS') AS operationTime,
      operater_operations AS operaterOperationsContent 
  FROM
      t_work_order_operation_history 
  ORDER BY
      operationTime ASC
  ```

#### [IFNULL(value1,value2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnullvalue1value2)

- 业务场景：查询重点关注用户(根据用户表查询, 可能出现用户表里有数据, 但ueba数据信息表里没有)

- mysql语句：
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      ifnull( m.seven_days_score, 0 ) seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```

- 修改建议：
  
  **示例1（建议）：**
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      case when m.seven_days_score is NULL then 0 else m.seven_days_score end seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```
  
  示例2：
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      ifnull( m.seven_days_score, 0 ) seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```

#### [CURDATE()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=curdate)

- 业务场景：查询组织架构下高风险资产的数量

- mysql语句：
  
  ```
  SELECT
      t1.asset_id 
  FROM
      t_asset_information t1
      LEFT JOIN t_asset_rating t2 ON t1.asset_id = t2.asset_id 
  WHERE
      t2.create_time >= CURDATE() 
      AND (
      t2.asset_health_state != 'healthy')
  ```

- 修改建议：
  
  示例：
  
  ```
  SELECT
      t1.asset_id 
  FROM
      t_asset_information t1
      LEFT JOIN t_asset_rating t2 ON t1.asset_id = t2.asset_id 
  WHERE
      t2.create_time >= CURRENT_DATE 
      AND (
      t2.asset_health_state != 'healthy')
  ```

- 说明
  
  **CURRENT_DATE不是函数，不要写括号**

#### [IF(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifexpr1expr2expr3)

- 业务场景：修改资产同步配置开关

- mysql语句：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = IF (#{enable}, 1, 0)
  WHERE
      id = #{configId}
  ```

- 修改建议：
  
  示例1，使用[自定义函数if](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if_impl)实现：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = IF (#{enable}, 1, 0)
  WHERE
      id = #{configId}
  ```
  
  示例2，使用类型转换实现：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = #{enable}::int4
  WHERE
      id = #{configId}
  ```
  
  示例3，sync_asset字段改为bool类型：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = #{enable}
  WHERE
      id = #{configId}
  ```
  
  **示例4，使用case when实现（推荐）：**
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = case #{enable} when 1 then true else false end
  WHERE
      id = #{configId}
  ```

### [4.自定义函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e8%87%aa%e5%ae%9a%e4%b9%89%e5%87%bd%e6%95%b0)

- #### [创建函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%88%9b%e5%bb%ba%e5%87%bd%e6%95%b0)
  
  ##### [语法：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%af%ad%e6%b3%95%ef%bc%9a)
  
  ```
  CREATE FUNCTION somefunc(integer, text) RETURNS integer
  AS 'function body text'
  LANGUAGE plpgsql;
  ```
  
  ##### [示例：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%a4%ba%e4%be%8b%ef%bc%9a)
  
  ```
  CREATE FUNCTION my_add ( n1 INTEGER, n2 INTEGER ) RETURNS INTEGER AS $$ BEGIN
      RETURN n1 + n2;
  END $$ LANGUAGE plpgsql;
  ```

- #### [调用函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%b0%83%e7%94%a8%e5%87%bd%e6%95%b0)
  
  ```
  select my_add(1,2);
  ```

### [4.存储过程](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b)

- #### [创建存储过程](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%88%9b%e5%bb%ba%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b)
  
  ##### [示例：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%a4%ba%e4%be%8b%ef%bc%9a-1)
  
  ```
  CREATE PROCEDURE triple(INOUT x int)
  LANGUAGE plpgsql
  AS $$
  BEGIN
      x := x * 3;
  END;
  $$;
  ```

- #### [调用](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%b0%83%e7%94%a8)
  
  ```
  call triple(3);
  ```

- ### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%ae%98%e6%96%b9%e6%96%87%e6%a1%a3)[官方文档](https://www.postgresql.org/docs/13/plpgsql-control-structures.html#PLPGSQL-STATEMENTS-RETURNING-PROCEDURE)

$$ 不推荐使用存储过程 $$

## [五、触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%ba%94%e3%80%81%e8%a7%a6%e5%8f%91%e5%99%a8)

### [1.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%a7%a6%e5%8f%91%e5%99%a8)[触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%a7%a6%e5%8f%91%e5%99%a8)

### [2.事件触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e4%ba%8b%e4%bb%b6%e8%a7%a6%e5%8f%91%e5%99%a8)

为了补充[第 38 章](https://www.postgresql.org/docs/13/triggers.html)中讨论的触发机制，PostgreSQL还提供了事件触发器。与附加到单个表并仅捕获 DML 事件的常规触发器不同，事件触发器对特定数据库是全局的，并且能够捕获 DDL 事件。

与常规触发器一样，事件触发器可以用任何包括事件触发器支持的过程语言编写，也可以用 C 编写，但不能用普通 SQL 编写。

参见[事件触发器](https://www.postgresql.org/docs/13/event-triggers.html)

## [六、建表语句修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%85%ad%e3%80%81%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)

可以使用navicat帮我们转换成postgresql语句，但是会有一些问题；

### [1.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%bb%ba%e8%a1%a8%e8%af%ad%e6%b3%95)[建表语法](https://www.postgresql.org/docs/13/sql-createtable.html)

```
CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name ( [
  { column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
    | table_constraint
    | LIKE source_table [ like_option ... ] }
    [, ... ]
] )
[ INHERITS ( parent_table [, ... ] ) ]
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]

CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
    OF type_name [ (
  { column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
    | table_constraint }
    [, ... ]
) ]
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]

CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
    PARTITION OF parent_table [ (
  { column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
    | table_constraint }
    [, ... ]
) ] { FOR VALUES partition_bound_spec | DEFAULT }
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]
```

### [2.字段和表的引用修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e5%ad%97%e6%ae%b5%e5%92%8c%e8%a1%a8%e7%9a%84%e5%bc%95%e7%94%a8%e4%bf%ae%e6%94%b9)

```
`table_name` 改为 "table_name"
`column_name` 改为 "column_name"
```

### [3.主键策略修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e4%b8%bb%e9%94%ae%e7%ad%96%e7%95%a5%e4%bf%ae%e6%94%b9)

参见[自增主键](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae)和[UUID](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=uuid)

### [4.字段类型修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e5%ad%97%e6%ae%b5%e7%b1%bb%e5%9e%8b%e4%bf%ae%e6%94%b9)

参见[常用数据类型映射](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b%e6%98%a0%e5%b0%84)

### [5.字符串修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5%e5%ad%97%e7%ac%a6%e4%b8%b2%e4%bf%ae%e6%94%b9)

- 字符串标识由双引号修改为单引号;
  
  例如：
  
  ```
  mysql: SELECT "字符串" str;
  postgresql: SELECT '字符串' str;
  ```

- char(n),varchar(n)类型，存储中文的，n要乘以4兼容openGauss

### [6.字段和表注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6%e5%ad%97%e6%ae%b5%e5%92%8c%e8%a1%a8%e6%b3%a8%e9%87%8a)

- #### [字段注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%ad%97%e6%ae%b5%e6%b3%a8%e9%87%8a)
  
  mysql字段注释紧跟字段后面，pg字段注释是单独的sql语句；
  
  ps语法：`COMMENT ON COLUMN "table_name"."column_name" IS '字段注释';`

- #### [表注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%a1%a8%e6%b3%a8%e9%87%8a)
  
  mysql表注释紧跟在表后面，pg表注释是单独的sql语句；
  
  pg语法：`COMMENT ON TABLE "table_name" IS '表注释';`

### [7.触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_7%e8%a7%a6%e5%8f%91%e5%99%a8)

1. 定义表
   
   创建需要触发器的表，例如：
   
   ```
   CREATE TABLE ttest (
      "id" serial primary key,
        "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
   );
   ```

2. 编写触发函数
   
   - 触发函数支持的语言：`PL/pgSQL`
   
   - 触发函数示例
     
     pgsql示例：
     
     ```
     CREATE 
        OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
            NEW.update_time = CURRENT_TIMESTAMP;
        RETURN NEW;
     END $$ LANGUAGE plpgsql;
     ```

3. 声明触发器
   
   ```
   --操作之前填充更新时间:
   CREATE TRIGGER before_trigger BEFORE UPDATE ON ttest
          FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
   
   --操作之前执行:
   CREATE TRIGGER tbefore BEFORE INSERT OR UPDATE OR DELETE ON ttest
      FOR EACH ROW EXECUTE FUNCTION trigf();
   
   --操作之后执行:
   CREATE TRIGGER tafter AFTER INSERT OR UPDATE OR DELETE ON ttest
      FOR EACH ROW EXECUTE FUNCTION trigf();
   ```

4. [触发器官方文档](https://www.postgresql.org/docs/13/trigger-definition.html)

### [8.索引](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_8%e7%b4%a2%e5%bc%95)

pg创建索引语法：

```
CREATE INDEX name ON table [USING index_type] (column [collation] [asc || desc] [NULLS] [LAST || FIRST]);
```

mysql中的key对应pg中create index，例如：

```
mysql:
CREATE TABLE ttest (
    `id` int(11) PRIMARY KEY,
      `code` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        KEY `idx_code` (`code`) USING BTREE
);

postgresql:
CREATE TABLE ttest (
    "id" int PRIMARY KEY,
      "code" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_code ON ttest USING btree ("code" ASC NULLS FIRST);
```

**注意：mysql创建的索引默认null在最后，pg可以指定，不指定默认为 ASC NULLS LAST。**

### [9.字段、数据库命名](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_9%e5%ad%97%e6%ae%b5%e3%80%81%e6%95%b0%e6%8d%ae%e5%ba%93%e5%91%bd%e5%90%8d)

- 将包含大写的字段修改为下划线命名

- database名字按照标识符命名规则重新命名，openGauss不支持中划线命名
  
  如：bigdata-web→bigdata_web

### [10.完整示例](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_10%e5%ae%8c%e6%95%b4%e7%a4%ba%e4%be%8b)

```
mysql:
CREATE TABLE `t_asset_information` (
  `asset_id` VARCHAR ( 100 ) NOT NULL COMMENT '资产ID-资产唯一标识',
    `asset_name` VARCHAR ( 100 ) NOT NULL COMMENT '资产名称-便于查看及识别',
     PRIMARY KEY ( `asset_id` ) 
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT='资产信息表';

CREATE TABLE `t_asset_monitor_port_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `asset_id` varchar(100) DEFAULT NULL COMMENT '资产ID-资产唯一标识',
  `asset_ip` varchar(45) NOT NULL COMMENT '资产ip',
  `port` varchar(45) NOT NULL COMMENT '端口',
  `protocol` varchar(100) DEFAULT NULL COMMENT '协议',
  `service_name` varchar(500) DEFAULT NULL COMMENT '服务名',
  `server_version` varchar(500) DEFAULT NULL COMMENT '服务版本',
  `status` char(1) NOT NULL COMMENT '端口状态，1：开启，0：关闭',
  `message` varchar(255) DEFAULT NULL COMMENT '描述信息',
  `find_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发现时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `source` varchar(100) DEFAULT NULL COMMENT '端口来源 AiNTA',
  `fingerprint_name` varchar(100) DEFAULT NULL COMMENT '指纹名称',
  `fingerprint_class2` varchar(100) DEFAULT NULL COMMENT '指纹二级类型（指纹类型）',
  `vendor_name` varchar(100) DEFAULT NULL COMMENT '厂商：中文名（英文名）',
  `tag` text COMMENT '产品标签',
  PRIMARY KEY (`id`),
  KEY `idx_asset_ip` (`asset_ip`) USING BTREE,
  UNIQUE KEY `unique_asset_id_asset_ip_port` (`asset_id`,`asset_ip`,`port`),
  CONSTRAINT `foreign_key_monitor_port_info_to_asset_id_4` FOREIGN KEY (`asset_id`) REFERENCES `t_asset_information` (`asset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主机资产-端口';

postgresql:
CREATE TABLE "t_asset_information" (
 "asset_id" VARCHAR ( 100 ) PRIMARY KEY,
    "asset_name" VARCHAR ( 400 )
);
COMMENT ON COLUMN "t_asset_information"."asset_id" IS '资产ID-资产唯一标识';
COMMENT ON COLUMN "t_asset_information"."asset_name" IS '资产名称-便于查看及识别';
COMMENT ON TABLE "t_asset_information" IS '资产信息表';

CREATE TABLE "t_asset_monitor_port_info" (
    "id" bigserial NOT NULL,
    "asset_id" VARCHAR ( 100 ) DEFAULT NULL,
    "asset_ip" VARCHAR ( 45 ) NOT NULL,
    "port" VARCHAR ( 45 ) NOT NULL,
    "protocol" VARCHAR ( 100 ) DEFAULT NULL,
    "service_name" VARCHAR ( 2000 ) DEFAULT NULL,
    "server_version" VARCHAR ( 500 ) DEFAULT NULL,
    "status" "char" NOT NULL,
    "message" VARCHAR ( 1020 ) DEFAULT NULL,
    "find_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "create_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "source" VARCHAR ( 100 ) DEFAULT NULL,
    "fingerprint_name" VARCHAR ( 400 ) DEFAULT NULL,
    "fingerprint_class2" VARCHAR ( 400 ) DEFAULT NULL,
    "vendor_name" VARCHAR ( 400 ) DEFAULT NULL,
    "tag" TEXT,
    PRIMARY KEY ( "id" ),
    CONSTRAINT "unique_asset_id_asset_ip_port" UNIQUE ( "asset_id", "asset_ip", "port" ),
    CONSTRAINT "foreign_key_monitor_port_info_to_asset_id" FOREIGN KEY ( "asset_id" ) REFERENCES "t_asset_information" ( "asset_id" ) ON DELETE CASCADE ON UPDATE CASCADE 
);
CREATE INDEX "idx_asset_ip" ON "t_asset_monitor_port_info" USING btree ("asset_ip" ASC NULLS FIRST);
COMMENT ON COLUMN "t_asset_monitor_port_info"."id" IS '主键Id';
COMMENT ON COLUMN "t_asset_monitor_port_info"."asset_id" IS '资产ID-资产唯一标识';
COMMENT ON COLUMN "t_asset_monitor_port_info"."asset_ip" IS '资产ip';
COMMENT ON COLUMN "t_asset_monitor_port_info"."port" IS '端口';
COMMENT ON COLUMN "t_asset_monitor_port_info"."protocol" IS '协议';
COMMENT ON COLUMN "t_asset_monitor_port_info"."service_name" IS '服务名';
COMMENT ON COLUMN "t_asset_monitor_port_info"."server_version" IS '服务版本';
COMMENT ON COLUMN "t_asset_monitor_port_info"."status" IS '端口状态，1：开启，0：关闭';
COMMENT ON COLUMN "t_asset_monitor_port_info"."message" IS '描述信息';
COMMENT ON COLUMN "t_asset_monitor_port_info"."find_time" IS '发现时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."update_time" IS '修改时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."source" IS '端口来源 AiNTA';
COMMENT ON COLUMN "t_asset_monitor_port_info"."fingerprint_name" IS '指纹名称';
COMMENT ON COLUMN "t_asset_monitor_port_info"."fingerprint_class2" IS '指纹二级类型（指纹类型）';
COMMENT ON COLUMN "t_asset_monitor_port_info"."vendor_name" IS '厂商：中文名（英文名）';
COMMENT ON COLUMN "t_asset_monitor_port_info"."tag" IS '产品标签';
COMMENT ON TABLE "t_asset_monitor_port_info" IS '主机资产-端口';

CREATE 
    OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
        NEW.update_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER "t_asset_monitor_port_info_upd_trigger" BEFORE UPDATE ON "t_asset_monitor_port_info" FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
```

## [七、事件替换](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%83%e3%80%81%e4%ba%8b%e4%bb%b6%e6%9b%bf%e6%8d%a2)

postgresql只有事件触发器，不包含定时触发，mysql事件改为代码实现。

## [八、视图处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%85%ab%e3%80%81%e8%a7%86%e5%9b%be%e5%a4%84%e7%90%86)

### [1.视图语法](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%a7%86%e5%9b%be%e8%af%ad%e6%b3%95)

```
CREATE TABLE myview (same column list as mytab);
ALTER TABLE myview OWNER TO "user_name";
```

### [2.示例](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e7%a4%ba%e4%be%8b)

```
CREATE VIEW "asset_port" AS  SELECT t_asset_monitor_port_info.id,
    t_asset_monitor_port_info.asset_id,
    t_asset_monitor_port_info.asset_ip,
    t_asset_monitor_port_info.port,
    t_asset_monitor_port_info.protocol,
    t_asset_monitor_port_info.status
   FROM test.t_asset_monitor_port_info;

ALTER TABLE "asset_port" OWNER TO "postgres";
```

### [3.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%ae%98%e6%96%b9%e6%96%87%e6%a1%a3)[官方文档](https://www.postgresql.org/docs/13/rules-views.html)

## [九、分表处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b9%9d%e3%80%81%e5%88%86%e8%a1%a8%e5%a4%84%e7%90%86)

使用分区功能实现分表，表分区通过继承实现，可以单独查询分区表数据，也可以查询主分区，主分区包含全部分区数据，可以通过trigger和check来约束分区，同时插入数据时不指定具体分区插入到主分区，由trigger来完成分区。

[详见官网](https://www.postgresql.org/docs/13/ddl-partitioning.html)

**openGauss不支持继承**

## [十、数据迁移](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e3%80%81%e6%95%b0%e6%8d%ae%e8%bf%81%e7%a7%bb)

### [1.简介](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e7%ae%80%e4%bb%8b)

由于mysql导出的导出sql类型的数据，sql中表名和字段名的表示方式不同，不推荐sql文件形式导入。

### [2.csv导入](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2csv%e5%af%bc%e5%85%a5)

- #### [从mysql导出csv文件](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bb%8emysql%e5%af%bc%e5%87%bacsv%e6%96%87%e4%bb%b6)
  
  ```
  select * from t_asset_monitor_port_info into outfile "/var/lib/mysql-files/t_asset_monitor_port_info.csv" character set utf8 fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';
  ```

- #### [导入csv到postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%af%bc%e5%85%a5csv%e5%88%b0postgresql)
  
  ```
  copy t_asset_monitor_port_info 
  from '/var/lib/mysql-files/t_asset_monitor_port_info.csv' 
  DELIMITER ','
  CSV;
  ```

### [3.datax导入](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3datax%e5%af%bc%e5%85%a5)

[datax官网](https://github.com/alibaba/DataX/blob/master/introduction.md)

## [十一、修改项目配置](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%b8%80%e3%80%81%e4%bf%ae%e6%94%b9%e9%a1%b9%e7%9b%ae%e9%85%8d%e7%bd%ae)

### [1.pom.xml](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1pomxml)

新增postgresql驱动依赖

```
<dependency>
  <groupId>org.postgresql</groupId>
  <artifactId>postgresql</artifactId>
</dependency>
```

### [2.application.properties](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2applicationproperties)

修改数据库连接信息和驱动

```
spring.datasource.driver-class-name=org.postgresql.Driver
```

## [十二、SQL修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%ba%8c%e3%80%81sql%e4%bf%ae%e6%94%b9)

### [1.参考](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%8f%82%e8%80%83%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)[建表语句修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)

### [2.insert冲突处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2insert%e5%86%b2%e7%aa%81%e5%a4%84%e7%90%86)

```
mysql:
INSERT INTO t_asset_information ( asset_id, asset_name, org_id, net_id )
VALUES
    ( 'asset_00008519-b728-4b00-857a-9be4e4cf537d_1657273055277', '10.2.51.88', '12bbcbcf-d8e8-4009-a8ba-a043f96f5ae8', '12bbcbcf-d8e8-4009-a8ba-a043f96f5ae8' ) 
    ON DUPLICATE KEY UPDATE asset_name = '10.2.51.88';

postgresql:
INSERT INTO "t_asset_information" ( "asset_id", "asset_name" )
VALUES
    ( 'asset_00008519-b728-4b00-857a-9be4e4cf537d_1657273055277', '10.2.51.88' ) ON CONFLICT ( asset_id ) DO
UPDATE 
    SET asset_name = '10.2.51.65';
```

### [3.schema处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3schema%e5%a4%84%e7%90%86)

**postgresql未指定schema时默认查询public，如果使用的非public，请指定schema。**

- 实体类
  
  ```
  @TableName(value="test.t_asset_monitor_port_info")
  或者
  @TableName(value="t_asset_monitor_port_info", schema="test")
  ```

- sql
  
  ```
  SELECT ID
      ,
      asset_id,
      asset_ip,
      port,
      protocol,
      service_name,
      server_version,
      status,
      message,
      find_time,
      create_time,
      update_time,
      SOURCE,
      fingerprint_name,
      fingerprint_class2,
      vendor_name,
      tag 
  FROM
      test.t_asset_monitor_port_info
  ```

### [4.运算符修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e8%bf%90%e7%ae%97%e7%ac%a6%e4%bf%ae%e6%94%b9)

​ [运算符对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e8%bf%90%e7%ae%97%e7%ac%a6%e5%af%b9%e7%85%a7%e8%a1%a8)

### [5.函数修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5%e5%87%bd%e6%95%b0%e4%bf%ae%e6%94%b9)

​ [常用函数对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e5%af%b9%e7%85%a7%e8%a1%a8)

### [6.group by和order by](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6group-by%e5%92%8corder-by)

​ postgresql的order by字段必须出现在select后面；

​ postgresql的group by语句中select字段必须出现在group by后面或者使用聚合函数。

## [十三、涉及组件](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%b8%89%e3%80%81%e6%b6%89%e5%8f%8a%e7%bb%84%e4%bb%b6)

### [1.flywaydb](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1flywaydb)

[官方文档](https://flywaydb.org/documentation/)显示支持postgresql，但是不支持openGauss，需要测试语法兼容openGauss的情况下能不能正常使用。

### [2.nacos](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2nacos)

nacos不支持postgresql和openGauss；

#### [建议：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%bb%ba%e8%ae%ae%ef%bc%9a)

1. 使用内置数据源
2. 使用java agent，不支持openGauss，地址:[GitHub - ccwxl/mysql2postgresql-jdbc-agent: Non-invasive replacement of mysql to postgresql , jdbc javaagent](https://github.com/siaron/mysql2postgresql-jdbc-agent)

## [十四、集群方式](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e5%9b%9b%e3%80%81%e9%9b%86%e7%be%a4%e6%96%b9%e5%bc%8f)

### [1.citus](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1citus)

Citus 是 Postgres 的一个**开源扩展**，它在集群中的多个节点上分布数据和查询。因为 Citus 是 Postgres 的扩展（**不是 fork**），所以当您使用 Citus 时，您也在使用 Postgres。您可以利用最新的 Postgres 功能、工具和生态系统。

Citus 将 Postgres 转换为具有分片、分布式 SQL 引擎、引用表和分布式表等功能的分布式数据库。Citus 将并行性、在内存中保留更多数据和更高的 I/O 带宽相结合，可以显着提高多租户 SaaS 应用程序、面向客户的实时分析仪表板和时间序列工作负载的性能。

- #### [优点](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bc%98%e7%82%b9)
  
  文档丰富；
  
  开源；
  
  只是PostgreSQL的一个extension；
  
  横向扩展方便；
  
  支持常用DDL；
  
  支持实时增删改查；
  
  支持聚合下推；
  
  支持分布式事务；
  
  支持并行查询。

- #### [缺点](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%bc%ba%e7%82%b9)
  
  多语句事务没有防止死锁的安全措施；
  
  没有针对中间查询失败和由此产生的不一致的安全措施；
  
  查询结果缓存在内存中；这些函数不能处理非常大的结果集；
  
  如果无法连接到节点，这些函数会提前出错；
  
  SQL限制。

- #### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=citus%e5%ae%98%e7%bd%91)[citus官网](https://docs.citusdata.com/en/v11.0/?_gl=1*1i2q6bs*_ga*MjcwMDQ1NzI5LjE2NTg3MzI0MjM.*_ga_DS5S1RKEB7*MTY1ODczMjQyMy4xLjEuMTY1ODczMjQ0Ny4w)

- #### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=sql%e5%92%8c%e8%a7%a3%e5%86%b3%e6%96%b9%e6%b3%95)[SQL和解决方法](https://docs.citusdata.com/en/v11.0/develop/reference_workarounds.html#)

### [2.Patroni + Etcd](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2patroni-etcd)

基于 [Patroni](https://patroni.readthedocs.io/en/latest/index.html) + [Etcd](https://etcd.io/docs/v3.4.0/) 的高可用方案，此方案使用Patroni管理本地库，并结合Etcd作为数据存储和主节点选举。

Patroni基于Python开发的模板，结合DCS(例如 ZooKeeper, etcd, Consul )可以定制PostgreSQL高可用方案。 Patroni并不是一套拿来即用的PostgreSQL高可用组件，涉及较多的配置和定制工作，Patroni 本身使用的数据同步方式是postgresql的流复制方式，默认的情况我们还是使用异步的方式，在Patroni 中会有一个参数，Maximum_lag_on_failover ,通过设置，保证从库在与主库超过一定数据不同步的情况下，不会发生相关的主从转移。 Patroni接管PostgreSQL数据库的启停，同时监控本地的PostgreSQL数据库，并将本地的PostgreSQL数据库信息写入DCS。 Patroni的主备端是通过是否能获得 leader key 来控制的，获取到了leader key的Patroni为主节点，其它的为备节点。

Etcd是一款基于Raft算法和协议开发的分布式 key-value 数据库，基于Go语言编写，Patroni监控本地的PostgreSQL状态，并将相关信息写入Etcd，每个Patroni都能读写Etcd上的key，从而获取外地PostgreSQL数据库信息。

- 优点
  
  健壮性: 使用分布式key-value数据库作为数据存储，主节点故障时进行主节点重新选举，具有很强的健壮性；
  
  支持主备延迟设置: 可以设置备库延迟主库WAL的字节数，当备库延迟大于指定值时不做故障切换；
  
  自动化程度高：
  
  1. 支持自动化初始PostgreSQL实例并部署流复制;
  2. 当备库实例关闭后，支持自动拉起;
  3. 当主库实例关闭后，首先会尝试自动拉起;
  4. 支持switchover命令，能自动将老的主库进行角色转换。
  
  避免脑裂: 数据库信息记录到 ETCD 中，通过优化部署策略（多机房部署、增加实例数)可以避免脑裂。

- 缺点
  
  搭建繁琐，需要安装不同的组件，及配置项；
  
  无组合使用的官方文档；
  
  读写需要访问不同的接口。

## [十五、附录](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%ba%94%e3%80%81%e9%99%84%e5%bd%95)

### [1.postgresql类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1postgresql%e7%b1%bb%e5%9e%8b)

| Name                                          | Aliases                      | Description                                                        |
| --------------------------------------------- | ---------------------------- | ------------------------------------------------------------------ |
| `bigint`                                      | `int8`                       | signed eight-byte integer                                          |
| `bigserial`                                   | `serial8`                    | autoincrementing eight-byte integer                                |
| `bit [ (*`n`*) ]`                             |                              | fixed-length bit string                                            |
| `bit varying [ (*`n`*) ]`                     | `varbit [ (*`n`*) ]`         | variable-length bit string                                         |
| `boolean`                                     | `bool`                       | logical Boolean (true/false)                                       |
| `box`                                         |                              | rectangular box on a plane                                         |
| `bytea`                                       |                              | binary data (“byte array”)                                         |
| `character [ (*`n`*) ]`                       | `char [ (*`n`*) ]`           | fixed-length character string                                      |
| `character varying [ (*`n`*) ]`               | `varchar [ (*`n`*) ]`        | variable-length character string                                   |
| `cidr`                                        |                              | IPv4 or IPv6 network address                                       |
| `circle`                                      |                              | circle on a plane                                                  |
| `date`                                        |                              | calendar date (year, month, day)                                   |
| `double precision`                            | `float8`                     | double precision floating-point number (8 bytes)                   |
| `inet`                                        |                              | IPv4 or IPv6 host address                                          |
| `integer`                                     | `int`, `int4`                | signed four-byte integer                                           |
| `interval [ *`fields`* ] [ (*`p`*) ]`         |                              | time span                                                          |
| `json`                                        |                              | textual JSON data                                                  |
| `jsonb`                                       |                              | binary JSON data, decomposed                                       |
| `line`                                        |                              | infinite line on a plane                                           |
| `lseg`                                        |                              | line segment on a plane                                            |
| `macaddr`                                     |                              | MAC (Media Access Control) address                                 |
| `macaddr8`                                    |                              | MAC (Media Access Control) address (EUI-64 format)                 |
| `money`                                       |                              | currency amount                                                    |
| `numeric [ (*`p`*, *`s`*) ]`                  | `decimal [ (*`p`*, *`s`*) ]` | exact numeric of selectable precision                              |
| `path`                                        |                              | geometric path on a plane                                          |
| `pg_lsn`                                      |                              | PostgreSQL Log Sequence Number                                     |
| `pg_snapshot`                                 |                              | user-level transaction ID snapshot                                 |
| `point`                                       |                              | geometric point on a plane                                         |
| `polygon`                                     |                              | closed geometric path on a plane                                   |
| `real`                                        | `float4`                     | single precision floating-point number (4 bytes)                   |
| `smallint`                                    | `int2`                       | signed two-byte integer                                            |
| `smallserial`                                 | `serial2`                    | autoincrementing two-byte integer                                  |
| `serial`                                      | `serial4`                    | autoincrementing four-byte integer                                 |
| `text`                                        |                              | variable-length character string                                   |
| `time [ (*`p`*) ] [ without time zone ]`      |                              | time of day (no time zone)                                         |
| `time [ (*`p`*) ] with time zone`             | `timetz`                     | time of day, including time zone                                   |
| `timestamp [ (*`p`*) ] [ without time zone ]` |                              | date and time (no time zone)                                       |
| `timestamp [ (*`p`*) ] with time zone`        | `timestamptz`                | date and time, including time zone                                 |
| `tsquery`                                     |                              | text search query                                                  |
| `tsvector`                                    |                              | text search document                                               |
| `txid_snapshot`                               |                              | user-level transaction ID snapshot (deprecated; see `pg_snapshot`) |
| `uuid`                                        |                              | universally unique identifier                                      |
| `xml`                                         |                              | XML data                                                           |

### [2.postgresql日期pattern](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2postgresql%e6%97%a5%e6%9c%9fpattern)

| Pattern                          | Description                                                                                                                                               |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `HH`                             | hour of day (01–12)                                                                                                                                       |
| `HH12`                           | hour of day (01–12)                                                                                                                                       |
| `HH24`                           | hour of day (00–23)                                                                                                                                       |
| `MI`                             | minute (00–59)                                                                                                                                            |
| `SS`                             | second (00–59)                                                                                                                                            |
| `MS`                             | millisecond (000–999)                                                                                                                                     |
| `US`                             | microsecond (000000–999999)                                                                                                                               |
| `FF1`                            | tenth of second (0–9)                                                                                                                                     |
| `FF2`                            | hundredth of second (00–99)                                                                                                                               |
| `FF3`                            | millisecond (000–999)                                                                                                                                     |
| `FF4`                            | tenth of a millisecond (0000–9999)                                                                                                                        |
| `FF5`                            | hundredth of a millisecond (00000–99999)                                                                                                                  |
| `FF6`                            | microsecond (000000–999999)                                                                                                                               |
| `SSSS`, `SSSSS`                  | seconds past midnight (0–86399)                                                                                                                           |
| `AM`, `am`, `PM` or `pm`         | meridiem indicator (without periods)                                                                                                                      |
| `A.M.`, `a.m.`, `P.M.` or `p.m.` | meridiem indicator (with periods)                                                                                                                         |
| `Y,YYY`                          | year (4 or more digits) with comma                                                                                                                        |
| `YYYY`                           | year (4 or more digits)                                                                                                                                   |
| `YYY`                            | last 3 digits of year                                                                                                                                     |
| `YY`                             | last 2 digits of year                                                                                                                                     |
| `Y`                              | last digit of year                                                                                                                                        |
| `IYYY`                           | ISO 8601 week-numbering year (4 or more digits)                                                                                                           |
| `IYY`                            | last 3 digits of ISO 8601 week-numbering year                                                                                                             |
| `IY`                             | last 2 digits of ISO 8601 week-numbering year                                                                                                             |
| `I`                              | last digit of ISO 8601 week-numbering year                                                                                                                |
| `BC`, `bc`, `AD` or `ad`         | era indicator (without periods)                                                                                                                           |
| `B.C.`, `b.c.`, `A.D.` or `a.d.` | era indicator (with periods)                                                                                                                              |
| `MONTH`                          | full upper case month name (blank-padded to 9 chars)                                                                                                      |
| `Month`                          | full capitalized month name (blank-padded to 9 chars)                                                                                                     |
| `month`                          | full lower case month name (blank-padded to 9 chars)                                                                                                      |
| `MON`                            | abbreviated upper case month name (3 chars in English, localized lengths vary)                                                                            |
| `Mon`                            | abbreviated capitalized month name (3 chars in English, localized lengths vary)                                                                           |
| `mon`                            | abbreviated lower case month name (3 chars in English, localized lengths vary)                                                                            |
| `MM`                             | month number (01–12)                                                                                                                                      |
| `DAY`                            | full upper case day name (blank-padded to 9 chars)                                                                                                        |
| `Day`                            | full capitalized day name (blank-padded to 9 chars)                                                                                                       |
| `day`                            | full lower case day name (blank-padded to 9 chars)                                                                                                        |
| `DY`                             | abbreviated upper case day name (3 chars in English, localized lengths vary)                                                                              |
| `Dy`                             | abbreviated capitalized day name (3 chars in English, localized lengths vary)                                                                             |
| `dy`                             | abbreviated lower case day name (3 chars in English, localized lengths vary)                                                                              |
| `DDD`                            | day of year (001–366)                                                                                                                                     |
| `IDDD`                           | day of ISO 8601 week-numbering year (001–371; day 1 of the year is Monday of the first ISO week)                                                          |
| `DD`                             | day of month (01–31)                                                                                                                                      |
| `D`                              | day of the week, Sunday (`1`) to Saturday (`7`)                                                                                                           |
| `ID`                             | ISO 8601 day of the week, Monday (`1`) to Sunday (`7`)                                                                                                    |
| `W`                              | week of month (1–5) (the first week starts on the first day of the month)                                                                                 |
| `WW`                             | week number of year (1–53) (the first week starts on the first day of the year)                                                                           |
| `IW`                             | week number of ISO 8601 week-numbering year (01–53; the first Thursday of the year is in week 1)                                                          |
| `CC`                             | century (2 digits) (the twenty-first century starts on 2001-01-01)                                                                                        |
| `J`                              | Julian Date (integer days since November 24, 4714 BC at local midnight; see [Section B.7](https://www.postgresql.org/docs/13/datetime-julian-dates.html)) |
| `Q`                              | quarter                                                                                                                                                   |
| `RM`                             | month in upper case Roman numerals (I–XII; I=January)                                                                                                     |
| `rm`                             | month in lower case Roman numerals (i–xii; i=January)                                                                                                     |
| `TZ`                             | upper case time-zone abbreviation (only supported in `to_char`)                                                                                           |
| `tz`                             | lower case time-zone abbreviation (only supported in `to_char`)                                                                                           |
| `TZH`                            | time-zone hours                                                                                                                                           |
| `TZM`                            | time-zone minutes                                                                                                                                         |
| `OF`                             | time-zone offset from UTC (only supported in `to_char`)                                                                                                   |

### [3.substring_index()实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3substring_index%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION substring_index ( VARCHAR, VARCHAR, INTEGER ) RETURNS VARCHAR AS $$ DECLARE
    tokens VARCHAR [];
len INTEGER;
indexnum INTEGER;
BEGIN
    tokens := string_to_array( $1, $2 );
    len := array_upper( tokens, 1 );
    indexnum := len - ( $3 * - 1 ) + 1;
    IF
        $3 >= 0 THEN
            RETURN array_to_string( tokens [ 1 :$3 ], $2 );
        ELSE RETURN array_to_string( tokens [ indexnum : len ], $2 );
    END IF;
END;
$$ LANGUAGE PLPGSQL;
```

### [4.if(expr1,expr2,expr3)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4ifexpr1expr2expr3%e5%ae%9e%e7%8e%b0)

```
CREATE 
OR REPLACE FUNCTION
IF
    ( expr1 anyelement, expr2 anyelement, expr3 anyelement ) RETURNS anyelement AS $$ BEGIN
    IF
        expr1::BOOLEAN THEN
            RETURN expr2;
        ELSE RETURN expr3;
    END IF;
END;
$$ LANGUAGE plpgsql;
```

### [5.ifnull(val1,val2)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5ifnullval1val2%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION ifnull ( val1 anyelement, val2 anyelement ) RETURNS anyelement AS $$ BEGIN
    IF
        val1 IS NULL THEN
            RETURN val2;
        ELSE RETURN val1;
    END IF;
END;
$$ LANGUAGE plpgsql;
```

### [6.find_in_set(str,strlist)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6find_in_setstrstrlist%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION find_in_set ( str VARCHAR, strlist VARCHAR ) RETURNS BOOLEAN AS $$ BEGIN
        RETURN array_position ( string_to_array( strlist, ',' ), str ) > 0;
END;
$$ LANGUAGE plpgsql;
```

**注意：该函数返回值为boolean类型**# [数据库切换PG方案](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e6%95%b0%e6%8d%ae%e5%ba%93%e5%88%87%e6%8d%a2pg%e6%96%b9%e6%a1%88)

## [一、版本选择](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%80%e3%80%81%e7%89%88%e6%9c%ac%e9%80%89%e6%8b%a9)

### [各版本对比：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%90%84%e7%89%88%e6%9c%ac%e5%af%b9%e6%af%94%ef%bc%9a)

| 版本    | 最新版本   | 最新发布日期     | 停更时间       | 重要变化                                                                                                                                                                                                                 | 官网介绍                                                    |
| ----- | ------ | ---------- | ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| 9.6.X | 9.6.24 | 2021-11-11 | 2021-11-11 | 1.**支持并行查询**<br>2.**允许同步复制**<br>3.**热备份**<br>4.继承式分区                                                                                                                                                                 | [9.6.0](https://www.postgresql.org/docs/release/9.6.0/) |
| 10.X  | 10.23  | 2022-11-10 | 2022-11-10 | 1.内置分区表<br>2.逻辑复制<br>3.**并行功能增强**                                                                                                                                                                                    | [10.0](https://www.postgresql.org/docs/release/10.0/)   |
| 11.X  | 11.22  | 2023-11-09 | 2023-11-09 | 1.新增哈希分区<br>2.基于的分区表创建索引<br>3.支持update分区<br>4.会创建一个默认default分区<br>5.分区支持创建主键，外键，索引，触发器                                                                                                                               | [11.0](https://www.postgresql.org/docs/release/11.0/)   |
| 12.X  | 12.19  | 2024-05-09 | --         | 1.**支持[SQL/JSON路径](https://www.postgresql.org/docs/12/functions-json.html#FUNCTIONS-SQLJSON-PATH)语言**<br>2.一般性能改进<br>3.[使用GSSAPI](https://www.postgresql.org/docs/12/gssapi-auth.html)身份验证时的 TCP/IP 连接加密             | [12.0](https://www.postgresql.org/docs/release/12.0/)   |
| 13.X  | 13.15  | 2024-05-09 | --         | 1.新增gen_random_uuid()函数<br>2.提高了使用聚合或分区表的查询的性能<br>3.从 B 树索引条目的重复数据删除中节省空间并提高性能                                                                                                                                       | [13.0](https://www.postgresql.org/docs/release/13.0/)   |
| 14.X  | 14.12  | 2024-05-09 | --         | 1.对并行查询、高度并发的工作负载、分区表、逻辑复制和清理进行了许多性能改进<br>2.B-tree 索引更新的管理效率更高，从而减少了索引膨胀<br>3.`VACUUM`如果数据库开始接近事务 ID 环绕条件，它会自动变得更加积极，并跳过不必要的清理                                                                                       | [14.0](https://www.postgresql.org/docs/release/14.0/)   |
| 15.X  | 15.7   | 2024-05-09 | --         | 1.添加SQL / JSON查询函数[`json_exists()`](https://www.postgresql.org/docs/15/functions-json.html#FUNCTIONS-SQLJSON-QUERYING), `json_query()`, 和`json_value()`<br>2.**merge sql command**<br>3.在使用distinct 命令的情况下，可以支持并行的查询 | [15.0](https://www.postgresql.org/docs/release/15.0/)   |
| 16.X  | 16.3   | 2024-05-09 | --         | 1.允许并行化FULL和内部右OUTER哈希连接<br>2.允许从备用服务器进行逻辑复制<br>3.允许逻辑复制订阅者并行应用大型事务<br>4.允许使用新视图监控I/O统计信息pg_stat_io<br>5.添加SQL/JSON构造函数和标识函数<br>6.提高真空冷冻性能<br>7.pg_hba.conf添加对中用户和数据库名称以及中用户名的正则表达式匹配的支持pg_ident.conf                | [16.0](https://www.postgresql.org/docs/release/16.0/)   |

### [总结：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e6%80%bb%e7%bb%93%ef%bc%9a)

当前最高版本为v16.3;

当前最高release版本为v16.3，修复了16.2使用的一些问题；

由于12.X版本才支持SQL/JSON path，所以我们最低版本应该选择12.X。

目前大部分公司使用的版本：9.4、10、12、13，推荐使用版本：13.7、12.11、14.4。

版本特性总结连接：[PostgreSQL: Documentation](https://www.postgresql.org/docs/)

## [二、常用数据类型映射](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%ba%8c%e3%80%81%e5%b8%b8%e7%94%a8%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b%e6%98%a0%e5%b0%84)

### [1.数值类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e6%95%b0%e5%80%bc%e7%b1%bb%e5%9e%8b)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql)

| mysql类型    | 范围                                                             | pg类型                                | 范围                                      | 说明                                           |
| ---------- | -------------------------------------------------------------- | ----------------------------------- | --------------------------------------- | -------------------------------------------- |
| BIT[(M)]   | M范围是：[1,64]，默认1                                                | BIT[(n)]                            | ----                                    |                                              |
| TINYINT    | 有符号范围 `-128` - `127`。<br>无符号范围是`0` - `255`                     | smallint<br>int2                    | `-32768` - `32767`                      |                                              |
| TINYINT(1) | true,1<br>false,0                                              | bool                                | true,yes,on,1<br>false,no,off,0         | 布尔值                                          |
| SMALLINT   | 有符号范围 `-32768` - `32767`<br>无符号范围是`0` - `65535`                | smallint<br>int2                    | `-32768` - `32767`                      | **pg不能使用无符号，如果超出范围请使用`integer`类型**           |
| MEDIUMINT  | 有符号范围 `-8388608` - `8388607`<br>无符号范围是`0` - `16777215`         | integer<br>int4                     | `-2147483648` - `2147483647`            | 一个中等大小的整数                                    |
| INT        | 有符号范围 `-2147483648` - `2147483647`<br>无符号范围是`0` - `4294967295` | integer<br>int4                     | `-2147483648` - `2147483647`            | **pg不能使用无符号，如果超出范围请使用`bigint`类型**            |
| BIGINT     | 有符号范围 `-2^63` - `2^63 - 1`<br>无符号范围是`0` - `2^ 64 - 1`          | bigint<br>int8                      | `-2^63` - `2^63 - 1`                    | **pg不能使用无符号，如果超出范围请使用`numeric`或`decimal`类型** |
| DECIMAL    | 最大`DECIMAL(65)`                                                | decimal                             | 小数点前最多 131072 位；小数点后最多 16383 位          | 指定的精度，精确                                     |
| NUMERIC    | 最大`NUMERIC(65)`                                                | numeric                             | 小数点前最多 131072 位；小数点后最多 16383 位          | 指定的精度，精确                                     |
| FLOAT      | 支持无符号，4字节                                                      | real<br>float4                      | 4字节<br>-3.402E+38~3.402E+38，6位十进制数字精度。  | 不精确                                          |
| DOUBLE     | 支持无符号，8字节                                                      | float<br>float8<br>double precision | 8字节<br>-1.79E+308~1.79E+308，15位十进制数字精度。 | 不精确                                          |
| **----**   | **----**                                                       | **smallserial**                     | **1 - 32767<br>自增整数**                   |                                              |
| **----**   | **----**                                                       | **serial**                          | **1 - 2147483647<br>自增整数**              |                                              |
| **----**   | **----**                                                       | **bigserial**                       | **1 - 9223372036854775807<br>自增整数**     |                                              |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss)

| pg类型                                  | 范围   | openGauss类型                                   | 范围                                                                                                           | 说明       |
| ------------------------------------- | ---- | --------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | -------- |
| ----                                  | ---- | TINYINT,<br>int1                              | 0 ~ 255                                                                                                      |          |
| ----                                  | ---- | LARGESERIAL                                   | -170,141,183,460,469,231,731,687,303,715,884,105,728<br>~170,141,183,460,469,231,731,687,303,715,884,105,727 | 十六字节序列整型 |
| float,<br>float8,<br>double precision | ---- | DOUBLE PRECISION,<br>FLOAT8,<br>BINARY_DOUBLE | ----                                                                                                         |          |

### [2.日期和时间类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e6%97%a5%e6%9c%9f%e5%92%8c%e6%97%b6%e9%97%b4%e7%b1%bb%e5%9e%8b)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-1)

| mysql类型   | 范围                                                        | pg类型         | 范围                                     | 说明                          |
| --------- | --------------------------------------------------------- | ------------ | -------------------------------------- | --------------------------- |
| DATE      | 1000-01-01 - 9999-12-31                                   | date         | 4713 BC - 5874897 AD                   | 年月日，精度：一天                   |
| **----**  |                                                           | **time**     | **00:00:00 - 24:00:00**                | **精度：微秒<br>可带时区**           |
| DATETIME  | 1000-01-01 00:00:00 - 9999-12-31 23:59:59                 | timestamp    | 4713 BC - 294276 AD                    | 可以包括一个尾随小数秒部分，可带时区<br>精度：微秒 |
| **----**  | **----**                                                  | **interval** | **-178000000 years - 178000000 years** | **时间间隔**                    |
| TIMESTAMP | `'1970-01-01 00:00:01'` UTC - `'2038-01-19 03:14:07'` UTC | timestamp    | 4713 BC - 294276 AD                    | 可以包括一个尾随小数秒部分，可带时区<br>精度：微秒 |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-1)

| pg类型     | 描述       | openGauss类型       | 描述                                                                                                                |
| -------- | -------- | ----------------- | ----------------------------------------------------------------------------------------------------------------- |
| **date** | **日期**   | **DATE**          | **时间和日期**                                                                                                         |
| **----** | **----** | **SMALLDATETIME** | **日期和时间，不带时区。<br>精确到分钟，秒位大于等于30秒进一位。**                                                                            |
| **----** | **----** | **reltime**       | **相对时间间隔。格式为：<br>X years X mons X days XX:XX:XX。<br>采用儒略历计时，规定一年为365.25天，一个月为30天，计算输入值对应的相对时间间隔，输出采用POSTGRES格式。** |
| **----** | **----** | **abstime**       | **日期和时间。格式为：<br>YYYY-MM-DD hh:mm:ss+timezone<br>取值范围为1901-12-13 20:45:53 GMT~2038-01-18 23:59:59 GMT，精度为秒。**      |

#### [备注：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%a4%87%e6%b3%a8%ef%bc%9a)

​ 推荐使用timestamp

### [3.字符串数据类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%ad%97%e7%ac%a6%e4%b8%b2%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b)

pg和openGauss字符串类型可以指定COLLATE(排序规则)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-2)

| mysql类型    | 范围/说明                                                                 | pg类型                                | 范围/说明                                                                | 说明            |
| ---------- | --------------------------------------------------------------------- | ----------------------------------- | -------------------------------------------------------------------- | ------------- |
| CHAR(n)    | 0-255<br>会用空格右填充到指定的长度                                                | char(n),<br>character(n)            | 最大约1GB，固定长度，空白填充<br>char不指定长度默认1<br>varchar不指定长度，最大约1GB              |               |
| VARCHAR(n) | 0-65535<br>值在存储时不会被填充                                                 | character varying(n),<br>varchar(n) | 最大约1GB，可变长度                                                          |               |
| BINARY     | 0-255<br>使用值0x00右填充到指定的长度                                             | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| VARBINARY  | 0-65535                                                               | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| BLOB       | 二进制字符串                                                                | bytea                               | 占用1或4字节加上实际长度                                                        | 二进制字符串        |
| TEXT       | 非二进制字符串                                                               | text                                | 无限制                                                                  |               |
| ENUM       | 最多65535个元素                                                            | ENUM                                | 63字节                                                                 |               |
| SET        | 最多64个不同的成员，自动去重<br>如果将`SET`列设置为不受支持的值，则该值将被忽略并发出警告                    | ----                                | ----                                                                 | pg无对应类型       |
| JSON       | [json函数](https://dev.mysql.com/doc/refman/5.7/en/json-functions.html) | json,<br>jsonb                      | [json函数和运算符](https://www.postgresql.org/docs/13/functions-json.html) | 均支持路径语法，函数不相同 |
| ----       | ----                                                                  | "char"                              | 1字节                                                                  |               |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-2)

| pg类型                                    | 范围/说明                                                                  | openGauss类型                                             | 范围/说明                                                                                                                                   |
| --------------------------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **char(n),<br>character(n)**            | **最大约1GB，固定长度，空白填充<br>char不指定长度默认1<br>varchar不指定长度，最大约1GB<br>n是指字符长度** | **CHAR(n),<br>CHARACTER(n),<br>NCHAR(n)**               | **定长字符串，不足补空格。n是指字节长度，如不带精度n，默认精度为1。<br>最大为10MB。**                                                                                      |
| **character varying(n),<br>varchar(n)** | **最大约1GB，可变长度<br>n是指字符长度**                                             | **character varying(n),<br>varchar(n),<br>varchar2(n)** | **变长字符串。n是指字节长度。<br>最大为10MB。**                                                                                                          |
| **----**                                | **----**                                                               | **NVARCHAR2(n)**                                        | **变长字符串。n是指字符长度。<br>最大为10MB。**                                                                                                          |
| **----**                                | **----**                                                               | **BLOB**                                                | **二进制字符串<br>说明：列存不支持BLOB类型<br>最大为1GB-8203字节（即1073733621字节）。**                                                                           |
| **----**                                | **----**                                                               | **RAW**                                                 | **变长的十六进制类型<br>说明：<br>列存不支持RAW类型**                                                                                                      |
| **----**                                | **----**                                                               | **BYTEAWITHOUTORDERWITHEQUALCOL**                       | **变长的二进制字符串（密态特性新增的类型，如果加密列的加密类型指定为确定性加密，则该列的实际类型为BYTEAWITHOUTORDERWITHEQUALCOL），元命令打印加密表将显示原始数据类型**                                    |
| **----**                                | **----**                                                               | **BYTEAWITHOUTORDERCOL**                                | **变长的二进制字符串（密态特性新增的类型，如果加密列的加密类型指定为随机加密，则该列的实际类型为BYTEAWITHOUTORDERCOL），元命令打印加密表将显示原始数据类型**                                              |
| **----**                                | **----**                                                               | **_BYTEAWITHOUTORDERWITHEQUALCOL**                      | **变长的二进制字符串，密态特性新增的类型**                                                                                                                 |
| **----**                                | **----**                                                               | **_BYTEAWITHOUTORDERCOL**                               | **变长的二进制字符串，密态特性新增的类型**                                                                                                                 |
| json,<br>jsonb                          | [json函数和运算符](https://www.postgresql.org/docs/13/functions-json.html)   | JSON,<br>JSONB                                          | [json函数](https://opengauss.org/zh/docs/3.0.0/docs/Developerguide/JSON-JSONB%E5%87%BD%E6%95%B0%E5%92%8C%E6%93%8D%E4%BD%9C%E7%AC%A6.html) |

#### [备注：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%a4%87%e6%b3%a8%ef%bc%9a-1)

- json和jsonb
  
  json存储效率比jsonb高，但是如果进行json操作时，json类型需要解析。
  
  json存储和查询（作为字符串方式查询出来）效率比较高；
  
  jsonb适合在json字段上做一些操作，比如查询和更新等。

## [三、主键策略与日期更新处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%89%e3%80%81%e4%b8%bb%e9%94%ae%e7%ad%96%e7%95%a5%e4%b8%8e%e6%97%a5%e6%9c%9f%e6%9b%b4%e6%96%b0%e5%a4%84%e7%90%86)

### [1.自增主键](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae)

自增主键改用`smallserial`、`serial`、`bigserial`类型，由于有旧数据，需要在数据迁移完成后更新自增序列：

```
select setval('sequence_name', (select max("col_name") from employee_age));
```

serial自动创建的自增序列命名规则为 `表名_字段名_seq`，重复时会增加数字序号，如：`employee_age_employee_id_seq1`。

#### [使用自增主键同时按照自增主键排序的表：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bd%bf%e7%94%a8%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae%e5%90%8c%e6%97%b6%e6%8c%89%e7%85%a7%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae%e6%8e%92%e5%ba%8f%e7%9a%84%e8%a1%a8%ef%bc%9a)

| 表名                        | 数据量    |
| ------------------------- | ------ |
| t_quartz_job              | 60     |
| t_work_order_status_trace | 431884 |
| t_web_info                | 34941  |
| t_user_site               | 1      |
| t_autosend_history        | 202    |
| t_web_asset               | 35388  |
| t_role_type               | 8      |
| t_role                    | 25     |

### [2.UUID](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2uuid)

- 使用函数生成uuid：`gen_random_uuid()`，结果：`8667eca6-72c1-48fd-840c-34393ffa11b5`
- 创建表时字段使用uuid类型

### [3.日期更新](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e6%97%a5%e6%9c%9f%e6%9b%b4%e6%96%b0)

- 新增数据时默认值
  
  - **业务模块手动设置值（推荐）**
  
  - 根据字段类型在字段定义后添加如下语句

```
DEFAULT CURRENT_DATE;
DEFAULT CURRENT_TIME;
DEFAULT CURRENT_TIMESTAMP;
DEFAULT LOCALTIME;
DEFAULT LOCALTIME;
DEFAULT LOCALTIMESTAMP
```

例如：`"find_time" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP`

- 更新数据时更新值
  
  - **业务模块手动设置更新值（推荐）**
  
  - 使用触发器更新

```
1.创建函数：
CREATE 
    OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
        NEW.column_name = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$ LANGUAGE plpgsql;

2.创建触发器
CREATE TRIGGER "trigger_name" BEFORE UPDATE ON "table_name" FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
```

## [四、函数、存储过程与运算符](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%9b%9b%e3%80%81%e5%87%bd%e6%95%b0%e3%80%81%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b%e4%b8%8e%e8%bf%90%e7%ae%97%e7%ac%a6)

### [1.常用运算符对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%b8%b8%e7%94%a8%e8%bf%90%e7%ae%97%e7%ac%a6%e5%af%b9%e7%85%a7%e8%a1%a8)

| mysql运算符             | 描述          | 示例                                                        | pg运算符                         | 描述                    | 示例                                                                                                           |
| -------------------- | ----------- | --------------------------------------------------------- | ----------------------------- | --------------------- | ------------------------------------------------------------------------------------------------------------ |
| and,<br>**&&**       | 逻辑与         | 1 and 0 → 0                                               | and                           | 逻辑与                   | 1 and 0 → 0                                                                                                  |
| or,<br>**\|**        | 逻辑或         | 1 or 0 → 1                                                | or                            | 逻辑或                   | 1 or 0 → 1                                                                                                   |
| not,<br>**!**        | 逻辑非         | not 1 → 0                                                 | not                           | 逻辑非                   | not 1 → 0                                                                                                    |
| <                    | 小于          | 1 < 0 → 0                                                 | <                             | 小于                    | 1 < 0 → 0                                                                                                    |
| >                    | 大于          | 1 > 0 → 1                                                 | >                             | 大于                    | 1 > 0 → 1                                                                                                    |
| <=                   | 小于等于        | 1 <= 0 → 0                                                | <=                            | 小于等于                  | 1 <= 0 → 0                                                                                                   |
| >=                   | 小于等于        | 1 >= 0 → 1                                                | >=                            | 小于等于                  | 1 >= 0 → 1                                                                                                   |
| =                    | 等于          | 1 = 0 → 0;<br>1 = NULL → NULL.                            | =                             | 等于                    | 1 = 0 → 0;<br>1 = NULL → NULL.                                                                               |
| !=                   | 不等于         | 1 != 0 → 1                                                | !=                            | 不等于                   | 1 != 0 → 1                                                                                                   |
| <>                   | 不等于         | 1 <> 0 → 1                                                | <>                            | 不等于                   | 1 <> 0 → 1                                                                                                   |
| **<=>**              | **安全等于**    | **1 <=> 1 → 1;<br>1 <=> NULL → 0;<br>NULL <=> NULL → 1.** | **IS NOT DISTINCT FROM**      | **安全等于**              | **1 IS NOT DISTINCT FROM 1 → 1;<br>1 IS NOT DISTINCT FROM NULL → 0;<br>NULL IS NOT DISTINCT FROM NULL → 1.** |
| **not (... <=>...)** | **安全不等于**   | **----**                                                  | **IS DISTINCT FROM**          | **安全不等于**             | **----**                                                                                                     |
| BETWEEN AND          | 之间，包含端点     | 2 BETWEEN 1 AND 3 → 1;<br>2 BETWEEN 3 AND 1 → 0.          | BETWEEN AND                   | 之间，包含端点               | 2 BETWEEN 1 AND 3 → 1;<br>2 BETWEEN 3 AND 1 → 0.                                                             |
| NOT BETWEEN AND      | 不在区间内       | ----                                                      | NOT BETWEEN AND               | 不在区间内                 | ----                                                                                                         |
| **----**             | **----**    | **----**                                                  | **BETWEEN SYMMETRIC AND**     | **之间，端点排序**           | **2 BETWEEN SYMMETRIC 1 AND 3 → 1;<br>2 BETWEEN SYMMETRIC 3 AND 1 → 1.**                                     |
| **----**             | **----**    | **----**                                                  | **NOT BETWEEN SYMMETRIC AND** | **不在区间内，端点排序**        | **----**                                                                                                     |
| **IS NULL**          | **为空**      | **1.5 IS NULL → 0**                                       | **IS NULL,<br>ISNULL**        | **为空**                | **1.5 IS NULL → 0**                                                                                          |
| **IS NOT NULL**      | **不为空**     | **'null' IS NOT NULL → 1**                                | **IS NOT NULL,<br>NOTNULL**   | **不为空**               | **'null' IS NOT NULL → 1**                                                                                   |
| IS TRUE              | 测试布尔表达式是否为真 | 1 IS TRUE → 1;<br>NULL IS TRUE → 0.                       | IS TRUE                       | 测试布尔表达式是否为真           | 1::bool IS TRUE → 1;<br>NULL IS TRUE → 0.                                                                    |
| IS NOT TRUE          | 测试布尔表达式是否为假 | ----                                                      | IS NOT TRUE                   | 测试布尔表达式是否为假           | ----                                                                                                         |
| IS FALSE             | 测试布尔表达式是否为假 | ----                                                      | IS FALSE                      | 测试布尔表达式是否为假           | ----                                                                                                         |
| IS NOT FALSE         | 测试布尔表达式是否为真 | ----                                                      | IS NOT FALSE                  | 测试布尔表达式是否为真           | ----                                                                                                         |
| **----**             | **----**    | **----**                                                  | **IS UNKNOWN**                | **测试布尔表达式是否产生未知值**    | **true IS UNKNOWN → 0;<br>NULL::boolean IS UNKNOWN → t.**                                                    |
| **----**             | **----**    | **----**                                                  | **IS NOT UNKNOWN**            | **测试布尔表达式结果是否是产生布尔值** | **----**                                                                                                     |
| **^**                | **按位异或**    | **1 ^ 2 → 3**                                             | **#**                         | **按位异或**              | **1 # 2 → 3**                                                                                                |
| **----**             | **----**    | **----**                                                  | **^**                         | **求幂**                | **2 ^ 3 → 8**                                                                                                |

### [2.常用函数对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e5%af%b9%e7%85%a7%e8%a1%a8)

#### [mysql和postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=mysql%e5%92%8cpostgresql-3)

| mysql函数                                                                                                                  | 描述                              | 示例                                                                                                                                                                                          | pg函数                                               | 描述                                                                                                               | 示例                                                                                                                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------ | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CONV()                                                                                                                   | 进制转换                            | CONV('a',16,2) → '1010'                                                                                                                                                                     | ----                                               | 有10转16: to_hex(n)<br>其余自己实现                                                                                      | ----                                                                                                                                                                                        |
| INET_ATON()                                                                                                              | IPv4地址转为数字                      | INET_ATON('192.168.3.1') → 3232236289                                                                                                                                                       | ----                                               | 无对应函数，自己实现<br>pg有[ip](https://www.postgresql.org/docs/13/datatype-net-types.html)类型                              | ----                                                                                                                                                                                        |
| INET_NTOA()                                                                                                              | 数字转IPv4                         | INET_NTOA(3232236289) → 192.168.3.1                                                                                                                                                         | ----                                               | 无对应函数，自己实现<br>pg有ip类型：inet,cidr                                                                                  | ----                                                                                                                                                                                        |
| INET6_ATON()                                                                                                             | IPv6地址转为二进制字符串                  | HEX(inet6_aton('FE80::2DBA:7113:B2BE:2E10')) → FE800000000000002DBA7113B2BE2E10                                                                                                             | ----                                               | ----                                                                                                             | ----                                                                                                                                                                                        |
| HEX()                                                                                                                    | 十进制或字符串值的16进制表示                 | HEX(3232236289) → C0A80301                                                                                                                                                                  | to_hex                                             | 十进制或字符串值的16进制表示                                                                                                  | (3232236289) → c0a80301                                                                                                                                                                     |
| **[CONVERT(expr USING transcoding_name)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=covert_code)** | **编码转换**                        | **CONVERT('test' USING utf8) → test;<br>CONVERT(_latin1 'Müller' USING utf8) → MÃ¼ller;<br>CONVERT('test', CHAR CHARACTER SET utf8) → test.**                                               | **convert(),<br>convert_to(),<br>convert_from().** | **需组合使用，[官方文档](https://www.postgresql.org/docs/13/functions-binarystring.html)**                                 | **----**                                                                                                                                                                                    |
| CONVERT(expr,type)                                                                                                       | 类型转换                            | CONVERT('123', UNSIGNED) → 123                                                                                                                                                              | cast(),<br>expr::type_name                         | 类型转换                                                                                                             | cast('123' AS int4) → 123;<br>'123'::int4 → 123.                                                                                                                                            |
| **[CAST(expr AS type)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=cast)**                          | **类型转换**                        | **CONVERT('123' AS UNSIGNED) → 123**                                                                                                                                                        | **cast(),<br>expr::type_name**                     | **类型转换**                                                                                                         | **cast('123' AS int4) → 123;<br>'123'::int4 → 123.**                                                                                                                                        |
| **[FIND_IN_SET(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_set)**             | **集合查找**                        | **FIND_IN_SET('b','a,b,c,d') → 2**                                                                                                                                                          | **str=any(string_to_array(strlist, ','))**         | **判断strlist中是否含有str**                                                                                            | **'a' = ANY(STRING_TO_ARRAY('a,b,c', ',')) → true**                                                                                                                                         |
| concat(str1,str2,...)                                                                                                    | 字符串拼接                           | CONCAT('a','b','c') → abc                                                                                                                                                                   | \|,<br>concat(str1,str2,...)                       | 字符串拼接                                                                                                            | 'a' \| 'b' \| 'c' → abc;<br>CONCAT('a','b','c') → abc.                                                                                                                                      |
| **[group_concat()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=group_concat)**                      | **分组字符串拼接**                     | **----**                                                                                                                                                                                    | **array_to_string(array_agg(column_name),',')**    | **分组字符串拼接**                                                                                                      | **----**                                                                                                                                                                                    |
| **[DATE_FORMAT(date,format)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=date_format)**             | **日期格式化**                       | **----**                                                                                                                                                                                    | **to_char(date, [pattern](#date pattern))**        | **日期时间格式化**                                                                                                      | **to_char(now(), 'YYYY-MM-DD HH24:MI:SS') → 2022-07-21 17:12:43**                                                                                                                           |
| **[IFNULL(value1,value2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnull)**                     | **空值判断**                        | **IFNULL(NULL, '值为空') → 值为空**                                                                                                                                                               | **----**                                           | **自定义函数实现，见[ifnull(val1,val2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnull_impl)**   | **IFNULL(NULL, '值为空') → 值为空**                                                                                                                                                               |
| CURRENT_TIMESTAMP([precision])                                                                                           | 当前日期,**precision可省略**，范围[0,6]   | ----                                                                                                                                                                                        | CURRENT_TIMESTAMP(precision)                       | 当前日期,**precision不可省略**，范围[0,6]                                                                                   | ----                                                                                                                                                                                        |
| **[CURDATE()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=curdate)**                                | **获取当前日期，不包含时分秒**               | **select CURDATE() → 2022-07-26**                                                                                                                                                           | **CURRENT_DATE**                                   | **获取当前日期，不包含时分秒**                                                                                                | **SELECT CURRENT_DATE → 2022-07-26**                                                                                                                                                        |
| **[SUBSTRING_INDEX(str,delim,count)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)** | **从出现分隔符 *`str`*之前 的字符串返回子字符串** | **SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', 2) → [www.mysql](http://www.mysql/);<br>SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', -2) → mysql.com** | **-----**                                          | **自定义函数实现，见[substring_index](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)** | **substring_index('[www.mysql.com'](http://www.mysql.com'/), '.', 2) → [www.mysql](http://www.mysql/);<br>SUBSTRING_INDEX('[www.mysql.com'](http://www.mysql.com'/), '.', -2) → mysql.com** |
| **[IF(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if)**                         | **条件判断函数**                      | **SELECT IF(1>2,2,3) → 3**                                                                                                                                                                  | **----**                                           | **自定义函数实现，见[if(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if_impl)**   | **SELECT IF(1>2,2,3) → 3**                                                                                                                                                                  |

#### [postgresql和openGauss](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=postgresql%e5%92%8copengauss-3)

| postgresql函数                                                                                                                                                                          | 描述       | openGauss函数                       | 描述                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | --------------------------------- | ------------------------------------------------------------------------------- |
| **convert( bytes bytea, src_encoding name, dest_encoding name) → bytea;<br>convert_from(bytes bytea, src_encoding name) → text<br>convert_to(string text,dest_encoding name) →bytea** | **编码转换** | **convert_to_nocase(text, text)** | **将字符串转换为指定的编码类型。<br>返回值类型：bytea<br>SELECT convert_to_nocase('12345', 'GBK');** |
| **----**                                                                                                                                                                              | **----** | **nvl(value1,value2)**            | **如果value1为NULL则返回value2，如果value1非NULL，则返回value1。<br>和mysql的ifnull函数功能相同。**     |

### [3.常用函数修改示例（兼容postgresql和openGauss）](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e4%bf%ae%e6%94%b9%e7%a4%ba%e4%be%8b%ef%bc%88%e5%85%bc%e5%ae%b9postgresql%e5%92%8copengauss%ef%bc%89)

#### [CONVERT(expr USING transcoding_name)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=convertexpr-using-transcoding_name)

- 业务场景：查询字典数据厂商信息，按gbk编码排序

- mysql语句：
  
  ```
  SELECT DISTINCT
      vendor 
  FROM
      t_vendor_model 
  ORDER BY
      CONVERT ( vendor USING gbk ) DESC;
  ```

- 修改建议：
  
  1. postgresql和openGauss函数不相同，无法兼容，mirror中共三处均用在排序处；
     
     取消gbk排序或者业务排序。
  
  2. 分别在postgresql和openGauss上实现convert函数。

#### [CAST(expr AS type)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=castexpr-as-type)

- 业务场景：重大保障大屏-应用保障查询，获取最后一个点访问次数

- mysql语句：
  
  ```
  SELECT
      id,
      destHostName,
      webName,
      cast( SUBSTRING_INDEX( visitCount, ',',- 1 ) AS SIGNED ) visit,
      accessRateValue,
      accessMonitor,
      accessRate 
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```

- 修改建议：
  
  示例1：
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      substring_index( "visitCount", ',',- 1 )::int  visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **说明：substring_index是自定义函数。**
  
  示例2：
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      cast(substring_index( "visitCount", ',',- 1 ) AS int4)  visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **说明：substring_index是自定义函数。**
  
  **示例3（建议）：**
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      (string_to_array("visitCount", ','))[array_length(string_to_array("visitCount", ','), 1)]::int4 visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```
  
  **示例4（建议）：**
  
  ```
  SELECT
      id,
      "destHostName",
      "webName",
      (string_to_array("visitCount", ','))[7]::int4 visit,
      "accessRateValue",
      "accessMonitor",
      "accessRate"
  FROM
      t_web_info 
  ORDER BY
      visit DESC;
  ```

- 说明
  
  有没有发现只有id和visit没有使用双引号？**请不要使用大写字段名！！！**

#### [SUBSTRING_INDEX](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=substring_index)

- 示例同[cast](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=cast)

#### [FIND_IN_SET(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_setstrstrlist)

- 业务场景：根据资产标签统计在线数量和风险数量

- mysql语句：
  
  ```
  SELECT
      COUNT( CASE WHEN r.assetState = 'online' OR r.assetOnlineMonitor = 0 THEN 1 END ) AS `online`,
      COUNT( CASE WHEN r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ) THEN 1 END ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURDATE() 
      WHERE
          FIND_IN_SET( 'AR网关', ai.asset_label ) 
      ) r;
  ```

- 修改建议：
  
  **示例1，使用any和string_to_array实现（建议）：**
  
  ```
  SELECT 
      COUNT( IF ( r.assetState = 'online' OR r.assetOnlineMonitor = 0, 1, NULL ) ) AS online,
      COUNT( IF ( r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ), 1, NULL ) ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURRENT_DATE 
      WHERE
      'AR网关' = ANY ( string_to_array( ai.asset_label, ',' ) ) 
      ) r;
  ```
  
  示例2，[自定义find_in_set(str,strlist)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=find_in_set_impl)函数实现：
  
  ```
  SELECT 
      COUNT( IF ( r.assetState = 'online' OR r.assetOnlineMonitor = 0, 1, NULL ) ) AS online,
      COUNT( IF ( r.assetHealthState IN ( 'low_risk', 'medium_risk', 'high_risk', 'fallen' ), 1, NULL ) ) AS risk 
  FROM
      (
      SELECT DISTINCT
          ai.asset_label,
          ai.asset_id AS assetId,
          asr.asset_state AS assetState,
          ai.asset_online_monitor AS assetOnlineMonitor,
          ar.asset_health_state AS assetHealthState 
      FROM
          t_asset_information ai
          LEFT JOIN t_asset_statistical_results asr ON ai.asset_id = asr.asset_id
          LEFT JOIN t_asset_rating ar ON ai.asset_id = ar.asset_id 
          AND ar.rating_time >= CURRENT_DATE 
      WHERE
          FIND_IN_SET( 'AR网关', ai.asset_label ) 
      ) r;
  ```

#### [GROUP_CONCAT()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=group_concat)

- 业务场景：查询资产的名称和所有IP标识

- mysql语句：
  
  ```
  SELECT DISTINCT
      CONCAT( tai.asset_name, '(', taid.identification, ')' ) 
  FROM
      t_asset_information tai
      LEFT JOIN 
      ( 
          SELECT 
              GROUP_CONCAT( identification ) AS identification, 
              asset_id FROM t_asset_identification 
          WHERE identification_type IN ( 'private_ip', 'public_ip' )
          GROUP BY asset_id  
      ) taid ON tai.asset_id = taid.asset_id;
  ```

- 修改建议：
  
  示例1，使用array_to_string函数和聚合函数array_agg组合实现：
  
  ```
  SELECT DISTINCT
      CONCAT( tai.asset_name, '(', taid.identification, ')' ) 
  FROM
      t_asset_information tai
      LEFT JOIN 
      ( 
          SELECT 
              array_to_string(array_agg(identification), ',') AS identification, 
              asset_id FROM t_asset_identification 
          WHERE identification_type IN ( 'private_ip', 'public_ip' )
          GROUP BY asset_id
      ) taid ON tai.asset_id = taid.asset_id;
  ```

#### [DATE_FORMAT(date,format)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=date_formatdateformat)

- 业务场景：查询工单创建操作行为记录

- mysql语句：
  
  ```
  SELECT
      serial_id,
      operater,
      operater_host_address AS operaterHostAddress,
      action AS actionCode,
      date_format( created_at, '%Y-%m-%d %H:%i:%s' ) AS operationTime,
      operater_operations AS operaterOperationsContent 
  FROM
      t_work_order_operation_history 
  ORDER BY
      operationTime ASC
  ```

- 修改建议：
  
  示例：
  
  ```
  SELECT
      serial_id,
      operater,
      operater_host_address AS operaterHostAddress,
      "action" AS actionCode,
      to_char(created_at, 'YYYY-MM-DD HH24:MI:SS') AS operationTime,
      operater_operations AS operaterOperationsContent 
  FROM
      t_work_order_operation_history 
  ORDER BY
      operationTime ASC
  ```

#### [IFNULL(value1,value2)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifnullvalue1value2)

- 业务场景：查询重点关注用户(根据用户表查询, 可能出现用户表里有数据, 但ueba数据信息表里没有)

- mysql语句：
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      ifnull( m.seven_days_score, 0 ) seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```

- 修改建议：
  
  **示例1（建议）：**
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      case when m.seven_days_score is NULL then 0 else m.seven_days_score end seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```
  
  示例2：
  
  ```
  SELECT
      u.id,
      u.name,
      u.sex,
      u.interest,
      u.organisation,
      u.post,
      u.employee_number,
      u.state,
      u.pic,
      m.time,
      ifnull( m.seven_days_score, 0 ) seven_days_score,
      m.last_login_time 
  FROM
      (
      SELECT
          * 
      FROM
          t_ueba_user_msg 
      WHERE
      time = #{ time }) m
      RIGHT JOIN t_ueba_user u ON m.userId = u.id 
  WHERE
      u.interest = 1 
  ORDER BY
      seven_days_score DESC 
      LIMIT #{offset},#{limit}
  ```

#### [CURDATE()](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=curdate)

- 业务场景：查询组织架构下高风险资产的数量

- mysql语句：
  
  ```
  SELECT
      t1.asset_id 
  FROM
      t_asset_information t1
      LEFT JOIN t_asset_rating t2 ON t1.asset_id = t2.asset_id 
  WHERE
      t2.create_time >= CURDATE() 
      AND (
      t2.asset_health_state != 'healthy')
  ```

- 修改建议：
  
  示例：
  
  ```
  SELECT
      t1.asset_id 
  FROM
      t_asset_information t1
      LEFT JOIN t_asset_rating t2 ON t1.asset_id = t2.asset_id 
  WHERE
      t2.create_time >= CURRENT_DATE 
      AND (
      t2.asset_health_state != 'healthy')
  ```

- 说明
  
  **CURRENT_DATE不是函数，不要写括号**

#### [IF(expr1,expr2,expr3)](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=ifexpr1expr2expr3)

- 业务场景：修改资产同步配置开关

- mysql语句：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = IF (#{enable}, 1, 0)
  WHERE
      id = #{configId}
  ```

- 修改建议：
  
  示例1，使用[自定义函数if](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=if_impl)实现：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = IF (#{enable}, 1, 0)
  WHERE
      id = #{configId}
  ```
  
  示例2，使用类型转换实现：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = #{enable}::int4
  WHERE
      id = #{configId}
  ```
  
  示例3，sync_asset字段改为bool类型：
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = #{enable}
  WHERE
      id = #{configId}
  ```
  
  **示例4，使用case when实现（推荐）：**
  
  ```
  UPDATE t_security_device_info 
  SET sync_asset = case #{enable} when 1 then true else false end
  WHERE
      id = #{configId}
  ```

### [4.自定义函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e8%87%aa%e5%ae%9a%e4%b9%89%e5%87%bd%e6%95%b0)

- #### [创建函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%88%9b%e5%bb%ba%e5%87%bd%e6%95%b0)
  
  ##### [语法：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%af%ad%e6%b3%95%ef%bc%9a)
  
  ```
  CREATE FUNCTION somefunc(integer, text) RETURNS integer
  AS 'function body text'
  LANGUAGE plpgsql;
  ```
  
  ##### [示例：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%a4%ba%e4%be%8b%ef%bc%9a)
  
  ```
  CREATE FUNCTION my_add ( n1 INTEGER, n2 INTEGER ) RETURNS INTEGER AS $$ BEGIN
      RETURN n1 + n2;
  END $$ LANGUAGE plpgsql;
  ```

- #### [调用函数](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%b0%83%e7%94%a8%e5%87%bd%e6%95%b0)
  
  ```
  select my_add(1,2);
  ```

### [4.存储过程](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b)

- #### [创建存储过程](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%88%9b%e5%bb%ba%e5%ad%98%e5%82%a8%e8%bf%87%e7%a8%8b)
  
  ##### [示例：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%a4%ba%e4%be%8b%ef%bc%9a-1)
  
  ```
  CREATE PROCEDURE triple(INOUT x int)
  LANGUAGE plpgsql
  AS $$
  BEGIN
      x := x * 3;
  END;
  $$;
  ```

- #### [调用](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%b0%83%e7%94%a8)
  
  ```
  call triple(3);
  ```

- ### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%ae%98%e6%96%b9%e6%96%87%e6%a1%a3)[官方文档](https://www.postgresql.org/docs/13/plpgsql-control-structures.html#PLPGSQL-STATEMENTS-RETURNING-PROCEDURE)

$$ 不推荐使用存储过程 $$

## [五、触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%ba%94%e3%80%81%e8%a7%a6%e5%8f%91%e5%99%a8)

### [1.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%a7%a6%e5%8f%91%e5%99%a8)[触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%a7%a6%e5%8f%91%e5%99%a8)

### [2.事件触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e4%ba%8b%e4%bb%b6%e8%a7%a6%e5%8f%91%e5%99%a8)

为了补充[第 38 章](https://www.postgresql.org/docs/13/triggers.html)中讨论的触发机制，PostgreSQL还提供了事件触发器。与附加到单个表并仅捕获 DML 事件的常规触发器不同，事件触发器对特定数据库是全局的，并且能够捕获 DDL 事件。

与常规触发器一样，事件触发器可以用任何包括事件触发器支持的过程语言编写，也可以用 C 编写，但不能用普通 SQL 编写。

参见[事件触发器](https://www.postgresql.org/docs/13/event-triggers.html)

## [六、建表语句修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%85%ad%e3%80%81%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)

可以使用navicat帮我们转换成postgresql语句，但是会有一些问题；

### [1.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%bb%ba%e8%a1%a8%e8%af%ad%e6%b3%95)[建表语法](https://www.postgresql.org/docs/13/sql-createtable.html)

```
CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name ( [
  { column_name data_type [ COLLATE collation ] [ column_constraint [ ... ] ]
    | table_constraint
    | LIKE source_table [ like_option ... ] }
    [, ... ]
] )
[ INHERITS ( parent_table [, ... ] ) ]
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]

CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
    OF type_name [ (
  { column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
    | table_constraint }
    [, ... ]
) ]
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]

CREATE [ [ GLOBAL | LOCAL ] { TEMPORARY | TEMP } | UNLOGGED ] TABLE [ IF NOT EXISTS ] table_name
    PARTITION OF parent_table [ (
  { column_name [ WITH OPTIONS ] [ column_constraint [ ... ] ]
    | table_constraint }
    [, ... ]
) ] { FOR VALUES partition_bound_spec | DEFAULT }
[ PARTITION BY { RANGE | LIST | HASH } ( { column_name | ( expression ) } [ COLLATE collation ] [ opclass ] [, ... ] ) ]
[ USING method ]
[ WITH ( storage_parameter [= value] [, ... ] ) | WITHOUT OIDS ]
[ ON COMMIT { PRESERVE ROWS | DELETE ROWS | DROP } ]
[ TABLESPACE tablespace_name ]
```

### [2.字段和表的引用修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e5%ad%97%e6%ae%b5%e5%92%8c%e8%a1%a8%e7%9a%84%e5%bc%95%e7%94%a8%e4%bf%ae%e6%94%b9)

```
`table_name` 改为 "table_name"
`column_name` 改为 "column_name"
```

### [3.主键策略修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e4%b8%bb%e9%94%ae%e7%ad%96%e7%95%a5%e4%bf%ae%e6%94%b9)

参见[自增主键](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%87%aa%e5%a2%9e%e4%b8%bb%e9%94%ae)和[UUID](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=uuid)

### [4.字段类型修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e5%ad%97%e6%ae%b5%e7%b1%bb%e5%9e%8b%e4%bf%ae%e6%94%b9)

参见[常用数据类型映射](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e6%95%b0%e6%8d%ae%e7%b1%bb%e5%9e%8b%e6%98%a0%e5%b0%84)

### [5.字符串修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5%e5%ad%97%e7%ac%a6%e4%b8%b2%e4%bf%ae%e6%94%b9)

- 字符串标识由双引号修改为单引号;
  
  例如：
  
  ```
  mysql: SELECT "字符串" str;
  postgresql: SELECT '字符串' str;
  ```

- char(n),varchar(n)类型，存储中文的，n要乘以4兼容openGauss

### [6.字段和表注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6%e5%ad%97%e6%ae%b5%e5%92%8c%e8%a1%a8%e6%b3%a8%e9%87%8a)

- #### [字段注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%ad%97%e6%ae%b5%e6%b3%a8%e9%87%8a)
  
  mysql字段注释紧跟字段后面，pg字段注释是单独的sql语句；
  
  ps语法：`COMMENT ON COLUMN "table_name"."column_name" IS '字段注释';`

- #### [表注释](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e8%a1%a8%e6%b3%a8%e9%87%8a)
  
  mysql表注释紧跟在表后面，pg表注释是单独的sql语句；
  
  pg语法：`COMMENT ON TABLE "table_name" IS '表注释';`

### [7.触发器](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_7%e8%a7%a6%e5%8f%91%e5%99%a8)

1. 定义表
   
   创建需要触发器的表，例如：
   
   ```
   CREATE TABLE ttest (
      "id" serial primary key,
        "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
   );
   ```

2. 编写触发函数
   
   - 触发函数支持的语言：`PL/pgSQL`
   
   - 触发函数示例
     
     pgsql示例：
     
     ```
     CREATE 
        OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
            NEW.update_time = CURRENT_TIMESTAMP;
        RETURN NEW;
     END $$ LANGUAGE plpgsql;
     ```

3. 声明触发器
   
   ```
   --操作之前填充更新时间:
   CREATE TRIGGER before_trigger BEFORE UPDATE ON ttest
          FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
   
   --操作之前执行:
   CREATE TRIGGER tbefore BEFORE INSERT OR UPDATE OR DELETE ON ttest
      FOR EACH ROW EXECUTE FUNCTION trigf();
   
   --操作之后执行:
   CREATE TRIGGER tafter AFTER INSERT OR UPDATE OR DELETE ON ttest
      FOR EACH ROW EXECUTE FUNCTION trigf();
   ```

4. [触发器官方文档](https://www.postgresql.org/docs/13/trigger-definition.html)

### [8.索引](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_8%e7%b4%a2%e5%bc%95)

pg创建索引语法：

```
CREATE INDEX name ON table [USING index_type] (column [collation] [asc || desc] [NULLS] [LAST || FIRST]);
```

mysql中的key对应pg中create index，例如：

```
mysql:
CREATE TABLE ttest (
    `id` int(11) PRIMARY KEY,
      `code` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        KEY `idx_code` (`code`) USING BTREE
);

postgresql:
CREATE TABLE ttest (
    "id" int PRIMARY KEY,
      "code" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX idx_code ON ttest USING btree ("code" ASC NULLS FIRST);
```

**注意：mysql创建的索引默认null在最后，pg可以指定，不指定默认为 ASC NULLS LAST。**

### [9.字段、数据库命名](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_9%e5%ad%97%e6%ae%b5%e3%80%81%e6%95%b0%e6%8d%ae%e5%ba%93%e5%91%bd%e5%90%8d)

- 将包含大写的字段修改为下划线命名

- database名字按照标识符命名规则重新命名，openGauss不支持中划线命名
  
  如：bigdata-web→bigdata_web

### [10.完整示例](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_10%e5%ae%8c%e6%95%b4%e7%a4%ba%e4%be%8b)

```
mysql:
CREATE TABLE `t_asset_information` (
  `asset_id` VARCHAR ( 100 ) NOT NULL COMMENT '资产ID-资产唯一标识',
    `asset_name` VARCHAR ( 100 ) NOT NULL COMMENT '资产名称-便于查看及识别',
     PRIMARY KEY ( `asset_id` ) 
) ENGINE = INNODB DEFAULT CHARSET = utf8 COMMENT='资产信息表';

CREATE TABLE `t_asset_monitor_port_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `asset_id` varchar(100) DEFAULT NULL COMMENT '资产ID-资产唯一标识',
  `asset_ip` varchar(45) NOT NULL COMMENT '资产ip',
  `port` varchar(45) NOT NULL COMMENT '端口',
  `protocol` varchar(100) DEFAULT NULL COMMENT '协议',
  `service_name` varchar(500) DEFAULT NULL COMMENT '服务名',
  `server_version` varchar(500) DEFAULT NULL COMMENT '服务版本',
  `status` char(1) NOT NULL COMMENT '端口状态，1：开启，0：关闭',
  `message` varchar(255) DEFAULT NULL COMMENT '描述信息',
  `find_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发现时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `source` varchar(100) DEFAULT NULL COMMENT '端口来源 AiNTA',
  `fingerprint_name` varchar(100) DEFAULT NULL COMMENT '指纹名称',
  `fingerprint_class2` varchar(100) DEFAULT NULL COMMENT '指纹二级类型（指纹类型）',
  `vendor_name` varchar(100) DEFAULT NULL COMMENT '厂商：中文名（英文名）',
  `tag` text COMMENT '产品标签',
  PRIMARY KEY (`id`),
  KEY `idx_asset_ip` (`asset_ip`) USING BTREE,
  UNIQUE KEY `unique_asset_id_asset_ip_port` (`asset_id`,`asset_ip`,`port`),
  CONSTRAINT `foreign_key_monitor_port_info_to_asset_id_4` FOREIGN KEY (`asset_id`) REFERENCES `t_asset_information` (`asset_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主机资产-端口';

postgresql:
CREATE TABLE "t_asset_information" (
 "asset_id" VARCHAR ( 100 ) PRIMARY KEY,
    "asset_name" VARCHAR ( 400 )
);
COMMENT ON COLUMN "t_asset_information"."asset_id" IS '资产ID-资产唯一标识';
COMMENT ON COLUMN "t_asset_information"."asset_name" IS '资产名称-便于查看及识别';
COMMENT ON TABLE "t_asset_information" IS '资产信息表';

CREATE TABLE "t_asset_monitor_port_info" (
    "id" bigserial NOT NULL,
    "asset_id" VARCHAR ( 100 ) DEFAULT NULL,
    "asset_ip" VARCHAR ( 45 ) NOT NULL,
    "port" VARCHAR ( 45 ) NOT NULL,
    "protocol" VARCHAR ( 100 ) DEFAULT NULL,
    "service_name" VARCHAR ( 2000 ) DEFAULT NULL,
    "server_version" VARCHAR ( 500 ) DEFAULT NULL,
    "status" "char" NOT NULL,
    "message" VARCHAR ( 1020 ) DEFAULT NULL,
    "find_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "create_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "update_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "source" VARCHAR ( 100 ) DEFAULT NULL,
    "fingerprint_name" VARCHAR ( 400 ) DEFAULT NULL,
    "fingerprint_class2" VARCHAR ( 400 ) DEFAULT NULL,
    "vendor_name" VARCHAR ( 400 ) DEFAULT NULL,
    "tag" TEXT,
    PRIMARY KEY ( "id" ),
    CONSTRAINT "unique_asset_id_asset_ip_port" UNIQUE ( "asset_id", "asset_ip", "port" ),
    CONSTRAINT "foreign_key_monitor_port_info_to_asset_id" FOREIGN KEY ( "asset_id" ) REFERENCES "t_asset_information" ( "asset_id" ) ON DELETE CASCADE ON UPDATE CASCADE 
);
CREATE INDEX "idx_asset_ip" ON "t_asset_monitor_port_info" USING btree ("asset_ip" ASC NULLS FIRST);
COMMENT ON COLUMN "t_asset_monitor_port_info"."id" IS '主键Id';
COMMENT ON COLUMN "t_asset_monitor_port_info"."asset_id" IS '资产ID-资产唯一标识';
COMMENT ON COLUMN "t_asset_monitor_port_info"."asset_ip" IS '资产ip';
COMMENT ON COLUMN "t_asset_monitor_port_info"."port" IS '端口';
COMMENT ON COLUMN "t_asset_monitor_port_info"."protocol" IS '协议';
COMMENT ON COLUMN "t_asset_monitor_port_info"."service_name" IS '服务名';
COMMENT ON COLUMN "t_asset_monitor_port_info"."server_version" IS '服务版本';
COMMENT ON COLUMN "t_asset_monitor_port_info"."status" IS '端口状态，1：开启，0：关闭';
COMMENT ON COLUMN "t_asset_monitor_port_info"."message" IS '描述信息';
COMMENT ON COLUMN "t_asset_monitor_port_info"."find_time" IS '发现时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."create_time" IS '创建时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."update_time" IS '修改时间';
COMMENT ON COLUMN "t_asset_monitor_port_info"."source" IS '端口来源 AiNTA';
COMMENT ON COLUMN "t_asset_monitor_port_info"."fingerprint_name" IS '指纹名称';
COMMENT ON COLUMN "t_asset_monitor_port_info"."fingerprint_class2" IS '指纹二级类型（指纹类型）';
COMMENT ON COLUMN "t_asset_monitor_port_info"."vendor_name" IS '厂商：中文名（英文名）';
COMMENT ON COLUMN "t_asset_monitor_port_info"."tag" IS '产品标签';
COMMENT ON TABLE "t_asset_monitor_port_info" IS '主机资产-端口';

CREATE 
    OR REPLACE FUNCTION upg_timestamp ( ) RETURNS TRIGGER AS $$ BEGIN
        NEW.update_time = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER "t_asset_monitor_port_info_upd_trigger" BEFORE UPDATE ON "t_asset_monitor_port_info" FOR EACH ROW EXECUTE PROCEDURE upg_timestamp ( );
```

## [七、事件替换](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b8%83%e3%80%81%e4%ba%8b%e4%bb%b6%e6%9b%bf%e6%8d%a2)

postgresql只有事件触发器，不包含定时触发，mysql事件改为代码实现。

## [八、视图处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%85%ab%e3%80%81%e8%a7%86%e5%9b%be%e5%a4%84%e7%90%86)

### [1.视图语法](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e8%a7%86%e5%9b%be%e8%af%ad%e6%b3%95)

```
CREATE TABLE myview (same column list as mytab);
ALTER TABLE myview OWNER TO "user_name";
```

### [2.示例](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2%e7%a4%ba%e4%be%8b)

```
CREATE VIEW "asset_port" AS  SELECT t_asset_monitor_port_info.id,
    t_asset_monitor_port_info.asset_id,
    t_asset_monitor_port_info.asset_ip,
    t_asset_monitor_port_info.port,
    t_asset_monitor_port_info.protocol,
    t_asset_monitor_port_info.status
   FROM test.t_asset_monitor_port_info;

ALTER TABLE "asset_port" OWNER TO "postgres";
```

### [3.](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3%e5%ae%98%e6%96%b9%e6%96%87%e6%a1%a3)[官方文档](https://www.postgresql.org/docs/13/rules-views.html)

## [九、分表处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%b9%9d%e3%80%81%e5%88%86%e8%a1%a8%e5%a4%84%e7%90%86)

使用分区功能实现分表，表分区通过继承实现，可以单独查询分区表数据，也可以查询主分区，主分区包含全部分区数据，可以通过trigger和check来约束分区，同时插入数据时不指定具体分区插入到主分区，由trigger来完成分区。

[详见官网](https://www.postgresql.org/docs/13/ddl-partitioning.html)

**openGauss不支持继承**

## [十、数据迁移](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e3%80%81%e6%95%b0%e6%8d%ae%e8%bf%81%e7%a7%bb)

### [1.简介](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e7%ae%80%e4%bb%8b)

由于mysql导出的导出sql类型的数据，sql中表名和字段名的表示方式不同，不推荐sql文件形式导入。

### [2.csv导入](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2csv%e5%af%bc%e5%85%a5)

- #### [从mysql导出csv文件](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bb%8emysql%e5%af%bc%e5%87%bacsv%e6%96%87%e4%bb%b6)
  
  ```
  select * from t_asset_monitor_port_info into outfile "/var/lib/mysql-files/t_asset_monitor_port_info.csv" character set utf8 fields terminated by ',' optionally enclosed by '"' lines terminated by '\r\n';
  ```

- #### [导入csv到postgresql](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%af%bc%e5%85%a5csv%e5%88%b0postgresql)
  
  ```
  copy t_asset_monitor_port_info 
  from '/var/lib/mysql-files/t_asset_monitor_port_info.csv' 
  DELIMITER ','
  CSV;
  ```

### [3.datax导入](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3datax%e5%af%bc%e5%85%a5)

[datax官网](https://github.com/alibaba/DataX/blob/master/introduction.md)

## [十一、修改项目配置](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%b8%80%e3%80%81%e4%bf%ae%e6%94%b9%e9%a1%b9%e7%9b%ae%e9%85%8d%e7%bd%ae)

### [1.pom.xml](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1pomxml)

新增postgresql驱动依赖

```
<dependency>
  <groupId>org.postgresql</groupId>
  <artifactId>postgresql</artifactId>
</dependency>
```

### [2.application.properties](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2applicationproperties)

修改数据库连接信息和驱动

```
spring.datasource.driver-class-name=org.postgresql.Driver
```

## [十二、SQL修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%ba%8c%e3%80%81sql%e4%bf%ae%e6%94%b9)

### [1.参考](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1%e5%8f%82%e8%80%83%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)[建表语句修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%bb%ba%e8%a1%a8%e8%af%ad%e5%8f%a5%e4%bf%ae%e6%94%b9)

### [2.insert冲突处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2insert%e5%86%b2%e7%aa%81%e5%a4%84%e7%90%86)

```
mysql:
INSERT INTO t_asset_information ( asset_id, asset_name, org_id, net_id )
VALUES
    ( 'asset_00008519-b728-4b00-857a-9be4e4cf537d_1657273055277', '10.2.51.88', '12bbcbcf-d8e8-4009-a8ba-a043f96f5ae8', '12bbcbcf-d8e8-4009-a8ba-a043f96f5ae8' ) 
    ON DUPLICATE KEY UPDATE asset_name = '10.2.51.88';

postgresql:
INSERT INTO "t_asset_information" ( "asset_id", "asset_name" )
VALUES
    ( 'asset_00008519-b728-4b00-857a-9be4e4cf537d_1657273055277', '10.2.51.88' ) ON CONFLICT ( asset_id ) DO
UPDATE 
    SET asset_name = '10.2.51.65';
```

### [3.schema处理](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3schema%e5%a4%84%e7%90%86)

**postgresql未指定schema时默认查询public，如果使用的非public，请指定schema。**

- 实体类
  
  ```
  @TableName(value="test.t_asset_monitor_port_info")
  或者
  @TableName(value="t_asset_monitor_port_info", schema="test")
  ```

- sql
  
  ```
  SELECT ID
      ,
      asset_id,
      asset_ip,
      port,
      protocol,
      service_name,
      server_version,
      status,
      message,
      find_time,
      create_time,
      update_time,
      SOURCE,
      fingerprint_name,
      fingerprint_class2,
      vendor_name,
      tag 
  FROM
      test.t_asset_monitor_port_info
  ```

### [4.运算符修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4%e8%bf%90%e7%ae%97%e7%ac%a6%e4%bf%ae%e6%94%b9)

​ [运算符对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e8%bf%90%e7%ae%97%e7%ac%a6%e5%af%b9%e7%85%a7%e8%a1%a8)

### [5.函数修改](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5%e5%87%bd%e6%95%b0%e4%bf%ae%e6%94%b9)

​ [常用函数对照表](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%b8%b8%e7%94%a8%e5%87%bd%e6%95%b0%e5%af%b9%e7%85%a7%e8%a1%a8)

### [6.group by和order by](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6group-by%e5%92%8corder-by)

​ postgresql的order by字段必须出现在select后面；

​ postgresql的group by语句中select字段必须出现在group by后面或者使用聚合函数。

## [十三、涉及组件](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%b8%89%e3%80%81%e6%b6%89%e5%8f%8a%e7%bb%84%e4%bb%b6)

### [1.flywaydb](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1flywaydb)

[官方文档](https://flywaydb.org/documentation/)显示支持postgresql，但是不支持openGauss，需要测试语法兼容openGauss的情况下能不能正常使用。

### [2.nacos](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2nacos)

nacos不支持postgresql和openGauss；

#### [建议：](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%bb%ba%e8%ae%ae%ef%bc%9a)

1. 使用内置数据源
2. 使用java agent，不支持openGauss，地址:[GitHub - ccwxl/mysql2postgresql-jdbc-agent: Non-invasive replacement of mysql to postgresql , jdbc javaagent](https://github.com/siaron/mysql2postgresql-jdbc-agent)

## [十四、集群方式](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e5%9b%9b%e3%80%81%e9%9b%86%e7%be%a4%e6%96%b9%e5%bc%8f)

### [1.citus](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1citus)

Citus 是 Postgres 的一个**开源扩展**，它在集群中的多个节点上分布数据和查询。因为 Citus 是 Postgres 的扩展（**不是 fork**），所以当您使用 Citus 时，您也在使用 Postgres。您可以利用最新的 Postgres 功能、工具和生态系统。

Citus 将 Postgres 转换为具有分片、分布式 SQL 引擎、引用表和分布式表等功能的分布式数据库。Citus 将并行性、在内存中保留更多数据和更高的 I/O 带宽相结合，可以显着提高多租户 SaaS 应用程序、面向客户的实时分析仪表板和时间序列工作负载的性能。

- #### [优点](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e4%bc%98%e7%82%b9)
  
  文档丰富；
  
  开源；
  
  只是PostgreSQL的一个extension；
  
  横向扩展方便；
  
  支持常用DDL；
  
  支持实时增删改查；
  
  支持聚合下推；
  
  支持分布式事务；
  
  支持并行查询。

- #### [缺点](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e7%bc%ba%e7%82%b9)
  
  多语句事务没有防止死锁的安全措施；
  
  没有针对中间查询失败和由此产生的不一致的安全措施；
  
  查询结果缓存在内存中；这些函数不能处理非常大的结果集；
  
  如果无法连接到节点，这些函数会提前出错；
  
  SQL限制。

- #### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=citus%e5%ae%98%e7%bd%91)[citus官网](https://docs.citusdata.com/en/v11.0/?_gl=1*1i2q6bs*_ga*MjcwMDQ1NzI5LjE2NTg3MzI0MjM.*_ga_DS5S1RKEB7*MTY1ODczMjQyMy4xLjEuMTY1ODczMjQ0Ny4w)

- #### [](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=sql%e5%92%8c%e8%a7%a3%e5%86%b3%e6%96%b9%e6%b3%95)[SQL和解决方法](https://docs.citusdata.com/en/v11.0/develop/reference_workarounds.html#)

### [2.Patroni + Etcd](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2patroni-etcd)

基于 [Patroni](https://patroni.readthedocs.io/en/latest/index.html) + [Etcd](https://etcd.io/docs/v3.4.0/) 的高可用方案，此方案使用Patroni管理本地库，并结合Etcd作为数据存储和主节点选举。

Patroni基于Python开发的模板，结合DCS(例如 ZooKeeper, etcd, Consul )可以定制PostgreSQL高可用方案。 Patroni并不是一套拿来即用的PostgreSQL高可用组件，涉及较多的配置和定制工作，Patroni 本身使用的数据同步方式是postgresql的流复制方式，默认的情况我们还是使用异步的方式，在Patroni 中会有一个参数，Maximum_lag_on_failover ,通过设置，保证从库在与主库超过一定数据不同步的情况下，不会发生相关的主从转移。 Patroni接管PostgreSQL数据库的启停，同时监控本地的PostgreSQL数据库，并将本地的PostgreSQL数据库信息写入DCS。 Patroni的主备端是通过是否能获得 leader key 来控制的，获取到了leader key的Patroni为主节点，其它的为备节点。

Etcd是一款基于Raft算法和协议开发的分布式 key-value 数据库，基于Go语言编写，Patroni监控本地的PostgreSQL状态，并将相关信息写入Etcd，每个Patroni都能读写Etcd上的key，从而获取外地PostgreSQL数据库信息。

- 优点
  
  健壮性: 使用分布式key-value数据库作为数据存储，主节点故障时进行主节点重新选举，具有很强的健壮性；
  
  支持主备延迟设置: 可以设置备库延迟主库WAL的字节数，当备库延迟大于指定值时不做故障切换；
  
  自动化程度高：
  
  1. 支持自动化初始PostgreSQL实例并部署流复制;
  2. 当备库实例关闭后，支持自动拉起;
  3. 当主库实例关闭后，首先会尝试自动拉起;
  4. 支持switchover命令，能自动将老的主库进行角色转换。
  
  避免脑裂: 数据库信息记录到 ETCD 中，通过优化部署策略（多机房部署、增加实例数)可以避免脑裂。

- 缺点
  
  搭建繁琐，需要安装不同的组件，及配置项；
  
  无组合使用的官方文档；
  
  读写需要访问不同的接口。

## [十五、附录](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=%e5%8d%81%e4%ba%94%e3%80%81%e9%99%84%e5%bd%95)

### [1.postgresql类型](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_1postgresql%e7%b1%bb%e5%9e%8b)

| Name                                          | Aliases                      | Description                                                        |
| --------------------------------------------- | ---------------------------- | ------------------------------------------------------------------ |
| `bigint`                                      | `int8`                       | signed eight-byte integer                                          |
| `bigserial`                                   | `serial8`                    | autoincrementing eight-byte integer                                |
| `bit [ (*`n`*) ]`                             |                              | fixed-length bit string                                            |
| `bit varying [ (*`n`*) ]`                     | `varbit [ (*`n`*) ]`         | variable-length bit string                                         |
| `boolean`                                     | `bool`                       | logical Boolean (true/false)                                       |
| `box`                                         |                              | rectangular box on a plane                                         |
| `bytea`                                       |                              | binary data (“byte array”)                                         |
| `character [ (*`n`*) ]`                       | `char [ (*`n`*) ]`           | fixed-length character string                                      |
| `character varying [ (*`n`*) ]`               | `varchar [ (*`n`*) ]`        | variable-length character string                                   |
| `cidr`                                        |                              | IPv4 or IPv6 network address                                       |
| `circle`                                      |                              | circle on a plane                                                  |
| `date`                                        |                              | calendar date (year, month, day)                                   |
| `double precision`                            | `float8`                     | double precision floating-point number (8 bytes)                   |
| `inet`                                        |                              | IPv4 or IPv6 host address                                          |
| `integer`                                     | `int`, `int4`                | signed four-byte integer                                           |
| `interval [ *`fields`* ] [ (*`p`*) ]`         |                              | time span                                                          |
| `json`                                        |                              | textual JSON data                                                  |
| `jsonb`                                       |                              | binary JSON data, decomposed                                       |
| `line`                                        |                              | infinite line on a plane                                           |
| `lseg`                                        |                              | line segment on a plane                                            |
| `macaddr`                                     |                              | MAC (Media Access Control) address                                 |
| `macaddr8`                                    |                              | MAC (Media Access Control) address (EUI-64 format)                 |
| `money`                                       |                              | currency amount                                                    |
| `numeric [ (*`p`*, *`s`*) ]`                  | `decimal [ (*`p`*, *`s`*) ]` | exact numeric of selectable precision                              |
| `path`                                        |                              | geometric path on a plane                                          |
| `pg_lsn`                                      |                              | PostgreSQL Log Sequence Number                                     |
| `pg_snapshot`                                 |                              | user-level transaction ID snapshot                                 |
| `point`                                       |                              | geometric point on a plane                                         |
| `polygon`                                     |                              | closed geometric path on a plane                                   |
| `real`                                        | `float4`                     | single precision floating-point number (4 bytes)                   |
| `smallint`                                    | `int2`                       | signed two-byte integer                                            |
| `smallserial`                                 | `serial2`                    | autoincrementing two-byte integer                                  |
| `serial`                                      | `serial4`                    | autoincrementing four-byte integer                                 |
| `text`                                        |                              | variable-length character string                                   |
| `time [ (*`p`*) ] [ without time zone ]`      |                              | time of day (no time zone)                                         |
| `time [ (*`p`*) ] with time zone`             | `timetz`                     | time of day, including time zone                                   |
| `timestamp [ (*`p`*) ] [ without time zone ]` |                              | date and time (no time zone)                                       |
| `timestamp [ (*`p`*) ] with time zone`        | `timestamptz`                | date and time, including time zone                                 |
| `tsquery`                                     |                              | text search query                                                  |
| `tsvector`                                    |                              | text search document                                               |
| `txid_snapshot`                               |                              | user-level transaction ID snapshot (deprecated; see `pg_snapshot`) |
| `uuid`                                        |                              | universally unique identifier                                      |
| `xml`                                         |                              | XML data                                                           |

### [2.postgresql日期pattern](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_2postgresql%e6%97%a5%e6%9c%9fpattern)

| Pattern                          | Description                                                                                                                                               |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `HH`                             | hour of day (01–12)                                                                                                                                       |
| `HH12`                           | hour of day (01–12)                                                                                                                                       |
| `HH24`                           | hour of day (00–23)                                                                                                                                       |
| `MI`                             | minute (00–59)                                                                                                                                            |
| `SS`                             | second (00–59)                                                                                                                                            |
| `MS`                             | millisecond (000–999)                                                                                                                                     |
| `US`                             | microsecond (000000–999999)                                                                                                                               |
| `FF1`                            | tenth of second (0–9)                                                                                                                                     |
| `FF2`                            | hundredth of second (00–99)                                                                                                                               |
| `FF3`                            | millisecond (000–999)                                                                                                                                     |
| `FF4`                            | tenth of a millisecond (0000–9999)                                                                                                                        |
| `FF5`                            | hundredth of a millisecond (00000–99999)                                                                                                                  |
| `FF6`                            | microsecond (000000–999999)                                                                                                                               |
| `SSSS`, `SSSSS`                  | seconds past midnight (0–86399)                                                                                                                           |
| `AM`, `am`, `PM` or `pm`         | meridiem indicator (without periods)                                                                                                                      |
| `A.M.`, `a.m.`, `P.M.` or `p.m.` | meridiem indicator (with periods)                                                                                                                         |
| `Y,YYY`                          | year (4 or more digits) with comma                                                                                                                        |
| `YYYY`                           | year (4 or more digits)                                                                                                                                   |
| `YYY`                            | last 3 digits of year                                                                                                                                     |
| `YY`                             | last 2 digits of year                                                                                                                                     |
| `Y`                              | last digit of year                                                                                                                                        |
| `IYYY`                           | ISO 8601 week-numbering year (4 or more digits)                                                                                                           |
| `IYY`                            | last 3 digits of ISO 8601 week-numbering year                                                                                                             |
| `IY`                             | last 2 digits of ISO 8601 week-numbering year                                                                                                             |
| `I`                              | last digit of ISO 8601 week-numbering year                                                                                                                |
| `BC`, `bc`, `AD` or `ad`         | era indicator (without periods)                                                                                                                           |
| `B.C.`, `b.c.`, `A.D.` or `a.d.` | era indicator (with periods)                                                                                                                              |
| `MONTH`                          | full upper case month name (blank-padded to 9 chars)                                                                                                      |
| `Month`                          | full capitalized month name (blank-padded to 9 chars)                                                                                                     |
| `month`                          | full lower case month name (blank-padded to 9 chars)                                                                                                      |
| `MON`                            | abbreviated upper case month name (3 chars in English, localized lengths vary)                                                                            |
| `Mon`                            | abbreviated capitalized month name (3 chars in English, localized lengths vary)                                                                           |
| `mon`                            | abbreviated lower case month name (3 chars in English, localized lengths vary)                                                                            |
| `MM`                             | month number (01–12)                                                                                                                                      |
| `DAY`                            | full upper case day name (blank-padded to 9 chars)                                                                                                        |
| `Day`                            | full capitalized day name (blank-padded to 9 chars)                                                                                                       |
| `day`                            | full lower case day name (blank-padded to 9 chars)                                                                                                        |
| `DY`                             | abbreviated upper case day name (3 chars in English, localized lengths vary)                                                                              |
| `Dy`                             | abbreviated capitalized day name (3 chars in English, localized lengths vary)                                                                             |
| `dy`                             | abbreviated lower case day name (3 chars in English, localized lengths vary)                                                                              |
| `DDD`                            | day of year (001–366)                                                                                                                                     |
| `IDDD`                           | day of ISO 8601 week-numbering year (001–371; day 1 of the year is Monday of the first ISO week)                                                          |
| `DD`                             | day of month (01–31)                                                                                                                                      |
| `D`                              | day of the week, Sunday (`1`) to Saturday (`7`)                                                                                                           |
| `ID`                             | ISO 8601 day of the week, Monday (`1`) to Sunday (`7`)                                                                                                    |
| `W`                              | week of month (1–5) (the first week starts on the first day of the month)                                                                                 |
| `WW`                             | week number of year (1–53) (the first week starts on the first day of the year)                                                                           |
| `IW`                             | week number of ISO 8601 week-numbering year (01–53; the first Thursday of the year is in week 1)                                                          |
| `CC`                             | century (2 digits) (the twenty-first century starts on 2001-01-01)                                                                                        |
| `J`                              | Julian Date (integer days since November 24, 4714 BC at local midnight; see [Section B.7](https://www.postgresql.org/docs/13/datetime-julian-dates.html)) |
| `Q`                              | quarter                                                                                                                                                   |
| `RM`                             | month in upper case Roman numerals (I–XII; I=January)                                                                                                     |
| `rm`                             | month in lower case Roman numerals (i–xii; i=January)                                                                                                     |
| `TZ`                             | upper case time-zone abbreviation (only supported in `to_char`)                                                                                           |
| `tz`                             | lower case time-zone abbreviation (only supported in `to_char`)                                                                                           |
| `TZH`                            | time-zone hours                                                                                                                                           |
| `TZM`                            | time-zone minutes                                                                                                                                         |
| `OF`                             | time-zone offset from UTC (only supported in `to_char`)                                                                                                   |

### [3.substring_index()实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_3substring_index%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION substring_index ( VARCHAR, VARCHAR, INTEGER ) RETURNS VARCHAR AS $$ DECLARE
    tokens VARCHAR [];
len INTEGER;
indexnum INTEGER;
BEGIN
    tokens := string_to_array( $1, $2 );
    len := array_upper( tokens, 1 );
    indexnum := len - ( $3 * - 1 ) + 1;
    IF
        $3 >= 0 THEN
            RETURN array_to_string( tokens [ 1 :$3 ], $2 );
        ELSE RETURN array_to_string( tokens [ indexnum : len ], $2 );
    END IF;
END;
$$ LANGUAGE PLPGSQL;
```

### [4.if(expr1,expr2,expr3)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_4ifexpr1expr2expr3%e5%ae%9e%e7%8e%b0)

```
CREATE 
OR REPLACE FUNCTION
IF
    ( expr1 anyelement, expr2 anyelement, expr3 anyelement ) RETURNS anyelement AS $$ BEGIN
    IF
        expr1::BOOLEAN THEN
            RETURN expr2;
        ELSE RETURN expr3;
    END IF;
END;
$$ LANGUAGE plpgsql;
```

### [5.ifnull(val1,val2)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_5ifnullval1val2%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION ifnull ( val1 anyelement, val2 anyelement ) RETURNS anyelement AS $$ BEGIN
    IF
        val1 IS NULL THEN
            RETURN val2;
        ELSE RETURN val1;
    END IF;
END;
$$ LANGUAGE plpgsql;
```

### [6.find_in_set(str,strlist)实现](https://scc.das-security.cn/docs/das-rds/#/localized/switchPG?id=_6find_in_setstrstrlist%e5%ae%9e%e7%8e%b0)

```
CREATE 
    OR REPLACE FUNCTION find_in_set ( str VARCHAR, strlist VARCHAR ) RETURNS BOOLEAN AS $$ BEGIN
        RETURN array_position ( string_to_array( strlist, ',' ), str ) > 0;
END;
$$ LANGUAGE plpgsql;
```

**注意：该函数返回值为boolean类型**
