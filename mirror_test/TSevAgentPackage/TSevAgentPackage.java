package com.dbapp.xdr.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.time.LocalDateTime;

/**
 * TSevAgentPackage 实体（最小可用版本）
 * 对应表：t_sev_agent_package
 * 
 * 注意：此表有外键约束
 * - agent_type 引用 t_sev_agent_type(agent_type) ON DELETE CASCADE ON UPDATE CASCADE
 * - file_uuid 引用 t_bs_files(uuid) ON DELETE RESTRICT ON UPDATE RESTRICT（测试数据可暂时忽略）
 */
@TableName("t_sev_agent_package")
public class TSevAgentPackage {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String agentType;
    private String packageType;
    private String packageVersion;
    private String dependSoftware;
    private String fileUuid;
    private String fileName;
    private String uploadType;
    private Long fileSize;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAgentType() {
        return agentType;
    }

    public void setAgentType(String agentType) {
        this.agentType = agentType;
    }

    public String getPackageType() {
        return packageType;
    }

    public void setPackageType(String packageType) {
        this.packageType = packageType;
    }

    public String getPackageVersion() {
        return packageVersion;
    }

    public void setPackageVersion(String packageVersion) {
        this.packageVersion = packageVersion;
    }

    public String getDependSoftware() {
        return dependSoftware;
    }

    public void setDependSoftware(String dependSoftware) {
        this.dependSoftware = dependSoftware;
    }

    public String getFileUuid() {
        return fileUuid;
    }

    public void setFileUuid(String fileUuid) {
        this.fileUuid = fileUuid;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getUploadType() {
        return uploadType;
    }

    public void setUploadType(String uploadType) {
        this.uploadType = uploadType;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }

    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }
}
