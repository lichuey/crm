package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.settings.bean.User;

import java.util.List;
import java.util.Map;

public interface TranService {

    //查询所有满足条件的客户名
    List<String> selectCustomerName(String customerName);

    //查询交易的阶段图标
    Map<String,Object> queryStages(Integer index, String id, Map<String, String> stage2Possibility, User user);
}
