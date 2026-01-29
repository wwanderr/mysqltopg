package com.dbapp.extension.xdr.threatAnalysis.mapper;

import com.dbapp.extension.xdr.threatAnalysis.entity.LoginBaseline;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * LoginBaseline Mapper接口
 * 映射文件：LoginBaselineMapper.xml
 */
@Mapper
public interface LoginBaselineMapper {
    
    /**
     * 清理超时数据
     * @param overtimeHour 超时小时数
     */
    int cleanOvertimeData(@Param("overtimeHour") Integer overtimeHour);
    
    /**
     * 插入或更新（根据XML是delete标签，实际是TRUNCATE+INSERT）
     * @param list 登录基线列表
     */
    int insertOrUpdate(@Param("list") List<LoginBaseline> list);
    
    /**
     * 根据主键查询
     * @param assetIp 资产IP
     * @param userName 用户名
     * @param serviceType 服务类型
     */
    LoginBaseline queryByPrimaryKey(@Param("assetIp") String assetIp, @Param("userName") String userName, @Param("serviceType") String serviceType);
}
