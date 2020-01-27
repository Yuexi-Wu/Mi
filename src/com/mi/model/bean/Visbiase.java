package com.mi.model.bean;

/**
 * bean which saves visible layers' biases of CRBMRecommender
 * @author huang jiarui
 * @version 1.0
 */
public class Visbiase {

    private int visbiaseId;//the id of hidbiase
    private int productId;//the id of visible layer's product
    private double visbiaseValue;//the value of bias

    public int getVisbiaseId() {
        return visbiaseId;
    }

    public void setVisbiaseId(int visbiaseId) {
        this.visbiaseId = visbiaseId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public double getVisbiaseValue() {
        return visbiaseValue;
    }

    public void setVisbiaseValue(double visbiaseValue) {
        this.visbiaseValue = visbiaseValue;
    }
}
