package com.dbapp.extension.xdr.threatMonitor.mapper;

import com.dbapp.extension.xdr.threatMonitor.entity.AttackKnowledge;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

/**
 * AttackKnowledge Mapper接口
 * 映射文件：AttackKnowledgeMapper.xml
 * 
 * 包含9个方法：
 * 1. selectListByParams - 按参数查询列表
 * 2. selectByparentCode - 按父代码查询
 * 3. queryIdBytacticName - 按战术名称查询ID
 * 4. queryNameByCode - 按代码查询名称
 * 5. queryParentId - 查询父ID
 * 6. selectTactic - 查询所有战术
 * 7. updateByCode - 按代码更新
 * 8. truncateTable - 清空表
 * 9. batchInsert - 批量插入
 */
@Mapper
public interface AttackKnowledgeMapper {
    
    /**
     * 按参数查询列表
     * @param os 操作系统
     * @param perspective 视角
     * @param type 设备类型
     */
    List<AttackKnowledge> selectListByParams(@Param("os") String os, @Param("perspective") String perspective, @Param("type") String type);
    
    /**
     * 按父代码查询
     * @param key 父代码（technique_code）
     */
    List<AttackKnowledge> selectByparentCode(@Param("key") String key);
    
    /**
     * 按战术名称查询技术代码
     * @param tacticName 战术名称
     */
    String queryIdBytacticName(@Param("tacticName") String tacticName);
    
    /**
     * 按代码查询名称
     * @param tacticCode 战术代码
     */
    String queryNameByCode(@Param("tacticCode") String tacticCode);
    
    /**
     * 查询父ID
     * @param techniquesId 技术ID
     */
    String queryParentId(@Param("techniquesId") String techniquesId);
    
    /**
     * 查询所有战术（level='tactic'）
     */
    List<String> selectTactic();
    
    /**
     * 按代码更新
     * @param techniqueCode 技术代码
     * @param os 操作系统
     * @param perspective 视角
     * @param deviceType 设备类型
     */
    void updateByCode(@Param("techniqueCode") String techniqueCode, @Param("os") String os, @Param("perspective") String perspective, @Param("deviceType") String deviceType);
    
    /**
     * 清空表（危险操作！）
     */
    void truncateTable();
    
    /**
     * 批量插入
     * @param attackUpdateList 攻击知识列表（注意：参数名必须是attackUpdateList，与XML中collection对应）
     */
    void batchInsert(@Param("attackUpdateList") List<AttackKnowledge> attackUpdateList);
}
