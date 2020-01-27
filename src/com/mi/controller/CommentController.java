package com.mi.controller;

import com.mi.model.bean.Account;
import com.mi.model.bean.Comment;
import com.mi.model.bean.OrderItem;
import com.mi.model.service.AccountService;
import com.mi.model.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CommentController {

    @Autowired
    private CommentService commentService;
    @Autowired
    private AccountService accountService;

    @RequestMapping("viewUncommentProduct")
    public String viewUncommentProduct(Model model, HttpSession session){
        int accountId = (Integer) session.getAttribute("accountId");
        List<OrderItem> items = commentService.getUncommentedProducts(accountId);
        model.addAttribute("uncommentedItems",items);
        int uncommentedNum = items.size();
        session.setAttribute("uncommented",uncommentedNum);
        return "MyComment";
    }

    @RequestMapping("viewCommentedProduct")
    public String viewCommentedProduct(Model model,HttpSession session){
        int accountId = (Integer) session.getAttribute("accountId");
        List<OrderItem> items = commentService.getCommentedProducts(accountId);
        model.addAttribute("commentedItems",items);
        return "MyCommented";
    }


    @RequestMapping("addComment")
    public String addComment(Integer orderItemId, HttpSession session){
        OrderItem orderItem = commentService.getOrderItemById(orderItemId);
        System.out.println(orderItem.getProduct().getProductId());
        session.setAttribute("commentItem",orderItem);
        return "CreateComment";
    }


    @RequestMapping("insertComment")
    @ResponseBody
    public String insertComment(Integer descriptionLevel,Integer logisticsLevel,Integer serviceLevel,String content,Integer totalLevel, String photoUrl, HttpSession session){
        Comment comment = new Comment();
        OrderItem item = (OrderItem)session.getAttribute("commentItem");
        comment.setDescriptionLevel(descriptionLevel);
        comment.setLogisticsLevel(logisticsLevel);
        comment.setServiceLevel(serviceLevel);
        comment.setContent(content);
        comment.setTotalLevel(totalLevel);
        comment.setOrderItem(item);
        System.out.println("111111111");
        comment.setPhotoUrl(photoUrl);
        System.out.println(photoUrl);

        commentService.insertComment(comment);
        System.out.println("222222222");
        return "CommentSuccess.jsp";
    }
}
