package com.mi.model.dao;

import com.mi.model.bean.Comment;
import com.mi.model.bean.Order;
import com.mi.model.bean.OrderItem;
import com.mi.model.bean.Reply;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author daiqibin
 * @version 1.4.0
 * @date 2018/8/1
 * @description 订单DAO
 */
public interface OrderDAO {
    /**
     * @param map
     * @return void
     * @description 添加订单
     */
    public void addOrder(Map<String, Object> map);

    /**
     * @param order
     * @return void
     * @description 修改订单状态
     */
    public void editStatus(Order order);

    /**
     * @param orderitemMap
     * @return void
     * @description 添加订单项
     */
    public void addOrderItem(Map<String, Object> orderitemMap);

    /**
     * @param order
     * @return void
     * @description 更新订单
     */
    public void updateOrder(Order order);

    /**
     * @param map
     * @return java.util.List<com.mi.model.bean.Order>
     * @description 通过map查询订单
     */
    public List<Order> selectOrderByMap(Map<String, Object> map);

    /**
     * @param order
     * @return com.mi.model.bean.Order
     * @description 通过订单Id查询订单
     */
    public Order selectOrder(Order order);

    /**
     * @param map
     * @return java.util.List<com.mi.model.bean.Order>
     * @description 通过小米账户查询该账户的Id
     */
    public List<Order> selectOrderByAccount(Map<String, Object> map);

    /**
     * @param orderId
     * @return java.util.List<java.lang.Integer>
     * @description 获得需要评论的商品
     */
    public List<Integer> getNeedCommentProduct(String orderId);

    /**
     * @param productName
     * @return java.util.List<com.mi.model.bean.Comment>
     * @description 查询指定商品的评论
     */
    public List<Comment> getProductCommentByName(String productName);

    /**
     * @param orderitemId
     * @return java.util.List<com.mi.model.bean.Comment>
     * @description 查询指定订单项的评论
     */
    public Comment getProductCommentByorderItemId(int orderitemId);

    /**
     * @param orderitemId
     * @return java.util.List<com.mi.model.bean.Comment>
     * @description 查询指定订单项的订单
     */
    public Order selectOrderByOrderItemid(int orderitemId);

    /**
     * @param orderId
     * @return int
     * @description 获取所有可修改为已到货状态的订单数量 zkn
     */
    public int selectAllOrdersCounts(@Param("orderId") String orderId);

    /**
     * @param map
     * @return java.util.List<com.mi.model.bean.Order>
     * @description 获取所有可修改为已到货状态的订单集合 zkn
     */
    public List<Order> selectAllOrders(Map<String, Object> map);

    /**
     * @param map
     * @return java.util.List<com.mi.model.bean.Order>
     * @description 获取特定时间段的用户数量 zkn
     */
    public int selectAccountsCount(Map<String, Object> map);

    /**
     * @param map
     * @return java.util.List<com.mi.model.bean.Order>
     * @description 获取特定时间段的订单集合 zkn
     */
    public List<Order> selectOrdersByTime(Map<String, Object> map);

    /**
     * @param commentId
     * @return java.util.List<com.mi.model.bean.Reply>
     * @description 获得商品评价回复
     */
    public List<Reply> getReplyByCommentId(int commentId);

    /**
     * @param reply
     * @return void
     * @description 增加回复
     */
    public void addReply(Reply reply);
}
