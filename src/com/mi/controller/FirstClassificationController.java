package com.mi.controller;

import com.mi.model.bean.FirstClassification;
import com.mi.model.bean.Product;
import com.mi.model.service.FirstClassificationService;
import com.mi.model.tools.CusMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 上午9:39
 */
@Controller
public class  FirstClassificationController {

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

    @RequestMapping("addFc")
    @ResponseBody
    public String addFc(FirstClassification fc){
        if (fc.getFcName() == null || fc.getFcName().equals("")){
            return "name";
        }
        fc.setFcId(CusMethod.randomId());
        service.addFc(fc);
        return "success";
    }

    @RequestMapping("getFcById")
    public String getFcById(int fcId, Model model){
        FirstClassification fc = service.selectFcById(fcId);
        model.addAttribute("fc", fc);
        return "fcEdit";
    }

    @RequestMapping("updateFc")
    @ResponseBody
    public String updateFc(FirstClassification fc){
        if (fc.getFcName() == null || fc.getFcName().equals("")){
            return "name";
        }
        service.updateFc(fc);
        return "success";
    }
}
