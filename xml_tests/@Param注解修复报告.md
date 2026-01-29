# @Param 注解缺失问题修复报告

## 🔴 核心问题

### 问题1：Mapper 接口缺少 @Param 注解

**症状：** 调用 `selectListByParams(os, perspective, type)` 时，返回 0 条数据。

**根本原因：** 
当 MyBatis Mapper 接口有**多个参数**时，如果不加 `@Param` 注解，XML 中的 `#{paramName}` 将**无法正确映射**到方法参数！

### 错误示例（❌ 会导致查询失败）

```java
// Mapper 接口
List<AttackKnowledge> selectListByParams(String os, String perspective, String type);
```

**实际效果：** XML 中的所有参数都是 `null`
```
#{os} = null
#{perspective} = null
#{type} = null
```

导致所有 `<if test="os != null and os != ''">` 条件都不成立，WHERE 子句为空。

### 正确写法（✅）

```java
// Mapper 接口 - 必须加 @Param 注解
List<AttackKnowledge> selectListByParams(
    @Param("os") String os, 
    @Param("perspective") String perspective, 
    @Param("type") String type
);
```

## ✅ 已修复的文件

### AttackKnowledgeMapper.java

所有多参数方法已添加 `@Param` 注解：

```java
package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.AttackKnowledge;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;  // ✅ 导入
import java.util.List;

@Mapper
public interface AttackKnowledgeMapper {
    
    // ✅ 3个参数都加了 @Param
    List<AttackKnowledge> selectListByParams(
        @Param("os") String os, 
        @Param("perspective") String perspective, 
        @Param("type") String type
    );
    
    // ✅ 1个参数也加了 @Param（推荐做法）
    List<AttackKnowledge> selectByparentCode(@Param("key") String key);
    
    String queryIdBytacticName(@Param("tacticName") String tacticName);
    String queryNameByCode(@Param("tacticCode") String tacticCode);
    String queryParentId(@Param("techniquesId") String techniquesId);
    
    // ✅ 4个参数都加了 @Param
    void updateByCode(
        @Param("techniqueCode") String techniqueCode, 
        @Param("os") String os, 
        @Param("perspective") String perspective, 
        @Param("deviceType") String deviceType
    );
    
    // ✅ 集合参数也加了 @Param
    void batchInsert(@Param("attackUpdateList") List<AttackKnowledge> attackUpdateList);
    
    // 无参数方法不需要 @Param
    List<String> selectTactic();
    void truncateTable();
}
```

## 📋 需要修复的其他 Mapper（紧急）

根据之前的分析，以下 Mapper 都有**多参数方法**，必须全部添加 `@Param` 注解：

### 高优先级（已生成 Controller，需立即修复）

1. **AssetInfoMapper**
   ```java
   // ❌ 错误
   List<Map<String, Object>> queryAssets(int offset, int size);
   
   // ✅ 正确
   List<Map<String, Object>> queryAssets(@Param("offset") int offset, @Param("size") int size);
   ```

2. **OutGoingConfigMapper**（5个方法都需要修复）
   ```java
   List<OutGoingConfig> selectOutGoingConfig(
       @Param("type") String type, 
       @Param("enable") Boolean enable
   );
   
   List<OutGoingConfig> selectOutGoingConfigByPage(
       @Param("type") String type, 
       @Param("enable") Boolean enable, 
       @Param("offset") int offset, 
       @Param("size") int size
   );
   
   void updateSwitchById(@Param("id") Integer id, @Param("enable") Boolean enable);
   ```

3. **ProhibitHistoryMapper**（7个多参数方法）
4. **SecurityEventMapper**（9个多参数方法）
5. **RiskIncidentMapper**（7个多参数方法）
6. **BlockHistoryMapper**（3个多参数方法）
7. **IntelligenceMapper**（3个多参数方法）
8. **LinkedStrategyMapper**（2个多参数方法）
9. **LinkedStrategyValidtimeMapper**（1个方法）
10. **QueryTemplateMapper**（1个方法）
11. **RiskIncidentHistoryMapper**（5个多参数方法）
12. **RiskIncidentOutGoingMapper**（3个多参数方法）
13. **RiskIncidentOutGoingHistoryMapper**（1个方法）
14. **StrategyDeviceRelMapper**（2个多参数方法）
15. **ThirdAuthMapper**（1个方法）

### 详细清单见：`Mapper参数类型修复报告.md`

## 🔧 修复规则

### 规则1：何时需要 @Param

