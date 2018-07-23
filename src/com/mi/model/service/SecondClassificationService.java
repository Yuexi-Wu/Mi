package com.mi.model.service;

import com.mi.model.bean.SecondClassification;
import com.mi.model.dao.SecondClassificationDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 上午11:09
 */
@Service
public class SecondClassificationService {

    @Autowired
    private SecondClassificationDAO dao;

    public int selectAllScsCount(String scName, String fcId) {
        Map<String, Object> map = new HashMap<>();
        if (scName != null && !scName.equals("")){
            map.put("scName", scName);
        }
        if (fcId != null && !fcId.equals("")){
            map.put("fcId", fcId);
        }
        return dao.selectAllScsCount(map);
    }

    public List<SecondClassification> selectAllScs(String scName, String fcId, String page, String limit) {
        Map<String, Object> map = new HashMap<>();
        if (scName != null && !scName.equals("")){
            map.put("scName", scName);
        }
        if (fcId != null && !fcId.equals("")){
            map.put("fcId", fcId);
        }
        if (page != null && !page.equals("") && limit != null && !limit.equals("")){
            map.put("index", ((Integer.parseInt(page) - 1) * Integer.parseInt(limit)));
            map.put("limit", Integer.parseInt(limit));
        }
        return dao.selectAllScs(map);
    }

    public void deleteSc(int fcId){
        dao.deleteSc(fcId);
    }

    public void addSc(SecondClassification sc) {
        dao.addSc(sc);
    }

    public SecondClassification selectScById(int scId) {
        return dao.selectScById(scId);
    }

    public void updateSc(SecondClassification sc) {
        dao.updateSc(sc);
    }
}
