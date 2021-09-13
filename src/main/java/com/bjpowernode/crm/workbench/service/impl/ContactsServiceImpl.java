package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.DateTimeUtil;
import com.bjpowernode.crm.base.util.UUIDUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import com.bjpowernode.crm.workbench.mapper.ContactsMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.service.ContactsService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.Arrays;
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

        for (Contacts contacts1 : contactsList) {
            //处理owner
            String owner = contacts1.getOwner();
            User user = userMapper.selectByPrimaryKey(owner);

            contacts1.setOwner(user.getName());

            //处理customerId
            String customerId = contacts1.getCustomerId();
            Customer customer = customerMapper.selectByPrimaryKey(customerId);
            contacts1.setCustomerId(customer.getName());
        }

        return contactsList;
    }


    @Override
    public List<User> queryUsers() {
        return userMapper.selectAll();
    }


    @Override
    public ResultVo saveOrUpdate(Contacts contacts, User user) {
        ResultVo resultVo = new ResultVo();
        //先判断修改还是添加
        if(contacts.getId() == null){

            contacts.setId(UUIDUtil.uuid());
            contacts.setCreateBy(user.getName());
            contacts.setCreateTime(DateTimeUtil.getSysTime());
            int count = contactsMapper.insertSelective(contacts);
            if(count == 0){
                throw new CrmException(CrmEnum.CONTACTS_SAVE_FALSE);
            }
            //添加
            resultVo.setMessage("添加联系人成功");
        }else {
            //修改
            contacts.setEditBy(user.getName());
            contacts.setEditTime(DateTimeUtil.getSysTime());

            int count = contactsMapper.updateByPrimaryKeySelective(contacts);
            if(count == 0){
                throw new CrmException(CrmEnum.CONTACTS_UPDATE_FALSE);
            }
            resultVo.setMessage("修改联系人成功");

        }
        resultVo.setResOK(true);
        return resultVo;
    }

    @Override
    public Contacts queryById(String id) {
        return contactsMapper.selectByPrimaryKey(id);
    }

    @Override
    public void deleteBatch(String ids) {
        String[] split = ids.split(",");

        //把split转换成List集合
        List<String> list = Arrays.asList(split);
        Example example = new Example(Activity.class);
        example.createCriteria().andIn("id", list);
        contactsMapper.deleteByExample(example);
    }

}