| 情况 | 是否需要 @Param | 示例 |
|------|----------------|------|
| 无参数 | ❌ 不需要 | `List<Entity> selectAll();` |
| 1个参数（简单类型） | ✅ **推荐加**（MyBatis 3.4.1+可选） | `Entity selectById(@Param("id") Integer id);` |
| 2个及以上参数 | ✅ **必须加** | `List<Entity> query(@Param("id") Integer id, @Param("name") String name);` |
| 1个参数（实体对象） | ❌ 不需要 | `void insert(Entity entity);` |
| 集合参数（与XML的collection匹配） | ✅ **必须加** | `void batchInsert(@Param("list") List<Entity> list);` |

### 规则2：@Param 的值必须与 XML 中一致

```java
// Mapper 接口
List<Entity> query(@Param("userName") String name);
```

```xml
<!-- XML 中必须使用 userName -->
<select id="query" resultType="Entity">
    SELECT * FROM t_entity WHERE user_name = #{userName}
</select>
```

### 规则3：实体对象作为参数

```java
// 实体对象不需要 @Param
void updateUser(User user);

// 但如果同时有其他参数，实体对象也要加 @Param
void updateUserWithTime(@Param("user") User user, @Param("updateTime") String updateTime);
```

```xml
<!-- 不加 @Param 时，直接用属性名 -->
<update id="updateUser">
    UPDATE t_user SET name = #{name}, age = #{age} WHERE id = #{id}
</update>

<!-- 加了 @Param 后，要加前缀 -->
<update id="updateUserWithTime">
    UPDATE t_user SET 
        name = #{user.name}, 
        age = #{user.age}, 
        update_time = #{updateTime}
    WHERE id = #{user.id}
</update>
```

## 🐛 常见错误

### 错误1：忘记导入 @Param
```java
import org.apache.ibatis.annotations.Mapper;
// ❌ 忘记导入
// import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    // 编译错误：找不到 @Param
    List<User> query(@Param("id") Integer id);
}
```

### 错误2：@Param 的值与 XML 不一致
```java
// Mapper
List<User> query(@Param("userId") Integer id);
```

```xml
<!-- XML 中用了 id，而不是 userId -->
<select id="query">
    SELECT * FROM t_user WHERE id = #{id}  <!-- ❌ 应该是 #{userId} -->
</select>
```

### 错误3：参数类型不匹配
```java
// Mapper 定义为 String
List<User> query(@Param("id") String id);
```

```xml
<!-- XML 中定义为 INTEGER -->
<select id="query">
    SELECT * FROM t_user WHERE id = #{id,jdbcType=INTEGER}  <!-- ❌ 类型冲突 -->
</select>
```

## ✅ 修复验证

修复后，重新运行测试：

```bash
# 启动应用
mvn spring-boot:run

# 测试 AttackKnowledge
curl http://localhost:8080/test/attackKnowledge/test-select-list-by-params
```

**预期结果：** 返回包含 "Windows" 的攻击知识列表（应该有多条）

## 📝 批量修复脚本（可选）

如果要批量修复所有 Mapper，可以用以下 Python 脚本：

```python
import re
from pathlib import Path

mapper_dir = Path('xml_tests')

for mapper_file in mapper_dir.rglob('*Mapper.java'):
    with open(mapper_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 检查是否已导入 @Param
    if 'import org.apache.ibatis.annotations.Param;' not in content:
        # 在 Mapper 导入之后添加 Param 导入
        content = content.replace(
            'import org.apache.ibatis.annotations.Mapper;',
            'import org.apache.ibatis.annotations.Mapper;\nimport org.apache.ibatis.annotations.Param;'
        )
    
    # 查找所有方法声明（带多个参数的）
    # 这里需要更复杂的正则，只是示例
    # ...
    
    with open(mapper_file, 'w', encoding='utf-8') as f:
        f.write(content)
```

## 📚 参考文档

1. **MyBatis 官方文档**：https://mybatis.org/mybatis-3/java-api.html
2. **@Param 注解说明**：https://mybatis.org/mybatis-3/zh/java-api.html#sqlSession

## 总结

- ✅ **AttackKnowledgeMapper 已完成修复**，所有多参数方法都添加了 `@Param` 注解
- ⚠️  **其他 15 个 Mapper 需要同样修复**
- 📌 **记住：2个及以上参数时，必须加 @Param**
- 🔍 **检查方法**：如果查询返回 0 条或空结果，首先检查是否缺少 `@Param`

## 后续任务

1. ✅ AttackKnowledgeMapper - 已完成
2. ⏳ AssetInfoMapper - 待修复
3. ⏳ OutGoingConfigMapper - 待修复
4. ⏳ ProhibitHistoryMapper - 待修复（7个方法）
5. ⏳ SecurityEventMapper - 待修复（9个方法）
6. ⏳ RiskIncidentMapper - 待修复（7个方法）
7. ⏳ 其他 10 个 Mapper - 待修复

优先级：按照已生成 Controller 的顺序修复。
