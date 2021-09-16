package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.bean.Clue;

import java.util.List;

public interface ClueService {

    //查询线索
    List<Clue> list(int page, int pageSize, Clue clue);
}
