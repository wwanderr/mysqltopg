package com.test.controller;

import com.dbapp.extension.xdr.commonConfig.mapper.CommonConfigMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * CommonConfig 测试控制器
 *
 * 覆盖 Mapper 中的 4 个方法：
 * - queryCommonConfig
 * - updateCommonConfig
 * - insertCommonConfig
 * - queryMirrorCommonConfig
 *
 * 注意：
 * - 这里直接在测试方法里读 / 写 t_common_config 表的配置项，
 *   采用一个前缀为 "test.common" 的专用配置键，避免污染业务数据。
 */
@RestController
@RequestMapping("/test/commonConfig")
public class CommonConfigTestController {

    @Autowired
    private CommonConfigMapper mapper;

    /**
     * 测试1：queryCommonConfig 查询已有配置
     * URL: /test/commonConfig/testQuery
     *
     * 期望：如果库里已经有 prefix='style' AND key='title' 的配置，则能查询到值；
     * 如果没有也不会报错，只是返回 null。
     */
    @GetMapping("/testQuery")
    public String testQueryCommonConfig() {
        try {
            String prefix = "style";
            String key = "title";
            String value = mapper.queryCommonConfig(prefix, key);
            System.out.println("queryCommonConfig(" + prefix + "," + key + ") = " + value);
            return "SUCCESS: value=" + value;
        } catch (Exception e) {
            String msg = "testQueryCommonConfig 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：insertCommonConfig 插入测试配置
     * URL: /test/commonConfig/testInsert
     *
     * 步骤：
     * - 使用 prefix='test.common', key='demo.key' 插入一条记录
     * - 然后再次 queryCommonConfig 验证是否插入成功
     */
    @GetMapping("/testInsert")
    public String testInsertCommonConfig() {
        try {
            String prefix = "test.common";
            String key = "demo.key";
            String value = "v1";

            System.out.println("调用 insertCommonConfig 插入配置: " + prefix + " / " + key + " = " + value);
            mapper.insertCommonConfig(prefix, key, value);

            String dbValue = mapper.queryCommonConfig(prefix, key);
            System.out.println("插入后查询 queryCommonConfig = " + dbValue);
            return "SUCCESS: inserted value=" + dbValue;
        } catch (Exception e) {
            String msg = "testInsertCommonConfig 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试3：updateCommonConfig 更新测试配置
     * URL: /test/commonConfig/testUpdate
     *
     * 步骤：
     * - 先确保有一条 prefix='test.common', key='demo.key' 的记录（如无则插入）
     * - 调用 updateCommonConfig 更新为新值
     * - 再 queryCommonConfig 校验
     */
    @GetMapping("/testUpdate")
    public String testUpdateCommonConfig() {
        try {
            String prefix = "test.common";
            String key = "demo.key";

            // 1. 如果不存在则先插入一条初始值
            String origin = mapper.queryCommonConfig(prefix, key);
            if (origin == null) {
                System.out.println("原始配置不存在，先调用 insertCommonConfig 初始化");
                mapper.insertCommonConfig(prefix, key, "init");
            }

            // 2. 调用 updateCommonConfig 更新为新值
            String newValue = "updated-" + System.currentTimeMillis();
            System.out.println("调用 updateCommonConfig 更新配置: " + prefix + " / " + key + " = " + newValue);
            int rows = mapper.updateCommonConfig(prefix, key, newValue);
            System.out.println("updateCommonConfig 影响行数 = " + rows);

            // 3. 再查一次确认
            String dbValue = mapper.queryCommonConfig(prefix, key);
            System.out.println("更新后查询 queryCommonConfig = " + dbValue);
            return "SUCCESS: rows=" + rows + ", value=" + dbValue;
        } catch (Exception e) {
            String msg = "testUpdateCommonConfig 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试4：queryMirrorCommonConfig 镜像查询
     * URL: /test/commonConfig/testMirrorQuery
     *
     * 与 queryCommonConfig 传入同样的参数，主要验证 XML 中镜像 SQL 是否可用。
     */
    @GetMapping("/testMirrorQuery")
    public String testQueryMirrorCommonConfig() {
        try {
            String prefix = "test.common";
            String key = "demo.key";

            String value = mapper.queryMirrorCommonConfig(prefix, key);
            System.out.println("queryMirrorCommonConfig(" + prefix + "," + key + ") = " + value);
            return "SUCCESS: mirrorValue=" + value;
        } catch (Exception e) {
            String msg = "testQueryMirrorCommonConfig 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }
}

