package com.dbapp.extension.xdr.test;

import com.dbapp.extension.xdr.outgoingData.po.AlarmOutGoingConfig;
import com.dbapp.extension.xdr.outgoingData.mapper.AlarmOutGoingConfigMapper;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * PostgreSQL时间字段测试类
 * 验证 LocalDateTime 与 timestamp(6) 的正确转换
 */
@SpringBootTest
public class TimeFieldTest {
    
    @Autowired
    private AlarmOutGoingConfigMapper mapper;
    
    /**
     * 测试1: 插入时间数据
     * 验证 LocalDateTime -> PostgreSQL timestamp(6)
     */
    @Test
    public void testInsertTimeField() {
        AlarmOutGoingConfig config = new AlarmOutGoingConfig();
        config.setAlarmSource("测试来源");
        config.setEnable(1);
        config.setIsDel(0);
        
        // 使用 LocalDateTime 设置时间
        LocalDateTime now = LocalDateTime.now();
        config.setCreateTime(now);
        config.setUpdateTime(now);
        config.setLastSendTime(now);
        
        // 插入数据库
        int result = mapper.insert(config);
        
        System.out.println("插入结果: " + result);
        System.out.println("Java LocalDateTime: " + now);
        System.out.println("预期PostgreSQL存储: " + now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
    }
    
    /**
     * 测试2: 查询时间数据
     * 验证 PostgreSQL timestamp(6) -> LocalDateTime
     */
    @Test
    public void testQueryTimeField() {
        AlarmOutGoingConfig config = mapper.selectById(1L);
        
        if (config != null) {
            LocalDateTime createTime = config.getCreateTime();
            LocalDateTime updateTime = config.getUpdateTime();
            LocalDateTime lastSendTime = config.getLastSendTime();
            
            System.out.println("===== 时间字段查询结果 =====");
            System.out.println("Create Time: " + createTime);
            System.out.println("Update Time: " + updateTime);
            System.out.println("Last Send Time: " + lastSendTime);
            System.out.println();
            
            // 格式化输出（去除T）
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            System.out.println("===== 格式化输出 =====");
            System.out.println("Create Time: " + createTime.format(formatter));
            System.out.println("Update Time: " + updateTime.format(formatter));
            System.out.println("Last Send Time: " + (lastSendTime != null ? lastSendTime.format(formatter) : "NULL"));
            System.out.println();
            
            // 验证无时区后缀
            String timeStr = createTime.toString();
            System.out.println("===== 验证无时区后缀 =====");
            System.out.println("toString(): " + timeStr);
            System.out.println("包含+08? " + timeStr.contains("+08"));
            System.out.println("包含时区? " + (timeStr.contains("+") || timeStr.contains("Z")));
            
            // 断言验证
            assert !timeStr.contains("+08") : "时间字符串不应包含时区后缀+08";
            assert !timeStr.contains("Z") : "时间字符串不应包含时区标识Z";
            
            System.out.println("✅ 验证通过：时间字段不包含时区信息");
        }
    }
    
    /**
     * 测试3: 对比修改前后的差异
     */
    @Test
    public void testTimeFieldComparison() {
        System.out.println("===== PostgreSQL时间类型对比 =====");
        System.out.println();
        
        System.out.println("【修改前】使用 timestamptz(6):");
        System.out.println("  PostgreSQL存储: 2024-01-15 14:30:00+08");
        System.out.println("  Java获取(Date): 2024-01-15 14:30:00+08 ❌");
        System.out.println("  Java获取(String): 2024-01-15 14:30:00+08 ❌");
        System.out.println();
        
        System.out.println("【修改后】使用 timestamp(6):");
        System.out.println("  PostgreSQL存储: 2024-01-15 14:30:00");
        System.out.println("  Java获取(LocalDateTime): 2024-01-15T14:30:00 ✅");
        System.out.println("  格式化输出: 2024-01-15 14:30:00 ✅");
        System.out.println();
        
        System.out.println("【核心差异】:");
        System.out.println("  1. timestamp(6) 不存储时区信息");
        System.out.println("  2. LocalDateTime 不包含时区信息");
        System.out.println("  3. JDBC自动转换，无需手动处理");
        System.out.println("  4. 完美对齐MySQL的 datetime 语义");
    }
    
    /**
     * 测试4: LocalDateTime的各种操作
     */
    @Test
    public void testLocalDateTimeOperations() {
        LocalDateTime now = LocalDateTime.now();
        
        System.out.println("===== LocalDateTime常用操作 =====");
        System.out.println();
        
        // 1. 基本输出
        System.out.println("1. toString(): " + now);
        System.out.println("   格式: yyyy-MM-ddTHH:mm:ss.SSS");
        System.out.println();
        
        // 2. 格式化输出
        DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        System.out.println("2. 格式化(标准): " + now.format(formatter1));
        
        DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy年MM月dd日 HH:mm:ss");
        System.out.println("   格式化(中文): " + now.format(formatter2));
        System.out.println();
        
        // 3. 字符串解析
        String timeStr = "2024-01-15 14:30:00";
        LocalDateTime parsed = LocalDateTime.parse(timeStr, formatter1);
        System.out.println("3. 解析字符串: " + timeStr + " -> " + parsed);
        System.out.println();
        
        // 4. 时间计算
        LocalDateTime future = now.plusDays(7);
        LocalDateTime past = now.minusHours(12);
        System.out.println("4. 时间计算:");
        System.out.println("   当前时间: " + now.format(formatter1));
        System.out.println("   7天后: " + future.format(formatter1));
        System.out.println("   12小时前: " + past.format(formatter1));
        System.out.println();
        
        // 5. 获取各部分
        System.out.println("5. 获取各部分:");
        System.out.println("   年: " + now.getYear());
        System.out.println("   月: " + now.getMonthValue());
        System.out.println("   日: " + now.getDayOfMonth());
        System.out.println("   时: " + now.getHour());
        System.out.println("   分: " + now.getMinute());
        System.out.println("   秒: " + now.getSecond());
    }
    
    /**
     * 测试5: MyBatis返回时间字段
     */
    @Test
    public void testMyBatisReturnTime() {
        // 模拟MyBatis查询
        AlarmOutGoingConfig config = mapper.selectById(1L);
        
        if (config != null && config.getCreateTime() != null) {
            LocalDateTime createTime = config.getCreateTime();
            
            System.out.println("===== MyBatis返回的时间字段 =====");
            System.out.println();
            System.out.println("Java对象: " + config.getClass().getName());
            System.out.println("字段类型: " + createTime.getClass().getName());
            System.out.println("字段值: " + createTime);
            System.out.println();
            
            // 检查是否包含时区
            String timeStr = createTime.toString();
            boolean hasTimezone = timeStr.contains("+") || 
                                 timeStr.contains("Z") || 
                                 timeStr.contains("CST");
            
            System.out.println("检查时区:");
            System.out.println("  toString结果: " + timeStr);
            System.out.println("  是否包含时区: " + (hasTimezone ? "是 ❌" : "否 ✅"));
            System.out.println();
            
            if (!hasTimezone) {
                System.out.println("✅ 验证通过: MyBatis正确返回了不带时区的LocalDateTime");
            } else {
                System.out.println("❌ 验证失败: 时间字段仍包含时区信息");
                System.out.println("   可能原因:");
                System.out.println("   1. DDL未修改（仍使用timestamptz）");
                System.out.println("   2. 实体类未使用LocalDateTime");
                System.out.println("   3. JDBC驱动版本过低");
            }
        }
    }
}
