package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.bean.BarVo;
import com.bjpowernode.crm.workbench.bean.PieVo;

import java.util.List;

public interface ChartService{

    //柱状图数据
    BarVo queryBarVo();

    //饼状图数据
    List<PieVo> queryPieVo();
}
