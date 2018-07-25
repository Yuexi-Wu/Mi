package com.mi.controller;

import com.mi.model.bean.Product;
import com.mi.model.bean.Seckill;
import com.mi.model.bean.SeckillProduct;
import com.mi.model.dao.SeckillProductDAO;
import com.mi.model.service.SeckillService;
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
 * Created by Alexander on 2018/7/22 下午2:03
 */
@Controller
public class SeckillController {

    @Autowired
    private SeckillService service;
    @Autowired
    private SeckillProductDAO dao;

    @RequestMapping("getAllSeckills")
    @ResponseBody
    public Map<String, Object> getAllSeckills(String startTime, String endTime, String page, String limit){
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", service.selectAllSeckillsCount(startTime, endTime));
        List<Seckill> seckills = service.selectAllSeckills(startTime, endTime, page, limit);
        result.put("data", seckills);
        return result;
    }

    @RequestMapping("deleteSeckill")
    @ResponseBody
    public String deleteSeckill(int seckillId){
        service.deleteSeckill(seckillId);
        return "success";
    }

    @RequestMapping("addSeckill")
    @ResponseBody
    public String addSeckill(HttpServletRequest request) throws ParseException {
        String seckillString = request.getParameter("seckill");
        String spsString = request.getParameter("sps");
        JSONObject json = JSONObject.fromObject(seckillString);
        if (json.getString("seckillName") == null || json.getString("seckillName").equals("")){
            return "name";
        }else if (json.getString("seckillStart") == null || json.getString("seckillStart").equals("")){
            return "start";
        }else if (json.getString("seckillEnd") == null || json.getString("seckillEnd").equals("")){
            return "end";
        }
        Seckill seckill = new Seckill();
        seckill.setSeckillId(CusMethod.randomId());
        seckill.setSeckillName(json.getString("seckillName"));
        seckill.setSeckillDescription(json.getString("seckillDescription"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        seckill.setSeckillStart(sdf.parse(json.getString("seckillStart")));
        seckill.setSeckillEnd(sdf.parse(json.getString("seckillEnd")));
        service.addSeckill(seckill);
//        System.out.println(seckill.getSeckillName());
//        System.out.println(seckill.getSeckillDescription());
//        System.out.println(seckill.getSeckillStart());
//        System.out.println(seckill.getSeckillEnd());
        JSONArray jsonArray = JSONArray.fromObject(spsString);
        List<SeckillProduct> list = new ArrayList<>();
        for (int i = 0; i < jsonArray.size(); i++){
            SeckillProduct sp = new SeckillProduct();
            sp.setSeckillId(seckill.getSeckillId());
            sp.setSpAmount(Integer.parseInt(jsonArray.getJSONObject(i).getString("spAmount")));
            sp.setSpPrice(Double.parseDouble(jsonArray.getJSONObject(i).getString("spPrice")));
            Product product = new Product();
            product.setProductId(Integer.parseInt(jsonArray.getJSONObject(i).getString("productId")));
            sp.setProduct(product);
            list.add(sp);
        }
        dao.addSps(list);
        return "success";
    }
}
