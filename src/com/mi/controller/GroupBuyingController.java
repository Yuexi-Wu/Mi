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
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Alexander on 2018/7/22 下午4:42
 */
@Controller
public class GroupBuyingController {

    @Autowired
    private GroupBuyingService groupBuyingService;
    @Autowired
    private GroupBuyingProductDAO groupBuyingProductDAO;

    @RequestMapping("getAllGbs")
    @ResponseBody
    public Map<String, Object> getAllSeckills(String startTime, String endTime, String page, String limit){
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", groupBuyingService.selectAllGbsCount(startTime, endTime));
        List<GroupBuying> gbs = groupBuyingService.selectAllGbs(startTime, endTime, page, limit);
        result.put("data", gbs);
        return result;
    }

    @RequestMapping("deleteGb")
    @ResponseBody
    public String deleteGb(int gbId){
        groupBuyingService.deleteGb(gbId);
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
        }
        GroupBuying gb = new GroupBuying();
        gb.setGbId(CusMethod.randomId());
        gb.setGbName(json.getString("gbName"));
        gb.setGbDescription(json.getString("gbDescription"));
        gb.setGbStart(sdf.parse(json.getString("gbStart")));
        gb.setGbEnd(sdf.parse(json.getString("gbEnd")));
//        System.out.println(seckill.getSeckillName());
//        System.out.println(seckill.getSeckillDescription());
//        System.out.println(seckill.getSeckillStart());
//        System.out.println(seckill.getSeckillEnd());

        List<GroupBuyingProduct> list = new ArrayList<>();
        for (int i = 0; i < jsonArray.size(); i++){
            String productId = jsonArray.getJSONObject(i).getString("productId");
            String gbpAmount = jsonArray.getJSONObject(i).getString("gbpAmount");
            String gbpPrice = jsonArray.getJSONObject(i).getString("gbpPrice");
            if (productId == null || productId.equals("")){
                return "productId";
            }
            if (gbpAmount == null || gbpAmount.equals("")){
                return "gbpAmount";
            }
            if (gbpPrice == null || gbpPrice.equals("")){
                return "gbpPrice";
            }
            GroupBuyingProduct gbp = new GroupBuyingProduct();
            gbp.setGbId(gb.getGbId());
            gbp.setGbpId(CusMethod.randomId());
            gbp.setGbpAmount(Integer.parseInt(gbpAmount));
            gbp.setGbpPrice(Double.parseDouble(gbpPrice));
            Product product = new Product();
            product.setProductId(Integer.parseInt(productId));
            gbp.setProduct(product);
            list.add(gbp);
        }
        groupBuyingService.addGb(gb);
        groupBuyingProductDAO.addGbps(list);
        return "success";
    }

    @RequestMapping("getGbById")
    public String getGbById(int gbId, Model model){
        GroupBuying gb = groupBuyingService.selectGbById(gbId);
        model.addAttribute("gb", gb);

        return "gbInfo";
    }

    @RequestMapping(value="GroupBuyingController_getGroupActivity.action")
    public String getGroupActivity (HttpServletRequest request){
        GroupBuying gb = null;
        List<GroupBuyingProduct> list = null;
        Date date=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//格式化时间
        String today = df.format(date);
        gb = groupBuyingService.getGroupActivity(today);
        list = groupBuyingService.getGroupProducts((int)gb.getGbId());
        //剩余数量
        Map<Integer, Integer> gbpAmounts = new HashMap<>();
        for (GroupBuyingProduct gbp : list) {
            gbpAmounts.put(gbp.getGbpId(), groupBuyingService.getBoughtGbpNum(gbp.getGbpId()));
        }
        request.setAttribute("gbpAmounts", gbpAmounts);
//        list=gb.getGbProducts();
        System.out.println("list.get(0).getGbId()"+list.get(0).getGbId());
        request.setAttribute("gb",gb);
        request.setAttribute("list",list);
        return "forward:/GroupBuyingMain.jsp";
    }


    @RequestMapping(value="GroupBuyingController_getOneProduct.action")
    public String getOneProduct (HttpServletRequest request){
        int gbp_id = Integer.parseInt((String)request.getParameter("gbp_id"));
        int account_id = Integer.parseInt(request.getParameter("account_id"));
        GroupBuyingProduct gbp = groupBuyingService.getOneGbp(gbp_id);
        ArrayList<Receiver> res = groupBuyingService.getReceivers(account_id);
        System.out.println(res.get(0).getReceiverName());
        request.setAttribute("gbp",gbp);
        request.setAttribute("receivers",res);
        return "forward:/payoff.jsp";
    }

    @RequestMapping(value="GroupBuyingController_addReceiver.action")
    public String addReceiver (HttpServletRequest request){
        int account_id = Integer.parseInt((String)request.getParameter("account_id"));
        String postcode = request.getParameter("postcode");
        String receiver_name = (String)request.getParameter("receiver_name");
        String receiver_phone = (String)request.getParameter("receiver_phone");
        System.out.println("receiver_phone"+receiver_phone);
        String ad_province = (String)request.getParameter("ad_province");
        System.out.println("ad_province"+ad_province);
        String ad_city = (String)request.getParameter("ad_city");
        System.out.println("ad_city"+ad_city);
        String ad_district = (String)request.getParameter("ad_district");
        System.out.println("ad_district"+ad_district);
        String ad_detail = (String)request.getParameter("ad_detail");
        System.out.println("ad_detail"+ad_detail);
        String ad_label = (String)request.getParameter("ad_label");
        Boolean isOK = groupBuyingService.addReceiver(account_id,postcode,receiver_name,receiver_phone,ad_province,ad_city,ad_detail,ad_label,ad_district);
        return "forward:/GroupBuyingController_getOneProduct.action?account_id=" + account_id+"&gbp_id=" + request.getParameter("gbp_id");
    }

    //    @RequestMapping(value="GroupBuyingController_addGroupOrder.action")
//    public String addGroupOrder (HttpServletRequest request){
//        int product_id = Integer.parseInt((String)request.getParameter("product_id"));
//        String order_id=(String)request.getParameter("order_id");
//        Boolean isOK = service.addGroupOrder(order_id,product_id);
//    }
    @RequestMapping(value = "GroupBuyingController_addOrder.action")
    public String addOrder(HttpServletRequest request, HttpSession session){
        int accountId = Integer.parseInt(request.getParameter("accountId"));
        int receiverId=Integer.parseInt(request.getParameter("receiverId"));
        int orderDeliverTime= Integer.parseInt(request.getParameter("orderDeliverTime"));
        int productId=Integer.parseInt(request.getParameter("productId"));
        double gbpPrice=Double.parseDouble(request.getParameter("gbpPrice"));


        String orderId=groupBuyingService.addOrder(accountId,receiverId,orderDeliverTime,productId,gbpPrice);
        return "forward:/showOrder.action?method=orderView&orderId="+orderId;
    }

    /**
     * get latest group buying activity
     * @return latest group buying activity
     * @author huang jiarui
     * @version 1.2
     */
    @RequestMapping("/groupBuyingController/getLatestGroupBuying.action")
    @ResponseBody
    public GroupBuying getLatestGroupBuying(){
        GroupBuying groupBuyingResult = groupBuyingService.getLatestGroupBuying();
        return groupBuyingResult;

    }


    /**
     * get current time of server
     * @return the milliseconds between 1970/1/1 0:0 and current time of server
     * @author huang jiarui
     * @version 1.1
     */
    @RequestMapping("/groupBuyingController/getServerTime.action")
    @ResponseBody
    public Long getServerTime(){

        return new Date().getTime();

    }
}
