package com.mi.model.dao;

import com.mi.model.bean.CartItem;
import com.mi.model.bean.Product;
import com.mi.model.bean.Receiver;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/18
 * @description 购物车DAO
 */
public interface CartDAO {


    /**
     * @param map
     * @return: void
     * @description 添加购物车项
     */
    public void addCartItem(Map<String, Object> map);

    /**
     * @param cartitemIds
     * @return void
     * @description 批量删除购物车项
     */
    public void deleteCartItem(List<Integer> cartitemIds);


    /**
     * @param cartitem
     * @return void
     * @description 更改购物车项商品数量
     */
    public void editQuantity(CartItem cartitem);

    /**
     * @param accountId
     * @return List<CartItem>
     * @description 查询指定账户下的购物车项
     */
    public List<CartItem> selectCartItemByAccount(int accountId);

    /**
     * @param cartItemIds
     * @return List<CartItem>
     * @description 查询指定Id的购物车项
     */
    public List<CartItem> selectCartItemById(int[] cartItemIds);


    /**
     * @param cartItemId
     * @return List<CartItem>
     * @description 查询指定Id的购物车项
     */
    public CartItem selectCartItemById(int cartItemId);

    /**
     * @param map
     * @return: void
     * @description 通过商品名称和细节获得购物车项
     */
    public CartItem findCartItem(Map<String, Object> map);


    public CartItem selectCartItemByProductId(Map<String, Object> map);
}
