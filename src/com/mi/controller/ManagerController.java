package com.mi.controller;

import com.mi.model.bean.Manager;
import com.mi.model.service.ManagerService;
import com.mi.model.utils.Md5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by Alexander on 2018/7/18 下午7:04
 */
@Controller
public class ManagerController {
    @Autowired
    private ManagerService service;

    @RequestMapping("managerLogin")
    public String login(String name, String password, Model model, HttpSession session){
        password = Md5Utils.md5(password);
        String result = service.login(name, password);
        if (result.contains("success")){
            int id = Integer.parseInt(result.substring(result.indexOf('&') + 1));
            Manager manager = service.selectManagerById(id);
            System.out.println(manager.getManagerSex()+ "------------------------");
            session.setAttribute("manager", manager);
            return "main";
        }else{
            if (result.equals("no_data")) {
                model.addAttribute("tip", "用户不存在");
            } else {
                model.addAttribute("tip", "密码错误");
            }
            return "login";
        }
    }

    @RequestMapping("getManagerInfo")
    public Manager getManagerInfo(int managerId){
        Manager manager = service.selectManagerById(managerId);
        return manager;
    }


}
