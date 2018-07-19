package com.mi.model.bean;

public class Comment {
    private int commentId;
    private Account account;
    private String context;
    private String photourl;
    private int level;

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
        return context;
    }

    public void setContext(String context) {
        this.context = context;
    }

    public String getPhotourl() {
        return photourl;
    }

    public void setPhotourl(String photourl) {
        this.photourl = photourl;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(String commentTime) {
        this.commentTime = commentTime;
    }

    public int getProductScore() {
        return productScore;
    }

    public void setProductScore(int productScore) {
        this.productScore = productScore;
    }

    public int getLigisticScore() {
        return ligisticScore;
    }

    public void setLigisticScore(int ligisticScore) {
        this.ligisticScore = ligisticScore;
    }

    public int getServiceScore() {
        return serviceScore;
    }

    public void setServiceScore(int serviceScore) {
        this.serviceScore = serviceScore;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    private String commentTime;
    private int productScore;
    private int ligisticScore;
    private int serviceScore;
    private Order order;
}
