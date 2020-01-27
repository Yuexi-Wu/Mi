package com.mi.model.service;

import com.mi.model.bean.*;
import com.mi.model.dao.AccountDAO;
import com.mi.model.dao.CommentDAO;
import com.mi.model.dao.ProductDAO;
import com.mi.model.dao.RecommenderDAO;
import com.mi.model.utils.CRBMRecommender;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Service related to recommend function
 * @author huang jiarui
 * @version 1.0
 */
@Service
public class RecommenderService {
    @Autowired
    private RecommenderDAO recommenderDAO;

    @Autowired
    private ProductDAO productDAO;

    @Autowired
    private AccountDAO accountDAO;

    @Autowired
    private CommentDAO commentDAO;

    /**
     * save parameters of CRBMRecommender into database
     * @param numItems the amount of products
     * @param featureNumber the amount of feature
     * @param weightsIn weights to save
     * @param hidbiasesIn hidbiases to save
     * @param visbiasesIn visbiases to save
     * @param productIds id of all products
     * @author huang jiarui
     * @version 1.0
     */
    public void saveParameters(int numItems, int featureNumber, double[][] weightsIn, double[] hidbiasesIn, double[] visbiasesIn, List<Integer> productIds){
        List<Weight> weights = new ArrayList<Weight>();
        List<Hidbiase> hidbiases = new ArrayList<Hidbiase>();
        List<Visbiase> visbiases = new ArrayList<Visbiase>();
        recommenderDAO.deleteWeight();
        recommenderDAO.deleteHidbiase();
        recommenderDAO.deleteVisbiase();
        int count = 0;

        for(int i = 0 ; i < numItems ; i++){
            for(int h = 0 ; h < featureNumber ; h++){
                Weight tempWeight = new Weight();
                tempWeight.setFeatureNumber(h);
                tempWeight.setProductId(productIds.get(i));
                tempWeight.setWeightId(count);
                tempWeight.setWeightValue(weightsIn[i][h]);
                weights.add(tempWeight);
                count ++;
            }
        }

        count = 0;

        for(int h = 0 ; h < featureNumber ; h++){
            Hidbiase tempHidbiase = new Hidbiase();
            tempHidbiase.setFeatureNumber(h);
            tempHidbiase.setHidbiaseId(count);
            tempHidbiase.setHidbiaseValue(hidbiasesIn[h]);
            hidbiases.add(tempHidbiase);
            count ++;
        }

        count = 0;

        for(int i = 0 ; i < numItems ; i++){
            Visbiase tempVisbiase = new Visbiase();
            tempVisbiase.setProductId(productIds.get(i));
            tempVisbiase.setVisbiaseId(count);
            tempVisbiase.setVisbiaseValue(visbiasesIn[i]);
            visbiases.add(tempVisbiase);
            count ++;
        }

        recommenderDAO.insertAllWeight(weights);
        recommenderDAO.insertAllHidbiase(hidbiases);
        recommenderDAO.insertAllVisbiase(visbiases);
    }

    /**
     * get all weights
     * @return list of weights
     * @author huang jiarui
     * @version 1.0
     */
    public List<Weight> getAllWeight(){
        return recommenderDAO.getAllWeight();
    }

    /**
     * get all hidbiases
     * @return list of hidbiases
     * @author huang jiarui
     * @version 1.0
     */
    public List<Hidbiase> getAllHidbiase(){
        return recommenderDAO.getAllHidbiase();
    }

    /**
     * get all visbiases
     * @return list of visbiases
     * @author huang jiarui
     * @version 1.0
     */
    public List<Visbiase> getAllVisbiase(){
        return recommenderDAO.getAllVisbiase();
    }


}
