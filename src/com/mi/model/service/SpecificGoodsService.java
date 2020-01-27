package com.mi.model.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.mi.model.bean.*;
import com.mi.model.dao.OrderDAO;
import com.mi.model.dao.ProductDAO;
import com.mi.model.dao.ReceiverDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * @author daiqibin
 * @version 1.2.0
 * @date 2018/8/1
 * @description
 */
@Service
public class SpecificGoodsService {
    @Autowired
    private ProductDAO productDAO;
    @Autowired
    private OrderDAO orderDAO;
    @Autowired
    private ReceiverDAO receiverDAO;

    /**
     * @param productName
     * @return com.mi.model.bean.Product
     * @description 通过商品名字获得首先需要展示的商品
     */
    private Product getProductByName(String productName) {
        return productDAO.selectProductsByName(productName).get(0);
    }

    /**
     * @param productName
     * @return java.util.List<com.mi.model.bean.Comment>
     * @description 通过商品名字获得评论信息
     */
    public Map<String, Object> getProductComment(String productName, int pageSize) {
        Map<String, Object> map = new HashMap<>();
        Page<Comment> page = PageHelper.startPage(1, pageSize);
        orderDAO.getProductCommentByName(productName);
        List<Comment> comments = page.getResult();
        for (int i = 0; i < comments.size(); i++) {
            List<Reply> replies = orderDAO.getReplyByCommentId(comments.get(i).getCommentId());
            if (replies.size() != 0)
                comments.get(i).setReplies(replies);
        }
        map.put("comments", comments);
        map.put("commentPageCount", page.getPages());
        map.put("commentPageSize", page.getPageSize());

        return map;
    }

    /**
     * @param productName
     * @return java.util.Map<java.lang.String,java.lang.Object>
     * @description 获得点击购买界面信息
     */
    public Map<String, Object> getBuyGoods(String productName, int accountId) {
        Map<String, Object> map = new HashMap<>();
        Product product = getProductByName(productName);
        map.put("product", product);
        if (product.getProductColor() != null && !product.getProductColor().equals("")) {
            Product productC = new Product();
            productC.setProductName(productName);
            List<String> colors = productDAO.selectProductColor(productC);
            map.put("colors", colors);
        }
        if (product.getProductSize() != null && !product.getProductSize().equals("")) {
            List<Descripe> sizes = productDAO.selectProductSize(productName);
            map.put("sizes", sizes);
        }
        if (product.getProductVersion() != null && !product.getProductVersion().equals("")) {
            List<Descripe> version = productDAO.selectProductVersion(productName);
            map.put("versions", version);
        }
        Page<Comment> page = PageHelper.startPage(1, 2);
        orderDAO.getProductCommentByName(productName);
        List<Comment> comments = page.getResult();
        if (comments != null && comments.size() > 0) {
            for (int i = 0; i < comments.size(); i++) {
                int commentId = comments.get(i).getCommentId();
                List<Reply> replies = orderDAO.getReplyByCommentId(commentId);
                if (replies.size() != 0)
                    comments.get(i).setReplies(replies);
            }
            map.put("comments", comments);
            map.put("commentPageCount", page.getPages());
            map.put("commentPageSize", page.getPageSize());
        }
        if (accountId != 0) {
            List<Receiver> receivers = receiverDAO.selectReceiverByAccount(accountId);
            if (receivers != null && receivers.size() != 0)
                map.put("receiver", receivers.get(0));
        }
        return map;
    }

    /**
     * @param product
     * @param place
     * @return java.util.List<java.lang.String>
     * @description 获得点击购买界面的商品的信息
     */
    public List<String> selectProductPic(Product product, String place) {
        Map<String, Object> picAsk = new HashMap<>();
        picAsk.put("k_product", product);
        picAsk.put("k_place", place);
        return productDAO.selectProductPic(picAsk);
    }

    /**
     * @param productName
     * @return java.util.Map<java.lang.String,java.lang.Object>
     * @description 获得参数界面图片和参数
     */
    public Map<String, Object> selectDetailInSpecs(String productName) {
        Map<String, Object> picAsk = new HashMap<>();
        Product product = new Product();
        product.setProductName(productName);
        picAsk.put("k_product", product);
        Map<String, Object> details = new HashMap<>();
        picAsk.put("k_place", "specs_lunbo%");
        List<String> carousel = productDAO.selectProductPic(picAsk);
        if (carousel.size() != 0)
            details.put("specs_lunbo", carousel);
        picAsk.put("k_place", "specs_pic%");
        List<String> bigPic = productDAO.selectProductPic(picAsk);
        details.put("specs_pic", bigPic);
        details.put("bigPic_size", bigPic.size());
        details.put("product", productDAO.getLowestPrice(productName).get(0));
        return details;
    }

    /**
     * @param productName
     * @return java.util.Map<java.lang.String,java.lang.Object>
     * @description 获得购买界面参数
     */
    public Map<String, Object> selectDetailTextInSpecs(String productName) {
        Map<String, Object> picAsk = new HashMap<>();
        Product product = new Product();
        product.setProductName(productName);
        picAsk.put("k_product", product);
        Map<String, Object> details = new HashMap<>();
        picAsk.put("k_place", "specs_text_title%");
        details.put("specs_text_title", productDAO.selectProductPic(picAsk));
        List<String> textTitle = productDAO.selectProductPic(picAsk);
        int textInteger = textTitle.size();
        if (textInteger != 0) {
            details.put("specs_text_title", productDAO.selectProductPic(picAsk));
            picAsk.put("k_place", "specs_text_content%");
            details.put("specs_text_content", productDAO.selectProductPic(picAsk));
            details.put("text_size", textInteger);
        }
        return details;
    }

    /**
     * @param product
     * @param from
     * @return java.util.List<java.lang.String>
     * @description 点击购买界面根据商品型号和商品尺寸获得对应的商品颜色信息
     */
    public List<String> selectProductColor(Product product, String from) {
        if (from.equals("size"))
            product.setProductVersion("");
        else
            product.setProductSize("");
        return productDAO.selectProductColor(product);
    }

    /**
     * @param reply
     * @return void
     * @description 增加回复
     */
    public void addReply(Reply reply,int accountId) {
        Account account = new Account();
        account.setAccountId(accountId);
        reply.setAccount(account);
        orderDAO.addReply(reply);
    }
}
