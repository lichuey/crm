package com.bjpowernode.crm.base.controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.CircleCaptcha;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//生成图片验证码
@Controller
public class VerifyCodeController {

    @RequestMapping("code")
    public void code(HttpServletResponse response, HttpSession session) throws IOException {
        //定义图形验证码的长、宽、验证码字符数、干扰元素个数
        CircleCaptcha captcha = CaptchaUtil.createCircleCaptcha(200, 100, 4, 20);
        //获取正确的验证码
        String correctCode = captcha.getCode();
        //将正确的验证码存入session
        session.setAttribute("correctCode", correctCode);
        //写出
        captcha.write(response.getOutputStream());
    }
}
