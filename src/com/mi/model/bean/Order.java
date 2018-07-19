package com.mi.model.bean;

import java.util.Date;
import java.util.List;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/18
 * @description 订单
 */
public class Order {
    private int orderId;//主键
    private double total;//总价
    private int orderStatus;//订单状态:1.未付款 2.已付款 3.已收货 4.已评价 5.已取消(只有未付款才能取消) 6.拼团成功
    private int orderType;//订单类型:1.正常购物 2.秒杀 3.团购
    private int orderDeliverTime;//订单配送时间:.1不限收货时间 2.周一至周五 3.周六至周日
    private Date orderGenerationTime;//订单生成时间
    private Receiver receiver;//收货地址
    private List<OrderItem> items;//订单项

    public void countMoney() {
        total = 0;
        if (items == null || items.size() == 0)
            return;
        for (OrderItem orderItem : items) {
            total += orderItem.getOrderitemPrice();
        }
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public int getOrderType() {
        return orderType;
    }

    public void setOrderType(int orderType) {
        this.orderType = orderType;
    }

    public int getOrderDeliverTime() {
        return orderDeliverTime;
    }

    public void setOrderDeliverTime(int orderDeliverTime) {
        this.orderDeliverTime = orderDeliverTime;
    }

    public Date getOrderGenerationTime() {
        return orderGenerationTime;
    }

    public void setOrderGenerationTime(Date orderGenerationTime) {
        this.orderGenerationTime = orderGenerationTime;
    }

    public Receiver getReceiver() {
        return receiver;
    }

    public void setReceiver(Receiver receiver) {
        this.receiver = receiver;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}
