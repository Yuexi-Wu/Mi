package com.mi.model.service;

import com.mi.model.bean.*;
//import com.mi.model.dao.CartDAO;
import com.mi.model.dao.OrderDAO;
import com.mi.model.dao.ProductDAO;
//import com.mi.model.dao.ReceiverDAO;
import com.mi.model.tools.CusMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/19
 * @description
 */
@Service
public class OrderService {
    @Autowired
    private OrderDAO orderDAO;
//    @Autowired
//    private ReceiverDAO receiverDAO;
//    @Autowired
//    private CartDAO cartDAO;
    @Autowired
    private ProductDAO productDAO;

//    public String addOrder(Order order, int accountId, List<CartItem> cart) {
//        String orderId = CusMethod.randomStringId();
//        order.setOrderId(orderId);
//        Map<String, Object> map = new HashMap<>();
//        map.put("k_order", order);
//        map.put("k_account", accountId);
//        orderDAO.addOrder(map);
//        Map<String, Object> orderItemMap = new HashMap<>();
//        orderItemMap.put("k_order", order.getOrderId());
//        orderItemMap.put("k_orderitem", null);
//        List<Integer> cartitemIds = new ArrayList<>();
//        for (CartItem cartItem : cart) {
//            OrderItem orderItem = new OrderItem();
//            //第一种赋订单项Id值方式
//            orderItem.setOrderitemId(CusMethod.randomId());
//            //第二种赋订单项Id值方式
//            //orderItem.setOrderitemId(cartItem.getCartitemId());
//            orderItem.setOrderitemPrice(cartItem.getCartitemPrice());
//            orderItem.setOrderitemQuantity(cartItem.getCartitemQuantity());
//            orderItem.setProduct(cartItem.getProduct());
//            orderItemMap.put("k_orderitem", orderItem);
//            orderDAO.addOrderItem(orderItemMap);
//            cartitemIds.add(cartItem.getCartitemId());
//        }
//        cartDAO.deleteCartItem(cartitemIds);
//        return orderId;
//    }
//
//    public Order selectOrderByOrderId(String orderId) {
//        Order order = new Order();
//        order.setOrderId(orderId);
//        Map<String, Object> map = new HashMap<>();
//        map.put("k_order", order);
//        List<Order> orders = orderDAO.selectOrderByMap(map);
//        if (orders.size() == 0)
//            return null;
//        order = orders.get(0);
//        order.countMoney();
//        return order;
//    }
//
//
//    public Receiver addReceiver(Receiver receiver, Account account) {
//        receiver.setReceiverId(CusMethod.randomId());
//        receiver.setAccount(account);
//        if (account == null) {
//            account = new Account();
//            account.setAccountId(1);
//        }
//        receiver.setAccount(account);
//        receiverDAO.addReceiver(receiver);
//        return receiver;
//    }
//
//    public Receiver selectReceiverById(int receiverId) {
//        return receiverDAO.selectReceiverById(receiverId);
//    }
//
//    public void updateReceiver(Receiver receiver) {
//        receiverDAO.updateReceiver(receiver);
//    }
//
//    public void cancelOrder(String orderId){
//        Order order = new Order();
//        order.setOrderId(orderId);
//        order.setOrderStatus(5);
//        orderDAO.editStatus(order);
//    }

    public void payOrder(Order order){
        order.setOrderStatus(2);
        orderDAO.editStatus(order);
        Date date =  new Date();
        order.setOrderPayTime(date);
        orderDAO.updateOrder(order);
        Map<String, Object> map = new HashMap<>();
        for(OrderItem orderItem:order.getItems()){
            map.put("productId",orderItem.getProduct().getProductId());
            map.put("amount",orderItem.getOrderitemQuantity());
            productDAO.updateProductSales(map);
        }
    }

    public double getOriginPrice(Order order) {
        double originPrice = 0;
        for (OrderItem orderItem : order.getItems()) {
            originPrice += orderItem.getProduct().getProductPrice() * orderItem.getOrderitemQuantity();
        }
        return originPrice;
    }

    public List<Integer> getNeedCommentProduct(Order order){
        List<Integer> orderItemIds = orderDAO.getNeedCommentProduct(order.getOrderId());
        return orderItemIds;
    }

    public int selectAllOrdersCount(String orderId) {
        return orderDAO.selectAllOrdersCounts(orderId);
    }

    public List<Order> selectAllOrders(String orderId, String page, String limit) {
        Map<String, Object> map = new HashMap<>();
        if (orderId != null && !orderId.equals("")){
            map.put("orderId", orderId);
        }
        if (page != null && !page.equals("") && limit != null && !limit.equals("")){
            map.put("index", ((Integer.parseInt(page) - 1) * Integer.parseInt(limit)));
            map.put("limit", Integer.parseInt(limit));
        }
        List<Order> orders = orderDAO.selectAllOrders(map);
        for (Order order: orders){
            order.countMoney();
        }
        return orders;
    }

    public String updateOrderStatus(String orderId) {
        Order order = new Order();
        order.setOrderId(orderId);
        order.setOrderStatus(3);
        orderDAO.editStatus(order);
        return "success";
    }
}
