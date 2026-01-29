package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.NoticeHistoryMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.NoticeHistory;
import com.dbapp.extension.xdr.linkageHandle.entity.NoticeHistoryParam;
import com.dbapp.extension.xdr.linkageHandle.entity.NoticeHistoryVO;
import com.dbapp.extension.xdr.linkageHandle.entity.BaseHistoryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * NoticeHistory (通知历史) 深度测试控制器
 * 主表：t_notice_history (15个字段)
 * 关联表：t_linked_strategy
 * 测试方法数：6
 * 生成时间：2026-01-28（深度修复）
 */
@RestController
@RequestMapping("/test/noticeHistory")
public class NoticeHistoryTestController {

    @Autowired
    private NoticeHistoryMapper mapper;

    /**
     * 方法1：countLaunchTimesByStrategyId - 统计策略启动次数
     * 测试条件：<foreach collection='strategyIds'> + GROUP BY
     */
    @GetMapping("/test1_countLaunchTimesByStrategyId")
    public String test1_countLaunchTimesByStrategyId() {
        try {
            System.out.println("测试: countLaunchTimesByStrategyId - 统计策略启动次数");
            List<Long> strategyIds = new ArrayList<>();
            strategyIds.add(6001L);  // 从test_data.sql
            strategyIds.add(6002L);
            strategyIds.add(6003L);
            
            List<BaseHistoryVO> result = mapper.countLaunchTimesByStrategyId(strategyIds);
            System.out.println("结果: " + result.size() + " 个策略");
            for (BaseHistoryVO vo : result) {
                System.out.println("  - 策略ID=" + vo.getStrategyId() + ", 启动次数=" + vo.getCount());
            }
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test1_countLaunchTimesByStrategyId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法2：batchInsert - 批量插入
     * 测试条件：<foreach collection="insertList">（插入2条）
     */
    @GetMapping("/test2_batchInsert")
    public String test2_batchInsert() {
        try {
            System.out.println("测试: batchInsert - 批量插入通知历史");
            List<NoticeHistory> notices = new ArrayList<>();
            
            NoticeHistory notice1 = new NoticeHistory();
            notice1.setReceiverId(1010L);
            notice1.setContactType("email");
            notice1.setContactAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            notice1.setStartTimeMin(LocalDateTime.now().minusMinutes(10).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            notice1.setCount(5);
            notice1.setAlertContent("测试告警：检测到异常登录尝试");
            notice1.setDeviceId("dev-test-001");
            notice1.setStatus(true);
            notice1.setEventIdStr("2001,2002,2003");
            notice1.setStrategyId(6001L);
            notices.add(notice1);
            
            NoticeHistory notice2 = new NoticeHistory();
            notice2.setReceiverId(1011L);
            notice2.setContactType("sms");
            notice2.setContactAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            notice2.setStartTimeMin(LocalDateTime.now().minusMinutes(15).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            notice2.setCount(3);
            notice2.setAlertContent("测试告警：检测到SQL注入尝试");
            notice2.setFailureMsg(null);
            notice2.setDeviceId("dev-test-002");
            notice2.setStatus(true);
            notice2.setEventIdStr("2004,2005");
            notice2.setStrategyId(6002L);
            notices.add(notice2);
            
            int rows = mapper.batchInsert(notices);
            System.out.println("结果: " + rows + " 行");
            return "SUCCESS: " + rows;
        } catch (Exception e) {
            String errorMsg = "测试方法 test2_batchInsert 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法3：getNoticeListCount - 统计通知数量（所有if条件）
     * 测试参数：strategyName, receiverIds, contactAtLow, contactAtUp, contactType, alertContent, strategyId
     */
    @GetMapping("/test3_getNoticeListCount_allParams")
    public String test3_getNoticeListCount_allParams() {
        try {
            System.out.println("测试: getNoticeListCount - 统计通知数量（所有参数）");
            NoticeHistoryParam param = new NoticeHistoryParam();
            param.setStrategyName("APT");  // 测试if: strategyName != null
            List<Long> receiverIds = new ArrayList<>();
            receiverIds.add(1001L);  // 测试if: receiverIds.size>0
            receiverIds.add(1002L);
            param.setReceiverIds(receiverIds);
            param.setContactAtLow("2026-01-01 00:00:00");  // 测试if: contactAtLow != null
            param.setContactAtUp("2026-12-31 23:59:59");  // 测试if: contactAtUp != null
            param.setContactType("email");  // 测试if: contactType != null
            param.setAlertContent("攻击");  // 测试if: alertContent != null
            param.setStrategyId(6001L);  // 测试if: strategyId != null
            
            Long count = mapper.getNoticeListCount(param);
            System.out.println("结果: " + count + " 条");
            return "SUCCESS: " + count;
        } catch (Exception e) {
            String errorMsg = "测试方法 test3_getNoticeListCount_allParams 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法4：getNoticeHistory - 查询通知历史（默认排序）
     * 测试条件：<choose><when test="orderByStr == null">（默认排序）
     */
    @GetMapping("/test4_getNoticeHistory_defaultSort")
    public String test4_getNoticeHistory_defaultSort() {
        try {
            System.out.println("测试: getNoticeHistory - 默认排序");
            NoticeHistoryParam param = new NoticeHistoryParam();
            param.setLimit(10);
            param.setOffset(0);
            
            // orderByStr=null，触发when分支（tnh.contact_at desc）
            List<NoticeHistoryVO> result = mapper.getNoticeHistory(null, param);
            System.out.println("结果: " + result.size() + " 条");
            for (int i = 0; i < Math.min(3, result.size()); i++) {
                NoticeHistoryVO vo = result.get(i);
                System.out.println("  - ID=" + vo.getId() + ", 策略=" + vo.getStrategyName() + ", 联系时间=" + vo.getContactAt());
            }
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test4_getNoticeHistory_defaultSort 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法5：getNoticeHistory - 自定义排序（测试所有参数 + choose的otherwise分支）
     * 测试条件：<choose><otherwise>（自定义排序）+ 所有7个if条件
     */
    @GetMapping("/test5_getNoticeHistory_customSort")
    public String test5_getNoticeHistory_customSort() {
        try {
            System.out.println("测试: getNoticeHistory - 自定义排序（所有参数）");
            NoticeHistoryParam param = new NoticeHistoryParam();
            param.setStrategyId(6001L);  // 测试if: strategyId != null
            param.setStrategyName("APT");  // 测试if: strategyName != null
            List<Long> receiverIds = new ArrayList<>();
            receiverIds.add(1001L);  // 测试if: receiverIds.size>0
            param.setReceiverIds(receiverIds);
            param.setContactAtLow("2026-01-01 00:00:00");  // 测试if: contactAtLow != null
            param.setContactAtUp("2026-12-31 23:59:59");  // 测试if: contactAtUp != null
            param.setContactType("email");  // 测试if: contactType != null
            param.setAlertContent("攻击");  // 测试if: alertContent != null
            param.setLimit(5);  // 测试if: limit != null
            param.setOffset(0);  // 测试if: offset >= 0
            
            // 自定义排序，触发otherwise分支
            String orderByStr = "tnh.contact_at desc, tnh.id asc";
            
            List<NoticeHistoryVO> result = mapper.getNoticeHistory(orderByStr, param);
            System.out.println("结果: " + result.size() + " 条（自定义排序）");
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test5_getNoticeHistory_customSort 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }

    /**
     * 方法6：getIdsByStrategyId - 按策略ID获取通知ID列表
     */
    @GetMapping("/test6_getIdsByStrategyId")
    public String test6_getIdsByStrategyId() {
        try {
            System.out.println("测试: getIdsByStrategyId - 按策略ID获取通知ID列表");
            List<Long> result = mapper.getIdsByStrategyId(6001L);
            System.out.println("结果: " + result.size() + " 个ID");
            for (Long id : result) {
                System.out.println("  - 通知ID=" + id);
            }
            return "SUCCESS: " + result.size();
        } catch (Exception e) {
            String errorMsg = "测试方法 test6_getIdsByStrategyId 执行失败";
            System.err.println(errorMsg + ": " + e.getMessage());
            e.printStackTrace();
            return "{\"error\": \"" + errorMsg + "\", \"exception\": \"" + e.getClass().getName() + "\", \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}";
        }
    }
}
