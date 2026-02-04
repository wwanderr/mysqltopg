# LocalDateTime + jdbcType=TIMESTAMP 使用指南

## ✅ 你的问题

> **如果是 LocalDateTime 传入，也能用 jdbcType=TIMESTAMP 么？**

---

## 🎯 答案：完全可以！而且是最佳方案！

### 结论
- ✅ **LocalDateTime + jdbcType=TIMESTAMP** = 完美组合
- ✅ **无需 CAST 类型转换**
- ✅ **JDBC 驱动自动处理转换**
- ✅ **性能最优**

---

## 📊 完整对比表

### Java类型 vs MyBatis写法 vs PostgreSQL效果

| Java实体类类型 | MyBatis XML写法 | 是否需要CAST | PostgreSQL接收 | 性能 | 推荐度 |
|----------------|----------------|-------------|----------------|------|--------|
| **`LocalDateTime`** | `#{field,jdbcType=TIMESTAMP}` | ❌ 不需要 | `timestamp` | ⭐⭐⭐⭐⭐ | ✅✅✅ **最佳** |
| **`LocalDateTime`** | `#{field}` (不指定类型) | ❌ 不需要 | `timestamp` | ⭐⭐⭐⭐⭐ | ✅✅ 也可以 |
| **`String`** | `CAST(#{field} AS timestamp)` | ✅ 需要 | `timestamp` | ⭐⭐⭐ | ⚠️ 兼容方案 |
| **`String`** | `#{field,jdbcType=VARCHAR}` | N/A | `varchar` | N/A | ❌ 报错 |
| **`String`** | `#{field,jdbcType=TIMESTAMP}` | ❌ 不需要 | 可能失败 | ⭐⭐ | ⚠️ 不可靠 |
| **`Date`** | `#{field,jdbcType=TIMESTAMP}` | ❌ 不需要 | `timestamptz` | ⭐⭐⭐ | ⚠️ 有时区问题 |

---

## 🌟 最佳实践示例

### 完整的配置示例

#### 1. PostgreSQL表结构
```sql
CREATE TABLE t_event_template (
    id BIGSERIAL PRIMARY KEY,
    incident_name VARCHAR(100),
    update_time timestamp(6),      -- ✅ 使用 timestamp (不带时区)
    create_time timestamp(6),      -- ✅ 使用 timestamp (不带时区)
    last_execute_time timestamp(6) -- ✅ 使用 timestamp (不带时区)
);
```

#### 2. Java实体类
```java
package com.dbapp.extension.xdr.threatMonitor.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class EventTemplate {
    private Long id;
    private String incidentName;
    
    // ✅ 使用 LocalDateTime 类型
    private LocalDateTime updateTime;
    private LocalDateTime createTime;
    private LocalDateTime lastExecuteTime;
    
    // 其他字段...
}
```

#### 3. MyBatis XML映射
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
    "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.dbapp.extension.xdr.threatMonitor.mapper.EventTemplateMapper">

    <!-- ============================================ -->
    <!-- INSERT：使用 jdbcType=TIMESTAMP -->
    <!-- ============================================ -->
    <insert id="insert" parameterType="EventTemplate">
        INSERT INTO t_event_template 
        (incident_name, update_time, create_time)
        VALUES 
        (
            #{incidentName,jdbcType=VARCHAR},
            #{updateTime,jdbcType=TIMESTAMP},      <!-- ✅ 直接使用，无需CAST -->
            #{createTime,jdbcType=TIMESTAMP}       <!-- ✅ 直接使用，无需CAST -->
        )
    </insert>

    <!-- ============================================ -->
    <!-- UPDATE：使用 jdbcType=TIMESTAMP -->
    <!-- ============================================ -->
    <update id="update" parameterType="EventTemplate">
        UPDATE t_event_template 
        SET 
            incident_name = #{incidentName,jdbcType=VARCHAR},
            update_time = #{updateTime,jdbcType=TIMESTAMP}  <!-- ✅ 直接使用 -->
        WHERE id = #{id}
    </update>

    <!-- ============================================ -->
    <!-- SELECT：ResultMap配置 -->
    <!-- ============================================ -->
    <resultMap id="baseResult" type="EventTemplate">
        <id property="id" column="id" jdbcType="BIGINT"/>
        <result property="incidentName" column="incident_name" jdbcType="VARCHAR"/>
        <result property="updateTime" column="update_time" jdbcType="TIMESTAMP"/>
        <result property="createTime" column="create_time" jdbcType="TIMESTAMP"/>
    </resultMap>

    <select id="selectById" resultMap="baseResult">
        SELECT 
            id, 
            incident_name, 
            update_time,    <!-- ✅ PostgreSQL返回timestamp -->
            create_time     <!-- ✅ JDBC自动转为LocalDateTime -->
        FROM t_event_template
        WHERE id = #{id}
    </select>

