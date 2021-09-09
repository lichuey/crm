package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.workbench.service.ActivityService;
import com.bjpowernode.crm.workbench.bean.Activity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 市场活动控制器
 * RestController:自动的给Controller中的每个方法返回值定为返回json
 */
@RestController
public class ActivityController{

    @Autowired
    private ActivityService activityService;

    //返回所有的市场活动数据
    @RequestMapping("/workbench/activity/list")
    public List<Activity> list() {
        //查询所有的市场活动
        return activityService.selectAllActivity();
    }
}
