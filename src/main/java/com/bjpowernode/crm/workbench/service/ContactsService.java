package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.bean.ContactsRemark;

import java.util.List;

public interface ContactsService {

    //条件模糊查询
    List<Contacts> list(int page, int pageSize, Contacts contacts);

    /*//查询所有者信息
    List<User> queryUsers();
*/
    //异步添加或者保存市场活动数据
    ResultVo saveOrUpdate(Contacts contacts, User user);

    //根据主键查询市场活动
    Contacts queryById(String id);

    //异步批量删除市场活动数据
    void deleteBatch(String ids);

    //异步查询详情页数据
    Contacts queryDetail(String id);

    //保存联系人备注
    void saveContactsRemark(ContactsRemark contactsRemark, User user);

    //更新联系人备注
    void editContactsRemark(ContactsRemark contactsRemark, User user);

    //删除联系人备注
    void deleteContactsRemark(String id);
}
