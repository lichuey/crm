package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;

import java.util.List;

public interface ActivityService {

    //查询所有的市场活动
    List<Activity> list(int page, int pageSize, Activity activity);

    //查询总记录数
    int count();

    //查询所有用户
    List<User> selectUsers();

    //保存活动
    void saveActivity(Activity activity, User user);
}