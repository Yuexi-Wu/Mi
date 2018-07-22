package com.mi.controller;

import com.mi.model.bean.GroupBuying;
import com.mi.model.service.GroupBuyingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
