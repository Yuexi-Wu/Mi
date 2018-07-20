package com.mi.model.bean;

/**
 * Created by Alexander on 2018/7/19 下午1:31
 */
public class SeckillProduct {

    private int spId;//秒杀商品项目ID
    private Product product;//秒杀商品项目商品
    private int spAmount;//秒杀商品项目数量
    private double spPrice;//秒杀商品项目价格
    private int seckillId;//所属秒杀活动ID

    public int getSpId() {
        return spId;
    }

    public void setSpId(int spId) {
        this.spId = spId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getSpAmount() {
        return spAmount;
    }

    public void setSpAmount(int spAmount) {
        this.spAmount = spAmount;
    }

    public double getSpPrice() {
        return spPrice;
    }

    public void setSpPrice(double spPrice) {
        this.spPrice = spPrice;
    }

    public int getSeckillId() {
        return seckillId;
    }

    public void setSeckillId(int seckillId) {
        this.seckillId = seckillId;
    }
}
