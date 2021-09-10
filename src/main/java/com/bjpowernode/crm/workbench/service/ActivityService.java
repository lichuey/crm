package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.bean.Activity;

import java.util.List;

public interface ActivityService {

    //查询所有的市场活动
    List<Activity> list();

    //查询总记录数
    int count();
}