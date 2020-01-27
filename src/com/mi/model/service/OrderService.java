package com.mi.model.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.mi.model.bean.*;
import com.mi.model.dao.CartDAO;
import com.mi.model.dao.OrderDAO;
import com.mi.model.dao.ProductDAO;
import com.mi.model.dao.ReceiverDAO;
import com.mi.model.tools.CusMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author daiqibin
 * @version 1.4.0
 * @date 2018/8/1
 * @description 订单Service
 */
@Service
public class OrderService {
    @Autowired
    private OrderDAO orderDAO;
    @Autowired
    private ReceiverDAO receiverDAO;
    @Autowired
    private CartDAO cartDAO;
    @Autowired
    private ProductDAO productDAO;

    /**
     * @param order
     * @param accountId
     * @param cart
     * @return java.lang.String
     * @description 添加新订单
     */
    public String addOrder(Order order, int accountId, List<CartItem> cart) {
        String orderId = CusMethod.randomStringId();
        order.setOrderId(orderId);
        Map<String, Object> map = new HashMap<>();
        map.put("k_order", order);
        map.put("k_account", accountId);
        //添加订单信息
        orderDAO.addOrder(map);
        Map<String, Object> orderItemMap = new HashMap<>();
        orderItemMap.put("k_order", order.getOrderId());
        orderItemMap.put("k_orderitem", null);
        List<Integer> cartitemIds = new ArrayList<>();
        for (CartItem cartItem : cart) {
            OrderItem orderItem = new OrderItem();
            //第一种赋订单项Id值方式
            orderItem.setOrderitemId(CusMethod.randomId());
            //第二种赋订单项Id值方式
            //orderItem.setOrderitemId(cartItem.getCartitemId());
            orderItem.setOrderitemPrice(cartItem.getCartitemPrice());
            orderItem.setOrderitemQuantity(cartItem.getCartitemQuantity());
            orderItem.setProduct(cartItem.getProduct());
            orderItemMap.put("k_orderitem", orderItem);
            //添加订单项信息
            orderDAO.addOrderItem(orderItemMap);
            cartitemIds.add(cartItem.getCartitemId());
        }
        cartDAO.deleteCartItem(cartitemIds);
        return orderId;
    }

    /**
     * @param orderId
     * @return com.mi.model.bean.Order
     * @description 通过订单Id查询订单
     */
    public Order selectOrderByOrderId(String orderId) {
        Order order = new Order();
        order.setOrderId(orderId);
        Map<String, Object> map = new HashMap<>();
        map.put("k_order", order);
        List<Order> orders = orderDAO.selectOrderByMap(map);
        if (orders.size() == 0)
            return null;
        order = orders.get(0);
        order.countMoney();
        return order;
    }

    /**
     * @param receiver
     * @param account
     * @return com.mi.model.bean.Receiver
     * @description 添加新收货地址
     */
    public Receiver addReceiver(Receiver receiver, Account account) {
        receiver.setReceiverId(CusMethod.randomId());
        if (account == null) {
            account = new Account();
            account.setAccountId(1);
        }
        receiver.setAccount(account);
        receiverDAO.addReceiver(receiver);
        return receiver;
    }

    /**
     * @param receiverId
     * @return com.mi.model.bean.Receiver
     * @description 通过收货地址Id查询收货地址
     */
    public Receiver selectReceiverById(int receiverId) {
        return receiverDAO.selectReceiverById(receiverId);
    }

    /**
     * @param receiver
     * @return void
     * @description 更新收货地址信息
     */
    public void updateReceiver(Receiver receiver) {
        receiverDAO.updateReceiver(receiver);
    }

    /**
     * @param orderId
     * @return void
     * @description 取消订单
     */
    public void cancelOrder(String orderId) {
        Order order = new Order();
        order.setOrderId(orderId);
        order.setOrderStatus(5);
        orderDAO.editStatus(order);
    }

    /**
     * @param order
     * @return void
     * @description 将订单从未支付变成已支付
     */
    public void payOrder(Order order) {
        order.setOrderStatus(2);
        orderDAO.editStatus(order);
        Date date = new Date();
        order.setOrderPayTime(date);
        orderDAO.updateOrder(order);
        Map<String, Object> map = new HashMap<>();
        for (OrderItem orderItem : order.getItems()) {
            map.put("productId", orderItem.getProduct().getProductId());
            map.put("amount", orderItem.getOrderitemQuantity());
            productDAO.updateProductSales(map);
        }
    }

    /**
     * @param order
     * @return double
     * @description 获得订单商品原价
     */
    public double getOriginPrice(Order order) {
        double originPrice = 0;
        for (OrderItem orderItem : order.getItems()) {
            originPrice += orderItem.getProduct().getProductPrice() * orderItem.getOrderitemQuantity();
        }
        return originPrice;
    }

    /**
     * @param order
     * @return java.util.List<java.lang.Integer>
     * @description 查询需要评论的商品
     */
    public List<Integer> getNeedCommentProduct(Order order) {
        List<Integer> orderItemIds = orderDAO.getNeedCommentProduct(order.getOrderId());
        return orderItemIds;
    }

    /**
     * @param OrderItemid
     * @return com.mi.model.bean.Comment
     * @description 通过商品项Id查询评论
     */
    public Comment getProductCommentByorderItemId(int OrderItemid) {
        return orderDAO.getProductCommentByorderItemId(OrderItemid);
    }

    /**
     * @param orderitemId
     * @return java.util.List<com.mi.model.bean.Comment>
     * @description 查询指定订单项的订单
     */
    public Order selectOrderByOrderItemid(int orderitemId) {
        return orderDAO.selectOrderByOrderItemid(orderitemId);
    }

    /**
     * @return java.util.List<com.mi.model.bean.Product>
     * @description 获得热销商品（根据订单项的数量）
     */
    public List<Product> getProductInHotSale(int fc, int pageSize) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Calendar c = Calendar.getInstance();
        String nowTime = format.format(new Date());
        c.setTime(new Date());
        c.add(Calendar.MONTH, -1);
        Date past = c.getTime();
        String pastTime = format.format(past);
        Map<String, Object> map = new HashMap<>();
        map.put("k_nowTime", nowTime);
        map.put("k_pastTime", pastTime);
        if (fc != 0)
            map.put("k_fc", fc);
        Page<Product> products = PageHelper.startPage(1, pageSize);
        productDAO.getProductInHotSale(map);
        for (Product product : products) {
            Product lowProduct = productDAO.getLowestPrice(product.getProductName()).get(0);
            product.setProductId(lowProduct.getProductId());
            product.setProductPrice(lowProduct.getProductPrice());
            product.setProductColor(lowProduct.getProductColor());
            product.setProductVersion(lowProduct.getProductVersion());
            product.setProductSize(lowProduct.getProductSize());
            product.setProductUrl(lowProduct.getProductUrl());
        }
        return products;
    }


    /**
     * @param accountId
     * @return java.util.List<com.mi.model.bean.Product>
     * @description 购买完成页面获得推荐商品
     */
    public List<Product> productRecommended(int accountId) {
        List<CartItem> cart = cartDAO.selectCartItemByAccount(accountId);
        int quantity = (int) Math.ceil(5.0 / cart.size());
        List<Product> products = new ArrayList<>();
        for (int i = 0; i < cart.size() && i < 5; i++) {
            int fc = productDAO.selectFcByProductId(cart.get(i).getProduct().getProductId());
            products.addAll(getProductInHotSale(fc, quantity));
        }
        return products;
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
        order.setOrderReachTime(new Date());
        orderDAO.updateOrder(order);
        return "success";
    }

}
