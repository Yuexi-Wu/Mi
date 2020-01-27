package com.mi.model.service;

import com.mi.model.bean.Manager;
import com.mi.model.dao.ManagerDAO;
import com.mi.model.tools.Md5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/**
 * Created by Alexander on 2018/7/18 下午7:16
 */
@Service
public class ManagerService {
    @Autowired
    private ManagerDAO dao;

    public String login(String name, String password){
        Manager manager = dao.selectManagerByName(name);
        if (manager == null){
            return "no_data";
        }else{
            if (password.equals(manager.getManagerPassword())){
                return "success&" + manager.getManagerId();
            }else {
                return "wrong_password";
            }
        }
    }

    //通过ID获取管理员对象
    public Manager selectManagerById(int managerId){
        return dao.selectManagerById(managerId);
    }

    //修改管理员信息
    public void updateManager(Manager manager){
        dao.updateManager(manager);
    }

    //修改管理员密码
    public String updateManagerPassword(int managerId, String oldPassword, String newPassword1, String newPassword2){
        if (!newPassword1.equals(newPassword2)){
            return "different";
        }else {
            Manager manager = selectManagerById(managerId);
            oldPassword = Md5Utils.md5(oldPassword);
            if (!oldPassword.equals(manager.getManagerPassword())){
                return "wrong";
            }else {
                manager.setManagerPassword(Md5Utils.md5(newPassword1));
                dao.updateManagerPassword(manager);
                return "success";
            }
        }
    }
}
