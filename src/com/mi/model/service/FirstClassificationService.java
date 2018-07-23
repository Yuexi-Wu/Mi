package com.mi.model.service;

import com.mi.model.bean.FirstClassification;
import com.mi.model.dao.FirstClassificationDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 上午9:40
 */
@Service
public class FirstClassificationService {

    @Autowired
    private FirstClassificationDAO dao;

    public int selectAllFcsCount(String fcName) {
        return dao.selectAllFcsCount(fcName);
    }

    public List<FirstClassification> selectAllFcs(String fcName, String page, String limit) {
        Map<String, Object> map = new HashMap<>();
        if (fcName != null && !fcName.equals("")){
            map.put("fcName", fcName);
        }
        if (page != null && !page.equals("") && limit != null && !limit.equals("")){
            map.put("index", ((Integer.parseInt(page) - 1) * Integer.parseInt(limit)));
            map.put("limit", Integer.parseInt(limit));
        }
        return dao.selectAllFcs(map);
    }

    public void deleteFc(int fcId){
        dao.deleteFc(fcId);
    }

    public void addFc(FirstClassification fc){
        dao.addFc(fc);
    }

    public FirstClassification selectFcById(int fcId) {
        return dao.selectFcById(fcId);
    }

    public void updateFc(FirstClassification fc) {
        dao.updateFc(fc);
    }
}
