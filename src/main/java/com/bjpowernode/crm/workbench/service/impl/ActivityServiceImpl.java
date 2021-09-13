package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.DateTimeUtil;
import com.bjpowernode.crm.base.util.UUIDUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.ActivityRemark;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import com.bjpowernode.crm.workbench.mapper.ActivityRemarkMapper;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ActivityRemarkMapper activityRemarkMapper;

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
        //添加按创建时间降序排序
        example.setOrderByClause("createTime desc");

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

    //保存或更新活动
    @Override
    public ResultVo saveOrUpdate(Activity activity, User user) {
        ResultVo resultVo = new ResultVo();
        //保存活动
        if (activity.getId() == null) {
            activity.setId(UUIDUtil.uuid());
            activity.setCreateTime(DateTimeUtil.getSysTime());
            activity.setCreateBy(user.getName());
            int count = activityMapper.insertSelective(activity);
            if (count == 0) {
                throw new CrmException(CrmEnum.ACTIVITY_SAVE_FALSE);
            }
            resultVo.setMessage("添加市场活动成功");
        } else {
            activity.setEditTime(DateTimeUtil.getSysTime());
            activity.setEditBy(user.getName());
            int count = activityMapper.updateByPrimaryKeySelective(activity);
            if (count == 0) {
                throw new CrmException(CrmEnum.ACTIVITY_UPDATE_FALSE);
            }
            resultVo.setMessage("更新市场活动成功");
        }
        resultVo.setResOK(true);
        return resultVo;
    }

    //通过id查询活动
    @Override
    public Activity queryById(String id) {
        return activityMapper.selectByPrimaryKey(id);
    }

    //批量删除
    @Override
    public void deleteBatch(String ids) {
        //分割ids json串
        String[] arr = ids.split(",");
        //将arr数组转化给集合
        List<String> id = Arrays.asList(arr);
        Example example = new Example(Activity.class);
        example.createCriteria().andIn("id", id);
        int count = activityMapper.deleteByExample(example);
        if (count == 0) {
            throw new CrmException(CrmEnum.ACTIVITY_DELETE_FALSE);
        }
    }

    //查询市场活动详情页的数据

    @Override
    public Activity selectDetail(String id) {
        //通过id查询活动
        Activity activity = activityMapper.selectByPrimaryKey(id);

        //设置活动的owner
        User user = userMapper.selectByPrimaryKey(activity.getOwner());
        activity.setOwner(user.getName());

        //设置活动的activityRemarkList
       /* Example example = new Example(ActivityRemark.class);
        example.createCriteria().andEqualTo("activityId", id);
        List<ActivityRemark> activityRemarks = activityRemarkMapper.selectByExample(example);*/
        ActivityRemark activityRemark = new ActivityRemark();
        activityRemark.setActivityId(id);
        List<ActivityRemark> activityRemarks = activityRemarkMapper.select(activityRemark);

        activity.setActivityRemarkList(activityRemarks);

        return activity;
    }

    //保存市场活动备注
    @Override
    public void saveActivityRemark(ActivityRemark activityRemark, User user) {
        activityRemark.setId(UUIDUtil.uuid());
        activityRemark.setCreateBy(user.getName());
        activityRemark.setCreateTime(DateTimeUtil.getSysTime());
        activityRemark.setImg(user.getImg());
        int count = activityRemarkMapper.insertSelective(activityRemark);
        if (count == 0) {
            throw new CrmException(CrmEnum.ACTIVITY_REMARK_SAVE_FALSE);
        }
    }

    //更新市场活动备注
    @Override
    public void updateActivityRemark(ActivityRemark activityRemark, User user) {
        activityRemark.setEditBy(user.getName());
        activityRemark.setEditTime(DateTimeUtil.getSysTime());
        activityRemark.setImg(user.getImg());
        int count = activityRemarkMapper.updateByPrimaryKeySelective(activityRemark);
        if (count == 0) {
            throw new CrmException(CrmEnum.ACTIVITY_REMARK_UPDATE_FALSE);
        }
    }

    //删除市场活动备注
    @Override
    public void deleteActivityRemark(String id) {
        int count = activityRemarkMapper.deleteByPrimaryKey(id);
        if (count == 0) {
            throw new CrmException(CrmEnum.ACTIVITY_REMARK_DELETE_FALSE);
        }
    }
}