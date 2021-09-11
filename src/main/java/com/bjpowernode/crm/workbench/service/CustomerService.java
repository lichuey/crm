package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.bean.Customer;

import java.util.List;

public interface CustomerService {

    //条件查询
    List<Customer> selectCustomer(Customer customer);
}
