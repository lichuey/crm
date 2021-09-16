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
import com.bjpowernode.crm.workbench.bean.Clue;
import com.bjpowernode.crm.workbench.bean.ClueActivityRelation;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import com.bjpowernode.crm.workbench.mapper.ClueActivityRelationMapper;
import com.bjpowernode.crm.workbench.mapper.ClueMapper;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ClueServiceImpl implements ClueService {

    @Autowired
    private ClueMapper clueMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ClueActivityRelationMapper clueActivityRelationMapper;

    @Autowired
    private ActivityMapper activityMapper;

    //查询线索
    @Override
    public List<Clue> list(int page, int pageSize, Clue clue) {
        Example example = new Example(Clue.class);
        Example.Criteria criteria = example.createCriteria();

        if (StrUtil.isNotEmpty(clue.getFullname())) {
            criteria.andLike("fullname", "%" + clue.getFullname() + "%");
        }

        if (StrUtil.isNotEmpty(clue.getCompany())) {
            criteria.andLike("company", "%" + clue.getCompany() + "%");
        }

        if (StrUtil.isNotEmpty(clue.getPhone())) {
            criteria.andLike("phone", "%" + clue.getPhone() + "%");
        }

        if (StrUtil.isNotEmpty(clue.getSource())) {
            criteria.andEqualTo("source", clue.getSource());
        }

        if (StrUtil.isNotEmpty(clue.getOwner())) {
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name", "%" + clue.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);

            //2、把查询出来的用户的主键放入到集合中
            List<String> ids = new ArrayList<>();
            for(User user : users){
                ids.add(user.getId());
            }

            //3、查询用户的id在联系人表中的满足的owner
            criteria.andIn("owner", ids);
        }

        if (StrUtil.isNotEmpty(clue.getMphone())) {
            criteria.andLike("mphone", clue.getMphone());
        }

        if (StrUtil.isNotEmpty(clue.getState())) {
            criteria.andEqualTo("state", clue.getState());
        }

        //参数1:当前页码 参数2:每页记录数 改行代码等同于limit a,b
        PageHelper.startPage(page, pageSize);

        List<Clue> clueList = clueMapper.selectByExample(example);

        for (Clue clue1 : clueList) {
            User user = userMapper.selectByPrimaryKey(clue1.getOwner());
            clue1.setOwner(user.getName());
        }

        return clueList;
    }

    //保存或更新线索
    @Override
    public ResultVo saveOrUpdate(Clue clue, User user) {
        ResultVo resultVo = new ResultVo();
        //保存活动
        if (clue.getId() == null) {
            clue.setId(UUIDUtil.uuid());
            clue.setCreateTime(DateTimeUtil.getSysTime());
            clue.setCreateBy(user.getName());
            int count = clueMapper.insertSelective(clue);
            if (count == 0) {
                throw new CrmException(CrmEnum.CLUE_SAVE_FALSE);
            }
            resultVo.setMessage("添加线索成功");
        } else {
            clue.setEditTime(DateTimeUtil.getSysTime());
            clue.setEditBy(user.getName());
            int count = clueMapper.updateByPrimaryKeySelective(clue);
            if (count == 0) {
                throw new CrmException(CrmEnum.CLUE_UPDATE_FALSE);
            }
            resultVo.setMessage("更新线索成功");
        }
        resultVo.setResOK(true);
        return resultVo;
    }

    //通过id查询线索
    @Override
    public Clue queryById(String id) {
        return clueMapper.selectByPrimaryKey(id);
    }

    //批量删除线索
    //批量删除
    @Override
    public void deleteBatch(String ids) {
        //分割ids json串
        String[] arr = ids.split(",");
        //将arr数组转化给集合
        List<String> id = Arrays.asList(arr);
        Example example = new Example(Clue.class);
        example.createCriteria().andIn("id", id);
        int count = clueMapper.deleteByExample(example);
        if (count == 0) {
            throw new CrmException(CrmEnum.CLUE_DELETE_FALSE);
        }
    }

    //查询线索
    @Override
    public Clue queryClue(String id) {
        //根据主键查询线索
        Clue clue = clueMapper.selectByPrimaryKey(id);

        //查询所有满足clueId为id的ClueActivityRelation
        Example example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("clueId", id);
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.selectByExample(example);

        //通过clueActivityRelations中的activityId查找所有市场活动
        List<Activity> activityList = new ArrayList<>();
        for (ClueActivityRelation clueActivityRelation : clueActivityRelations) {
            Activity activity = activityMapper.selectByPrimaryKey(clueActivityRelation.getActivityId());

            //处理活动中的owner
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());

            activityList.add(activity);
        }

        clue.setActivityList(activityList);

        return clue;
    }

    //查询其他市场活动
    @Override
    public List<Activity> selectOtherActivity(String name, String id) {
        //通过线索id查询市场活动id
        Example example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("clueId", id);
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.selectByExample(example);

        //将市场活动id存入数组中
        List<String> list = new ArrayList<>();
        for (ClueActivityRelation clueActivityRelation : clueActivityRelations) {
            list.add(clueActivityRelation.getActivityId());
        }

        //根据条件查询市场活动
        Example example1 = new Example(Activity.class);
        Example.Criteria criteria = example1.createCriteria();
        if (StrUtil.isNotEmpty(name)) {
            criteria.andLike("name", "%" + name + "%");
        }

        criteria.andNotIn("id", list);

        List<Activity> activityList = activityMapper.selectByExample(example1);

        for (Activity activity : activityList) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
        }

        return activityList;
    }
}
