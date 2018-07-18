package com.mi.model.bean;

/**
 * Created by Alexander on 2018/7/18 下午7:05
 */
public class Manager {
    private int managerId;//管理员ID
    private String managerName;//管理员名称
    private String managerPassword;//管理员密码
    private boolean managerSex;//管理员性别：true表示男 false表示女
    private String managerTelephone;//管理员手机号
    private String managerEmail;//管理员邮箱
    private String managerAddress;//管理员住址
    private String managerUrl;//管理员头像url

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getManagerPassword() {
        return managerPassword;
    }

    public void setManagerPassword(String managerPassword) {
        this.managerPassword = managerPassword;
    }

    public boolean isManagerSex() {
        return managerSex;
    }

    public void setManagerSex(boolean managerSex) {
        this.managerSex = managerSex;
    }

    public String getManagerTelephone() {
        return managerTelephone;
    }

    public void setManagerTelephone(String managerTelephone) {
        this.managerTelephone = managerTelephone;
    }

    public String getManagerEmail() {
        return managerEmail;
    }

    public void setManagerEmail(String managerEmail) {
        this.managerEmail = managerEmail;
    }

    public String getManagerAddress() {
        return managerAddress;
    }

    public void setManagerAddress(String managerAddress) {
        this.managerAddress = managerAddress;
    }

    public String getManagerUrl() {
        return managerUrl;
    }

    public void setManagerUrl(String managerUrl) {
        this.managerUrl = managerUrl;
    }
}
