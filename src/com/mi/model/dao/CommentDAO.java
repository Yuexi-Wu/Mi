package com.mi.model.dao;

import com.mi.model.bean.Comment;
import com.mi.model.bean.Order;
import com.mi.model.bean.OrderItem;
import com.mi.model.bean.Product;

import java.util.List;

public interface CommentDAO {

    //新增评论
    public void addComment(Comment comment);

    //新增评论同时更改item评论状态
    public void changeStatus(OrderItem orderItem);

    //查看所有评论
    public List<Comment> viewComment(int accountId);

    //查看客户未评价的全部商品
    public List<OrderItem> selectUncommentedOrder(int accountId);

    //查看客户已评价商品
    public List<OrderItem> selectCommentedOrder(int accountId);

    //通过id定位orderItem
    public OrderItem getOrderItemById(int itemId);

    /**
     * get all comment
     * @return list of comment
     * @author huang jiarui
     * @version 1.0
     */
    public List<Comment> getAllComment();

}
