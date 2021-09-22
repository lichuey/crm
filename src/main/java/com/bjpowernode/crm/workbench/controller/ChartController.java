package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.workbench.bean.BarVo;
import com.bjpowernode.crm.workbench.bean.PieVo;
import com.bjpowernode.crm.workbench.service.ChartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ChartController {

    @Autowired
    private ChartService chartService;

    //柱状图
    @RequestMapping("/workbench/chart/transaction/queryBarVo")
    public BarVo queryBarVo() {
        return chartService.queryBarVo();
    }

    //饼状图
    @RequestMapping("/workbench/chart/transaction/queryPieVo")
    public List<PieVo> queryPieVo() {
        return chartService.queryPieVo();
    }
}
