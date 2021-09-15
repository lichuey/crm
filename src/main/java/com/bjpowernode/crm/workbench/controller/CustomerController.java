package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.CommonUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.CustomerRemark;
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
            resultVo = customerService.saveOrUpdate(customer, user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //获取所有客户数据
    @RequestMapping("/workbench/customer/queryCustomerById")
    public Customer queryCustomerById(String id) {
        return customerService.queryCustomerById(id);
    }

    /*//获取所有用户
    @RequestMapping("/workbench/customer/queryAllUser")
    public List<User> queryAllUser() {
        return customerService.queryAllUser();
    }*/

    //删除客户
    @RequestMapping("/workbench/customer/deleteCustomerById")
    public ResultVo deleteCustomerById(String ids) {
        ResultVo resultVo = new ResultVo();
        try {
            customerService.deleteCustomerById(ids);
            resultVo.setResOK(true);
            resultVo.setMessage("客户删除成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //通过id查询客户备注
    @RequestMapping("/workbench/customer/queryDetail")
    public Customer queryDetail(String id) {
        return customerService.queryDetail(id);
    }

    //异步保存客户备注
    @RequestMapping("/workbench/customer/saveCustomerRemark")
    public ResultVo saveCustomerRemark(CustomerRemark customerRemark, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        User user = CommonUtil.getCurrentUser(session);
        try {
            customerService.saveCustomerRemark(customerRemark, user);
            resultVo.setResOK(true);
            resultVo.setMessage("客户保存成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //异步更新客户备注
    @RequestMapping("/workbench/customer/updateCustomerRemark")
    public ResultVo updateCustomerRemark(CustomerRemark customerRemark, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        User user = CommonUtil.getCurrentUser(session);
        try {
            customerService.updateCustomerRemark(customerRemark, user);
            resultVo.setResOK(true);
            resultVo.setMessage("客户更新成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //删除客户备注
    @RequestMapping("/workbench/customer/deleteCustomerRemark")
    public ResultVo deleteCustomerRemark(String id) {
        ResultVo resultVo = new ResultVo();
        try {
            customerService.deleteCustomerRemark(id);
            resultVo.setResOK(true);
            resultVo.setMessage("客户删除成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //通过id查询客户
    @RequestMapping("/workbench/customer/showEditCustomerDetailModal")
    public Customer showEditCustomerDetailModal(String id) {
        return customerService.showEditCustomerDetailModal(id);
    }

    //异步更新客户
    @RequestMapping("/workbench/customer/updateCustomer")
    public ResultVo updateCustomer(Customer customer, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        User user = CommonUtil.getCurrentUser(session);
        try {
            customerService.updateCustomer(customer, user);
            resultVo.setResOK(true);
            resultVo.setMessage("更新客户信息成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //异步删除客户
    @RequestMapping("workbench/customer/deleteCustomer")
    public ResultVo deleteCustomer(String id) {
        ResultVo resultVo = new ResultVo();
        try {
            customerService.deleteCustomerById(id);
            resultVo.setResOK(true);
            resultVo.setMessage("删除客户成功");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }
}
