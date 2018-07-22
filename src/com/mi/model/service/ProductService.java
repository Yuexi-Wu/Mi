package com.mi.model.service;

import com.mi.model.bean.Product;
import com.mi.model.dao.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/21 下午10:16
 */
@Service
public class ProductService {

    @Autowired
    private ProductDAO dao;

    public List<Product> selectAllProducts(String productName, String scId, String page, String limit){
        Map<String, Object> map = new HashMap<>();
        if (productName != null && !productName.equals("")){
            map.put("productName", productName);
        }
        if (scId != null && !scId.equals("")){
            map.put("scId", Integer.parseInt(scId));
        }
        if (page != null && !page.equals("") && limit != null && !limit.equals("")){
            map.put("index", ((Integer.parseInt(page) - 1) * Integer.parseInt(limit)));
            map.put("limit", Integer.parseInt(limit));
        }
        return dao.selectAllProducts(map);
    }

    public int selectAllProductsCount(String productName, String scId){
        Map<String, Object> map = new HashMap<>();
        if (productName != null && !productName.equals("")){
            map.put("productName", productName);
        }
        if (scId != null && !scId.equals("")){
            map.put("scId", Integer.parseInt(scId));
        }
        return dao.selectAllProductsCount(map);
    }

    public void deleteProduct(int productId) {
        dao.deleteProduct(productId);
    }
}
