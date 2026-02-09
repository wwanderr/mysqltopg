package com.dbapp.xdr.bean.meta;

/**
 * PackageType 枚举
 * 对应 t_sev_agent_package.package_type 字段
 * 升级包类型：software（软件包）、rule（规则包）、intelligence（情报包）
 */
public enum PackageType {
    SOFTWARE("software"),
    RULE("rule"),
    INTELLIGENCE("intelligence");

    private final String value;

    PackageType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    /**
     * 根据字符串值获取枚举
     */
    public static PackageType fromValue(String value) {
        for (PackageType type : PackageType.values()) {
            if (type.value.equals(value)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Unknown PackageType: " + value);
    }
}
