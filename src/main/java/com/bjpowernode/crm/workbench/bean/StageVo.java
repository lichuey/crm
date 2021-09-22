package com.bjpowernode.crm.workbench.bean;

import lombok.Data;

/**
 * 表示阶段图标
 */
@Data
public class StageVo {

    private String type;//图标的种类
    private String stage;//图标阶段
    private String possibility;//图标可能性
}
