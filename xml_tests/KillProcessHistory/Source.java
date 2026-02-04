package com.dbapp.extension.xdr.utils;

/**
 * Source（最小实现）
 * 仅用于 KillProcessHistoryMapper#delete 中的 Source::getNameByDesc 映射。
 *
 * 约定：如果没有命中映射，则原样返回。
 */
public class Source {
    public static String getNameByDesc(String desc) {
        if (desc == null) {
            return null;
        }
        // 常见取值（可按需补充）
        if ("手动".equalsIgnoreCase(desc) || "manual".equalsIgnoreCase(desc)) {
            return "manual";
        }
        if ("自动".equalsIgnoreCase(desc) || "auto".equalsIgnoreCase(desc)) {
            return "auto";
        }
        if ("模板".equalsIgnoreCase(desc) || "template".equalsIgnoreCase(desc)) {
            return "template";
        }
        return desc;
    }
}
