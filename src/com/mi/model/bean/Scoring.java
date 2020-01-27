package com.mi.model.bean;

/**
 * bean which saves scoring status of comment
 * @author huang jiarui
 * @version 1.0
 */
public class Scoring {

    private int productId;//id of product
    private int accountId;//id of account
    private double score;//value of score

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

}