</mapper>
```

#### 4. Mapper接口
```java
package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.EventTemplate;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EventTemplateMapper {
    int insert(EventTemplate template);
    int update(EventTemplate template);
    EventTemplate selectById(Long id);
}
```

#### 5. Service层使用
```java
package com.dbapp.extension.xdr.threatMonitor.service;

import com.dbapp.extension.xdr.threatMonitor.entity.EventTemplate;
import com.dbapp.extension.xdr.threatMonitor.mapper.EventTemplateMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class EventTemplateService {
    
    @Autowired
    private EventTemplateMapper mapper;
    
    // ============================================
    // 示例1：插入数据
    // ============================================
    public void createTemplate() {
        EventTemplate template = new EventTemplate();
        template.setIncidentName("测试事件");
        
        // ✅ 使用 LocalDateTime.now()
        LocalDateTime now = LocalDateTime.now();
        template.setCreateTime(now);
        template.setUpdateTime(now);
        
        mapper.insert(template);
        
        // Java: 2024-01-22T15:30:00
        // PostgreSQL存储: 2024-01-22 15:30:00
    }
    
    // ============================================
    // 示例2：更新数据
    // ============================================
    public void updateTemplate(Long id) {
        EventTemplate template = new EventTemplate();
        template.setId(id);
        template.setIncidentName("更新后的名称");
        
        // ✅ 设置更新时间
        template.setUpdateTime(LocalDateTime.now());
        
        mapper.update(template);
    }
    
    // ============================================
    // 示例3：查询并格式化输出
    // ============================================
    public String getFormattedTime(Long id) {
        EventTemplate template = mapper.selectById(id);
        
        if (template != null && template.getUpdateTime() != null) {
            LocalDateTime updateTime = template.getUpdateTime();
            
            // ✅ 格式化输出
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String formatted = updateTime.format(formatter);
            
            // 输出: 2024-01-22 15:30:00 (无时区后缀)
            return formatted;
        }
        
        return null;
    }
    
    // ============================================
    // 示例4：从字符串解析时间
    // ============================================
    public void createFromString(String timeStr) {
        // 字符串转LocalDateTime
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime dateTime = LocalDateTime.parse(timeStr, formatter);
        
        EventTemplate template = new EventTemplate();
        template.setIncidentName("从字符串创建");
        template.setCreateTime(dateTime);
        template.setUpdateTime(dateTime);
        
        // ✅ MyBatis会正确处理LocalDateTime
        mapper.insert(template);
    }
    
    // ============================================
    // 示例5：时间计算
    // ============================================
    public void calculateTime() {
        EventTemplate template = mapper.selectById(1L);
        
        if (template != null) {
            LocalDateTime updateTime = template.getUpdateTime();
            
            // ✅ LocalDateTime支持时间计算
            LocalDateTime future = updateTime.plusDays(7);      // 7天后
            LocalDateTime past = updateTime.minusHours(12);     // 12小时前
            
            System.out.println("原始时间: " + updateTime);
            System.out.println("7天后: " + future);
            System.out.println("12小时前: " + past);
        }
    }
}
```

---

## 🔍 技术细节

### JDBC驱动的类型映射

PostgreSQL JDBC驱动（42.x版本）内置的类型映射表：

| Java 8+ 类型 | PostgreSQL类型 | 转换方式 | 说明 |
|-------------|---------------|---------|------|
| `LocalDateTime` | `timestamp` | **自动转换** ✅ | 不带时区，完美匹配 |
| `LocalDateTime` | `timestamptz` | 自动转换 | 会转为UTC存储 |
| `LocalDate` | `date` | 自动转换 | 仅日期部分 |
| `LocalTime` | `time` | 自动转换 | 仅时间部分 |
| `OffsetDateTime` | `timestamptz` | 自动转换 | 带时区偏移 |
| `ZonedDateTime` | `timestamptz` | 自动转换 | 带时区ID |
| `Instant` | `timestamptz` | 自动转换 | UTC时间戳 |

**关键点**：
- ✅ `LocalDateTime` → `timestamp` 是**无损转换**
- ✅ 不涉及时区计算，**性能最优**
- ✅ 存储和读取**完全一致**

---

## ⚡ 性能对比

### 方案1：LocalDateTime + jdbcType=TIMESTAMP（最快）

```xml
#{updateTime,jdbcType=TIMESTAMP}
```

**执行流程**：
```
Java LocalDateTime 
    ↓ (JDBC驱动直接转换)
