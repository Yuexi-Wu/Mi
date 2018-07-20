package com.mi.model.bean;

public class FavouriteItem {
    private int favourId;
    private Product product;

    public int getFavourId() {
        return favourId;
    }

    public void setFavourId(int favourId) {
        this.favourId = favourId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

}