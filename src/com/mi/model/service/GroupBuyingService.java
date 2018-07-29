package com.mi.model.service;

import com.mi.model.bean.GroupBuying;
import com.mi.model.dao.GroupBuyingDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 下午4:44
 */
@Service
public class GroupBuyingService {

    @Autowired
    private GroupBuyingDAO dao;

    public List<GroupBuying> selectAllGbs(String startTime, String endTime, String page, String limit){
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
        return dao.selectAllGbs(map);
    }

    public int selectAllGbsCount(String startTime, String endTime){
        Map<String, Object> map = new HashMap<>();
        if (startTime != null && !startTime.equals("")){
            map.put("startTime", startTime);
        }
        if (endTime != null && !endTime.equals("")){
            map.put("endTime", endTime);
        }
        return dao.selectAllGbsCount(map);
    }

    public void deleteGb(int gbId){
        dao.deleteGb(gbId);
    }

    public void addGb(GroupBuying gb) {
        dao.addGb(gb);
    }

    public GroupBuying selectGbById(int gbId) {
        return dao.selectGbById(gbId);
    }
}
