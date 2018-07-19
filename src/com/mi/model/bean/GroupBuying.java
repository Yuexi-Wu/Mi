package com.mi.model.bean;

import java.util.Date;
import java.util.List;

/**
 * Created by Alexander on 2018/7/19 下午1:34
 */
public class GroupBuying {

    public static final int GB_STATUS_READY = 1;//活动未开始状态
    public static final int GB_STATUS_RUNNING = 2;//活动进行中状态
    public static final int GB_STATUS_OVER = 3;//活动已结束状态

    private int gbId;//团购活动ID
    private String gbName;//团购活动名称
    private String gbDescription;//团购活动描述
    private Date gbStart;//团购活动开始时间
    private Date gbEnd;//团购活动结束时间
    private int gbStatus;//团购活动状态
    private List<GroupBuyingProduct> gbProducts;//团购所有的商品项目集合

    public int getGbId() {
        return gbId;
    }

    public void setGbId(int gbId) {
        this.gbId = gbId;
    }

    public String getGbName() {
        return gbName;
    }

    public void setGbName(String gbName) {
        this.gbName = gbName;
    }

    public String getGbDescription() {
        return gbDescription;
    }

    public void setGbDescription(String gbDescription) {
        this.gbDescription = gbDescription;
    }

    public Date getGbStart() {
        return gbStart;
    }

    public void setGbStart(Date gbStart) {
        this.gbStart = gbStart;
    }

    public Date getGbEnd() {
        return gbEnd;
    }

    public void setGbEnd(Date gbEnd) {
        this.gbEnd = gbEnd;
    }

    public int getGbStatus() {
        return gbStatus;
    }

    public void setGbStatus(int gbStatus) {
        this.gbStatus = gbStatus;
    }

    public List<GroupBuyingProduct> getGbProducts() {
        return gbProducts;
    }

    public void setGbProducts(List<GroupBuyingProduct> gbProducts) {
        this.gbProducts = gbProducts;
    }
}
