package com.mi.controller;

import com.mi.model.bean.*;
import com.mi.model.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/19
 * @description
 */
@Controller
public class OrderController {
    @Autowired
    private OrderService orderService;

//    @RequestMapping("orderAddReceiver")
//    public @ResponseBody Receiver addReceiver(Receiver receiver, HttpSession session){
//        Account account = (Account) session.getAttribute("account");
//        return orderService.addReceiver(receiver,account);
//    }
//
//    @RequestMapping("orderFindReceiver")
//    public @ResponseBody Receiver selectReceiverById(int receiverId){
//        return orderService.selectReceiverById(receiverId);
//    }
//
//    @RequestMapping("orderUpdateReceiver")
//    public @ResponseBody Receiver updateReceiver(Receiver receiver){
//        orderService.updateReceiver(receiver);
//        return receiver;
//    }
//
//    @RequestMapping("addOrder")
//    public String addOrder(Order order,HttpSession session){
//        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
//        Account account = (Account) session.getAttribute("account");
//        int accountId = 1;
//        if (account != null) {
//            accountId = account.getAccountId();
//        }
//        String newOrderId = orderService.addOrder(order,accountId,cart);
//        return "redirect:showOrder.action?orderId=" + newOrderId + "&method=payConfirm";
//    }
//
//    @RequestMapping("showOrder")
//    public String showOrder(String orderId,Model model,String method,HttpSession session){
//        Order order = orderService.selectOrderByOrderId(orderId);
//        session.setAttribute("newOrder",order);
//        if(method.equals("orderView")) {
//            model.addAttribute("originPrice",orderService.getOriginPrice(order));
//            return "orderView";
//        }
//        return "payConfirm";
//    }
//
//    @RequestMapping("cancelOrder")
//    public @ResponseBody String cancelOrder(String orderId){
//        orderService.cancelOrder(orderId);
//        return "true";
//    }
//
//    @RequestMapping("payOrder")
//    public @ResponseBody String payOrder(HttpSession session){
//        Order order =  (Order)session.getAttribute("newOrder");
//        orderService.payOrder(order);
//        return "true";
//    }
//
//    @RequestMapping("getNeedCommentProduct")
//    public @ResponseBody List<Integer> getNeedCommentProduct(HttpSession session){
//        Order order =  (Order)session.getAttribute("newOrder");
//        List<Integer> orderItemIds = orderService.getNeedCommentProduct(order);
//        return orderItemIds;
//    }

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
