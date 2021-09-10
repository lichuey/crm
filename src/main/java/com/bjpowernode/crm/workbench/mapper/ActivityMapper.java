package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.Activity;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ActivityMapper extends Mapper<Activity> {

    List<Activity> list();

}