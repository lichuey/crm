package com.bjpowernode.crm.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Enumeration;

/**
 * 专门负责视图跳转
 */
@Controller
public class ViewController {

    //跳转到workbench的main下的index.jsp视图
    @RequestMapping({"/toView/{firstView}/{secondView}","/toView/{firstView}/{secondView}/{thirdView}"
            ,"/toView/{firstView}/{secondView}/{thirdView}/{fourthView}"})
    public String toView(@PathVariable(value = "firstView",required = false) String firstView,
                         @PathVariable(value = "secondView",required = false) String secondView,
                         @PathVariable(value = "thirdView",required = false) String thirdView,
                         @PathVariable(value = "fourthView",required = false) String fourthView,
                         HttpServletRequest request) {

        //使视图转化可以传递参数
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String name = parameterNames.nextElement();
            String value = request.getParameter(name);
            request.setAttribute(name, value);
        }

        if (thirdView == null) {
            return firstView + File.separator + secondView;
        }
        if (fourthView == null) {
            return firstView + File.separator + secondView + File.separator + thirdView;
        }
        return firstView + File.separator + secondView + File.separator + thirdView + File.separator + fourthView;
    }
}
