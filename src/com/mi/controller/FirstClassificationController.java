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
    private FirstClassificationService firstClassificationService;

    @RequestMapping("getAllFcs")
    @ResponseBody
    public Map<String, Object> getAllFcs(String fcName, String page, String limit){
        System.out.println(fcName + "---" + page + "---" + limit);
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", firstClassificationService.selectAllFcsCount(fcName));
        List<FirstClassification> fcs = firstClassificationService.selectAllFcs(fcName, page, limit);
        result.put("data", fcs);
        return result;
    }

    @RequestMapping("deleteFc")
    @ResponseBody
    public String deleteFc(String fcId){
        firstClassificationService.deleteFc(Integer.parseInt(fcId));
        return "success";
    }

    @RequestMapping("addFc")
    @ResponseBody
    public String addFc(FirstClassification fc){
        if (fc.getFcName() == null || fc.getFcName().equals("")){
            return "name";
        }
        fc.setFcId(CusMethod.randomId());
        firstClassificationService.addFc(fc);
        return "success";
    }

    @RequestMapping("getFcById")
    public String getFcById(int fcId, Model model){
        FirstClassification fc = firstClassificationService.selectFcById(fcId);
        model.addAttribute("fc", fc);
        return "fcEdit";
    }

    @RequestMapping("updateFc")
    @ResponseBody
    public String updateFc(FirstClassification fc){
        if (fc.getFcName() == null || fc.getFcName().equals("")){
            return "name";
        }
        firstClassificationService.updateFc(fc);
        return "success";
    }

    /**
     * get all first classifications
     * @return list of all first classifications
     * @author huang jiarui
     * @version 1.1
     */
    @RequestMapping("/firstClassificationController/getAllFirstClassification")
    @ResponseBody
    public List<FirstClassification> getAllFirstClassification(){
        List<FirstClassification> firstClassifications = firstClassificationService.getAllFirstClassification();
        return firstClassifications;
    }

    /**
     * get all first classifications with latest portion second classification
     * @param amount the number of products of second classification
     * @return list of all first classifications with latest portion second classification
     * @author huang jiarui
     * @version 1.1
     */
    @RequestMapping("/firstClassificationController/getAllFirstClassificationWithLatestPortionSecondClassification")
    @ResponseBody
    public List<FirstClassification> getAllFirstClassificationWithLatestPortionSecondClassification(int amount){
        return firstClassificationService.getAllFirstClassificationWithLatestPortionSecondClassification(amount);
    }
}
