package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 市场活动控制器
 * RestController:自动的给Controller中的每个方法返回值定为返回json
 */
@RestController
public class ActivityController{

    //每页记录数
    private int pageSize = 3;

    @Autowired
    private ActivityService activityService;

     /*
    //传统分页
    //返回所有的市场活动数据
    @RequestMapping("/workbench/activity/list")
    public ResultVo list(@RequestParam(defaultValue = "1") int page) {
        ResultVo resultVo = new ResultVo();
        //查询所有的市场活动
        List<Activity> activities = activityService.selectAllActivity(page, pageSize);
        //查询总记录数
        int count = activityService.count();
        //查询总页数
        int pages = (count % pageSize == 0) ? (count / pageSize) : (count / pageSize) + 1;

        resultVo.setList(activities);
        resultVo.setT(pages);

        return resultVo;
    }
    */
      /*
     //使用PageHelper
     @RequestMapping("/workbench/activity/list")
     public ResultVo list(@RequestParam(defaultValue = "1") int page) {
         ResultVo resultVo = new ResultVo();
         PageHelper.startPage(page, pageSize);
         //查询所有的市场活动
         List<Activity> activities = activityService.list();
         PageInfo<Activity> pageInfo = new PageInfo<>(activities);
         //查询总记录数
         long count = pageInfo.getTotal();
         //查询总页数
         long pages = pageInfo.getPages();

         resultVo.setList(activities);
         resultVo.setT(pages);

         return resultVo;
     }
     */

    //使用BootStrap分页插件实现
    @RequestMapping("/workbench/activity/list")
    public PageInfo list(@RequestParam(defaultValue = "1") int page) {
        PageHelper.startPage(page, pageSize);
        //查询所有的市场活动
        List<Activity> activities = activityService.list();
        PageInfo<Activity> pageInfo = new PageInfo<>(activities);

        return pageInfo;
    }
}