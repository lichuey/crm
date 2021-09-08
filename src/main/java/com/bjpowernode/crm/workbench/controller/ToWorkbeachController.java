package com.bjpowernode.crm.workbench.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ToWorkbeachController {

    @RequestMapping("/workbench/main/index")
    public String toMain(){
        return "/workbench/main/index";
    }

    @RequestMapping("/workbench/activity/index")
    public String toActivity() {
        return "/workbench/activity/index";
    }
}
