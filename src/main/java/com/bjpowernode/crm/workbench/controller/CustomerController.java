package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.workbench.service.CustomerService;
import com.bjpowernode.crm.workbench.bean.Customer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 顾客控制器
 * RestController:自动的给Controller中的每个方法返回值定为返回json
 */
@RestController
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    //条件查询
    @RequestMapping("/workbench/customer/selectCustomer")
    public List<Customer> selectCustomer(Customer customer) {
        return customerService.selectCustomer(customer);
    }
}
