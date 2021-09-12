package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.service.ContactsService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ContactsController {

    @Autowired
    ContactsService contactsService;

    //使用BootStrap分页插件实现,还能实现条件模糊查询
    @RequestMapping("/workbench/contacts/list")
    public PageInfo list(int page, int pageSize, Contacts contacts) {


        List<Contacts> contactsList = contactsService.list(page, pageSize, contacts);

        PageInfo<Contacts> pageInfo = new PageInfo<>(contactsList);

        return pageInfo;
    }
}
