package com.test.controller;

import com.dbapp.extension.xdr.linkageHandle.mapper.NoticeHistoryMapper;
import com.dbapp.extension.xdr.linkageHandle.entity.NoticeHistory;
import com.dbapp.extension.xdr.linkageHandle.entity.NoticeHistoryParam;
import com.dbapp.extension.xdr.linkageHandle.entity.NoticeHistoryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * NoticeHistory 测试控制器
 * 
 * 测试说明：
 * 1. 所有方法使用 GET 请求
 * 2. 参数已硬编码，无需 Postman 传参
 * 3. 测试数据参考：test_data.sql 中的场景
 */
@RestController
@RequestMapping("/test/notice-history")
public class NoticeHistoryTestController {

    @Autowired
    private NoticeHistoryMapper mapper;

    /**
     * 测试1：批量插入通知历史
     */
    @GetMapping("/test-batch-insert")
    public String testBatchInsert() {
        try {
            List<NoticeHistory> notices = new ArrayList<>();
            
            // 新增一条Webhook通知
            NoticeHistory notice = new NoticeHistory();
            notice.setNoticeType("alarm");
            notice.setNoticeTitle("【测试】告警通知");
            notice.setNoticeContent("这是一条测试通知");
            notice.setNoticeLevel("high");
            notice.setReceiver("test_webhook");
            notice.setReceiverType("webhook");
            notice.setSendStatus("pending");
            notice.setRetryCount(0);
            notice.setRelateId("test_001");
            notice.setRelateType("test");
            notice.setChannel("dingtalk");
            
            notices.add(notice);
            
            mapper.batchInsert(notices);
            
            System.out.println("✅ 批量插入成功：插入了 " + notices.size() + " 条通知记录");
            
            return "批量插入成功，共 " + notices.size() + " 条";
        } catch (Exception e) {
            System.err.println("❌ 批量插入失败：" + e.getMessage());
            e.printStackTrace();
            return "批量插入失败：" + e.getMessage();
        }
    }

    /**
     * 测试2：查询通知历史列表
     */
    @GetMapping("/test-query-list")
    public String testGetNoticeHistory() {
        try {
            NoticeHistoryParam param = new NoticeHistoryParam();
            param.setNoticeType("alarm");  // 查询告警类通知
            param.setSendStatus("success,failed");  // 查询成功和失败的
            param.setPageNum(1);
            param.setPageSize(10);
            
            List<NoticeHistoryVO> result = mapper.getNoticeHistory(param);
            
            System.out.println("✅ 查询成功，共 " + result.size() + " 条通知：");
            for (NoticeHistoryVO vo : result) {
                System.out.println("  - ID=" + vo.getId() 
                    + ", 标题=" + vo.getNoticeTitle()
                    + ", 级别=" + vo.getNoticeLevel()
                    + ", 渠道=" + vo.getChannel()
                    + ", 状态=" + vo.getSendStatus()
                    + ", 重试=" + vo.getRetryCount() + "次");
            }
            
            return "查询成功，共 " + result.size() + " 条通知";
        } catch (Exception e) {
            System.err.println("❌ 查询失败：" + e.getMessage());
            e.printStackTrace();
            return "查询失败：" + e.getMessage();
        }
    }

    /**
     * 测试3：统计通知数量
     */
    @GetMapping("/test-count")
    public String testGetNoticeListCount() {
        try {
            NoticeHistoryParam param = new NoticeHistoryParam();
            param.setNoticeType("alarm");  // 统计告警通知
            
            Long count = mapper.getNoticeListCount(param);
            
            System.out.println("✅ 统计成功：告警通知共 " + count + " 条");
            
            return "统计成功：共 " + count + " 条";
        } catch (Exception e) {
            System.err.println("❌ 统计失败：" + e.getMessage());
            e.printStackTrace();
            return "统计失败：" + e.getMessage();
        }
    }
}
