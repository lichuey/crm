package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.CommonUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.bean.ContactsRemark;
import com.bjpowernode.crm.workbench.service.ContactsService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
public class ContactsController {

    @Autowired
    ContactsService contactsService;

    //条件模糊查询
    @RequestMapping("/workbench/contacts/list")
    public PageInfo list(int page, int pageSize, Contacts contacts) {


        List<Contacts> contactsList = contactsService.list(page, pageSize, contacts);

        PageInfo<Contacts> pageInfo = new PageInfo<>(contactsList);

        return pageInfo;
    }

    //查询所有者信息
    @RequestMapping("/workbench/contacts/queryUsers")
    public List<User> queryUsers() {
        return contactsService.queryUsers();
    }

    //异步添加或者保存市场活动数据
    @RequestMapping("/workbench/contacts/saveOrUpdate")
    public ResultVo saveOrUpdate(Contacts contacts, HttpSession session){
        ResultVo resultVo = new ResultVo();
        try {
            User user = CommonUtil.getCurrentUser(session);
            resultVo = contactsService.saveOrUpdate(contacts,user);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //根据主键查询市场活动
    @RequestMapping("/workbench/contacts/queryById")
    public Contacts queryById(String id){
        return contactsService.queryById(id);
    }

    //异步批量删除市场活动数据
    @RequestMapping("/workbench/contacts/deleteBatch")
    public ResultVo deleteBatch(String ids){
        ResultVo resultVo = new ResultVo();
        try {
            contactsService.deleteBatch(ids);
            resultVo.setResOK(true);
            resultVo.setMessage("删除联系人成功");
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //异步查询详情页数据
    @RequestMapping("/workbench/contacts/queryDetail")
    public Contacts queryDetail(String id){
        Contacts contacts = contactsService.queryDetail(id);
        return contacts;
    }

    //保存联系人备注
    @RequestMapping("/workbench/contacts/saveContactsRemark")
    public ResultVo saveContactsRemark(ContactsRemark contactsRemark, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        User user = CommonUtil.getCurrentUser(session);
        try {
            contactsService.saveContactsRemark(contactsRemark, user);
            resultVo.setResOK(true);
            resultVo.setMessage("联系人备注保存成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //更新联系人备注
    @RequestMapping("/workbench/contacts/editContactsRemark")
    public ResultVo editContactsRemark(ContactsRemark contactsRemark, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        User user = CommonUtil.getCurrentUser(session);
        try {
            contactsService.editContactsRemark(contactsRemark, user);
            resultVo.setResOK(true);
            resultVo.setMessage("联系人备注更新成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //删除联系人备注
    @RequestMapping("/workbench/contacts/deleteContactsRemarkModel")
    public ResultVo deleteContactsRemarkModel(String id) {
        ResultVo resultVo = new ResultVo();
        try {
            contactsService.deleteContactsRemark(id);
            resultVo.setResOK(true);
            resultVo.setMessage("联系人备注删除成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }
}
