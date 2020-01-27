package com.mi.model.bean;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/18
 * @description 购物车项
 */
public class CartItem {
    private int cartitemId;//主键
    private int cartitemQuantity;//数量
    private double cartitemPrice;//价格
    private Product product;//商品

    public int getCartitemId() {
        return cartitemId;
    }

    public void setCartitemId(int cartitemId) {
        this.cartitemId = cartitemId;
    }

    public int getCartitemQuantity() {
        return cartitemQuantity;
    }

    public void setCartitemQuantity(int cartitemQuantity) {
        this.cartitemQuantity = cartitemQuantity;
    }

    public double getCartitemPrice() {
        return cartitemPrice;
    }

    public void setCartitemPrice(double cartitemPrice) {
        this.cartitemPrice = cartitemPrice;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}
