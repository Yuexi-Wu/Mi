package com.mi.model.bean;

/**
 * Created by Alexander on 2018/7/23 下午5:53
 */
public class Detail {

    private int detailId;
    private int productId;
    private String detailKey;
    private String detailVlaue;

    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getDetailKey() {
        return detailKey;
    }

    public void setDetailKey(String detailKey) {
        this.detailKey = detailKey;
    }

    public String getDetailVlaue() {
        return detailVlaue;
    }

    public void setDetailVlaue(String detailVlaue) {
        this.detailVlaue = detailVlaue;
    }
}
