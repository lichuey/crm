package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.bean.StageVo;

import java.util.List;
import java.util.Map;

public interface TranService {

    //查询所有满足条件的客户名
    List<String> selectCustomerName(String customerName);

    //查询交易的阶段图标
    List<StageVo> queryStages(String id, Map<String, String> stage2Possibility);
}
