package com.mi.controller;

import com.mi.model.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Alexander on 2018/7/18 下午7:04
 */
@Controller
public class ManagerController {
    @Autowired
    private ManagerService service;

    @RequestMapping("login")
    public String login(String name, String password, Model model){
        String result = service.login(name, password);
        if (result.contains("success")){
            return "index";
        }else{
            if (result.equals("no_date"))
                model.addAttribute("tip", "用户不存在");
            else
                model.addAttribute("tip", "密码错误");
            System.out.println(result);
            return "login";
        }
    }
}
