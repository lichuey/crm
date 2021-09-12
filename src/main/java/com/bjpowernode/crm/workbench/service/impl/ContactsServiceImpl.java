package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.mapper.ContactsMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.service.ContactsService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;

@Service
public class ContactsServiceImpl implements ContactsService {

    @Autowired
    ContactsMapper contactsMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    CustomerMapper customerMapper;

    @Override
    public List<Contacts> list(int page, int pageSize, Contacts contacts) {

        Example example = new Example(Contacts.class);
        Example.Criteria criteria = example.createCriteria();

        //所有者模糊查询
        //1、先按owner查询用户表，查询满足条件的用户
        if(StrUtil.isNotEmpty(contacts.getOwner())){
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name", "%" + contacts.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);


            //2、把查询出来的用户的主键放入到集合中
            List<String> ids = new ArrayList<>();
            for(User user : users){
                ids.add(user.getId());
            }

            //3、查询用户的id在联系人表中的满足的owner
            criteria.andIn("owner", ids);
        }


        //按姓名模糊查询
        //isNotEmpty:null ""
        if(StrUtil.isNotEmpty(contacts.getFullname())){
            criteria.andLike("fullname", "%" + contacts.getFullname() + "%");
        }

        //按客户名称模糊查询
        if (StrUtil.isNotEmpty(contacts.getCustomerId())) {
            //1、通过顾客名称查询满足条件的顾客
            Example example1 = new Example(Customer.class);
            example1.createCriteria().andLike("name", "%" + contacts.getCustomerId() + "%");
            List<Customer> customerList = customerMapper.selectByExample(example1);

            //2、将查询出来的客户id放入集合中
            List<String> ids = new ArrayList<>();
            for (Customer customer : customerList) {
                ids.add(customer.getId());
            }

            //3、查询客户id在联系人表中满足的customerId
            criteria.andIn("customerId", ids);
        }

        //按来源查询
        if (StrUtil.isNotEmpty(contacts.getSource())) {
            criteria.andEqualTo("source", contacts.getSource());
        }

        //按生日查询
        if (StrUtil.isNotEmpty(contacts.getBirth())) {
            criteria.andEqualTo("birth", contacts.getBirth());
        }

        //参数1:当前页码 参数2:每页记录数 改行代码等同于limit a,b
        PageHelper.startPage(page, pageSize);

        //添加按创建时间降序排序
        example.setOrderByClause("createTime desc");
        List<Contacts> contactsList = contactsMapper.selectByExample(example);

        for (Contacts Contacts : contactsList) {
            //处理owner
            String owner = Contacts.getOwner();
            User user = userMapper.selectByPrimaryKey(owner);

            Contacts.setOwner(user.getName());

            //处理customerId
            String customerId = Contacts.getCustomerId();
            Customer customer = customerMapper.selectByPrimaryKey(customerId);
            Contacts.setCustomerId(customer.getName());
        }

        return contactsList;
    }


}
