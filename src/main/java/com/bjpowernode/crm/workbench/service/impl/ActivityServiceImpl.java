package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.DateTimeUtil;
import com.bjpowernode.crm.base.util.UUIDUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
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
    public List<Activity> list(int page, int pageSize, Activity activity) {

        Example example = new Example(Activity.class);
        Example.Criteria criteria = example.createCriteria();

        //通过名称模糊查询
        if (StrUtil.isNotEmpty(activity.getName())) {
            criteria.andLike("name", "%" + activity.getName() + "%");
        }

        //开始日期查询
        if (StrUtil.isNotEmpty(activity.getStartDate())) {
            criteria.andGreaterThanOrEqualTo("startDate", activity.getStartDate());
        }

        //结束日期查询
        if (StrUtil.isNotEmpty(activity.getEndDate())) {
            criteria.andLessThanOrEqualTo("endDate", activity.getEndDate());
        }

        //通过所有者查询
        if (StrUtil.isNotEmpty(activity.getOwner())) {
            //通过所有者名称查询所有者
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name", "%" + activity.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);

            //将所有者的id存在数组中
            List<String> ids = new ArrayList<>();
            for (User user : users) {
                ids.add(user.getId());
            }

            //通过id查询所有满足该id的activity
            criteria.andIn("owner", ids);
        }

        //分页
        PageHelper.startPage(page, pageSize);
        //查询所有的市场活动
        List<Activity> activities = activityMapper.selectByExample(example);

        //遍历市场活动
        for (Activity activity1 : activities) {
            String owner = activity1.getOwner();
            //通过主键查询用户
            User user = userMapper.selectByPrimaryKey(owner);
            activity1.setOwner(user.getName());
        }
        return activities;
    }

    //查询总记录数
    @Override
    public int count() {
        return activityMapper.selectAll().size();
    }

    //查询所有用户
    @Override
    public List<User> selectUsers() {
        return userMapper.selectAll();
    }

    //保存活动
    @Override
    public void saveActivity(Activity activity, User user) {
        activity.setId(UUIDUtil.uuid());
        activity.setCreateTime(DateTimeUtil.getSysTime());
        activity.setCreateBy(user.getName());
        int count = activityMapper.insertSelective(activity);
        if (count == 0) {
            throw new CrmException(CrmEnum.ACTIVITY_SAVE_FALSE);
        }
    }
}