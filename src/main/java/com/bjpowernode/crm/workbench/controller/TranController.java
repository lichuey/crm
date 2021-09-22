package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.workbench.bean.StageVo;
import com.bjpowernode.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@RestController
public class TranController{

    @Autowired
    private TranService tranService;

    //查询所有满足条件的客户名
    @RequestMapping("/workbench/transaction/queryCustomerName")
    public List<String> queryCustomerName(String customerName) {
        return tranService.selectCustomerName(customerName);
    }

    //获取stage2Possibility中的possibility
    @RequestMapping("/workbench/transaction/getStage2Possibility")
    public String getStage2Possibility(String stage, HttpSession session) {
        Map<String,String> stage2Possibility =
                (Map<String, String>) session.getServletContext().getAttribute("stage2Possibility");
        return stage2Possibility.get(stage);
    }

    //查询交易的阶段图标
    @RequestMapping("/workbench/transaction/queryStages")
    public List<StageVo> queryStages(String id, HttpSession session) {
        Map<String,String> stage2Possibility =
                (Map<String, String>) session.getServletContext().getAttribute("stage2Possibility");
        return tranService.queryStages(id, stage2Possibility);
    }
}
