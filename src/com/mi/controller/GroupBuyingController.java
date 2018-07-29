package com.mi.controller;

import com.mi.model.bean.*;
import com.mi.model.dao.AccountDAO;
import com.mi.model.dao.GroupBuyingProductDAO;
import com.mi.model.dao.NotificationDAO;
import com.mi.model.service.GroupBuyingService;
import com.mi.model.tools.CusMethod;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Alexander on 2018/7/22 下午4:42
 */
@Controller
public class GroupBuyingController {

    @Autowired
    private GroupBuyingService service;
    @Autowired
    private GroupBuyingProductDAO dao;
    @Autowired
    private AccountDAO aDao;
    @Autowired
    private NotificationDAO nDao;

    @RequestMapping("getAllGbs")
    @ResponseBody
    public Map<String, Object> getAllSeckills(String startTime, String endTime, String page, String limit){
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", service.selectAllGbsCount(startTime, endTime));
        List<GroupBuying> gbs = service.selectAllGbs(startTime, endTime, page, limit);
        result.put("data", gbs);
        return result;
    }

    @RequestMapping("deleteGb")
    @ResponseBody
    public String deleteGb(int gbId){
        service.deleteGb(gbId);
        return "success";
    }

    @RequestMapping("addGb")
    @ResponseBody
    public String addGb(HttpServletRequest request) throws ParseException {
        String gbString = request.getParameter("gb");
        String gbpsString = request.getParameter("gbps");
        JSONObject json = JSONObject.fromObject(gbString);
        JSONArray jsonArray = JSONArray.fromObject(gbpsString);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (json.getString("gbName") == null || json.getString("gbName").equals("")){
            return "name";
        }else if (json.getString("gbStart") == null || json.getString("gbStart").equals("")){
            return "start";
        }else if ((sdf.parse(json.getString("gbStart")).getTime() - new Date().getTime()) < 3600){
            return "startWrong";
        }else if (json.getString("gbEnd") == null || json.getString("gbEnd").equals("")){
            return "end";
        }else if ((sdf.parse(json.getString("gbEnd")).getTime() - sdf.parse(json.getString("gbStart")).getTime()) < 18000){
            return "endWrong";
        }else if (jsonArray.size() == 0){
            return "product";
        }
        GroupBuying gb = new GroupBuying();
        gb.setGbId(CusMethod.randomId());
        gb.setGbName(json.getString("gbName"));
        gb.setGbDescription(json.getString("gbDescription"));
        gb.setGbStart(sdf.parse(json.getString("gbStart")));
        gb.setGbEnd(sdf.parse(json.getString("gbEnd")));
        service.addGb(gb);
//        System.out.println(seckill.getSeckillName());
//        System.out.println(seckill.getSeckillDescription());
//        System.out.println(seckill.getSeckillStart());
//        System.out.println(seckill.getSeckillEnd());

        List<GroupBuyingProduct> list = new ArrayList<>();
        for (int i = 0; i < jsonArray.size(); i++){
            GroupBuyingProduct gbp = new GroupBuyingProduct();
            gbp.setGbId(gb.getGbId());
            gbp.setGbpId(CusMethod.randomId());
            gbp.setGbpAmount(Integer.parseInt(jsonArray.getJSONObject(i).getString("gbpAmount")));
            gbp.setGbpPrice(Double.parseDouble(jsonArray.getJSONObject(i).getString("gbpPrice")));
            Product product = new Product();
            product.setProductId(Integer.parseInt(jsonArray.getJSONObject(i).getString("productId")));
            gbp.setProduct(product);
            list.add(gbp);
        }
        dao.addGbps(list);
        List<Integer> accountIds = aDao.selectAllAccountsId();
        List<Notification> notifications = new ArrayList<>();
        String title = gb.getGbName() + "开始！！！";
        String content = gb.getGbDescription();
        for (Integer accountId: accountIds){
            Notification notification = new Notification();
            notification.setNotificationStatus(Notification.NOTIFICATION_STATUS_NEW);
            notification.setNotificationTitle(title);
            notification.setNotificationContent(content);
            notification.setAccountId(accountId);
            notifications.add(notification);
        }
        nDao.addNotifications(notifications);
        return "success";
    }

    @RequestMapping("getGbById")
    public String getGbById(int gbId, Model model){
        GroupBuying gb = service.selectGbById(gbId);
        model.addAttribute("gb", gb);

        return "gbInfo";
    }
}
