package com.dbapp.extension.xdr.linkageHandle.entity;

/**
 * BaseHistoryVO（最小实现）
 * 对应 SQL: SELECT strategy_id, SUM(1) AS "count" FROM t_virus_kill_history GROUP BY strategy_id
 */
public class BaseHistoryVO {
    private Long strategyId;
    private Long count;

    public Long getStrategyId() {
        return strategyId;
    }

    public void setStrategyId(Long strategyId) {
        this.strategyId = strategyId;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }
}

