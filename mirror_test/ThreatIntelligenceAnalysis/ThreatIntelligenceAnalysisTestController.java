package com.test.controller;

import com.dbapp.xdr.bean.dto.AptDeleteDto;
import com.dbapp.xdr.bean.dto.AptHostDto;
import com.dbapp.xdr.bean.po.ThreatIntelligenceAnalysis;
import com.dbapp.xdr.mapper.ThreatIntelligenceAnalysisMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;

/**
 * ThreatIntelligenceAnalysis 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的 3 个方法：
 * - getServerById
 * - getAptDeleteDtosByIds
 * - selectAll
 *
 * 依赖表：
 * - t_threat_intelligence_analysis
 * - t_sev_agent_info
 *
 * 测试数据：
 * - mirror_test/ThreatIntelligenceAnalysis/test_data.sql
 */
@RestController
@RequestMapping("/test/mirror/threatIntelligenceAnalysis")
public class ThreatIntelligenceAnalysisTestController {

    @Autowired
    private ThreatIntelligenceAnalysisMapper mapper;

    /**
     * 测试1：getServerById
     * URL: /test/mirror/threatIntelligenceAnalysis/test1-getServerById
     */
    @GetMapping("/test1-getServerById")
    public String test1_getServerById() {
        try {
            Long id = 9001L;
            AptHostDto dto = mapper.getServerById(id);

            System.out.println("✅ getServerById 执行成功");
            System.out.println("  id=" + id);
            System.out.println("  server=" + (dto == null ? null : dto.getServer()));
            System.out.println("  machineCode=" + (dto == null ? null : dto.getMachineCode()));

            return "SUCCESS: getServerById, dto=" + (dto == null ? "null" : (dto.getServer() + "," + dto.getMachineCode()));
        } catch (Exception e) {
            String msg = "❌ test1_getServerById 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：getAptDeleteDtosByIds
     * URL: /test/mirror/threatIntelligenceAnalysis/test2-getAptDeleteDtosByIds
     */
    @GetMapping("/test2-getAptDeleteDtosByIds")
    public String test2_getAptDeleteDtosByIds() {
        try {
            Collection<Long> ids = Arrays.asList(9001L, 9002L, 9999L); // 9999 用于验证不存在的 ID 不影响
            List<AptDeleteDto> list = mapper.getAptDeleteDtosByIds(ids);

            System.out.println("✅ getAptDeleteDtosByIds 执行成功");
            System.out.println("  ids=" + ids);
            System.out.println("  size=" + (list == null ? 0 : list.size()));
            if (list != null && !list.isEmpty()) {
                AptDeleteDto first = list.get(0);
                System.out.println("  first.id=" + first.getId() + ", server=" + first.getServer() + ", machineCode=" + first.getMachineCode());
            }

            return "SUCCESS: getAptDeleteDtosByIds, size=" + (list == null ? 0 : list.size());
        } catch (Exception e) {
            String msg = "❌ test2_getAptDeleteDtosByIds 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试3：selectAll
     * URL: /test/mirror/threatIntelligenceAnalysis/test3-selectAll
     */
    @GetMapping("/test3-selectAll")
    public String test3_selectAll() {
        try {
            List<ThreatIntelligenceAnalysis> list = mapper.selectAll();

            System.out.println("✅ selectAll 执行成功");
            System.out.println("  size=" + (list == null ? 0 : list.size()));
            if (list != null && !list.isEmpty()) {
                ThreatIntelligenceAnalysis first = list.get(0);
                System.out.println("  first.id=" + first.getId() + ", agentCode=" + first.getAgentCode() + ", fileName=" + first.getFileName());
            }

            return "SUCCESS: selectAll, size=" + (list == null ? 0 : list.size());
        } catch (Exception e) {
            String msg = "❌ test3_selectAll 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * URL: /test/mirror/threatIntelligenceAnalysis/test-all
     */
    @GetMapping("/test-all")
    public String testAll() {
        String r1 = test1_getServerById();
        String r2 = test2_getAptDeleteDtosByIds();
        String r3 = test3_selectAll();
        return "ALL DONE\n" + r1 + "\n" + r2 + "\n" + r3;
    }
}

