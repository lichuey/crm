package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.PieVo;
import com.bjpowernode.crm.workbench.bean.Tran;

import java.util.List;

public interface ChartMapper {

    List<Tran> barEcharts();

    List<PieVo> pieEcharts();
}
