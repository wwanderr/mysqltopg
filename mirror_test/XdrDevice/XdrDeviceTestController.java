package com.test.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dbapp.xdr.bean.dto.LicenseStatusDto;
import com.dbapp.xdr.bean.dto.XdrDeviceDetailDto;
import com.dbapp.xdr.bean.dto.XdrDeviceDto;
import com.dbapp.xdr.bean.request.XdrDeviceDetailRequest;
import com.dbapp.xdr.bean.request.XdrDeviceRequest;
import com.dbapp.xdr.bean.response.XdrDeviceBase;
import com.dbapp.xdr.mapper.XdrDeviceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * XdrDevice 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的 6 个方法：
 * - getAllXdrDevices
 * - getXdrDevices
 * - listXdrDevices
 * - getXdrDeviceByAgentCode
 * - getAgentTypeLicenseStatus
 * - getXdrDeviceByNo
 *
 * 依赖视图：
 * - t_sev_agent_view（基础视图）
 * - t_sev_agent_detail_view（详细视图）
 *
 * 依赖表：
 * - t_sev_agent_info
 * - t_sev_agent_type
 * - t_sev_agent_license
 * - t_sev_agent_monitor（可选）
 * - t_org（可选，用于 orgName）
 *
 * 测试数据：
 * - mirror_test/XdrDevice/test_data.sql
 */
@RestController
@RequestMapping("/test/mirror/xdrDevice")
public class XdrDeviceTestController {

    @Autowired
    private XdrDeviceMapper mapper;

