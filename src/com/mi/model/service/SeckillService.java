package com.mi.model.service;

import com.mi.model.bean.Seckill;
import com.mi.model.dao.SeckillDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 下午2:03
 */
@Service
public class SeckillService {

    @Autowired
    private SeckillDAO dao;

    public List<Seckill> selectAllSeckills(String startTime, String endTime, String page, String limit){
        Map<String, Object> map = new HashMap<>();
        if (startTime != null && !startTime.equals("")){
            map.put("startTime", startTime);
        }
        if (endTime != null && !endTime.equals("")){
            map.put("endTime", endTime);
        }
        if (page != null && !page.equals("") && limit != null && !limit.equals("")){
            map.put("index", ((Integer.parseInt(page) - 1) * Integer.parseInt(limit)));
            map.put("limit", Integer.parseInt(limit));
        }
        return dao.selectAllSeckills(map);
    }

    public int selectAllSeckillsCount(String startTime, String endTime){
        Map<String, Object> map = new HashMap<>();
        if (startTime != null && !startTime.equals("")){
            map.put("startTime", startTime);
        }
        if (endTime != null && !endTime.equals("")){
            map.put("endTime", endTime);
        }
        return dao.selectAllSeckillsCount(map);
    }

    public void deleteSeckill(int seckillId){
        dao.deleteSeckill(seckillId);
    }

}
