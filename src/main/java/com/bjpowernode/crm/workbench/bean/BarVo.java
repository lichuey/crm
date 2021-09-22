package com.bjpowernode.crm.workbench.bean;

import lombok.Data;

import java.util.List;

@Data
public class BarVo {

    private List<String> across;//横坐标数据
    private List<Integer> vertical;//纵坐标数据
}
