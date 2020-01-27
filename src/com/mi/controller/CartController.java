package com.mi.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mi.model.bean.Account;
import com.mi.model.bean.CartItem;
import com.mi.model.bean.Product;
import com.mi.model.bean.Receiver;
import com.mi.model.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/19
 * @description 购物车控制器
 */
@Controller
public class CartController {
    //实例注入
    @Autowired
    private CartService cartService;

    /**
     * @param session
     * @param cartItem
     * @return java.lang.String
     * @description 点击购买界面增加购物车项
     */
    @RequestMapping("addCartItem")
    public String addCartItem(HttpSession session, CartItem cartItem,Model model) {
        Account account = (Account) session.getAttribute("account");
        int accountId = 1;
        if (account != null) {
            accountId = account.getAccountId();
        }
        cartService.addCartItem(cartItem, accountId);
        model.addAttribute("product",cartService.selectProductById(cartItem.getProduct().getProductId()));
        return "buySuccess";
    }

    /**
     * @param session
     * @param productId,productPrice
     * @return java.lang.String
     * @description 其他界面通过Ajax增加购物车项
     */
    @RequestMapping("addCartItemAjax")
    public @ResponseBody String addCartItemAjax(HttpSession session,int productId,double productPrice) {
        Account account = (Account) session.getAttribute("account");
        int accountId = 1;
        if (account != null) {
            accountId = account.getAccountId();
        }
        CartItem cartItem = new CartItem();
        Product product = new Product();
        product.setProductId(productId);
        cartItem.setProduct(product);
        cartItem.setCartitemPrice(productPrice);
        cartService.addCartItem(cartItem, accountId);
        return "true";
    }

    /**
     * @param cartitemId
     * @return java.lang.String
     * @description 删除购物车项
     */
    @RequestMapping("deleteCartItem")
    public String deleteCartItem(int cartitemId) {
        cartService.deleteCartItem(cartitemId);
        return "forward:showCart.action";
    }

    /**
     * @param cartitemId
     * @param quantity
     * @return double
     * @description 修改购物车项数量
     */
    @RequestMapping("editQuantity")
    public
    @ResponseBody
    double editQuantity(int cartitemId, int quantity) {
        return cartService.editQuantity(cartitemId, quantity);
    }

    /**
     * @param session
     * @return org.springframework.web.servlet.ModelAndView
     * @description 收缩指定客户的购物车
     */
    @RequestMapping("showCart")
    public ModelAndView selectCartItemByAccount(HttpSession session) {
        Account account = (Account) session.getAttribute("account");
        int accountId = 0;
        if (account != null) {
            accountId = account.getAccountId();
        }
        List<CartItem> cartItems = cartService.selectCartItemByAccount(accountId);
        ModelAndView mav = new ModelAndView();
        mav.addObject("cart", cartItems);
        mav.addObject("cartSize", cartItems.size());
        mav.setViewName("cart");
        return mav;
    }

    /**
     * @param cartItemIds
     * @param session
     * @return org.springframework.web.servlet.ModelAndView
     * @description 为当前选中的购物车项进入订单生成功能
     */
    @RequestMapping("orderCheck")
    public ModelAndView checkOut(int[] cartItemIds, HttpSession session) {
        Account account = (Account) session.getAttribute("account");
        int accountId = 0;
        if (account != null) {
            accountId = account.getAccountId();
        }
        List<CartItem> cartItems = cartService.getCheckOutCart(cartItemIds);
        List<Receiver> receivers = cartService.getCheckOutReceiver(accountId);
        ModelAndView mav = new ModelAndView();
        session.setAttribute("cart", cartItems);
        mav.addObject("receivers", receivers);
        mav.setViewName("checkOut");
        return mav;
    }

    /**
     * @param product
     * @param session
     * @return int
     * @description 判断当前购买量是否超过限制
     */
    @RequestMapping("canBuyProduct")
    public
    @ResponseBody
    int canBuyProduct(Product product, HttpSession session) {
        Account account = (Account) session.getAttribute("account");
        int accountId = 0;
        if (account != null) {
            accountId = account.getAccountId();
        }
        return cartService.findCanBuyProduct(accountId, product);
    }

}

