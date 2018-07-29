package com.mi.model.bean;

public class Comment {
    private int commentId;
    private String content;
    private String photoUrl;
    private int totalLevel;
    private String commentTime;
    private int descriptionLevel;
    private int logisticsLevel;
    private int serviceLevel;
    private OrderItem orderItem;
    private Account account;

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

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
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

    public String getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(String commentTime) {
        this.commentTime = commentTime;
    }


}
