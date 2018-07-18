package com.mi.model.service;

import com.mi.model.bean.Manager;
import com.mi.model.dao.ManagerDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
