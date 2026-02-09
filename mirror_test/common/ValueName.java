package com.dbapp.entity;

/**
 * 通用下拉列表实体：
 * - value: 一般用于 ID / 编码
 * - name: 一般用于展示名称
 *
 * 供 Mirror 测试套件使用（如 TSevAgentInfoMapper.selectAgentCodeAndAgentNameByAgentType）
 */
public class ValueName {

    private String value;
    private String name;

    public ValueName() {
    }

    public ValueName(String value, String name) {
        this.value = value;
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

