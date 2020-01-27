package com.mi.model.service;

import com.mi.model.bean.FirstClassification;
import com.mi.model.bean.SecondClassification;
import com.mi.model.dao.FirstClassificationDAO;
import com.mi.model.tools.Utils;
import com.mi.model.utils.ValueAscComparator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by Alexander on 2018/7/22 上午9:40
 */
@Service
public class FirstClassificationService {

    @Autowired
    private FirstClassificationDAO firstClassificationDAO;

    public int selectAllFcsCount(String fcName) {
        return firstClassificationDAO.selectAllFcsCount(fcName);
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
        return firstClassificationDAO.selectAllFcs(map);
    }

    public void deleteFc(int fcId){
        firstClassificationDAO.deleteFc(fcId);
    }

    public void addFc(FirstClassification fc){
        firstClassificationDAO.addFc(fc);
    }

    public FirstClassification selectFcById(int fcId) {
        return firstClassificationDAO.selectFcById(fcId);
    }

    public void updateFc(FirstClassification fc) {
        firstClassificationDAO.updateFc(fc);
    }

    /**
     * get all first classifications
     * @return list FirstClassification
     * @author huang jiarui
     * @version 1.0
     */
    public List<FirstClassification> getAllFirstClassification(){

        return firstClassificationDAO.getAllFirstClassification();

    }

    /**
     * get all first classifications with latest portion second classification
     * @param amount the number of products of second classification
     * @return list of all first classifications with latest portion second classification
     * @author huang jiarui
     * @version 1.2
     */
    public List<FirstClassification> getAllFirstClassificationWithLatestPortionSecondClassification(int amount){
        List<FirstClassification> allFirstClassifications = firstClassificationDAO.getAllFirstClassification();

        for(FirstClassification fc : allFirstClassifications){
            Map<Integer,Long> minTimeMap = new HashMap<Integer,Long>();

            List<SecondClassification> secondClassifications = fc.getScs();

            List<SecondClassification> result = new ArrayList<SecondClassification>();

            for(int i = 0 ; i < secondClassifications.size() ; i++){

                long minDifferenceTime = Utils.getMinDifferenceTime(secondClassifications.get(i));

                minTimeMap.put(i,minDifferenceTime);

            }
            List<Map.Entry<Integer,Long>> minTimeList = new ArrayList<Map.Entry<Integer,Long>>(minTimeMap.entrySet());
            Collections.sort(minTimeList , new ValueAscComparator());
            int i = 0;

            for(Map.Entry<Integer,Long> timeEntry : minTimeList){
                result.add(secondClassifications.get(timeEntry.getKey()));
                i++;
                if(i >= amount){
                    break;
                }
            }

            fc.setScs(result);
        }
        return allFirstClassifications;
    }
}
