package com.mi.model.bean;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/19 下午12:59
 */
public class Product {

    private int productId;//商品ID
    private String productName;//商品名称
    private String productIntro;//商品简介
    private double productPrice;//商品价格
    private String productColor;//商品颜色
    private String productVersion;//商品版本
    private String productSize;//商品尺寸
    private int productSales;//商品销量
    private int productMax;//商品最大购买量
    private String productUrl;//商品主要图片url
    private Date productTime;//商品上架时间
    private int scId;//商品所属二级分类ID
    private Map<String, String> details;//商品概述图片url和参数
    private List<Comment> comments;//商品所有的评论集合

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductIntro() {
        return productIntro;
    }

    public void setProductIntro(String productIntro) {
        this.productIntro = productIntro;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(double productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductColor() {
        return productColor;
    }

    public void setProductColor(String productColor) {
        this.productColor = productColor;
    }

    public String getProductVersion() {
        return productVersion;
    }

    public void setProductVersion(String productVersion) {
        this.productVersion = productVersion;
    }

    public String getProductSize() {
        return productSize;
    }

    public void setProductSize(String productSize) {
        this.productSize = productSize;
    }

    public int getProductSales() {
        return productSales;
    }

    public void setProductSales(int productSales) {
        this.productSales = productSales;
    }

    public int getProductMax() {
        return productMax;
    }

    public void setProductMax(int productMax) {
        this.productMax = productMax;
    }

    public String getProductUrl() {
        return productUrl;
    }

    public void setProductUrl(String productUrl) {
        this.productUrl = productUrl;
    }

    public Date getProductTime() {
        return productTime;
    }

    public void setProductTime(Date productTime) {
        this.productTime = productTime;
    }

    public int getScId() {
        return scId;
    }

    public void setScId(int scId) {
        this.scId = scId;
    }

    public Map<String, String> getDetails() {
        return details;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setDetails(Map<String, String> details) {
        this.details = details;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", productIntro='" + productIntro + '\'' +
                ", productPrice=" + productPrice +
                ", productColor='" + productColor + '\'' +
                ", productVersion='" + productVersion + '\'' +
                ", productSize='" + productSize + '\'' +
                ", productSales=" + productSales +
                ", productMax=" + productMax +
                ", productUrl='" + productUrl + '\'' +
                ", productTime=" + productTime +
                ", scId=" + scId +
                ", details=" + details +
                ", comments=" + comments +
                '}';
    }
}
