package com.mi.model.service;

import com.mi.model.bean.*;
import com.mi.model.dao.*;
import com.mi.model.tools.CusMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by Alexander on 2018/7/22 下午4:44
 */
@Service
public class GroupBuyingService {

    @Autowired
    private GroupBuyingDAO groupBuyingDAO;
    @Autowired
    private AccountDAO accountDAO;
    @Autowired
    private OrderDAO orderDAO;
    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private NotificationDAO notificationDAO;

    public List<GroupBuying> selectAllGbs(String startTime, String endTime, String page, String limit){
        Map<String, Object> map = new HashMap<>();
        if (startTime != null && !startTime.equals("")){
            map.put("startTime", startTime);
        }
        if (endTime != null && !endTime.equals("")){
            map.put("endTime", endTime);
        }
        if (page != null && !page.equals("") && limit != null && !limit.equals("")){
            map.put("index", ((Integer.parseInt(page) - 1) * Integer.parseInt(limit)));
            map.put("limit", Integer.parseInt(limit));
        }
        return groupBuyingDAO.selectAllGbs(map);
    }

    public int selectAllGbsCount(String startTime, String endTime){
        Map<String, Object> map = new HashMap<>();
        if (startTime != null && !startTime.equals("")){
            map.put("startTime", startTime);
        }
        if (endTime != null && !endTime.equals("")){
            map.put("endTime", endTime);
        }
        return groupBuyingDAO.selectAllGbsCount(map);
    }

    public void deleteGb(int gbId){
        groupBuyingDAO.deleteGb(gbId);
    }

    public void addGb(GroupBuying gb) {
        groupBuyingDAO.addGb(gb);

        List<Integer> accountIds = accountDAO.selectAllAccountsId();
        List<Notification> notifications = new ArrayList<>();
        String title = gb.getGbName() + "开始！！！";
        String content = gb.getGbDescription();
        if (accountIds.size() > 0){
            for (Integer accountId: accountIds){
                Notification notification = new Notification();
                notification.setNotificationStatus(Notification.NOTIFICATION_STATUS_NEW);
                notification.setNotificationTitle(title);
                notification.setNotificationContent(content);
                notification.setAccountId(accountId);
                notifications.add(notification);
            }
            notificationDAO.addNotifications(notifications);
        }
    }

    public GroupBuying selectGbById(int gbId) {
        return groupBuyingDAO.selectGbById(gbId);
    }

    public GroupBuying getGroupActivity(String today) {
        GroupBuying gb = null;
        try {
            gb = groupBuyingDAO.getGroupActivity(today);
        } catch (Exception e) {
            e.printStackTrace();
        }
//        SqlSession sqlSession = SqlSessionUtil.getSession();
//        GroupBuyingDAO mapper = sqlSession.getMapper(GroupBuyingDAO.class);
//        try {
//            gb = mapper.getGroupActivity(today);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }finally {
//            sqlSession.close();
//        }
        return gb;
    }

    public ArrayList<GroupBuyingProduct> getGroupProducts(int gbId) {
        ArrayList<GroupBuyingProduct> list = null;
        try {
            list = groupBuyingDAO.getGroupProducts(gbId);
        } catch (Exception e) {
            e.printStackTrace();
        }
//        SqlSession sqlSession = SqlSessionUtil.getSession();
//        GroupBuyingDAO mapper = sqlSession.getMapper(GroupBuyingDAO.class);
//        try {
//            list = mapper.getGroupProducts(gbId);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }finally {
//            sqlSession.close();
//        }
        return list;
    }

    public GroupBuyingProduct getOneGbp(int gbp_id) {

        return groupBuyingDAO.getOneGbp(gbp_id);
    }

    public ArrayList<Receiver> getReceivers(int account_id) {
        ArrayList<Receiver> list = null;
        try {
            list = groupBuyingDAO.getReceivers(account_id);
        } catch (Exception e) {
            e.printStackTrace();
        }
//        SqlSession sqlSession = SqlSessionUtil.getSession();
//        GroupBuyingDAO mapper = sqlSession.getMapper(GroupBuyingDAO.class);
//        try {
//            list = mapper.getReceivers(account_id);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }finally {
//            sqlSession.close();
//        }
        return list;
    }

