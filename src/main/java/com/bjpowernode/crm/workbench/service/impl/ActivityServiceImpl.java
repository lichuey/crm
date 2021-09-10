package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private UserMapper userMapper;

    /*
    //传统方式
    //查询所有的市场活动
    @Override
    public List<Activity> selectAllActivity(int page, int pageSize) {
        //查询所有的市场活动
        List<Activity> activities = activityMapper.list(page, pageSize);

        //遍历市场活动
        for (Activity activity : activities) {
            String owner = activity.getOwner();
            //通过主键查询用户
            User user = userMapper.selectByPrimaryKey(owner);
            activity.setOwner(user.getName());
        }
        return activities;
    }
    */

    //PageHelper
    @Override
    public List<Activity> list() {
        //查询所有的市场活动
        List<Activity> activities = activityMapper.selectAll();

        //遍历市场活动
        for (Activity activity : activities) {
            String owner = activity.getOwner();
            //通过主键查询用户
            User user = userMapper.selectByPrimaryKey(owner);
            activity.setOwner(user.getName());
        }
        return activities;
    }

    //查询总记录数
    @Override
    public int count() {
        return activityMapper.selectAll().size();
    }
}