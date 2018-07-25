package com.mi.controller;

import com.mi.model.bean.*;
import com.mi.model.dao.GroupBuyingProductDAO;
import com.mi.model.service.GroupBuyingService;
import com.mi.model.tools.CusMethod;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 下午4:42
 */
@Controller
public class GroupBuyingController {

    @Autowired
    private GroupBuyingService service;
    @Autowired
    private GroupBuyingProductDAO dao;

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
        if (json.getString("gbName") == null || json.getString("gbName").equals("")){
            return "name";
        }else if (json.getString("gbStart") == null || json.getString("gbStart").equals("")){
            return "start";
        }else if (json.getString("gbEnd") == null || json.getString("gbEnd").equals("")){
            return "end";
        }
        GroupBuying gb = new GroupBuying();
        gb.setGbId(CusMethod.randomId());
        gb.setGbName(json.getString("gbName"));
        gb.setGbDescription(json.getString("gbDescription"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        gb.setGbStart(sdf.parse(json.getString("gbStart")));
        gb.setGbEnd(sdf.parse(json.getString("gbEnd")));
        service.addGb(gb);
//        System.out.println(seckill.getSeckillName());
//        System.out.println(seckill.getSeckillDescription());
//        System.out.println(seckill.getSeckillStart());
//        System.out.println(seckill.getSeckillEnd());
        JSONArray jsonArray = JSONArray.fromObject(gbpsString);
        List<GroupBuyingProduct> list = new ArrayList<>();
        for (int i = 0; i < jsonArray.size(); i++){
            GroupBuyingProduct gbp = new GroupBuyingProduct();
            gbp.setGbId(gb.getGbId());
            gbp.setGbpAmount(Integer.parseInt(jsonArray.getJSONObject(i).getString("gbpAmount")));
            gbp.setGbpPrice(Double.parseDouble(jsonArray.getJSONObject(i).getString("gbpPrice")));
            Product product = new Product();
            product.setProductId(Integer.parseInt(jsonArray.getJSONObject(i).getString("productId")));
            gbp.setProduct(product);
            list.add(gbp);
        }
        dao.addGbps(list);
        return "success";
    }
}
