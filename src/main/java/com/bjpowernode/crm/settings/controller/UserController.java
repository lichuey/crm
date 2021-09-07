package com.bjpowernode.crm.settings.controller;

import cn.hutool.db.Session;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.util.MD5Util;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    //登录
    @RequestMapping("/settings/user/login")
    @ResponseBody
    public ResultVo login(User user, String code, HttpSession session, HttpServletRequest request) {
        //返回结果对象
        ResultVo resultVo = new ResultVo();
        //获取正确的验证码
        String correctCode = (String) session.getAttribute("correctCode");
        try {
            //获取登录用户的ip
            String ip = request.getRemoteAddr();
            System.out.println(ip);
            //验证
            user = userService.login(user, code, correctCode, ip);
            //用户登录成功
            resultVo.setResOK(true);
            //将用户信息存储在session中
            session.setAttribute("user", user);
        } catch (CrmException e) {
            //给客户端返回错误消息
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //跳转到主页面
    @RequestMapping("/settings/user/toIndex")
    public String toLogin() {
        return "workbench/index";
    }

    //登出系统
    @RequestMapping("/settings/user/logOut")
    public String logOut(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/login.jsp";
    }

    //判断用户输入的原始密码是否正确
    @RequestMapping("/settings/user/verifyOldPwd")
    @ResponseBody
    public ResultVo verifyOldPwd(String oldPwd, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        User user = (User) session.getAttribute("user");
        try {
            userService.comparePwd(oldPwd,user);
            resultVo.setResOK(true);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }
}
