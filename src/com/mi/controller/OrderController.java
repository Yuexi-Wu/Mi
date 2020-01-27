package com.mi.controller;

import com.mi.model.bean.*;
import com.mi.model.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author daiqibin
 * @version 1.4.0
 * @date 2018/8/1
 * @description 订单控制器
 */
@Controller
public class OrderController {
    @Autowired
    private OrderService orderService;

    /**
     * @param receiver
     * @param session
     * @return com.mi.model.bean.Receiver
     * @description 订单生成页面Ajax增加收货地址
     */
    @RequestMapping("orderAddReceiver")
    public @ResponseBody Receiver addReceiver(Receiver receiver, HttpSession session) {

        Account account = (Account) session.getAttribute("account");
        return orderService.addReceiver(receiver, account);
    }

    /**
     * @param receiverId
     * @return com.mi.model.bean.Receiver
     * @description 订单生成界面，收货地址弹窗信息查询
     */
    @RequestMapping("orderFindReceiver")
    public
    @ResponseBody
    Receiver selectReceiverById(int receiverId) {
        return orderService.selectReceiverById(receiverId);
    }

    /**
     * @param receiver
     * @return com.mi.model.bean.Receiver
     * @description 订单生成界面，修改收货地址
     */
    @RequestMapping("orderUpdateReceiver")
    public
    @ResponseBody
    Receiver updateReceiver(Receiver receiver) {
        orderService.updateReceiver(receiver);
        return receiver;
    }

    /**
     * @param order
     * @param session
     * @return java.lang.String
     * @description 生成新订单
     */
    @RequestMapping("addOrder")
    public String addOrder(Order order, HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        Account account = (Account) session.getAttribute("account");
        int accountId = 0;
        if (account != null) {
            accountId = account.getAccountId();
        }

        String newOrderId = orderService.addOrder(order, accountId, cart);
        return "redirect:showOrder.action?orderId=" + newOrderId + "&method=payConfirm";
    }

    /**
     * @param orderId
     * @param model
     * @param method
     * @param session
     * @return java.lang.String
     * @description 支付界面和订单详情界面，查询订单信息
     */
    @RequestMapping("showOrder")
    public String showOrder(String orderId, Model model, String method, HttpSession session) {
        Order order = orderService.selectOrderByOrderId(orderId);
        session.setAttribute("newOrder", order);
        if (method.equals("orderView")) {
            model.addAttribute("originPrice", orderService.getOriginPrice(order));
            return "orderView";
        }
        return "payConfirm";
    }

    /**
     * @param orderId
     * @return java.lang.String
     * @description 取消订单
     */
    @RequestMapping("cancelOrder")
    public @ResponseBody String cancelOrder(String orderId) {
        orderService.cancelOrder(orderId);
        return "true";
    }

    /**
     * @param session
     * @return java.lang.String
     * @description 订单变成已支付状态
     */
    @RequestMapping("payOrder")
    public @ResponseBody String payOrder(HttpSession session) {
        Order order = (Order) session.getAttribute("newOrder");
        orderService.payOrder(order);
        return "true";
    }

    /**
     * @param session
     * @return java.util.List<java.lang.Integer>
     * @description 查询需要评价的商品
     */
    @RequestMapping("getNeedCommentProduct")
    public @ResponseBody List<Integer> getNeedCommentProduct(HttpSession session) {
        Order order = (Order) session.getAttribute("newOrder");
        List<Integer> orderItemIds = orderService.getNeedCommentProduct(order);
        return orderItemIds;
    }


    /**
      * @param orderitemId
      * @param model
     * @return java.lang.String
     * @description 查看个人评价
     */
    @RequestMapping("orderShowComment")
    public String orderShowComment(int orderitemId,Model model){
        model.addAttribute("orderShow",orderService.selectOrderByOrderItemid(orderitemId));
        model.addAttribute("commentShow",orderService.getProductCommentByorderItemId(orderitemId));
        return "showComment";
    }

    /**
     * @return java.util.List<com.mi.model.bean.Product>
     * @description 展示购买成功界面的热销商品
     */
    @RequestMapping("productInHotSale")
    public @ResponseBody List<Product> productInHotSale (){
        return orderService.getProductInHotSale(0,5);
    }

    /**
     * @param session
     * @return java.util.List<com.mi.model.bean.Product>
     * @description 购买成功界面推销商品
     */
    @RequestMapping("productRecommended")
    public @ResponseBody List<Product> productRecommended (HttpSession session){
        Account account = (Account) session.getAttribute("account");
        int accountId = 0;
        if (account != null) {
            accountId = account.getAccountId();
        }
        return orderService.productRecommended(accountId);
    }

    @RequestMapping("getAllOrders")
    @ResponseBody
    public Map<String, Object> getAllOrders(String orderId, String page, String limit){
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", orderService.selectAllOrdersCount(orderId));
        List<Order> orders = orderService.selectAllOrders(orderId, page, limit);
        result.put("data", orders);
        return result;
    }

    @RequestMapping("updateOrderStatus")
    @ResponseBody
    public String updateOrderStatus(String orderId){
        return orderService.updateOrderStatus(orderId);
    }

}
