package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.bean.User;

public interface UserService {

    //验证
    User login(User user, String code, String correctCode,String ip);

    //比较原密码是否正确
    void comparePwd(String oldPwd, User user);

    //更新用户密码
    void updatePwd(User user);
}
