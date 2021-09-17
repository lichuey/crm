package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.CommonUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Clue;
import com.bjpowernode.crm.workbench.bean.ClueActivityRelation;
import com.bjpowernode.crm.workbench.bean.Tran;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
public class ClueController {

    @Autowired
    private ClueService clueService;

    //使用BootStrap分页插件实现,查询
    @RequestMapping("/workbench/clue/list")
    public PageInfo list(int page, int pageSize, Clue clue) {

        //查询所有的市场活动
        List<Clue> Clues = clueService.list(page, pageSize, clue);

        PageInfo<Clue> cluePageInfo = new PageInfo<>(Clues);

        return cluePageInfo;
    }

    //保存或更新线索
    @RequestMapping("/workbench/clue/saveOrUpdate")
    public ResultVo saveOrUpdate(Clue clue, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        try {
            User user = CommonUtil.getCurrentUser(session);
            resultVo = clueService.saveOrUpdate(clue, user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //通过id查询线索
    @RequestMapping("/workbench/clue/queryById")
    public Clue queryById(String id) {
        return clueService.queryById(id);
    }

    //批量删除线索
    @RequestMapping("/workbench/clue/deleteBatch")
    public ResultVo deleteBatch(String ids) {
        ResultVo resultVo = new ResultVo();
        try {
            clueService.deleteBatch(ids);
            resultVo.setResOK(true);
            resultVo.setMessage("批量删除成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询线索
    @RequestMapping("/workbench/clue/queryClue")
    public Clue queryClue(String id) {
        return clueService.queryClue(id);
    }

    //查询其他市场活动
    @RequestMapping("/workbench/clue/selectOtherActivity")
    public List<Activity> selectOtherActivity(String name, String id) {
        return clueService.selectOtherActivity(name, id);
    }

    //关联市场活动
    @RequestMapping("/workbench/clue/bind")
    public ResultVo bind(String id, String ids) {
        ResultVo resultVo = new ResultVo();
        try {
            clueService.bind(id, ids);
            resultVo.setResOK(true);
            resultVo.setMessage("关联市场活动成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //取消关联市场活动
    @RequestMapping("/workbench/clue/unbind")
    public ResultVo unbind(ClueActivityRelation clueActivityRelation) {
        ResultVo resultVo = new ResultVo();
        try {
            clueService.unbind(clueActivityRelation);
            resultVo.setResOK(true);
            resultVo.setMessage("取消关联市场活动成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //通过id查询clue
    @RequestMapping("/workbench/clue/selectClueById")
    public Clue selectClueById(String id) {
        return clueService.selectClueById(id);
    }

    //线索转换
    @RequestMapping("/workbench/clue/convert")
    public ResultVo convert(String id, HttpSession session, String isCreateTransaction, Tran tran) {
        ResultVo resultVo = new ResultVo();
        User user = CommonUtil.getCurrentUser(session);
        try {
            clueService.convert(id, user, isCreateTransaction, tran);
            resultVo.setResOK(true);
            resultVo.setMessage("线索转换成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询绑定的市场活动
    @RequestMapping("/workbench/clue/selectBindActivity")
    public List<Activity> selectBindActivity(String id, String name) {
        return clueService.selectBindActivity(id, name);
    }

}
