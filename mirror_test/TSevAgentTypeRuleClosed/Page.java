package com.dbapp.restful.entity;

/**
 * 分页对象（用于 MyBatis XML 中的分页参数）
 * 对应 XML 中的 #{page.size} 和 #{page.offset}
 */
public class Page {
    private long size;
    private long offset;

    public Page() {
    }

    public Page(long size, long offset) {
        this.size = size;
        this.offset = offset;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }

    public long getOffset() {
        return offset;
    }

    public void setOffset(long offset) {
        this.offset = offset;
    }
}
