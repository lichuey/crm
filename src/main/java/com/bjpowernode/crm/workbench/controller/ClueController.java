package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.CommonUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Clue;
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


}
