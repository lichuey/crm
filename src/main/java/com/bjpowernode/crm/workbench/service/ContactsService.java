package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.bean.Contacts;

import java.util.List;

public interface ContactsService {

    List<Contacts> list(int page, int pageSize, Contacts contacts);

}
