package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.bean.User;

import java.util.List;

public interface UserService {

    //查询所有用户
    List<User> queryAllUser();
}
