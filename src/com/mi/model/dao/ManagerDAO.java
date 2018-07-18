package com.mi.model.dao;

import com.mi.model.bean.Manager;

/**
 * Created by Alexander on 2018/7/18 下午7:11
 */
public interface ManagerDAO {
    public Manager selectManagerByName(String managerName);
    public Manager selectManagerById(int managerId);
    public void updateManager(Manager manager);
    public String updateManagerPassword(int managerId);
}
