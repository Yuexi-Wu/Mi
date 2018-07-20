package com.mi.model.bean;

/**
 * Created by Alexander on 2018/7/19 下午1:39
 */
public class Notification {

    public static final int NOTIFICATION_STATUS_READ = 1;//通知已读状态
    public static final int NOTIFICATION_STATUS_NEW = 2;//通知未读状态

    private int notificationId;//通知ID
    private String notificationTitle;//通知标题
    private String notificationContent;//通知内容
    private int notificationStatus;//通知状态
    private int accountId;//通知所属用户

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public String getNotificationTitle() {
        return notificationTitle;
    }

    public void setNotificationTitle(String notificationTitle) {
        this.notificationTitle = notificationTitle;
    }

    public String getNotificationContent() {
        return notificationContent;
    }

    public void setNotificationContent(String notificationContent) {
        this.notificationContent = notificationContent;
    }

    public int getNotificationStatus() {
        return notificationStatus;
    }

    public void setNotificationStatus(int notificationStatus) {
        this.notificationStatus = notificationStatus;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(Account account) {
        this.accountId = accountId;
    }
}
