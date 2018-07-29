package com.mi.controller;

import com.mi.model.bean.PieData;
import com.mi.model.bean.Product;
import com.mi.model.service.AnalysisService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/26 下午3:51
 */
@Controller
public class AnalysisController {

    @Autowired
    private AnalysisService service;

    @RequestMapping("scComposition")
    @ResponseBody
    public List<PieData> getScComposition(){
        return service.getScComposition();
    }

    @RequestMapping("productSale")
    @ResponseBody
    public Map<String, Object> getProductSale(){
        return service.getProductSale();
    }

    @RequestMapping("panelData")
    @ResponseBody
    public Map<String, Object> getPanelData(){
        return service.getPanelData();
    }

    @RequestMapping("orderMoney")
    @ResponseBody
    public Map<String, Object> getOrderMoney(){
        return service.getOrderMoney();
    }
}