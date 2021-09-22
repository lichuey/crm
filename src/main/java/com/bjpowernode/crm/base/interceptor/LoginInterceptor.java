package com.bjpowernode.crm.base.interceptor;

import com.bjpowernode.crm.settings.bean.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("/crm/login.jsp");
        }

        return true;
    }
}
