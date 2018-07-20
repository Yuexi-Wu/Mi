package com.mi.controller;

import com.mi.model.bean.Manager;
import com.mi.model.service.ManagerService;
import com.mi.model.tools.Md5Utils;
import com.mi.model.tools.ParameterCheck;
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

    @RequestMapping("login")
    public String login(String name, String password, Model model, HttpSession session){
        password = Md5Utils.md5(password);
        String result = service.login(name, password);
        if (result.contains("success")){
            int id = Integer.parseInt(result.substring(result.indexOf('&') + 1));
            Manager manager = service.selectManagerById(id);
            System.out.println(manager.getManagerSex());
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

    @RequestMapping("logout")
    public String logout(HttpSession session){
        session.removeAttribute("manager");
        return "redirect:login.jsp";
    }

    @RequestMapping("getManagerInfo")
    public Manager getManagerInfo(int managerId){
        Manager manager = service.selectManagerById(managerId);
        return manager;
    }

    @RequestMapping("editManager")
    public String editManager(Manager manager, Model model, HttpSession session){
//        System.out.println(manager.getManagerName());
//        System.out.println(manager.getManagerSex());
//        System.out.println(manager.getManagerEmail());
//        System.out.println(manager.getManagerAddress());
//        System.out.println(manager.getManagerTelephone());
        if (manager.getManagerTelephone() != null && !manager.getManagerTelephone().equals("")){
            if (!ParameterCheck.isTelephoneLegal(manager.getManagerTelephone())){
                model.addAttribute("tip", "手机号格式有误");
                return "editManager";
            }
        }
        if (manager.getManagerEmail() != null && !manager.getManagerEmail().equals("")) {
            if (!ParameterCheck.isEmailLegal(manager.getManagerEmail())) {
                model.addAttribute("tip", "邮箱格式有误");
                return "editManager";
            }
        }
        service.updateManager(manager);
        Manager managerNew = service.selectManagerById(manager.getManagerId());
        System.out.println(managerNew.getManagerSex());
        session.setAttribute("manager", managerNew);
        model.addAttribute("tip", "success");
        return "editManager";
    }

    @RequestMapping("editPassword")
    public String editPassword(String managerId, String oldPassword, String newPassword1, String newPassword2, Model model){
        String result = service.updateManagerPassword(Integer.parseInt(managerId), oldPassword, newPassword1, newPassword2);
        String response = null;
        switch (result){
            case "different":
                response =  "两次新密码输入不一致";
                break;
            case "wrong":
                response =  "旧密码错误";
                break;
            case "success":
                response =  "修改成功";
                break;
            default:
                break;
        }
        model.addAttribute("tip", response);
        return "editPassword";
    }
}
