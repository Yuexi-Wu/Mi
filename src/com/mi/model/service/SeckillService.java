package com.mi.model.service;

import com.mi.model.bean.Notification;
import com.mi.model.bean.Seckill;
import com.mi.model.dao.AccountDAO;
import com.mi.model.dao.NotificationDAO;
import com.mi.model.dao.SeckillDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 下午2:03
 */
@Service
public class SeckillService {

    @Autowired
    private SeckillDAO seckillDAO;
    @Autowired
    private AccountDAO accountDAO;
    @Autowired
    private NotificationDAO notificationDAO;

    public List<Seckill> selectAllSeckills(String startTime, String endTime, String page, String limit){
        Map<String, Object> map = new HashMap<>();
        if (startTime != null && !startTime.equals("")){
            map.put("startTime", startTime);
        }
        if (endTime != null && !endTime.equals("")){
            map.put("endTime", endTime);
        }
        if (page != null && !page.equals("") && limit != null && !limit.equals("")){
            map.put("index", ((Integer.parseInt(page) - 1) * Integer.parseInt(limit)));
            map.put("limit", Integer.parseInt(limit));
        }
        return seckillDAO.selectAllSeckills(map);
    }

    public int selectAllSeckillsCount(String startTime, String endTime){
        Map<String, Object> map = new HashMap<>();
        if (startTime != null && !startTime.equals("")){
            map.put("startTime", startTime);
        }
        if (endTime != null && !endTime.equals("")){
            map.put("endTime", endTime);
        }
        return seckillDAO.selectAllSeckillsCount(map);
    }

    public void deleteSeckill(int seckillId){
        seckillDAO.deleteSeckill(seckillId);
    }

    public void addSeckill(Seckill seckill){
        seckillDAO.addSeckill(seckill);

        List<Integer> accountIds = accountDAO.selectAllAccountsId();
        List<Notification> notifications = new ArrayList<>();
        String title = seckill.getSeckillName() + "开始！！！";
        String content = seckill.getSeckillDescription();
        for (Integer accountId: accountIds){
            Notification notification = new Notification();
            notification.setNotificationStatus(Notification.NOTIFICATION_STATUS_NEW);
            notification.setNotificationTitle(title);
            notification.setNotificationContent(content);
            notification.setAccountId(accountId);
            notifications.add(notification);
        }
        notificationDAO.addNotifications(notifications);
    }

    public Seckill selectSeckillById(int seckillId) {
        return seckillDAO.selectSeckillById(seckillId);
    }

    /**
     * get latest second kill activity
     * @return latest second kill activity
     * @author huang jiarui
     * @version 1.0
     */
    public Seckill getLatestSeckill(){
        return seckillDAO.getLatestSeckill();
    }
}
