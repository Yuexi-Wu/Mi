package com.mi.model.bean;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/27
 * @description 商品描述
 */
public class Descripe {
    String descipetion;//商品型号或尺寸
    Double price;//价格

    public String getDescipetion() {
        return descipetion;
    }

    public void setDescipetion(String descipetion) {
        this.descipetion = descipetion;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
}
