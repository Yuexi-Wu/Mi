package com.mi.controller;

import com.mi.model.bean.Account;
import com.mi.model.bean.Product;
import com.mi.model.bean.Reply;
import com.mi.model.service.SpecificGoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;


/**
 * @author daiqibin
 * @version 1.4.0
 * @date 2018/8/4
 * @description 具体商品控制器，商品概述，点击购买模块
 */
@Controller
public class SpecificGoodsController {

    @Autowired
    private SpecificGoodsService specificGoodsService;

    /**
     * @param productName
     * @param model
     * @return java.lang.String
     * @description 点击购买界面，生成商品信息（包括颜色List，尺寸List，型号List，进入展示的商品信息）
     */
    @RequestMapping("loadGoods")
    public String loadGoods(String productName, Model model, HttpSession session) {
        if (productName == null) {
            productName = "小米手机";
        }
        int accountId = 0;
        Account account = (Account) session.getAttribute("account");
        if (account != null) {
            accountId = account.getAccountId();
        }
        model.addAttribute("buyGoodsMap", specificGoodsService.getBuyGoods(productName, accountId));
        return "buyGoods";
    }

    /**
     * @param product
     * @return java.util.List<java.lang.String>
     * @description 点击购买界面，AJax生成图片
     */
    @RequestMapping("updateBuyPic")
    public @ResponseBody List<String> updateBuyPic(Product product) {
        return specificGoodsService.selectProductPic(product, "buy_pic%");
    }

    /**
     * @param product
     * @return java.util.List<java.lang.String>
     * @description 点击购买界面，AJax生成商品颜色，商品颜色与型号和尺寸挂钩
     */
    @RequestMapping("updateBuyColor")
    public @ResponseBody List<String> updateBuyColor(Product product, String from) {
        return specificGoodsService.selectProductColor(product, from);
    }

    /**
     * @param productName
     * @param pageSize
     * @return java.util.Map<java.lang.String java.lang.Object>
     * @description 加载更多评论
     */
    @RequestMapping("moreProductComment")
    public @ResponseBody Map<String, Object> getMoreProductComment(String productName, int pageSize) {
        return specificGoodsService.getProductComment(productName,pageSize);
    }

    /**
     * @param productName
     * @param model
     * @return java.lang.String
     * @description 加载商品概述界面
     */
    @RequestMapping("loadProductSpecs")
    public String loadProductSpecs(String productName, Model model){
        model.addAttribute("specProductMap",specificGoodsService.selectDetailInSpecs(productName));
        return "generalSpecs";
    }

    /**
     * @param productName
     * @return java.util.Map<java.lang.String,java.lang.Object>
     * @description Ajax加载商品概述界面参数
     */
    @RequestMapping("loadProductTextSpecs")
    public @ResponseBody Map<String,Object> loadProductTextSpecs(String productName){
        return  specificGoodsService.selectDetailTextInSpecs(productName);
    }

    /**
     * @param reply
     * @param session
     * @return com.mi.model.bean.Reply
     * @description 添加回复
     */
    @RequestMapping("addReply")
    public @ResponseBody Reply addReply(Reply reply, HttpSession session){
        int accountId = 0;
        Account account = (Account) session.getAttribute("account");
        if (account != null) {
            accountId = account.getAccountId();
        }
        specificGoodsService.addReply(reply,accountId);
        reply.setAccount(account);
        return reply;
    }
}
