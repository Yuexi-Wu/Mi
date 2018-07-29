package com.mi.controller;

import com.mi.model.bean.FirstClassification;
import com.mi.model.bean.SecondClassification;
import com.mi.model.service.SecondClassificationService;
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

    @RequestMapping("addSc")
    @ResponseBody
    public String addSc(SecondClassification sc){
        if (sc.getFcId() == 0){
            return "fc";
        }else if (sc.getScName() == null || sc.getScName().equals("")){
            return "name";
        }else if (sc.getScUrl() == null || sc.getScUrl().equals("")){
            return "url";
        }
        sc.setScId(CusMethod.randomId());
        service.addSc(sc);
        return "success";
    }

    @RequestMapping("updateSc")
    @ResponseBody
    public String updateSc(SecondClassification sc){
        if (sc.getFcId() == 0){
            return "fc";
        }else if (sc.getScName() == null || sc.getScName().equals("")){
            return "name";
        }else if (sc.getScUrl() == null || sc.getScUrl().equals("")){
            return "url";
        }
        service.updateSc(sc);
        return "success";
    }

    @RequestMapping("getScById")
    public String getScById(int scId, Model model){
        SecondClassification sc = service.selectScById(scId);
        model.addAttribute("sc", sc);
        return "scEdit";
    }
}
