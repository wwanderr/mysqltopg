package com.test.controller;

import com.dbapp.extension.xdr.security.mapper.SecurityAlarmHandleMapper;
import com.dbapp.extension.xdr.security.entity.SecurityAlarmHandle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/test/security-alarm-handle")
public class SecurityAlarmHandleTestController {

    @Autowired
    private SecurityAlarmHandleMapper mapper;

    @GetMapping("/test-query-by-alarm")
    public String testQueryByAlarm() {
        try {
            String alarmId = "1001";
            List<SecurityAlarmHandle> result = mapper.selectByAlarmId(alarmId);
            System.out.println("✅ 查询告警处理记录，共 " + result.size() + " 条");
            return "查询成功，共 " + result.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            return "查询失败";
        }
    }
}
