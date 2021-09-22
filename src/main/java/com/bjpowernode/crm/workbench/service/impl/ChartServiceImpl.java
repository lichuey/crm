package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.workbench.bean.BarVo;
import com.bjpowernode.crm.workbench.bean.PieVo;
import com.bjpowernode.crm.workbench.bean.Tran;
import com.bjpowernode.crm.workbench.mapper.ChartMapper;
import com.bjpowernode.crm.workbench.mapper.TranMapper;
import com.bjpowernode.crm.workbench.service.ChartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ChartServiceImpl implements ChartService {

    @Autowired
    private ChartMapper chartMapper;

    //柱状图数据
    @Override
    public BarVo queryBarVo() {
        BarVo barVo = new BarVo();

        List<Tran> trans = chartMapper.barEcharts();

        List<String> acrossList = new ArrayList<>();
        ArrayList<Integer> verticalList = new ArrayList<>();
        for (Tran tran : trans) {
            acrossList.add(tran.getStage());
            verticalList.add(Integer.parseInt(tran.getPossibility()));
            System.out.println(tran.getPossibility());
        }

        barVo.setAcross(acrossList);
        barVo.setVertical(verticalList);

        return barVo;
    }

    //饼状图
    @Override
    public List<PieVo> queryPieVo() {
        return chartMapper.pieEcharts();
    }
}