PostgreSQL timestamp
```

**性能**：⭐⭐⭐⭐⭐
- 无类型转换开销
- 无字符串解析
- 直接二进制传输

---

### 方案2：String + CAST（较慢）

```xml
CAST(#{updateTime} AS timestamp)
```

**执行流程**：
```
Java String 
    ↓ (MyBatis绑定为VARCHAR)
PostgreSQL VARCHAR
    ↓ (PostgreSQL执行CAST)
PostgreSQL timestamp
```

**性能**：⭐⭐⭐
- 需要字符串解析
- 需要类型转换
- 额外的CPU开销

---

## 📋 jdbcType 完整列表

### MyBatis支持的jdbcType（常用）

| jdbcType | Java类型 | PostgreSQL类型 | 说明 |
|----------|---------|---------------|------|
| `TIMESTAMP` | `LocalDateTime`, `Timestamp`, `Date` | `timestamp`, `timestamptz` | 日期时间 |
| `DATE` | `LocalDate`, `Date` | `date` | 仅日期 |
| `TIME` | `LocalTime`, `Time` | `time` | 仅时间 |
| `VARCHAR` | `String` | `varchar`, `text` | 字符串 |
| `INTEGER` | `Integer`, `int` | `int4` | 整数 |
| `BIGINT` | `Long`, `long` | `int8` | 长整数 |
| `BOOLEAN` | `Boolean`, `boolean` | `bool` | 布尔值 |
| `NUMERIC` | `BigDecimal` | `numeric` | 精确数字 |

---

## ✅ 修改建议

### 如果你的Java实体类使用LocalDateTime

#### 当前的XML（使用CAST）
```xml
<!-- 当前方案：兼容String类型 -->
CAST(#{eventList.updateTime} AS timestamp)
```

#### 推荐的XML（使用jdbcType）
```xml
<!-- 推荐方案：适用于LocalDateTime -->
#{eventList.updateTime,jdbcType=TIMESTAMP}
```

**修改步骤**：
1. ✅ 确认Java实体类使用 `LocalDateTime`
2. ✅ 将XML中的 `CAST(#{field} AS timestamp)` 改为 `#{field,jdbcType=TIMESTAMP}`
3. ✅ 测试插入/更新/查询功能
4. ✅ 验证性能提升

---

## 🧪 验证测试

### 测试1：类型验证
```java
@Test
public void testLocalDateTimeType() {
    EventTemplate template = new EventTemplate();
    template.setIncidentName("类型测试");
    
    LocalDateTime now = LocalDateTime.now();
    template.setUpdateTime(now);
    
    // 插入
    mapper.insert(template);
    
    // 查询
    EventTemplate result = mapper.selectById(template.getId());
    
    // 验证类型
    assert result.getUpdateTime() instanceof LocalDateTime;
    System.out.println("✅ 类型正确: LocalDateTime");
    
    // 验证值（精度到秒）
    assert now.withNano(0).equals(result.getUpdateTime().withNano(0));
    System.out.println("✅ 值一致");
}
```

### 测试2：格式验证
```java
@Test
public void testTimeFormat() {
    EventTemplate template = mapper.selectById(1L);
    LocalDateTime updateTime = template.getUpdateTime();
    
    // 原始格式
    String raw = updateTime.toString();
    System.out.println("原始格式: " + raw);
    // 输出: 2024-01-22T15:30:00
    
    // 验证无时区后缀
    assert !raw.contains("+08");
    assert !raw.contains("Z");
    System.out.println("✅ 无时区后缀");
    
    // 格式化输出
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String formatted = updateTime.format(formatter);
    System.out.println("格式化: " + formatted);
    // 输出: 2024-01-22 15:30:00
    
    System.out.println("✅ 格式正确");
}
```

### 测试3：数据库验证
```sql
-- 在Navicat中执行

-- 1. 查看字段类型
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 't_event_template' 
  AND column_name = 'update_time';
-- 预期: timestamp without time zone

-- 2. 查看实际数据
SELECT id, incident_name, update_time 
FROM t_event_template 
LIMIT 5;
-- 预期: 2024-01-22 15:30:00.123456 (无+08)

-- 3. 验证类型转换
SELECT 
    update_time,
    update_time::text as time_as_text,
    pg_typeof(update_time) as time_type
FROM t_event_template 
LIMIT 1;
-- 预期: time_type = "timestamp without time zone"
```

---

## 🎯 总结

### 你的问题的答案

> **如果是 LocalDateTime 传入，也能用 jdbcType=TIMESTAMP 么？**

| 问题 | 答案 |
|------|------|
| **能用吗？** | ✅ **完全可以！** |
| **需要CAST吗？** | ❌ **不需要！** |
| **是最佳方案吗？** | ✅ **是的！** |
| **性能如何？** | ⭐⭐⭐⭐⭐ **最优！** |
| **推荐度** | ✅✅✅ **强烈推荐！** |

---

### 完整方案对比

| 方案 | Java类型 | XML写法 | 性能 | 推荐度 | 适用场景 |
|------|----------|---------|------|--------|----------|
| **方案A** | `LocalDateTime` | `#{field,jdbcType=TIMESTAMP}` | ⭐⭐⭐⭐⭐ | ✅✅✅ | **新项目、重构项目** |
| **方案B** | `LocalDateTime` | `#{field}` | ⭐⭐⭐⭐⭐ | ✅✅ | 简化写法 |
| **方案C** | `String` | `CAST(#{field} AS timestamp)` | ⭐⭐⭐ | ⚠️ | 临时兼容方案 |
| **方案D** | `Date` | `#{field,jdbcType=TIMESTAMP}` | ⭐⭐⭐ | ⚠️ | 老项目（不推荐） |

---

### 推荐配置组合

```
PostgreSQL:      timestamp(6)
     ↕ (完美匹配)
MyBatis XML:     #{field,jdbcType=TIMESTAMP}
     ↕ (自动转换)
Java:            LocalDateTime
```

**这是最佳实践！** ✅✅✅

---

## 📚 参考资料

1. **PostgreSQL JDBC驱动文档**：https://jdbc.postgresql.org/documentation/head/8-date-time.html
2. **MyBatis类型处理器**：https://mybatis.org/mybatis-3/configuration.html#typeHandlers
3. **Java LocalDateTime API**：https://docs.oracle.com/javase/8/docs/api/java/time/LocalDateTime.html

---

**最后更新**：2026-01-22  
**建议**：使用 `LocalDateTime + jdbcType=TIMESTAMP` 组合 ✅
