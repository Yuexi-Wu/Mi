package com.mi.controller;

import com.mi.model.bean.*;
import com.mi.model.service.AccountService;
import com.mi.model.service.CommentService;
import com.mi.model.service.ProductService;
import com.mi.model.service.RecommenderService;
import com.mi.model.utils.CRBMRecommender;
import com.mi.model.utils.ProbDescComparator;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.*;

/**
 * controller of recommender , contains method to achieve recommending results
 * @author huang jiarui
 * @version 1.1
 */
@Controller
public class RecommenderController {

    @Resource
    AccountService accountService;

    @Resource
    ProductService productService;

    @Resource
    CommentService commentService;

    @Resource
    RecommenderService recommenderService;

    /**
     * get recommending results
     *
     * the method gets product,account,comment information and parameters of model first,
     * then it sets up the model,finally it predicts and gets the recommending result
     *
     * @param accountId id of recommending target account
     * @param amount amount of recommended products
     * @return list of recommended products
     * @author huang jiarui
     * @version 1.3
     */
    @RequestMapping("/recommenderController/getRecommendResult.action")
    @ResponseBody
    public List<Product> getRecommendResult(Integer accountId,Integer amount){
        List<Integer> productIds = productService.getAllSortedProductId();
        List<Integer> accountIds = accountService.getAllSortedAccountId();
        List<Scoring> scorings = commentService.getAllScoring();
        List<Weight> weightsIn = recommenderService.getAllWeight();
        List<Hidbiase> hidbiasesIn = recommenderService.getAllHidbiase();
        List<Visbiase> visbiasesIn = recommenderService.getAllVisbiase();
        double[][] weights = new double[productIds.size()][hidbiasesIn.size()];
        for(Weight w : weightsIn){
            for(int i = 0 ; i < productIds.size() ; i++){
                if(w.getProductId() == productIds.get(i)){
                    weights[i][w.getFeatureNumber()] = w.getWeightValue();
                }
            }
        }
        double[] hidbiases = new double[hidbiasesIn.size()];
        for(Hidbiase h : hidbiasesIn){
            hidbiases[h.getFeatureNumber()] = h.getHidbiaseValue();
        }
        double[] visbiases = new double[productIds.size()];
        for(Visbiase v : visbiasesIn){
            for(int i = 0 ; i < productIds.size() ; i++) {
                if (v.getProductId() == productIds.get(i)) {
                    visbiases[i] = v.getVisbiaseValue();
                }
            }
        }
        int u = 0;
        CRBMRecommender crbmRecommender = new CRBMRecommender();
        crbmRecommender.setup(productIds,accountIds,scorings,weights,hidbiases,visbiases);
        for(int i = 0 ; i < accountIds.size() ; i++){
            if(accountIds.get(i) == accountId){
                u = i ;
            }
        }
        double[] result = crbmRecommender.predict(u);
        Map<Integer,Double> maxProbMap = new HashMap<Integer, Double>();

        for(int i = 0 ; i < result.length ; i++){
            maxProbMap.put(i,result[i]);
        }

        List<Map.Entry<Integer,Double>> maxProbList = new ArrayList<Map.Entry<Integer,Double>>(maxProbMap.entrySet());
        Collections.sort(maxProbList,new ProbDescComparator());
        int i = 0;
        List<Integer> commentedProducts = new ArrayList<Integer>();

        for(Scoring s : scorings){
            if(s.getAccountId() == accountId){
                commentedProducts.add(s.getProductId());
            }
        }

        List<Integer> productIdsIn = new ArrayList<Integer>();
        for(Map.Entry<Integer,Double> probEntry : maxProbList){
            int tempProduct = productIds.get(probEntry.getKey());
            boolean finded = false;
            for(int tempId : commentedProducts){
                if(tempId == tempProduct){
                    finded = true;
                    break;
                }
            }
            if(!finded) {
                productIdsIn.add(tempProduct);
                i++;
            }
            if(i >= amount){
                break;
            }
        }

        return productService.getProductByIds(productIdsIn);
        
    }

    /**
     * get recommending results while not logged in
     *
     * the method gets product,account,comment information and parameters of model first,
     * then it sets up the model,finally it predicts and gets the recommending result
     *
     * @param amount amount of recommended products
     * @return list of recommended products
     * @author huang jiarui
     * @version 1.2
     */
    @RequestMapping("/recommenderController/logOutGetRecommendResult.action")
    @ResponseBody
    public List<Product> getRecommendResult(Integer amount){
        List<Integer> productIds = productService.getAllSortedProductId();
        List<Integer> accountIds = accountService.getAllSortedAccountId();
        List<Scoring> scorings = commentService.getAllScoring();
        List<Weight> weightsIn = recommenderService.getAllWeight();
        List<Hidbiase> hidbiasesIn = recommenderService.getAllHidbiase();
        List<Visbiase> visbiasesIn = recommenderService.getAllVisbiase();
        double[][] weights = new double[productIds.size()][hidbiasesIn.size()];
        for(Weight w : weightsIn){
            for(int i = 0 ; i < productIds.size() ; i++){
                if(w.getProductId() == productIds.get(i)){
                    weights[i][w.getFeatureNumber()] = w.getWeightValue();
                }
            }
        }
        double[] hidbiases = new double[hidbiasesIn.size()];
        for(Hidbiase h : hidbiasesIn){
            hidbiases[h.getFeatureNumber()] = h.getHidbiaseValue();
        }
        double[] visbiases = new double[productIds.size()];
        for(Visbiase v : visbiasesIn){
            for(int i = 0 ; i < productIds.size() ; i++) {
                if (v.getProductId() == productIds.get(i)) {
                    visbiases[i] = v.getVisbiaseValue();
                }
            }
        }
        int u = 0;
        CRBMRecommender crbmRecommender = new CRBMRecommender();
        crbmRecommender.setup(productIds,accountIds,scorings,weights,hidbiases,visbiases);

        double[] result = crbmRecommender.predict();
        Map<Integer,Double> maxProbMap = new HashMap<Integer, Double>();

        for(int i = 0 ; i < result.length ; i++){
            maxProbMap.put(i,result[i]);
        }

        List<Map.Entry<Integer,Double>> maxProbList = new ArrayList<Map.Entry<Integer,Double>>(maxProbMap.entrySet());
        Collections.sort(maxProbList,new ProbDescComparator());
        int i = 0;

        List<Integer> productIdsIn = new ArrayList<Integer>();
        for(Map.Entry<Integer,Double> probEntry : maxProbList){
            productIdsIn.add(productIds.get(probEntry.getKey()));
            i++;
            if(i >= amount){
                break;
            }
        }

        return productService.getProductByIds(productIdsIn);

    }
}
