package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.CommonUtil;
import com.bjpowernode.crm.base.util.UUIDUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.ActivityRemark;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 市场活动控制器
 * RestController:自动的给Controller中的每个方法返回值定为返回json
 */
@RestController
public class ActivityController{

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

    //使用BootStrap分页插件实现,查询
    @RequestMapping("/workbench/activity/list")
    public PageInfo list(int page, int pageSize, Activity activity) {

        //查询所有的市场活动
        List<Activity> activities = activityService.list(page, pageSize, activity);
        PageInfo<Activity> pageInfo = new PageInfo<>(activities);

        return pageInfo;
    }

    //查询所有用户
    @RequestMapping("/workbench/activity/queryUsers")
    public List<User> queryUsers() {
        return activityService.selectUsers();
    }

    //保存或更新活动
    @RequestMapping("/workbench/activity/saveOrUpdate")
    public ResultVo saveOrUpdate(Activity activity, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        try {
            User user = CommonUtil.getCurrentUser(session);
            resultVo = activityService.saveOrUpdate(activity, user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //通过id查询活动
    @RequestMapping("/workbench/activity/queryById")
    public Activity queryById(String id) {
        return activityService.queryById(id);
    }

    //批量删除
    @RequestMapping("/workbench/activity/deleteBatch")
    public ResultVo deleteBatch(String ids) {
        ResultVo resultVo = new ResultVo();
        try {
            activityService.deleteBatch(ids);
            resultVo.setResOK(true);
            resultVo.setMessage("批量删除成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询市场活动详情页的数据
    @RequestMapping("/workbench/activity/selectDetail")
    public Activity selectDetail(String id) {
        return activityService.selectDetail(id);
    }

    //保存市场活动备注
    @RequestMapping("/workbench/activity/saveActivityRemark")
    public ResultVo saveActivityRemark(ActivityRemark activityRemark, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        try {
            User user = CommonUtil.getCurrentUser(session);
            activityService.saveActivityRemark(activityRemark, user);
            resultVo.setResOK(true);
            resultVo.setMessage("活动备注保存成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }
}