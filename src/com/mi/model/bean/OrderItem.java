package com.mi.model.bean;

/**
 * @author daiqibin
 * @version 1.2.0
 * @date 2018/7/18
 * @description 订单项
 */
public class OrderItem {
    private int orderitemId;//主键
    private int orderitemQuantity;//数量
    private double orderitemPrice;//价格
    private Product product;//商品
    private boolean commented;//是否评价,0为未评价，1为已评价

    public int getOrderitemId() {
        return orderitemId;
    }

    public void setOrderitemId(int orderitemId) {
        this.orderitemId = orderitemId;
    }

    public int getOrderitemQuantity() {
        return orderitemQuantity;
    }

    public void setOrderitemQuantity(int orderitemQuantity) {
        this.orderitemQuantity = orderitemQuantity;
    }

    public double getOrderitemPrice() {
        return orderitemPrice;
    }

    public void setOrderitemPrice(double orderitemPrice) {
        this.orderitemPrice = orderitemPrice;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public boolean isCommented() {
        return commented;
    }

    public void setCommented(boolean commented) {
        this.commented = commented;
    }
}
