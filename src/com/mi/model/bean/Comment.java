package com.mi.model.bean;

import java.util.Date;

public class Comment {
    private int commentId;
    private Account account;
    private String content;
    private String photoUrl;
    private int totalLevel;//1-差评，2-中评，3-好评
    private Date commentTime;
    private int descriptionLevel;//1，2，3，4，5星
    private int logisticsLevel;//1，2，3，4，5星
    private int serviceLevel;//1，2，3，4，5星
    private OrderItem orderItem;

    public int getTotalLevel() {
        return totalLevel;
    }

    public void setTotalLevel(int totalLevel) {
        this.totalLevel = totalLevel;
    }

    public int getDescriptionLevel() {
        return descriptionLevel;
    }

    public void setDescriptionLevel(int descriptionLevel) {
        this.descriptionLevel = descriptionLevel;
    }

    public int getLogisticsLevel() {
        return logisticsLevel;
    }

    public void setLogisticsLevel(int logisticsLevel) {
        this.logisticsLevel = logisticsLevel;
    }

    public int getServiceLevel() {
        return serviceLevel;
    }

    public void setServiceLevel(int serviceLevel) {
        this.serviceLevel = serviceLevel;
    }



    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public OrderItem getOrderItem() {
        return orderItem;
    }

    public void setOrderItem(OrderItem orderItem) {
        this.orderItem = orderItem;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public String getContext() {
        return content;
    }

    public void setContext(String content) {
        this.content = content;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photourl) {
        this.photoUrl = photourl;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }
}
