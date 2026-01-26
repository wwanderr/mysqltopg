package com.test.controller;

import com.dbapp.extension.xdr.scenario.mapper.ScenarioDataMapper;
import com.dbapp.extension.xdr.threatMonitor.entity.ScenarioData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/test/scenario-data")
public class ScenarioDataTestController {
    @Autowired
    private ScenarioDataMapper mapper;

    @GetMapping("/test-insert-or-update")
    public void testInsertOrUpdate() {
        try {
            ScenarioData data = new ScenarioData();
            data.setScenarioId("SCEN-TEST-001");
            data.setTemplateId(1001L);
            data.setDataContent("{\"test\": \"data\"}");
            data.setMatchScore(80);
            data.setStatus("matched");
            
            mapper.insertOrUpdate(data);
            System.out.println("✅ 插入/更新成功");
        } catch (Exception e) {
            System.err.println("❌ 操作失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
