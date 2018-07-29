package com.mi.model.dao;

import com.mi.model.bean.Notification;

import java.util.List;

/**
 * Created by Alexander on 2018/7/23 下午7:38
 */
public interface NotificationDAO {
    //添加活动通知
    public void addNotifications(List<Notification> notifications);
    //通过通知ID获取通知
    public Notification selectNotificationById(int notificationId);
    //通过通知ID修改通知状态
    public void updateNotificationStatus(int notificationId);
}
