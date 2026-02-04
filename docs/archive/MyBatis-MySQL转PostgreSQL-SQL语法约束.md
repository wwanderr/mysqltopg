# MyBatis XML - MySQL转PostgreSQL SQL语法约束与规范

> **目标**: 将MyBatis XML文件中的MySQL SQL语句转换为PostgreSQL 16.x兼容语法  
> **场景**: 业务代码中的查询、插入、更新、删除语句  
> **版本**: PostgreSQL 16.x  
> **最后更新**: 2026-01-14

---

## 📋 目录

1. [基本语法差异](#1-基本语法差异)
2. [查询语句转换](#2-查询语句转换)
3. [插入语句转换](#3-插入语句转换)
4. [更新语句转换](#4-更新语句转换)
5. [删除语句转换](#5-删除语句转换)
6. [函数转换大全](#6-函数转换大全)
7. [条件判断和空值处理](#7-条件判断和空值处理)
8. [分页查询转换](#8-分页查询转换)
9. [日期时间处理](#9-日期时间处理)
10. [字符串操作](#10-字符串操作)
11. [聚合和分组](#11-聚合和分组)
12. [MyBatis动态SQL处理](#12-mybatis动态sql处理)
13. [参数绑定](#13-参数绑定)
14. [特殊场景处理](#14-特殊场景处理)
15. [完整示例对比](#15-完整示例对比)

---

## 1. 基本语法差异

### 1.1 引号使用

| 用途 | MySQL | PostgreSQL | 约束规则 |
|------|-------|-----------|---------|
| 字符串 | `'string'` 或 `"string"` | **只能** `'string'` | ✅ **必须**用单引号 |
| 标识符 | `` `column` `` | `"column"` | ✅ 建议去掉引号（小写命名） |

**转换规则**:
```xml
<!-- MySQL -->
<select id="getUser">
  SELECT * FROM users WHERE name = "Alice"  <!-- ❌ 错误 -->
</select>

<!-- PostgreSQL -->
<select id="getUser">
  SELECT * FROM users WHERE name = 'Alice'  <!-- ✅ 正确 -->
</select>
```

### 1.2 表名和列名

**约束规则**:
- ✅ **推荐**: 全部使用小写+下划线命名（snake_case）
- ✅ **推荐**: 不使用引号（除非必要）
- ⚠️ 如果必须使用引号，用双引号 `"`

```xml
<!-- MySQL -->
<select id="getUser">
  SELECT `userName`, `createTime` FROM `userTable`
</select>

<!-- PostgreSQL 方案A: 转为小写（推荐） -->
<select id="getUser">
  SELECT user_name, create_time FROM user_table
</select>

<!-- PostgreSQL 方案B: 保留大小写（不推荐） -->
<select id="getUser">
  SELECT "userName", "createTime" FROM "userTable"
</select>
```

---

## 2. 查询语句转换

### 2.1 基本SELECT

**通用约束**:
- ✅ SELECT语句大部分兼容
- ⚠️ 注意函数名差异
- ⚠️ 注意类型转换语法

```xml
<!-- MySQL -->
<select id="getUserList" resultType="User">
  SELECT 
    id,
    `userName` as userName,
    `email` as email,
    DATE_FORMAT(create_time, '%Y-%m-%d') as createDate
  FROM `t_user`
  WHERE status = 1
  ORDER BY create_time DESC
  LIMIT #{offset}, #{limit}
</select>

<!-- PostgreSQL -->
<select id="getUserList" resultType="User">
  SELECT 
    id,
    user_name as userName,
    email,
    TO_CHAR(create_time, 'YYYY-MM-DD') as createDate
  FROM t_user
  WHERE status = 1
  ORDER BY create_time DESC
  LIMIT #{limit} OFFSET #{offset}
</select>
```

### 2.2 GROUP BY 严格性 ⚠️ **重要**

**PostgreSQL要求**: SELECT中的非聚合列**必须**在GROUP BY中

```xml
<!-- MySQL (宽松) -->
<select id="getUserCount">
  SELECT 
    user_id,
    user_name,  <!-- ❌ 不在GROUP BY中，MySQL允许 -->
    COUNT(*) as count
  FROM orders
  GROUP BY user_id
</select>

<!-- PostgreSQL (严格) - 方案A -->
<select id="getUserCount">
  SELECT 
    user_id,
    user_name,
    COUNT(*) as count
  FROM orders
  GROUP BY user_id, user_name  <!-- ✅ 必须包含user_name -->
</select>

<!-- PostgreSQL (严格) - 方案B -->
<select id="getUserCount">
  SELECT 
    user_id,
    MAX(user_name) as user_name,  <!-- ✅ 使用聚合函数 -->
    COUNT(*) as count
  FROM orders
  GROUP BY user_id
</select>
```

**约束规则**:
- ✅ **必须**: SELECT的每个非聚合列都要在GROUP BY中
- ✅ **或者**: 使用聚合函数（MAX, MIN, ANY_VALUE等）
- ⚠️ 这是PostgreSQL最常见的迁移错误！

### 2.3 ORDER BY 限制

**PostgreSQL要求**: 使用DISTINCT时，ORDER BY的列必须在SELECT中

```xml
<!-- MySQL -->
<select id="getDistinctUsers">
  SELECT DISTINCT user_id, user_name
  FROM orders
  ORDER BY create_time  <!-- ❌ create_time不在SELECT中 -->
</select>

<!-- PostgreSQL - 方案A -->
<select id="getDistinctUsers">
  SELECT DISTINCT user_id, user_name, create_time
  FROM orders
  ORDER BY create_time  <!-- ✅ 添加到SELECT中 -->
</select>

<!-- PostgreSQL - 方案B -->
<select id="getDistinctUsers">
  SELECT user_id, user_name
  FROM (
    SELECT DISTINCT user_id, user_name, create_time
    FROM orders
    ORDER BY create_time
  ) t
</select>
```

---

## 3. 插入语句转换

### 3.1 INSERT IGNORE

**MySQL特有，PostgreSQL需要改写**

```xml
<!-- MySQL -->
<insert id="insertUser">
  INSERT IGNORE INTO t_user (id, name, email)
  VALUES (#{id}, #{name}, #{email})
</insert>

<!-- PostgreSQL -->
<insert id="insertUser">
  INSERT INTO t_user (id, name, email)
  VALUES (#{id}, #{name}, #{email})
  ON CONFLICT (id) DO NOTHING
</insert>
```

**约束规则**:
- ✅ `INSERT IGNORE` → `INSERT ... ON CONFLICT DO NOTHING`
- ✅ 需要指定冲突列（通常是主键或唯一键）

### 3.2 ON DUPLICATE KEY UPDATE

```xml
<!-- MySQL -->
<insert id="upsertUser">
  INSERT INTO t_user (id, name, email, update_time)
  VALUES (#{id}, #{name}, #{email}, NOW())
  ON DUPLICATE KEY UPDATE 
    name = #{name},
    email = #{email},
    update_time = NOW()
</insert>

<!-- PostgreSQL -->
<insert id="upsertUser">
  INSERT INTO t_user (id, name, email, update_time)
  VALUES (#{id}, #{name}, #{email}, CURRENT_TIMESTAMP)
  ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    email = EXCLUDED.email,
    update_time = CURRENT_TIMESTAMP
</insert>
```

**约束规则**:
- ✅ `ON DUPLICATE KEY UPDATE` → `ON CONFLICT ... DO UPDATE`
- ✅ `VALUES(column)` → `EXCLUDED.column`
- ✅ `NOW()` → `CURRENT_TIMESTAMP`

### 3.3 REPLACE INTO

```xml
<!-- MySQL -->
<insert id="replaceUser">
  REPLACE INTO t_user (id, name, email)
  VALUES (#{id}, #{name}, #{email})
</insert>

<!-- PostgreSQL -->
<insert id="replaceUser">
  INSERT INTO t_user (id, name, email)
  VALUES (#{id}, #{name}, #{email})
  ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    email = EXCLUDED.email
</insert>
```

---

## 4. 更新语句转换

### 4.1 UPDATE JOIN

**MySQL特有语法，需要改写**

```xml
<!-- MySQL -->
<update id="updateUserStatus">
  UPDATE t_user u
  INNER JOIN t_order o ON u.id = o.user_id
  SET u.status = 1
  WHERE o.status = 'completed'
</update>

<!-- PostgreSQL -->
<update id="updateUserStatus">
  UPDATE t_user u
  SET status = 1
  FROM t_order o
  WHERE u.id = o.user_id 
    AND o.status = 'completed'
</update>
```

**约束规则**:
- ✅ `UPDATE table1 INNER JOIN table2` → `UPDATE table1 FROM table2`
- ✅ JOIN条件移到WHERE子句中

### 4.2 条件更新

```xml
<!-- MySQL -->
<update id="updateUserLevel">
  UPDATE t_user
  SET level = IF(score >= 100, 'A', IF(score >= 60, 'B', 'C'))
  WHERE id = #{id}
</update>

<!-- PostgreSQL -->
<update id="updateUserLevel">
  UPDATE t_user
  SET level = CASE 
    WHEN score >= 100 THEN 'A'
    WHEN score >= 60 THEN 'B'
    ELSE 'C'
  END
  WHERE id = #{id}
</update>
```

---

## 5. 删除语句转换

### 5.1 DELETE JOIN

```xml
<!-- MySQL -->
<delete id="deleteInactiveUsers">
  DELETE u FROM t_user u
  INNER JOIN t_login_log l ON u.id = l.user_id
  WHERE l.last_login &lt; DATE_SUB(NOW(), INTERVAL 1 YEAR)
</delete>

<!-- PostgreSQL -->
<delete id="deleteInactiveUsers">
  DELETE FROM t_user u
  USING t_login_log l
  WHERE u.id = l.user_id 
    AND l.last_login &lt; NOW() - INTERVAL '1 year'
</delete>
```

**约束规则**:
- ✅ `DELETE t1 FROM t1 JOIN t2` → `DELETE FROM t1 USING t2`
- ✅ MySQL的 `&lt;` 在XML中表示 `<`（转义字符保持）

---

## 6. 函数转换大全

### 6.1 IFNULL / IF 函数

```xml
<!-- MySQL -->
<select id="getUserWithDefault">
  SELECT 
    id,
    IFNULL(nickname, '匿名用户') as nickname,
    IF(status = 1, '启用', '禁用') as statusText
  FROM t_user
</select>

<!-- PostgreSQL -->
<select id="getUserWithDefault">
  SELECT 
    id,
    COALESCE(nickname, '匿名用户') as nickname,
    CASE WHEN status = 1 THEN '启用' ELSE '禁用' END as statusText
  FROM t_user
</select>
```

**约束规则**:
- ✅ `IFNULL(a, b)` → `COALESCE(a, b)`
- ✅ `IF(condition, a, b)` → `CASE WHEN condition THEN a ELSE b END`

**或者创建自定义函数** (可选):
```sql
CREATE OR REPLACE FUNCTION IFNULL(anyelement, anyelement) 
RETURNS anyelement AS $$
  SELECT COALESCE($1, $2);
$$ LANGUAGE SQL IMMUTABLE;
```

### 6.2 GROUP_CONCAT

```xml
<!-- MySQL -->
<select id="getUserTags">
  SELECT 
    user_id,
    GROUP_CONCAT(tag_name ORDER BY tag_name SEPARATOR ',') as tags
  FROM t_user_tag
  GROUP BY user_id
</select>

<!-- PostgreSQL -->
<select id="getUserTags">
  SELECT 
    user_id,
    STRING_AGG(tag_name, ',' ORDER BY tag_name) as tags
  FROM t_user_tag
  GROUP BY user_id
</select>
```

**约束规则**:
- ✅ `GROUP_CONCAT(col SEPARATOR ',')` → `STRING_AGG(col, ',')`
- ✅ ORDER BY语法略有不同

### 6.3 FIND_IN_SET

```xml
<!-- MySQL -->
<select id="getUsersByTag">
  SELECT * FROM t_user
  WHERE FIND_IN_SET('vip', tags)
</select>

<!-- PostgreSQL - 方案A (推荐) -->
<select id="getUsersByTag">
  SELECT * FROM t_user
  WHERE 'vip' = ANY(STRING_TO_ARRAY(tags, ','))
</select>

<!-- PostgreSQL - 方案B (自定义函数) -->
<select id="getUsersByTag">
  SELECT * FROM t_user
  WHERE FIND_IN_SET('vip', tags) > 0
</select>
```

**自定义函数** (需要提前在数据库中创建):
```sql
CREATE OR REPLACE FUNCTION FIND_IN_SET(str TEXT, strlist TEXT) 
RETURNS INTEGER AS $$
DECLARE
  arr TEXT[];
  i INTEGER;
BEGIN
  IF str IS NULL OR strlist IS NULL THEN
    RETURN NULL;
  END IF;
  arr := STRING_TO_ARRAY(strlist, ',');
  FOR i IN 1..ARRAY_LENGTH(arr, 1) LOOP
    IF arr[i] = str THEN
      RETURN i;
    END IF;
  END LOOP;
  RETURN 0;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
```

### 6.4 SUBSTRING_INDEX

```xml
<!-- MySQL -->
<select id="getFirstDomain">
  SELECT 
    SUBSTRING_INDEX(url, '.', 1) as firstPart,
    SUBSTRING_INDEX(url, '.', -1) as lastPart
  FROM t_website
</select>

<!-- PostgreSQL - 使用数组函数 (推荐) -->
<select id="getFirstDomain">
  SELECT 
    (STRING_TO_ARRAY(url, '.'))[1] as firstPart,
    (STRING_TO_ARRAY(url, '.'))[ARRAY_LENGTH(STRING_TO_ARRAY(url, '.'), 1)] as lastPart
  FROM t_website
</select>

<!-- PostgreSQL - 使用SPLIT_PART -->
<select id="getFirstDomain">
  SELECT 
    SPLIT_PART(url, '.', 1) as firstPart,
    SPLIT_PART(url, '.', -1) as lastPart  <!-- ❌ SPLIT_PART不支持负数 -->
  FROM t_website
</select>
```

**自定义SUBSTRING_INDEX函数** (推荐提前创建):
```sql
CREATE OR REPLACE FUNCTION SUBSTRING_INDEX(str TEXT, delim TEXT, count INTEGER)
RETURNS TEXT AS $$
DECLARE
  arr TEXT[];
  result TEXT;
BEGIN
  arr := STRING_TO_ARRAY(str, delim);
  IF count > 0 THEN
    result := ARRAY_TO_STRING(arr[1:count], delim);
  ELSIF count < 0 THEN
    result := ARRAY_TO_STRING(
      arr[ARRAY_LENGTH(arr, 1) + count + 1 : ARRAY_LENGTH(arr, 1)], 
      delim
    );
  ELSE
    result := '';
  END IF;
  RETURN result;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
```

### 6.5 CURDATE / NOW

```xml
<!-- MySQL -->
<select id="getTodayOrders">
  SELECT * FROM t_order
  WHERE DATE(create_time) = CURDATE()
    AND update_time >= NOW()
</select>

<!-- PostgreSQL -->
<select id="getTodayOrders">
  SELECT * FROM t_order
  WHERE DATE(create_time) = CURRENT_DATE
    AND update_time >= CURRENT_TIMESTAMP
</select>
```

**约束规则**:
- ✅ `CURDATE()` → `CURRENT_DATE` (注意：没有括号)
- ✅ `NOW()` → `CURRENT_TIMESTAMP` 或 `NOW()`
- ✅ `CURTIME()` → `CURRENT_TIME`

---

## 7. 条件判断和空值处理

### 7.1 NULL值判断

```xml
<!-- MySQL -->
<select id="getUsers">
  SELECT * FROM t_user
  WHERE 
    ISNULL(deleted_at)  <!-- MySQL特有 -->
    AND email IS NOT NULL
</select>

<!-- PostgreSQL -->
<select id="getUsers">
  SELECT * FROM t_user
  WHERE 
    deleted_at IS NULL  <!-- 标准SQL -->
    AND email IS NOT NULL
</select>
```

**约束规则**:
- ✅ `ISNULL(col)` → `col IS NULL`
- ✅ 使用标准SQL语法

### 7.2 安全等于

```xml
<!-- MySQL -->
<select id="compareValues">
  SELECT * FROM t_data
  WHERE value1 &lt;=&gt; value2  <!-- NULL安全比较 -->
</select>

<!-- PostgreSQL -->
<select id="compareValues">
  SELECT * FROM t_data
  WHERE value1 IS NOT DISTINCT FROM value2
</select>
```

---

## 8. 分页查询转换 ⚠️ **重要**

### 8.1 LIMIT语法差异

```xml
<!-- MySQL -->
<select id="getUserList">
  SELECT * FROM t_user
  ORDER BY id
  LIMIT #{offset}, #{limit}  <!-- offset在前 -->
</select>

<!-- PostgreSQL -->
<select id="getUserList">
  SELECT * FROM t_user
  ORDER BY id
  LIMIT #{limit} OFFSET #{offset}  <!-- limit在前 -->
</select>
```

**约束规则**:
- ✅ **必须**: `LIMIT offset, count` → `LIMIT count OFFSET offset`
- ✅ 注意参数顺序反了！

### 8.2 MyBatis分页插件兼容

如果使用PageHelper等分页插件：

```xml
<!-- 插件会自动处理，但需要配置 -->
<!-- mybatis-config.xml -->
<plugins>
  <plugin interceptor="com.github.pagehelper.PageInterceptor">
    <property name="helperDialect" value="postgresql"/>
  </plugin>
</plugins>
```

---

## 9. 日期时间处理

### 9.1 DATE_FORMAT / DATE_ADD

```xml
<!-- MySQL -->
<select id="getOrderReport">
  SELECT 
    DATE_FORMAT(order_time, '%Y-%m-%d') as orderDate,
    DATE_FORMAT(order_time, '%Y-%m-%d %H:%i:%s') as orderDateTime,
    DATE_ADD(order_time, INTERVAL 7 DAY) as dueDate
  FROM t_order
</select>

<!-- PostgreSQL -->
<select id="getOrderReport">
  SELECT 
    TO_CHAR(order_time, 'YYYY-MM-DD') as orderDate,
    TO_CHAR(order_time, 'YYYY-MM-DD HH24:MI:SS') as orderDateTime,
    order_time + INTERVAL '7 days' as dueDate
  FROM t_order
</select>
```

**约束规则**:
- ✅ `DATE_FORMAT(date, format)` → `TO_CHAR(date, format)`
- ✅ `DATE_ADD(date, INTERVAL n DAY)` → `date + INTERVAL 'n days'`
- ✅ `DATE_SUB(date, INTERVAL n DAY)` → `date - INTERVAL 'n days'`

**格式符对照表**:

| MySQL | PostgreSQL | 说明 |
|-------|-----------|------|
| `%Y` | `YYYY` | 4位年份 |
| `%y` | `YY` | 2位年份 |
| `%m` | `MM` | 月份(01-12) |
| `%d` | `DD` | 日期(01-31) |
| `%H` | `HH24` | 小时(00-23) |
| `%h` | `HH12` | 小时(01-12) |
| `%i` | `MI` | 分钟 |
| `%s` | `SS` | 秒 |
| `%W` | `Day` | 星期全名 |
| `%w` | `D` | 星期序号 |

### 9.2 UNIX_TIMESTAMP

```xml
<!-- MySQL -->
<select id="getTimestamp">
  SELECT 
    UNIX_TIMESTAMP() as now_timestamp,
    UNIX_TIMESTAMP(create_time) as create_timestamp,
    FROM_UNIXTIME(#{timestamp}) as datetime
  FROM t_order
</select>

<!-- PostgreSQL -->
<select id="getTimestamp">
  SELECT 
    EXTRACT(EPOCH FROM NOW())::INTEGER as now_timestamp,
    EXTRACT(EPOCH FROM create_time)::INTEGER as create_timestamp,
    TO_TIMESTAMP(#{timestamp}) as datetime
  FROM t_order
</select>
```

---

## 10. 字符串操作

### 10.1 字符串拼接

```xml
<!-- MySQL -->
<select id="getUserFullName">
  SELECT CONCAT(first_name, ' ', last_name) as fullName
  FROM t_user
</select>

<!-- PostgreSQL - 方案A -->
<select id="getUserFullName">
  SELECT first_name || ' ' || last_name as fullName
  FROM t_user
</select>

<!-- PostgreSQL - 方案B -->
<select id="getUserFullName">
  SELECT CONCAT(first_name, ' ', last_name) as fullName
  FROM t_user
</select>
```

**约束规则**:
- ✅ 推荐使用 `||` 运算符（PostgreSQL风格）
- ✅ `CONCAT()` 也可用（保持兼容性）

### 10.2 LIKE查询

```xml
<!-- MySQL (不区分大小写) -->
<select id="searchUsers">
  SELECT * FROM t_user
  WHERE name LIKE CONCAT('%', #{keyword}, '%')
</select>

<!-- PostgreSQL (区分大小写) -->
<select id="searchUsers">
  SELECT * FROM t_user
  WHERE name ILIKE '%' || #{keyword} || '%'  <!-- 不区分大小写 -->
</select>

<!-- 或者区分大小写 -->
<select id="searchUsers">
  SELECT * FROM t_user
  WHERE name LIKE '%' || #{keyword} || '%'  <!-- 区分大小写 -->
</select>
```

**约束规则**:
- ✅ PostgreSQL的 `LIKE` 默认**区分**大小写
- ✅ 使用 `ILIKE` 实现不区分大小写（推荐）
- ✅ 或使用 `LOWER()` 函数

### 10.3 LOCATE / POSITION

```xml
<!-- MySQL -->
<select id="findPosition">
  SELECT LOCATE('abc', content) as position
  FROM t_article
</select>

<!-- PostgreSQL -->
<select id="findPosition">
  SELECT POSITION('abc' IN content) as position
  FROM t_article
</select>
```

---

## 11. 聚合和分组

### 11.1 COUNT(DISTINCT)

```xml
<!-- MySQL -->
<select id="countDistinctUsers">
  SELECT 
    COUNT(DISTINCT user_id) as userCount,
    COUNT(DISTINCT DATE(create_time)) as dayCount
  FROM t_order
</select>

<!-- PostgreSQL (相同) -->
<select id="countDistinctUsers">
  SELECT 
    COUNT(DISTINCT user_id) as userCount,
    COUNT(DISTINCT DATE(create_time)) as dayCount
  FROM t_order
</select>
```

### 11.2 条件聚合

```xml
<!-- MySQL -->
<select id="getOrderStats">
  SELECT 
    COUNT(IF(status = 'completed', 1, NULL)) as completedCount,
    COUNT(IF(status = 'cancelled', 1, NULL)) as cancelledCount
  FROM t_order
</select>

<!-- PostgreSQL -->
<select id="getOrderStats">
  SELECT 
    COUNT(CASE WHEN status = 'completed' THEN 1 END) as completedCount,
    COUNT(CASE WHEN status = 'cancelled' THEN 1 END) as cancelledCount
  FROM t_order
</select>

<!-- 或使用FILTER (PostgreSQL 9.4+) -->
<select id="getOrderStats">
  SELECT 
    COUNT(*) FILTER (WHERE status = 'completed') as completedCount,
    COUNT(*) FILTER (WHERE status = 'cancelled') as cancelledCount
  FROM t_order
</select>
```

---

## 12. MyBatis动态SQL处理

### 12.1 &lt;if&gt; 标签

```xml
<!-- MySQL和PostgreSQL通用 -->
<select id="searchUsers">
  SELECT * FROM t_user
  WHERE 1=1
  <if test="name != null and name != ''">
    AND name LIKE CONCAT('%', #{name}, '%')  <!-- MySQL -->
  </if>
</select>

<!-- PostgreSQL -->
<select id="searchUsers">
  SELECT * FROM t_user
  WHERE 1=1
  <if test="name != null and name != ''">
    AND name ILIKE '%' || #{name} || '%'  <!-- PostgreSQL -->
  </if>
</select>
```

### 12.2 &lt;foreach&gt; 标签

```xml
<!-- MySQL和PostgreSQL都支持 -->
<select id="getUsersByIds">
  SELECT * FROM t_user
  WHERE id IN
  <foreach collection="ids" item="id" open="(" separator="," close=")">
    #{id}
  </foreach>
</select>
```

### 12.3 &lt;choose&gt; &lt;when&gt;

```xml
<!-- 通用，但注意函数差异 -->
<select id="getUserList">
  SELECT * FROM t_user
  <where>
    <choose>
      <when test="orderBy == 'time'">
        ORDER BY create_time DESC
      </when>
      <when test="orderBy == 'name'">
        ORDER BY name ASC
      </when>
      <otherwise>
        ORDER BY id DESC
      </otherwise>
    </choose>
  </where>
</select>
```

---

## 13. 参数绑定

### 13.1 #{} 和 ${}

```xml
<!-- 通用 - #{} 参数绑定（推荐，防SQL注入） -->
<select id="getUser">
  SELECT * FROM t_user
  WHERE id = #{id}  <!-- 会转换为 ? 参数 -->
</select>

<!-- ${} 字符串替换（谨慎使用） -->
<select id="getUserList">
  SELECT * FROM t_user
  ORDER BY ${orderColumn} ${orderDirection}  <!-- 动态排序字段 -->
</select>
```

**约束规则**:
- ✅ 优先使用 `#{}`（防SQL注入）
- ⚠️ `${}` 仅用于动态表名、列名、ORDER BY
- ✅ PostgreSQL和MySQL行为一致

### 13.2 类型转换

```xml
<!-- MySQL -->
<select id="getUserById">
  SELECT * FROM t_user
  WHERE id = CAST(#{id} AS SIGNED)
</select>

<!-- PostgreSQL -->
<select id="getUserById">
  SELECT * FROM t_user
  WHERE id = CAST(#{id} AS INTEGER)
  <!-- 或使用 :: 语法 -->
  WHERE id = #{id}::INTEGER
</select>
```

---

## 14. 特殊场景处理

### 14.1 位运算

```xml
<!-- MySQL -->
<select id="checkPermission">
  SELECT * FROM t_user
  WHERE permission &amp; #{flag} = #{flag}  <!-- &amp; 是 & 的XML转义 -->
    AND role ^ 1 = 2  <!-- 异或 -->
</select>

<!-- PostgreSQL -->
<select id="checkPermission">
  SELECT * FROM t_user
  WHERE permission &amp; #{flag} = #{flag}  <!-- 与运算相同 -->
    AND role # 1 = 2  <!-- 异或用 # -->
</select>
```

### 14.2 正则表达式

```xml
<!-- MySQL -->
<select id="searchByRegex">
  SELECT * FROM t_user
  WHERE email REGEXP '^[a-z]+@example.com$'
</select>

<!-- PostgreSQL -->
<select id="searchByRegex">
  SELECT * FROM t_user
  WHERE email ~ '^[a-z]+@example.com$'  <!-- 区分大小写 -->
  <!-- 或不区分大小写 -->
  WHERE email ~* '^[a-z]+@example.com$'
</select>
```

### 14.3 JSON操作

```xml
<!-- MySQL 5.7+ -->
<select id="getUserByJsonField">
  SELECT * FROM t_user
  WHERE JSON_EXTRACT(profile, '$.age') > 18
</select>

<!-- PostgreSQL (JSONB推荐) -->
<select id="getUserByJsonField">
  SELECT * FROM t_user
  WHERE (profile->'age')::INTEGER > 18
  <!-- 或 -->
  WHERE profile->>'age'::INTEGER > 18
</select>
```

---

## 15. 完整示例对比

### 示例1: 用户列表查询（复杂条件）

```xml
<!-- MySQL版本 -->
<select id="getUserList" resultType="UserVO">
  SELECT 
    u.id,
    u.username,
    IFNULL(u.nickname, '匿名用户') as nickname,
    u.email,
    DATE_FORMAT(u.create_time, '%Y-%m-%d %H:%i:%s') as createTime,
    CASE 
      WHEN u.status = 1 THEN '启用'
      WHEN u.status = 0 THEN '禁用'
      ELSE '未知'
    END as statusText,
    GROUP_CONCAT(r.role_name SEPARATOR ',') as roles
  FROM `t_user` u
  LEFT JOIN `t_user_role` ur ON u.id = ur.user_id
  LEFT JOIN `t_role` r ON ur.role_id = r.id
  <where>
    <if test="keyword != null and keyword != ''">
      AND (
        u.username LIKE CONCAT('%', #{keyword}, '%')
        OR u.email LIKE CONCAT('%', #{keyword}, '%')
      )
    </if>
    <if test="status != null">
      AND u.status = #{status}
    </if>
    <if test="startDate != null">
      AND u.create_time >= #{startDate}
    </if>
    <if test="endDate != null">
      AND u.create_time &lt;= #{endDate}
    </if>
    <if test="roleIds != null and roleIds.size() > 0">
      AND ur.role_id IN
      <foreach collection="roleIds" item="roleId" open="(" separator="," close=")">
        #{roleId}
      </foreach>
    </if>
  </where>
  GROUP BY u.id, u.username, u.nickname, u.email, u.create_time, u.status
  ORDER BY u.create_time DESC
  LIMIT #{offset}, #{limit}
</select>

<!-- PostgreSQL版本 -->
<select id="getUserList" resultType="UserVO">
  SELECT 
    u.id,
    u.username,
    COALESCE(u.nickname, '匿名用户') as nickname,
    u.email,
    TO_CHAR(u.create_time, 'YYYY-MM-DD HH24:MI:SS') as createTime,
    CASE 
      WHEN u.status = 1 THEN '启用'
      WHEN u.status = 0 THEN '禁用'
      ELSE '未知'
    END as statusText,
    STRING_AGG(r.role_name, ',' ORDER BY r.role_name) as roles
  FROM t_user u
  LEFT JOIN t_user_role ur ON u.id = ur.user_id
  LEFT JOIN t_role r ON ur.role_id = r.id
  <where>
    <if test="keyword != null and keyword != ''">
      AND (
        u.username ILIKE '%' || #{keyword} || '%'
        OR u.email ILIKE '%' || #{keyword} || '%'
      )
    </if>
    <if test="status != null">
      AND u.status = #{status}
    </if>
    <if test="startDate != null">
      AND u.create_time >= #{startDate}
    </if>
    <if test="endDate != null">
      AND u.create_time &lt;= #{endDate}
    </if>
    <if test="roleIds != null and roleIds.size() > 0">
      AND ur.role_id IN
      <foreach collection="roleIds" item="roleId" open="(" separator="," close=")">
        #{roleId}
      </foreach>
    </if>
  </where>
  GROUP BY u.id, u.username, u.nickname, u.email, u.create_time, u.status
  ORDER BY u.create_time DESC
  LIMIT #{limit} OFFSET #{offset}
</select>
```

**关键差异**:
1. ✅ `IFNULL` → `COALESCE`
2. ✅ `DATE_FORMAT` → `TO_CHAR`
3. ✅ `GROUP_CONCAT` → `STRING_AGG`
4. ✅ `LIKE` → `ILIKE` (不区分大小写)
5. ✅ `CONCAT('%', x, '%')` → `'%' || x || '%'`
6. ✅ `LIMIT offset, limit` → `LIMIT limit OFFSET offset`
7. ✅ 反引号全部去除

---

### 示例2: 订单统计（聚合查询）

```xml
<!-- MySQL版本 -->
<select id="getOrderStatistics" resultType="OrderStatVO">
  SELECT 
    DATE_FORMAT(create_time, '%Y-%m-%d') as date,
    COUNT(*) as totalCount,
    COUNT(IF(status = 'completed', 1, NULL)) as completedCount,
    COUNT(IF(status = 'cancelled', 1, NULL)) as cancelledCount,
    IFNULL(SUM(IF(status = 'completed', amount, 0)), 0) as totalAmount,
    IFNULL(AVG(IF(status = 'completed', amount, NULL)), 0) as avgAmount
  FROM `t_order`
  WHERE create_time >= #{startDate}
    AND create_time &lt; #{endDate}
  GROUP BY DATE(create_time)
  ORDER BY date DESC
</select>

<!-- PostgreSQL版本 -->
<select id="getOrderStatistics" resultType="OrderStatVO">
  SELECT 
    TO_CHAR(create_time, 'YYYY-MM-DD') as date,
    COUNT(*) as totalCount,
    COUNT(*) FILTER (WHERE status = 'completed') as completedCount,
    COUNT(*) FILTER (WHERE status = 'cancelled') as cancelledCount,
    COALESCE(SUM(amount) FILTER (WHERE status = 'completed'), 0) as totalAmount,
    COALESCE(AVG(amount) FILTER (WHERE status = 'completed'), 0) as avgAmount
  FROM t_order
  WHERE create_time >= #{startDate}
    AND create_time &lt; #{endDate}
  GROUP BY DATE(create_time)
  ORDER BY date DESC
</select>
```

**关键差异**:
1. ✅ `COUNT(IF(...))` → `COUNT(*) FILTER (WHERE ...)`
2. ✅ `SUM(IF(...))` → `SUM(...) FILTER (WHERE ...)`
3. ✅ `IFNULL` → `COALESCE`
4. ✅ `DATE_FORMAT` → `TO_CHAR`

---

### 示例3: 批量Upsert

```xml
<!-- MySQL版本 -->
<insert id="batchUpsertUsers">
  INSERT INTO t_user (id, username, email, update_time)
  VALUES
  <foreach collection="users" item="user" separator=",">
    (#{user.id}, #{user.username}, #{user.email}, NOW())
  </foreach>
  ON DUPLICATE KEY UPDATE
    username = VALUES(username),
    email = VALUES(email),
    update_time = NOW()
</insert>

<!-- PostgreSQL版本 -->
<insert id="batchUpsertUsers">
  INSERT INTO t_user (id, username, email, update_time)
  VALUES
  <foreach collection="users" item="user" separator=",">
    (#{user.id}, #{user.username}, #{user.email}, CURRENT_TIMESTAMP)
  </foreach>
  ON CONFLICT (id) DO UPDATE SET
    username = EXCLUDED.username,
    email = EXCLUDED.email,
    update_time = CURRENT_TIMESTAMP
</insert>
```

---

## 📋 快速检查清单

迁移MyBatis XML时，按此清单逐项检查：

### 基本语法
- [ ] 字符串全部用单引号 `'string'`
- [ ] 反引号 `` `table` `` 改为小写或双引号 `"table"`
- [ ] `LIMIT offset, count` → `LIMIT count OFFSET offset`

### 函数替换
- [ ] `IFNULL(a, b)` → `COALESCE(a, b)`
- [ ] `IF(cond, a, b)` → `CASE WHEN cond THEN a ELSE b END`
- [ ] `GROUP_CONCAT(col)` → `STRING_AGG(col, ',')`
- [ ] `FIND_IN_SET(str, list)` → `str = ANY(STRING_TO_ARRAY(list, ','))`
- [ ] `DATE_FORMAT(date, fmt)` → `TO_CHAR(date, fmt)`
- [ ] `CURDATE()` → `CURRENT_DATE`
- [ ] `NOW()` → `CURRENT_TIMESTAMP`

### INSERT语句
- [ ] `INSERT IGNORE` → `INSERT ... ON CONFLICT DO NOTHING`
- [ ] `ON DUPLICATE KEY UPDATE` → `ON CONFLICT DO UPDATE`
- [ ] `VALUES(col)` → `EXCLUDED.col`

### UPDATE/DELETE
- [ ] `UPDATE ... JOIN` → `UPDATE ... FROM`
- [ ] `DELETE ... JOIN` → `DELETE ... USING`

### 查询语句
- [ ] GROUP BY 包含所有非聚合列
- [ ] DISTINCT时ORDER BY列在SELECT中
- [ ] `LIKE` → `ILIKE` (不区分大小写)

### 字符串
- [ ] `CONCAT('%', x, '%')` → `'%' || x || '%'`
- [ ] `LOCATE(a, b)` → `POSITION(a IN b)`

### 条件
- [ ] `ISNULL(col)` → `col IS NULL`
- [ ] `col <=> val` → `col IS NOT DISTINCT FROM val`

---

## 🔧 推荐工具

### 1. 自定义函数库

创建兼容函数，减少代码改动：

```sql
-- ifnull.sql
CREATE OR REPLACE FUNCTION IFNULL(anyelement, anyelement) 
RETURNS anyelement AS $$
  SELECT COALESCE($1, $2);
$$ LANGUAGE SQL IMMUTABLE;

-- find_in_set.sql  
CREATE OR REPLACE FUNCTION FIND_IN_SET(str TEXT, strlist TEXT) 
RETURNS INTEGER AS $$
DECLARE
  arr TEXT[];
  i INTEGER;
BEGIN
  IF str IS NULL OR strlist IS NULL THEN RETURN NULL; END IF;
  arr := STRING_TO_ARRAY(strlist, ',');
  FOR i IN 1..ARRAY_LENGTH(arr, 1) LOOP
    IF arr[i] = str THEN RETURN i; END IF;
  END LOOP;
  RETURN 0;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- substring_index.sql
CREATE OR REPLACE FUNCTION SUBSTRING_INDEX(str TEXT, delim TEXT, count INTEGER)
RETURNS TEXT AS $$
DECLARE
  arr TEXT[];
BEGIN
  arr := STRING_TO_ARRAY(str, delim);
  IF count > 0 THEN
    RETURN ARRAY_TO_STRING(arr[1:count], delim);
  ELSIF count < 0 THEN
    RETURN ARRAY_TO_STRING(
      arr[ARRAY_LENGTH(arr, 1) + count + 1 : ARRAY_LENGTH(arr, 1)], 
      delim
    );
  ELSE
    RETURN '';
  END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
```

### 2. 批量替换脚本

```bash
#!/bin/bash
# replace_mysql_syntax.sh

# 在所有mapper.xml文件中替换MySQL语法为PostgreSQL

find . -name "*Mapper.xml" -type f | while read file; do
  echo "Processing: $file"
  
  # IFNULL → COALESCE
  sed -i 's/IFNULL(/COALESCE(/g' "$file"
  
  # DATE_FORMAT → TO_CHAR (需手动确认格式)
  # sed -i 's/DATE_FORMAT(/TO_CHAR(/g' "$file"
  
  # GROUP_CONCAT → STRING_AGG (需手动调整)
  # sed -i 's/GROUP_CONCAT(/STRING_AGG(/g' "$file"
  
  # CURDATE → CURRENT_DATE
  sed -i 's/CURDATE()/CURRENT_DATE/g' "$file"
  
  # NOW → CURRENT_TIMESTAMP
  sed -i 's/NOW()/CURRENT_TIMESTAMP/g' "$file"
  
done
```

---

## 📚 参考资源

- [PostgreSQL 16 SQL语法](https://www.postgresql.org/docs/16/sql.html)
- [MyBatis官方文档](https://mybatis.org/mybatis-3/zh/index.html)
- [MySQL到PostgreSQL迁移指南](https://wiki.postgresql.org/wiki/Converting_from_other_Databases_to_PostgreSQL#MySQL)

---

**文档版本**: 1.0  
**适用范围**: MyBatis 3.x + PostgreSQL 16.x  
**维护状态**: 活跃维护  
**最后更新**: 2026-01-14
