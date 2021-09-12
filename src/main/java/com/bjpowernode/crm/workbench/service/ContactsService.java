package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Contacts;

import java.util.List;

public interface ContactsService {

    List<Contacts> list(int page, int pageSize, Contacts contacts);

    List<User> queryUsers();

    ResultVo saveOrUpdate(Contacts contacts, User user);

    Contacts queryById(String id);

    void deleteBatch(String ids);

}
