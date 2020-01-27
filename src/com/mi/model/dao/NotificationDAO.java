package com.mi.model.dao;

import com.mi.model.bean.Notification;

import java.util.List;

public interface NotificationDAO {

    //查询所有消息
    public List<Notification> getAllNotes(int accountId);

    //通过通知ID修改通知状态
    public void updateNotificationStatus(Notification notification);

    //查看所有已读消息
    public List<Notification> getReadNotes(int accountId);

    //查看所有未读消息
    public List<Notification> getUnreadNotes(int accountId);

    //通过id查找消息
    public Notification getNotificationById(int notificationId);

    //注册成功后发送第一条消息通知
    public void addFirstNotification(int accountId);

    //添加活动通知
    public void addNotifications(List<Notification> notifications);

    //通过通知ID获取通知
    public Notification selectNotificationById(int notificationId);

    //给指定用户发送通知
    public void addSingleNotification(Notification notification);

}
