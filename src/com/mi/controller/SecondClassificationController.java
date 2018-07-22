package com.mi.controller;

import com.mi.model.bean.SecondClassification;
import com.mi.model.service.SecondClassificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 上午11:06
 */
@Controller
public class SecondClassificationController {

    @Autowired
    private SecondClassificationService service;

    @RequestMapping("getAllScs")
    @ResponseBody
    public Map<String, Object> getAllFcs(String scName, String fcId, String page, String limit){
        System.out.println(scName + "---" + fcId + "---" + page + "---" + limit);
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", service.selectAllScsCount(scName, fcId));
        List<SecondClassification> scs = service.selectAllScs(scName, fcId, page, limit);
        result.put("data", scs);
        return result;
    }

    @RequestMapping("deleteSc")
    @ResponseBody
    public String deleteFc(String scId){
        service.deleteSc(Integer.parseInt(scId));
        return "success";
    }
}
