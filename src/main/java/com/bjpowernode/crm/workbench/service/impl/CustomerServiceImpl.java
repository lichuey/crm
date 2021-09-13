package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.DateTimeUtil;
import com.bjpowernode.crm.base.util.UUIDUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.bean.CustomerRemark;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerRemarkMapper;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import javax.persistence.Id;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;

    //条件查询
    @Override
    public List<Customer> selectCustomer(int page, int pageSize, Customer customer) {
        Example example = new Example(Customer.class);
        Example.Criteria criteria = example.createCriteria();

        //通过名称查询
        if (StrUtil.isNotEmpty(customer.getName())) {
            criteria.andLike("name", "%" + customer.getName() + "%");
        }

        //通过所有者查询
        if (StrUtil.isNotEmpty(customer.getOwner())) {
            //通过名称查询所有用户
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name", "%" + customer.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);

            //将所有用户的id存入到list集合中
            List<String> ids = new ArrayList<>();
            for (User user : users) {
                ids.add(user.getId());
            }

            //通过id查询所有满足条件的客户
            criteria.andIn("owner", ids);
        }

        //通过公司座机查询
        if (StrUtil.isNotEmpty(customer.getPhone())) {
            criteria.andLike("phone", "%" + customer.getPhone() + "%");
        }

        //通过公司网站查询
        if (StrUtil.isNotEmpty(customer.getWebsite())) {
            criteria.andLike("website", "%" + customer.getWebsite() + "%");
        }

        //分页
        PageHelper.startPage(page, pageSize);
        //添加按创建时间降序排序
        example.setOrderByClause("name");//desc 降序

        List<Customer> customers = customerMapper.selectByExample(example);

        for (Customer customer1 : customers) {
            //处理owner
            User user = userMapper.selectByPrimaryKey(customer1.getOwner());
            customer1.setOwner(user.getName());
        }

        return customers;
    }

    //查询所有用户
    @Override
    public List<User> queryUser() {
        return userMapper.selectAll();
    }

    //保存更新客户
    @Override
    public ResultVo saveOrUpdate(Customer customer, User user) {
        ResultVo resultVo = new ResultVo();
        if (customer.getId() == null) {
            customer.setId(UUIDUtil.uuid());
            customer.setCreateBy(user.getName());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            int count = customerMapper.insertSelective(customer);
            if (count == 0) {
                throw new CrmException(CrmEnum.CUSTOMER_SAVE_FALSE);
            }
            resultVo.setResOK(true);
            resultVo.setMessage("客户保存成功");
        } else {
            customer.setEditBy(user.getName());
            customer.setEditTime(DateTimeUtil.getSysTime());
            int count = customerMapper.updateByPrimaryKeySelective(customer);
            if (count == 0) {
                throw new CrmException(CrmEnum.CUSTOMER_UPDATE_FALSE);
            }
            resultVo.setResOK(true);
            resultVo.setMessage("客户更新成功");
        }
        return resultVo;
    }

    //获取所有客户数据
    @Override
    public Customer queryCustomerById(String id) {
        return customerMapper.selectByPrimaryKey(id);
    }

    //获取所有用户
    @Override
    public List<User> queryAllUser() {
        return userMapper.selectAll();
    }

    //删除客户
    @Override
    public void deleteCustomerById(String ids) {
        String[] idArr = ids.split(",");
        List<String> idList = Arrays.asList(idArr);
        Example example = new Example(Customer.class);
        example.createCriteria().andIn("id", idList);
        int count = customerMapper.deleteByExample(example);
        if (count == 0) {
            throw new CrmException(CrmEnum.CUSTOMER_DELETE_FALSE);
        }
    }

    //通过id查询客户备注
    @Override
    public Customer queryDetail(String id) {
        //查询客户
        Customer customer = customerMapper.selectByPrimaryKey(id);

        //处理owner
        User user = userMapper.selectByPrimaryKey(customer.getOwner());
        customer.setOwner(user.getName());

        //查询客户备注
        CustomerRemark customerRemark = new CustomerRemark();
        customerRemark.setCustomerId(customer.getId());
        List<CustomerRemark> customerRemarks = customerRemarkMapper.select(customerRemark);
        customer.setCustomerRemarkList(customerRemarks);

        return customer;
    }

    //保存客户备注
    @Override
    public void saveCustomerRemark(CustomerRemark customerRemark, User user) {
        customerRemark.setId(UUIDUtil.uuid());
        customerRemark.setCreateBy(user.getName());
        customerRemark.setCreateTime(DateTimeUtil.getSysTime());
        int count = customerRemarkMapper.insertSelective(customerRemark);
        if (count == 0) {
            throw new CrmException(CrmEnum.CUSTOMER_REMARK_SAVE_FALSE);
        }
    }

    //更新客户备注
    @Override
    public void updateCustomerRemark(CustomerRemark customerRemark, User user) {
        customerRemark.setEditBy(user.getName());
        customerRemark.setEditTime(DateTimeUtil.getSysTime());
        int count = customerRemarkMapper.updateByPrimaryKeySelective(customerRemark);
        if (count == 0) {
            throw new CrmException(CrmEnum.CUSTOMER_REMARK_UPDATE_FALSE);
        }
    }

    //删除客户备注
    @Override
    public void deleteCustomerRemark(String id) {
        int count = customerRemarkMapper.deleteByPrimaryKey(id);
        if (count == 0) {
            throw new CrmException(CrmEnum.CUSTOMER_REMARK_DELETE_FALSE);
        }
    }
}
