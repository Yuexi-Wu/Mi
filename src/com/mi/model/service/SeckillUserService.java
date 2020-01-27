package com.mi.model.service;

import com.mi.model.bean.*;
import com.mi.model.dao.*;
import com.mi.model.tools.CusMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class SeckillUserService {
    @Autowired
    private SeckillDAO seckillDAO;
    @Autowired
    private SeckillProductDAO spDAO;
    @Autowired
    private SeckillQueueStatusDAO sqsDAO;
    @Autowired
    private OrderDAO orderDAO;
    @Autowired
    private ReceiverDAO receiverDAO;
    @Autowired
    private NotificationDAO notificationDAO;

    /**
     * 得到今日正在进行中的和尚未进行的闪购活动列表
     */
    public List<Seckill> getTodayRemainingSeckills() {
        return seckillDAO.getTodayRemainingSeckills();
    }

    /**
     * 根据ID获取秒杀活动信息（不包含商品）
     */
    public Seckill getSeckillById(int seckillId) {
        return seckillDAO.getSeckillById(seckillId);
    }

    /**
     * 得到指定闪购活动的闪购商品
     */
    public List<SeckillProduct> getSeckillProducts(int seckillId) {
        return spDAO.getSeckillProductsBySeckillId(seckillId);
    }

    /**
     * 得到该闪购商品已经被抢到的数量。
     */
    public int getBoughtCount(int spId) {
        return spDAO.getBoughtCount(spId);
    }

    /**
     * 得到用户当前“正在进行中”的排队请求。
     * “正在进行中”指状态为“正在排队”或“排队成功等待付款”的排队请求。
     */
    public SeckillQueueStatus getCurrentSqsByAccountId(int accountId) {
        return sqsDAO.getCurrentSqsByAccountId(accountId);
    }

    /**
     * 检测该用户是否可以进行闪购（即没有“正在进行中”的排队请求）
     */
    public boolean getCanDoSeckill(int accountId) {
        SeckillQueueStatus sqs = sqsDAO.getCurrentSqsByAccountId(accountId);
        return (sqs == null);
    }

    /**
     * 用户开始排队
     */
    public void saveInQueue(int accountId, int spId) {
        SeckillQueueStatus sqs = new SeckillQueueStatus();
        Account account = new Account(); account.setAccountId(accountId); sqs.setAccount(account);
        SeckillProduct sp = new SeckillProduct(); sp.setSpId(spId); sqs.setSeckillProduct(sp);
        sqsDAO.addSeckillQueueStatus(sqs);
    }

    /**
     *  检查用户当前闪购商品的排队状态。并且使得排队计数加1。
     */
    public SeckillQueueStatus transactionCheckQueueStatus(int accountId) {
        SeckillQueueStatus sqs = sqsDAO.getCurrentSqsByAccountId(accountId);
        if (sqs != null) {
            if (sqs.getSqsStatus() == 1) {
                sqs.setSqsWaitCount(sqs.getSqsWaitCount() + 1);
                sqsDAO.updateWaitCount(sqs);
            }
        } else {
            sqs = new SeckillQueueStatus();
            sqs.setSqsStatus(5);
        }
        return sqs;
    }

    /**
     *  用户取消排队。
     */
    public void deleteFromQueue(int accountId) {
        SeckillQueueStatus sqs = sqsDAO.getCurrentSqsByAccountId(accountId);
        sqs.setSqsStatus(5);
        sqsDAO.updateSqsStatus(sqs);
    }

    /**
     * 对用户当前进行中的排队成功等待付款的订单进行付款
     * 如果付款成功，返回订单号，否则返回null
     */
    public String transactionPurchaseCurrentSeckill(Receiver receiver, int accountId) {
        SeckillQueueStatus sqs = sqsDAO.getCurrentSqsByAccountId(accountId);
        //如果未超时，则付款成功，添加订单。
        if (sqs != null && sqs.getSqsStatus() == 2) {
            System.out.println("-----------------" + sqs.getSqsId() + " " + sqs.getSqsAcceptedTime());
            System.out.println("-----------------" + receiver.getReceiverName() + " " + receiver.getAdDetail());
            //修改队列状态为已付款
            sqs.setSqsStatus(3);
            sqsDAO.updateSqsStatus(sqs);
            //添加收货人
            receiver.setReceiverId(CusMethod.randomId());
            receiver.setAccount(new Account()); receiver.getAccount().setAccountId(accountId);
            receiverDAO.addReceiver(receiver);
            //添加订单
            Order order = new Order();
            order.setReceiver(receiver);
            order.setOrderId(CusMethod.randomStringId());
            order.setOrderStatus(2);
            order.setOrderType(2);
            order.setOrderDeliverTime(1);
            Map<String, Object> orderMap = new HashMap<>();
            orderMap.put("k_order", order);
            orderMap.put("k_account", accountId);
            orderDAO.addOrder(orderMap);
            //添加订单项
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderitemId(CusMethod.randomId());
            orderItem.setProduct(new Product()); orderItem.getProduct().setProductId(sqs.getSeckillProduct().getProduct().getProductId());
            orderItem.setOrderitemPrice(sqs.getSeckillProduct().getSpPrice());
            orderItem.setOrderitemQuantity(1);
            Map<String, Object> orderItemMap = new HashMap<>();
            orderItemMap.put("k_orderitem", orderItem);
            orderItemMap.put("k_order", order.getOrderId());
            orderDAO.addOrderItem(orderItemMap);
            //添加付款时间
            order.setOrderPayTime(new Date());
            orderDAO.updateOrder(order);
            //插入通知
            Notification notification = new Notification();
            notification.setAccountId(accountId);
            notification.setNotificationTitle("闪购购买成功");
            String productName = sqs.getSeckillProduct().getProduct().getProductName();
            notification.setNotificationContent("您闪购购买的" + productName + "付款成功，订单已生成");
            notification.setNotificationStatus(0);
            notificationDAO.addSingleNotification(notification);
            return order.getOrderId();
        } else {
            return null;
        }
    }
}