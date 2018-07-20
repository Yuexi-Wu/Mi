package com.mi.model.bean;

import java.util.List;

/**
 * Created by Alexander on 2018/7/19 下午12:57
 */
public class SecondClassification {

    private int scId;//二级分类ID
    private String scName;//二级分类名称
    private String scDescription;//二级分类描述
    private String scUrl;//二级分类图片url
    private int fcId;//所属一级分类Id
    private List<Product> products;//该二级分类下所有的商品集合

    public int getScId() {
        return scId;
    }

    public void setScId(int scId) {
        this.scId = scId;
    }

    public String getScName() {
        return scName;
    }

    public void setScName(String scName) {
        this.scName = scName;
    }

    public String getScDescription() {
        return scDescription;
    }

    public void setScDescription(String scDescription) {
        this.scDescription = scDescription;
    }

    public String getScUrl() {
        return scUrl;
    }

    public void setScUrl(String scUrl) {
        this.scUrl = scUrl;
    }

    public int getFcId() {
        return fcId;
    }

    public void setFcId(int fcId) {
        this.fcId = fcId;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }
}
