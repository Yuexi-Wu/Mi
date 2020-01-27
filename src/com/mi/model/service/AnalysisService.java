package com.mi.model.service;

import com.mi.model.bean.Order;
import com.mi.model.bean.PieData;
import com.mi.model.bean.Product;
import com.mi.model.bean.SecondClassification;
import com.mi.model.dao.AccountDAO;
import com.mi.model.dao.OrderDAO;
import com.mi.model.dao.ProductDAO;
import com.mi.model.dao.SecondClassificationDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Alexander on 2018/7/26 下午3:52
 */
@Service
public class AnalysisService {
    @Autowired
    private ProductDAO pDao;
    @Autowired
    private AccountDAO aDao;
    @Autowired
    private OrderDAO oDao;
    @Autowired
    private SecondClassificationDAO scDao;

    //获取所有二级分类所含商品数
    public List<PieData> getScComposition() {
        List<PieData> pieData = new ArrayList<>();
        Map<String, Object> scMap = new HashMap<>();
        scMap.put("index", 0);
        scMap.put("limit", 1000);
        List<SecondClassification> scs = scDao.selectAllScs(scMap);
        for (SecondClassification sc: scs){
            PieData data = new PieData();
            data.setName(sc.getScName());
            Map<String, Object> pMap = new HashMap<>();
            pMap.put("scId", sc.getScId());
            data.setValue(pDao.selectAllProductsCount(pMap));
            pieData.add(data);
        }
        return pieData;
    }

    //获取商品按照销量排行的前十个商品
    public Map<String, Object> getProductSale() {
        Map<String, Integer> map = new HashMap<>();
        map.put("index", 0);
        map.put("limit", 10);
        List<Product> products = pDao.getProductsOrderedBySale(map);
        List<String> names = new ArrayList<>();
        List<Integer> values = new ArrayList<>();
        for (Product p: products){
            String name = p.getProductName();
            if (p.getProductColor() != null && !p.getProductColor().equals("")){
                name = name + " " + p.getProductColor();
            }
            if (p.getProductVersion() != null && !p.getProductVersion().equals("")){
                name = name + " " + p.getProductVersion();
            }
            if (p.getProductSize() != null && !p.getProductSize().equals("")){
                name = name + " " + p.getProductSize();
            }
            names.add(name);
            values.add(p.getProductSales());
        }
        Map<String, Object> data = new HashMap<>();
        data.put("name", names);
        data.put("value", values);
        return data;
    }

    //获取总销售量和本周销售量，总用户数和本周活跃用户数
    public Map<String,Object> getPanelData() {
        Map<String,Object> result = new HashMap<>();
        result.put("accountTotal", aDao.getAllAccountsCount());
        double totalMoney = 0;
        List<Order> allOrders = oDao.selectOrderByMap(new HashMap<>());
        for (Order order: allOrders){
            order.countMoney();
            totalMoney += order.getTotal();
        }
        result.put("totalMoney", totalMoney);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Map<String,Object> map = new HashMap<>();
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        map.put("k_startTime", sdf.format(cal.getTime()));
        map.put("k_finishTime", sdf.format(new Date()));
        List<Order> weekOrders = oDao.selectOrderByMap(map);
        double weekMoney = 0;
        for (Order order: weekOrders){
            order.countMoney();
            weekMoney += order.getTotal();
        }
        result.put("weekMoney", weekMoney);
        int accountWeek = oDao.selectAccountsCount(map);
        result.put("accountWeek", accountWeek);
        return result;
    }

    public Map<String,Object> getOrderMoney() {
        Map<String,Object> result = new HashMap<>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        List<String> names = new ArrayList<>();
        List<Double> values = new ArrayList<>();
        for (int i = 5; i >= 0; i--){
            Map<String, Object> map = new HashMap<>();
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.MONTH, -i);
            cal.set(Calendar.DAY_OF_MONTH, 0);
            cal.set(Calendar.HOUR_OF_DAY, 23);
            cal.set(Calendar.MINUTE, 59);
            cal.set(Calendar.SECOND, 59);
            map.put("k_finishTime", sdf.format(cal.getTime()));
            cal.set(Calendar.DAY_OF_MONTH,1);
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            map.put("k_startTime", sdf.format(cal.getTime()));
            names.add((cal.get(Calendar.MONTH) + 1) + "月");
            double money = 0;
            List<Order> orders = oDao.selectOrdersByTime(map);
            for (Order order: orders){
                System.out.println(order.getOrderId() +"++++++++++++++++");
                order.countMoney();
                money += order.getTotal();
            }
            values.add(money);
        }
        result.put("name", names);
        result.put("value", values);
        for (String name: names){
            System.out.println(name + "---------------------------");
        }
        for (double value: values){
            System.out.println(value + "---------------------------");
        }
        return result;
    }
}
