package com.mi.controller;

import com.mi.model.bean.Notification;
import com.mi.model.bean.Product;
import com.mi.model.bean.Seckill;
import com.mi.model.bean.SeckillProduct;
import com.mi.model.dao.AccountDAO;
import com.mi.model.dao.NotificationDAO;
import com.mi.model.dao.SeckillProductDAO;
import com.mi.model.service.SeckillService;
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
 * Created by Alexander on 2018/7/22 下午2:03
 */
@Controller
public class SeckillController {

    @Autowired
    private SeckillService seckillService;
    @Autowired
    private SeckillProductDAO spDao;

    @RequestMapping("getAllSeckills")
    @ResponseBody
    public Map<String, Object> getAllSeckills(String startTime, String endTime, String page, String limit){
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", seckillService.selectAllSeckillsCount(startTime, endTime));
        List<Seckill> seckills = seckillService.selectAllSeckills(startTime, endTime, page, limit);
        result.put("data", seckills);
        return result;
    }

    @RequestMapping("deleteSeckill")
    @ResponseBody
    public String deleteSeckill(int seckillId){
        seckillService.deleteSeckill(seckillId);
        return "success";
    }

    @RequestMapping("addSeckill")
    @ResponseBody
    public String addSeckill(HttpServletRequest request) throws ParseException {
        String seckillString = request.getParameter("seckill");
        String spsString = request.getParameter("sps");
        JSONObject json = JSONObject.fromObject(seckillString);
        JSONArray jsonArray = JSONArray.fromObject(spsString);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (json.getString("seckillName") == null || json.getString("seckillName").equals("")){
            return "name";
        }else if (json.getString("seckillStart") == null || json.getString("seckillStart").equals("")){
            return "start";
        }else if ((sdf.parse(json.getString("seckillStart")).getTime() - new Date().getTime()) < 3600){
            return "startWrong";
        }else if (json.getString("seckillEnd") == null || json.getString("seckillEnd").equals("")){
            return "end";
        }else if ((sdf.parse(json.getString("seckillEnd")).getTime() - sdf.parse(json.getString("seckillStart")).getTime()) < 1800){
            return "endWrong";
        }
        Seckill seckill = new Seckill();
        seckill.setSeckillId(CusMethod.randomId());
        seckill.setSeckillName(json.getString("seckillName"));
        seckill.setSeckillDescription(json.getString("seckillDescription"));
        seckill.setSeckillStart(sdf.parse(json.getString("seckillStart")));
        seckill.setSeckillEnd(sdf.parse(json.getString("seckillEnd")));
        List<SeckillProduct> list = new ArrayList<>();
        for (int i = 0; i < jsonArray.size(); i++){
            String productId = jsonArray.getJSONObject(i).getString("productId");
            String spAmount = jsonArray.getJSONObject(i).getString("spAmount");
            String spPrice = jsonArray.getJSONObject(i).getString("spPrice");
            if (productId == null || productId.equals("")){
                return "productId";
            }
            if (spAmount == null || spAmount.equals("")){
                return "spAmount";
            }
            if (spPrice == null || spPrice.equals("")){
                return "spPrice";
            }
            SeckillProduct sp = new SeckillProduct();
            sp.setSpId(CusMethod.randomId());
            sp.setSeckillId(seckill.getSeckillId());
            sp.setSpAmount(Integer.parseInt(spAmount));
            sp.setSpPrice(Double.parseDouble(spPrice));
            Product product = new Product();
            product.setProductId(Integer.parseInt(productId));
            sp.setProduct(product);
            list.add(sp);
        }
        seckillService.addSeckill(seckill);
        spDao.addSps(list);
        return "success";
    }

    @RequestMapping("getSeckillByIdBack")
    public String getSeckillById(int seckillId, Model model){
        Seckill seckill = seckillService.selectSeckillById(seckillId);
        model.addAttribute("seckill", seckill);
        return "seckillInfo";
    }

    /**
     * get latest second kill activity
     * @return latest second kill activity
     * @author huang jiarui
     * @version 1.1
     */
    @RequestMapping("/seckillController/getLatestSeckill.action")
    @ResponseBody
    public Seckill getLatestSeckill(){

        return seckillService.getLatestSeckill();

    }

    /**
     * get current time of server
     * @return the milliseconds between 1970/1/1 0:0 and current time of server
     * @author huang jiarui
     * @version 1.1
     */
    @RequestMapping("/seckillController/getServerTime.action")
    @ResponseBody
    public Long getServerTime(){

        return new Date().getTime();

    }
}
