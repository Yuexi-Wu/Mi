package com.mi.controller;

import com.mi.model.bean.Scoring;
import com.mi.model.service.AccountService;
import com.mi.model.service.CommentService;
import com.mi.model.service.ProductService;
import com.mi.model.service.RecommenderService;
import com.mi.model.utils.CRBMRecommender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * training controller , which has a scheduled method to update the parameters of the CRBMRecommender
 * @author huang jiarui
 * @version 1.0
 */
@Component
public class TrainController {

    @Resource
    AccountService accountService;

    @Resource
    ProductService productService;

    @Resource
    CommentService commentService;

    @Resource
    RecommenderService recommenderService;

    /**
     * a scheduled method to update the parameters of the CRBMRecommender
     *
     * the method gets product,accoun and comment information first,
     * then it sets up the model,finally the model trains and save the parameters
     *
     * the method execute every 30 minutes
     * @author huang jiarui
     * @version 1.0
     */
    //@Scheduled(cron="1 * * * * ?")
    public void updateTrainModel(){
        CRBMRecommender recommender = new CRBMRecommender();
        List<Integer> productIdsIn = productService.getAllSortedProductId();
        List<Integer> accountIdsIn = accountService.getAllSortedAccountId();
        List<Scoring> scorings = commentService.getAllScoring();
        recommender.setup(productIdsIn,accountIdsIn,scorings);
        recommender.trainModel();
        recommenderService.saveParameters(recommender.numItems,recommender.featureNumber,recommender.weights,recommender.hidbiases,recommender.visbiases,recommender.productIds);
    }
}
