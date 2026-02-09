package com.test.controller;

import com.dbapp.xdr.bean.meta.PackageType;
import com.dbapp.xdr.mapper.TSevAgentPackageMapper;
import org.apache.commons.lang3.tuple.MutablePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * TSevAgentPackage 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的 2 个方法：
 * - getAllLastVersionByAgentType
 * - selectNotLastTwoPackage
 *
 * 依赖表：
 * - t_sev_agent_package（主表）
 * - t_sev_agent_type（外键依赖：agent_type）
 * - t_bs_files（外键依赖：file_uuid，测试数据中可暂时忽略或使用假 UUID）
 *
 * 测试数据：
 * - mirror_test/TSevAgentPackage/test_data.sql
 */
@RestController
@RequestMapping("/test/mirror/tSevAgentPackage")
public class TSevAgentPackageTestController {

    @Autowired
    private TSevAgentPackageMapper mapper;

    /**
     * 测试1：getAllLastVersionByAgentType
     * URL: /test/mirror/tSevAgentPackage/test1-getAllLastVersion
     * 
     * 功能：获取指定 agent_type 的所有 package_type 的最新版本
     */
    @GetMapping("/test1-getAllLastVersion")
    public String test1_getAllLastVersionByAgentType() {
        try {
            String agentType = "APT";
            List<MutablePair<PackageType, String>> result = mapper.getAllLastVersionByAgentType(agentType);

            System.out.println("✅ getAllLastVersionByAgentType 执行成功");
            System.out.println("  agentType=" + agentType);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            
            if (result != null && !result.isEmpty()) {
                for (MutablePair<PackageType, String> pair : result) {
                    System.out.println("  - packageType=" + pair.getLeft() + ", version=" + pair.getRight());
                }
            } else {
                System.out.println("  返回为空");
            }

            return "SUCCESS: getAllLastVersionByAgentType, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test1_getAllLastVersionByAgentType 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：selectNotLastTwoPackage
     * URL: /test/mirror/tSevAgentPackage/test2-selectNotLastTwo
     * 
     * 功能：选择不是最后两个的包（用于清理旧包）
     * 逻辑：返回 update_time 小于倒数第二个包的包
     */
    @GetMapping("/test2-selectNotLastTwo")
    public String test2_selectNotLastTwoPackage() {
        try {
            String agentType = "APT";
            PackageType packageType = PackageType.SOFTWARE;
            
            List<MutablePair<Long, String>> result = mapper.selectNotLastTwoPackage(agentType, packageType);

            System.out.println("✅ selectNotLastTwoPackage 执行成功");
            System.out.println("  agentType=" + agentType + ", packageType=" + packageType);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            
            if (result != null && !result.isEmpty()) {
                for (MutablePair<Long, String> pair : result) {
                    System.out.println("  - id=" + pair.getLeft() + ", fileUuid=" + pair.getRight());
                }
            } else {
                System.out.println("  返回为空（可能该类型只有2个或更少的包）");
            }

            return "SUCCESS: selectNotLastTwoPackage, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test2_selectNotLastTwoPackage 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * URL: /test/mirror/tSevAgentPackage/test-all
     */
    @GetMapping("/test-all")
    public String testAll() {
        String r1 = test1_getAllLastVersionByAgentType();
        String r2 = test2_selectNotLastTwoPackage();
        return "ALL DONE\n" + r1 + "\n" + r2;
    }
}
