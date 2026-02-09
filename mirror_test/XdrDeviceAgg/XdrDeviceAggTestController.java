package com.test.controller;

import com.dbapp.xdr.bean.dto.KeyValueCount;
import com.dbapp.xdr.bean.dto.PointSum;
import com.dbapp.xdr.bean.dto.HourSum;
import com.dbapp.xdr.bean.meta.XdrTimeEnum;
import com.dbapp.xdr.bean.request.XdrDeviceRequest;
import com.dbapp.xdr.mapper.XdrDeviceAggMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * XdrDeviceAgg 测试控制器（Mirror 测试套件）
 *
 * 覆盖 Mapper 中的 13 个方法：
 * - getAgentTypeStausCount
 * - getAgentTypeIps
 * - getAgentTypeMetric3Sum
 * - getAgentTypeCpuCount
 * - getAgentTypeMemCount
 * - getAgentTypeMetric1AndMetric2Sum
 * - getAgentTypeMetric1Sum
 * - getAgentDataMetric1
 * - getAgentDataMetric2
 * - getAgentDataMetric3
 * - queryAllDeviceCount
 * - queryTodayStatistics
 * - queryTodayStatisticsByIp
 *
 * 依赖表 / 视图（同 XdrDeviceAggMapper.xml）：
 * - t_sev_agent_info
 * - t_sev_agent_type
 * - t_sev_agent_license
 * - t_sev_agent_monitor
 * - 以及可能的组织相关表 / 视图
 *
 * 测试数据建议复用：
 * - mirror_test/XdrDeviceAgg/test_data.sql
 *   （已准备 t_sev_agent_info / t_sev_agent_type / t_sev_agent_license / t_sev_agent_monitor 及组织表）
 */
@RestController
@RequestMapping("/test/mirror/xdrDeviceAgg")
public class XdrDeviceAggTestController {

    @Autowired
    private XdrDeviceAggMapper mapper;

