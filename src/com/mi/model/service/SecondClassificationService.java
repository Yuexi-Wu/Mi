package com.mi.model.service;

import com.mi.model.bean.SecondClassification;
import com.mi.model.dao.SecondClassificationDAO;
import com.mi.model.tools.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by Alexander on 2018/7/22 上午11:09
 */
@Service
public class SecondClassificationService {

    @Autowired
    private SecondClassificationDAO secondClassificationDAO;

    public int selectAllScsCount(String scName, String fcId) {
        Map<String, Object> map = new HashMap<>();
        if (scName != null && !scName.equals("")){
            map.put("scName", scName);
        }
        if (fcId != null && !fcId.equals("")){
            map.put("fcId", fcId);
        }
        return secondClassificationDAO.selectAllScsCount(map);
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
        return secondClassificationDAO.selectAllScs(map);
    }

    public void deleteSc(int fcId){
        secondClassificationDAO.deleteSc(fcId);
    }

    public void addSc(SecondClassification sc) {
        secondClassificationDAO.addSc(sc);
    }

    public SecondClassification selectScById(int scId) {
        return secondClassificationDAO.selectScById(scId);
    }

    public void updateSc(SecondClassification sc) {
        secondClassificationDAO.updateSc(sc);
    }

    /*根据一级分类返回全部二级分类*/
    public List<SecondClassification> selectScByFc(String fcId) {
        List<SecondClassification> scList = secondClassificationDAO.selectScByFc(Integer.parseInt(fcId));
        return scList;
    }

    /**
     * get portion second classifications which contain the latest new products by id of first classification
     * @param fcId id of first classification
     * @param amount amount of products
     * @return list of second classifications which contain the latest new products
     * @author huang jiarui
     * @version 1.0
     */
    public List<SecondClassification> getLatestPortionSecondClassificationByFcId(int fcId,int amount){
        Map<Long,Integer> minTimeMap = new TreeMap<Long,Integer>();
        List<SecondClassification> secondClassifications = secondClassificationDAO.getSecondClassificationByFcId(new Integer(fcId));

        if(secondClassifications.size() <= amount){
            return secondClassifications;
        }

        List<SecondClassification> result = new ArrayList<SecondClassification>();


        for(int i = 0 ; i < secondClassifications.size() ; i++){

            long minDifferenceTime = Utils.getMinDifferenceTime(secondClassifications.get(i));

            minTimeMap.put(minDifferenceTime,i);

        }

        int i = 0;

        Iterator it = minTimeMap.keySet().iterator();

        while(it.hasNext() && i < amount){
            result.add(secondClassifications.get(minTimeMap.get(it.next())));
        }

        return result;
    }
}
