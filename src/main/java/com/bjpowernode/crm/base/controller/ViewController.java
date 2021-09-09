package com.bjpowernode.crm.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.File;

/**
 * 专门负责视图跳转
 */
@Controller
public class ViewController {

    //跳转到workbench的main下的index.jsp视图
    @RequestMapping({"/toView/{firstView}/{secondView}","/toView/{firstView}/{secondView}/{thirdView}"})
    public String toView(@PathVariable(value = "firstView",required = false) String firstView,
                         @PathVariable(value = "secondView",required = false) String secondView,
                         @PathVariable(value = "thirdView",required = false) String thirdView) {
        if (thirdView == null) {
            return firstView + File.separator + secondView;
        }
        return firstView + File.separator + secondView + File.separator + thirdView;
    }
}