    /**
     * 测试1：getAgentTypeStausCount
     * URL: /test/mirror/xdrDeviceAgg/test1-getAgentTypeStausCount
     */
    @GetMapping("/test1-getAgentTypeStausCount")
    public String test1_getAgentTypeStausCount() {
        try {
            List<KeyValueCount> result = mapper.getAgentTypeStausCount();

            System.out.println("✅ getAgentTypeStausCount 执行成功");
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            if (result != null) {
                for (int i = 0; i < Math.min(result.size(), 5); i++) {
                    KeyValueCount kv = result.get(i);
                    System.out.println("  [" + i + "] name=" + kv.getName()
                            + ", value=" + kv.getValue()
                            + ", count=" + kv.getCount()
                            + ", count2=" + kv.getCount2());
                }
            }

            return "SUCCESS: getAgentTypeStausCount, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test1_getAgentTypeStausCount 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试2：getAgentTypeIps
     * URL: /test/mirror/xdrDeviceAgg/test2-getAgentTypeIps
     */
    @GetMapping("/test2-getAgentTypeIps")
    public String test2_getAgentTypeIps() {
        try {
            // 方法签名有一个 int 参数，但 XML 中未使用，这里传 0 即可
            List<KeyValueCount> result = mapper.getAgentTypeIps(0);

            System.out.println("✅ getAgentTypeIps 执行成功");
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            if (result != null) {
                for (int i = 0; i < Math.min(result.size(), 5); i++) {
                    KeyValueCount kv = result.get(i);
                    System.out.println("  [" + i + "] name=" + kv.getName()
                            + ", value=" + kv.getValue());
                }
            }

            return "SUCCESS: getAgentTypeIps, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test2_getAgentTypeIps 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试3：getAgentTypeMetric3Sum
     * URL: /test/mirror/xdrDeviceAgg/test3-getAgentTypeMetric3Sum
     */
    @GetMapping("/test3-getAgentTypeMetric3Sum")
    public String test3_getAgentTypeMetric3Sum() {
        try {
            List<KeyValueCount> result = mapper.getAgentTypeMetric3Sum();

            System.out.println("✅ getAgentTypeMetric3Sum 执行成功");
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            if (result != null) {
                for (int i = 0; i < Math.min(result.size(), 5); i++) {
                    KeyValueCount kv = result.get(i);
                    System.out.println("  [" + i + "] value(agentType)=" + kv.getValue()
                            + ", count2(sumMetric3)=" + kv.getCount2());
                }
            }

            return "SUCCESS: getAgentTypeMetric3Sum, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test3_getAgentTypeMetric3Sum 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试4：getAgentTypeCpuCount
     * URL: /test/mirror/xdrDeviceAgg/test4-getAgentTypeCpuCount
     */
    @GetMapping("/test4-getAgentTypeCpuCount")
    public String test4_getAgentTypeCpuCount() {
        try {
            double threshold = 20.0;
            int minutes = 1;

            List<KeyValueCount> result = mapper.getAgentTypeCpuCount(threshold, minutes);

            System.out.println("✅ getAgentTypeCpuCount 执行成功");
            System.out.println("  threshold=" + threshold + ", minutes=" + minutes);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            if (result != null) {
                for (int i = 0; i < Math.min(result.size(), 5); i++) {
                    KeyValueCount kv = result.get(i);
                    System.out.println("  [" + i + "] value(agentType)=" + kv.getValue()
                            + ", count=" + kv.getCount());
                }
            }

            return "SUCCESS: getAgentTypeCpuCount, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test4_getAgentTypeCpuCount 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试5：getAgentTypeMemCount
     * URL: /test/mirror/xdrDeviceAgg/test5-getAgentTypeMemCount
     */
    @GetMapping("/test5-getAgentTypeMemCount")
    public String test5_getAgentTypeMemCount() {
        try {
            double threshold = 0.5; // 内存使用率阈值
            int minutes = 1;

            List<KeyValueCount> result = mapper.getAgentTypeMemCount(threshold, minutes);

            System.out.println("✅ getAgentTypeMemCount 执行成功");
            System.out.println("  threshold=" + threshold + ", minutes=" + minutes);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            if (result != null) {
                for (int i = 0; i < Math.min(result.size(), 5); i++) {
                    KeyValueCount kv = result.get(i);
                    System.out.println("  [" + i + "] value(agentType)=" + kv.getValue()
                            + ", count=" + kv.getCount());
                }
            }

            return "SUCCESS: getAgentTypeMemCount, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test5_getAgentTypeMemCount 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试6：getAgentTypeMetric1AndMetric2Sum
     * URL: /test/mirror/xdrDeviceAgg/test6-getAgentTypeMetric1AndMetric2Sum
     */
    @GetMapping("/test6-getAgentTypeMetric1AndMetric2Sum")
    public String test6_getAgentTypeMetric1AndMetric2Sum() {
        try {
            List<HourSum> result = mapper.getAgentTypeMetric1AndMetric2Sum();

            System.out.println("✅ getAgentTypeMetric1AndMetric2Sum 执行成功");
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));

            return "SUCCESS: getAgentTypeMetric1AndMetric2Sum, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test6_getAgentTypeMetric1AndMetric2Sum 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试7：getAgentTypeMetric1Sum
     * URL: /test/mirror/xdrDeviceAgg/test7-getAgentTypeMetric1Sum
     */
    @GetMapping("/test7-getAgentTypeMetric1Sum")
    public String test7_getAgentTypeMetric1Sum() {
        try {
            List<HourSum> result = mapper.getAgentTypeMetric1Sum();

            System.out.println("✅ getAgentTypeMetric1Sum 执行成功");
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));

            return "SUCCESS: getAgentTypeMetric1Sum, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test7_getAgentTypeMetric1Sum 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试8：getAgentDataMetric1
     * URL: /test/mirror/xdrDeviceAgg/test8-getAgentDataMetric1
     */
    @GetMapping("/test8-getAgentDataMetric1")
    public String test8_getAgentDataMetric1() {
        try {
            String agentCode = "XDR_AGG_1";
            XdrTimeEnum type = XdrTimeEnum.hour1; // 对应 XML 中 @XdrTimeEnum@hour1

            List<PointSum> result = mapper.getAgentDataMetric1(agentCode, type);

            System.out.println("✅ getAgentDataMetric1 执行成功");
            System.out.println("  agentCode=" + agentCode + ", type=" + type);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));

            return "SUCCESS: getAgentDataMetric1, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test8_getAgentDataMetric1 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试9：getAgentDataMetric2
     * URL: /test/mirror/xdrDeviceAgg/test9-getAgentDataMetric2
     */
    @GetMapping("/test9-getAgentDataMetric2")
    public String test9_getAgentDataMetric2() {
        try {
            String agentCode = "XDR_AGG_1";
            XdrTimeEnum type = XdrTimeEnum.hour24;

            List<PointSum> result = mapper.getAgentDataMetric2(agentCode, type);

            System.out.println("✅ getAgentDataMetric2 执行成功");
            System.out.println("  agentCode=" + agentCode + ", type=" + type);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));

            return "SUCCESS: getAgentDataMetric2, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test9_getAgentDataMetric2 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试10：getAgentDataMetric3
     * URL: /test/mirror/xdrDeviceAgg/test10-getAgentDataMetric3
     */
    @GetMapping("/test10-getAgentDataMetric3")
    public String test10_getAgentDataMetric3() {
        try {
            String agentCode = "XDR_AGG_1";
            XdrTimeEnum type = XdrTimeEnum.week1;

            List<PointSum> result = mapper.getAgentDataMetric3(agentCode, type);

            System.out.println("✅ getAgentDataMetric3 执行成功");
            System.out.println("  agentCode=" + agentCode + ", type=" + type);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));

            return "SUCCESS: getAgentDataMetric3, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test10_getAgentDataMetric3 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试11：queryAllDeviceCount
     * URL: /test/mirror/xdrDeviceAgg/test11-queryAllDeviceCount
     */
    @GetMapping("/test11-queryAllDeviceCount")
    public String test11_queryAllDeviceCount() {
        try {
            XdrDeviceRequest request = new XdrDeviceRequest();
            request.setTypeName("APT");
            // 可按需设置 status / licenseStatus / deviceName
            // request.setStatus("online");
            // request.setLicenseStatus("NORMAL");

            List<KeyValueCount> result = mapper.queryAllDeviceCount(request);

            System.out.println("✅ queryAllDeviceCount 执行成功");
            System.out.println("  request=" + request);
            System.out.println("  result.size()=" + (result == null ? 0 : result.size()));
            if (result != null) {
                for (int i = 0; i < Math.min(result.size(), 5); i++) {
                    KeyValueCount kv = result.get(i);
                    System.out.println("  [" + i + "] value(status)=" + kv.getValue()
                            + ", count=" + kv.getCount());
                }
            }

            return "SUCCESS: queryAllDeviceCount, size=" + (result == null ? 0 : result.size());
        } catch (Exception e) {
            String msg = "❌ test11_queryAllDeviceCount 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试12：queryTodayStatistics
     * URL: /test/mirror/xdrDeviceAgg/test12-queryTodayStatistics
     */
    @GetMapping("/test12-queryTodayStatistics")
    public String test12_queryTodayStatistics() {
        try {
            String agentType = "APT";

            Long sum = mapper.queryTodayStatistics(agentType);

            System.out.println("✅ queryTodayStatistics 执行成功");
            System.out.println("  agentType=" + agentType + ", sumMetric3Today=" + sum);

            return "SUCCESS: queryTodayStatistics, sum=" + sum;
        } catch (Exception e) {
            String msg = "❌ test12_queryTodayStatistics 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 测试13：queryTodayStatisticsByIp
     * URL: /test/mirror/xdrDeviceAgg/test13-queryTodayStatisticsByIp
     */
    @GetMapping("/test13-queryTodayStatisticsByIp")
    public String test13_queryTodayStatisticsByIp() {
        try {
            String agentType = "APT";
            String ip = "10.0.5.1";

            Long sum = mapper.queryTodayStatisticsByIp(agentType, ip);

            System.out.println("✅ queryTodayStatisticsByIp 执行成功");
            System.out.println("  agentType=" + agentType + ", ip=" + ip + ", sumMetric3Today=" + sum);

            return "SUCCESS: queryTodayStatisticsByIp, sum=" + sum;
        } catch (Exception e) {
            String msg = "❌ test13_queryTodayStatisticsByIp 执行失败: " + e.getMessage();
            System.err.println(msg);
            e.printStackTrace();
            return msg;
        }
    }

    /**
     * 综合测试
     * URL: /test/mirror/xdrDeviceAgg/test-all
     */
    @GetMapping("/test-all")
    public String testAll() {
        StringBuilder sb = new StringBuilder("ALL DONE\n");
        sb.append(test1_getAgentTypeStausCount()).append("\n");
        sb.append(test2_getAgentTypeIps()).append("\n");
        sb.append(test3_getAgentTypeMetric3Sum()).append("\n");
        sb.append(test4_getAgentTypeCpuCount()).append("\n");
        sb.append(test5_getAgentTypeMemCount()).append("\n");
        sb.append(test6_getAgentTypeMetric1AndMetric2Sum()).append("\n");
        sb.append(test7_getAgentTypeMetric1Sum()).append("\n");
        sb.append(test8_getAgentDataMetric1()).append("\n");
        sb.append(test9_getAgentDataMetric2()).append("\n");
        sb.append(test10_getAgentDataMetric3()).append("\n");
        sb.append(test11_queryAllDeviceCount()).append("\n");
        sb.append(test12_queryTodayStatistics()).append("\n");
        sb.append(test13_queryTodayStatisticsByIp()).append("\n");
        return sb.toString();
    }
}

