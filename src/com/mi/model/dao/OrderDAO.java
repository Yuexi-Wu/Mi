package com.mi.model.dao;

import com.mi.model.bean.Order;
import com.mi.model.bean.OrderItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/18
 * @description 订单DAO
 */
public interface OrderDAO {
    public void addOrder(Map<String, Object> map);

    public void editStatus(Order order);

    public void addOrderItem(Map<String, Object> orderitemMap);

    public void updateOrder(Order order);

    public List<Order> selectOrderByMap(Map<String, Object> map);

    public Order selectOrder(Order order);

    public List<Order> selectOrderByAccount(Map<String, Object> map);

    List<Integer> getNeedCommentProduct(String orderId);


    //获取所有可修改为已到货状态的订单数量 zkn
    public int selectAllOrdersCounts(@Param("orderId") String orderId);
    //获取所有可修改为已到货状态的订单集合 zkn
    public List<Order> selectAllOrders(Map<String, Object> map);
    //获取特定时间段的用户数量
    public int selectAccountsCount(Map<String, Object> map);
    //获取特定时间段的订单集合
    public List<Order> selectOrdersByTime(Map<String, Object> map);
}
