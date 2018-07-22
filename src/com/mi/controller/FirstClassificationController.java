package com.mi.controller;

import com.mi.model.bean.FirstClassification;
import com.mi.model.bean.Product;
import com.mi.model.service.FirstClassificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 上午9:39
 */
@Controller
public class FirstClassificationController {

    @Autowired
    private FirstClassificationService service;

    @RequestMapping("getAllFcs")
    @ResponseBody
    public Map<String, Object> getAllFcs(String fcName, String page, String limit){
        System.out.println(fcName + "---" + page + "---" + limit);
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", service.selectAllFcsCount(fcName));
        List<FirstClassification> fcs = service.selectAllFcs(fcName, page, limit);
        result.put("data", fcs);
        return result;
    }

    @RequestMapping("deleteFc")
    @ResponseBody
    public String deleteFc(String fcId){
        service.deleteFc(Integer.parseInt(fcId));
        return "success";
    }
}
