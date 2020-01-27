package com.mi.model.service;

import com.mi.model.bean.*;
import com.mi.model.dao.AccountDAO;
import com.mi.model.dao.CommentDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentDAO commentDAO;


    public List<Comment> viewComment(int accountId){
        List<Comment> comments = commentDAO.viewComment(accountId);
        return comments;
    }

    //查看未评价商品
    public List<OrderItem> getUncommentedProducts(int accountId){
        List<OrderItem> items = commentDAO.selectUncommentedOrder(accountId);
        return items;
    }

    //查看已评价商品
    public List<OrderItem> getCommentedProducts(int accountId){
        List<OrderItem> items = commentDAO.selectCommentedOrder(accountId);
        return items;
    }

    public OrderItem getOrderItemById(int itemId){
        OrderItem item = commentDAO.getOrderItemById(itemId);
        return  item;
    }

    public void insertComment(Comment comment){
        commentDAO.addComment(comment);
        OrderItem item = comment.getOrderItem();
        commentDAO.changeStatus(item);
    }
    
    /**
     * get all scoring
     * @return list of all scorings
     * @author huang jiarui
     * @version 1.1
     */
    public List<Scoring> getAllScoring(){

        List<Comment> comments = commentDAO.getAllComment();

        List<Scoring> scorings = new ArrayList<Scoring>();

        for(int i = 0 ; i < comments.size() ; i++){
            Scoring temp = new Scoring();
            double tempScore  = 0;
            temp.setAccountId(comments.get(i).getAccount().getAccountId());
            temp.setProductId(comments.get(i).getOrderItem().getProduct().getProductId());
            if(comments.get(i).getTotalLevel() == 1) {
                tempScore += 0.4;
            } else if(comments.get(i).getTotalLevel() == 2){
                tempScore += 1.2;
            } else if(comments.get(i).getTotalLevel() == 3){
                tempScore += 2;
            }
            tempScore += 0.2 * comments.get(i).getDescriptionLevel() + 0.2 * comments.get(i).getLogisticsLevel()
                    + 0.2 * comments.get(i).getServiceLevel();
            temp.setScore(tempScore);
            scorings.add(temp);
        }

        return scorings;

    }
}
