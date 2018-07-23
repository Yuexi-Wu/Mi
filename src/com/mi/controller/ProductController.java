package com.mi.controller;

import com.mi.model.bean.Product;
import com.mi.model.dao.ProductDAO;
import com.mi.model.service.ProductService;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/20 下午2:21
 */

@Controller
public class ProductController {

    @Autowired
    private ProductService service;

    @RequestMapping("getAllProducts")
    @ResponseBody
    public Map<String, Object> getAllProducts(String productName, String scId, String page, String limit){
        System.out.println(productName + "---" + scId + "---" + page + "---" + limit);
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", service.selectAllProductsCount(productName, scId));
        List<Product> products = service.selectAllProducts(productName, scId, page, limit);
        result.put("data", products);
        return result;
    }

    @RequestMapping("deleteProduct")
    @ResponseBody
    public String deleteProduct(int productId){
        service.deleteProduct(productId);
        return "success";
    }

    @RequestMapping("addProduct")
    @ResponseBody
    public String addProduct(Product product){
        if (product.getScId() == 0){
            return "sc";
        }else if (product.getProductName() == null || product.getProductName().equals("")){
            return "name";
        }else if (product.getProductPrice() == null || product.getProductPrice().equals("")){
            return "price";
        }else if (product.getProductMax() == null || product.getProductMax().equals("")){
            return "max";
        }else if (product.getProductUrl() == null || product.getProductUrl().equals("")){
            return "url";
        }
        service.addProduct(product);
        return "success";

    }

    @RequestMapping("getProductById")
    public String getProductById(int productId, Model model){
        Product product = service.selectProductById(productId);
        model.addAttribute("product", product);
        return "productEdit";
    }

    @RequestMapping("updateProduct")
    @ResponseBody
    public String updateProduct(Product product){
        if (product.getScId() == 0){
            return "sc";
        }else if (product.getProductName() == null || product.getProductName().equals("")){
            return "name";
        }else if (product.getProductPrice() == null || product.getProductPrice().equals("")){
            return "price";
        }else if (product.getProductMax() == null || product.getProductMax().equals("")){
            return "max";
        }else if (product.getProductUrl() == null || product.getProductUrl().equals("")){
            return "url";
        }
        service.updateProduct(product);
        return "success";

    }
}
