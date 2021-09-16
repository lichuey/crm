package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Clue;
import com.bjpowernode.crm.workbench.bean.ClueActivityRelation;

import java.util.List;

public interface ClueService {

    //查询线索
    List<Clue> list(int page, int pageSize, Clue clue);

    //保存或更新线索
    ResultVo saveOrUpdate(Clue clue, User user);

    //通过id查询线索
    Clue queryById(String id);

    //批量删除线索
    void deleteBatch(String ids);

    //查询线索
    Clue queryClue(String id);

    //查询其他市场活动
    List<Activity> selectOtherActivity(String name, String id);

    //关联市场活动
    void bind(String id, String ids);

    //取消关联市场活动
    void unbind(ClueActivityRelation clueActivityRelation);
}
