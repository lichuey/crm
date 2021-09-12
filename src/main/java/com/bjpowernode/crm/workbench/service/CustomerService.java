package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Customer;

import java.util.List;

public interface CustomerService {

    //条件查询
    List<Customer> selectCustomer(int page, int pageSize, Customer customer);

    //查询所有用户
    List<User> queryUser();

    //保存更新客户
    void saveOrUpdate(Customer customer, User user);
}
