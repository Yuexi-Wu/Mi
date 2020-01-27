package com.mi.model.bean;

/**
 * bean which saves weights of CRBMRecommender
 * @author huang jiarui
 * @version 1.0
 */
public class Weight {

    private int weightId;//the id of weight
    private int productId;//the id of visible layer's product
    private int featureNumber;//the id of hidden layer's feature
    private double weightValue;//the value of weight

    public int getWeightId() {
        return weightId;
    }

    public void setWeightId(int weightId) {
        this.weightId = weightId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getFeatureNumber() {
        return featureNumber;
    }

    public void setFeatureNumber(int featureNumber) {
        this.featureNumber = featureNumber;
    }

    public double getWeightValue() {
        return weightValue;
    }

    public void setWeightValue(double weightValue) {
        this.weightValue = weightValue;
    }
}
