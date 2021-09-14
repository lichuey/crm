package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.bean.CustomerRemark;

import java.util.List;

public interface CustomerService {

    //条件查询
    List<Customer> selectCustomer(int page, int pageSize, Customer customer);

    //查询所有用户
    List<User> queryUser();

    //保存更新客户
    ResultVo saveOrUpdate(Customer customer, User user);

    //获取所有客户数据
    Customer queryCustomerById(String id);

    /*//获取所有用户
    List<User> queryAllUser();*/

    //删除客户
    void deleteCustomerById(String ids);

    //通过id查询客户备注
    Customer queryDetail(String id);

    //保存客户备注
    void saveCustomerRemark(CustomerRemark customerRemark, User user);

    //更新客户备注
    void updateCustomerRemark(CustomerRemark customerRemark, User user);

    //删除客户备注
    void deleteCustomerRemark(String id);
}