    public Boolean addReceiver(int account_id, String postcode, String receiver_name, String receiver_phone, String ad_province, String ad_city, String ad_detail, String ad_label, String ad_district) {
        int receiver_id=CusMethod.randomId();
        Boolean isOk = groupBuyingDAO.addReceiver(receiver_id,account_id,postcode,receiver_name,receiver_phone,ad_province,ad_city,ad_detail,ad_label,ad_district);
        //SqlSession sqlSession = SqlSessionUtil.getSession();
//        GroupBuyingDAO mapper = sqlSession.getMapper(GroupBuyingDAO.class);
//        try {
//            isOk = mapper.addReceiver(account_id,postcode,receiver_name,receiver_phone,ad_province,ad_city,ad_detail,ad_label);
//            sqlSession.commit();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }finally {
//            sqlSession.close();
//        }
        return isOk;
    }


    public Boolean addGroupOrder(String order_id,int product_id) {
        Boolean isOk = false;
        try {
            String random = CusMethod.randomStringId();
            Order order=new Order();
            order.setOrderId(random);
            isOk = groupBuyingDAO.addGroupOrder(order_id, new Date(), product_id);


//            dao.addOrder(random,account_id,receiver_id,order_type,order_deliver_time);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isOk;
    }
    public  String addOrder(int accountId,int receiverId,int orderDeliverTime,int productId,double gbpPrice) {
        String orderId = CusMethod.randomStringId();
        Integer orderStatus=null;
        Order order=new Order();
        order.setOrderId(orderId);
        order.setOrderStatus(2);
        //插入accountId
        order.setReceiver(new Receiver());
        order.getReceiver().setReceiverId(receiverId);
        order.setOrderType(3);
        order.setOrderDeliverTime(orderDeliverTime);

        //添加订单信息
        Map<String, Object> orderMap = new HashMap<>();
        orderMap.put("k_order", order);
        orderMap.put("k_account", accountId);
        orderDAO.addOrder(orderMap);
//        Notification notification=new Notification();
//        notificationdao.addSingleNotification(notification);
//        Order orderUpdate = new Order();
//        orderUpdate.setOrderId(orderId);
//        orderUpdate.setOrderGenerationTime(new Date());
//        orderdao.updateOrder(orderUpdate);

        addNotification(accountId, productDAO.selectProductById(productId), "付款成功");

        OrderItem orderItem = new OrderItem();
        orderItem.setOrderitemId(CusMethod.randomId());
        orderItem.setOrderitemPrice(gbpPrice);
        orderItem.setOrderitemQuantity(1);
        orderItem.setProduct(new Product()); orderItem.getProduct().setProductId(productId);
        Map<String,Object> orderItemMap = new HashMap<>();
        orderItemMap.put("k_orderitem", orderItem);
        orderItemMap.put("k_order", order.getOrderId());
        orderDAO.addOrderItem(orderItemMap);

        groupBuyingDAO.addGroupOrder(order.getOrderId(), new Date(),
                productId);
//
        List<String> orderIds = groupBuyingDAO.getGroupOrderIds(productId);
        if (orderIds.size() % 5 == 0 && orderIds.size() != 0) {
            for (String gbSuccessOrderId : orderIds) {
                //封装要改动的status和orderpaytime同id一起封装在对象里。
                Order gbSuccessOrder = new Order();
                gbSuccessOrder.setOrderId(gbSuccessOrderId);
                gbSuccessOrder.setOrderStatus(6);
                gbSuccessOrder.setOrderPayTime(new Date());
                orderDAO.editStatus(gbSuccessOrder);
                orderDAO.updateOrder(gbSuccessOrder);
                addNotification(groupBuyingDAO.getAccountIdByOrderId(gbSuccessOrderId), productDAO.selectProductById(productId), "拼团成功");
            }
        }
        return orderId;
    }

    public int getBoughtGbpNum(int gbpId) {return groupBuyingDAO.getBoughtGbpNum(gbpId); }

    private void addNotification(int accountId, Product product, String gbStatus){
        Notification notification = new Notification();
        notification.setAccountId(accountId);
        notification.setNotificationStatus(0);
        //以下的product_id更改为查找出product并且输出product_name
        notification.setNotificationTitle("团购通知");
        notification.setNotificationContent("拼团购买" + product.getProductName() + gbStatus);
        notificationDAO.addSingleNotification(notification);
    }

    /**
     * get latest group buying activity
     * @return latest group buying activity
     * @author huang jiarui
     * @version 1.0
     */
    public GroupBuying getLatestGroupBuying() {
        return groupBuyingDAO.getLatestGroupBuying();
    }
}
