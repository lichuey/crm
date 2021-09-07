package com.bjpowernode.crm.test;

import com.bjpowernode.crm.base.util.MD5Util;
import com.bjpowernode.crm.base.util.UUIDUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;

public class TestCrm {

    BeanFactory beanFactory = new ClassPathXmlApplicationContext("classpath:spring/applicationContext.xml");
    UserMapper userMapper = (UserMapper) beanFactory.getBean("userMapper");
    //tkMapper
    //测试添加
    @Test
    public void test01() {
          //insertSelective:只插入非空值
        User user = new User();
        user.setId(UUIDUtil.uuid());
        user.setName("李初");

        userMapper.insertSelective(user);
    }

    //测试更新
    @Test
    public void test02() {
        User user = new User();
        user.setId("2d53edd0d5e14fe58158597b043389b2");
        user.setName("李文燕");

        //userMapper.updateByPrimaryKeySelective(user);
        Example example = new Example(User.class);
        example.createCriteria().andEqualTo("id", "2d53edd0d5e14fe58158597b043389b2");
        User user1 = new User();
        user1.setName("陆小凤");
        userMapper.updateByExampleSelective(user1,example);
    }

    //测试删除
    @Test
    public void test03() {
        //根据主键删除
        //userMapper.deleteByPrimaryKey("2d53edd0d5e14fe58158597b043389b2");

//        User user = new User();
//        user.setId("12312");
//        userMapper.delete(user);

        String name = "楚";
        Example example = new Example(User.class);
        example.createCriteria().andLike("name", "%" + name + "%");
        userMapper.deleteByExample(example);
    }

    //测试查询
    @Test
    public void test04() {
        /*User user = new User();
        user.setName("胡铁花");
        List<User> users = userMapper.select(user);
        System.out.println(users);*/

//        userMapper.selectAll();
        List<String> ids = new ArrayList<>();
        ids.add("21434152142125325321");
        ids.add("31421412421421");
        Example example = new Example(User.class);
        example.createCriteria().andIn("id", ids);
        List<User> users = userMapper.selectByExample(example);
        for (User user : users) {
            System.out.println(user);
        }
    }

    //测试加密
    @Test
    public void test05() {
        String s = "123";
        String md5 = MD5Util.getMD5(s);
        System.out.println(md5);
    }
}
