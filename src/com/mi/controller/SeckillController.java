package com.mi.controller;

import com.mi.model.bean.Seckill;
import com.mi.model.service.SeckillService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
