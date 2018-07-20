package com.mi.controller;

import com.mi.model.bean.Product;
import com.mi.model.dao.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Created by Alexander on 2018/7/20 下午2:21
 */

@Controller
public class ProductController {

    @Autowired
    private ProductDAO dao;

    @RequestMapping("getAllProducts")
    public String getAllProducts(Model model){
        List<Product> list = dao.selectAllProducts();
        model.addAttribute("list", list);
        return "test";
    }
}
