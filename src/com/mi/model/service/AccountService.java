package com.mi.model.service;

import com.mi.model.bean.*;
import com.mi.model.dao.AccountDAO;
import com.mi.model.dao.NotificationDAO;
import com.mi.model.dao.OrderDAO;
import com.mi.model.tools.CusMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AccountService {
    @Autowired
    private AccountDAO accountDAO;
    @Autowired
    private NotificationDAO notificationDAO;
    @Autowired
    private OrderDAO orderDAO;


    /*添加到我的喜欢*/
    public Integer addToFavorite(FavouriteItem favouriteItem, String accountId) {
        Integer favoriteId = CusMethod.randomId();
        favouriteItem.setFavourId(favoriteId);
        Map<String,Object> map = new HashMap<>();
        map.put("k_favouriteItem",favouriteItem);
        map.put("k_account",accountId);
        accountDAO.addToFavorite(map);
        return favoriteId;
    }
    public boolean findPassword(String password, int accountId){
        Account account = new Account();
        account.setAccountId(accountId);
        account.setPassword(password);
        Account a = accountDAO.verifyPassword(account);
        if(a==null){
            return false;
        }else {
            return true;
        }
    }

    public Account findAccount(String telephone, String accountName, String email,String password){
        Account account = new Account();
        if(telephone !=null && !"".equals(telephone)){
            account.setTelephone(telephone);
        }
        if(accountName !=null && !"".equals(accountName)){
            account.setAccountName(accountName);
        }
        if(email !=null && !"".equals(email)){
            account.setEmail(email);
        }
        account.setPassword(password);
        Account a = accountDAO.validateAccount(account);
        return a;
    }

    public List<FavouriteItem> getFavourite(int accountId){
        List<FavouriteItem> items = accountDAO.checkFavouriteById(accountId);
        return items;
    }

    public void saveAccount(Account account){
        accountDAO.registAccount(account);
    }

    public void updatePassword(Account account){
        accountDAO.updatePassword(account);
    }

    public void updateAccountInfo(Account account){
        accountDAO.updateAccountInfo(account);
    }

    public void updateEmail(int accountId, String email){
        Account account = accountDAO.getAccountById(accountId);
        account.setEmail(email);
        accountDAO.updateEmail(account);
    }

    public void deleteFavourite(int favourId){
        accountDAO.deleteFavourite(favourId);
    }

    public boolean findTelephone(String telephone){
        String tel = accountDAO.findTelephone(telephone);
        if(tel==null || tel.equals("")){
            return false;
        }else{
            return true;
        }
    }

    public boolean findEmail(String email){
        String e = accountDAO.findEmail(email);
        if(e==null || e.equals("")){
            return false;
        }else {
            return true;
        }
    }

    public boolean findAccountName(String accountName){
        String name = accountDAO.findAccountName(accountName);
        if(name==null||name.equals("")){
            return false;
        }else {
            return true;
        }
    }

    public boolean findExistAccountName(String accountName){
        String name = accountDAO.validateAccountName(accountName);
        String telephone = accountDAO.validateNameAndPhone(accountName);
        String email = accountDAO.validateNameAndEmail(accountName);
        if (name != null || telephone !=null || email !=null){
            return false;
        }else {
            return true;
        }
    }

    public List<Notification> getNotification(int accountId){
        return notificationDAO.getAllNotes(accountId);
    }

    public List<Order> getAllOrders(int accountId){

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("k_account",accountId);
        Order order = new Order();
        order.setOrderType(1);
        map.put("k_order",order);
        List<Order> orders = orderDAO.selectOrderByMap(map);
        return orderDAO.selectOrderByAccount(map);
    }

    public List<Order> getOrderByStatus(int accountId, int status){
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("k_account",accountId);
        Order order = new Order();
        order.setOrderType(1);
        order.setOrderStatus(status);
        map.put("k_order",order);
        return orderDAO.selectOrderByMap(map);
    }

    public List<Order> getAllGroupOrders(int accountId){

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("k_account",accountId);
        Order order = new Order();
        order.setOrderType(3);
        map.put("k_order",order);
        return orderDAO.selectOrderByMap(map);
    }

    public List<Order> getGroupOrderByStatus(int accountId, int status){
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("k_account",accountId);
        Order order = new Order();
        order.setOrderType(3);
        order.setOrderStatus(status);
        map.put("k_order",order);
        return orderDAO.selectOrderByMap(map);
    }

    public List<Order> selectOrdersByKey(int accountId, String proId, String productName, String orderId, int orderStatus){
        Map<String,Object> map = new HashMap<String,Object>();
        Order order = new Order();
        Product product = new Product();
        int productId = 0;
        if(!"".equals(proId) && proId!=null){
            productId = Integer.parseInt(proId);
            product.setProductId(productId);
            map.put("k_product",product);
        }
        if (productName!=null && !"".equals(productName)){
            product.setProductName(productName);
            map.put("k_product",product);
        }
        if (orderId!=null && !"".equals(orderId)){
            order.setOrderId(orderId);
            if(orderStatus!=0){
                order.setOrderStatus(orderStatus);
            }
            map.put("k_order",order);
        }
        map.put("k_account",accountId);
        return orderDAO.selectOrderByMap(map);
    }

    public void insertConfidentiality(Confiditiality confiditiality){
        accountDAO.addConfiditiality(confiditiality);
    }

    public Account getAccountById(int accountId){
        return accountDAO.getAccountById(accountId);
    }

    public int insertTelephone(String telephone){
        CusMethod cusMethod = new CusMethod();
        int accountId = cusMethod.randomId();
        Account account = new Account();
        account.setTelephone(telephone);
        account.setAccountId(accountId);
        accountDAO.addTelephone(account);
        return accountId;
    }

    public void updateNamePass(Account account){
        accountDAO.addAccount(account);
    }

    public void updatePerson(Account account){
        accountDAO.addInfo(account);
    }

    public void updateAvatar(Account account){
        accountDAO.addAvatar(account);
    }

    public void updateAlAvatar(Account account){
        accountDAO.updateAvatar(account);
    }

    public int getPayingNum(int accountId){
        return accountDAO.getPayingNum(accountId);
    }

    public int getShippingNum(int accountId){
        return accountDAO.getShippingNum(accountId);
    }

    public int getUncommentedNum(int accountId){
        return accountDAO.getUncommentedNum(accountId);
    }

    public void updateNotificationStatus(Notification notification){
        notificationDAO.updateNotificationStatus(notification);
    }

    public List<Notification> getReadNotes(int accountId){
        return notificationDAO.getReadNotes(accountId);
    }

    public List<Notification> getUnreadNotes(int accountId){
        return notificationDAO.getUnreadNotes(accountId);
    }

    public  Notification getNotificationById(int notificationId){
        return notificationDAO.getNotificationById(notificationId);
    }

    public Account getAccountByName(Account account){
        return accountDAO.findAccountByName(account);
    }

    public void addFirstNotification(int accountId){
        notificationDAO.addFirstNotification(accountId);
    }

    /**
     * get all account id from small to large
     * @return the sorted list of account id
     * @author huang jiarui
     * @version 1.0
     */
    public List<Integer> getAllSortedAccountId(){
        return accountDAO.getAllSortedAccountId();
    }
    /*从我的喜欢中移除*/
    public void cancelFavorite(Integer favoriteId) {
        accountDAO.deleteFavourite(favoriteId);
    }
}
