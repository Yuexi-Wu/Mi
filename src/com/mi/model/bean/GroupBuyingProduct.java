package com.mi.model.bean;

/**
 * Created by Alexander on 2018/7/19 下午1:36
 */
public class GroupBuyingProduct {

    private int gbpId;//团购商品项目ID
    private Product product;//团购商品项目商品
    private int gbpAmount;//团购商品项目数量
    private double gbpPrice;//团购商品项目价格
    private int gbId;//所属团购活动

    public int getGbpId() {
        return gbpId;
    }

    public void setGbpId(int gbpId) {
        this.gbpId = gbpId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getGbpAmount() {
        return gbpAmount;
    }

    public void setGbpAmount(int gbpAmount) {
        this.gbpAmount = gbpAmount;
    }

    public double getGbpPrice() {
        return gbpPrice;
    }

    public void setGbpPrice(double gbpPrice) {
        this.gbpPrice = gbpPrice;
    }

    public int getGbId() {
        return gbId;
    }

    public void setGbId(int gbId) {
        this.gbId = gbId;
    }
}
