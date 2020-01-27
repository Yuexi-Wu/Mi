package com.mi.model.bean;

/**
 * bean which saves hidden layers' biases of CRBMRecommender
 * @author huang jiarui
 * @version 1.0
 */
public class Hidbiase {

    private int hidbiaseId;//the id of hidbiase
    private int featureNumber;//the number of hidden layer's feature
    private double hidbiaseValue;//the value of bias

    public int getHidbiaseId() {
        return hidbiaseId;
    }

    public void setHidbiaseId(int hidbiaseId) {
        this.hidbiaseId = hidbiaseId;
    }

    public int getFeatureNumber() {
        return featureNumber;
    }

    public void setFeatureNumber(int featureNumber) {
        this.featureNumber = featureNumber;
    }

    public double getHidbiaseValue() {
        return hidbiaseValue;
    }

    public void setHidbiaseValue(double hidbiaseValue) {
        this.hidbiaseValue = hidbiaseValue;
    }
}
