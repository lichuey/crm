package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Clue;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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


}
