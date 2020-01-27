package com.mi.model.service;

import com.mi.model.bean.CartItem;
import com.mi.model.bean.Product;
import com.mi.model.bean.Receiver;
import com.mi.model.dao.CartDAO;
import com.mi.model.dao.ProductDAO;
import com.mi.model.dao.ReceiverDAO;
import com.mi.model.tools.CusMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/18
 * @description 购物车Service
 */
@Service
public class CartService {

    @Autowired
    private CartDAO cartDAO;
    @Autowired
    private ReceiverDAO receiverDAO;
    @Autowired
    private ProductDAO productDAO;

    /**
     * @param cartItem
     * @param accountId
     * @return void
     * @description 增加购物车项
     */
    public void addCartItem(CartItem cartItem, int accountId) {
        CartItem originCart = selectCartItemByProductId(cartItem.getProduct().getProductId(), accountId);
        if (originCart == null) {
            cartItem.setCartitemQuantity(1);
            cartItem.setCartitemId(CusMethod.randomId());
            Map<String, Object> map = new HashMap<>();
            map.put("k_cart", cartItem);
            map.put("k_account", accountId);
            cartDAO.addCartItem(map);
        } else {
            editQuantity(originCart.getCartitemId(), originCart.getCartitemQuantity() + 1);
        }
    }

    /**
     * @param cartitemId
     * @return void
     * @description 删除购物车项
     */
    public void deleteCartItem(int cartitemId) {
        List<Integer> cartitemIds = new ArrayList<>();
        cartitemIds.add(cartitemId);
        cartDAO.deleteCartItem(cartitemIds);
    }

    /**
     * @param cartitemId
     * @param quantity
     * @return double
     * @description 修改购物车项数量
     */
    public double editQuantity(int cartitemId, int quantity) {
        CartItem cartItem = new CartItem();
        cartItem.setCartitemId(cartitemId);
        int[] cartitemIds = {cartitemId};
        cartItem = cartDAO.selectCartItemById(cartitemIds).get(0);
        cartItem.setCartitemQuantity(quantity);
        cartDAO.editQuantity(cartItem);
        return cartItem.getCartitemPrice() * quantity;
    }

    /**
     * @param accountId
     * @return java.util.List<com.mi.model.bean.CartItem>
     * @description 通过小米账号查找购物车
     */
    public List<CartItem> selectCartItemByAccount(int accountId) {
        return cartDAO.selectCartItemByAccount(accountId);
    }

    /**
     * @param productId
     * @param accountId
     * @return com.mi.model.bean.CartItem
     * @description 通过商品Id查询购物车项
     */
    public CartItem selectCartItemByProductId(int productId, int accountId) {
        Map<String, Object> map = new HashMap<>();
        map.put("k_product", productId);
        map.put("k_account", accountId);
        return cartDAO.selectCartItemByProductId(map);
    }

    /**
     * @param cartItemIds
     * @return java.util.List<com.mi.model.bean.CartItem>
     * @description通过购物车项Id查询购物车信息
     */
    public List<CartItem> getCheckOutCart(int[] cartItemIds) {
        return cartDAO.selectCartItemById(cartItemIds);
    }

    /**
     * @param accountId
     * @return java.util.List<com.mi.model.bean.Receiver>
     * @description 过得当前小米账号保存的收货地址信息
     */
    public List<Receiver> getCheckOutReceiver(int accountId) {
        return receiverDAO.selectReceiverByAccount(accountId);
    }

    /**
     * @param accountId
     * @param product
     * @return int
     * @description 查询商品购买量是否超过限制
     */
    public int findCanBuyProduct(int accountId, Product product) {
        if(product.getProductId() !=0)
            product = productDAO.selectProductById(product.getProductId());
        else
            product = productDAO.selectProductByNCVS(product);
        CartItem originCart = selectCartItemByProductId(product.getProductId(), accountId);
        if (originCart != null && (originCart.getCartitemQuantity() + 1) > product.getProductMax()) {
            return 0;
        }
        return product.getProductId();
    }

    /**
     * @param productId
     * @return com.mi.model.bean.Product
     * @description 通过商品Id查询商品
     */
    public Product selectProductById(int productId){
        return productDAO.selectProductById(productId);
    }
}
