package com.mi.model.dao;

import com.mi.model.bean.Product;

import java.util.List;

/**
 * Created by Alexander on 2018/7/20 上午11:43
 */
public interface ProductDAO {
    public List<Product> selectAllProducts();
    public List<Product> selectProductsByScId(int scId);
}
