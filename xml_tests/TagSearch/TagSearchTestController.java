package com.test.controller;

import com.dbapp.extension.xdr.tag.mapper.TagSearchMapper;
import com.dbapp.extension.xdr.tag.entity.TagSearch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/test/tagSearch")
public class TagSearchTestController {
    @Autowired
    private TagSearchMapper mapper;

    @GetMapping("/test-batch-insert")
    public void testBatchInsert() {
        try {
            List<TagSearch> tags = new ArrayList<>();
            TagSearch tag = new TagSearch();
            tag.setTagName("测试标签");
            tag.setTagType("test_type");
            tag.setTagValue("test_value");
            tags.add(tag);
            
            mapper.batchInsert(tags);
            System.out.println("✅ 批量插入成功");
        } catch (Exception e) {
            System.err.println("❌ 插入失败：" + e.getMessage());
            e.printStackTrace();
        }
    }
}
