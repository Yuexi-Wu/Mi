package com.mi.model.bean;

import java.util.Date;
import java.util.List;

/**
 * Created by Alexander on 2018/7/19 下午1:23
 */
public class Seckill {

    public static final int SECKILL_STATUS_READY = 1;//活动未开始状态
    public static final int SECKILL_STATUS_RUNNING = 2;//活动进行中状态
    public static final int SECKILL_STATUS_OVER = 3;//活动已结束状态

    private int scekillId;//秒杀活动ID
    private String seckillName;//秒杀活动名称
    private String seckillDescription;//秒杀活动描述
    private Date seckillStart;//秒杀活动开始时间
    private Date seckillEnd;//秒杀活动结束时间
    private int seckillStatus;//秒杀活动状态
    private List<SeckillProduct> seckillProducts;//秒杀所有的商品项目集合

    public int getScekillId() {
        return scekillId;
    }

    public void setScekillId(int scekillId) {
        this.scekillId = scekillId;
    }

    public String getSeckillName() {
        return seckillName;
    }

    public void setSeckillName(String seckillName) {
        this.seckillName = seckillName;
    }

    public String getSeckillDescription() {
        return seckillDescription;
    }

    public void setSeckillDescription(String seckillDescription) {
        this.seckillDescription = seckillDescription;
    }

    public Date getSeckillStart() {
        return seckillStart;
    }

    public void setSeckillStart(Date seckillStart) {
        this.seckillStart = seckillStart;
    }

    public Date getSeckillEnd() {
        return seckillEnd;
    }

    public void setSeckillEnd(Date seckillEnd) {
        this.seckillEnd = seckillEnd;
    }

    public int getSeckillStatus() {
        return seckillStatus;
    }

    public void setSeckillStatus(int seckillStatus) {
        this.seckillStatus = seckillStatus;
    }

    public List<SeckillProduct> getSeckillProducts() {
        return seckillProducts;
    }

    public void setSeckillProducts(List<SeckillProduct> seckillProduct) {
        this.seckillProducts = seckillProduct;
    }
}
