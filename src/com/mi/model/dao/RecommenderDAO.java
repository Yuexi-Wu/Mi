package com.mi.model.dao;

import com.mi.model.bean.Hidbiase;
import com.mi.model.bean.Product;
import com.mi.model.bean.Visbiase;
import com.mi.model.bean.Weight;

import java.util.List;

/**
 * DAO related to recommend function
 * @author huang jiarui
 * @version 1.0
 */
public interface RecommenderDAO {

    /**
     * get all weights
     * @return list of weights
     * @author huang jiarui
     * @version 1.0
     */
    public List<Weight> getAllWeight();

    /**
     * get all hidbiases
     * @return list of hidbiases
     * @author huang jiarui
     * @version 1.0
     */
    public List<Hidbiase> getAllHidbiase();

    /**
     * get all visbiases
     * @return list of visbiases
     * @author huang jiarui
     * @version 1.0
     */
    public List<Visbiase> getAllVisbiase();

    /**
     * delete all data in table weight
     * @author huang jiarui
     * @version 1.0
     */
    public void deleteWeight();

    /**
     * delete all data in table hidbiase
     * @author huang jiarui
     * @version 1.0
     */
    public void deleteHidbiase();

    /**
     * delete all data in table weight
     * @author huang jiarui
     * @version 1.0
     */
    public void deleteVisbiase();

    /**
     * insert all weights into table weight
     * @param weights list of weights
     * @author huang jiarui
     * @version 1.0
     */
    public void insertAllWeight(List<Weight> weights);

    /**
     * insert all hidbiases into table weight
     * @param hidbiases list of hidbiases
     * @author huang jiarui
     * @version 1.0
     */
    public void insertAllHidbiase(List<Hidbiase> hidbiases);

    /**
     * insert all visbiases into table weight
     * @param visbiases list of visbiases
     * @author huang jiarui
     * @version 1.0
     */
    public void insertAllVisbiase(List<Visbiase> visbiases);
}
