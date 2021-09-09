package com.bjpowernode.crm.settings.service.Impl;

import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.MD5Util;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    //验证
    @Override
    public User login(User user, String code, String correctCode,String ip) {
        //先校验用户输入的验证码是否正确
        if (!correctCode.equalsIgnoreCase(code)) {
            //验证码输入不正确
            throw new CrmException(CrmEnum.USER_LOGIN_CODE);
        }

        //判断用户名密码是否正确
        Example example = new Example(User.class);
        example.createCriteria().andEqualTo("loginAct", user.getLoginAct()).andEqualTo("loginPwd", MD5Util.getMD5(user.getLoginPwd()));
        List<User> userList = userMapper.selectByExample(example);
        if (userList.size() == 0) {
            //用户名或密码错误
            throw new CrmException(CrmEnum.USER_LOGIN_LOGINACTANDPWD);
        }

        //判断用户是否失效
        //获取此用户
        user = userList.get(0);
        //获取此用户的失效时间
        String expireTime = user.getExpireTime();
        //获取现在时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
        String nowTime = sdf.format(new Date());
        //比较用户失效时间和现在时间
        if (expireTime.compareTo(nowTime) < 0) {
            //失效
            throw new CrmException(CrmEnum.USER_LOGIN_LOGINTIMEEXPIRE);
        }

        //判断用户是否被锁定
        if ("0".equals(user.getLockState())) {
            throw new CrmException(CrmEnum.USER_LOGIN_LOGINLOCT);
        }

        //判断用户ip是否被允许
        String allowIps = user.getAllowIps();
        if (!allowIps.equals(ip)) {
            throw new CrmException(CrmEnum.USER_LOGIN_LOGINIPNOTALLOW);
        }
        return user;
    }

    //比较原密码是否正确
    @Override
    public void comparePwd(String oldPwd, User user) {
        if (!user.getLoginPwd().equals(MD5Util.getMD5(oldPwd))) {
            throw new CrmException(CrmEnum.USER_UPDATE_OLDPOWERISFALSE);
        }
    }

    //更新用户密码
    @Override
    public void updatePwd(User user) {
        //加密密码
        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));
        //更新用户密码,返回影响记录条数
        int count = userMapper.updateByPrimaryKeySelective(user);
        //没有更新
        if (count == 0) {
            throw new CrmException(CrmEnum.USER_UPDATE_PASSWORD);
        }
    }
}
