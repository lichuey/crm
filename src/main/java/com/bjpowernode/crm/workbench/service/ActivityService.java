package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.ActivityRemark;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface ActivityService {

    //查询所有的市场活动
    List<Activity> list(int page, int pageSize, Activity activity);
/*
    //查询总记录数
    int count();

    //查询所有用户
    List<User> selectUsers();*/

    //保存或更新活动
    ResultVo saveOrUpdate(Activity activity, User user);

    //通过id查询活动
    Activity queryById(String id);

    //批量删除
    void deleteBatch(String ids);

    //查询市场活动详情页的数据
    Activity selectDetail(String id);

    //保存市场活动备注
    void saveActivityRemark(ActivityRemark activityRemark, User user);

    //更新市场活动备注
    void updateActivityRemark(ActivityRemark activityRemark, User user);

    //删除市场活动备注
    void deleteActivityRemark(String id);

    //异步通过id查询活动
    Activity selectActivityById(String id);

    //异步更新市场活动
    void updateActivityModal(Activity activity, User user);

    //异步删除市场活动
    void deleteActivityDetail(String id);
}