    /**
     * 测试1：getAllXdrDevices
     * URL: /test/mirror/xdrDevice/test1-getAllXdrDevices
     */
    @GetMapping("/test1-getAllXdrDevices")
    public String test1_getAllXdrDevices() {
        try {
            XdrDeviceRequest request = new XdrDeviceRequest();
            request.setTypeName("APT");
            request.setStatus("online");
            request.setDeviceName("XDR");

            List<XdrDeviceDto> result = mapper.getAllXdrDevices(request);

            System.out.println("✅ getAllXdrDevices 执行成功");
            System.out.println("  request.typeName=" + request.getTypeName() + ", request.status=" + request.getStatus());
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            if (result != null && !result.isEmpty()) {
                for (int i = 0; i < Math.min(result.size(), 3); i++) {
                    XdrDeviceDto dto = result.get(i);
                    System.out.println("  [" + i + "] agentCode=" + dto.getAgentCode() + ", agentName=" + dto.getAgentName());
                }
            }

            return "SUCCESS: getAllXdrDevices, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test1_getAllXdrDevices 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：getXdrDevices（分页）
     * URL: /test/mirror/xdrDevice/test2-getXdrDevices
     */
    @GetMapping("/test2-getXdrDevices")
    public String test2_getXdrDevices() {
        try {
            Page<XdrDeviceDto> page = new Page<>(1L, 10L);
            XdrDeviceRequest request = new XdrDeviceRequest();
            request.setTypeName("APT");

            Page<XdrDeviceDto> result = mapper.getXdrDevices(page, request);

            System.out.println("✅ getXdrDevices 执行成功");
            System.out.println("  page=" + page.getCurrent() + ", size=" + page.getSize());
            System.out.println("  result.total=" + (result == null ? 0 : result.getTotal()));
            System.out.println("  result.records.size()=" + (result == null || result.getRecords() == null ? 0 : result.getRecords().size()));

            return "SUCCESS: getXdrDevices, total=" + (result == null ? 0 : result.getTotal());
        } catch (Exception e) {
            String msg = "❌ test2_getXdrDevices 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试3：listXdrDevices（分页）
     * URL: /test/mirror/xdrDevice/test3-listXdrDevices
     */
    @GetMapping("/test3-listXdrDevices")
    public String test3_listXdrDevices() {
        try {
            Page<XdrDeviceBase> page = new Page<>(1L, 10L);
            XdrDeviceRequest request = new XdrDeviceRequest();
            request.setStatus("online");

            Page<XdrDeviceBase> result = mapper.listXdrDevices(page, request);

            System.out.println("✅ listXdrDevices 执行成功");
            System.out.println("  page=" + page.getCurrent() + ", size=" + page.getSize());
            System.out.println("  result.total=" + (result == null ? 0 : result.getTotal()));
            System.out.println("  result.records.size()=" + (result == null || result.getRecords() == null ? 0 : result.getRecords().size()));

            return "SUCCESS: listXdrDevices, total=" + (result == null ? 0 : result.getTotal());
        } catch (Exception e) {
            String msg = "❌ test3_listXdrDevices 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试4：getXdrDeviceByAgentCode
     * URL: /test/mirror/xdrDevice/test4-getXdrDeviceByAgentCode
     */
    @GetMapping("/test4-getXdrDeviceByAgentCode")
    public String test4_getXdrDeviceByAgentCode() {
        try {
            String orderSql = "agentCode ASC";
            XdrDeviceDetailRequest request = new XdrDeviceDetailRequest();
            request.setAgentCode("XDR_DEVICE_1");
            request.setTypeName("APT");

            XdrDeviceDetailDto result = mapper.getXdrDeviceByAgentCode(orderSql, request);

            System.out.println("✅ getXdrDeviceByAgentCode 执行成功");
            System.out.println("  orderSql=" + orderSql + ", request.agentCode=" + request.getAgentCode());
            if (result != null) {
                System.out.println("  result.agentCode=" + result.getAgentCode() + ", agentName=" + result.getAgentName());
            } else {
                System.out.println("  返回为空");
            }

            return "SUCCESS: getXdrDeviceByAgentCode, exists=" + (result != null);
        } catch (Exception e) {
            String msg = "❌ test4_getXdrDeviceByAgentCode 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试5：getAgentTypeLicenseStatus
     * URL: /test/mirror/xdrDevice/test5-getAgentTypeLicenseStatus
     */
    @GetMapping("/test5-getAgentTypeLicenseStatus")
    public String test5_getAgentTypeLicenseStatus() {
        try {
            List<LicenseStatusDto> result = mapper.getAgentTypeLicenseStatus();

            System.out.println("✅ getAgentTypeLicenseStatus 执行成功");
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            if (result != null && !result.isEmpty()) {
                for (int i = 0; i < Math.min(result.size(), 3); i++) {
                    LicenseStatusDto dto = result.get(i);
                    System.out.println("  [" + i + "] agentType=" + dto.getAgentType() + ", licenseType=" + dto.getLicenseType());
                }
            }

            return "SUCCESS: getAgentTypeLicenseStatus, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test5_getAgentTypeLicenseStatus 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试6：getXdrDeviceByNo
     * URL: /test/mirror/xdrDevice/test6-getXdrDeviceByNo
     */
    @GetMapping("/test6-getXdrDeviceByNo")
    public String test6_getXdrDeviceByNo() {
        try {
            String orderSql = "agentCode ASC";
            XdrDeviceDetailRequest request = new XdrDeviceDetailRequest();
            request.setTypeName("APT");
            long no = 1L;

            XdrDeviceDetailDto result = mapper.getXdrDeviceByNo(orderSql, request, no);

            System.out.println("✅ getXdrDeviceByNo 执行成功");
            System.out.println("  orderSql=" + orderSql + ", no=" + no);
            if (result != null) {
                System.out.println("  result.no=" + result.getNo() + ", agentCode=" + result.getAgentCode());
            } else {
                System.out.println("  返回为空");
            }

            return "SUCCESS: getXdrDeviceByNo, exists=" + (result != null);
        } catch (Exception e) {
            String msg = "❌ test6_getXdrDeviceByNo 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * URL: /test/mirror/xdrDevice/test-all
     */
    @GetMapping("/test-all")
    public String testAll() {
        StringBuilder sb = new StringBuilder("ALL DONE\n");
        sb.append(test1_getAllXdrDevices()).append("\n");
        sb.append(test2_getXdrDevices()).append("\n");
        sb.append(test3_listXdrDevices()).append("\n");
        sb.append(test4_getXdrDeviceByAgentCode()).append("\n");
        sb.append(test5_getAgentTypeLicenseStatus()).append("\n");
        sb.append(test6_getXdrDeviceByNo()).append("\n");
        return sb.toString();
    }
}
