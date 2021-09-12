package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.CommonUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.bjpowernode.crm.workbench.bean.Customer;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
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
    public PageInfo selectCustomer(int page, int pageSize, Customer customer) {

        List<Customer> customerList = customerService.selectCustomer(page, pageSize, customer);
        return new PageInfo<>(customerList);
    }

    //查询所有用户
    @RequestMapping("/workbench/customer/queryUser")
    public List<User> queryUser() {
        return customerService.queryUser();
    }

    //保存更新客户
    @RequestMapping("/workbench/customer/saveOrUpdate")
    public ResultVo saveOrUpdate(Customer customer, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        try {
            User user = CommonUtil.getCurrentUser(session);
            customerService.saveOrUpdate(customer, user);
            resultVo.setResOK(true);
            resultVo.setMessage("客户更新成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }
}
