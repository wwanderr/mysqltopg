package com.dbapp.xdr.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dbapp.xdr.bean.meta.PackageType;
import com.dbapp.xdr.bean.po.TSevAgentPackage;
import org.apache.commons.lang3.tuple.MutablePair;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * TSevAgentPackageMapper 接口
 * 对应 XML: mysql/mirror_pg_xml/TSevAgentPackageMapper.xml
 */
@Mapper
public interface TSevAgentPackageMapper extends BaseMapper<TSevAgentPackage> {

    /**
     * 获取指定 agent_type 的所有 package_type 的最新版本
     * @param agentType agent 类型
     * @return List<MutablePair<PackageType, String>> 其中 left 是 package_type，right 是 package_version
     */
    List<MutablePair<PackageType, String>> getAllLastVersionByAgentType(@Param("agentType") String agentType);

    /**
     * 选择不是最后两个的包（用于清理旧包）
     * @param agentType agent 类型
     * @param packageType 包类型
     * @return List<MutablePair<Long, String>> 其中 left 是 id，right 是 file_uuid
     */
    List<MutablePair<Long, String>> selectNotLastTwoPackage(
            @Param("agentType") String agentType,
            @Param("packageType") PackageType packageType
    );
}
